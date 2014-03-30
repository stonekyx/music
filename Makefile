CFLAGS=-g -Wall -Wextra -std=c++11
BOOST_LIBS=-lboost_thread -lboost_atomic -lboost_serialization -lboost_system -pthread
FFMPEG_LIBS=-lswresample -lavcodec -lavutil -lavformat -lasound
LIBS=$(BOOST_LIBS) $(FFMPEG_LIBS)

all: main

obj_main=chunk.o  decoder.o  decoder_ffmpeg.o  pc_boost.o  pc_boost_main.o  decoder_random.o channelmap.o  player.o  player_alsa.o

main: $(obj_main)
	g++ $(CFLAGS) $(obj_main) $(LIBS) -o main

chunk.o: chunk.cpp chunk.h
	g++ $(CFLAGS) chunk.cpp -c

decoder.o: decoder.cpp decoder.h
	g++ $(CFLAGS) decoder.cpp -c

decoder_ffmpeg.o: decoder_ffmpeg.cpp decoder_ffmpeg.h utils.h sf.h decoder.h
	g++ $(CFLAGS) decoder_ffmpeg.cpp -c

decoder_random.o: decoder_random.cpp decoder_random.h decoder.h
	g++ $(CFLAGS) decoder_random.cpp -c

player.o: player.cpp player.h sf.h channelmap.h
	g++ $(CFLAGS) player.cpp -c

player_alsa.o: player_alsa.h player_alsa.cpp player.h
	g++ $(CFLAGS) player_alsa.cpp -c

pc_boost_main.o: pc_boost_main.cpp
	g++ $(CFLAGS) pc_boost_main.cpp -c

channelmap.o: channelmap.c channelmap.h
	g++ $(CFLAGS) channelmap.c -c

pc_boost.o: pc_boost.cpp pc_boost.h chunk.o pc_boost_monitor.h decoder.o decoder_ffmpeg.o decoder_random.o channelmap.o player.o player_alsa.o
	g++ $(CFLAGS) pc_boost.cpp -c
