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

# SDCC optimizes almost nothing by default, and lcc has no -O option
# (unrecognized options go to the linker!). Compiler flags must be forwarded
# via -Wf. Without these the game cannot hold 60fps: all OAM/metatile work
# runs at naive -O0 speed.
LCCFLAGS = -I$(INCDIR) -Wf--opt-code-speed -Wf--max-allocs-per-node50000 -Wa-I. -Wl-j -Wl-yt0x19 -Wl-yo256
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
