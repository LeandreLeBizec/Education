CC=gcc
SOURCES = principal.c tableau.c tri.c
OBJETS = $(SOURCES:.c=.o)


principal: $(OBJETS)
	$(CC) $^ -o $@
principal.o: principal.c tri.h tableau.h commun.h
tableau.o: tableau.c tableau.h commun.h
tri.o: tri.c tri.h tableau.h commun.h

clean:
	rm *.o principal

#v1
#principal: principal.o tableau.o tri.o
	# gcc principal.o tableau.o tri.o -o principal
	
#principal.o: principal.c tri.h tableau.h commun.h
	#gcc -c principal.c
#tableau.o: tableau.c tableau.h commun.h
	#gcc -c tableau.c
#tri.o: tri.c tri.h tableau.h commun.h
	#gcc -c tri.c
	
#clean:
	#rm *.o principal
	
	
	
#v2
#principal: principal.o tableau.o tri.o
	# gcc $^ -o$@
	
#principal.o: principal.c tri.h tableau.h commun.h
	#gcc -c $<
#tableau.o: tableau.c tableau.h commun.h
	#gcc -c $<
#tri.o: tri.c tri.c tableau.h commun.h
	#gcc -c $<
	
#clean:
	#rm *.o principal
	
	
	
#v3
#CC=gcc
#OBJETS = principal.o tableau.o tri.o

#principal: $(OBJETS)
	#$(CC) $^-o$@
	
#principal.o: principal.c tri.h tableau.h commun.h
	#$(CC) $^-o$@
#tableau.o: tableau.c tableau.h commun.h
	#$(CC) $^-o$@
#tri.o: tri.c tri.c tableau.h commun.h
	#$(CC) $^-o$@
	
#clean:
	#rm *.o principal
	
	
	
#v4
#CC=gcc
#SOURCES = principal.c tableau.c tri.c
#OBJETS = $(SOURCES:.c=.o)


#principal: $(OBJETS)
	#$(CC) $^-o$@

#principal.o: principal.c tri.h tableau.h commun.h
	#$(CC) -c $<
#tableau.o: tableau.c tableau.h commun.h
	#$(CC) -c $<
#tri.o: tri.c tri.h tableau.h commun.h
	#$(CC) -c $<
	
#clean:
	#rm *.o principal
	
	
#v5
#CC=gcc
#SOURCES = principal.c tableau.c tri.c
#OBJETS = $(SOURCES:.c=.o)


#principal: $(OBJETS)
	#$(CC) $^ -o $@
#principal.o: principal.c tri.h tableau.h commun.h
#tableau.o: tableau.c tableau.h commun.h
#tri.o: tri.c tri.h tableau.h commun.h

#clean:
	#rm *.o principal
