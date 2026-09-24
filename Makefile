CC	:=	arm-none-eabi-gcc
CFLAGS	:=	-mcpu=cortex-m4	-mthumb	-Wall	-fdata-sections	-o0
LDFLAGS	:=	--specs=nano.specs	--specs=nosys.specs 

main.o:	main.c gpio.h
	$(CC)	-c	$(CFLAGS)	$(LDFLAGS)	$<	-o	$@

	