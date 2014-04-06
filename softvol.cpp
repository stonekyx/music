#include <climits>

#include "utils.h"
#include "sf.h"
#include "compiler.h"

#include "softvol.h"

#define SOFT_VOL_SCALE 65536

/* coefficients for volumes 0..99, for 100 65536 is used
 * data copied from alsa-lib src/pcm/pcm_softvol.c
 */
static const unsigned short soft_vol_db[100] = {
    0x0000, 0x0110, 0x011c, 0x012f, 0x013d, 0x0152, 0x0161, 0x0179,
    0x018a, 0x01a5, 0x01c1, 0x01d5, 0x01f5, 0x020b, 0x022e, 0x0247,
    0x026e, 0x028a, 0x02b6, 0x02d5, 0x0306, 0x033a, 0x035f, 0x0399,
    0x03c2, 0x0403, 0x0431, 0x0479, 0x04ac, 0x04fd, 0x0553, 0x058f,
    0x05ef, 0x0633, 0x069e, 0x06ea, 0x0761, 0x07b5, 0x083a, 0x0898,
    0x092c, 0x09cb, 0x0a3a, 0x0aeb, 0x0b67, 0x0c2c, 0x0cb6, 0x0d92,
    0x0e2d, 0x0f21, 0x1027, 0x10de, 0x1202, 0x12cf, 0x1414, 0x14f8,
    0x1662, 0x1761, 0x18f5, 0x1a11, 0x1bd3, 0x1db4, 0x1f06, 0x211d,
    0x2297, 0x24ec, 0x2690, 0x292a, 0x2aff, 0x2de5, 0x30fe, 0x332b,
    0x369f, 0x390d, 0x3ce6, 0x3f9b, 0x43e6, 0x46eb, 0x4bb3, 0x4f11,
    0x5466, 0x5a18, 0x5e19, 0x6472, 0x68ea, 0x6ffd, 0x74f8, 0x7cdc,
    0x826a, 0x8b35, 0x9499, 0x9b35, 0xa5ad, 0xad0b, 0xb8b7, 0xc0ee,
    0xcdf1, 0xd71a, 0xe59c, 0xefd3
};

static inline void scale_sample_int16_t(int16_t *buf, int i, int vol, int swap)
{
    int32_t sample = swap ? (int16_t)swap_uint16(buf[i]) : buf[i];

    if (sample < 0) {
        sample = (sample * vol - SOFT_VOL_SCALE / 2) / SOFT_VOL_SCALE;
        if (sample < INT16_MIN)
            sample = INT16_MIN;
    } else {
        sample = (sample * vol + SOFT_VOL_SCALE / 2) / SOFT_VOL_SCALE;
        if (sample > INT16_MAX)
            sample = INT16_MAX;
    }
    buf[i] = swap ? swap_uint16(sample) : sample;
}

static inline int32_t scale_sample_s24le(int32_t s, int vol)
{
    int64_t sample = s;
    if (sample < 0) {
        sample = (sample * vol - SOFT_VOL_SCALE / 2) / SOFT_VOL_SCALE;
        if (sample < -0x800000)
            sample = -0x800000;
    } else {
        sample = (sample * vol + SOFT_VOL_SCALE / 2) / SOFT_VOL_SCALE;
        if (sample > 0x7fffff)
            sample = 0x7fffff;
    }
    return sample;
}

static inline void scale_sample_int32_t(int32_t *buf, int i, int vol, int swap)
{
    int64_t sample = swap ? (int32_t)swap_uint32(buf[i]) : buf[i];

    if (sample < 0) {
        sample = (sample * vol - SOFT_VOL_SCALE / 2) / SOFT_VOL_SCALE;
        if (sample < INT32_MIN)
            sample = INT32_MIN;
    } else {
        sample = (sample * vol + SOFT_VOL_SCALE / 2) / SOFT_VOL_SCALE;
        if (sample > INT32_MAX)
            sample = INT32_MAX;
    }
    buf[i] = swap ? swap_uint32(sample) : sample;
}

