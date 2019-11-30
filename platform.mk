MACHINE=$(shell gcc -dumpmachine)


#############
### Linux ###
#############

ifneq ($(findstring linux, $(MACHINE)),)

ifeq ($(DEBUG), 1)

CXXFLAGS?=-std=c++14 -fsanitize=address -ggdb -Wall -Wpedantic -Wextra -Weffc++ -Werror -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14 -fsanitize=address
LDLIBS?=-lm -ldl `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

else

CXXFLAGS?=-std=c++14 -O2 -DNDEBUG -Wall -Wpedantic -Wextra -Weffc++ -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14 -O2
LDLIBS?=-lm -ldl `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

endif

LUA_CFLAGS?=-std=c99 -DLUA_USE_LINUX
LUA_LDFLAGS?=
LUA_LDLIBS?=-ldl -lreadline -lhistory -lncurses


#############
### macOS ###
#############

else ifneq ($(findstring darwin, $(MACHINE)),)

ifeq ($(DEBUG), 1)

CXXFLAGS?=-std=c++14 -fsanitize=address -ggdb -Wall -Wpedantic -Wextra -Weffc++ -Werror -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14 -fsanitize=address
LDLIBS?=-lm -ldl `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

else

CXXFLAGS?=-std=c++14 -O2 -DNDEBUG -Wall -Wpedantic -Wextra -Weffc++ -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14 -O2
LDLIBS?=-lm -ldl `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

endif

LUA_CFLAGS?=-std=c99 -DLUA_USE_MACOSX
LUA_LDFLAGS?=
LUA_LDLIBS?=-ldl -lreadline -lncurses


###########################
### Windows (MinGW-w64) ###
###########################

else ifneq ($(findstring mingw, $(MACHINE)),)

ifeq ($(DEBUG), 1)

CXXFLAGS?=-std=c++14 -O2 -mwindows -Dmain=WinMain -ggdb -Wall -Wpedantic -Wextra -Weffc++ -Werror -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14 -O2 -mwindows
LDLIBS?=-lm `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

else

CXXFLAGS?=-std=c++14 -O2 -mwindows -Dmain=WinMain -DNDEBUG -Wall -Wpedantic -Wextra -Weffc++ -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14 -O2 -mwindows
LDLIBS?=-lm `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

endif

LUA_CFLAGS?=-std=c99 -DLUA_USE_WINDOWS
LUA_LDFLAGS?=
LUA_LDLIBS?=-lreadline -lhistory -lncurses

else


###############
### Unknown ###
###############

ifeq ($(DEBUG), 1)

CXXFLAGS?=-std=c++14 -Wall -Wpedantic -Wextra -Weffc++ -Werror -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14
LDLIBS?=-lm -ldl `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

else

CXXFLAGS?=-std=c++14 -DNDEBUG -Wall -Wpedantic -Wextra -Weffc++ -isystem $(LIBDIR) -isystem $(LIBDIR)/lua -isystem $(LIBDIR)/sol2 `sdl2-config --cflags` -I `sdl2-config --prefix`/include/ `pkg-config --cflags yaml-cpp`
LDFLAGS?=-std=c++14
LDLIBS?=-lm -ldl `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_gfx `pkg-config --libs yaml-cpp`

endif

LUA_CFLAGS?=-std=c99
LUA_LDFLAGS?=
LUA_LDLIBS?=-ldl -lreadline -lhistory -lncurses

endif