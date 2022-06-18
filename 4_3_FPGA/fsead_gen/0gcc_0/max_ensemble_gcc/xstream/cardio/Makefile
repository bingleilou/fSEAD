CC=g++
CFLAGS=-Wall --std=c++11 -g
SOURCES := $(wildcard *.cpp)
OBJS := $(SOURCES:.cpp=.o)

.PHONY: clean
xstream_cardioE140: $(OBJS)
		$(CC) $(CFLAGS) $^ -o $@

.cpp.o:
		$(CC) $(CFLAGS) -c $<

clean:
		rm -f xstream_cardioE140 $(OBJS) *.o
