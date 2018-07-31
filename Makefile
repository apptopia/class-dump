DEBUG = 0

TARGET = iphone:clang:10.3:10.3
ARCHS = armv7 arm64

CLANG = xcrun -sdk iphoneos clang

TARGET_CC  = $(CLANG)
TARGET_CXX = $(CLANG)
TARGET_LD  = $(CLANG)

# add entitlements
TARGET_CODESIGN_FLAGS ?= -Sent.xml

include $(THEOS)/makefiles/common.mk

TOOL_NAME = class-dump

COMPAT_DEFINES = -include class-dump-Prefix.pch

${TOOL_NAME}_FILES  = $(shell find ./Source -name '*.m' -print)
${TOOL_NAME}_FILES += class-dump.m

${TOOL_NAME}_CFLAGS  = -Os -g0 -x objective-c -fobjc-arc -fno-common -Wno-error -I./Source $(COMPAT_DEFINES)

${TOOL_NAME}_LDFLAGS = -all_load -ObjC

${TOOL_NAME}_LIBRARIES = 
${TOOL_NAME}_FRAMEWORKS = Foundation

include $(THEOS_MAKE_PATH)/tool.mk

after-clean::
	rm -r obj/ packages/ .theos/
