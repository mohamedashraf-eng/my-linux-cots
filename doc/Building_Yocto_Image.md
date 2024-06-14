# Building a yocto image
## Ubuntu

### Pre conditions
`[note]: The full pkg required`
```C
sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev python3-subunit mesa-common-dev zstd liblz4-tool file locale &&
sudo apt update && sudo apt upgrade &&
sudo apt install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath &&socat libsdl1.2-dev xterm &&
sudo locale-gen en_US.UTF-8 && 
sudo update-locale LANG=en_US.UTF-8 &&
sudo apt install python 
```

### Yocto (Poky) clone
```C
git clone git://git.yoctoproject.org/poky &&
cd poky  
```

### Checkout to the specified version
`[note]: versions are mapped to names @ex[4.0.11(July 23) == kKirkstone]`
```C
git checkout dunfell
```

### Building the image
`[note]: You can customize your config files [@ex[.local | .config] etc.]`
`[note]: Every time you open WSL2 you should run the following`
```C
source oe-init-build-env &&
git clone git://git.yoctoproject.org/poky &&
bitbake core-image-minimal
```

### Porting on QEMU
```C
sudo chmod 666 /dev/net/tun &&
runqemu qemux86 nographic &&
Poky (Yocto Project Reference Distro) 2.7.1 qemux86 /dev/ttyS0 

[qemux86 login:]
```













