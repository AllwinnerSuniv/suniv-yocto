<h1 align="center">Yocto for Allwinner Suniv</h1>

# Foreword

Hello, everyone. This is a unoffical Yocto project for Allwinner
suniv series SoC, it provides many functions like image build, sdk generation etc.

There may still have problems i couldn't found, so issue and P&R is welcome. I think you could figure it out, right? I will setup a website for documentations on github page sooner. partner is also welcome.

Anyway, have fun with this.

Best wishs,

iotah

# Get started

`Ubuntu 18.04` is required for this project. Other platform haven't tested. I suggest using a docker or lxd.

Host machine is Ubuntu 23.04 x86_64

install requirements first [offical system requirements](https://docs.yoctoproject.org/ref-manual/system-requirements.html#required-packages-for-the-build-host)
```bash
$ sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool
```

then pull this repo
```bash
$ git clone https://github.com/AllwinnerSuniv/suniv-yocto
```

when things up there have all done, you could build it now.
```bash
$ cd suniv-yocto && ls
LICENSE  README.md  build.sh yocto

$ ./build.sh
Loading cache: 100% |#############################################################| Time: 0:00:00
Loaded 1268 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "1.40.0"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "ubuntu-18.04"
TARGET_SYS           = "arm-lichee-linux-gnueabi"
MACHINE              = "suniv"
DISTRO               = "lichee"
DISTRO_VERSION       = "0.0.1"
TUNE_FEATURES        = "arm armv5 thumb dsp"
TARGET_FPU           = "soft"
meta                 
meta-poky            
meta-yocto-bsp       = "thud:6c5a847a4514b8c1729511aae96374eb8679a152"
meta-suniv           = "thud:151a1add53bfc0f08461e9fb08d7769800653bbd"
workspace            = "thud:b11b41955663e58394c5bbd75cdbc667049baec3"

Initialising tasks: 100% |########################################################| Time: 0:00:00
Sstate summary: Wanted 103 Found 0 Missed 103 Current 70 (0% match, 40% complete)
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 808 tasks of which 592 didn't need to be rerun and all succeeded.
```

# Basic

Layer Management

```bash
$ bitbake-layers show-layers
NOTE: Starting bitbake server...
layer                 path                                      priority
==========================================================================
meta                  /home/developer/sources/suniv-yocto/yocto/poky/meta  5
meta-poky             /home/developer/sources/suniv-yocto/yocto/poky/meta-poky  5
meta-yocto-bsp        /home/developer/sources/suniv-yocto/yocto/poky/meta-yocto-bsp  5
meta-suniv            /home/developer/sources/suniv-yocto/yocto/meta-suniv  6


```


# License

This project is protected by MIT license.

# Thanks

uboot source from [sipeed](https://www.sipeed.com/)

kernel usb and audio patchs from [whycan.com](https://whycan.com)