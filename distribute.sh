#!/bin/bash -ex

# init USB
diskutil list
diskutil eraseDisk FAT32 BOOT GPT /dev/disk4
mkdir -p /Volumes/BOOT/EFI/BOOT

echo "-----"

# build kernel
cd ~/gitrepo/mymikanos/kernel
rm -f ./kernel.elf || true
source ~/gitrepo/osbook/devenv/buildenv.sh
make
# clang++ $CPPFLAGS -O2 --target=x86_64-elf -fno-exceptions -ffreestanding -c main.cpp
# ld.lld $LDFLAGS --entry KernelMain -z norelro -z separate-code --image-base 0x100000 --static -o kernel.elf main.o
cp ./kernel.elf /Volumes/BOOT

# build boot loader
cd ~/gitrepo/edk2
source edksetup.sh && build
cp ~/gitrepo/edk2/Build/MikanLoaderX64/DEBUG_CLANGPDB/X64/Loader.efi /Volumes/BOOT/EFI/BOOT/BOOTX64.EFI

sync

echo "all process done"
# diskutil eject /dev/disk4