#------------------ Compiler ----------------------------------------
CC := arm-none-eabi-gcc

#-------------------- Flags -----------------------------------------
CFLAGS := -mcpu=cortex-m4 -mthumb	-mfloat-abi=soft	-Wall	-Werror	-O0	-ffunction-sections -fdata-sections
CFLAGS	+=	-I includes/	#Header files 
CFLAGS	+=	-fstack-usage -Wstack-usage=2048	#Compiler flags for stack
LDFLAGS :=	--specs=nano.specs -T linkerScript.ld	-Wl,--gc-sections 
LDFLAGS	+=	-Wl,-Map=main.map	#Linker Flags for map file
CLIFLAGS	:=	-c port=SWD

#------------------ Directories ---------------------------------------
OBJ_DIR	= obj
BUILD_DIR	=	build
SRC_DIR	=	src

#---------------------- Files ---------------------------------------
TARGET	=	$(BUILD_DIR)/main.elf
SOURCES	=	$(wildcard $(SRC_DIR)/*.c)
OBJECTS = 	$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SOURCES))

#------------------------ CLI for loading the code in mcu --------------------------
CLI	:=	STM32_Programmer_CLI.exe

#------------------------------ Recepies ---------------------------------------
all: $(TARGET)

.DEFAULT_GOAL	:=	all		#defalt goal 

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo compiling $<
	@if not exist $(OBJ_DIR) mkdir $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/main.elf: $(OBJECTS)
	@echo linking $@
	@if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)
	$(CC)	$(CFLAGS)	$(LDFLAGS)	$(OBJECTS)	-o	$@

clean:
	del /Q $(OBJ_DIR) $(BUILD_DIR)

load:	$(BUILD_DIR)/main.elf
	$(CLI) $(CLIFLAGS) -d $< -v

reset:	load
	$(CLI) $(CLIFLAGS) -rst

load2:	$(BUILD_DIR)/main.elf
	openocd -f "C:\Users\VICTUS\xpack-openocd-0.12.0-7\openocd\scripts\board\st_nucleo_f4.cfg"

bin:	$(BUILD_DIR)/main.elf
	arm-none-eabi-objcopy -O binary $< $(BUILD_DIR)/main.bin

.PHONY:
	all clean load reset load2 bin
