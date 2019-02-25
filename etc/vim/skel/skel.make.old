INC_DIRS=-I$(HOME)/opt/linux/include
LIB_DIRS=-L$(HOME)/opt/linux/lib

CFLAGS=-Wall -g -O2 $(INC_DIRS)
LDFLAGS=$(LIB_DIRS)

sample_OBJS=$(addsuffix .o, $(basename sample.cxx))
sample_LIBS=

sample.exe: $(sample_OBJS)
	g++ $(CFLAGS) -o $@ $^ $(LDFLAGS) $(sample_LIBS)

%.o: %.c
	gcc $(CFLAGS) -c -o $@ $<

%.o: %.cxx
	g++ $(CFLAGS) -c -o $@ $<

clean:
	find . -name '*.o' -exec rm {} \;
	rm -f *.exe

