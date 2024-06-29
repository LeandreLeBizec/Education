CC=g++
BIN=bin
LIBS=
INCLUDE=-I src
CFLAGS=-g -O3 -c -Wall -std=c++14 $(INCLUDE)
LDFLAGS=-std=c++14 #-lprofiler -Wl,-no_pie
SOURCES=node.cpp tree.cpp transposition_table.cpp main.cpp
OBJECTS=$(addprefix $(BIN)/, $(SOURCES:.cpp=.o))
EXECUTABLE=$(BIN)/main
vpath %.cpp src

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@

-include $(BIN)/$(OBJECTS:.o=.d)

$(BIN)/%.o: %.cpp
	$(CC) -c $(CFLAGS) $< -o $(BIN)/$*.o
	$(CC) -MM $(CFLAGS) $< > $(BIN)/$*.d
	@mv -f $(BIN)/$*.d $(BIN)/$*.d.tmp
	@sed -e 's|.*:|$(BIN)/$*.o:|' < $(BIN)/$*.d.tmp > $(BIN)/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $(BIN)/$*.d.tmp | fmt -1 | \
	sed -e 's/^ *//' -e 's/$$/:/' >> $(BIN)/$*.d
	@rm -f $(BIN)/$*.d.tmp

clean:
	rm -f $(BIN)/*.o $(BIN)/*.d $(EXECUTABLE)
