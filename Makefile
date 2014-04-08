#
# 'make depend' uses makedepend to automatically generate dependencies
#               (dependencies are added to end of Makefile)
# 'make'        build executable file 'mycc'
# 'make clean'  removes all .o and executable files
#

# define the C compiler to use
CC = gcc

# define any compile-time flags
CFLAGS = -Wall -Wextra -g
CXXFLAGS=-g -Wall -Wextra -std=c++11

# define any directories containing header files other than /usr/include
#
#INCLUDES = -I/home/newhall/include  -I../include

# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
#LFLAGS = -L/home/newhall/lib  -L../lib

# define any libraries to link into executable:
#   if I want to link in libraries (libx.so or libx.a) I use the -llibname
#   option, something like (this will link in libmylib.so and libm.so:
BOOST_LIBS=-lboost_thread -lboost_atomic -lboost_serialization -lboost_locale -lboost_system -pthread
FFMPEG_LIBS=-lswresample -lavcodec -lavutil -lavformat
ALSA_LIBS=-lasound
SDL_LIBS=-lSDL2
LIBS=$(BOOST_LIBS) $(FFMPEG_LIBS) $(ALSA_LIBS) $(SDL_LIBS)

# define the C source files
SRC_C = channelmap.c
SRC_CXX =   chunk.cpp \
			decoder.cpp decoder_ffmpeg.cpp decoder_random.cpp \
			pc_boost.cpp pc_boost_pl.cpp pc_boost_status.cpp \
			player.cpp player_alsa.cpp player_sdl.cpp \
			playlist.cpp softvol.cpp trackinfo.cpp \
			pc_boost_main.cpp
SRCS = $(SRC_C) $(SRC_CXX)

# define the C object files
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
#
OBJS = $(SRC_C:.c=.o) $(SRC_CXX:.cpp=.o)

# define the executable file
MAIN = main

#
# The following part of the makefile is generic; it can be used to
# build any executable just by changing the definitions above and by
# deleting dependencies appended to the file from 'make depend'
#

.PHONY: depend clean

all:    $(MAIN)

$(MAIN): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(MAIN) $(OBJS) $(LIBS)

# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file)
# (see the gnu make manual section about automatic variables)
.c.o:
	$(CC) $(CFLAGS) -c $<  -o $@

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<  -o $@

clean:
	$(RM) *.o *~ $(MAIN)

depend: $(SRCS)
	makedepend -I/usr/include/c++/4.8.2 $^

# DO NOT DELETE THIS LINE -- make depend needs it

