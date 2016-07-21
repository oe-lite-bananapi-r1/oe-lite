#!/bin/bash
set -x -e

# Call this script with something like:
# ./scripts/mk_sd.sh /dev/mmcblk0 tmp/images/

MEDIA=$1
#PART_SPAREFS="$1"p4
#PART_ROOTFS_SPARE="$1"p3
PART_ROOTFS="$1"p2
PART_BOOTFS="$1"p1
UBOOT=$2/bpir1-u-boot.bin
ROOTFS=$2/bpir1-bananapir1-rootfs.tar
BOOTFS=$2/bpir1-bananapir1-bootfs.tar.gz

#temporary mount dir
TMPMNT=/tmp/sdmount
mkdir -p $TMPMNT

#######################
ls -l $MEDIA
sleep 5

umount /media/*  || :

dd if=/dev/zero of=$MEDIA bs=512 count=1
partprobe $MED2IA

#u-boot
sudo dd if=$UBOOT of=$MEDIA bs=1024 seek=8

sfdisk $MEDIA <<EOF
1MiB,200MiB,0C
,1GiB,83
EOF
#,200MiB,83
#,1GiB,83
#EOF
sleep 1
partprobe $MEDIA

mkfs.vfat -n BOOT $PART_BOOTFS
mkfs.ext4 -L rootfs $PART_ROOTFS
#mkfs.ext4 -L rootfs_spare $PART_ROOTFS_SPARE
#mkfs.ext4 -L spare $PART_SPAREFS

[ -r $ROOTFS ]
mount -t ext4 $PART_ROOTFS $TMPMNT
tar --strip-components=1 -xf $ROOTFS -C $TMPMNT
umount $TMPMNT

[ -r $BOOTFS ]
mount -t vfat $PART_BOOTFS $TMPMNT
tar --strip-components=2 -xzf $BOOTFS -C $TMPMNT
umount $TMPMNT

rm -rf $TMPMNT
