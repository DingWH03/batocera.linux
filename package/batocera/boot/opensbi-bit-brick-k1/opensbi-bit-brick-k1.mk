################################################################################
#
# OpenSBI for bit-brick-k1 (spacemit k1)
#
################################################################################

OPENSBI_VERSION = k1-bl-v2.1-release
OPENSBI_SITE = https://gitee.com/bianbu-linux/opensbi.git
OPENSBI_SITE_METHOD = git
OPENSBI_SUPPORTS_IN_SOURCE_BUILD = NO

# 如果有必要，设置自定义平台的 defconfig
OPENSBI_PLAT_DEFCONFIG = k1_defconfig
OPENSBI_ARCH = riscv
OPENSBI_PLAT = k1

define OPENSBI_CONFIGURE_CMDS
	$(MAKE) -C $(@D) \
	  ARCH=$(OPENSBI_ARCH) \
	  CROSS_COMPILE=$(HOST_DIR)/bin/riscv64-buildroot-linux-gnu- \
	  PLATFORM=$(OPENSBI_PLAT) \
	  defconfig
endef

define OPENSBI_BUILD_CMDS
	# 编译 OpenSBI
	$(MAKE) -C $(@D) ARCH=riscv CROSS_COMPILE=$(HOST_DIR)/bin/riscv64-buildroot-linux-gnu- -j$(PARALLEL_JOBS)
endef

define OPENSBI_INSTALL_TARGET_CMDS
	# 安装 OpenSBI 到目标文件系统
	# 安装 fw_payload.elf
	$(INSTALL) -m 0644 $(@D)/build/platform/generic/firmware/fw_payload.elf $(BINARIES_DIR)/opensbi/
	
	# 安装 fw_jump.elf
	$(INSTALL) -m 0644 $(@D)/build/platform/generic/firmware/fw_jump.elf $(BINARIES_DIR)/opensbi/
	
	# 安装 fw_dynamic.bin
	$(INSTALL) -m 0644 $(@D)/build/platform/generic/firmware/fw_dynamic.bin $(BINARIES_DIR)/opensbi/
	
	# 安装 fw_dynamic.elf
	$(INSTALL) -m 0644 $(@D)/build/platform/generic/firmware/fw_dynamic.elf $(BINARIES_DIR)/opensbi/
endef

$(eval $(generic-package))
