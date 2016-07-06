inherit kernel

DESCRIPTION = "Banana Pi R1 Linux Kernel"
HOMEPAGE = "https://github.com/BPI-SINOVOIP/"
LICENSE = "GPL-2.0"

COMPATIBLE_MACHINES = "bpir1"

SRC_URI += "git://github.com/BPI-SINOVOIP/BPI-Kernel4.0.git;protocol=git;${SRC_REV} \
	file://defconfig \
	file://bpir1-bpir1-linux.dtb \
	"

RECIPE_USE_kernel_defconfig ?= "file"
RECIPE_USE_kernel_imagetype = "uImage"

S="${SRCDIR}/BPI-Kernel4.0/linux-4.0.2"
