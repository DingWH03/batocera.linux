################################################################################
#
# firmware-bit-brick-k1
#
################################################################################

FIRMWARE_BIT_BRICK_K1_VERSION = 1.0
FIRMWARE_BIT_BRICK_K1_SITE = $(call github,DingWH03,firmware-bit-brick-k1,$(FIRMWARE_BIT_BRICK_K1_VERSION))
FIRMWARE_BIT_BRICK_K1_SOURCE = firmware-bit-brick-k1-$(FIRMWARE_BIT_BRICK_K1_VERSION).tar.gz

define FIRMWARE_BIT_BRICK_K1_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/
	cp -R $(@D)/* $(TARGET_DIR)/lib/firmware/
endef

$(eval $(generic-package))
