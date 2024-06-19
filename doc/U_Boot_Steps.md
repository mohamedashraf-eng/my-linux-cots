# Steps for U-Boot

## u-boot : boot loader for Linux steps to generate u-boot.bin

- make rpi_3_defconfig
- make menuconfig
- set default config. for specific arch 
- /arch/arm/cpu/arch/start.sstart:
  - call reset  reset cpu configuration , disaple IRQ , disable cache,lowlevel init
  - branch main
- arch/arm/lib/crt0.S:
  - Entry main  
  - setup inital stack and global data  
  - board initlization  
  - relocate_code copy binary to ram
  - board_init_r jumbing to main
  - call function pointer  init_sequence_r
  - main_loop
- common/main.c:  
  - main_loop:
    - bootdelay_process or open CLI
    - cli_process_fdt `bootcmd`   `autoboot_command`
    - run_command_list