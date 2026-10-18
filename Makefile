CC	:=	arm-none-eabi-gcc
CFLAGS	:=	-mcpu=cortex-m4	-mthumb	-Wall	-fdata-sections	-o0
LDFLAGS	:=	--specs=nano.specs	--specs=nosys.specs -nostdlib -T linkerScript.ld 
OBJECTS	:=	main.o	gpio.o	startup.o
all : $(OBJECTS)
$(OBJECTS): %.o : %.c
	$(CC)	-c	$(CFLAGS)	$(LDFLAGS)	$<	-o	$@

clean:
	del /Q	$(OBJECTS)