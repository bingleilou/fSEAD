CC=g++
CFLAGS=-Wall --std=c++11 -g
SOURCES := $(wildcard *.cpp)
OBJS := $(SOURCES:.cpp=.o)

.PHONY: clean
loda_http1E245: $(OBJS)
		$(CC) $(CFLAGS) $^ -o $@

.cpp.o:
		$(CC) $(CFLAGS) -c $<

clean:
		rm -f loda_http1E245 $(OBJS) *.o
