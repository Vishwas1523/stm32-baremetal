CC	:=	arm-none-eabi-gcc
CFLAGS	:=	-mcpu=cortex-m4	-mthumb	-std	-Wall	-fdata-sections	--gc-sections	-o0
LDFLAGS	:=	--specs=nano.specs	--specs=nosys.specs

main.o:	main.c
	$(CC)	-c	$(CFLAGS)	$(LDFLAGS)	$^	-o	$@

	