static inline int sf_need_swap(sample_format_t sf)
{
#ifdef WORDS_BIGENDIAN
    return !sf_get_bigendian(sf);
#else
    return sf_get_bigendian(sf);
#endif
}

#define SCALE_SAMPLES(TYPE, buffer, count, l, r, swap)				\
{										\
    const int frames = count / sizeof(TYPE) / 2;				\
    TYPE *buf = (TYPE *) buffer;						\
    int i;									\
    /* avoid underflowing -32768 to 32767 when scale is 65536 */		\
    if (l != SOFT_VOL_SCALE && r != SOFT_VOL_SCALE) {			\
        for (i = 0; i < frames; i++) {					\
            scale_sample_##TYPE(buf, i * 2, l, swap);		\
            scale_sample_##TYPE(buf, i * 2 + 1, r, swap);		\
        }								\
    } else if (l != SOFT_VOL_SCALE) {					\
        for (i = 0; i < frames; i++)					\
        scale_sample_##TYPE(buf, i * 2, l, swap);		\
    } else if (r != SOFT_VOL_SCALE) {					\
        for (i = 0; i < frames; i++)					\
        scale_sample_##TYPE(buf, i * 2 + 1, r, swap);		\
    }									\
}

static inline int32_t read_s24le(const char *buf)
{
    const unsigned char *b = (const unsigned char *) buf;
    return b[0] | (b[1] << 8) | (((const signed char *) buf)[2] << 16);
}

static inline void write_s24le(char *buf, int32_t x)
{
    unsigned char *b = (unsigned char *) buf;
    b[0] = x;
    b[1] = x >> 8;
    b[2] = x >> 16;
}

static void scale_samples_s24le(char *buf, unsigned int count, int l, int r)
{
    int frames = count / 3 / 2;
    if (l != SOFT_VOL_SCALE && r != SOFT_VOL_SCALE) {
        while (frames--) {
            write_s24le(buf, scale_sample_s24le(read_s24le(buf), l));
            buf += 3;
            write_s24le(buf, scale_sample_s24le(read_s24le(buf), r));
            buf += 3;
        }
    } else if (l != SOFT_VOL_SCALE) {
        while (frames--) {
            write_s24le(buf, scale_sample_s24le(read_s24le(buf), l));
            buf += 3 * 2;
        }
    } else if (r != SOFT_VOL_SCALE) {
        buf += 3;
        while (frames--) {
            write_s24le(buf, scale_sample_s24le(read_s24le(buf), r));
            buf += 3 * 2;
        }
    }
}

void Softvol::scale_samples(char *buffer, unsigned int count, sample_format_t buffer_sf, double replaygain_scale)
{
    int ch, bits, l, r;

    if (replaygain_scale == 1.0 && soft_vol_l == 100 && soft_vol_r == 100)
        return;

    ch = sf_get_channels(buffer_sf);
    bits = sf_get_bits(buffer_sf);
    if (ch != 2 || (bits != 16 && bits != 24 && bits != 32))
        return;

    l = SOFT_VOL_SCALE;
    r = SOFT_VOL_SCALE;
    if (soft_vol_l != 100)
        l = soft_vol_db[soft_vol_l];
    if (soft_vol_r != 100)
        r = soft_vol_db[soft_vol_r];

    l *= replaygain_scale;
    r *= replaygain_scale;

    switch (bits) {
        case 16:
            SCALE_SAMPLES(int16_t, buffer, count, l, r, sf_need_swap(buffer_sf));
            break;
        case 24:
            if (likely(!sf_get_bigendian(buffer_sf)))
                scale_samples_s24le(buffer, count, l, r);
            break;
        case 32:
            SCALE_SAMPLES(int32_t, buffer, count, l, r, sf_need_swap(buffer_sf));
            break;
    }
}

Softvol::Softvol()
{
    soft_vol_l=100;
    soft_vol_r=100;
}

void Softvol::set_vol(int l, int r)
{
    soft_vol_l = l;
    soft_vol_r = r;
}

int Softvol::get_l() const
{
    return soft_vol_l;
}

int Softvol::get_r() const
{
    return soft_vol_r;
}
