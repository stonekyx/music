extern "C" {
#include <alsa/asoundlib.h>
}
#include <cstring>
#include <cstdlib>
#include <cerrno>

#include "sf.h"
#include "utils.h"
#include "channelmap.h"

#include "player_alsa.h"

/* --------------------------------------------------------- */

// Removing some symbols defined by Cmus.
#define d_print(...)

/* --------------------------------------------------------- */

class PlayerALSA::Private {
    public:
        PlayerALSA &owner;
        Private(PlayerALSA &owner):owner(owner){}
        sample_format_t alsa_sf;
        snd_pcm_t *alsa_handle;
        snd_pcm_format_t alsa_fmt;
        int alsa_can_pause;
        snd_pcm_status_t *status;

        /* bytes (bits * channels / 8) */
        int alsa_frame_size;

        /* configuration */
        char *alsa_dsp_device = NULL;

        static void error_handler(const char *file, int line, const char *function, int err, const char *fmt, ...);
        static int alsa_error_to_op_error(int err);

        int set_hw_params();
};

#if 0
#define debug_ret(func, ret) \
    d_print("%s returned %d %s\n", func, ret, ret < 0 ? snd_strerror(ret) : "")
#else
#define debug_ret(func, ret) do { } while (0)
#endif

/* we don't want error messages to stderr */
void PlayerALSA::Private::error_handler(const char *file, int line, const char *function, int err, const char *fmt, ...)
{
    (void)file;
    (void)line;
    (void)function;
    (void)err;
    (void)fmt;
}

int PlayerALSA::Private::alsa_error_to_op_error(int err)
{
    if (!err)
        return OP_ERROR_SUCCESS;
    err = -err;
    if (err < SND_ERROR_BEGIN) {
        errno = err;
        return -OP_ERROR_ERRNO;
    }
    return -OP_ERROR_INTERNAL;
}

int PlayerALSA::Private::set_hw_params()
{
    snd_pcm_hw_params_t *hwparams = NULL;
    const char *cmd;
    unsigned int rate;
    int rc, dir;
    (void)cmd;

    snd_pcm_hw_params_malloc(&hwparams);

    cmd = "snd_pcm_hw_params_any";
    rc = snd_pcm_hw_params_any(alsa_handle, hwparams);
    if (rc < 0)
        goto error;

    alsa_can_pause = snd_pcm_hw_params_can_pause(hwparams);
    d_print("can pause = %d\n", alsa_can_pause);

    cmd = "snd_pcm_hw_params_set_access";
    rc = snd_pcm_hw_params_set_access(alsa_handle, hwparams,
            SND_PCM_ACCESS_RW_INTERLEAVED);
    if (rc < 0)
        goto error;

    alsa_fmt = snd_pcm_build_linear_format(sf_get_bits(alsa_sf), sf_get_bits(alsa_sf),
            sf_get_signed(alsa_sf) ? 0 : 1,
            sf_get_bigendian(alsa_sf));
    cmd = "snd_pcm_hw_params_set_format";
    rc = snd_pcm_hw_params_set_format(alsa_handle, hwparams, alsa_fmt);
    if (rc < 0)
        goto error;

    cmd = "snd_pcm_hw_params_set_channels";
    rc = snd_pcm_hw_params_set_channels(alsa_handle, hwparams, sf_get_channels(alsa_sf));
    if (rc < 0)
        goto error;

    cmd = "snd_pcm_hw_params_set_rate";
    rate = sf_get_rate(alsa_sf);
    dir = 0;
    rc = snd_pcm_hw_params_set_rate_near(alsa_handle, hwparams, &rate, &dir);
    if (rc < 0)
        goto error;
    d_print("rate=%d\n", rate);

    cmd = "snd_pcm_hw_params";
    rc = snd_pcm_hw_params(alsa_handle, hwparams);
    if (rc < 0)
        goto error;
    goto out;
error:
    d_print("%s: error: %s\n", cmd, snd_strerror(rc));
out:
    snd_pcm_hw_params_free(hwparams);
    return rc;
}

/* ---------------------------------------------------------- */

PlayerALSA::PlayerALSA()
{
    priv = new Private(*this);
}

PlayerALSA::~PlayerALSA()
{
    delete priv;
}

int PlayerALSA::init()
{
    opened=false;
    int rc;

    snd_lib_error_set_handler(priv->error_handler);

    if (priv->alsa_dsp_device == NULL)
        priv->alsa_dsp_device = strdup("default");
    rc = snd_pcm_status_malloc(&priv->status);
    if (rc < 0) {
        free(priv->alsa_dsp_device);
        priv->alsa_dsp_device = NULL;
        errno = ENOMEM;
        return -OP_ERROR_ERRNO;
    }
    return OP_ERROR_SUCCESS;
}

int PlayerALSA::exit()
{
    snd_pcm_status_free(priv->status);
    free(priv->alsa_dsp_device);
    priv->alsa_dsp_device = NULL;
    return OP_ERROR_SUCCESS;
}

int PlayerALSA::open(sample_format_t sf, const channel_position_t *channel_map)
{
    int rc;
    (void)channel_map;

    priv->alsa_sf = sf;
    priv->alsa_frame_size = sf_get_frame_size(priv->alsa_sf);

    rc = snd_pcm_open(&priv->alsa_handle, priv->alsa_dsp_device, SND_PCM_STREAM_PLAYBACK, 0);
    if (rc < 0)
        goto error;

    rc = priv->set_hw_params();
    if (rc)
        goto close_error;

    rc = snd_pcm_prepare(priv->alsa_handle);
    if (rc < 0)
        goto close_error;
    opened=true;
    return OP_ERROR_SUCCESS;
close_error:
    snd_pcm_close(priv->alsa_handle);
error:
    return priv->alsa_error_to_op_error(rc);
}

