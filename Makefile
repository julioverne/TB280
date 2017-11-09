include theos/makefiles/common.mk

TWEAK_NAME = tb280
tb280_FILES = /mnt/d/codes/tb280/Tweak.xm
tb280_FRAMEWORKS = CydiaSubstrate Foundation
tb280_CFLAGS = -fobjc-arc
tb280_LDFLAGS = -Wl,-segalign,4000

tb280_ARCHS = armv7 arm64
export ARCHS = armv7 arm64

include $(THEOS_MAKE_PATH)/tweak.mk
