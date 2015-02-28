CC=g++
CFLAGS=-g -O2 -Wall
LDLIBS=`python-config --libs`

all:
	cython -2 -o pysais.cpp pysais.pyx
	$(CC) $(CFLAGS) -fpic -c pysais.cpp -o pysais.o `python-config --cflags`
	$(CC) $(CFLAGS) -shared -o pysais.so pysais.o $(LDLIBS)
