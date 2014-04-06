#ifndef SOFTVOL_H

#define SOFTVOL_H

#include <boost/atomic.hpp>

#include "sf.h"

class Softvol {
    private:
        boost::atomic<int> soft_vol_l;
        boost::atomic<int> soft_vol_r;
    public:
        void scale_samples(char *, unsigned int, sample_format_t, double=1.0);
        Softvol();
        void set_vol(int l, int r);
        int get_l() const;
        int get_r() const;
    protected:
};

#endif
