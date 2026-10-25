
CC := arm-none-eabi-gcc

CFLAGS := -mcpu=cortex-m4 -mthumb -Wall	-Werror	-O0	-ffunction-sections -fdata-sections

LDFLAGS := -nostdlib -T linkerScript.ld	-Wl,--gc-sections -Wl,-Map=main.map

OBJECTS := main.o gpio.o startup.o

CLI	:=	STM32_Programmer_CLI.exe

CLIFLAGS	:=	-c port=SWD

CFLAGS	+=	-fstack-usage -Wstack-usage=2048

all: main.elf

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

main.elf: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LDFLAGS) -o $@

clean:
	del /Q $(OBJECTS) main.elf main.map *.su

load:
	$(CLI) $(CLIFLAGS) -d main.elf -v

reset:
	$(CLI) $(CLIFLAGS) -rst

load2:
	openocd -f "C:\Users\VICTUS\xpack-openocd-0.12.0-7\openocd\scripts\board\st_nucleo_f4.cfg"
	