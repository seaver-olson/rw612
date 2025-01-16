

RM := rm -rf

BINFILE:=rw612.elf

ODIR=obj
SDIR=src
CFLAGS=-Isrc/
CFLAGS += -DDEBUG=2
CFLAGS+=-O0 -fno-stack-protector -ffunction-sections -fdata-sections -mcpu=cortex-m33 -fvar-tracking -g3

CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld
SIZE=arm-none-eabi-size


OBJS +=  \
	main.o \



OBJ = $(patsubst %,$(ODIR)/%,$(OBJS))

$(ODIR)/%.o: $(SDIR)/%.c
	$(CC) $(CFLAGS) -c -g -o $@ $^

$(ODIR)/%.o: $(SDIR)/%.s
	nasm -f elf32 -g -o $@ $^


all: bin

bin: $(OBJ)
	$(CC)  $(CFLAGS) obj/*  --specs=nano.specs -Trw612.ld -Wl,"-u _printf_float" -Wl,--gc-sections -static -e Reset_Handler -o $(BINFILE)
	ctags -R src/*
	$(SIZE) $(BINFILE)

debug:
	ps aux | grep openocd | grep -v grep && { killall openocd; sleep 2; } || { echo "debugging..."; }
	screen -S openocd -d -m openocd -f $(OPENOCDDIR)/board/$(OCDCONFIG)
	sleep 2
	gdb-multiarch $(BINFILE) -x gdb_init.txt



# Other Targets
clean:
	rm -rf $(BINFILE) obj/*

disassemble:
	arm-none-eabi-objdump --source $(BINFILE)

