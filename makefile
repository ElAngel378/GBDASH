# GBDK path - use environment variable if set, otherwise default to C:/gbdk
GBDK ?= C:/gbdk
GBCC = $(GBDK)/bin/lcc

PROJECT_NAME = GBDASH
SRCDIR = src
INCDIR = include
TEMPDIR = temp
BINDIR = bin
LIBDIR = lib

SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c, $(TEMPDIR)/%.o, $(SRCS))

LCCFLAGS = -I$(INCDIR) -Wa-I. -Wl-j -Wl-yt0x19 -Wl-yo256
LIBS = $(LIBDIR)/hUGEDriver.lib

all: prepare $(BINDIR)/$(PROJECT_NAME).gb

prepare:
	@mkdir -p $(TEMPDIR)
	@mkdir -p $(BINDIR)

$(TEMPDIR)/%.o: $(SRCDIR)/%.c
	$(GBCC) $(LCCFLAGS) -c -o $@ $<

$(BINDIR)/$(PROJECT_NAME).gb: $(OBJS)
	$(GBCC) $(LCCFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	rm -rf $(TEMPDIR) $(BINDIR)
