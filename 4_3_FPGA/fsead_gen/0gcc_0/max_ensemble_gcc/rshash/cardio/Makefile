CC=g++
CFLAGS=-Wall --std=c++11 -g
SOURCES := $(wildcard *.cpp)
OBJS := $(SOURCES:.cpp=.o)

.PHONY: clean
rshash_cardioE175: $(OBJS)
		$(CC) $(CFLAGS) $^ -o $@

.cpp.o:
		$(CC) $(CFLAGS) -c $<

clean:
		rm -f rshash_cardioE175 $(OBJS) *.o
