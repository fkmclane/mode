EXE=mode
DEBUG?=0

SRCDIR=src
LIBDIR=vendor
BUILDDIR=build
DATADIR=data
DISTDIR=dist

DIST:=behaviours data fonts libs sounds specs textures $(EXE)

CC?=gcc
CXX?=g++

include platform.mk

SRC=$(shell find $(SRCDIR) -maxdepth 1 -name "*.cpp" -printf "%f ")
DEP=$(shell echo $(SRC) | sed -e "s/\([^ ]*\).cpp/$(BUILDDIR)\/\1.d /g")
OBJ=$(shell echo $(SRC) | sed -e "s/\([^ ]*\).cpp/$(BUILDDIR)\/\1.o /g")

all: $(DEP) $(EXE) $(DATADIR)

$(EXE): $(OBJ) $(LIBDIR)/lua/liblua.a
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(BUILDDIR)/%.d: $(BUILDDIR) $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -MQ $(@:.d=.o) -MF $@ -MM $(word 2,$^)

$(BUILDDIR)/%.o: $(BUILDDIR) $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $(word 2,$^)

$(BUILDDIR):
	mkdir -p $@

$(LIBDIR)/lua/liblua.a: $(LIBDIR)/lua/makefile
	+make -C $(LIBDIR)/lua CC=$(CC) MYCFLAGS="$(LUA_CFLAGS)" MYLDFLAGS="$(LUA_LDFLAGS)" MYLIBS="$(LUA_LDLIBS)" a

$(DATADIR):
	mkdir -p $@

clean:
	$(RM) $(LIBDIR)/lua/{*.d,*.o,*.a,lua}
	$(RM) $(BUILDDIR)/{*.d,*.o,*.a} $(EXE)

dist: all
	mkdir -p $(DISTDIR)
	cp -a $(DIST) $(DISTDIR)/

.PHONY: all clean dist

-include $(DEP)
