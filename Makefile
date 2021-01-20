
#Author: cc

PROJECT = tx231_trunk

CROSS_COMPILE_PREFIX = arm-none-eabi-
#CROSS_COMPILE_PREFIX =
CC = $(CROSS_COMPILE_PREFIX)gcc
OBJCOPY = $(CROSS_COMPILE_PREFIX)objcopy
#CXX = g++
LD = $(CROSS_COMPILE_PREFIX)ld


ROOT_DIR=$(shell pwd)
OUT_DIR = $(ROOT_DIR)/output
OBJS_DIR = $(OUT_DIR)/objects

CFLAGS = -Os
LDFLAGS = -Wl,-Map=$(OUT_DIR)/$(PROJECT).map 

SRC += ./hello/*.c
SRC += ./app/*.c

INC += -I./hello/

SOURCE := $(wildcard $(SRC))

OBJS := $(SOURCE:%.c=%.o)

$(OUT_DIR)/$(PROJECT).elf:$(OBJS)
	mkdir -p $(OUT_DIR)
	mkdir -p $(OBJS_DIR)
	$(CC) $(LDFLAGS)-o $@ $(OBJS_DIR)/*.o 
	$(OBJCOPY) -O binary -R .note -R .comment -S $@ $(OUT_DIR)/$(PROJECT).bin

%.o:%.c
	$(CC) $(INC) $(CLAGS) -c $< -o $@
	mv $@ $(OBJS_DIR)

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)/*



