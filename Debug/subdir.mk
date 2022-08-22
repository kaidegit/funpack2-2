################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Cpu0_Main.c \
../Cpu1_Main.c \
../Cpu2_Main.c \
../adc.c \
../led.c \
../pwm.c \
../timer.c \
../uart.c 

OBJS += \
./Cpu0_Main.o \
./Cpu1_Main.o \
./Cpu2_Main.o \
./adc.o \
./led.o \
./pwm.o \
./timer.o \
./uart.o 

COMPILED_SRCS += \
./Cpu0_Main.src \
./Cpu1_Main.src \
./Cpu2_Main.src \
./adc.src \
./led.src \
./pwm.src \
./timer.src \
./uart.src 

C_DEPS += \
./Cpu0_Main.d \
./Cpu1_Main.d \
./Cpu2_Main.d \
./adc.d \
./led.d \
./pwm.d \
./timer.d \
./uart.d 


# Each subdirectory must supply rules for building sources it contributes
Cpu0_Main.src: ../Cpu0_Main.c subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: TASKING C/C++ Compiler'
	cctc -D__CPU__=tc27xd -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Configurations" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Infra" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Infra\\Platform" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Infra\\Platform\\Tricore" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Infra\\Platform\\Tricore\\Compilers" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Infra\\Sfr" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Infra\\Sfr\\TC27D" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Infra\\Sfr\\TC27D\\_Reg" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Service" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Service\\CpuGeneric" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Service\\CpuGeneric\\StdIf" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\Service\\CpuGeneric\\_Utilities" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Asclin" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Asclin\\Asc" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Asclin\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Cpu" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Cpu\\CStart" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Cpu\\Irq" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Cpu\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Cpu\\Trap" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Gtm" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Gtm\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Gtm\\Tom" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Gtm\\Tom\\Pwm" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Mtu" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Mtu\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Port" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Port\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Scu" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Scu\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Src" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Src\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Stm" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Stm\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Vadc" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Vadc\\Adc" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\Vadc\\Std" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\_Impl" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\_Lib" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\_Lib\\DataHandling" -I"C:\\Users\\yekai\\AURIX-v1.7.2-workspace\\blink\\Libraries\\iLLD\\TC27D\\Tricore\\_PinMap" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O0 --tradeoff=4 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -o "$@"  "$<"  -cs --dep-file="$(@:.src=.d)" --misrac-version=2012 -N0 -Z0 -Y0 2>&1;
	@echo 'Finished building: $<'
	@echo ' '

%.o: ./%.src subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: TASKING Assembler'
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<" --list-format=L1 --optimize=gs
	@echo 'Finished building: $<'
	@echo ' '

%.src: ../%.c subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: TASKING C/C++ Compiler'
	cctc -D__CPU__=tc27xd "-fC:/Users/yekai/AURIX-v1.7.2-workspace/blink/Debug/TASKING_C_C___Compiler-Include_paths.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O0 --tradeoff=4 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -o "$@"  "$<"  -cs --dep-file="$(@:.src=.d)" --misrac-version=2012 -N0 -Z0 -Y0 2>&1;
	@echo 'Finished building: $<'
	@echo ' '


