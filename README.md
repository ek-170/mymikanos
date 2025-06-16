# mikanos


## how to build with EDK2

```shell
cd $HOME/edk2
source edksetup.sh && build
```

## how to create bootable USB

```shell
# USBを挿したら識別子を確認
diskutil list
# /dev/disk4 (external, physical):
#    #:                       TYPE NAME                    SIZE       IDENTIFIER
#    0:      GUID_partition_scheme                        *31.0 GB    disk4
#    1:                        EFI EFI                     209.7 MB   disk4s1
#    2:       Microsoft Basic Data BOOT                    30.8 GB    disk4s2

# USB を初期化
diskutil eraseDisk FAT32 BOOT GPT /dev/disk4
mkdir -p /Volumes/BOOT/EFI/BOOT
# もしファイル名が BOOTX64.EFIでない場合はリネームする
cp BOOTX64.EFI /Volumes/BOOT/EFI/BOOT/

# キャッシュをUSBに確実に書き込む
sync
diskutil eject /dev/disk4
```
