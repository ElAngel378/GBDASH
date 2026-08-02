# Shell detection and commands
ifeq ($(OS),Windows_NT)
    ifneq ($(findstring sh,$(SHELL)),)
        IS_BASH = true
    else
        IS_BASH = false
    endif
else
    IS_BASH = true
endif

ifeq ($(IS_BASH),true)
    CLEAR = clear
    MKDIR_P = mkdir -p
    RM_RF = rm -rf
else
    CLEAR = cls
    MKDIR_P = mkdir
    RM_RF = rmdir /S /Q
endif


# Directories
SRC_DIR := src
INC_DIR := include
BUILD_DIR := build

INSTRUMENT_DIR := $(SRC_DIR)/Instruments
STREAM_DIR := $(SRC_DIR)/Streams

BUILD_INSTRUMENT_DIR := $(BUILD_DIR)/Instruments
BUILD_STREAM_DIR := $(BUILD_DIR)/Streams


# Tools and flags
CC := lcc

CFLAGS := \
	-I$(INC_DIR) \
	-I$(SRC_DIR) \
	-I$(INSTRUMENT_DIR) \
	-I$(STREAM_DIR) \
	-c \
	-debug

LDFLAGS := \
	-I$(INC_DIR) \
	-I$(SRC_DIR) \
	-I$(INSTRUMENT_DIR) \
	-I$(STREAM_DIR) \
	-Wl-yt19 \
	-Wl-yo8 \
	-debug


# Sources
SRC_SOURCES := $(wildcard $(SRC_DIR)/*.c)

SOURCES := \
	$(SRC_SOURCES) \
	$(INSTRUMENT_SOURCES) \
	$(STREAM_SOURCES)


# Objects
SRC_OBJECTS := \
	$(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRC_SOURCES))

INSTRUMENT_OBJECTS := \
	$(patsubst $(INSTRUMENT_DIR)/%.c,$(BUILD_INSTRUMENT_DIR)/%.o,$(INSTRUMENT_SOURCES))

STREAM_OBJECTS := \
	$(patsubst $(STREAM_DIR)/%.c,$(BUILD_STREAM_DIR)/%.o,$(STREAM_SOURCES))

OBJECTS := \
	$(SRC_OBJECTS) \
	$(INSTRUMENT_OBJECTS) \
	$(STREAM_OBJECTS)


# Output
TARGET := $(BUILD_DIR)/game.gb


# Default build
all: $(TARGET)


# Link
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^


# Compile root src files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ $<


# Compile instruments
$(BUILD_INSTRUMENT_DIR)/%.o: $(INSTRUMENT_DIR)/%.c | $(BUILD_INSTRUMENT_DIR)
	$(CC) $(CFLAGS) -o $@ $<


# Compile streams
$(BUILD_STREAM_DIR)/%.o: $(STREAM_DIR)/%.c | $(BUILD_STREAM_DIR)
	$(CC) $(CFLAGS) -o $@ $<


# Create directories
$(BUILD_DIR):
	$(MKDIR_P) $(BUILD_DIR)

$(BUILD_INSTRUMENT_DIR):
	$(MKDIR_P) $(BUILD_INSTRUMENT_DIR)

$(BUILD_STREAM_DIR):
	$(MKDIR_P) $(BUILD_STREAM_DIR)


# Clean
clean:
	$(RM_RF) $(BUILD_DIR)


.PHONY: all clean