int PlayerALSA::close()
{
    int rc;

    rc = snd_pcm_drain(priv->alsa_handle);
    debug_ret("snd_pcm_drain", rc);

    rc = snd_pcm_close(priv->alsa_handle);
    debug_ret("snd_pcm_close", rc);
    opened=false;
    return priv->alsa_error_to_op_error(rc);
}

int PlayerALSA::drop()
{
    int rc;

    rc = snd_pcm_drop(priv->alsa_handle);
    debug_ret("snd_pcm_drop", rc);

    rc = snd_pcm_prepare(priv->alsa_handle);
    debug_ret("snd_pcm_prepare", rc);

    /* drop set state to SETUP
     * prepare set state to PREPARED
     *
     * so if old state was PAUSED we can't UNPAUSE (see op_alsa_unpause)
     */
    return priv->alsa_error_to_op_error(rc);
}

int PlayerALSA::write(const char *buffer, int count)
{
    int rc, len;
    int recovered = 0;

    len = count / priv->alsa_frame_size;
again:
    rc = snd_pcm_writei(priv->alsa_handle, buffer, len);
    if (rc < 0) {
        // rc _should_ be either -EBADFD, -EPIPE or -ESTRPIPE
        if (!recovered && (rc == -EINTR || rc == -EPIPE || rc == -ESTRPIPE)) {
            d_print("snd_pcm_writei failed: %s, trying to recover\n",
                    snd_strerror(rc));
            recovered++;
            // this handles -EINTR, -EPIPE and -ESTRPIPE
            // for other errors it just returns the error code
            rc = snd_pcm_recover(priv->alsa_handle, rc, 1);
            if (!rc)
                goto again;
        }

        /* this handles EAGAIN too which is not critical error */
        return priv->alsa_error_to_op_error(rc);
    }

    rc *= priv->alsa_frame_size;
    return rc;
}

int PlayerALSA::buffer_space()
{
    int rc;
    snd_pcm_sframes_t f;

    f = snd_pcm_avail_update(priv->alsa_handle);
    while (f < 0) {
        d_print("snd_pcm_avail_update failed: %s, trying to recover\n",
                snd_strerror(f));
        rc = snd_pcm_recover(priv->alsa_handle, f, 1);
        if (rc < 0) {
            d_print("recovery failed: %s\n", snd_strerror(rc));
            return priv->alsa_error_to_op_error(rc);
        }
        f = snd_pcm_avail_update(priv->alsa_handle);
    }

    return f * priv->alsa_frame_size;
}

int PlayerALSA::pause()
{
    int rc = 0;
    if (priv->alsa_can_pause) {
        snd_pcm_state_t state = snd_pcm_state(priv->alsa_handle);
        if (state == SND_PCM_STATE_PREPARED) {
            // state is PREPARED -> no need to pause
        } else if (state == SND_PCM_STATE_RUNNING) {
            // state is RUNNING - > pause

            // infinite timeout
            rc = snd_pcm_wait(priv->alsa_handle, -1);
            debug_ret("snd_pcm_wait", rc);

            rc = snd_pcm_pause(priv->alsa_handle, 1);
            debug_ret("snd_pcm_pause", rc);
        } else {
            d_print("error: state is not RUNNING or PREPARED\n");
            rc = -OP_ERROR_INTERNAL;
        }
    } else {
        rc = snd_pcm_drop(priv->alsa_handle);
        debug_ret("snd_pcm_drop", rc);
    }
    return priv->alsa_error_to_op_error(rc);
}

int PlayerALSA::unpause()
{
    int rc = 0;
    if (priv->alsa_can_pause) {
        snd_pcm_state_t state = snd_pcm_state(priv->alsa_handle);
        if (state == SND_PCM_STATE_PREPARED) {
            // state is PREPARED -> no need to unpause
        } else if (state == SND_PCM_STATE_PAUSED) {
            // state is PAUSED -> unpause

            // infinite timeout
            rc = snd_pcm_wait(priv->alsa_handle, -1);
            debug_ret("snd_pcm_wait", rc);

            rc = snd_pcm_pause(priv->alsa_handle, 0);
            debug_ret("snd_pcm_pause", rc);
        } else {
            d_print("error: state is not PAUSED nor PREPARED\n");
            rc = -OP_ERROR_INTERNAL;
        }
    } else {
        rc = snd_pcm_prepare(priv->alsa_handle);
        debug_ret("snd_pcm_prepare", rc);
    }
    return priv->alsa_error_to_op_error(rc);
}

int PlayerALSA::set_option(int key, const char *val)
{
    switch (key) {
        case 0:
            free(priv->alsa_dsp_device);
            priv->alsa_dsp_device = strdup(val);
            break;
        default:
            return -OP_ERROR_NOT_OPTION;
    }
    return OP_ERROR_SUCCESS;
}

int PlayerALSA::get_option(int key, char **val)
{
    switch (key) {
        case 0:
            if (priv->alsa_dsp_device)
                *val = strdup(priv->alsa_dsp_device);
            break;
        default:
            return -OP_ERROR_NOT_OPTION;
    }
    return OP_ERROR_SUCCESS;
}

bool PlayerALSA::isopen()
{
    return opened;
}
