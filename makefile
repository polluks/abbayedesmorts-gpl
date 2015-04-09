PREFIX?=	/usr

CC?=		gcc
CFLAGS?=	-O2 -finline-functions -funswitch-loops -fgcse-after-reload -fpredictive-commoning -ftree-vectorize

CFLAGS+=	`sdl2-config --cflags` -DDATADIR="\"$(PREFIX)/share/abbayev2\""
LIBS=		`sdl2-config --libs` -lSDL2_image -lSDL2_mixer -lm

SRCS=		src/drawing.c \
		src/ending.c \
		src/enemies.c \
		src/game.c \
		src/gameover.c \
		src/history.c \
		src/jean.c \
		src/loading.c \
		src/main.c \
		src/startscreen.c

all: abbaye

abbaye: ./src/main.c ./src/loading.c ./src/startscreen.c ./src/history.c ./src/game.c ./src/jean.c ./src/enemies.c ./src/gameover.c ./src/ending.c ./src/drawing.c
	$(CC) $(CFLAGS) $(SRCS) -o abbayev2 $(LIBS)

clean:

	rm -rf ./abbayev2

# Installation
install:
	cp abbayev2 $(DESTDIR)$(PREFIX)/bin/
	cp abbaye.desktop $(DESTDIR)$(PREFIX)/share/applications
	mkdir -p $(DESTDIR)$(PREFIX)/share/abbayev2/sounds
	cp ./sounds/* $(DESTDIR)$(PREFIX)/share/abbayev2/sounds
	mkdir -p $(DESTDIR)$(PREFIX)/share/abbayev2/data
	cp ./data/* $(DESTDIR)$(PREFIX)/share/abbayev2/data
	cp abbaye.png $(DESTDIR)$(PREFIX)/share/pixmaps
	mkdir -p $(DESTDIR)$(PREFIX)/share/abbayev2/graphics
	cp -r ./graphics/* $(DESTDIR)$(PREFIX)/share/abbayev2/graphics

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/abbayev2
	rm $(DESTDIR)$(PREFIX)/share/applications/abbaye.desktop
	rm $(DESTDIR)$(PREFIX)/share/pixmaps/abbaye.png
	rm -rf $(DESTDIR)$(PREFIX)/share/abbayev2
