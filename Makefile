TARGET := iphone:clang:latest:7.0

DEBUG = 0
FOR_RELEASE = 1
FINAL_PACKAGE = 1

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = XNotForMe

XNotForMe_FILES = XNotForMe.m $(wildcard swizzling/*.m)
XNotForMe_CFLAGS = -fobjc-arc
XNotForMe_INSTALL_PATH = /usr/local/lib

include $(THEOS_MAKE_PATH)/library.mk
