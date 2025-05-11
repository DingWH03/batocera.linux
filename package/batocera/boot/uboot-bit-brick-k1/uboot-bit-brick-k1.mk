################################################################################
#
# uboot files for bit-brick-k1 (spacemit k1)
#
################################################################################

UBOOT_BIT_BRICK_K1_VERSION = k1-bl-v2.1-release
UBOOT_BIT_BRICK_K1_SITE = https://gitee.com/bianbu-linux/uboot-2022.10.git
UBOOT_BIT_BRICK_K1_SITE_METHOD = git
UBOOT_SUPPORTS_IN_SOURCE_BUILD = NO

UBOOT_ARCH = riscv
UBOOT_PLAT = k1

define UBOOT_CONFIGURE_CMDS
	$(MAKE) -C $(@D) \
	  ARCH=$(UBOOT_ARCH) \
	  CROSS_COMPILE=$(HOST_DIR)/bin/riscv64-buildroot-linux-gnu- \
	  PLATFORM=$(UBOOT_PLAT) \
	  defconfig
endef

define UBOOT_BIT_BRICK_K1_BUILD_CMDS
	$(MAKE) -C $(@D) ARCH=riscv CROSS_COMPILE=$(HOST_DIR)/bin/riscv64-buildroot-linux-gnu-
 -j$(PARALLEL_JOBS)
endef

define UBOOT_BIT_BRICK_K1_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(BINARIES_DIR)/u-boot
	$(INSTALL) -m 0644 $(@D)/u-boot $(BINARIES_DIR)/u-boot/
	$(INSTALL) -m 0644 $(@D)/u-boot.bin $(BINARIES_DIR)/u-boot/
	$(INSTALL) -m 0644 $(@D)/u-boot.dtb $(BINARIES_DIR)/u-boot/
	$(INSTALL) -m 0644 $(@D)/u-boot-dtb.bin $(BINARIES_DIR)/u-boot/
	$(INSTALL) -m 0644 $(@D)/u-boot.itb $(BINARIES_DIR)/u-boot/
	$(INSTALL) -m 0644 $(@D)/u-boot-nodtb.bin $(BINARIES_DIR)/u-boot/
	$(INSTALL) -m 0644 $(@D)/FSBL.bin $(BINARIES_DIR)/u-boot/

	# 安装 bootinfo 文件
	$(INSTALL) -m 0644 $(@D)/bootinfo_*.bin $(BINARIES_DIR)/u-boot/ || true

	# 安装开发板 dtb 文件（可选）
	$(INSTALL) -m 0644 $(@D)/k1-*.dtb $(BINARIES_DIR)/u-boot/ || true
endef

$(eval $(generic-package))
