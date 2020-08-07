DEBUG = 0
FINALPACKAGE = 1
ARCHS = armv7 arm64

TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard

THEOS_DEVICE_IP = 192.168.0.18

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FullscreenCC

FullscreenCC_FILES = Tweak.x
FullscreenCC_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
