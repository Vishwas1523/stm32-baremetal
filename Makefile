
CC := arm-none-eabi-gcc

CFLAGS := -mcpu=cortex-m4 -mthumb -Wall -O0	-ffunction-sections -fdata-sections

LDFLAGS := -nostdlib -T linkerScript.ld	-Wl,--gc-sections

OBJECTS := main.o gpio.o startup.o

all: main.elf

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

main.elf: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LDFLAGS) -o $@

clean:
	del /Q $(OBJECTS) main.elf