channelmap.o: channelmap.h /usr/include/string.h /usr/include/features.h
channelmap.o: /usr/include/stdc-predef.h /usr/include/sys/cdefs.h
channelmap.o: /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h
channelmap.o: /usr/include/gnu/stubs-32.h /usr/include/xlocale.h utils.h
channelmap.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
channelmap.o: /usr/include/bits/waitstatus.h /usr/include/endian.h
channelmap.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
channelmap.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
channelmap.o: /usr/include/bits/byteswap-16.h /usr/include/sys/types.h
channelmap.o: /usr/include/time.h /usr/include/sys/select.h
channelmap.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
channelmap.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
channelmap.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
channelmap.o: /usr/include/bits/stdlib-float.h /usr/include/sys/stat.h
channelmap.o: /usr/include/bits/stat.h /usr/include/unistd.h
channelmap.o: /usr/include/bits/posix_opt.h /usr/include/bits/environments.h
channelmap.o: /usr/include/bits/confname.h /usr/include/getopt.h
channelmap.o: /usr/include/stdint.h /usr/include/bits/wchar.h
chunk.o: /usr/include/c++/4.8.2/cstring /usr/include/string.h
chunk.o: /usr/include/features.h /usr/include/stdc-predef.h
chunk.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
chunk.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
chunk.o: /usr/include/xlocale.h chunk.h
decoder.o: decoder.h sf.h channelmap.h /usr/include/string.h
decoder.o: /usr/include/features.h /usr/include/stdc-predef.h
decoder.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
decoder.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
decoder.o: /usr/include/xlocale.h
decoder_ffmpeg.o: /usr/include/c++/4.8.2/cstring /usr/include/string.h
decoder_ffmpeg.o: /usr/include/features.h /usr/include/stdc-predef.h
decoder_ffmpeg.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
decoder_ffmpeg.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
decoder_ffmpeg.o: /usr/include/xlocale.h /usr/include/boost/atomic.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/atomic.hpp
decoder_ffmpeg.o: /usr/include/c++/4.8.2/cstddef
decoder_ffmpeg.o: /usr/include/boost/cstdint.hpp
decoder_ffmpeg.o: /usr/include/boost/config.hpp
decoder_ffmpeg.o: /usr/include/boost/config/user.hpp
decoder_ffmpeg.o: /usr/include/boost/config/select_compiler_config.hpp
decoder_ffmpeg.o: /usr/include/boost/config/compiler/gcc.hpp
decoder_ffmpeg.o: /usr/include/boost/config/select_platform_config.hpp
decoder_ffmpeg.o: /usr/include/boost/config/platform/linux.hpp
decoder_ffmpeg.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
decoder_ffmpeg.o: /usr/include/bits/waitstatus.h /usr/include/endian.h
decoder_ffmpeg.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
decoder_ffmpeg.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
decoder_ffmpeg.o: /usr/include/bits/byteswap-16.h /usr/include/sys/types.h
decoder_ffmpeg.o: /usr/include/time.h /usr/include/sys/select.h
decoder_ffmpeg.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
decoder_ffmpeg.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
decoder_ffmpeg.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
decoder_ffmpeg.o: /usr/include/bits/stdlib-float.h
decoder_ffmpeg.o: /usr/include/boost/config/posix_features.hpp
decoder_ffmpeg.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
decoder_ffmpeg.o: /usr/include/bits/environments.h
decoder_ffmpeg.o: /usr/include/bits/confname.h /usr/include/getopt.h
decoder_ffmpeg.o: /usr/include/boost/config/suffix.hpp /usr/include/stdint.h
decoder_ffmpeg.o: /usr/include/bits/wchar.h
decoder_ffmpeg.o: /usr/include/boost/memory_order.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/config.hpp
decoder_ffmpeg.o: /usr/include/boost/config.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/platform.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/base.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/lockpool.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/link.hpp
decoder_ffmpeg.o: /usr/include/boost/config/auto_link.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/cas64strong.hpp
decoder_ffmpeg.o: /usr/include/boost/atomic/detail/type-classification.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_integral.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/int.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/int_fwd.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/adl.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/intel.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
decoder_ffmpeg.o: /usr/include/boost/detail/workaround.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/cat.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/config/config.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/integral_c_tag.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/static_cast.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/comma_if.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/control/if.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/control/iif.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/logical/bool.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/facilities/empty.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/repeat.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/debug/error.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/tuple/eat.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/inc.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/integral_constant.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/bool.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/bool_fwd.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/integral_c.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/integral_c_fwd.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/yes_no.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
decoder_ffmpeg.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/facilities/overload.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/variadic/size.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/list/adt.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/detail/check.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/logical/compl.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/repetition/for.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/tuple/elem.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/tuple/rem.hpp
decoder_ffmpeg.o: /usr/include/boost/preprocessor/variadic/elem.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_signed.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/remove_cv.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_enum.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/intrinsics.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/config.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/add_reference.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_reference.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/ice.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/ice_or.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/ice_and.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/ice_not.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_arithmetic.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_float.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_convertible.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_array.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_void.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_abstract.hpp
decoder_ffmpeg.o: /usr/include/boost/static_assert.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_class.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_union.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/is_function.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/false_result.hpp
decoder_ffmpeg.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
decoder_ffmpeg.o: /usr/include/libavcodec/avcodec.h /usr/include/errno.h
decoder_ffmpeg.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
decoder_ffmpeg.o: /usr/include/asm/errno.h /usr/include/asm-generic/errno.h
decoder_ffmpeg.o: /usr/include/asm-generic/errno-base.h
decoder_ffmpeg.o: /usr/include/libavutil/samplefmt.h
decoder_ffmpeg.o: /usr/include/libavutil/avutil.h
decoder_ffmpeg.o: /usr/include/libavutil/common.h /usr/include/inttypes.h
decoder_ffmpeg.o: /usr/include/limits.h /usr/include/bits/posix1_lim.h
decoder_ffmpeg.o: /usr/include/bits/local_lim.h /usr/include/linux/limits.h
decoder_ffmpeg.o: /usr/include/bits/posix2_lim.h /usr/include/math.h
decoder_ffmpeg.o: /usr/include/bits/huge_val.h /usr/include/bits/huge_valf.h
decoder_ffmpeg.o: /usr/include/bits/huge_vall.h /usr/include/bits/inf.h
decoder_ffmpeg.o: /usr/include/bits/nan.h /usr/include/bits/mathdef.h
decoder_ffmpeg.o: /usr/include/bits/mathcalls.h /usr/include/stdio.h
decoder_ffmpeg.o: /usr/include/libio.h /usr/include/_G_config.h
decoder_ffmpeg.o: /usr/include/wchar.h /usr/include/bits/stdio_lim.h
decoder_ffmpeg.o: /usr/include/bits/sys_errlist.h
decoder_ffmpeg.o: /usr/include/libavutil/attributes.h
decoder_ffmpeg.o: /usr/include/libavutil/version.h
decoder_ffmpeg.o: /usr/include/libavutil/macros.h
decoder_ffmpeg.o: /usr/include/libavutil/avconfig.h
decoder_ffmpeg.o: /usr/include/libavutil/mem.h /usr/include/libavutil/error.h
decoder_ffmpeg.o: /usr/include/libavutil/mathematics.h
decoder_ffmpeg.o: /usr/include/libavutil/rational.h
decoder_ffmpeg.o: /usr/include/libavutil/intfloat.h
decoder_ffmpeg.o: /usr/include/libavutil/log.h
decoder_ffmpeg.o: /usr/include/libavutil/pixfmt.h
decoder_ffmpeg.o: /usr/include/libavutil/old_pix_fmts.h
decoder_ffmpeg.o: /usr/include/libavutil/attributes.h
decoder_ffmpeg.o: /usr/include/libavutil/avutil.h
decoder_ffmpeg.o: /usr/include/libavutil/buffer.h
decoder_ffmpeg.o: /usr/include/libavutil/cpu.h
decoder_ffmpeg.o: /usr/include/libavutil/channel_layout.h
decoder_ffmpeg.o: /usr/include/libavutil/dict.h
decoder_ffmpeg.o: /usr/include/libavutil/frame.h
decoder_ffmpeg.o: /usr/include/libavutil/buffer.h
decoder_ffmpeg.o: /usr/include/libavutil/dict.h
decoder_ffmpeg.o: /usr/include/libavutil/samplefmt.h
decoder_ffmpeg.o: /usr/include/libavutil/log.h
decoder_ffmpeg.o: /usr/include/libavutil/pixfmt.h
decoder_ffmpeg.o: /usr/include/libavutil/rational.h
decoder_ffmpeg.o: /usr/include/libavformat/avformat.h
decoder_ffmpeg.o: /usr/include/libavformat/avio.h
decoder_ffmpeg.o: /usr/include/libavutil/common.h
decoder_ffmpeg.o: /usr/include/libavformat/version.h
decoder_ffmpeg.o: /usr/include/libavutil/version.h
decoder_ffmpeg.o: /usr/include/libavformat/avio.h
decoder_ffmpeg.o: /usr/include/libswresample/swresample.h
decoder_ffmpeg.o: /usr/include/libswresample/version.h
decoder_ffmpeg.o: /usr/include/libavutil/opt.h
decoder_ffmpeg.o: /usr/include/libavutil/audioconvert.h
decoder_ffmpeg.o: /usr/include/libavutil/channel_layout.h
decoder_ffmpeg.o: /usr/include/libavutil/mathematics.h decoder_ffmpeg.h sf.h
decoder_ffmpeg.o: channelmap.h decoder.h utils.h /usr/include/sys/stat.h
decoder_ffmpeg.o: /usr/include/bits/stat.h
decoder_random.o: decoder_random.h decoder.h sf.h channelmap.h
decoder_random.o: /usr/include/string.h /usr/include/features.h
decoder_random.o: /usr/include/stdc-predef.h /usr/include/sys/cdefs.h
decoder_random.o: /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h
decoder_random.o: /usr/include/gnu/stubs-32.h /usr/include/xlocale.h
decoder_random.o: /usr/include/c++/4.8.2/cstdlib /usr/include/c++/4.8.2/ctime
decoder_random.o: /usr/include/time.h /usr/include/bits/types.h
decoder_random.o: /usr/include/bits/typesizes.h
decoder_random.o: /usr/include/c++/4.8.2/climits /usr/include/limits.h
decoder_random.o: /usr/include/bits/posix1_lim.h
decoder_random.o: /usr/include/bits/local_lim.h /usr/include/linux/limits.h
decoder_random.o: /usr/include/bits/posix2_lim.h
pc_boost.o: /usr/include/boost/thread.hpp
pc_boost.o: /usr/include/boost/thread/thread.hpp
pc_boost.o: /usr/include/boost/thread/thread_only.hpp
pc_boost.o: /usr/include/boost/thread/detail/platform.hpp
pc_boost.o: /usr/include/boost/config.hpp
pc_boost.o: /usr/include/boost/config/requires_threads.hpp
pc_boost.o: /usr/include/boost/thread/detail/thread.hpp
pc_boost.o: /usr/include/boost/thread/detail/config.hpp
pc_boost.o: /usr/include/boost/detail/workaround.hpp
pc_boost.o: /usr/include/boost/config/auto_link.hpp
pc_boost.o: /usr/include/boost/thread/exceptions.hpp
pc_boost.o: /usr/include/c++/4.8.2/string
pc_boost.o: /usr/include/c++/4.8.2/bits/stringfwd.h
pc_boost.o: /usr/include/c++/4.8.2/bits/memoryfwd.h
pc_boost.o: /usr/include/c++/4.8.2/bits/char_traits.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_algobase.h
pc_boost.o: /usr/include/c++/4.8.2/bits/functexcept.h
pc_boost.o: /usr/include/c++/4.8.2/bits/exception_defines.h
pc_boost.o: /usr/include/c++/4.8.2/bits/cpp_type_traits.h
pc_boost.o: /usr/include/c++/4.8.2/ext/type_traits.h
pc_boost.o: /usr/include/c++/4.8.2/ext/numeric_traits.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_pair.h
pc_boost.o: /usr/include/c++/4.8.2/bits/move.h
pc_boost.o: /usr/include/c++/4.8.2/bits/concept_check.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_types.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_funcs.h
pc_boost.o: /usr/include/c++/4.8.2/debug/debug.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_iterator.h
pc_boost.o: /usr/include/c++/4.8.2/bits/postypes.h
pc_boost.o: /usr/include/c++/4.8.2/cwchar
pc_boost.o: /usr/include/c++/4.8.2/bits/allocator.h
pc_boost.o: /usr/include/c++/4.8.2/bits/localefwd.h
pc_boost.o: /usr/include/c++/4.8.2/iosfwd /usr/include/c++/4.8.2/cctype
pc_boost.o: /usr/include/ctype.h /usr/include/features.h
pc_boost.o: /usr/include/stdc-predef.h /usr/include/sys/cdefs.h
pc_boost.o: /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h
pc_boost.o: /usr/include/gnu/stubs-32.h /usr/include/bits/types.h
pc_boost.o: /usr/include/bits/typesizes.h /usr/include/endian.h
pc_boost.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
pc_boost.o: /usr/include/bits/byteswap-16.h /usr/include/xlocale.h
pc_boost.o: /usr/include/c++/4.8.2/bits/ostream_insert.h
pc_boost.o: /usr/include/c++/4.8.2/bits/cxxabi_forced.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_function.h
pc_boost.o: /usr/include/c++/4.8.2/backward/binders.h
pc_boost.o: /usr/include/c++/4.8.2/bits/range_access.h
pc_boost.o: /usr/include/c++/4.8.2/bits/basic_string.h
pc_boost.o: /usr/include/c++/4.8.2/ext/atomicity.h
pc_boost.o: /usr/include/c++/4.8.2/bits/basic_string.tcc
pc_boost.o: /usr/include/c++/4.8.2/stdexcept /usr/include/c++/4.8.2/exception
pc_boost.o: /usr/include/c++/4.8.2/bits/atomic_lockfree_defines.h
pc_boost.o: /usr/include/boost/system/system_error.hpp
pc_boost.o: /usr/include/c++/4.8.2/cassert /usr/include/assert.h
pc_boost.o: /usr/include/boost/system/error_code.hpp
pc_boost.o: /usr/include/boost/system/config.hpp
pc_boost.o: /usr/include/boost/system/api_config.hpp
pc_boost.o: /usr/include/boost/cstdint.hpp /usr/include/boost/config.hpp
pc_boost.o: /usr/include/boost/config/user.hpp
pc_boost.o: /usr/include/boost/config/select_compiler_config.hpp
pc_boost.o: /usr/include/boost/config/compiler/gcc.hpp
pc_boost.o: /usr/include/boost/config/select_platform_config.hpp
pc_boost.o: /usr/include/boost/config/platform/linux.hpp
pc_boost.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
pc_boost.o: /usr/include/bits/waitstatus.h /usr/include/sys/types.h
pc_boost.o: /usr/include/time.h /usr/include/sys/select.h
pc_boost.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
pc_boost.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
pc_boost.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
pc_boost.o: /usr/include/bits/stdlib-float.h
pc_boost.o: /usr/include/boost/config/posix_features.hpp
pc_boost.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
pc_boost.o: /usr/include/bits/environments.h /usr/include/bits/confname.h
pc_boost.o: /usr/include/getopt.h /usr/include/boost/config/suffix.hpp
pc_boost.o: /usr/include/stdint.h /usr/include/bits/wchar.h
pc_boost.o: /usr/include/boost/assert.hpp /usr/include/c++/4.8.2/cstdlib
pc_boost.o: /usr/include/c++/4.8.2/iostream /usr/include/c++/4.8.2/ostream
pc_boost.o: /usr/include/c++/4.8.2/ios /usr/include/c++/4.8.2/bits/ios_base.h
pc_boost.o: /usr/include/c++/4.8.2/bits/locale_classes.h
pc_boost.o: /usr/include/c++/4.8.2/bits/locale_classes.tcc
pc_boost.o: /usr/include/c++/4.8.2/streambuf
pc_boost.o: /usr/include/c++/4.8.2/bits/streambuf.tcc
pc_boost.o: /usr/include/c++/4.8.2/bits/basic_ios.h
pc_boost.o: /usr/include/c++/4.8.2/bits/locale_facets.h
pc_boost.o: /usr/include/c++/4.8.2/cwctype
pc_boost.o: /usr/include/c++/4.8.2/bits/streambuf_iterator.h
pc_boost.o: /usr/include/c++/4.8.2/bits/locale_facets.tcc
pc_boost.o: /usr/include/c++/4.8.2/bits/basic_ios.tcc
pc_boost.o: /usr/include/c++/4.8.2/bits/ostream.tcc
pc_boost.o: /usr/include/c++/4.8.2/istream
pc_boost.o: /usr/include/c++/4.8.2/bits/istream.tcc
pc_boost.o: /usr/include/boost/current_function.hpp
pc_boost.o: /usr/include/boost/operators.hpp /usr/include/boost/iterator.hpp
pc_boost.o: /usr/include/c++/4.8.2/iterator
pc_boost.o: /usr/include/c++/4.8.2/bits/stream_iterator.h
pc_boost.o: /usr/include/c++/4.8.2/cstddef /usr/include/boost/noncopyable.hpp
pc_boost.o: /usr/include/boost/utility/enable_if.hpp
pc_boost.o: /usr/include/c++/4.8.2/functional /usr/include/boost/cerrno.hpp
pc_boost.o: /usr/include/c++/4.8.2/cerrno /usr/include/errno.h
pc_boost.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
pc_boost.o: /usr/include/asm/errno.h /usr/include/asm-generic/errno.h
pc_boost.o: /usr/include/asm-generic/errno-base.h
pc_boost.o: /usr/include/boost/config/abi_prefix.hpp
pc_boost.o: /usr/include/boost/config/abi_suffix.hpp
pc_boost.o: /usr/include/boost/thread/detail/move.hpp
pc_boost.o: /usr/include/boost/type_traits/is_convertible.hpp
pc_boost.o: /usr/include/boost/type_traits/intrinsics.hpp
pc_boost.o: /usr/include/boost/type_traits/config.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
pc_boost.o: /usr/include/boost/type_traits/is_array.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
pc_boost.o: /usr/include/boost/mpl/int.hpp /usr/include/boost/mpl/int_fwd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/adl.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/intel.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
pc_boost.o: /usr/include/boost/preprocessor/cat.hpp
pc_boost.o: /usr/include/boost/preprocessor/config/config.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
pc_boost.o: /usr/include/boost/mpl/integral_c_tag.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/static_cast.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
pc_boost.o: /usr/include/boost/preprocessor/comma_if.hpp
pc_boost.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
pc_boost.o: /usr/include/boost/preprocessor/control/if.hpp
pc_boost.o: /usr/include/boost/preprocessor/control/iif.hpp
pc_boost.o: /usr/include/boost/preprocessor/logical/bool.hpp
pc_boost.o: /usr/include/boost/preprocessor/facilities/empty.hpp
pc_boost.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
pc_boost.o: /usr/include/boost/preprocessor/repeat.hpp
pc_boost.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
pc_boost.o: /usr/include/boost/preprocessor/debug/error.hpp
pc_boost.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
pc_boost.o: /usr/include/boost/preprocessor/tuple/eat.hpp
pc_boost.o: /usr/include/boost/preprocessor/inc.hpp
pc_boost.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
pc_boost.o: /usr/include/boost/type_traits/integral_constant.hpp
pc_boost.o: /usr/include/boost/mpl/bool.hpp
pc_boost.o: /usr/include/boost/mpl/bool_fwd.hpp
pc_boost.o: /usr/include/boost/mpl/integral_c.hpp
pc_boost.o: /usr/include/boost/mpl/integral_c_fwd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/yes_no.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
pc_boost.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
pc_boost.o: /usr/include/boost/preprocessor/facilities/overload.hpp
pc_boost.o: /usr/include/boost/preprocessor/variadic/size.hpp
pc_boost.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
pc_boost.o: /usr/include/boost/preprocessor/list/adt.hpp
pc_boost.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
pc_boost.o: /usr/include/boost/preprocessor/detail/check.hpp
pc_boost.o: /usr/include/boost/preprocessor/logical/compl.hpp
pc_boost.o: /usr/include/boost/preprocessor/repetition/for.hpp
pc_boost.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
pc_boost.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
pc_boost.o: /usr/include/boost/preprocessor/tuple/elem.hpp
pc_boost.o: /usr/include/boost/preprocessor/tuple/rem.hpp
pc_boost.o: /usr/include/boost/preprocessor/variadic/elem.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
pc_boost.o: /usr/include/boost/type_traits/ice.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/ice_or.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/ice_and.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/ice_not.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
pc_boost.o: /usr/include/boost/type_traits/is_arithmetic.hpp
pc_boost.o: /usr/include/boost/type_traits/is_integral.hpp
pc_boost.o: /usr/include/boost/type_traits/is_float.hpp
pc_boost.o: /usr/include/boost/type_traits/is_void.hpp
pc_boost.o: /usr/include/boost/type_traits/is_abstract.hpp
pc_boost.o: /usr/include/boost/static_assert.hpp
pc_boost.o: /usr/include/boost/type_traits/is_class.hpp
pc_boost.o: /usr/include/boost/type_traits/is_union.hpp
pc_boost.o: /usr/include/boost/type_traits/remove_cv.hpp
pc_boost.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
pc_boost.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
pc_boost.o: /usr/include/boost/type_traits/add_reference.hpp
pc_boost.o: /usr/include/boost/type_traits/is_reference.hpp
pc_boost.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
pc_boost.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
pc_boost.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
pc_boost.o: /usr/include/boost/type_traits/is_function.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/false_result.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
pc_boost.o: /usr/include/boost/type_traits/remove_reference.hpp
pc_boost.o: /usr/include/boost/type_traits/decay.hpp
pc_boost.o: /usr/include/boost/type_traits/remove_bounds.hpp
pc_boost.o: /usr/include/boost/type_traits/add_pointer.hpp
pc_boost.o: /usr/include/boost/mpl/eval_if.hpp /usr/include/boost/mpl/if.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/value_wknd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/integral.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/eti.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/na_spec.hpp
pc_boost.o: /usr/include/boost/mpl/lambda_fwd.hpp
pc_boost.o: /usr/include/boost/mpl/void_fwd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/na.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/arity.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/dtp.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/preprocessor/def_params_tail.hpp
pc_boost.o: /usr/include/boost/mpl/limits/arity.hpp
pc_boost.o: /usr/include/boost/preprocessor/logical/and.hpp
pc_boost.o: /usr/include/boost/preprocessor/logical/bitand.hpp
pc_boost.o: /usr/include/boost/preprocessor/identity.hpp
pc_boost.o: /usr/include/boost/preprocessor/facilities/identity.hpp
pc_boost.o: /usr/include/boost/preprocessor/empty.hpp
pc_boost.o: /usr/include/boost/preprocessor/arithmetic/add.hpp
pc_boost.o: /usr/include/boost/preprocessor/arithmetic/dec.hpp
pc_boost.o: /usr/include/boost/preprocessor/control/while.hpp
pc_boost.o: /usr/include/boost/preprocessor/list/fold_left.hpp
pc_boost.o: /usr/include/boost/preprocessor/list/detail/fold_left.hpp
pc_boost.o: /usr/include/boost/preprocessor/list/fold_right.hpp
pc_boost.o: /usr/include/boost/preprocessor/list/detail/fold_right.hpp
pc_boost.o: /usr/include/boost/preprocessor/list/reverse.hpp
pc_boost.o: /usr/include/boost/preprocessor/control/detail/while.hpp
pc_boost.o: /usr/include/boost/preprocessor/arithmetic/sub.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/lambda_arity_param.hpp
pc_boost.o: /usr/include/boost/mpl/identity.hpp
pc_boost.o: /usr/include/boost/thread/detail/delete.hpp
pc_boost.o: /usr/include/boost/move/utility.hpp
pc_boost.o: /usr/include/boost/move/detail/config_begin.hpp
pc_boost.o: /usr/include/boost/move/core.hpp
pc_boost.o: /usr/include/boost/move/detail/meta_utils.hpp
pc_boost.o: /usr/include/boost/move/detail/config_end.hpp
pc_boost.o: /usr/include/boost/move/traits.hpp
pc_boost.o: /usr/include/boost/type_traits/has_trivial_destructor.hpp
pc_boost.o: /usr/include/boost/type_traits/is_pod.hpp
pc_boost.o: /usr/include/boost/type_traits/is_scalar.hpp
pc_boost.o: /usr/include/boost/type_traits/is_enum.hpp
pc_boost.o: /usr/include/boost/type_traits/is_pointer.hpp
pc_boost.o: /usr/include/boost/type_traits/is_member_pointer.hpp
pc_boost.o: /usr/include/boost/type_traits/is_member_function_pointer.hpp
pc_boost.o: /usr/include/boost/type_traits/detail/is_mem_fun_pointer_impl.hpp
pc_boost.o: /usr/include/boost/type_traits/is_nothrow_move_constructible.hpp
pc_boost.o: /usr/include/boost/type_traits/has_trivial_move_constructor.hpp
pc_boost.o: /usr/include/boost/type_traits/is_volatile.hpp
pc_boost.o: /usr/include/boost/type_traits/has_nothrow_copy.hpp
pc_boost.o: /usr/include/boost/type_traits/has_trivial_copy.hpp
pc_boost.o: /usr/include/boost/utility/declval.hpp
pc_boost.o: /usr/include/boost/type_traits/is_nothrow_move_assignable.hpp
pc_boost.o: /usr/include/boost/type_traits/has_trivial_move_assign.hpp
pc_boost.o: /usr/include/boost/type_traits/is_const.hpp
pc_boost.o: /usr/include/boost/type_traits/has_nothrow_assign.hpp
pc_boost.o: /usr/include/boost/type_traits/has_trivial_assign.hpp
pc_boost.o: /usr/include/boost/thread/mutex.hpp
pc_boost.o: /usr/include/boost/thread/lockable_traits.hpp
pc_boost.o: /usr/include/boost/thread/xtime.hpp
pc_boost.o: /usr/include/boost/thread/thread_time.hpp
pc_boost.o: /usr/include/boost/date_time/time_clock.hpp
pc_boost.o: /usr/include/boost/date_time/c_time.hpp
pc_boost.o: /usr/include/c++/4.8.2/ctime
pc_boost.o: /usr/include/boost/throw_exception.hpp
pc_boost.o: /usr/include/boost/exception/detail/attribute_noreturn.hpp
pc_boost.o: /usr/include/boost/date_time/compiler_config.hpp
pc_boost.o: /usr/include/boost/date_time/locale_config.hpp
pc_boost.o: /usr/include/sys/time.h /usr/include/boost/shared_ptr.hpp
pc_boost.o: /usr/include/boost/smart_ptr/shared_ptr.hpp
pc_boost.o: /usr/include/boost/config/no_tr1/memory.hpp
pc_boost.o: /usr/include/c++/4.8.2/memory
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_construct.h
pc_boost.o: /usr/include/c++/4.8.2/new
pc_boost.o: /usr/include/c++/4.8.2/ext/alloc_traits.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_uninitialized.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_tempbuf.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_raw_storage_iter.h
pc_boost.o: /usr/include/c++/4.8.2/backward/auto_ptr.h
pc_boost.o: /usr/include/boost/checked_delete.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/shared_count.hpp
pc_boost.o: /usr/include/boost/smart_ptr/bad_weak_ptr.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/sp_counted_base.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/sp_has_sync.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/sp_counted_base_gcc_x86.hpp
pc_boost.o: /usr/include/boost/detail/sp_typeinfo.hpp
pc_boost.o: /usr/include/c++/4.8.2/typeinfo
pc_boost.o: /usr/include/boost/smart_ptr/detail/sp_counted_impl.hpp
pc_boost.o: /usr/include/boost/utility/addressof.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/sp_convertible.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/sp_nullptr_t.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/spinlock_pool.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/spinlock.hpp
pc_boost.o: /usr/include/boost/smart_ptr/detail/spinlock_pt.hpp
pc_boost.o: /usr/include/pthread.h /usr/include/sched.h
pc_boost.o: /usr/include/bits/sched.h /usr/include/bits/setjmp.h
pc_boost.o: /usr/include/boost/memory_order.hpp
pc_boost.o: /usr/include/c++/4.8.2/algorithm /usr/include/c++/4.8.2/utility
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_relops.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_algo.h
pc_boost.o: /usr/include/c++/4.8.2/bits/algorithmfwd.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_heap.h
pc_boost.o: /usr/include/boost/smart_ptr/detail/operator_bool.hpp
pc_boost.o: /usr/include/boost/date_time/microsec_time_clock.hpp
pc_boost.o: /usr/include/boost/date_time/filetime_functions.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/posix_time_types.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/ptime.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/posix_time_system.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/posix_time_config.hpp
pc_boost.o: /usr/include/boost/limits.hpp /usr/include/c++/4.8.2/limits
pc_boost.o: /usr/include/boost/config/no_tr1/cmath.hpp
pc_boost.o: /usr/include/c++/4.8.2/cmath /usr/include/math.h
pc_boost.o: /usr/include/bits/huge_val.h /usr/include/bits/huge_valf.h
pc_boost.o: /usr/include/bits/huge_vall.h /usr/include/bits/inf.h
pc_boost.o: /usr/include/bits/nan.h /usr/include/bits/mathdef.h
pc_boost.o: /usr/include/bits/mathcalls.h
pc_boost.o: /usr/include/boost/date_time/time_duration.hpp
pc_boost.o: /usr/include/boost/date_time/time_defs.hpp
pc_boost.o: /usr/include/boost/date_time/special_defs.hpp
pc_boost.o: /usr/include/boost/date_time/time_resolution_traits.hpp
pc_boost.o: /usr/include/boost/date_time/int_adapter.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/gregorian_types.hpp
pc_boost.o: /usr/include/boost/date_time/date.hpp
pc_boost.o: /usr/include/boost/date_time/year_month_day.hpp
pc_boost.o: /usr/include/boost/date_time/period.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_calendar.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_weekday.hpp
pc_boost.o: /usr/include/boost/date_time/constrained_value.hpp
pc_boost.o: /usr/include/boost/type_traits/is_base_of.hpp
pc_boost.o: /usr/include/boost/type_traits/is_base_and_derived.hpp
pc_boost.o: /usr/include/boost/type_traits/is_same.hpp
pc_boost.o: /usr/include/boost/date_time/date_defs.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_day_of_year.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian_calendar.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian_calendar.ipp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_ymd.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_day.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_year.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_month.hpp
pc_boost.o: /usr/include/c++/4.8.2/map /usr/include/c++/4.8.2/bits/stl_tree.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_map.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_multimap.h
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_duration.hpp
pc_boost.o: /usr/include/boost/date_time/date_duration.hpp
pc_boost.o: /usr/include/boost/date_time/date_duration_types.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_duration_types.hpp
pc_boost.o: /usr/include/boost/date_time/gregorian/greg_date.hpp
pc_boost.o: /usr/include/boost/date_time/adjust_functors.hpp
pc_boost.o: /usr/include/boost/date_time/wrapping_int.hpp
pc_boost.o: /usr/include/boost/date_time/date_generators.hpp
pc_boost.o: /usr/include/c++/4.8.2/sstream
pc_boost.o: /usr/include/c++/4.8.2/bits/sstream.tcc
pc_boost.o: /usr/include/boost/date_time/date_clock_device.hpp
pc_boost.o: /usr/include/boost/date_time/date_iterator.hpp
pc_boost.o: /usr/include/boost/date_time/time_system_split.hpp
pc_boost.o: /usr/include/boost/date_time/time_system_counted.hpp
pc_boost.o: /usr/include/boost/date_time/time.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/date_duration_operators.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/posix_time_duration.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/time_period.hpp
pc_boost.o: /usr/include/boost/date_time/time_iterator.hpp
pc_boost.o: /usr/include/boost/date_time/dst_rules.hpp
pc_boost.o: /usr/include/boost/date_time/posix_time/conversion.hpp
pc_boost.o: /usr/include/c++/4.8.2/cstring /usr/include/string.h
pc_boost.o: /usr/include/boost/date_time/gregorian/conversion.hpp
pc_boost.o: /usr/include/boost/thread/detail/thread_heap_alloc.hpp
pc_boost.o: /usr/include/boost/thread/detail/make_tuple_indices.hpp
pc_boost.o: /usr/include/boost/thread/detail/invoke.hpp
pc_boost.o: /usr/include/boost/thread/detail/is_convertible.hpp
pc_boost.o: /usr/include/c++/4.8.2/list
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_list.h
pc_boost.o: /usr/include/c++/4.8.2/bits/list.tcc /usr/include/boost/ref.hpp
pc_boost.o: /usr/include/boost/bind.hpp /usr/include/boost/bind/bind.hpp
pc_boost.o: /usr/include/boost/mem_fn.hpp /usr/include/boost/bind/mem_fn.hpp
pc_boost.o: /usr/include/boost/get_pointer.hpp
pc_boost.o: /usr/include/boost/bind/mem_fn_template.hpp
pc_boost.o: /usr/include/boost/bind/mem_fn_cc.hpp /usr/include/boost/type.hpp
pc_boost.o: /usr/include/boost/is_placeholder.hpp
pc_boost.o: /usr/include/boost/bind/arg.hpp /usr/include/boost/visit_each.hpp
pc_boost.o: /usr/include/boost/bind/storage.hpp
pc_boost.o: /usr/include/boost/bind/bind_template.hpp
pc_boost.o: /usr/include/boost/bind/bind_cc.hpp
pc_boost.o: /usr/include/boost/bind/bind_mf_cc.hpp
pc_boost.o: /usr/include/boost/bind/bind_mf2_cc.hpp
pc_boost.o: /usr/include/boost/bind/placeholders.hpp
pc_boost.o: /usr/include/boost/io/ios_state.hpp /usr/include/boost/io_fwd.hpp
pc_boost.o: /usr/include/c++/4.8.2/locale
pc_boost.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.h
pc_boost.o: /usr/include/c++/4.8.2/bits/codecvt.h
pc_boost.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.tcc
pc_boost.o: /usr/include/boost/functional/hash.hpp
pc_boost.o: /usr/include/boost/functional/hash/hash.hpp
pc_boost.o: /usr/include/boost/functional/hash/hash_fwd.hpp
pc_boost.o: /usr/include/boost/functional/hash/detail/hash_float.hpp
pc_boost.o: /usr/include/boost/functional/hash/detail/float_functions.hpp
pc_boost.o: /usr/include/boost/functional/hash/detail/limits.hpp
pc_boost.o: /usr/include/boost/integer/static_log2.hpp
pc_boost.o: /usr/include/boost/integer_fwd.hpp /usr/include/c++/4.8.2/climits
pc_boost.o: /usr/include/limits.h /usr/include/bits/posix1_lim.h
pc_boost.o: /usr/include/bits/local_lim.h /usr/include/linux/limits.h
pc_boost.o: /usr/include/bits/posix2_lim.h /usr/include/c++/4.8.2/typeindex
pc_boost.o: /usr/include/c++/4.8.2/bits/c++0x_warning.h
pc_boost.o: /usr/include/boost/functional/hash/extensions.hpp
pc_boost.o: /usr/include/boost/detail/container_fwd.hpp
pc_boost.o: /usr/include/c++/4.8.2/deque
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_deque.h
pc_boost.o: /usr/include/c++/4.8.2/bits/deque.tcc
pc_boost.o: /usr/include/c++/4.8.2/vector
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_vector.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_bvector.h
pc_boost.o: /usr/include/c++/4.8.2/bits/vector.tcc /usr/include/c++/4.8.2/set
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_set.h
pc_boost.o: /usr/include/c++/4.8.2/bits/stl_multiset.h
pc_boost.o: /usr/include/c++/4.8.2/bitset /usr/include/c++/4.8.2/complex
pc_boost.o: /usr/include/boost/preprocessor/repetition/repeat_from_to.hpp
pc_boost.o: /usr/include/boost/preprocessor/repetition/enum_params.hpp
pc_boost.o: /usr/include/c++/4.8.2/array /usr/include/c++/4.8.2/tuple
pc_boost.o: /usr/include/boost/chrono/system_clocks.hpp
pc_boost.o: /usr/include/boost/chrono/config.hpp
pc_boost.o: /usr/include/boost/chrono/duration.hpp
pc_boost.o: /usr/include/boost/chrono/detail/static_assert.hpp
pc_boost.o: /usr/include/boost/mpl/logical.hpp /usr/include/boost/mpl/or.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/use_preprocessed.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/nested_type_wknd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/compiler.hpp
pc_boost.o: /usr/include/boost/preprocessor/stringize.hpp
pc_boost.o: /usr/include/boost/mpl/and.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost.o: /usr/include/boost/mpl/not.hpp /usr/include/boost/ratio/ratio.hpp
pc_boost.o: /usr/include/boost/ratio/config.hpp
pc_boost.o: /usr/include/boost/ratio/detail/mpl/abs.hpp
pc_boost.o: /usr/include/boost/ratio/detail/mpl/sign.hpp
pc_boost.o: /usr/include/boost/ratio/detail/mpl/gcd.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/largest_int.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/dependent_nttp.hpp
pc_boost.o: /usr/include/boost/ratio/detail/mpl/lcm.hpp
pc_boost.o: /usr/include/boost/integer_traits.hpp /usr/include/wchar.h
pc_boost.o: /usr/include/boost/ratio/ratio_fwd.hpp
pc_boost.o: /usr/include/boost/ratio/detail/overflow_helpers.hpp
pc_boost.o: /usr/include/boost/type_traits/common_type.hpp
pc_boost.o: /usr/include/boost/typeof/typeof.hpp
pc_boost.o: /usr/include/boost/typeof/message.hpp
pc_boost.o: /usr/include/boost/typeof/native.hpp
pc_boost.o: /usr/include/boost/type_traits/is_floating_point.hpp
pc_boost.o: /usr/include/boost/type_traits/is_unsigned.hpp
pc_boost.o: /usr/include/boost/chrono/detail/is_evenly_divisible_by.hpp
pc_boost.o: /usr/include/boost/chrono/time_point.hpp
pc_boost.o: /usr/include/boost/chrono/detail/system.hpp
pc_boost.o: /usr/include/boost/version.hpp
pc_boost.o: /usr/include/boost/chrono/clock_string.hpp
pc_boost.o: /usr/include/boost/chrono/ceil.hpp
pc_boost.o: /usr/include/boost/thread/detail/thread_interruption.hpp
pc_boost.o: /usr/include/boost/thread/v2/thread.hpp
pc_boost.o: /usr/include/boost/thread/condition_variable.hpp
pc_boost.o: /usr/include/boost/thread/lock_types.hpp
pc_boost.o: /usr/include/boost/thread/lock_options.hpp
pc_boost.o: /usr/include/boost/thread/detail/thread_group.hpp
pc_boost.o: /usr/include/boost/thread/shared_mutex.hpp
pc_boost.o: /usr/include/boost/thread/lock_guard.hpp
pc_boost.o: /usr/include/boost/thread/detail/lockable_wrapper.hpp
pc_boost.o: /usr/include/c++/4.8.2/initializer_list
pc_boost.o: /usr/include/boost/thread/once.hpp
pc_boost.o: /usr/include/boost/thread/recursive_mutex.hpp
pc_boost.o: /usr/include/boost/thread/tss.hpp
pc_boost.o: /usr/include/boost/thread/locks.hpp
pc_boost.o: /usr/include/boost/thread/lock_algorithms.hpp
pc_boost.o: /usr/include/boost/thread/barrier.hpp
pc_boost.o: /usr/include/boost/utility/result_of.hpp
pc_boost.o: /usr/include/boost/preprocessor/iteration/iterate.hpp
pc_boost.o: /usr/include/boost/preprocessor/array/elem.hpp
pc_boost.o: /usr/include/boost/preprocessor/array/data.hpp
pc_boost.o: /usr/include/boost/preprocessor/array/size.hpp
pc_boost.o: /usr/include/boost/preprocessor/slot/slot.hpp
pc_boost.o: /usr/include/boost/preprocessor/slot/detail/def.hpp
pc_boost.o: /usr/include/boost/preprocessor/repetition/enum_trailing_params.hpp
pc_boost.o: /usr/include/boost/preprocessor/repetition/enum_binary_params.hpp
pc_boost.o: /usr/include/boost/preprocessor/repetition/enum_shifted_params.hpp
pc_boost.o: /usr/include/boost/preprocessor/facilities/intercept.hpp
pc_boost.o: /usr/include/boost/mpl/has_xxx.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/type_wrapper.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/has_xxx.hpp
pc_boost.o: /usr/include/boost/mpl/aux_/config/msvc_typename.hpp
pc_boost.o: /usr/include/boost/thread/future.hpp
pc_boost.o: /usr/include/boost/atomic.hpp
pc_boost.o: /usr/include/boost/atomic/atomic.hpp
pc_boost.o: /usr/include/boost/atomic/detail/config.hpp
pc_boost.o: /usr/include/boost/atomic/detail/platform.hpp
pc_boost.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
pc_boost.o: /usr/include/boost/atomic/detail/base.hpp
pc_boost.o: /usr/include/boost/atomic/detail/lockpool.hpp
pc_boost.o: /usr/include/boost/atomic/detail/link.hpp
pc_boost.o: /usr/include/boost/atomic/detail/cas64strong.hpp
pc_boost.o: /usr/include/boost/atomic/detail/type-classification.hpp
pc_boost.o: /usr/include/boost/type_traits/is_signed.hpp decoder_ffmpeg.h
pc_boost.o: sf.h channelmap.h decoder.h player_alsa.h player.h player_sdl.h
pc_boost.o: utils.h /usr/include/sys/stat.h /usr/include/bits/stat.h
pc_boost.o: pc_boost.h pc_boost_monitor.h chunk.h playlist.h trackinfo.h
pc_boost.o: softvol.h
pc_boost_pl.o: pc_boost.h pc_boost_monitor.h /usr/include/boost/thread.hpp
pc_boost_pl.o: /usr/include/boost/thread/thread.hpp
pc_boost_pl.o: /usr/include/boost/thread/thread_only.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/platform.hpp
pc_boost_pl.o: /usr/include/boost/config.hpp
pc_boost_pl.o: /usr/include/boost/config/requires_threads.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/thread.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/config.hpp
pc_boost_pl.o: /usr/include/boost/detail/workaround.hpp
pc_boost_pl.o: /usr/include/boost/config/auto_link.hpp
pc_boost_pl.o: /usr/include/boost/thread/exceptions.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/string
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stringfwd.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/memoryfwd.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/char_traits.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_algobase.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/functexcept.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/exception_defines.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/cpp_type_traits.h
pc_boost_pl.o: /usr/include/c++/4.8.2/ext/type_traits.h
pc_boost_pl.o: /usr/include/c++/4.8.2/ext/numeric_traits.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_pair.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/move.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/concept_check.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_types.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_funcs.h
pc_boost_pl.o: /usr/include/c++/4.8.2/debug/debug.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_iterator.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/postypes.h
pc_boost_pl.o: /usr/include/c++/4.8.2/cwchar
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/allocator.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/localefwd.h
pc_boost_pl.o: /usr/include/c++/4.8.2/iosfwd /usr/include/c++/4.8.2/cctype
pc_boost_pl.o: /usr/include/ctype.h /usr/include/features.h
pc_boost_pl.o: /usr/include/stdc-predef.h /usr/include/sys/cdefs.h
pc_boost_pl.o: /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h
pc_boost_pl.o: /usr/include/gnu/stubs-32.h /usr/include/bits/types.h
pc_boost_pl.o: /usr/include/bits/typesizes.h /usr/include/endian.h
pc_boost_pl.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
pc_boost_pl.o: /usr/include/bits/byteswap-16.h /usr/include/xlocale.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/ostream_insert.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/cxxabi_forced.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_function.h
pc_boost_pl.o: /usr/include/c++/4.8.2/backward/binders.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/range_access.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/basic_string.h
pc_boost_pl.o: /usr/include/c++/4.8.2/ext/atomicity.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/basic_string.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/stdexcept
pc_boost_pl.o: /usr/include/c++/4.8.2/exception
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/atomic_lockfree_defines.h
pc_boost_pl.o: /usr/include/boost/system/system_error.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/cassert /usr/include/assert.h
pc_boost_pl.o: /usr/include/boost/system/error_code.hpp
pc_boost_pl.o: /usr/include/boost/system/config.hpp
pc_boost_pl.o: /usr/include/boost/system/api_config.hpp
pc_boost_pl.o: /usr/include/boost/cstdint.hpp /usr/include/boost/config.hpp
pc_boost_pl.o: /usr/include/boost/config/user.hpp
pc_boost_pl.o: /usr/include/boost/config/select_compiler_config.hpp
pc_boost_pl.o: /usr/include/boost/config/compiler/gcc.hpp
pc_boost_pl.o: /usr/include/boost/config/select_platform_config.hpp
pc_boost_pl.o: /usr/include/boost/config/platform/linux.hpp
pc_boost_pl.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
pc_boost_pl.o: /usr/include/bits/waitstatus.h /usr/include/sys/types.h
pc_boost_pl.o: /usr/include/time.h /usr/include/sys/select.h
pc_boost_pl.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
pc_boost_pl.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
pc_boost_pl.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
pc_boost_pl.o: /usr/include/bits/stdlib-float.h
pc_boost_pl.o: /usr/include/boost/config/posix_features.hpp
pc_boost_pl.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
pc_boost_pl.o: /usr/include/bits/environments.h /usr/include/bits/confname.h
pc_boost_pl.o: /usr/include/getopt.h /usr/include/boost/config/suffix.hpp
pc_boost_pl.o: /usr/include/stdint.h /usr/include/bits/wchar.h
pc_boost_pl.o: /usr/include/boost/assert.hpp /usr/include/c++/4.8.2/cstdlib
pc_boost_pl.o: /usr/include/c++/4.8.2/iostream /usr/include/c++/4.8.2/ostream
pc_boost_pl.o: /usr/include/c++/4.8.2/ios
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/ios_base.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/locale_classes.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/locale_classes.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/streambuf
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/streambuf.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/basic_ios.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/locale_facets.h
pc_boost_pl.o: /usr/include/c++/4.8.2/cwctype
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/streambuf_iterator.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/locale_facets.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/basic_ios.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/ostream.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/istream
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/istream.tcc
pc_boost_pl.o: /usr/include/boost/current_function.hpp
pc_boost_pl.o: /usr/include/boost/operators.hpp
pc_boost_pl.o: /usr/include/boost/iterator.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/iterator
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stream_iterator.h
pc_boost_pl.o: /usr/include/c++/4.8.2/cstddef
pc_boost_pl.o: /usr/include/boost/noncopyable.hpp
pc_boost_pl.o: /usr/include/boost/utility/enable_if.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/functional
pc_boost_pl.o: /usr/include/boost/cerrno.hpp /usr/include/c++/4.8.2/cerrno
pc_boost_pl.o: /usr/include/errno.h /usr/include/bits/errno.h
pc_boost_pl.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
pc_boost_pl.o: /usr/include/asm-generic/errno.h
pc_boost_pl.o: /usr/include/asm-generic/errno-base.h
pc_boost_pl.o: /usr/include/boost/config/abi_prefix.hpp
pc_boost_pl.o: /usr/include/boost/config/abi_suffix.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/move.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_convertible.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/intrinsics.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/config.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_array.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
pc_boost_pl.o: /usr/include/boost/mpl/int.hpp
pc_boost_pl.o: /usr/include/boost/mpl/int_fwd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/adl.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/intel.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/cat.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/config/config.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
pc_boost_pl.o: /usr/include/boost/mpl/integral_c_tag.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/static_cast.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/comma_if.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/control/if.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/control/iif.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/logical/bool.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/facilities/empty.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repeat.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/debug/error.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/tuple/eat.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/inc.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/integral_constant.hpp
pc_boost_pl.o: /usr/include/boost/mpl/bool.hpp
pc_boost_pl.o: /usr/include/boost/mpl/bool_fwd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/integral_c.hpp
pc_boost_pl.o: /usr/include/boost/mpl/integral_c_fwd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/yes_no.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/facilities/overload.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/variadic/size.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/list/adt.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/detail/check.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/logical/compl.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/for.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/tuple/elem.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/tuple/rem.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/variadic/elem.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/ice.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/ice_or.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/ice_and.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/ice_not.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_arithmetic.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_integral.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_float.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_void.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_abstract.hpp
pc_boost_pl.o: /usr/include/boost/static_assert.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_class.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_union.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/remove_cv.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/add_reference.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_reference.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_function.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/false_result.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/remove_reference.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/decay.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/remove_bounds.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/add_pointer.hpp
pc_boost_pl.o: /usr/include/boost/mpl/eval_if.hpp
pc_boost_pl.o: /usr/include/boost/mpl/if.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/value_wknd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/integral.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/eti.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/na_spec.hpp
pc_boost_pl.o: /usr/include/boost/mpl/lambda_fwd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/void_fwd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/na.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/arity.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/dtp.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/preprocessor/def_params_tail.hpp
pc_boost_pl.o: /usr/include/boost/mpl/limits/arity.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/logical/and.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/logical/bitand.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/identity.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/facilities/identity.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/empty.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/arithmetic/add.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/arithmetic/dec.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/control/while.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/list/fold_left.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/list/detail/fold_left.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/list/fold_right.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/list/detail/fold_right.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/list/reverse.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/control/detail/while.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/arithmetic/sub.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/lambda_arity_param.hpp
pc_boost_pl.o: /usr/include/boost/mpl/identity.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/delete.hpp
pc_boost_pl.o: /usr/include/boost/move/utility.hpp
pc_boost_pl.o: /usr/include/boost/move/detail/config_begin.hpp
pc_boost_pl.o: /usr/include/boost/move/core.hpp
pc_boost_pl.o: /usr/include/boost/move/detail/meta_utils.hpp
pc_boost_pl.o: /usr/include/boost/move/detail/config_end.hpp
pc_boost_pl.o: /usr/include/boost/move/traits.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/has_trivial_destructor.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_pod.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_scalar.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_enum.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_pointer.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_member_pointer.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_member_function_pointer.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/detail/is_mem_fun_pointer_impl.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_nothrow_move_constructible.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/has_trivial_move_constructor.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_volatile.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/has_nothrow_copy.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/has_trivial_copy.hpp
pc_boost_pl.o: /usr/include/boost/utility/declval.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_nothrow_move_assignable.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/has_trivial_move_assign.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_const.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/has_nothrow_assign.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/has_trivial_assign.hpp
pc_boost_pl.o: /usr/include/boost/thread/mutex.hpp
pc_boost_pl.o: /usr/include/boost/thread/lockable_traits.hpp
pc_boost_pl.o: /usr/include/boost/thread/xtime.hpp
pc_boost_pl.o: /usr/include/boost/thread/thread_time.hpp
pc_boost_pl.o: /usr/include/boost/date_time/time_clock.hpp
pc_boost_pl.o: /usr/include/boost/date_time/c_time.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/ctime
pc_boost_pl.o: /usr/include/boost/throw_exception.hpp
pc_boost_pl.o: /usr/include/boost/exception/detail/attribute_noreturn.hpp
pc_boost_pl.o: /usr/include/boost/date_time/compiler_config.hpp
pc_boost_pl.o: /usr/include/boost/date_time/locale_config.hpp
pc_boost_pl.o: /usr/include/sys/time.h /usr/include/boost/shared_ptr.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/shared_ptr.hpp
pc_boost_pl.o: /usr/include/boost/config/no_tr1/memory.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/memory
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_construct.h
pc_boost_pl.o: /usr/include/c++/4.8.2/new
pc_boost_pl.o: /usr/include/c++/4.8.2/ext/alloc_traits.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_uninitialized.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_tempbuf.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_raw_storage_iter.h
pc_boost_pl.o: /usr/include/c++/4.8.2/backward/auto_ptr.h
pc_boost_pl.o: /usr/include/boost/checked_delete.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/shared_count.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/bad_weak_ptr.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/sp_counted_base.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/sp_has_sync.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/sp_counted_base_gcc_x86.hpp
pc_boost_pl.o: /usr/include/boost/detail/sp_typeinfo.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/typeinfo
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/sp_counted_impl.hpp
pc_boost_pl.o: /usr/include/boost/utility/addressof.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/sp_convertible.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/sp_nullptr_t.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/spinlock_pool.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/spinlock.hpp
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/spinlock_pt.hpp
pc_boost_pl.o: /usr/include/pthread.h /usr/include/sched.h
pc_boost_pl.o: /usr/include/bits/sched.h /usr/include/bits/setjmp.h
pc_boost_pl.o: /usr/include/boost/memory_order.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/algorithm
pc_boost_pl.o: /usr/include/c++/4.8.2/utility
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_relops.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_algo.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/algorithmfwd.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_heap.h
pc_boost_pl.o: /usr/include/boost/smart_ptr/detail/operator_bool.hpp
pc_boost_pl.o: /usr/include/boost/date_time/microsec_time_clock.hpp
pc_boost_pl.o: /usr/include/boost/date_time/filetime_functions.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/posix_time_types.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/ptime.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/posix_time_system.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/posix_time_config.hpp
pc_boost_pl.o: /usr/include/boost/limits.hpp /usr/include/c++/4.8.2/limits
pc_boost_pl.o: /usr/include/boost/config/no_tr1/cmath.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/cmath /usr/include/math.h
pc_boost_pl.o: /usr/include/bits/huge_val.h /usr/include/bits/huge_valf.h
pc_boost_pl.o: /usr/include/bits/huge_vall.h /usr/include/bits/inf.h
pc_boost_pl.o: /usr/include/bits/nan.h /usr/include/bits/mathdef.h
pc_boost_pl.o: /usr/include/bits/mathcalls.h
pc_boost_pl.o: /usr/include/boost/date_time/time_duration.hpp
pc_boost_pl.o: /usr/include/boost/date_time/time_defs.hpp
pc_boost_pl.o: /usr/include/boost/date_time/special_defs.hpp
pc_boost_pl.o: /usr/include/boost/date_time/time_resolution_traits.hpp
pc_boost_pl.o: /usr/include/boost/date_time/int_adapter.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/gregorian_types.hpp
pc_boost_pl.o: /usr/include/boost/date_time/date.hpp
pc_boost_pl.o: /usr/include/boost/date_time/year_month_day.hpp
pc_boost_pl.o: /usr/include/boost/date_time/period.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_calendar.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_weekday.hpp
pc_boost_pl.o: /usr/include/boost/date_time/constrained_value.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_base_of.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_base_and_derived.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_same.hpp
pc_boost_pl.o: /usr/include/boost/date_time/date_defs.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_day_of_year.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian_calendar.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian_calendar.ipp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_ymd.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_day.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_year.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_month.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/map
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_tree.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_map.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_multimap.h
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_duration.hpp
pc_boost_pl.o: /usr/include/boost/date_time/date_duration.hpp
pc_boost_pl.o: /usr/include/boost/date_time/date_duration_types.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_duration_types.hpp
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/greg_date.hpp
pc_boost_pl.o: /usr/include/boost/date_time/adjust_functors.hpp
pc_boost_pl.o: /usr/include/boost/date_time/wrapping_int.hpp
pc_boost_pl.o: /usr/include/boost/date_time/date_generators.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/sstream
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/sstream.tcc
pc_boost_pl.o: /usr/include/boost/date_time/date_clock_device.hpp
pc_boost_pl.o: /usr/include/boost/date_time/date_iterator.hpp
pc_boost_pl.o: /usr/include/boost/date_time/time_system_split.hpp
pc_boost_pl.o: /usr/include/boost/date_time/time_system_counted.hpp
pc_boost_pl.o: /usr/include/boost/date_time/time.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/date_duration_operators.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/posix_time_duration.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/time_period.hpp
pc_boost_pl.o: /usr/include/boost/date_time/time_iterator.hpp
pc_boost_pl.o: /usr/include/boost/date_time/dst_rules.hpp
pc_boost_pl.o: /usr/include/boost/date_time/posix_time/conversion.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/cstring /usr/include/string.h
pc_boost_pl.o: /usr/include/boost/date_time/gregorian/conversion.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/thread_heap_alloc.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/make_tuple_indices.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/invoke.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/is_convertible.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/list
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_list.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/list.tcc
pc_boost_pl.o: /usr/include/boost/ref.hpp /usr/include/boost/bind.hpp
pc_boost_pl.o: /usr/include/boost/bind/bind.hpp /usr/include/boost/mem_fn.hpp
pc_boost_pl.o: /usr/include/boost/bind/mem_fn.hpp
pc_boost_pl.o: /usr/include/boost/get_pointer.hpp
pc_boost_pl.o: /usr/include/boost/bind/mem_fn_template.hpp
pc_boost_pl.o: /usr/include/boost/bind/mem_fn_cc.hpp
pc_boost_pl.o: /usr/include/boost/type.hpp
pc_boost_pl.o: /usr/include/boost/is_placeholder.hpp
pc_boost_pl.o: /usr/include/boost/bind/arg.hpp
pc_boost_pl.o: /usr/include/boost/visit_each.hpp
pc_boost_pl.o: /usr/include/boost/bind/storage.hpp
pc_boost_pl.o: /usr/include/boost/bind/bind_template.hpp
pc_boost_pl.o: /usr/include/boost/bind/bind_cc.hpp
pc_boost_pl.o: /usr/include/boost/bind/bind_mf_cc.hpp
pc_boost_pl.o: /usr/include/boost/bind/bind_mf2_cc.hpp
pc_boost_pl.o: /usr/include/boost/bind/placeholders.hpp
pc_boost_pl.o: /usr/include/boost/io/ios_state.hpp
pc_boost_pl.o: /usr/include/boost/io_fwd.hpp /usr/include/c++/4.8.2/locale
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/codecvt.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.tcc
pc_boost_pl.o: /usr/include/boost/functional/hash.hpp
pc_boost_pl.o: /usr/include/boost/functional/hash/hash.hpp
pc_boost_pl.o: /usr/include/boost/functional/hash/hash_fwd.hpp
pc_boost_pl.o: /usr/include/boost/functional/hash/detail/hash_float.hpp
pc_boost_pl.o: /usr/include/boost/functional/hash/detail/float_functions.hpp
pc_boost_pl.o: /usr/include/boost/functional/hash/detail/limits.hpp
pc_boost_pl.o: /usr/include/boost/integer/static_log2.hpp
pc_boost_pl.o: /usr/include/boost/integer_fwd.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/climits /usr/include/limits.h
pc_boost_pl.o: /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h
pc_boost_pl.o: /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h
pc_boost_pl.o: /usr/include/c++/4.8.2/typeindex
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/c++0x_warning.h
pc_boost_pl.o: /usr/include/boost/functional/hash/extensions.hpp
pc_boost_pl.o: /usr/include/boost/detail/container_fwd.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/deque
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_deque.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/deque.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/vector
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_vector.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_bvector.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/vector.tcc
pc_boost_pl.o: /usr/include/c++/4.8.2/set
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_set.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bits/stl_multiset.h
pc_boost_pl.o: /usr/include/c++/4.8.2/bitset /usr/include/c++/4.8.2/complex
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/repeat_from_to.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/enum_params.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/array /usr/include/c++/4.8.2/tuple
pc_boost_pl.o: /usr/include/boost/chrono/system_clocks.hpp
pc_boost_pl.o: /usr/include/boost/chrono/config.hpp
pc_boost_pl.o: /usr/include/boost/chrono/duration.hpp
pc_boost_pl.o: /usr/include/boost/chrono/detail/static_assert.hpp
pc_boost_pl.o: /usr/include/boost/mpl/logical.hpp
pc_boost_pl.o: /usr/include/boost/mpl/or.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/use_preprocessed.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/nested_type_wknd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/compiler.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/stringize.hpp
pc_boost_pl.o: /usr/include/boost/mpl/and.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost_pl.o: /usr/include/boost/mpl/not.hpp
pc_boost_pl.o: /usr/include/boost/ratio/ratio.hpp
pc_boost_pl.o: /usr/include/boost/ratio/config.hpp
pc_boost_pl.o: /usr/include/boost/ratio/detail/mpl/abs.hpp
pc_boost_pl.o: /usr/include/boost/ratio/detail/mpl/sign.hpp
pc_boost_pl.o: /usr/include/boost/ratio/detail/mpl/gcd.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/largest_int.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/dependent_nttp.hpp
pc_boost_pl.o: /usr/include/boost/ratio/detail/mpl/lcm.hpp
pc_boost_pl.o: /usr/include/boost/integer_traits.hpp /usr/include/wchar.h
pc_boost_pl.o: /usr/include/boost/ratio/ratio_fwd.hpp
pc_boost_pl.o: /usr/include/boost/ratio/detail/overflow_helpers.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/common_type.hpp
pc_boost_pl.o: /usr/include/boost/typeof/typeof.hpp
pc_boost_pl.o: /usr/include/boost/typeof/message.hpp
pc_boost_pl.o: /usr/include/boost/typeof/native.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_floating_point.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_unsigned.hpp
pc_boost_pl.o: /usr/include/boost/chrono/detail/is_evenly_divisible_by.hpp
pc_boost_pl.o: /usr/include/boost/chrono/time_point.hpp
pc_boost_pl.o: /usr/include/boost/chrono/detail/system.hpp
pc_boost_pl.o: /usr/include/boost/version.hpp
pc_boost_pl.o: /usr/include/boost/chrono/clock_string.hpp
pc_boost_pl.o: /usr/include/boost/chrono/ceil.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/thread_interruption.hpp
pc_boost_pl.o: /usr/include/boost/thread/v2/thread.hpp
pc_boost_pl.o: /usr/include/boost/thread/condition_variable.hpp
pc_boost_pl.o: /usr/include/boost/thread/lock_types.hpp
pc_boost_pl.o: /usr/include/boost/thread/lock_options.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/thread_group.hpp
pc_boost_pl.o: /usr/include/boost/thread/shared_mutex.hpp
pc_boost_pl.o: /usr/include/boost/thread/lock_guard.hpp
pc_boost_pl.o: /usr/include/boost/thread/detail/lockable_wrapper.hpp
pc_boost_pl.o: /usr/include/c++/4.8.2/initializer_list
pc_boost_pl.o: /usr/include/boost/thread/once.hpp
pc_boost_pl.o: /usr/include/boost/thread/recursive_mutex.hpp
pc_boost_pl.o: /usr/include/boost/thread/tss.hpp
pc_boost_pl.o: /usr/include/boost/thread/locks.hpp
pc_boost_pl.o: /usr/include/boost/thread/lock_algorithms.hpp
pc_boost_pl.o: /usr/include/boost/thread/barrier.hpp
pc_boost_pl.o: /usr/include/boost/utility/result_of.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/iteration/iterate.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/array/elem.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/array/data.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/array/size.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/slot/slot.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/slot/detail/def.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/enum_trailing_params.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/enum_binary_params.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/repetition/enum_shifted_params.hpp
pc_boost_pl.o: /usr/include/boost/preprocessor/facilities/intercept.hpp
pc_boost_pl.o: /usr/include/boost/mpl/has_xxx.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/type_wrapper.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/has_xxx.hpp
pc_boost_pl.o: /usr/include/boost/mpl/aux_/config/msvc_typename.hpp
pc_boost_pl.o: /usr/include/boost/thread/future.hpp
pc_boost_pl.o: /usr/include/boost/atomic.hpp
pc_boost_pl.o: /usr/include/boost/atomic/atomic.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/config.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/platform.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/base.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/lockpool.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/link.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/cas64strong.hpp
pc_boost_pl.o: /usr/include/boost/atomic/detail/type-classification.hpp
pc_boost_pl.o: /usr/include/boost/type_traits/is_signed.hpp chunk.h decoder.h
pc_boost_pl.o: sf.h channelmap.h player.h playlist.h trackinfo.h softvol.h
pc_boost_status.o: pc_boost.h pc_boost_monitor.h
pc_boost_status.o: /usr/include/boost/thread.hpp
pc_boost_status.o: /usr/include/boost/thread/thread.hpp
pc_boost_status.o: /usr/include/boost/thread/thread_only.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/platform.hpp
pc_boost_status.o: /usr/include/boost/config.hpp
pc_boost_status.o: /usr/include/boost/config/requires_threads.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/thread.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/config.hpp
pc_boost_status.o: /usr/include/boost/detail/workaround.hpp
pc_boost_status.o: /usr/include/boost/config/auto_link.hpp
pc_boost_status.o: /usr/include/boost/thread/exceptions.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/string
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stringfwd.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/memoryfwd.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/char_traits.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_algobase.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/functexcept.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/exception_defines.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/cpp_type_traits.h
pc_boost_status.o: /usr/include/c++/4.8.2/ext/type_traits.h
pc_boost_status.o: /usr/include/c++/4.8.2/ext/numeric_traits.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_pair.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/move.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/concept_check.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_types.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_funcs.h
pc_boost_status.o: /usr/include/c++/4.8.2/debug/debug.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_iterator.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/postypes.h
pc_boost_status.o: /usr/include/c++/4.8.2/cwchar
pc_boost_status.o: /usr/include/c++/4.8.2/bits/allocator.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/localefwd.h
pc_boost_status.o: /usr/include/c++/4.8.2/iosfwd
pc_boost_status.o: /usr/include/c++/4.8.2/cctype /usr/include/ctype.h
pc_boost_status.o: /usr/include/features.h /usr/include/stdc-predef.h
pc_boost_status.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
pc_boost_status.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
pc_boost_status.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
pc_boost_status.o: /usr/include/endian.h /usr/include/bits/endian.h
pc_boost_status.o: /usr/include/bits/byteswap.h
pc_boost_status.o: /usr/include/bits/byteswap-16.h /usr/include/xlocale.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/ostream_insert.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/cxxabi_forced.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_function.h
pc_boost_status.o: /usr/include/c++/4.8.2/backward/binders.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/range_access.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/basic_string.h
pc_boost_status.o: /usr/include/c++/4.8.2/ext/atomicity.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/basic_string.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/stdexcept
pc_boost_status.o: /usr/include/c++/4.8.2/exception
pc_boost_status.o: /usr/include/c++/4.8.2/bits/atomic_lockfree_defines.h
pc_boost_status.o: /usr/include/boost/system/system_error.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/cassert /usr/include/assert.h
pc_boost_status.o: /usr/include/boost/system/error_code.hpp
pc_boost_status.o: /usr/include/boost/system/config.hpp
pc_boost_status.o: /usr/include/boost/system/api_config.hpp
pc_boost_status.o: /usr/include/boost/cstdint.hpp
pc_boost_status.o: /usr/include/boost/config.hpp
pc_boost_status.o: /usr/include/boost/config/user.hpp
pc_boost_status.o: /usr/include/boost/config/select_compiler_config.hpp
pc_boost_status.o: /usr/include/boost/config/compiler/gcc.hpp
pc_boost_status.o: /usr/include/boost/config/select_platform_config.hpp
pc_boost_status.o: /usr/include/boost/config/platform/linux.hpp
pc_boost_status.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
pc_boost_status.o: /usr/include/bits/waitstatus.h /usr/include/sys/types.h
pc_boost_status.o: /usr/include/time.h /usr/include/sys/select.h
pc_boost_status.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
pc_boost_status.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
pc_boost_status.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
pc_boost_status.o: /usr/include/bits/stdlib-float.h
pc_boost_status.o: /usr/include/boost/config/posix_features.hpp
pc_boost_status.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
pc_boost_status.o: /usr/include/bits/environments.h
pc_boost_status.o: /usr/include/bits/confname.h /usr/include/getopt.h
pc_boost_status.o: /usr/include/boost/config/suffix.hpp /usr/include/stdint.h
pc_boost_status.o: /usr/include/bits/wchar.h /usr/include/boost/assert.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/cstdlib
pc_boost_status.o: /usr/include/c++/4.8.2/iostream
pc_boost_status.o: /usr/include/c++/4.8.2/ostream /usr/include/c++/4.8.2/ios
pc_boost_status.o: /usr/include/c++/4.8.2/bits/ios_base.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/locale_classes.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/locale_classes.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/streambuf
pc_boost_status.o: /usr/include/c++/4.8.2/bits/streambuf.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/bits/basic_ios.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/locale_facets.h
pc_boost_status.o: /usr/include/c++/4.8.2/cwctype
pc_boost_status.o: /usr/include/c++/4.8.2/bits/streambuf_iterator.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/locale_facets.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/bits/basic_ios.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/bits/ostream.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/istream
pc_boost_status.o: /usr/include/c++/4.8.2/bits/istream.tcc
pc_boost_status.o: /usr/include/boost/current_function.hpp
pc_boost_status.o: /usr/include/boost/operators.hpp
pc_boost_status.o: /usr/include/boost/iterator.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/iterator
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stream_iterator.h
pc_boost_status.o: /usr/include/c++/4.8.2/cstddef
pc_boost_status.o: /usr/include/boost/noncopyable.hpp
pc_boost_status.o: /usr/include/boost/utility/enable_if.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/functional
pc_boost_status.o: /usr/include/boost/cerrno.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/cerrno /usr/include/errno.h
pc_boost_status.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
pc_boost_status.o: /usr/include/asm/errno.h /usr/include/asm-generic/errno.h
pc_boost_status.o: /usr/include/asm-generic/errno-base.h
pc_boost_status.o: /usr/include/boost/config/abi_prefix.hpp
pc_boost_status.o: /usr/include/boost/config/abi_suffix.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/move.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_convertible.hpp
pc_boost_status.o: /usr/include/boost/type_traits/intrinsics.hpp
pc_boost_status.o: /usr/include/boost/type_traits/config.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_array.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
pc_boost_status.o: /usr/include/boost/mpl/int.hpp
pc_boost_status.o: /usr/include/boost/mpl/int_fwd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/adl.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/intel.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/cat.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/config/config.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
pc_boost_status.o: /usr/include/boost/mpl/integral_c_tag.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/static_cast.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/comma_if.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/control/if.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/control/iif.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/logical/bool.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/facilities/empty.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repeat.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/debug/error.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/tuple/eat.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/inc.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
pc_boost_status.o: /usr/include/boost/type_traits/integral_constant.hpp
pc_boost_status.o: /usr/include/boost/mpl/bool.hpp
pc_boost_status.o: /usr/include/boost/mpl/bool_fwd.hpp
pc_boost_status.o: /usr/include/boost/mpl/integral_c.hpp
pc_boost_status.o: /usr/include/boost/mpl/integral_c_fwd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/yes_no.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/facilities/overload.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/variadic/size.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/list/adt.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/detail/check.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/logical/compl.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/for.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/tuple/elem.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/tuple/rem.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/variadic/elem.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
pc_boost_status.o: /usr/include/boost/type_traits/ice.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/ice_or.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/ice_and.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/ice_not.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_arithmetic.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_integral.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_float.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_void.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_abstract.hpp
pc_boost_status.o: /usr/include/boost/static_assert.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_class.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_union.hpp
pc_boost_status.o: /usr/include/boost/type_traits/remove_cv.hpp
pc_boost_status.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
pc_boost_status.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
pc_boost_status.o: /usr/include/boost/type_traits/add_reference.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_reference.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
pc_boost_status.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_function.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/false_result.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
pc_boost_status.o: /usr/include/boost/type_traits/remove_reference.hpp
pc_boost_status.o: /usr/include/boost/type_traits/decay.hpp
pc_boost_status.o: /usr/include/boost/type_traits/remove_bounds.hpp
pc_boost_status.o: /usr/include/boost/type_traits/add_pointer.hpp
pc_boost_status.o: /usr/include/boost/mpl/eval_if.hpp
pc_boost_status.o: /usr/include/boost/mpl/if.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/value_wknd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/integral.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/eti.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/na_spec.hpp
pc_boost_status.o: /usr/include/boost/mpl/lambda_fwd.hpp
pc_boost_status.o: /usr/include/boost/mpl/void_fwd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/na.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/arity.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/dtp.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/preprocessor/def_params_tail.hpp
pc_boost_status.o: /usr/include/boost/mpl/limits/arity.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/logical/and.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/logical/bitand.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/identity.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/facilities/identity.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/empty.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/arithmetic/add.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/arithmetic/dec.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/control/while.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/list/fold_left.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/list/detail/fold_left.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/list/fold_right.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/list/detail/fold_right.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/list/reverse.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/control/detail/while.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/arithmetic/sub.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/lambda_arity_param.hpp
pc_boost_status.o: /usr/include/boost/mpl/identity.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/delete.hpp
pc_boost_status.o: /usr/include/boost/move/utility.hpp
pc_boost_status.o: /usr/include/boost/move/detail/config_begin.hpp
pc_boost_status.o: /usr/include/boost/move/core.hpp
pc_boost_status.o: /usr/include/boost/move/detail/meta_utils.hpp
pc_boost_status.o: /usr/include/boost/move/detail/config_end.hpp
pc_boost_status.o: /usr/include/boost/move/traits.hpp
pc_boost_status.o: /usr/include/boost/type_traits/has_trivial_destructor.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_pod.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_scalar.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_enum.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_pointer.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_member_pointer.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_member_function_pointer.hpp
pc_boost_status.o: /usr/include/boost/type_traits/detail/is_mem_fun_pointer_impl.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_nothrow_move_constructible.hpp
pc_boost_status.o: /usr/include/boost/type_traits/has_trivial_move_constructor.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_volatile.hpp
pc_boost_status.o: /usr/include/boost/type_traits/has_nothrow_copy.hpp
pc_boost_status.o: /usr/include/boost/type_traits/has_trivial_copy.hpp
pc_boost_status.o: /usr/include/boost/utility/declval.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_nothrow_move_assignable.hpp
pc_boost_status.o: /usr/include/boost/type_traits/has_trivial_move_assign.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_const.hpp
pc_boost_status.o: /usr/include/boost/type_traits/has_nothrow_assign.hpp
pc_boost_status.o: /usr/include/boost/type_traits/has_trivial_assign.hpp
pc_boost_status.o: /usr/include/boost/thread/mutex.hpp
pc_boost_status.o: /usr/include/boost/thread/lockable_traits.hpp
pc_boost_status.o: /usr/include/boost/thread/xtime.hpp
pc_boost_status.o: /usr/include/boost/thread/thread_time.hpp
pc_boost_status.o: /usr/include/boost/date_time/time_clock.hpp
pc_boost_status.o: /usr/include/boost/date_time/c_time.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/ctime
pc_boost_status.o: /usr/include/boost/throw_exception.hpp
pc_boost_status.o: /usr/include/boost/exception/detail/attribute_noreturn.hpp
pc_boost_status.o: /usr/include/boost/date_time/compiler_config.hpp
pc_boost_status.o: /usr/include/boost/date_time/locale_config.hpp
pc_boost_status.o: /usr/include/sys/time.h /usr/include/boost/shared_ptr.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/shared_ptr.hpp
pc_boost_status.o: /usr/include/boost/config/no_tr1/memory.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/memory
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_construct.h
pc_boost_status.o: /usr/include/c++/4.8.2/new
pc_boost_status.o: /usr/include/c++/4.8.2/ext/alloc_traits.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_uninitialized.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_tempbuf.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_raw_storage_iter.h
pc_boost_status.o: /usr/include/c++/4.8.2/backward/auto_ptr.h
pc_boost_status.o: /usr/include/boost/checked_delete.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/shared_count.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/bad_weak_ptr.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/sp_counted_base.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/sp_has_sync.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/sp_counted_base_gcc_x86.hpp
pc_boost_status.o: /usr/include/boost/detail/sp_typeinfo.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/typeinfo
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/sp_counted_impl.hpp
pc_boost_status.o: /usr/include/boost/utility/addressof.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/sp_convertible.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/sp_nullptr_t.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/spinlock_pool.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/spinlock.hpp
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/spinlock_pt.hpp
pc_boost_status.o: /usr/include/pthread.h /usr/include/sched.h
pc_boost_status.o: /usr/include/bits/sched.h /usr/include/bits/setjmp.h
pc_boost_status.o: /usr/include/boost/memory_order.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/algorithm
pc_boost_status.o: /usr/include/c++/4.8.2/utility
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_relops.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_algo.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/algorithmfwd.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_heap.h
pc_boost_status.o: /usr/include/boost/smart_ptr/detail/operator_bool.hpp
pc_boost_status.o: /usr/include/boost/date_time/microsec_time_clock.hpp
pc_boost_status.o: /usr/include/boost/date_time/filetime_functions.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/posix_time_types.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/ptime.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/posix_time_system.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/posix_time_config.hpp
pc_boost_status.o: /usr/include/boost/limits.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/limits
pc_boost_status.o: /usr/include/boost/config/no_tr1/cmath.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/cmath /usr/include/math.h
pc_boost_status.o: /usr/include/bits/huge_val.h /usr/include/bits/huge_valf.h
pc_boost_status.o: /usr/include/bits/huge_vall.h /usr/include/bits/inf.h
pc_boost_status.o: /usr/include/bits/nan.h /usr/include/bits/mathdef.h
pc_boost_status.o: /usr/include/bits/mathcalls.h
pc_boost_status.o: /usr/include/boost/date_time/time_duration.hpp
pc_boost_status.o: /usr/include/boost/date_time/time_defs.hpp
pc_boost_status.o: /usr/include/boost/date_time/special_defs.hpp
pc_boost_status.o: /usr/include/boost/date_time/time_resolution_traits.hpp
pc_boost_status.o: /usr/include/boost/date_time/int_adapter.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/gregorian_types.hpp
pc_boost_status.o: /usr/include/boost/date_time/date.hpp
pc_boost_status.o: /usr/include/boost/date_time/year_month_day.hpp
pc_boost_status.o: /usr/include/boost/date_time/period.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_calendar.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_weekday.hpp
pc_boost_status.o: /usr/include/boost/date_time/constrained_value.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_base_of.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_base_and_derived.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_same.hpp
pc_boost_status.o: /usr/include/boost/date_time/date_defs.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_day_of_year.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian_calendar.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian_calendar.ipp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_ymd.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_day.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_year.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_month.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/map
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_tree.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_map.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_multimap.h
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_duration.hpp
pc_boost_status.o: /usr/include/boost/date_time/date_duration.hpp
pc_boost_status.o: /usr/include/boost/date_time/date_duration_types.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_duration_types.hpp
pc_boost_status.o: /usr/include/boost/date_time/gregorian/greg_date.hpp
pc_boost_status.o: /usr/include/boost/date_time/adjust_functors.hpp
pc_boost_status.o: /usr/include/boost/date_time/wrapping_int.hpp
pc_boost_status.o: /usr/include/boost/date_time/date_generators.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/sstream
pc_boost_status.o: /usr/include/c++/4.8.2/bits/sstream.tcc
pc_boost_status.o: /usr/include/boost/date_time/date_clock_device.hpp
pc_boost_status.o: /usr/include/boost/date_time/date_iterator.hpp
pc_boost_status.o: /usr/include/boost/date_time/time_system_split.hpp
pc_boost_status.o: /usr/include/boost/date_time/time_system_counted.hpp
pc_boost_status.o: /usr/include/boost/date_time/time.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/date_duration_operators.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/posix_time_duration.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/time_period.hpp
pc_boost_status.o: /usr/include/boost/date_time/time_iterator.hpp
pc_boost_status.o: /usr/include/boost/date_time/dst_rules.hpp
pc_boost_status.o: /usr/include/boost/date_time/posix_time/conversion.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/cstring /usr/include/string.h
pc_boost_status.o: /usr/include/boost/date_time/gregorian/conversion.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/thread_heap_alloc.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/make_tuple_indices.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/invoke.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/is_convertible.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/list
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_list.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/list.tcc
pc_boost_status.o: /usr/include/boost/ref.hpp /usr/include/boost/bind.hpp
pc_boost_status.o: /usr/include/boost/bind/bind.hpp
pc_boost_status.o: /usr/include/boost/mem_fn.hpp
pc_boost_status.o: /usr/include/boost/bind/mem_fn.hpp
pc_boost_status.o: /usr/include/boost/get_pointer.hpp
pc_boost_status.o: /usr/include/boost/bind/mem_fn_template.hpp
pc_boost_status.o: /usr/include/boost/bind/mem_fn_cc.hpp
pc_boost_status.o: /usr/include/boost/type.hpp
pc_boost_status.o: /usr/include/boost/is_placeholder.hpp
pc_boost_status.o: /usr/include/boost/bind/arg.hpp
pc_boost_status.o: /usr/include/boost/visit_each.hpp
pc_boost_status.o: /usr/include/boost/bind/storage.hpp
pc_boost_status.o: /usr/include/boost/bind/bind_template.hpp
pc_boost_status.o: /usr/include/boost/bind/bind_cc.hpp
pc_boost_status.o: /usr/include/boost/bind/bind_mf_cc.hpp
pc_boost_status.o: /usr/include/boost/bind/bind_mf2_cc.hpp
pc_boost_status.o: /usr/include/boost/bind/placeholders.hpp
pc_boost_status.o: /usr/include/boost/io/ios_state.hpp
pc_boost_status.o: /usr/include/boost/io_fwd.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/locale
pc_boost_status.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/codecvt.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.tcc
pc_boost_status.o: /usr/include/boost/functional/hash.hpp
pc_boost_status.o: /usr/include/boost/functional/hash/hash.hpp
pc_boost_status.o: /usr/include/boost/functional/hash/hash_fwd.hpp
pc_boost_status.o: /usr/include/boost/functional/hash/detail/hash_float.hpp
pc_boost_status.o: /usr/include/boost/functional/hash/detail/float_functions.hpp
pc_boost_status.o: /usr/include/boost/functional/hash/detail/limits.hpp
pc_boost_status.o: /usr/include/boost/integer/static_log2.hpp
pc_boost_status.o: /usr/include/boost/integer_fwd.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/climits /usr/include/limits.h
pc_boost_status.o: /usr/include/bits/posix1_lim.h
pc_boost_status.o: /usr/include/bits/local_lim.h /usr/include/linux/limits.h
pc_boost_status.o: /usr/include/bits/posix2_lim.h
pc_boost_status.o: /usr/include/c++/4.8.2/typeindex
pc_boost_status.o: /usr/include/c++/4.8.2/bits/c++0x_warning.h
pc_boost_status.o: /usr/include/boost/functional/hash/extensions.hpp
pc_boost_status.o: /usr/include/boost/detail/container_fwd.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/deque
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_deque.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/deque.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/vector
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_vector.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_bvector.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/vector.tcc
pc_boost_status.o: /usr/include/c++/4.8.2/set
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_set.h
pc_boost_status.o: /usr/include/c++/4.8.2/bits/stl_multiset.h
pc_boost_status.o: /usr/include/c++/4.8.2/bitset
pc_boost_status.o: /usr/include/c++/4.8.2/complex
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/repeat_from_to.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/enum_params.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/array /usr/include/c++/4.8.2/tuple
pc_boost_status.o: /usr/include/boost/chrono/system_clocks.hpp
pc_boost_status.o: /usr/include/boost/chrono/config.hpp
pc_boost_status.o: /usr/include/boost/chrono/duration.hpp
pc_boost_status.o: /usr/include/boost/chrono/detail/static_assert.hpp
pc_boost_status.o: /usr/include/boost/mpl/logical.hpp
pc_boost_status.o: /usr/include/boost/mpl/or.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/use_preprocessed.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/nested_type_wknd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/compiler.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/stringize.hpp
pc_boost_status.o: /usr/include/boost/mpl/and.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost_status.o: /usr/include/boost/mpl/not.hpp
pc_boost_status.o: /usr/include/boost/ratio/ratio.hpp
pc_boost_status.o: /usr/include/boost/ratio/config.hpp
pc_boost_status.o: /usr/include/boost/ratio/detail/mpl/abs.hpp
pc_boost_status.o: /usr/include/boost/ratio/detail/mpl/sign.hpp
pc_boost_status.o: /usr/include/boost/ratio/detail/mpl/gcd.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/largest_int.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/dependent_nttp.hpp
pc_boost_status.o: /usr/include/boost/ratio/detail/mpl/lcm.hpp
pc_boost_status.o: /usr/include/boost/integer_traits.hpp /usr/include/wchar.h
pc_boost_status.o: /usr/include/boost/ratio/ratio_fwd.hpp
pc_boost_status.o: /usr/include/boost/ratio/detail/overflow_helpers.hpp
pc_boost_status.o: /usr/include/boost/type_traits/common_type.hpp
pc_boost_status.o: /usr/include/boost/typeof/typeof.hpp
pc_boost_status.o: /usr/include/boost/typeof/message.hpp
pc_boost_status.o: /usr/include/boost/typeof/native.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_floating_point.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_unsigned.hpp
pc_boost_status.o: /usr/include/boost/chrono/detail/is_evenly_divisible_by.hpp
pc_boost_status.o: /usr/include/boost/chrono/time_point.hpp
pc_boost_status.o: /usr/include/boost/chrono/detail/system.hpp
pc_boost_status.o: /usr/include/boost/version.hpp
pc_boost_status.o: /usr/include/boost/chrono/clock_string.hpp
pc_boost_status.o: /usr/include/boost/chrono/ceil.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/thread_interruption.hpp
pc_boost_status.o: /usr/include/boost/thread/v2/thread.hpp
pc_boost_status.o: /usr/include/boost/thread/condition_variable.hpp
pc_boost_status.o: /usr/include/boost/thread/lock_types.hpp
pc_boost_status.o: /usr/include/boost/thread/lock_options.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/thread_group.hpp
pc_boost_status.o: /usr/include/boost/thread/shared_mutex.hpp
pc_boost_status.o: /usr/include/boost/thread/lock_guard.hpp
pc_boost_status.o: /usr/include/boost/thread/detail/lockable_wrapper.hpp
pc_boost_status.o: /usr/include/c++/4.8.2/initializer_list
pc_boost_status.o: /usr/include/boost/thread/once.hpp
pc_boost_status.o: /usr/include/boost/thread/recursive_mutex.hpp
pc_boost_status.o: /usr/include/boost/thread/tss.hpp
pc_boost_status.o: /usr/include/boost/thread/locks.hpp
pc_boost_status.o: /usr/include/boost/thread/lock_algorithms.hpp
pc_boost_status.o: /usr/include/boost/thread/barrier.hpp
pc_boost_status.o: /usr/include/boost/utility/result_of.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/iteration/iterate.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/array/elem.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/array/data.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/array/size.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/slot/slot.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/slot/detail/def.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/enum_trailing_params.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/enum_binary_params.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/repetition/enum_shifted_params.hpp
pc_boost_status.o: /usr/include/boost/preprocessor/facilities/intercept.hpp
pc_boost_status.o: /usr/include/boost/mpl/has_xxx.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/type_wrapper.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/has_xxx.hpp
pc_boost_status.o: /usr/include/boost/mpl/aux_/config/msvc_typename.hpp
pc_boost_status.o: /usr/include/boost/thread/future.hpp
pc_boost_status.o: /usr/include/boost/atomic.hpp
pc_boost_status.o: /usr/include/boost/atomic/atomic.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/config.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/platform.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/base.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/lockpool.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/link.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/cas64strong.hpp
pc_boost_status.o: /usr/include/boost/atomic/detail/type-classification.hpp
pc_boost_status.o: /usr/include/boost/type_traits/is_signed.hpp chunk.h
pc_boost_status.o: decoder.h sf.h channelmap.h player.h playlist.h
pc_boost_status.o: trackinfo.h softvol.h
player.o: player.h sf.h channelmap.h /usr/include/string.h
player.o: /usr/include/features.h /usr/include/stdc-predef.h
player.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
player.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
player.o: /usr/include/xlocale.h
player_alsa.o: /usr/include/alsa/asoundlib.h /usr/include/unistd.h
player_alsa.o: /usr/include/features.h /usr/include/stdc-predef.h
player_alsa.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
player_alsa.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
player_alsa.o: /usr/include/bits/posix_opt.h /usr/include/bits/environments.h
player_alsa.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
player_alsa.o: /usr/include/bits/confname.h /usr/include/getopt.h
player_alsa.o: /usr/include/stdio.h /usr/include/libio.h
player_alsa.o: /usr/include/_G_config.h /usr/include/wchar.h
player_alsa.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
player_alsa.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
player_alsa.o: /usr/include/bits/waitstatus.h /usr/include/endian.h
player_alsa.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
player_alsa.o: /usr/include/bits/byteswap-16.h /usr/include/sys/types.h
player_alsa.o: /usr/include/time.h /usr/include/sys/select.h
player_alsa.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
player_alsa.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
player_alsa.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
player_alsa.o: /usr/include/bits/stdlib-float.h /usr/include/string.h
player_alsa.o: /usr/include/xlocale.h /usr/include/fcntl.h
player_alsa.o: /usr/include/bits/fcntl.h /usr/include/bits/fcntl-linux.h
player_alsa.o: /usr/include/bits/stat.h /usr/include/assert.h
player_alsa.o: /usr/include/sys/poll.h /usr/include/bits/poll.h
player_alsa.o: /usr/include/errno.h /usr/include/bits/errno.h
player_alsa.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
player_alsa.o: /usr/include/asm-generic/errno.h
player_alsa.o: /usr/include/asm-generic/errno-base.h
player_alsa.o: /usr/include/alsa/asoundef.h /usr/include/alsa/version.h
player_alsa.o: /usr/include/alsa/global.h /usr/include/alsa/input.h
player_alsa.o: /usr/include/alsa/output.h /usr/include/alsa/error.h
player_alsa.o: /usr/include/alsa/conf.h /usr/include/alsa/pcm.h
player_alsa.o: /usr/include/alsa/rawmidi.h /usr/include/alsa/timer.h
player_alsa.o: /usr/include/alsa/hwdep.h /usr/include/alsa/control.h
player_alsa.o: /usr/include/alsa/mixer.h /usr/include/alsa/seq_event.h
player_alsa.o: /usr/include/alsa/seq.h /usr/include/alsa/seqmid.h
player_alsa.o: /usr/include/alsa/seq_midi_event.h
player_alsa.o: /usr/include/c++/4.8.2/cstring /usr/include/c++/4.8.2/cstdlib
player_alsa.o: /usr/include/c++/4.8.2/cerrno sf.h utils.h
player_alsa.o: /usr/include/sys/stat.h /usr/include/stdint.h
player_alsa.o: /usr/include/bits/wchar.h channelmap.h player_alsa.h player.h
player_sdl.o: /usr/include/SDL2/SDL_audio.h /usr/include/SDL2/SDL_stdinc.h
player_sdl.o: /usr/include/SDL2/SDL_config.h /usr/include/SDL2/SDL_platform.h
player_sdl.o: /usr/include/SDL2/begin_code.h /usr/include/SDL2/close_code.h
player_sdl.o: /usr/include/sys/types.h /usr/include/features.h
player_sdl.o: /usr/include/stdc-predef.h /usr/include/sys/cdefs.h
player_sdl.o: /usr/include/bits/wordsize.h /usr/include/gnu/stubs.h
player_sdl.o: /usr/include/gnu/stubs-32.h /usr/include/bits/types.h
player_sdl.o: /usr/include/bits/typesizes.h /usr/include/time.h
player_sdl.o: /usr/include/endian.h /usr/include/bits/endian.h
player_sdl.o: /usr/include/bits/byteswap.h /usr/include/bits/byteswap-16.h
player_sdl.o: /usr/include/sys/select.h /usr/include/bits/select.h
player_sdl.o: /usr/include/bits/sigset.h /usr/include/bits/time.h
player_sdl.o: /usr/include/sys/sysmacros.h /usr/include/bits/pthreadtypes.h
player_sdl.o: /usr/include/stdio.h /usr/include/libio.h
player_sdl.o: /usr/include/_G_config.h /usr/include/wchar.h
player_sdl.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
player_sdl.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
player_sdl.o: /usr/include/bits/waitstatus.h /usr/include/alloca.h
player_sdl.o: /usr/include/bits/stdlib-float.h /usr/include/string.h
player_sdl.o: /usr/include/xlocale.h /usr/include/strings.h
player_sdl.o: /usr/include/inttypes.h /usr/include/stdint.h
player_sdl.o: /usr/include/bits/wchar.h /usr/include/ctype.h
player_sdl.o: /usr/include/math.h /usr/include/bits/huge_val.h
player_sdl.o: /usr/include/bits/huge_valf.h /usr/include/bits/huge_vall.h
player_sdl.o: /usr/include/bits/inf.h /usr/include/bits/nan.h
player_sdl.o: /usr/include/bits/mathdef.h /usr/include/bits/mathcalls.h
player_sdl.o: /usr/include/iconv.h /usr/include/SDL2/SDL_error.h
player_sdl.o: /usr/include/SDL2/SDL_endian.h /usr/include/SDL2/SDL_mutex.h
player_sdl.o: /usr/include/SDL2/SDL_thread.h /usr/include/SDL2/SDL_atomic.h
player_sdl.o: /usr/include/SDL2/SDL_rwops.h /usr/include/SDL2/SDL.h
player_sdl.o: /usr/include/SDL2/SDL_main.h /usr/include/SDL2/SDL_assert.h
player_sdl.o: /usr/include/SDL2/SDL_audio.h /usr/include/SDL2/SDL_clipboard.h
player_sdl.o: /usr/include/SDL2/SDL_cpuinfo.h /usr/include/SDL2/SDL_events.h
player_sdl.o: /usr/include/SDL2/SDL_video.h /usr/include/SDL2/SDL_pixels.h
player_sdl.o: /usr/include/SDL2/SDL_rect.h /usr/include/SDL2/SDL_surface.h
player_sdl.o: /usr/include/SDL2/SDL_blendmode.h
player_sdl.o: /usr/include/SDL2/SDL_keyboard.h
player_sdl.o: /usr/include/SDL2/SDL_keycode.h
player_sdl.o: /usr/include/SDL2/SDL_scancode.h /usr/include/SDL2/SDL_mouse.h
player_sdl.o: /usr/include/SDL2/SDL_joystick.h
player_sdl.o: /usr/include/SDL2/SDL_gamecontroller.h
player_sdl.o: /usr/include/SDL2/SDL_quit.h /usr/include/SDL2/SDL_gesture.h
player_sdl.o: /usr/include/SDL2/SDL_touch.h
player_sdl.o: /usr/include/SDL2/SDL_filesystem.h
player_sdl.o: /usr/include/SDL2/SDL_haptic.h /usr/include/SDL2/SDL_hints.h
player_sdl.o: /usr/include/SDL2/SDL_loadso.h /usr/include/SDL2/SDL_log.h
player_sdl.o: /usr/include/SDL2/SDL_messagebox.h
player_sdl.o: /usr/include/SDL2/SDL_power.h /usr/include/SDL2/SDL_render.h
player_sdl.o: /usr/include/SDL2/SDL_system.h /usr/include/SDL2/SDL_timer.h
player_sdl.o: /usr/include/SDL2/SDL_version.h /usr/include/c++/4.8.2/cstring
player_sdl.o: pc_boost_monitor.h /usr/include/boost/thread.hpp
player_sdl.o: /usr/include/boost/thread/thread.hpp
player_sdl.o: /usr/include/boost/thread/thread_only.hpp
player_sdl.o: /usr/include/boost/thread/detail/platform.hpp
player_sdl.o: /usr/include/boost/config.hpp
player_sdl.o: /usr/include/boost/config/requires_threads.hpp
player_sdl.o: /usr/include/boost/thread/detail/thread.hpp
player_sdl.o: /usr/include/boost/thread/detail/config.hpp
player_sdl.o: /usr/include/boost/detail/workaround.hpp
player_sdl.o: /usr/include/boost/config/auto_link.hpp
player_sdl.o: /usr/include/boost/thread/exceptions.hpp
player_sdl.o: /usr/include/c++/4.8.2/string
player_sdl.o: /usr/include/c++/4.8.2/bits/stringfwd.h
player_sdl.o: /usr/include/c++/4.8.2/bits/memoryfwd.h
player_sdl.o: /usr/include/c++/4.8.2/bits/char_traits.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_algobase.h
player_sdl.o: /usr/include/c++/4.8.2/bits/functexcept.h
player_sdl.o: /usr/include/c++/4.8.2/bits/exception_defines.h
player_sdl.o: /usr/include/c++/4.8.2/bits/cpp_type_traits.h
player_sdl.o: /usr/include/c++/4.8.2/ext/type_traits.h
player_sdl.o: /usr/include/c++/4.8.2/ext/numeric_traits.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_pair.h
player_sdl.o: /usr/include/c++/4.8.2/bits/move.h
player_sdl.o: /usr/include/c++/4.8.2/bits/concept_check.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_types.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_funcs.h
player_sdl.o: /usr/include/c++/4.8.2/debug/debug.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_iterator.h
player_sdl.o: /usr/include/c++/4.8.2/bits/postypes.h
player_sdl.o: /usr/include/c++/4.8.2/cwchar
player_sdl.o: /usr/include/c++/4.8.2/bits/allocator.h
player_sdl.o: /usr/include/c++/4.8.2/bits/localefwd.h
player_sdl.o: /usr/include/c++/4.8.2/iosfwd /usr/include/c++/4.8.2/cctype
player_sdl.o: /usr/include/c++/4.8.2/bits/ostream_insert.h
player_sdl.o: /usr/include/c++/4.8.2/bits/cxxabi_forced.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_function.h
player_sdl.o: /usr/include/c++/4.8.2/backward/binders.h
player_sdl.o: /usr/include/c++/4.8.2/bits/range_access.h
player_sdl.o: /usr/include/c++/4.8.2/bits/basic_string.h
player_sdl.o: /usr/include/c++/4.8.2/ext/atomicity.h
player_sdl.o: /usr/include/c++/4.8.2/bits/basic_string.tcc
player_sdl.o: /usr/include/c++/4.8.2/stdexcept
player_sdl.o: /usr/include/c++/4.8.2/exception
player_sdl.o: /usr/include/c++/4.8.2/bits/atomic_lockfree_defines.h
player_sdl.o: /usr/include/boost/system/system_error.hpp
player_sdl.o: /usr/include/c++/4.8.2/cassert /usr/include/assert.h
player_sdl.o: /usr/include/boost/system/error_code.hpp
player_sdl.o: /usr/include/boost/system/config.hpp
player_sdl.o: /usr/include/boost/system/api_config.hpp
player_sdl.o: /usr/include/boost/cstdint.hpp /usr/include/boost/config.hpp
player_sdl.o: /usr/include/boost/config/user.hpp
player_sdl.o: /usr/include/boost/config/select_compiler_config.hpp
player_sdl.o: /usr/include/boost/config/compiler/gcc.hpp
player_sdl.o: /usr/include/boost/config/select_platform_config.hpp
player_sdl.o: /usr/include/boost/config/platform/linux.hpp
player_sdl.o: /usr/include/boost/config/posix_features.hpp
player_sdl.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
player_sdl.o: /usr/include/bits/environments.h /usr/include/bits/confname.h
player_sdl.o: /usr/include/getopt.h /usr/include/boost/config/suffix.hpp
player_sdl.o: /usr/include/boost/assert.hpp /usr/include/c++/4.8.2/cstdlib
player_sdl.o: /usr/include/c++/4.8.2/iostream /usr/include/c++/4.8.2/ostream
player_sdl.o: /usr/include/c++/4.8.2/ios
player_sdl.o: /usr/include/c++/4.8.2/bits/ios_base.h
player_sdl.o: /usr/include/c++/4.8.2/bits/locale_classes.h
player_sdl.o: /usr/include/c++/4.8.2/bits/locale_classes.tcc
player_sdl.o: /usr/include/c++/4.8.2/streambuf
player_sdl.o: /usr/include/c++/4.8.2/bits/streambuf.tcc
player_sdl.o: /usr/include/c++/4.8.2/bits/basic_ios.h
player_sdl.o: /usr/include/c++/4.8.2/bits/locale_facets.h
player_sdl.o: /usr/include/c++/4.8.2/cwctype
player_sdl.o: /usr/include/c++/4.8.2/bits/streambuf_iterator.h
player_sdl.o: /usr/include/c++/4.8.2/bits/locale_facets.tcc
player_sdl.o: /usr/include/c++/4.8.2/bits/basic_ios.tcc
player_sdl.o: /usr/include/c++/4.8.2/bits/ostream.tcc
player_sdl.o: /usr/include/c++/4.8.2/istream
player_sdl.o: /usr/include/c++/4.8.2/bits/istream.tcc
player_sdl.o: /usr/include/boost/current_function.hpp
player_sdl.o: /usr/include/boost/operators.hpp
player_sdl.o: /usr/include/boost/iterator.hpp /usr/include/c++/4.8.2/iterator
player_sdl.o: /usr/include/c++/4.8.2/bits/stream_iterator.h
player_sdl.o: /usr/include/c++/4.8.2/cstddef
player_sdl.o: /usr/include/boost/noncopyable.hpp
player_sdl.o: /usr/include/boost/utility/enable_if.hpp
player_sdl.o: /usr/include/c++/4.8.2/functional /usr/include/boost/cerrno.hpp
player_sdl.o: /usr/include/c++/4.8.2/cerrno /usr/include/errno.h
player_sdl.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
player_sdl.o: /usr/include/asm/errno.h /usr/include/asm-generic/errno.h
player_sdl.o: /usr/include/asm-generic/errno-base.h
player_sdl.o: /usr/include/boost/config/abi_prefix.hpp
player_sdl.o: /usr/include/boost/config/abi_suffix.hpp
player_sdl.o: /usr/include/boost/thread/detail/move.hpp
player_sdl.o: /usr/include/boost/type_traits/is_convertible.hpp
player_sdl.o: /usr/include/boost/type_traits/intrinsics.hpp
player_sdl.o: /usr/include/boost/type_traits/config.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
player_sdl.o: /usr/include/boost/type_traits/is_array.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
player_sdl.o: /usr/include/boost/mpl/int.hpp
player_sdl.o: /usr/include/boost/mpl/int_fwd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/adl.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/intel.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
player_sdl.o: /usr/include/boost/preprocessor/cat.hpp
player_sdl.o: /usr/include/boost/preprocessor/config/config.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
player_sdl.o: /usr/include/boost/mpl/integral_c_tag.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/static_cast.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
player_sdl.o: /usr/include/boost/preprocessor/comma_if.hpp
player_sdl.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
player_sdl.o: /usr/include/boost/preprocessor/control/if.hpp
player_sdl.o: /usr/include/boost/preprocessor/control/iif.hpp
player_sdl.o: /usr/include/boost/preprocessor/logical/bool.hpp
player_sdl.o: /usr/include/boost/preprocessor/facilities/empty.hpp
player_sdl.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
player_sdl.o: /usr/include/boost/preprocessor/repeat.hpp
player_sdl.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
player_sdl.o: /usr/include/boost/preprocessor/debug/error.hpp
player_sdl.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
player_sdl.o: /usr/include/boost/preprocessor/tuple/eat.hpp
player_sdl.o: /usr/include/boost/preprocessor/inc.hpp
player_sdl.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
player_sdl.o: /usr/include/boost/type_traits/integral_constant.hpp
player_sdl.o: /usr/include/boost/mpl/bool.hpp
player_sdl.o: /usr/include/boost/mpl/bool_fwd.hpp
player_sdl.o: /usr/include/boost/mpl/integral_c.hpp
player_sdl.o: /usr/include/boost/mpl/integral_c_fwd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/yes_no.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
player_sdl.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
player_sdl.o: /usr/include/boost/preprocessor/facilities/overload.hpp
player_sdl.o: /usr/include/boost/preprocessor/variadic/size.hpp
player_sdl.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
player_sdl.o: /usr/include/boost/preprocessor/list/adt.hpp
player_sdl.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
player_sdl.o: /usr/include/boost/preprocessor/detail/check.hpp
player_sdl.o: /usr/include/boost/preprocessor/logical/compl.hpp
player_sdl.o: /usr/include/boost/preprocessor/repetition/for.hpp
player_sdl.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
player_sdl.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
player_sdl.o: /usr/include/boost/preprocessor/tuple/elem.hpp
player_sdl.o: /usr/include/boost/preprocessor/tuple/rem.hpp
player_sdl.o: /usr/include/boost/preprocessor/variadic/elem.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
player_sdl.o: /usr/include/boost/type_traits/ice.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/ice_or.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/ice_and.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/ice_not.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
player_sdl.o: /usr/include/boost/type_traits/is_arithmetic.hpp
player_sdl.o: /usr/include/boost/type_traits/is_integral.hpp
player_sdl.o: /usr/include/boost/type_traits/is_float.hpp
player_sdl.o: /usr/include/boost/type_traits/is_void.hpp
player_sdl.o: /usr/include/boost/type_traits/is_abstract.hpp
player_sdl.o: /usr/include/boost/static_assert.hpp
player_sdl.o: /usr/include/boost/type_traits/is_class.hpp
player_sdl.o: /usr/include/boost/type_traits/is_union.hpp
player_sdl.o: /usr/include/boost/type_traits/remove_cv.hpp
player_sdl.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
player_sdl.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
player_sdl.o: /usr/include/boost/type_traits/add_reference.hpp
player_sdl.o: /usr/include/boost/type_traits/is_reference.hpp
player_sdl.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
player_sdl.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
player_sdl.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
player_sdl.o: /usr/include/boost/type_traits/is_function.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/false_result.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
player_sdl.o: /usr/include/boost/type_traits/remove_reference.hpp
player_sdl.o: /usr/include/boost/type_traits/decay.hpp
player_sdl.o: /usr/include/boost/type_traits/remove_bounds.hpp
player_sdl.o: /usr/include/boost/type_traits/add_pointer.hpp
player_sdl.o: /usr/include/boost/mpl/eval_if.hpp
player_sdl.o: /usr/include/boost/mpl/if.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/value_wknd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/integral.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/eti.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/na_spec.hpp
player_sdl.o: /usr/include/boost/mpl/lambda_fwd.hpp
player_sdl.o: /usr/include/boost/mpl/void_fwd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/na.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/arity.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/dtp.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/preprocessor/def_params_tail.hpp
player_sdl.o: /usr/include/boost/mpl/limits/arity.hpp
player_sdl.o: /usr/include/boost/preprocessor/logical/and.hpp
player_sdl.o: /usr/include/boost/preprocessor/logical/bitand.hpp
player_sdl.o: /usr/include/boost/preprocessor/identity.hpp
player_sdl.o: /usr/include/boost/preprocessor/facilities/identity.hpp
player_sdl.o: /usr/include/boost/preprocessor/empty.hpp
player_sdl.o: /usr/include/boost/preprocessor/arithmetic/add.hpp
player_sdl.o: /usr/include/boost/preprocessor/arithmetic/dec.hpp
player_sdl.o: /usr/include/boost/preprocessor/control/while.hpp
player_sdl.o: /usr/include/boost/preprocessor/list/fold_left.hpp
player_sdl.o: /usr/include/boost/preprocessor/list/detail/fold_left.hpp
player_sdl.o: /usr/include/boost/preprocessor/list/fold_right.hpp
player_sdl.o: /usr/include/boost/preprocessor/list/detail/fold_right.hpp
player_sdl.o: /usr/include/boost/preprocessor/list/reverse.hpp
player_sdl.o: /usr/include/boost/preprocessor/control/detail/while.hpp
player_sdl.o: /usr/include/boost/preprocessor/arithmetic/sub.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/lambda_arity_param.hpp
player_sdl.o: /usr/include/boost/mpl/identity.hpp
player_sdl.o: /usr/include/boost/thread/detail/delete.hpp
player_sdl.o: /usr/include/boost/move/utility.hpp
player_sdl.o: /usr/include/boost/move/detail/config_begin.hpp
player_sdl.o: /usr/include/boost/move/core.hpp
player_sdl.o: /usr/include/boost/move/detail/meta_utils.hpp
player_sdl.o: /usr/include/boost/move/detail/config_end.hpp
player_sdl.o: /usr/include/boost/move/traits.hpp
player_sdl.o: /usr/include/boost/type_traits/has_trivial_destructor.hpp
player_sdl.o: /usr/include/boost/type_traits/is_pod.hpp
player_sdl.o: /usr/include/boost/type_traits/is_scalar.hpp
player_sdl.o: /usr/include/boost/type_traits/is_enum.hpp
player_sdl.o: /usr/include/boost/type_traits/is_pointer.hpp
player_sdl.o: /usr/include/boost/type_traits/is_member_pointer.hpp
player_sdl.o: /usr/include/boost/type_traits/is_member_function_pointer.hpp
player_sdl.o: /usr/include/boost/type_traits/detail/is_mem_fun_pointer_impl.hpp
player_sdl.o: /usr/include/boost/type_traits/is_nothrow_move_constructible.hpp
player_sdl.o: /usr/include/boost/type_traits/has_trivial_move_constructor.hpp
player_sdl.o: /usr/include/boost/type_traits/is_volatile.hpp
player_sdl.o: /usr/include/boost/type_traits/has_nothrow_copy.hpp
player_sdl.o: /usr/include/boost/type_traits/has_trivial_copy.hpp
player_sdl.o: /usr/include/boost/utility/declval.hpp
player_sdl.o: /usr/include/boost/type_traits/is_nothrow_move_assignable.hpp
player_sdl.o: /usr/include/boost/type_traits/has_trivial_move_assign.hpp
player_sdl.o: /usr/include/boost/type_traits/is_const.hpp
player_sdl.o: /usr/include/boost/type_traits/has_nothrow_assign.hpp
player_sdl.o: /usr/include/boost/type_traits/has_trivial_assign.hpp
player_sdl.o: /usr/include/boost/thread/mutex.hpp
player_sdl.o: /usr/include/boost/thread/lockable_traits.hpp
player_sdl.o: /usr/include/boost/thread/xtime.hpp
player_sdl.o: /usr/include/boost/thread/thread_time.hpp
player_sdl.o: /usr/include/boost/date_time/time_clock.hpp
player_sdl.o: /usr/include/boost/date_time/c_time.hpp
player_sdl.o: /usr/include/c++/4.8.2/ctime
player_sdl.o: /usr/include/boost/throw_exception.hpp
player_sdl.o: /usr/include/boost/exception/detail/attribute_noreturn.hpp
player_sdl.o: /usr/include/boost/date_time/compiler_config.hpp
player_sdl.o: /usr/include/boost/date_time/locale_config.hpp
player_sdl.o: /usr/include/sys/time.h /usr/include/boost/shared_ptr.hpp
player_sdl.o: /usr/include/boost/smart_ptr/shared_ptr.hpp
player_sdl.o: /usr/include/boost/config/no_tr1/memory.hpp
player_sdl.o: /usr/include/c++/4.8.2/memory
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_construct.h
player_sdl.o: /usr/include/c++/4.8.2/new
player_sdl.o: /usr/include/c++/4.8.2/ext/alloc_traits.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_uninitialized.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_tempbuf.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_raw_storage_iter.h
player_sdl.o: /usr/include/c++/4.8.2/backward/auto_ptr.h
player_sdl.o: /usr/include/boost/checked_delete.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/shared_count.hpp
player_sdl.o: /usr/include/boost/smart_ptr/bad_weak_ptr.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/sp_counted_base.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/sp_has_sync.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/sp_counted_base_gcc_x86.hpp
player_sdl.o: /usr/include/boost/detail/sp_typeinfo.hpp
player_sdl.o: /usr/include/c++/4.8.2/typeinfo
player_sdl.o: /usr/include/boost/smart_ptr/detail/sp_counted_impl.hpp
player_sdl.o: /usr/include/boost/utility/addressof.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/sp_convertible.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/sp_nullptr_t.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/spinlock_pool.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/spinlock.hpp
player_sdl.o: /usr/include/boost/smart_ptr/detail/spinlock_pt.hpp
player_sdl.o: /usr/include/pthread.h /usr/include/sched.h
player_sdl.o: /usr/include/bits/sched.h /usr/include/bits/setjmp.h
player_sdl.o: /usr/include/boost/memory_order.hpp
player_sdl.o: /usr/include/c++/4.8.2/algorithm /usr/include/c++/4.8.2/utility
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_relops.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_algo.h
player_sdl.o: /usr/include/c++/4.8.2/bits/algorithmfwd.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_heap.h
player_sdl.o: /usr/include/boost/smart_ptr/detail/operator_bool.hpp
player_sdl.o: /usr/include/boost/date_time/microsec_time_clock.hpp
player_sdl.o: /usr/include/boost/date_time/filetime_functions.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/posix_time_types.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/ptime.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/posix_time_system.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/posix_time_config.hpp
player_sdl.o: /usr/include/boost/limits.hpp /usr/include/c++/4.8.2/limits
player_sdl.o: /usr/include/boost/config/no_tr1/cmath.hpp
player_sdl.o: /usr/include/c++/4.8.2/cmath
player_sdl.o: /usr/include/boost/date_time/time_duration.hpp
player_sdl.o: /usr/include/boost/date_time/time_defs.hpp
player_sdl.o: /usr/include/boost/date_time/special_defs.hpp
player_sdl.o: /usr/include/boost/date_time/time_resolution_traits.hpp
player_sdl.o: /usr/include/boost/date_time/int_adapter.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/gregorian_types.hpp
player_sdl.o: /usr/include/boost/date_time/date.hpp
player_sdl.o: /usr/include/boost/date_time/year_month_day.hpp
player_sdl.o: /usr/include/boost/date_time/period.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_calendar.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_weekday.hpp
player_sdl.o: /usr/include/boost/date_time/constrained_value.hpp
player_sdl.o: /usr/include/boost/type_traits/is_base_of.hpp
player_sdl.o: /usr/include/boost/type_traits/is_base_and_derived.hpp
player_sdl.o: /usr/include/boost/type_traits/is_same.hpp
player_sdl.o: /usr/include/boost/date_time/date_defs.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_day_of_year.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian_calendar.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian_calendar.ipp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_ymd.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_day.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_year.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_month.hpp
player_sdl.o: /usr/include/c++/4.8.2/map
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_tree.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_map.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_multimap.h
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_duration.hpp
player_sdl.o: /usr/include/boost/date_time/date_duration.hpp
player_sdl.o: /usr/include/boost/date_time/date_duration_types.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_duration_types.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/greg_date.hpp
player_sdl.o: /usr/include/boost/date_time/adjust_functors.hpp
player_sdl.o: /usr/include/boost/date_time/wrapping_int.hpp
player_sdl.o: /usr/include/boost/date_time/date_generators.hpp
player_sdl.o: /usr/include/c++/4.8.2/sstream
player_sdl.o: /usr/include/c++/4.8.2/bits/sstream.tcc
player_sdl.o: /usr/include/boost/date_time/date_clock_device.hpp
player_sdl.o: /usr/include/boost/date_time/date_iterator.hpp
player_sdl.o: /usr/include/boost/date_time/time_system_split.hpp
player_sdl.o: /usr/include/boost/date_time/time_system_counted.hpp
player_sdl.o: /usr/include/boost/date_time/time.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/date_duration_operators.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/posix_time_duration.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/time_period.hpp
player_sdl.o: /usr/include/boost/date_time/time_iterator.hpp
player_sdl.o: /usr/include/boost/date_time/dst_rules.hpp
player_sdl.o: /usr/include/boost/date_time/posix_time/conversion.hpp
player_sdl.o: /usr/include/boost/date_time/gregorian/conversion.hpp
player_sdl.o: /usr/include/boost/thread/detail/thread_heap_alloc.hpp
player_sdl.o: /usr/include/boost/thread/detail/make_tuple_indices.hpp
player_sdl.o: /usr/include/boost/thread/detail/invoke.hpp
player_sdl.o: /usr/include/boost/thread/detail/is_convertible.hpp
player_sdl.o: /usr/include/c++/4.8.2/list
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_list.h
player_sdl.o: /usr/include/c++/4.8.2/bits/list.tcc /usr/include/boost/ref.hpp
player_sdl.o: /usr/include/boost/bind.hpp /usr/include/boost/bind/bind.hpp
player_sdl.o: /usr/include/boost/mem_fn.hpp
player_sdl.o: /usr/include/boost/bind/mem_fn.hpp
player_sdl.o: /usr/include/boost/get_pointer.hpp
player_sdl.o: /usr/include/boost/bind/mem_fn_template.hpp
player_sdl.o: /usr/include/boost/bind/mem_fn_cc.hpp
player_sdl.o: /usr/include/boost/type.hpp
player_sdl.o: /usr/include/boost/is_placeholder.hpp
player_sdl.o: /usr/include/boost/bind/arg.hpp
player_sdl.o: /usr/include/boost/visit_each.hpp
player_sdl.o: /usr/include/boost/bind/storage.hpp
player_sdl.o: /usr/include/boost/bind/bind_template.hpp
player_sdl.o: /usr/include/boost/bind/bind_cc.hpp
player_sdl.o: /usr/include/boost/bind/bind_mf_cc.hpp
player_sdl.o: /usr/include/boost/bind/bind_mf2_cc.hpp
player_sdl.o: /usr/include/boost/bind/placeholders.hpp
player_sdl.o: /usr/include/boost/io/ios_state.hpp
player_sdl.o: /usr/include/boost/io_fwd.hpp /usr/include/c++/4.8.2/locale
player_sdl.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.h
player_sdl.o: /usr/include/c++/4.8.2/bits/codecvt.h
player_sdl.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.tcc
player_sdl.o: /usr/include/boost/functional/hash.hpp
player_sdl.o: /usr/include/boost/functional/hash/hash.hpp
player_sdl.o: /usr/include/boost/functional/hash/hash_fwd.hpp
player_sdl.o: /usr/include/boost/functional/hash/detail/hash_float.hpp
player_sdl.o: /usr/include/boost/functional/hash/detail/float_functions.hpp
player_sdl.o: /usr/include/boost/functional/hash/detail/limits.hpp
player_sdl.o: /usr/include/boost/integer/static_log2.hpp
player_sdl.o: /usr/include/boost/integer_fwd.hpp
player_sdl.o: /usr/include/c++/4.8.2/climits /usr/include/limits.h
player_sdl.o: /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h
player_sdl.o: /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h
player_sdl.o: /usr/include/c++/4.8.2/typeindex
player_sdl.o: /usr/include/c++/4.8.2/bits/c++0x_warning.h
player_sdl.o: /usr/include/boost/functional/hash/extensions.hpp
player_sdl.o: /usr/include/boost/detail/container_fwd.hpp
player_sdl.o: /usr/include/c++/4.8.2/deque
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_deque.h
player_sdl.o: /usr/include/c++/4.8.2/bits/deque.tcc
player_sdl.o: /usr/include/c++/4.8.2/vector
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_vector.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_bvector.h
player_sdl.o: /usr/include/c++/4.8.2/bits/vector.tcc
player_sdl.o: /usr/include/c++/4.8.2/set
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_set.h
player_sdl.o: /usr/include/c++/4.8.2/bits/stl_multiset.h
player_sdl.o: /usr/include/c++/4.8.2/bitset /usr/include/c++/4.8.2/complex
player_sdl.o: /usr/include/boost/preprocessor/repetition/repeat_from_to.hpp
player_sdl.o: /usr/include/boost/preprocessor/repetition/enum_params.hpp
player_sdl.o: /usr/include/c++/4.8.2/array /usr/include/c++/4.8.2/tuple
player_sdl.o: /usr/include/boost/chrono/system_clocks.hpp
player_sdl.o: /usr/include/boost/chrono/config.hpp
player_sdl.o: /usr/include/boost/chrono/duration.hpp
player_sdl.o: /usr/include/boost/chrono/detail/static_assert.hpp
player_sdl.o: /usr/include/boost/mpl/logical.hpp
player_sdl.o: /usr/include/boost/mpl/or.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/use_preprocessed.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/nested_type_wknd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/compiler.hpp
player_sdl.o: /usr/include/boost/preprocessor/stringize.hpp
player_sdl.o: /usr/include/boost/mpl/and.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
player_sdl.o: /usr/include/boost/mpl/not.hpp
player_sdl.o: /usr/include/boost/ratio/ratio.hpp
player_sdl.o: /usr/include/boost/ratio/config.hpp
player_sdl.o: /usr/include/boost/ratio/detail/mpl/abs.hpp
player_sdl.o: /usr/include/boost/ratio/detail/mpl/sign.hpp
player_sdl.o: /usr/include/boost/ratio/detail/mpl/gcd.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/largest_int.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/dependent_nttp.hpp
player_sdl.o: /usr/include/boost/ratio/detail/mpl/lcm.hpp
player_sdl.o: /usr/include/boost/integer_traits.hpp
player_sdl.o: /usr/include/boost/ratio/ratio_fwd.hpp
player_sdl.o: /usr/include/boost/ratio/detail/overflow_helpers.hpp
player_sdl.o: /usr/include/boost/type_traits/common_type.hpp
player_sdl.o: /usr/include/boost/typeof/typeof.hpp
player_sdl.o: /usr/include/boost/typeof/message.hpp
player_sdl.o: /usr/include/boost/typeof/native.hpp
player_sdl.o: /usr/include/boost/type_traits/is_floating_point.hpp
player_sdl.o: /usr/include/boost/type_traits/is_unsigned.hpp
player_sdl.o: /usr/include/boost/chrono/detail/is_evenly_divisible_by.hpp
player_sdl.o: /usr/include/boost/chrono/time_point.hpp
player_sdl.o: /usr/include/boost/chrono/detail/system.hpp
player_sdl.o: /usr/include/boost/version.hpp
player_sdl.o: /usr/include/boost/chrono/clock_string.hpp
player_sdl.o: /usr/include/boost/chrono/ceil.hpp
player_sdl.o: /usr/include/boost/thread/detail/thread_interruption.hpp
player_sdl.o: /usr/include/boost/thread/v2/thread.hpp
player_sdl.o: /usr/include/boost/thread/condition_variable.hpp
player_sdl.o: /usr/include/boost/thread/lock_types.hpp
player_sdl.o: /usr/include/boost/thread/lock_options.hpp
player_sdl.o: /usr/include/boost/thread/detail/thread_group.hpp
player_sdl.o: /usr/include/boost/thread/shared_mutex.hpp
player_sdl.o: /usr/include/boost/thread/lock_guard.hpp
player_sdl.o: /usr/include/boost/thread/detail/lockable_wrapper.hpp
player_sdl.o: /usr/include/c++/4.8.2/initializer_list
player_sdl.o: /usr/include/boost/thread/once.hpp
player_sdl.o: /usr/include/boost/thread/recursive_mutex.hpp
player_sdl.o: /usr/include/boost/thread/tss.hpp
player_sdl.o: /usr/include/boost/thread/locks.hpp
player_sdl.o: /usr/include/boost/thread/lock_algorithms.hpp
player_sdl.o: /usr/include/boost/thread/barrier.hpp
player_sdl.o: /usr/include/boost/utility/result_of.hpp
player_sdl.o: /usr/include/boost/preprocessor/iteration/iterate.hpp
player_sdl.o: /usr/include/boost/preprocessor/array/elem.hpp
player_sdl.o: /usr/include/boost/preprocessor/array/data.hpp
player_sdl.o: /usr/include/boost/preprocessor/array/size.hpp
player_sdl.o: /usr/include/boost/preprocessor/slot/slot.hpp
player_sdl.o: /usr/include/boost/preprocessor/slot/detail/def.hpp
player_sdl.o: /usr/include/boost/preprocessor/repetition/enum_trailing_params.hpp
player_sdl.o: /usr/include/boost/preprocessor/repetition/enum_binary_params.hpp
player_sdl.o: /usr/include/boost/preprocessor/repetition/enum_shifted_params.hpp
player_sdl.o: /usr/include/boost/preprocessor/facilities/intercept.hpp
player_sdl.o: /usr/include/boost/mpl/has_xxx.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/type_wrapper.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/has_xxx.hpp
player_sdl.o: /usr/include/boost/mpl/aux_/config/msvc_typename.hpp
player_sdl.o: /usr/include/boost/thread/future.hpp
player_sdl.o: /usr/include/boost/atomic.hpp
player_sdl.o: /usr/include/boost/atomic/atomic.hpp
player_sdl.o: /usr/include/boost/atomic/detail/config.hpp
player_sdl.o: /usr/include/boost/atomic/detail/platform.hpp
player_sdl.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
player_sdl.o: /usr/include/boost/atomic/detail/base.hpp
player_sdl.o: /usr/include/boost/atomic/detail/lockpool.hpp
player_sdl.o: /usr/include/boost/atomic/detail/link.hpp
player_sdl.o: /usr/include/boost/atomic/detail/cas64strong.hpp
player_sdl.o: /usr/include/boost/atomic/detail/type-classification.hpp
player_sdl.o: /usr/include/boost/type_traits/is_signed.hpp chunk.h
player_sdl.o: player_sdl.h player.h sf.h channelmap.h
playlist.o: /usr/include/c++/4.8.2/fstream /usr/include/c++/4.8.2/istream
playlist.o: /usr/include/c++/4.8.2/ios /usr/include/c++/4.8.2/iosfwd
playlist.o: /usr/include/c++/4.8.2/bits/stringfwd.h
playlist.o: /usr/include/c++/4.8.2/bits/memoryfwd.h
playlist.o: /usr/include/c++/4.8.2/bits/postypes.h
playlist.o: /usr/include/c++/4.8.2/cwchar /usr/include/c++/4.8.2/exception
playlist.o: /usr/include/c++/4.8.2/bits/atomic_lockfree_defines.h
playlist.o: /usr/include/c++/4.8.2/bits/char_traits.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_algobase.h
playlist.o: /usr/include/c++/4.8.2/bits/functexcept.h
playlist.o: /usr/include/c++/4.8.2/bits/exception_defines.h
playlist.o: /usr/include/c++/4.8.2/bits/cpp_type_traits.h
playlist.o: /usr/include/c++/4.8.2/ext/type_traits.h
playlist.o: /usr/include/c++/4.8.2/ext/numeric_traits.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_pair.h
playlist.o: /usr/include/c++/4.8.2/bits/move.h
playlist.o: /usr/include/c++/4.8.2/bits/concept_check.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_types.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_funcs.h
playlist.o: /usr/include/c++/4.8.2/debug/debug.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_iterator.h
playlist.o: /usr/include/c++/4.8.2/bits/localefwd.h
playlist.o: /usr/include/c++/4.8.2/cctype /usr/include/ctype.h
playlist.o: /usr/include/features.h /usr/include/stdc-predef.h
playlist.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
playlist.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
playlist.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
playlist.o: /usr/include/endian.h /usr/include/bits/endian.h
playlist.o: /usr/include/bits/byteswap.h /usr/include/bits/byteswap-16.h
playlist.o: /usr/include/xlocale.h /usr/include/c++/4.8.2/bits/ios_base.h
playlist.o: /usr/include/c++/4.8.2/ext/atomicity.h
playlist.o: /usr/include/c++/4.8.2/bits/locale_classes.h
playlist.o: /usr/include/c++/4.8.2/string
playlist.o: /usr/include/c++/4.8.2/bits/allocator.h
playlist.o: /usr/include/c++/4.8.2/bits/ostream_insert.h
playlist.o: /usr/include/c++/4.8.2/bits/cxxabi_forced.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_function.h
playlist.o: /usr/include/c++/4.8.2/backward/binders.h
playlist.o: /usr/include/c++/4.8.2/bits/range_access.h
playlist.o: /usr/include/c++/4.8.2/bits/basic_string.h
playlist.o: /usr/include/c++/4.8.2/bits/basic_string.tcc
playlist.o: /usr/include/c++/4.8.2/bits/locale_classes.tcc
playlist.o: /usr/include/c++/4.8.2/streambuf
playlist.o: /usr/include/c++/4.8.2/bits/streambuf.tcc
playlist.o: /usr/include/c++/4.8.2/bits/basic_ios.h
playlist.o: /usr/include/c++/4.8.2/bits/locale_facets.h
playlist.o: /usr/include/c++/4.8.2/cwctype
playlist.o: /usr/include/c++/4.8.2/bits/streambuf_iterator.h
playlist.o: /usr/include/c++/4.8.2/bits/locale_facets.tcc
playlist.o: /usr/include/c++/4.8.2/bits/basic_ios.tcc
playlist.o: /usr/include/c++/4.8.2/ostream
playlist.o: /usr/include/c++/4.8.2/bits/ostream.tcc
playlist.o: /usr/include/c++/4.8.2/bits/istream.tcc
playlist.o: /usr/include/c++/4.8.2/bits/codecvt.h
playlist.o: /usr/include/c++/4.8.2/cstdio /usr/include/stdio.h
playlist.o: /usr/include/libio.h /usr/include/_G_config.h
playlist.o: /usr/include/wchar.h /usr/include/bits/stdio_lim.h
playlist.o: /usr/include/bits/sys_errlist.h
playlist.o: /usr/include/c++/4.8.2/bits/fstream.tcc pc_boost.h
playlist.o: pc_boost_monitor.h /usr/include/boost/thread.hpp
playlist.o: /usr/include/boost/thread/thread.hpp
playlist.o: /usr/include/boost/thread/thread_only.hpp
playlist.o: /usr/include/boost/thread/detail/platform.hpp
playlist.o: /usr/include/boost/config.hpp
playlist.o: /usr/include/boost/config/requires_threads.hpp
playlist.o: /usr/include/boost/thread/detail/thread.hpp
playlist.o: /usr/include/boost/thread/detail/config.hpp
playlist.o: /usr/include/boost/detail/workaround.hpp
playlist.o: /usr/include/boost/config/auto_link.hpp
playlist.o: /usr/include/boost/thread/exceptions.hpp
playlist.o: /usr/include/c++/4.8.2/stdexcept
playlist.o: /usr/include/boost/system/system_error.hpp
playlist.o: /usr/include/c++/4.8.2/cassert /usr/include/assert.h
playlist.o: /usr/include/boost/system/error_code.hpp
playlist.o: /usr/include/boost/system/config.hpp
playlist.o: /usr/include/boost/system/api_config.hpp
playlist.o: /usr/include/boost/cstdint.hpp /usr/include/boost/config.hpp
playlist.o: /usr/include/boost/config/user.hpp
playlist.o: /usr/include/boost/config/select_compiler_config.hpp
playlist.o: /usr/include/boost/config/compiler/gcc.hpp
playlist.o: /usr/include/boost/config/select_platform_config.hpp
playlist.o: /usr/include/boost/config/platform/linux.hpp
playlist.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
playlist.o: /usr/include/bits/waitstatus.h /usr/include/sys/types.h
playlist.o: /usr/include/time.h /usr/include/sys/select.h
playlist.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
playlist.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
playlist.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
playlist.o: /usr/include/bits/stdlib-float.h
playlist.o: /usr/include/boost/config/posix_features.hpp
playlist.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
playlist.o: /usr/include/bits/environments.h /usr/include/bits/confname.h
playlist.o: /usr/include/getopt.h /usr/include/boost/config/suffix.hpp
playlist.o: /usr/include/stdint.h /usr/include/bits/wchar.h
playlist.o: /usr/include/boost/assert.hpp /usr/include/c++/4.8.2/cstdlib
playlist.o: /usr/include/c++/4.8.2/iostream
playlist.o: /usr/include/boost/current_function.hpp
playlist.o: /usr/include/boost/operators.hpp /usr/include/boost/iterator.hpp
playlist.o: /usr/include/c++/4.8.2/iterator
playlist.o: /usr/include/c++/4.8.2/bits/stream_iterator.h
playlist.o: /usr/include/c++/4.8.2/cstddef /usr/include/boost/noncopyable.hpp
playlist.o: /usr/include/boost/utility/enable_if.hpp
playlist.o: /usr/include/c++/4.8.2/functional /usr/include/boost/cerrno.hpp
playlist.o: /usr/include/c++/4.8.2/cerrno /usr/include/errno.h
playlist.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
playlist.o: /usr/include/asm/errno.h /usr/include/asm-generic/errno.h
playlist.o: /usr/include/asm-generic/errno-base.h
playlist.o: /usr/include/boost/config/abi_prefix.hpp
playlist.o: /usr/include/boost/config/abi_suffix.hpp
playlist.o: /usr/include/boost/thread/detail/move.hpp
playlist.o: /usr/include/boost/type_traits/is_convertible.hpp
playlist.o: /usr/include/boost/type_traits/intrinsics.hpp
playlist.o: /usr/include/boost/type_traits/config.hpp
playlist.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
playlist.o: /usr/include/boost/type_traits/is_array.hpp
playlist.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
playlist.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
playlist.o: /usr/include/boost/mpl/int.hpp /usr/include/boost/mpl/int_fwd.hpp
playlist.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/adl.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/intel.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
playlist.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
playlist.o: /usr/include/boost/preprocessor/cat.hpp
playlist.o: /usr/include/boost/preprocessor/config/config.hpp
playlist.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
playlist.o: /usr/include/boost/mpl/integral_c_tag.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
playlist.o: /usr/include/boost/mpl/aux_/static_cast.hpp
playlist.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
playlist.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
playlist.o: /usr/include/boost/preprocessor/comma_if.hpp
playlist.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
playlist.o: /usr/include/boost/preprocessor/control/if.hpp
playlist.o: /usr/include/boost/preprocessor/control/iif.hpp
playlist.o: /usr/include/boost/preprocessor/logical/bool.hpp
playlist.o: /usr/include/boost/preprocessor/facilities/empty.hpp
playlist.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
playlist.o: /usr/include/boost/preprocessor/repeat.hpp
playlist.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
playlist.o: /usr/include/boost/preprocessor/debug/error.hpp
playlist.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
playlist.o: /usr/include/boost/preprocessor/tuple/eat.hpp
playlist.o: /usr/include/boost/preprocessor/inc.hpp
playlist.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
playlist.o: /usr/include/boost/type_traits/integral_constant.hpp
playlist.o: /usr/include/boost/mpl/bool.hpp
playlist.o: /usr/include/boost/mpl/bool_fwd.hpp
playlist.o: /usr/include/boost/mpl/integral_c.hpp
playlist.o: /usr/include/boost/mpl/integral_c_fwd.hpp
playlist.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
playlist.o: /usr/include/boost/mpl/aux_/yes_no.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
playlist.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
playlist.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
playlist.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
playlist.o: /usr/include/boost/preprocessor/facilities/overload.hpp
playlist.o: /usr/include/boost/preprocessor/variadic/size.hpp
playlist.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
playlist.o: /usr/include/boost/preprocessor/list/adt.hpp
playlist.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
playlist.o: /usr/include/boost/preprocessor/detail/check.hpp
playlist.o: /usr/include/boost/preprocessor/logical/compl.hpp
playlist.o: /usr/include/boost/preprocessor/repetition/for.hpp
playlist.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
playlist.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
playlist.o: /usr/include/boost/preprocessor/tuple/elem.hpp
playlist.o: /usr/include/boost/preprocessor/tuple/rem.hpp
playlist.o: /usr/include/boost/preprocessor/variadic/elem.hpp
playlist.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
playlist.o: /usr/include/boost/type_traits/ice.hpp
playlist.o: /usr/include/boost/type_traits/detail/ice_or.hpp
playlist.o: /usr/include/boost/type_traits/detail/ice_and.hpp
playlist.o: /usr/include/boost/type_traits/detail/ice_not.hpp
playlist.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
playlist.o: /usr/include/boost/type_traits/is_arithmetic.hpp
playlist.o: /usr/include/boost/type_traits/is_integral.hpp
playlist.o: /usr/include/boost/type_traits/is_float.hpp
playlist.o: /usr/include/boost/type_traits/is_void.hpp
playlist.o: /usr/include/boost/type_traits/is_abstract.hpp
playlist.o: /usr/include/boost/static_assert.hpp
playlist.o: /usr/include/boost/type_traits/is_class.hpp
playlist.o: /usr/include/boost/type_traits/is_union.hpp
playlist.o: /usr/include/boost/type_traits/remove_cv.hpp
playlist.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
playlist.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
playlist.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
playlist.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
playlist.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
playlist.o: /usr/include/boost/type_traits/add_reference.hpp
playlist.o: /usr/include/boost/type_traits/is_reference.hpp
playlist.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
playlist.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
playlist.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
playlist.o: /usr/include/boost/type_traits/is_function.hpp
playlist.o: /usr/include/boost/type_traits/detail/false_result.hpp
playlist.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
playlist.o: /usr/include/boost/type_traits/remove_reference.hpp
playlist.o: /usr/include/boost/type_traits/decay.hpp
playlist.o: /usr/include/boost/type_traits/remove_bounds.hpp
playlist.o: /usr/include/boost/type_traits/add_pointer.hpp
playlist.o: /usr/include/boost/mpl/eval_if.hpp /usr/include/boost/mpl/if.hpp
playlist.o: /usr/include/boost/mpl/aux_/value_wknd.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/integral.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/eti.hpp
playlist.o: /usr/include/boost/mpl/aux_/na_spec.hpp
playlist.o: /usr/include/boost/mpl/lambda_fwd.hpp
playlist.o: /usr/include/boost/mpl/void_fwd.hpp
playlist.o: /usr/include/boost/mpl/aux_/na.hpp
playlist.o: /usr/include/boost/mpl/aux_/arity.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/dtp.hpp
playlist.o: /usr/include/boost/mpl/aux_/preprocessor/def_params_tail.hpp
playlist.o: /usr/include/boost/mpl/limits/arity.hpp
playlist.o: /usr/include/boost/preprocessor/logical/and.hpp
playlist.o: /usr/include/boost/preprocessor/logical/bitand.hpp
playlist.o: /usr/include/boost/preprocessor/identity.hpp
playlist.o: /usr/include/boost/preprocessor/facilities/identity.hpp
playlist.o: /usr/include/boost/preprocessor/empty.hpp
playlist.o: /usr/include/boost/preprocessor/arithmetic/add.hpp
playlist.o: /usr/include/boost/preprocessor/arithmetic/dec.hpp
playlist.o: /usr/include/boost/preprocessor/control/while.hpp
playlist.o: /usr/include/boost/preprocessor/list/fold_left.hpp
playlist.o: /usr/include/boost/preprocessor/list/detail/fold_left.hpp
playlist.o: /usr/include/boost/preprocessor/list/fold_right.hpp
playlist.o: /usr/include/boost/preprocessor/list/detail/fold_right.hpp
playlist.o: /usr/include/boost/preprocessor/list/reverse.hpp
playlist.o: /usr/include/boost/preprocessor/control/detail/while.hpp
playlist.o: /usr/include/boost/preprocessor/arithmetic/sub.hpp
playlist.o: /usr/include/boost/mpl/aux_/lambda_arity_param.hpp
playlist.o: /usr/include/boost/mpl/identity.hpp
playlist.o: /usr/include/boost/thread/detail/delete.hpp
playlist.o: /usr/include/boost/move/utility.hpp
playlist.o: /usr/include/boost/move/detail/config_begin.hpp
playlist.o: /usr/include/boost/move/core.hpp
playlist.o: /usr/include/boost/move/detail/meta_utils.hpp
playlist.o: /usr/include/boost/move/detail/config_end.hpp
playlist.o: /usr/include/boost/move/traits.hpp
playlist.o: /usr/include/boost/type_traits/has_trivial_destructor.hpp
playlist.o: /usr/include/boost/type_traits/is_pod.hpp
playlist.o: /usr/include/boost/type_traits/is_scalar.hpp
playlist.o: /usr/include/boost/type_traits/is_enum.hpp
playlist.o: /usr/include/boost/type_traits/is_pointer.hpp
playlist.o: /usr/include/boost/type_traits/is_member_pointer.hpp
playlist.o: /usr/include/boost/type_traits/is_member_function_pointer.hpp
playlist.o: /usr/include/boost/type_traits/detail/is_mem_fun_pointer_impl.hpp
playlist.o: /usr/include/boost/type_traits/is_nothrow_move_constructible.hpp
playlist.o: /usr/include/boost/type_traits/has_trivial_move_constructor.hpp
playlist.o: /usr/include/boost/type_traits/is_volatile.hpp
playlist.o: /usr/include/boost/type_traits/has_nothrow_copy.hpp
playlist.o: /usr/include/boost/type_traits/has_trivial_copy.hpp
playlist.o: /usr/include/boost/utility/declval.hpp
playlist.o: /usr/include/boost/type_traits/is_nothrow_move_assignable.hpp
playlist.o: /usr/include/boost/type_traits/has_trivial_move_assign.hpp
playlist.o: /usr/include/boost/type_traits/is_const.hpp
playlist.o: /usr/include/boost/type_traits/has_nothrow_assign.hpp
playlist.o: /usr/include/boost/type_traits/has_trivial_assign.hpp
playlist.o: /usr/include/boost/thread/mutex.hpp
playlist.o: /usr/include/boost/thread/lockable_traits.hpp
playlist.o: /usr/include/boost/thread/xtime.hpp
playlist.o: /usr/include/boost/thread/thread_time.hpp
playlist.o: /usr/include/boost/date_time/time_clock.hpp
playlist.o: /usr/include/boost/date_time/c_time.hpp
playlist.o: /usr/include/c++/4.8.2/ctime
playlist.o: /usr/include/boost/throw_exception.hpp
playlist.o: /usr/include/boost/exception/detail/attribute_noreturn.hpp
playlist.o: /usr/include/boost/date_time/compiler_config.hpp
playlist.o: /usr/include/boost/date_time/locale_config.hpp
playlist.o: /usr/include/sys/time.h /usr/include/boost/shared_ptr.hpp
playlist.o: /usr/include/boost/smart_ptr/shared_ptr.hpp
playlist.o: /usr/include/boost/config/no_tr1/memory.hpp
playlist.o: /usr/include/c++/4.8.2/memory
playlist.o: /usr/include/c++/4.8.2/bits/stl_construct.h
playlist.o: /usr/include/c++/4.8.2/new
playlist.o: /usr/include/c++/4.8.2/ext/alloc_traits.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_uninitialized.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_tempbuf.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_raw_storage_iter.h
playlist.o: /usr/include/c++/4.8.2/backward/auto_ptr.h
playlist.o: /usr/include/boost/checked_delete.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/shared_count.hpp
playlist.o: /usr/include/boost/smart_ptr/bad_weak_ptr.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/sp_counted_base.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/sp_has_sync.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/sp_counted_base_gcc_x86.hpp
playlist.o: /usr/include/boost/detail/sp_typeinfo.hpp
playlist.o: /usr/include/c++/4.8.2/typeinfo
playlist.o: /usr/include/boost/smart_ptr/detail/sp_counted_impl.hpp
playlist.o: /usr/include/boost/utility/addressof.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/sp_convertible.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/sp_nullptr_t.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/spinlock_pool.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/spinlock.hpp
playlist.o: /usr/include/boost/smart_ptr/detail/spinlock_pt.hpp
playlist.o: /usr/include/pthread.h /usr/include/sched.h
playlist.o: /usr/include/bits/sched.h /usr/include/bits/setjmp.h
playlist.o: /usr/include/boost/memory_order.hpp
playlist.o: /usr/include/c++/4.8.2/algorithm /usr/include/c++/4.8.2/utility
playlist.o: /usr/include/c++/4.8.2/bits/stl_relops.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_algo.h
playlist.o: /usr/include/c++/4.8.2/bits/algorithmfwd.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_heap.h
playlist.o: /usr/include/boost/smart_ptr/detail/operator_bool.hpp
playlist.o: /usr/include/boost/date_time/microsec_time_clock.hpp
playlist.o: /usr/include/boost/date_time/filetime_functions.hpp
playlist.o: /usr/include/boost/date_time/posix_time/posix_time_types.hpp
playlist.o: /usr/include/boost/date_time/posix_time/ptime.hpp
playlist.o: /usr/include/boost/date_time/posix_time/posix_time_system.hpp
playlist.o: /usr/include/boost/date_time/posix_time/posix_time_config.hpp
playlist.o: /usr/include/boost/limits.hpp /usr/include/c++/4.8.2/limits
playlist.o: /usr/include/boost/config/no_tr1/cmath.hpp
playlist.o: /usr/include/c++/4.8.2/cmath /usr/include/math.h
playlist.o: /usr/include/bits/huge_val.h /usr/include/bits/huge_valf.h
playlist.o: /usr/include/bits/huge_vall.h /usr/include/bits/inf.h
playlist.o: /usr/include/bits/nan.h /usr/include/bits/mathdef.h
playlist.o: /usr/include/bits/mathcalls.h
playlist.o: /usr/include/boost/date_time/time_duration.hpp
playlist.o: /usr/include/boost/date_time/time_defs.hpp
playlist.o: /usr/include/boost/date_time/special_defs.hpp
playlist.o: /usr/include/boost/date_time/time_resolution_traits.hpp
playlist.o: /usr/include/boost/date_time/int_adapter.hpp
playlist.o: /usr/include/boost/date_time/gregorian/gregorian_types.hpp
playlist.o: /usr/include/boost/date_time/date.hpp
playlist.o: /usr/include/boost/date_time/year_month_day.hpp
playlist.o: /usr/include/boost/date_time/period.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_calendar.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_weekday.hpp
playlist.o: /usr/include/boost/date_time/constrained_value.hpp
playlist.o: /usr/include/boost/type_traits/is_base_of.hpp
playlist.o: /usr/include/boost/type_traits/is_base_and_derived.hpp
playlist.o: /usr/include/boost/type_traits/is_same.hpp
playlist.o: /usr/include/boost/date_time/date_defs.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_day_of_year.hpp
playlist.o: /usr/include/boost/date_time/gregorian_calendar.hpp
playlist.o: /usr/include/boost/date_time/gregorian_calendar.ipp
playlist.o: /usr/include/boost/date_time/gregorian/greg_ymd.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_day.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_year.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_month.hpp
playlist.o: /usr/include/c++/4.8.2/map /usr/include/c++/4.8.2/bits/stl_tree.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_map.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_multimap.h
playlist.o: /usr/include/boost/date_time/gregorian/greg_duration.hpp
playlist.o: /usr/include/boost/date_time/date_duration.hpp
playlist.o: /usr/include/boost/date_time/date_duration_types.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_duration_types.hpp
playlist.o: /usr/include/boost/date_time/gregorian/greg_date.hpp
playlist.o: /usr/include/boost/date_time/adjust_functors.hpp
playlist.o: /usr/include/boost/date_time/wrapping_int.hpp
playlist.o: /usr/include/boost/date_time/date_generators.hpp
playlist.o: /usr/include/c++/4.8.2/sstream
playlist.o: /usr/include/c++/4.8.2/bits/sstream.tcc
playlist.o: /usr/include/boost/date_time/date_clock_device.hpp
playlist.o: /usr/include/boost/date_time/date_iterator.hpp
playlist.o: /usr/include/boost/date_time/time_system_split.hpp
playlist.o: /usr/include/boost/date_time/time_system_counted.hpp
playlist.o: /usr/include/boost/date_time/time.hpp
playlist.o: /usr/include/boost/date_time/posix_time/date_duration_operators.hpp
playlist.o: /usr/include/boost/date_time/posix_time/posix_time_duration.hpp
playlist.o: /usr/include/boost/date_time/posix_time/time_period.hpp
playlist.o: /usr/include/boost/date_time/time_iterator.hpp
playlist.o: /usr/include/boost/date_time/dst_rules.hpp
playlist.o: /usr/include/boost/date_time/posix_time/conversion.hpp
playlist.o: /usr/include/c++/4.8.2/cstring /usr/include/string.h
playlist.o: /usr/include/boost/date_time/gregorian/conversion.hpp
playlist.o: /usr/include/boost/thread/detail/thread_heap_alloc.hpp
playlist.o: /usr/include/boost/thread/detail/make_tuple_indices.hpp
playlist.o: /usr/include/boost/thread/detail/invoke.hpp
playlist.o: /usr/include/boost/thread/detail/is_convertible.hpp
playlist.o: /usr/include/c++/4.8.2/list
playlist.o: /usr/include/c++/4.8.2/bits/stl_list.h
playlist.o: /usr/include/c++/4.8.2/bits/list.tcc /usr/include/boost/ref.hpp
playlist.o: /usr/include/boost/bind.hpp /usr/include/boost/bind/bind.hpp
playlist.o: /usr/include/boost/mem_fn.hpp /usr/include/boost/bind/mem_fn.hpp
playlist.o: /usr/include/boost/get_pointer.hpp
playlist.o: /usr/include/boost/bind/mem_fn_template.hpp
playlist.o: /usr/include/boost/bind/mem_fn_cc.hpp /usr/include/boost/type.hpp
playlist.o: /usr/include/boost/is_placeholder.hpp
playlist.o: /usr/include/boost/bind/arg.hpp /usr/include/boost/visit_each.hpp
playlist.o: /usr/include/boost/bind/storage.hpp
playlist.o: /usr/include/boost/bind/bind_template.hpp
playlist.o: /usr/include/boost/bind/bind_cc.hpp
playlist.o: /usr/include/boost/bind/bind_mf_cc.hpp
playlist.o: /usr/include/boost/bind/bind_mf2_cc.hpp
playlist.o: /usr/include/boost/bind/placeholders.hpp
playlist.o: /usr/include/boost/io/ios_state.hpp /usr/include/boost/io_fwd.hpp
playlist.o: /usr/include/c++/4.8.2/locale
playlist.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.h
playlist.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.tcc
playlist.o: /usr/include/boost/functional/hash.hpp
playlist.o: /usr/include/boost/functional/hash/hash.hpp
playlist.o: /usr/include/boost/functional/hash/hash_fwd.hpp
playlist.o: /usr/include/boost/functional/hash/detail/hash_float.hpp
playlist.o: /usr/include/boost/functional/hash/detail/float_functions.hpp
playlist.o: /usr/include/boost/functional/hash/detail/limits.hpp
playlist.o: /usr/include/boost/integer/static_log2.hpp
playlist.o: /usr/include/boost/integer_fwd.hpp /usr/include/c++/4.8.2/climits
playlist.o: /usr/include/limits.h /usr/include/bits/posix1_lim.h
playlist.o: /usr/include/bits/local_lim.h /usr/include/linux/limits.h
playlist.o: /usr/include/bits/posix2_lim.h /usr/include/c++/4.8.2/typeindex
playlist.o: /usr/include/c++/4.8.2/bits/c++0x_warning.h
playlist.o: /usr/include/boost/functional/hash/extensions.hpp
playlist.o: /usr/include/boost/detail/container_fwd.hpp
playlist.o: /usr/include/c++/4.8.2/deque
playlist.o: /usr/include/c++/4.8.2/bits/stl_deque.h
playlist.o: /usr/include/c++/4.8.2/bits/deque.tcc
playlist.o: /usr/include/c++/4.8.2/vector
playlist.o: /usr/include/c++/4.8.2/bits/stl_vector.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_bvector.h
playlist.o: /usr/include/c++/4.8.2/bits/vector.tcc /usr/include/c++/4.8.2/set
playlist.o: /usr/include/c++/4.8.2/bits/stl_set.h
playlist.o: /usr/include/c++/4.8.2/bits/stl_multiset.h
playlist.o: /usr/include/c++/4.8.2/bitset /usr/include/c++/4.8.2/complex
playlist.o: /usr/include/boost/preprocessor/repetition/repeat_from_to.hpp
playlist.o: /usr/include/boost/preprocessor/repetition/enum_params.hpp
playlist.o: /usr/include/c++/4.8.2/array /usr/include/c++/4.8.2/tuple
playlist.o: /usr/include/boost/chrono/system_clocks.hpp
playlist.o: /usr/include/boost/chrono/config.hpp
playlist.o: /usr/include/boost/chrono/duration.hpp
playlist.o: /usr/include/boost/chrono/detail/static_assert.hpp
playlist.o: /usr/include/boost/mpl/logical.hpp /usr/include/boost/mpl/or.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/use_preprocessed.hpp
playlist.o: /usr/include/boost/mpl/aux_/nested_type_wknd.hpp
playlist.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/compiler.hpp
playlist.o: /usr/include/boost/preprocessor/stringize.hpp
playlist.o: /usr/include/boost/mpl/and.hpp
playlist.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
playlist.o: /usr/include/boost/mpl/not.hpp /usr/include/boost/ratio/ratio.hpp
playlist.o: /usr/include/boost/ratio/config.hpp
playlist.o: /usr/include/boost/ratio/detail/mpl/abs.hpp
playlist.o: /usr/include/boost/ratio/detail/mpl/sign.hpp
playlist.o: /usr/include/boost/ratio/detail/mpl/gcd.hpp
playlist.o: /usr/include/boost/mpl/aux_/largest_int.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/dependent_nttp.hpp
playlist.o: /usr/include/boost/ratio/detail/mpl/lcm.hpp
playlist.o: /usr/include/boost/integer_traits.hpp
playlist.o: /usr/include/boost/ratio/ratio_fwd.hpp
playlist.o: /usr/include/boost/ratio/detail/overflow_helpers.hpp
playlist.o: /usr/include/boost/type_traits/common_type.hpp
playlist.o: /usr/include/boost/typeof/typeof.hpp
playlist.o: /usr/include/boost/typeof/message.hpp
playlist.o: /usr/include/boost/typeof/native.hpp
playlist.o: /usr/include/boost/type_traits/is_floating_point.hpp
playlist.o: /usr/include/boost/type_traits/is_unsigned.hpp
playlist.o: /usr/include/boost/chrono/detail/is_evenly_divisible_by.hpp
playlist.o: /usr/include/boost/chrono/time_point.hpp
playlist.o: /usr/include/boost/chrono/detail/system.hpp
playlist.o: /usr/include/boost/version.hpp
playlist.o: /usr/include/boost/chrono/clock_string.hpp
playlist.o: /usr/include/boost/chrono/ceil.hpp
playlist.o: /usr/include/boost/thread/detail/thread_interruption.hpp
playlist.o: /usr/include/boost/thread/v2/thread.hpp
playlist.o: /usr/include/boost/thread/condition_variable.hpp
playlist.o: /usr/include/boost/thread/lock_types.hpp
playlist.o: /usr/include/boost/thread/lock_options.hpp
playlist.o: /usr/include/boost/thread/detail/thread_group.hpp
playlist.o: /usr/include/boost/thread/shared_mutex.hpp
playlist.o: /usr/include/boost/thread/lock_guard.hpp
playlist.o: /usr/include/boost/thread/detail/lockable_wrapper.hpp
playlist.o: /usr/include/c++/4.8.2/initializer_list
playlist.o: /usr/include/boost/thread/once.hpp
playlist.o: /usr/include/boost/thread/recursive_mutex.hpp
playlist.o: /usr/include/boost/thread/tss.hpp
playlist.o: /usr/include/boost/thread/locks.hpp
playlist.o: /usr/include/boost/thread/lock_algorithms.hpp
playlist.o: /usr/include/boost/thread/barrier.hpp
playlist.o: /usr/include/boost/utility/result_of.hpp
playlist.o: /usr/include/boost/preprocessor/iteration/iterate.hpp
playlist.o: /usr/include/boost/preprocessor/array/elem.hpp
playlist.o: /usr/include/boost/preprocessor/array/data.hpp
playlist.o: /usr/include/boost/preprocessor/array/size.hpp
playlist.o: /usr/include/boost/preprocessor/slot/slot.hpp
playlist.o: /usr/include/boost/preprocessor/slot/detail/def.hpp
playlist.o: /usr/include/boost/preprocessor/repetition/enum_trailing_params.hpp
playlist.o: /usr/include/boost/preprocessor/repetition/enum_binary_params.hpp
playlist.o: /usr/include/boost/preprocessor/repetition/enum_shifted_params.hpp
playlist.o: /usr/include/boost/preprocessor/facilities/intercept.hpp
playlist.o: /usr/include/boost/mpl/has_xxx.hpp
playlist.o: /usr/include/boost/mpl/aux_/type_wrapper.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/has_xxx.hpp
playlist.o: /usr/include/boost/mpl/aux_/config/msvc_typename.hpp
playlist.o: /usr/include/boost/thread/future.hpp
playlist.o: /usr/include/boost/atomic.hpp
playlist.o: /usr/include/boost/atomic/atomic.hpp
playlist.o: /usr/include/boost/atomic/detail/config.hpp
playlist.o: /usr/include/boost/atomic/detail/platform.hpp
playlist.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
playlist.o: /usr/include/boost/atomic/detail/base.hpp
playlist.o: /usr/include/boost/atomic/detail/lockpool.hpp
playlist.o: /usr/include/boost/atomic/detail/link.hpp
playlist.o: /usr/include/boost/atomic/detail/cas64strong.hpp
playlist.o: /usr/include/boost/atomic/detail/type-classification.hpp
playlist.o: /usr/include/boost/type_traits/is_signed.hpp chunk.h decoder.h
playlist.o: sf.h channelmap.h player.h playlist.h trackinfo.h softvol.h
softvol.o: /usr/include/c++/4.8.2/climits /usr/include/limits.h
softvol.o: /usr/include/features.h /usr/include/stdc-predef.h
softvol.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
softvol.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
softvol.o: /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h
softvol.o: /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h utils.h
softvol.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
softvol.o: /usr/include/bits/waitstatus.h /usr/include/endian.h
softvol.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
softvol.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
softvol.o: /usr/include/bits/byteswap-16.h /usr/include/sys/types.h
softvol.o: /usr/include/time.h /usr/include/sys/select.h
softvol.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
softvol.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
softvol.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
softvol.o: /usr/include/bits/stdlib-float.h /usr/include/string.h
softvol.o: /usr/include/xlocale.h /usr/include/sys/stat.h
softvol.o: /usr/include/bits/stat.h /usr/include/unistd.h
softvol.o: /usr/include/bits/posix_opt.h /usr/include/bits/environments.h
softvol.o: /usr/include/bits/confname.h /usr/include/getopt.h
softvol.o: /usr/include/stdint.h /usr/include/bits/wchar.h sf.h compiler.h
softvol.o: softvol.h /usr/include/boost/atomic.hpp
softvol.o: /usr/include/boost/atomic/atomic.hpp
softvol.o: /usr/include/c++/4.8.2/cstddef /usr/include/boost/cstdint.hpp
softvol.o: /usr/include/boost/config.hpp /usr/include/boost/config/user.hpp
softvol.o: /usr/include/boost/config/select_compiler_config.hpp
softvol.o: /usr/include/boost/config/compiler/gcc.hpp
softvol.o: /usr/include/boost/config/select_platform_config.hpp
softvol.o: /usr/include/boost/config/platform/linux.hpp
softvol.o: /usr/include/boost/config/posix_features.hpp
softvol.o: /usr/include/boost/config/suffix.hpp
softvol.o: /usr/include/boost/memory_order.hpp
softvol.o: /usr/include/boost/atomic/detail/config.hpp
softvol.o: /usr/include/boost/config.hpp
softvol.o: /usr/include/boost/atomic/detail/platform.hpp
softvol.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
softvol.o: /usr/include/boost/atomic/detail/base.hpp
softvol.o: /usr/include/boost/atomic/detail/lockpool.hpp
softvol.o: /usr/include/boost/atomic/detail/link.hpp
softvol.o: /usr/include/boost/config/auto_link.hpp
softvol.o: /usr/include/boost/atomic/detail/cas64strong.hpp
softvol.o: /usr/include/boost/atomic/detail/type-classification.hpp
softvol.o: /usr/include/boost/type_traits/is_integral.hpp
softvol.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
softvol.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
softvol.o: /usr/include/boost/mpl/int.hpp /usr/include/boost/mpl/int_fwd.hpp
softvol.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/adl.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/intel.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
softvol.o: /usr/include/boost/detail/workaround.hpp
softvol.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
softvol.o: /usr/include/boost/preprocessor/cat.hpp
softvol.o: /usr/include/boost/preprocessor/config/config.hpp
softvol.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
softvol.o: /usr/include/boost/mpl/integral_c_tag.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
softvol.o: /usr/include/boost/mpl/aux_/static_cast.hpp
softvol.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
softvol.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
softvol.o: /usr/include/boost/preprocessor/comma_if.hpp
softvol.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
softvol.o: /usr/include/boost/preprocessor/control/if.hpp
softvol.o: /usr/include/boost/preprocessor/control/iif.hpp
softvol.o: /usr/include/boost/preprocessor/logical/bool.hpp
softvol.o: /usr/include/boost/preprocessor/facilities/empty.hpp
softvol.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
softvol.o: /usr/include/boost/preprocessor/repeat.hpp
softvol.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
softvol.o: /usr/include/boost/preprocessor/debug/error.hpp
softvol.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
softvol.o: /usr/include/boost/preprocessor/tuple/eat.hpp
softvol.o: /usr/include/boost/preprocessor/inc.hpp
softvol.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
softvol.o: /usr/include/boost/type_traits/integral_constant.hpp
softvol.o: /usr/include/boost/mpl/bool.hpp
softvol.o: /usr/include/boost/mpl/bool_fwd.hpp
softvol.o: /usr/include/boost/mpl/integral_c.hpp
softvol.o: /usr/include/boost/mpl/integral_c_fwd.hpp
softvol.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
softvol.o: /usr/include/boost/mpl/aux_/yes_no.hpp
softvol.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
softvol.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
softvol.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
softvol.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
softvol.o: /usr/include/boost/preprocessor/facilities/overload.hpp
softvol.o: /usr/include/boost/preprocessor/variadic/size.hpp
softvol.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
softvol.o: /usr/include/boost/preprocessor/list/adt.hpp
softvol.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
softvol.o: /usr/include/boost/preprocessor/detail/check.hpp
softvol.o: /usr/include/boost/preprocessor/logical/compl.hpp
softvol.o: /usr/include/boost/preprocessor/repetition/for.hpp
softvol.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
softvol.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
softvol.o: /usr/include/boost/preprocessor/tuple/elem.hpp
softvol.o: /usr/include/boost/preprocessor/tuple/rem.hpp
softvol.o: /usr/include/boost/preprocessor/variadic/elem.hpp
softvol.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
softvol.o: /usr/include/boost/type_traits/is_signed.hpp
softvol.o: /usr/include/boost/type_traits/remove_cv.hpp
softvol.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
softvol.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
softvol.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
softvol.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
softvol.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
softvol.o: /usr/include/boost/type_traits/is_enum.hpp
softvol.o: /usr/include/boost/type_traits/intrinsics.hpp
softvol.o: /usr/include/boost/type_traits/config.hpp
softvol.o: /usr/include/boost/type_traits/add_reference.hpp
softvol.o: /usr/include/boost/type_traits/is_reference.hpp
softvol.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
softvol.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
softvol.o: /usr/include/boost/type_traits/ice.hpp
softvol.o: /usr/include/boost/type_traits/detail/ice_or.hpp
softvol.o: /usr/include/boost/type_traits/detail/ice_and.hpp
softvol.o: /usr/include/boost/type_traits/detail/ice_not.hpp
softvol.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
softvol.o: /usr/include/boost/type_traits/is_arithmetic.hpp
softvol.o: /usr/include/boost/type_traits/is_float.hpp
softvol.o: /usr/include/boost/type_traits/is_convertible.hpp
softvol.o: /usr/include/boost/type_traits/is_array.hpp
softvol.o: /usr/include/boost/type_traits/is_void.hpp
softvol.o: /usr/include/boost/type_traits/is_abstract.hpp
softvol.o: /usr/include/boost/static_assert.hpp
softvol.o: /usr/include/boost/type_traits/is_class.hpp
softvol.o: /usr/include/boost/type_traits/is_union.hpp
softvol.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
softvol.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
softvol.o: /usr/include/boost/type_traits/is_function.hpp
softvol.o: /usr/include/boost/type_traits/detail/false_result.hpp
softvol.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
trackinfo.o: /usr/include/boost/algorithm/string/predicate.hpp
trackinfo.o: /usr/include/boost/algorithm/string/config.hpp
trackinfo.o: /usr/include/boost/config.hpp
trackinfo.o: /usr/include/boost/detail/workaround.hpp
trackinfo.o: /usr/include/boost/range/begin.hpp
trackinfo.o: /usr/include/boost/range/config.hpp
trackinfo.o: /usr/include/boost/range/iterator.hpp
trackinfo.o: /usr/include/boost/range/mutable_iterator.hpp
trackinfo.o: /usr/include/boost/range/detail/extract_optional_type.hpp
trackinfo.o: /usr/include/boost/iterator/iterator_traits.hpp
trackinfo.o: /usr/include/boost/detail/iterator.hpp
trackinfo.o: /usr/include/c++/4.8.2/iterator
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_types.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_funcs.h
trackinfo.o: /usr/include/c++/4.8.2/bits/concept_check.h
trackinfo.o: /usr/include/c++/4.8.2/debug/debug.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_iterator.h
trackinfo.o: /usr/include/c++/4.8.2/bits/cpp_type_traits.h
trackinfo.o: /usr/include/c++/4.8.2/ext/type_traits.h
trackinfo.o: /usr/include/c++/4.8.2/bits/move.h
trackinfo.o: /usr/include/c++/4.8.2/ostream /usr/include/c++/4.8.2/ios
trackinfo.o: /usr/include/c++/4.8.2/iosfwd
trackinfo.o: /usr/include/c++/4.8.2/bits/stringfwd.h
trackinfo.o: /usr/include/c++/4.8.2/bits/memoryfwd.h
trackinfo.o: /usr/include/c++/4.8.2/bits/postypes.h
trackinfo.o: /usr/include/c++/4.8.2/cwchar /usr/include/c++/4.8.2/exception
trackinfo.o: /usr/include/c++/4.8.2/bits/atomic_lockfree_defines.h
trackinfo.o: /usr/include/c++/4.8.2/bits/char_traits.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_algobase.h
trackinfo.o: /usr/include/c++/4.8.2/bits/functexcept.h
trackinfo.o: /usr/include/c++/4.8.2/bits/exception_defines.h
trackinfo.o: /usr/include/c++/4.8.2/ext/numeric_traits.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_pair.h
trackinfo.o: /usr/include/c++/4.8.2/bits/localefwd.h
trackinfo.o: /usr/include/c++/4.8.2/cctype /usr/include/ctype.h
trackinfo.o: /usr/include/features.h /usr/include/stdc-predef.h
trackinfo.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
trackinfo.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
trackinfo.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
trackinfo.o: /usr/include/endian.h /usr/include/bits/endian.h
trackinfo.o: /usr/include/bits/byteswap.h /usr/include/bits/byteswap-16.h
trackinfo.o: /usr/include/xlocale.h /usr/include/c++/4.8.2/bits/ios_base.h
trackinfo.o: /usr/include/c++/4.8.2/ext/atomicity.h
trackinfo.o: /usr/include/c++/4.8.2/bits/locale_classes.h
trackinfo.o: /usr/include/c++/4.8.2/string
trackinfo.o: /usr/include/c++/4.8.2/bits/allocator.h
trackinfo.o: /usr/include/c++/4.8.2/bits/ostream_insert.h
trackinfo.o: /usr/include/c++/4.8.2/bits/cxxabi_forced.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_function.h
trackinfo.o: /usr/include/c++/4.8.2/backward/binders.h
trackinfo.o: /usr/include/c++/4.8.2/bits/range_access.h
trackinfo.o: /usr/include/c++/4.8.2/bits/basic_string.h
trackinfo.o: /usr/include/c++/4.8.2/bits/basic_string.tcc
trackinfo.o: /usr/include/c++/4.8.2/bits/locale_classes.tcc
trackinfo.o: /usr/include/c++/4.8.2/streambuf
trackinfo.o: /usr/include/c++/4.8.2/bits/streambuf.tcc
trackinfo.o: /usr/include/c++/4.8.2/bits/basic_ios.h
trackinfo.o: /usr/include/c++/4.8.2/bits/locale_facets.h
trackinfo.o: /usr/include/c++/4.8.2/cwctype
trackinfo.o: /usr/include/c++/4.8.2/bits/streambuf_iterator.h
trackinfo.o: /usr/include/c++/4.8.2/bits/locale_facets.tcc
trackinfo.o: /usr/include/c++/4.8.2/bits/basic_ios.tcc
trackinfo.o: /usr/include/c++/4.8.2/bits/ostream.tcc
trackinfo.o: /usr/include/c++/4.8.2/istream
trackinfo.o: /usr/include/c++/4.8.2/bits/istream.tcc
trackinfo.o: /usr/include/c++/4.8.2/bits/stream_iterator.h
trackinfo.o: /usr/include/c++/4.8.2/cstddef /usr/include/c++/4.8.2/utility
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_relops.h
trackinfo.o: /usr/include/boost/range/const_iterator.hpp
trackinfo.o: /usr/include/boost/type_traits/remove_const.hpp
trackinfo.o: /usr/include/boost/type_traits/is_volatile.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
trackinfo.o: /usr/include/boost/mpl/int.hpp
trackinfo.o: /usr/include/boost/mpl/int_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/adl.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/intel.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
trackinfo.o: /usr/include/boost/preprocessor/cat.hpp
trackinfo.o: /usr/include/boost/preprocessor/config/config.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
trackinfo.o: /usr/include/boost/mpl/integral_c_tag.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/static_cast.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
trackinfo.o: /usr/include/boost/preprocessor/comma_if.hpp
trackinfo.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
trackinfo.o: /usr/include/boost/preprocessor/control/if.hpp
trackinfo.o: /usr/include/boost/preprocessor/control/iif.hpp
trackinfo.o: /usr/include/boost/preprocessor/logical/bool.hpp
trackinfo.o: /usr/include/boost/preprocessor/facilities/empty.hpp
trackinfo.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
trackinfo.o: /usr/include/boost/preprocessor/repeat.hpp
trackinfo.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
trackinfo.o: /usr/include/boost/preprocessor/debug/error.hpp
trackinfo.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
trackinfo.o: /usr/include/boost/preprocessor/tuple/eat.hpp
trackinfo.o: /usr/include/boost/preprocessor/inc.hpp
trackinfo.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
trackinfo.o: /usr/include/boost/type_traits/integral_constant.hpp
trackinfo.o: /usr/include/boost/mpl/bool.hpp
trackinfo.o: /usr/include/boost/mpl/bool_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/integral_c.hpp
trackinfo.o: /usr/include/boost/mpl/integral_c_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/yes_no.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
trackinfo.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
trackinfo.o: /usr/include/boost/preprocessor/facilities/overload.hpp
trackinfo.o: /usr/include/boost/preprocessor/variadic/size.hpp
trackinfo.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
trackinfo.o: /usr/include/boost/preprocessor/list/adt.hpp
trackinfo.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
trackinfo.o: /usr/include/boost/preprocessor/detail/check.hpp
trackinfo.o: /usr/include/boost/preprocessor/logical/compl.hpp
trackinfo.o: /usr/include/boost/preprocessor/repetition/for.hpp
trackinfo.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
trackinfo.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
trackinfo.o: /usr/include/boost/preprocessor/tuple/elem.hpp
trackinfo.o: /usr/include/boost/preprocessor/tuple/rem.hpp
trackinfo.o: /usr/include/boost/preprocessor/variadic/elem.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
trackinfo.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
trackinfo.o: /usr/include/boost/type_traits/is_const.hpp
trackinfo.o: /usr/include/boost/type_traits/is_reference.hpp
trackinfo.o: /usr/include/boost/type_traits/config.hpp
trackinfo.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
trackinfo.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
trackinfo.o: /usr/include/boost/type_traits/ice.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/ice_or.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/ice_and.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/ice_not.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
trackinfo.o: /usr/include/boost/mpl/eval_if.hpp /usr/include/boost/mpl/if.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/value_wknd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/integral.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/eti.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/na_spec.hpp
trackinfo.o: /usr/include/boost/mpl/lambda_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/void_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/na.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/arity.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/dtp.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/preprocessor/def_params_tail.hpp
trackinfo.o: /usr/include/boost/mpl/limits/arity.hpp
trackinfo.o: /usr/include/boost/preprocessor/logical/and.hpp
trackinfo.o: /usr/include/boost/preprocessor/logical/bitand.hpp
trackinfo.o: /usr/include/boost/preprocessor/identity.hpp
trackinfo.o: /usr/include/boost/preprocessor/facilities/identity.hpp
trackinfo.o: /usr/include/boost/preprocessor/empty.hpp
trackinfo.o: /usr/include/boost/preprocessor/arithmetic/add.hpp
trackinfo.o: /usr/include/boost/preprocessor/arithmetic/dec.hpp
trackinfo.o: /usr/include/boost/preprocessor/control/while.hpp
trackinfo.o: /usr/include/boost/preprocessor/list/fold_left.hpp
trackinfo.o: /usr/include/boost/preprocessor/list/detail/fold_left.hpp
trackinfo.o: /usr/include/boost/preprocessor/list/fold_right.hpp
trackinfo.o: /usr/include/boost/preprocessor/list/detail/fold_right.hpp
trackinfo.o: /usr/include/boost/preprocessor/list/reverse.hpp
trackinfo.o: /usr/include/boost/preprocessor/control/detail/while.hpp
trackinfo.o: /usr/include/boost/preprocessor/arithmetic/sub.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/lambda_arity_param.hpp
trackinfo.o: /usr/include/boost/range/end.hpp
trackinfo.o: /usr/include/boost/range/detail/implementation_help.hpp
trackinfo.o: /usr/include/boost/range/detail/common.hpp
trackinfo.o: /usr/include/boost/range/detail/sfinae.hpp
trackinfo.o: /usr/include/boost/type_traits/is_array.hpp
trackinfo.o: /usr/include/boost/type_traits/is_void.hpp
trackinfo.o: /usr/include/boost/type_traits/is_same.hpp /usr/include/string.h
trackinfo.o: /usr/include/wchar.h /usr/include/boost/range/as_literal.hpp
trackinfo.o: /usr/include/boost/range/iterator_range.hpp
trackinfo.o: /usr/include/boost/range/iterator_range_core.hpp
trackinfo.o: /usr/include/boost/assert.hpp /usr/include/assert.h
trackinfo.o: /usr/include/c++/4.8.2/cstdlib /usr/include/c++/4.8.2/iostream
trackinfo.o: /usr/include/boost/current_function.hpp
trackinfo.o: /usr/include/boost/iterator/iterator_facade.hpp
trackinfo.o: /usr/include/boost/iterator.hpp
trackinfo.o: /usr/include/boost/iterator/interoperable.hpp
trackinfo.o: /usr/include/boost/mpl/or.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/use_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/nested_type_wknd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/compiler.hpp
trackinfo.o: /usr/include/boost/preprocessor/stringize.hpp
trackinfo.o: /usr/include/boost/type_traits/is_convertible.hpp
trackinfo.o: /usr/include/boost/type_traits/intrinsics.hpp
trackinfo.o: /usr/include/boost/type_traits/is_arithmetic.hpp
trackinfo.o: /usr/include/boost/type_traits/is_integral.hpp
trackinfo.o: /usr/include/boost/type_traits/is_float.hpp
trackinfo.o: /usr/include/boost/type_traits/is_abstract.hpp
trackinfo.o: /usr/include/boost/static_assert.hpp
trackinfo.o: /usr/include/boost/type_traits/is_class.hpp
trackinfo.o: /usr/include/boost/type_traits/is_union.hpp
trackinfo.o: /usr/include/boost/type_traits/remove_cv.hpp
trackinfo.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
trackinfo.o: /usr/include/boost/type_traits/add_reference.hpp
trackinfo.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
trackinfo.o: /usr/include/boost/type_traits/is_function.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/false_result.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
trackinfo.o: /usr/include/boost/iterator/detail/config_def.hpp
trackinfo.o: /usr/include/boost/iterator/detail/config_undef.hpp
trackinfo.o: /usr/include/boost/iterator/detail/facade_iterator_category.hpp
trackinfo.o: /usr/include/boost/iterator/iterator_categories.hpp
trackinfo.o: /usr/include/boost/mpl/identity.hpp
trackinfo.o: /usr/include/boost/mpl/placeholders.hpp
trackinfo.o: /usr/include/boost/mpl/arg.hpp
trackinfo.o: /usr/include/boost/mpl/arg_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/na_assert.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/arity_spec.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/arg_typedef.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/and.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/assert.hpp /usr/include/boost/mpl/not.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/pp_counter.hpp
trackinfo.o: /usr/include/boost/detail/indirect_traits.hpp
trackinfo.o: /usr/include/boost/type_traits/is_pointer.hpp
trackinfo.o: /usr/include/boost/type_traits/is_member_pointer.hpp
trackinfo.o: /usr/include/boost/type_traits/is_member_function_pointer.hpp
trackinfo.o: /usr/include/boost/type_traits/detail/is_mem_fun_pointer_impl.hpp
trackinfo.o: /usr/include/boost/type_traits/remove_reference.hpp
trackinfo.o: /usr/include/boost/type_traits/remove_pointer.hpp
trackinfo.o: /usr/include/boost/iterator/detail/enable_if.hpp
trackinfo.o: /usr/include/boost/utility/addressof.hpp
trackinfo.o: /usr/include/boost/type_traits/add_const.hpp
trackinfo.o: /usr/include/boost/type_traits/add_pointer.hpp
trackinfo.o: /usr/include/boost/type_traits/is_pod.hpp
trackinfo.o: /usr/include/boost/type_traits/is_scalar.hpp
trackinfo.o: /usr/include/boost/type_traits/is_enum.hpp
trackinfo.o: /usr/include/boost/mpl/always.hpp
trackinfo.o: /usr/include/boost/mpl/apply.hpp
trackinfo.o: /usr/include/boost/mpl/apply_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/apply_wrap.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/has_apply.hpp
trackinfo.o: /usr/include/boost/mpl/has_xxx.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/type_wrapper.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/has_xxx.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/msvc_typename.hpp
trackinfo.o: /usr/include/boost/preprocessor/array/elem.hpp
trackinfo.o: /usr/include/boost/preprocessor/array/data.hpp
trackinfo.o: /usr/include/boost/preprocessor/array/size.hpp
trackinfo.o: /usr/include/boost/preprocessor/repetition/enum_params.hpp
trackinfo.o: /usr/include/boost/preprocessor/repetition/enum_trailing_params.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/has_apply.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/msvc_never_true.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/lambda.hpp
trackinfo.o: /usr/include/boost/mpl/bind.hpp
trackinfo.o: /usr/include/boost/mpl/bind_fwd.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/config/bind.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/next.hpp
trackinfo.o: /usr/include/boost/mpl/next_prior.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/common_name_wknd.hpp
trackinfo.o: /usr/include/boost/mpl/protect.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/lambda_no_ctps.hpp
trackinfo.o: /usr/include/boost/mpl/is_placeholder.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/template_arity.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/has_rebind.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
trackinfo.o: /usr/include/boost/range/functions.hpp
trackinfo.o: /usr/include/boost/range/size.hpp
trackinfo.o: /usr/include/boost/range/size_type.hpp
trackinfo.o: /usr/include/boost/range/difference_type.hpp
trackinfo.o: /usr/include/boost/utility/enable_if.hpp
trackinfo.o: /usr/include/boost/type_traits/make_unsigned.hpp
trackinfo.o: /usr/include/boost/type_traits/is_signed.hpp
trackinfo.o: /usr/include/boost/type_traits/is_unsigned.hpp
trackinfo.o: /usr/include/boost/type_traits/add_volatile.hpp
trackinfo.o: /usr/include/boost/range/distance.hpp
trackinfo.o: /usr/include/boost/range/empty.hpp
trackinfo.o: /usr/include/boost/range/rbegin.hpp
trackinfo.o: /usr/include/boost/range/reverse_iterator.hpp
trackinfo.o: /usr/include/boost/iterator/reverse_iterator.hpp
trackinfo.o: /usr/include/boost/next_prior.hpp
trackinfo.o: /usr/include/boost/iterator/iterator_adaptor.hpp
trackinfo.o: /usr/include/boost/range/rend.hpp
trackinfo.o: /usr/include/boost/range/algorithm/equal.hpp
trackinfo.o: /usr/include/boost/range/concepts.hpp
trackinfo.o: /usr/include/boost/concept_check.hpp
trackinfo.o: /usr/include/boost/concept/assert.hpp
trackinfo.o: /usr/include/boost/concept/detail/borland.hpp
trackinfo.o: /usr/include/boost/concept/detail/backward_compatibility.hpp
trackinfo.o: /usr/include/boost/type_traits/conversion_traits.hpp
trackinfo.o: /usr/include/boost/concept/usage.hpp
trackinfo.o: /usr/include/boost/concept/detail/concept_def.hpp
trackinfo.o: /usr/include/boost/preprocessor/seq/for_each_i.hpp
trackinfo.o: /usr/include/boost/preprocessor/seq/seq.hpp
trackinfo.o: /usr/include/boost/preprocessor/seq/elem.hpp
trackinfo.o: /usr/include/boost/preprocessor/seq/size.hpp
trackinfo.o: /usr/include/boost/preprocessor/seq/enum.hpp
trackinfo.o: /usr/include/boost/concept/detail/concept_undef.hpp
trackinfo.o: /usr/include/boost/iterator/iterator_concepts.hpp
trackinfo.o: /usr/include/boost/limits.hpp /usr/include/c++/4.8.2/limits
trackinfo.o: /usr/include/c++/4.8.2/algorithm
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_algo.h
trackinfo.o: /usr/include/c++/4.8.2/bits/algorithmfwd.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_heap.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_tempbuf.h
trackinfo.o: /usr/include/c++/4.8.2/bits/stl_construct.h
trackinfo.o: /usr/include/c++/4.8.2/new
trackinfo.o: /usr/include/c++/4.8.2/ext/alloc_traits.h
trackinfo.o: /usr/include/boost/range/value_type.hpp
trackinfo.o: /usr/include/boost/range/detail/misc_concept.hpp
trackinfo.o: /usr/include/boost/range/detail/safe_bool.hpp
trackinfo.o: /usr/include/boost/range/iterator_range_io.hpp
trackinfo.o: /usr/include/boost/range/detail/str_types.hpp
trackinfo.o: /usr/include/c++/4.8.2/cstring
trackinfo.o: /usr/include/boost/algorithm/string/compare.hpp
trackinfo.o: /usr/include/c++/4.8.2/locale
trackinfo.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.h
trackinfo.o: /usr/include/c++/4.8.2/ctime /usr/include/time.h
trackinfo.o: /usr/include/c++/4.8.2/bits/codecvt.h
trackinfo.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.tcc
trackinfo.o: /usr/include/boost/algorithm/string/find.hpp
trackinfo.o: /usr/include/boost/algorithm/string/finder.hpp
trackinfo.o: /usr/include/boost/algorithm/string/constants.hpp
trackinfo.o: /usr/include/boost/algorithm/string/detail/finder.hpp
trackinfo.o: /usr/include/boost/algorithm/string/detail/predicate.hpp
trackinfo.o: trackinfo.h
pc_boost_main.o: /usr/include/c++/4.8.2/cstdio /usr/include/stdio.h
pc_boost_main.o: /usr/include/features.h /usr/include/stdc-predef.h
pc_boost_main.o: /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h
pc_boost_main.o: /usr/include/gnu/stubs.h /usr/include/gnu/stubs-32.h
pc_boost_main.o: /usr/include/bits/types.h /usr/include/bits/typesizes.h
pc_boost_main.o: /usr/include/libio.h /usr/include/_G_config.h
pc_boost_main.o: /usr/include/wchar.h /usr/include/bits/stdio_lim.h
pc_boost_main.o: /usr/include/bits/sys_errlist.h /usr/include/termios.h
pc_boost_main.o: /usr/include/bits/termios.h /usr/include/sys/ttydefaults.h
pc_boost_main.o: pc_boost.h pc_boost_monitor.h /usr/include/boost/thread.hpp
pc_boost_main.o: /usr/include/boost/thread/thread.hpp
pc_boost_main.o: /usr/include/boost/thread/thread_only.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/platform.hpp
pc_boost_main.o: /usr/include/boost/config.hpp
pc_boost_main.o: /usr/include/boost/config/requires_threads.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/thread.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/config.hpp
pc_boost_main.o: /usr/include/boost/detail/workaround.hpp
pc_boost_main.o: /usr/include/boost/config/auto_link.hpp
pc_boost_main.o: /usr/include/boost/thread/exceptions.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/string
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stringfwd.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/memoryfwd.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/char_traits.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_algobase.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/functexcept.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/exception_defines.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/cpp_type_traits.h
pc_boost_main.o: /usr/include/c++/4.8.2/ext/type_traits.h
pc_boost_main.o: /usr/include/c++/4.8.2/ext/numeric_traits.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_pair.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/move.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/concept_check.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_types.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_iterator_base_funcs.h
pc_boost_main.o: /usr/include/c++/4.8.2/debug/debug.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_iterator.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/postypes.h
pc_boost_main.o: /usr/include/c++/4.8.2/cwchar
pc_boost_main.o: /usr/include/c++/4.8.2/bits/allocator.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/localefwd.h
pc_boost_main.o: /usr/include/c++/4.8.2/iosfwd /usr/include/c++/4.8.2/cctype
pc_boost_main.o: /usr/include/ctype.h /usr/include/endian.h
pc_boost_main.o: /usr/include/bits/endian.h /usr/include/bits/byteswap.h
pc_boost_main.o: /usr/include/bits/byteswap-16.h /usr/include/xlocale.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/ostream_insert.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/cxxabi_forced.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_function.h
pc_boost_main.o: /usr/include/c++/4.8.2/backward/binders.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/range_access.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/basic_string.h
pc_boost_main.o: /usr/include/c++/4.8.2/ext/atomicity.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/basic_string.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/stdexcept
pc_boost_main.o: /usr/include/c++/4.8.2/exception
pc_boost_main.o: /usr/include/c++/4.8.2/bits/atomic_lockfree_defines.h
pc_boost_main.o: /usr/include/boost/system/system_error.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/cassert /usr/include/assert.h
pc_boost_main.o: /usr/include/boost/system/error_code.hpp
pc_boost_main.o: /usr/include/boost/system/config.hpp
pc_boost_main.o: /usr/include/boost/system/api_config.hpp
pc_boost_main.o: /usr/include/boost/cstdint.hpp /usr/include/boost/config.hpp
pc_boost_main.o: /usr/include/boost/config/user.hpp
pc_boost_main.o: /usr/include/boost/config/select_compiler_config.hpp
pc_boost_main.o: /usr/include/boost/config/compiler/gcc.hpp
pc_boost_main.o: /usr/include/boost/config/select_platform_config.hpp
pc_boost_main.o: /usr/include/boost/config/platform/linux.hpp
pc_boost_main.o: /usr/include/stdlib.h /usr/include/bits/waitflags.h
pc_boost_main.o: /usr/include/bits/waitstatus.h /usr/include/sys/types.h
pc_boost_main.o: /usr/include/time.h /usr/include/sys/select.h
pc_boost_main.o: /usr/include/bits/select.h /usr/include/bits/sigset.h
pc_boost_main.o: /usr/include/bits/time.h /usr/include/sys/sysmacros.h
pc_boost_main.o: /usr/include/bits/pthreadtypes.h /usr/include/alloca.h
pc_boost_main.o: /usr/include/bits/stdlib-float.h
pc_boost_main.o: /usr/include/boost/config/posix_features.hpp
pc_boost_main.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
pc_boost_main.o: /usr/include/bits/environments.h
pc_boost_main.o: /usr/include/bits/confname.h /usr/include/getopt.h
pc_boost_main.o: /usr/include/boost/config/suffix.hpp /usr/include/stdint.h
pc_boost_main.o: /usr/include/bits/wchar.h /usr/include/boost/assert.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/cstdlib
pc_boost_main.o: /usr/include/c++/4.8.2/iostream
pc_boost_main.o: /usr/include/c++/4.8.2/ostream /usr/include/c++/4.8.2/ios
pc_boost_main.o: /usr/include/c++/4.8.2/bits/ios_base.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/locale_classes.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/locale_classes.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/streambuf
pc_boost_main.o: /usr/include/c++/4.8.2/bits/streambuf.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/bits/basic_ios.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/locale_facets.h
pc_boost_main.o: /usr/include/c++/4.8.2/cwctype
pc_boost_main.o: /usr/include/c++/4.8.2/bits/streambuf_iterator.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/locale_facets.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/bits/basic_ios.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/bits/ostream.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/istream
pc_boost_main.o: /usr/include/c++/4.8.2/bits/istream.tcc
pc_boost_main.o: /usr/include/boost/current_function.hpp
pc_boost_main.o: /usr/include/boost/operators.hpp
pc_boost_main.o: /usr/include/boost/iterator.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/iterator
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stream_iterator.h
pc_boost_main.o: /usr/include/c++/4.8.2/cstddef
pc_boost_main.o: /usr/include/boost/noncopyable.hpp
pc_boost_main.o: /usr/include/boost/utility/enable_if.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/functional
pc_boost_main.o: /usr/include/boost/cerrno.hpp /usr/include/c++/4.8.2/cerrno
pc_boost_main.o: /usr/include/errno.h /usr/include/bits/errno.h
pc_boost_main.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
pc_boost_main.o: /usr/include/asm-generic/errno.h
pc_boost_main.o: /usr/include/asm-generic/errno-base.h
pc_boost_main.o: /usr/include/boost/config/abi_prefix.hpp
pc_boost_main.o: /usr/include/boost/config/abi_suffix.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/move.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_convertible.hpp
pc_boost_main.o: /usr/include/boost/type_traits/intrinsics.hpp
pc_boost_main.o: /usr/include/boost/type_traits/config.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/yes_no_type.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_array.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/bool_trait_def.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/template_arity_spec.hpp
pc_boost_main.o: /usr/include/boost/mpl/int.hpp
pc_boost_main.o: /usr/include/boost/mpl/int_fwd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/adl_barrier.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/adl.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/msvc.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/intel.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/gcc.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/workaround.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/nttp_decl.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/nttp.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/cat.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/config/config.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/integral_wrapper.hpp
pc_boost_main.o: /usr/include/boost/mpl/integral_c_tag.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/static_constant.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/static_cast.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/template_arity_fwd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/preprocessor/params.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/preprocessor.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/comma_if.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/punctuation/comma_if.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/control/if.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/control/iif.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/logical/bool.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/facilities/empty.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/punctuation/comma.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repeat.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/repeat.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/debug/error.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/detail/auto_rec.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/tuple/eat.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/inc.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/arithmetic/inc.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/lambda.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/ttp.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/ctps.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/overload_resolution.hpp
pc_boost_main.o: /usr/include/boost/type_traits/integral_constant.hpp
pc_boost_main.o: /usr/include/boost/mpl/bool.hpp
pc_boost_main.o: /usr/include/boost/mpl/bool_fwd.hpp
pc_boost_main.o: /usr/include/boost/mpl/integral_c.hpp
pc_boost_main.o: /usr/include/boost/mpl/integral_c_fwd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/lambda_support.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/yes_no.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/arrays.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/na_fwd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/preprocessor/enum.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/tuple/to_list.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/facilities/overload.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/variadic/size.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/list/for_each_i.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/list/adt.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/detail/is_binary.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/detail/check.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/logical/compl.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/for.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/detail/for.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/control/expr_iif.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/tuple/elem.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/tuple/rem.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/variadic/elem.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/bool_trait_undef.hpp
pc_boost_main.o: /usr/include/boost/type_traits/ice.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/ice_or.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/ice_and.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/ice_not.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/ice_eq.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_arithmetic.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_integral.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_float.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_void.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_abstract.hpp
pc_boost_main.o: /usr/include/boost/static_assert.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_class.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_union.hpp
pc_boost_main.o: /usr/include/boost/type_traits/remove_cv.hpp
pc_boost_main.o: /usr/include/boost/type_traits/broken_compiler_spec.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/cv_traits_impl.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/type_trait_def.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/type_trait_undef.hpp
pc_boost_main.o: /usr/include/boost/type_traits/add_lvalue_reference.hpp
pc_boost_main.o: /usr/include/boost/type_traits/add_reference.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_reference.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_lvalue_reference.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_rvalue_reference.hpp
pc_boost_main.o: /usr/include/boost/type_traits/add_rvalue_reference.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_function.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/false_result.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/is_function_ptr_helper.hpp
pc_boost_main.o: /usr/include/boost/type_traits/remove_reference.hpp
pc_boost_main.o: /usr/include/boost/type_traits/decay.hpp
pc_boost_main.o: /usr/include/boost/type_traits/remove_bounds.hpp
pc_boost_main.o: /usr/include/boost/type_traits/add_pointer.hpp
pc_boost_main.o: /usr/include/boost/mpl/eval_if.hpp
pc_boost_main.o: /usr/include/boost/mpl/if.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/value_wknd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/integral.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/eti.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/na_spec.hpp
pc_boost_main.o: /usr/include/boost/mpl/lambda_fwd.hpp
pc_boost_main.o: /usr/include/boost/mpl/void_fwd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/na.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/arity.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/dtp.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/preprocessor/def_params_tail.hpp
pc_boost_main.o: /usr/include/boost/mpl/limits/arity.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/logical/and.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/logical/bitand.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/identity.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/facilities/identity.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/empty.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/arithmetic/add.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/arithmetic/dec.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/control/while.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/list/fold_left.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/list/detail/fold_left.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/list/fold_right.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/list/detail/fold_right.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/list/reverse.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/control/detail/while.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/arithmetic/sub.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/lambda_arity_param.hpp
pc_boost_main.o: /usr/include/boost/mpl/identity.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/delete.hpp
pc_boost_main.o: /usr/include/boost/move/utility.hpp
pc_boost_main.o: /usr/include/boost/move/detail/config_begin.hpp
pc_boost_main.o: /usr/include/boost/move/core.hpp
pc_boost_main.o: /usr/include/boost/move/detail/meta_utils.hpp
pc_boost_main.o: /usr/include/boost/move/detail/config_end.hpp
pc_boost_main.o: /usr/include/boost/move/traits.hpp
pc_boost_main.o: /usr/include/boost/type_traits/has_trivial_destructor.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_pod.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_scalar.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_enum.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_pointer.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_member_pointer.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_member_function_pointer.hpp
pc_boost_main.o: /usr/include/boost/type_traits/detail/is_mem_fun_pointer_impl.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_nothrow_move_constructible.hpp
pc_boost_main.o: /usr/include/boost/type_traits/has_trivial_move_constructor.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_volatile.hpp
pc_boost_main.o: /usr/include/boost/type_traits/has_nothrow_copy.hpp
pc_boost_main.o: /usr/include/boost/type_traits/has_trivial_copy.hpp
pc_boost_main.o: /usr/include/boost/utility/declval.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_nothrow_move_assignable.hpp
pc_boost_main.o: /usr/include/boost/type_traits/has_trivial_move_assign.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_const.hpp
pc_boost_main.o: /usr/include/boost/type_traits/has_nothrow_assign.hpp
pc_boost_main.o: /usr/include/boost/type_traits/has_trivial_assign.hpp
pc_boost_main.o: /usr/include/boost/thread/mutex.hpp
pc_boost_main.o: /usr/include/boost/thread/lockable_traits.hpp
pc_boost_main.o: /usr/include/boost/thread/xtime.hpp
pc_boost_main.o: /usr/include/boost/thread/thread_time.hpp
pc_boost_main.o: /usr/include/boost/date_time/time_clock.hpp
pc_boost_main.o: /usr/include/boost/date_time/c_time.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/ctime
pc_boost_main.o: /usr/include/boost/throw_exception.hpp
pc_boost_main.o: /usr/include/boost/exception/detail/attribute_noreturn.hpp
pc_boost_main.o: /usr/include/boost/date_time/compiler_config.hpp
pc_boost_main.o: /usr/include/boost/date_time/locale_config.hpp
pc_boost_main.o: /usr/include/sys/time.h /usr/include/boost/shared_ptr.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/shared_ptr.hpp
pc_boost_main.o: /usr/include/boost/config/no_tr1/memory.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/memory
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_construct.h
pc_boost_main.o: /usr/include/c++/4.8.2/new
pc_boost_main.o: /usr/include/c++/4.8.2/ext/alloc_traits.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_uninitialized.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_tempbuf.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_raw_storage_iter.h
pc_boost_main.o: /usr/include/c++/4.8.2/backward/auto_ptr.h
pc_boost_main.o: /usr/include/boost/checked_delete.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/shared_count.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/bad_weak_ptr.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/sp_counted_base.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/sp_has_sync.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/sp_counted_base_gcc_x86.hpp
pc_boost_main.o: /usr/include/boost/detail/sp_typeinfo.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/typeinfo
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/sp_counted_impl.hpp
pc_boost_main.o: /usr/include/boost/utility/addressof.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/sp_convertible.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/sp_nullptr_t.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/spinlock_pool.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/spinlock.hpp
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/spinlock_pt.hpp
pc_boost_main.o: /usr/include/pthread.h /usr/include/sched.h
pc_boost_main.o: /usr/include/bits/sched.h /usr/include/bits/setjmp.h
pc_boost_main.o: /usr/include/boost/memory_order.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/algorithm
pc_boost_main.o: /usr/include/c++/4.8.2/utility
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_relops.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_algo.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/algorithmfwd.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_heap.h
pc_boost_main.o: /usr/include/boost/smart_ptr/detail/operator_bool.hpp
pc_boost_main.o: /usr/include/boost/date_time/microsec_time_clock.hpp
pc_boost_main.o: /usr/include/boost/date_time/filetime_functions.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/posix_time_types.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/ptime.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/posix_time_system.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/posix_time_config.hpp
pc_boost_main.o: /usr/include/boost/limits.hpp /usr/include/c++/4.8.2/limits
pc_boost_main.o: /usr/include/boost/config/no_tr1/cmath.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/cmath /usr/include/math.h
pc_boost_main.o: /usr/include/bits/huge_val.h /usr/include/bits/huge_valf.h
pc_boost_main.o: /usr/include/bits/huge_vall.h /usr/include/bits/inf.h
pc_boost_main.o: /usr/include/bits/nan.h /usr/include/bits/mathdef.h
pc_boost_main.o: /usr/include/bits/mathcalls.h
pc_boost_main.o: /usr/include/boost/date_time/time_duration.hpp
pc_boost_main.o: /usr/include/boost/date_time/time_defs.hpp
pc_boost_main.o: /usr/include/boost/date_time/special_defs.hpp
pc_boost_main.o: /usr/include/boost/date_time/time_resolution_traits.hpp
pc_boost_main.o: /usr/include/boost/date_time/int_adapter.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/gregorian_types.hpp
pc_boost_main.o: /usr/include/boost/date_time/date.hpp
pc_boost_main.o: /usr/include/boost/date_time/year_month_day.hpp
pc_boost_main.o: /usr/include/boost/date_time/period.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_calendar.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_weekday.hpp
pc_boost_main.o: /usr/include/boost/date_time/constrained_value.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_base_of.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_base_and_derived.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_same.hpp
pc_boost_main.o: /usr/include/boost/date_time/date_defs.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_day_of_year.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian_calendar.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian_calendar.ipp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_ymd.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_day.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_year.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_month.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/map
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_tree.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_map.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_multimap.h
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_duration.hpp
pc_boost_main.o: /usr/include/boost/date_time/date_duration.hpp
pc_boost_main.o: /usr/include/boost/date_time/date_duration_types.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_duration_types.hpp
pc_boost_main.o: /usr/include/boost/date_time/gregorian/greg_date.hpp
pc_boost_main.o: /usr/include/boost/date_time/adjust_functors.hpp
pc_boost_main.o: /usr/include/boost/date_time/wrapping_int.hpp
pc_boost_main.o: /usr/include/boost/date_time/date_generators.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/sstream
pc_boost_main.o: /usr/include/c++/4.8.2/bits/sstream.tcc
pc_boost_main.o: /usr/include/boost/date_time/date_clock_device.hpp
pc_boost_main.o: /usr/include/boost/date_time/date_iterator.hpp
pc_boost_main.o: /usr/include/boost/date_time/time_system_split.hpp
pc_boost_main.o: /usr/include/boost/date_time/time_system_counted.hpp
pc_boost_main.o: /usr/include/boost/date_time/time.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/date_duration_operators.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/posix_time_duration.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/time_period.hpp
pc_boost_main.o: /usr/include/boost/date_time/time_iterator.hpp
pc_boost_main.o: /usr/include/boost/date_time/dst_rules.hpp
pc_boost_main.o: /usr/include/boost/date_time/posix_time/conversion.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/cstring /usr/include/string.h
pc_boost_main.o: /usr/include/boost/date_time/gregorian/conversion.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/thread_heap_alloc.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/make_tuple_indices.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/invoke.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/is_convertible.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/list
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_list.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/list.tcc
pc_boost_main.o: /usr/include/boost/ref.hpp /usr/include/boost/bind.hpp
pc_boost_main.o: /usr/include/boost/bind/bind.hpp
pc_boost_main.o: /usr/include/boost/mem_fn.hpp
pc_boost_main.o: /usr/include/boost/bind/mem_fn.hpp
pc_boost_main.o: /usr/include/boost/get_pointer.hpp
pc_boost_main.o: /usr/include/boost/bind/mem_fn_template.hpp
pc_boost_main.o: /usr/include/boost/bind/mem_fn_cc.hpp
pc_boost_main.o: /usr/include/boost/type.hpp
pc_boost_main.o: /usr/include/boost/is_placeholder.hpp
pc_boost_main.o: /usr/include/boost/bind/arg.hpp
pc_boost_main.o: /usr/include/boost/visit_each.hpp
pc_boost_main.o: /usr/include/boost/bind/storage.hpp
pc_boost_main.o: /usr/include/boost/bind/bind_template.hpp
pc_boost_main.o: /usr/include/boost/bind/bind_cc.hpp
pc_boost_main.o: /usr/include/boost/bind/bind_mf_cc.hpp
pc_boost_main.o: /usr/include/boost/bind/bind_mf2_cc.hpp
pc_boost_main.o: /usr/include/boost/bind/placeholders.hpp
pc_boost_main.o: /usr/include/boost/io/ios_state.hpp
pc_boost_main.o: /usr/include/boost/io_fwd.hpp /usr/include/c++/4.8.2/locale
pc_boost_main.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/codecvt.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/locale_facets_nonio.tcc
pc_boost_main.o: /usr/include/boost/functional/hash.hpp
pc_boost_main.o: /usr/include/boost/functional/hash/hash.hpp
pc_boost_main.o: /usr/include/boost/functional/hash/hash_fwd.hpp
pc_boost_main.o: /usr/include/boost/functional/hash/detail/hash_float.hpp
pc_boost_main.o: /usr/include/boost/functional/hash/detail/float_functions.hpp
pc_boost_main.o: /usr/include/boost/functional/hash/detail/limits.hpp
pc_boost_main.o: /usr/include/boost/integer/static_log2.hpp
pc_boost_main.o: /usr/include/boost/integer_fwd.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/climits /usr/include/limits.h
pc_boost_main.o: /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h
pc_boost_main.o: /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h
pc_boost_main.o: /usr/include/c++/4.8.2/typeindex
pc_boost_main.o: /usr/include/c++/4.8.2/bits/c++0x_warning.h
pc_boost_main.o: /usr/include/boost/functional/hash/extensions.hpp
pc_boost_main.o: /usr/include/boost/detail/container_fwd.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/deque
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_deque.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/deque.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/vector
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_vector.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_bvector.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/vector.tcc
pc_boost_main.o: /usr/include/c++/4.8.2/set
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_set.h
pc_boost_main.o: /usr/include/c++/4.8.2/bits/stl_multiset.h
pc_boost_main.o: /usr/include/c++/4.8.2/bitset /usr/include/c++/4.8.2/complex
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/repeat_from_to.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/enum_params.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/array /usr/include/c++/4.8.2/tuple
pc_boost_main.o: /usr/include/boost/chrono/system_clocks.hpp
pc_boost_main.o: /usr/include/boost/chrono/config.hpp
pc_boost_main.o: /usr/include/boost/chrono/duration.hpp
pc_boost_main.o: /usr/include/boost/chrono/detail/static_assert.hpp
pc_boost_main.o: /usr/include/boost/mpl/logical.hpp
pc_boost_main.o: /usr/include/boost/mpl/or.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/use_preprocessed.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/nested_type_wknd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/compiler.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/stringize.hpp
pc_boost_main.o: /usr/include/boost/mpl/and.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/include_preprocessed.hpp
pc_boost_main.o: /usr/include/boost/mpl/not.hpp
pc_boost_main.o: /usr/include/boost/ratio/ratio.hpp
pc_boost_main.o: /usr/include/boost/ratio/config.hpp
pc_boost_main.o: /usr/include/boost/ratio/detail/mpl/abs.hpp
pc_boost_main.o: /usr/include/boost/ratio/detail/mpl/sign.hpp
pc_boost_main.o: /usr/include/boost/ratio/detail/mpl/gcd.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/largest_int.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/dependent_nttp.hpp
pc_boost_main.o: /usr/include/boost/ratio/detail/mpl/lcm.hpp
pc_boost_main.o: /usr/include/boost/integer_traits.hpp
pc_boost_main.o: /usr/include/boost/ratio/ratio_fwd.hpp
pc_boost_main.o: /usr/include/boost/ratio/detail/overflow_helpers.hpp
pc_boost_main.o: /usr/include/boost/type_traits/common_type.hpp
pc_boost_main.o: /usr/include/boost/typeof/typeof.hpp
pc_boost_main.o: /usr/include/boost/typeof/message.hpp
pc_boost_main.o: /usr/include/boost/typeof/native.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_floating_point.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_unsigned.hpp
pc_boost_main.o: /usr/include/boost/chrono/detail/is_evenly_divisible_by.hpp
pc_boost_main.o: /usr/include/boost/chrono/time_point.hpp
pc_boost_main.o: /usr/include/boost/chrono/detail/system.hpp
pc_boost_main.o: /usr/include/boost/version.hpp
pc_boost_main.o: /usr/include/boost/chrono/clock_string.hpp
pc_boost_main.o: /usr/include/boost/chrono/ceil.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/thread_interruption.hpp
pc_boost_main.o: /usr/include/boost/thread/v2/thread.hpp
pc_boost_main.o: /usr/include/boost/thread/condition_variable.hpp
pc_boost_main.o: /usr/include/boost/thread/lock_types.hpp
pc_boost_main.o: /usr/include/boost/thread/lock_options.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/thread_group.hpp
pc_boost_main.o: /usr/include/boost/thread/shared_mutex.hpp
pc_boost_main.o: /usr/include/boost/thread/lock_guard.hpp
pc_boost_main.o: /usr/include/boost/thread/detail/lockable_wrapper.hpp
pc_boost_main.o: /usr/include/c++/4.8.2/initializer_list
pc_boost_main.o: /usr/include/boost/thread/once.hpp
pc_boost_main.o: /usr/include/boost/thread/recursive_mutex.hpp
pc_boost_main.o: /usr/include/boost/thread/tss.hpp
pc_boost_main.o: /usr/include/boost/thread/locks.hpp
pc_boost_main.o: /usr/include/boost/thread/lock_algorithms.hpp
pc_boost_main.o: /usr/include/boost/thread/barrier.hpp
pc_boost_main.o: /usr/include/boost/utility/result_of.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/iteration/iterate.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/array/elem.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/array/data.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/array/size.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/slot/slot.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/slot/detail/def.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/enum_trailing_params.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/enum_binary_params.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/repetition/enum_shifted_params.hpp
pc_boost_main.o: /usr/include/boost/preprocessor/facilities/intercept.hpp
pc_boost_main.o: /usr/include/boost/mpl/has_xxx.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/type_wrapper.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/has_xxx.hpp
pc_boost_main.o: /usr/include/boost/mpl/aux_/config/msvc_typename.hpp
pc_boost_main.o: /usr/include/boost/thread/future.hpp
pc_boost_main.o: /usr/include/boost/atomic.hpp
pc_boost_main.o: /usr/include/boost/atomic/atomic.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/config.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/platform.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/gcc-x86.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/base.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/lockpool.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/link.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/cas64strong.hpp
pc_boost_main.o: /usr/include/boost/atomic/detail/type-classification.hpp
pc_boost_main.o: /usr/include/boost/type_traits/is_signed.hpp chunk.h
pc_boost_main.o: decoder.h sf.h channelmap.h player.h playlist.h trackinfo.h
pc_boost_main.o: softvol.h
