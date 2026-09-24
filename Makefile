CC := arm-none-eabi-gcc
CFLAGAGS := -mcpu=cortex-m4 -mthumb -std -Wall -fdata-sections --gc-sections
LDFLAGS := --specs=nano.specs --specs=nosys.specs

