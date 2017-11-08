inherit kernel

DESCRIPTION = "Upstream vanilla Banana Pi R1 Linux Kernel"
HOMEPAGE = "https://kernel.org"
LICENSE = "GPL-2.0"

COMPATIBLE_MACHINES = "bpir1"

SRC_URI += " \
	file://defconfig \
	"

SRC_URI += "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git;protocol=git;${SRC_REV}"

RECIPE_USE_kernel_imagetype = "uImage"

S="${SRCDIR}/linux"
