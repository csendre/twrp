# Copyright 2005 The Android Open Source Project

LOCAL_PATH:= $(call my-dir)

minadbd_cflags := \
    -Wall -Werror \
    -Wno-unused-parameter \
    -Wno-missing-field-initializers \
    -DADB_HOST=0

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    adb_main.cpp \
    fuse_adb_provider.cpp \
    services.cpp \
    ../fuse_sideload.cpp

LOCAL_CLANG := true
LOCAL_MODULE := libminadbd
LOCAL_CFLAGS := $(minadbd_cflags)
LOCAL_CONLY_FLAGS := -Wimplicit-function-declaration
LOCAL_C_INCLUDES := $(LOCAL_PATH)/.. system/core/adb
LOCAL_WHOLE_STATIC_LIBRARIES := libadbd
LOCAL_SHARED_LIBRARIES := libbase liblog libcutils libc libcrypto libcrypto_utils

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_CLANG := true
LOCAL_MODULE := minadbd_test
LOCAL_SRC_FILES := fuse_adb_provider_test.cpp
LOCAL_CFLAGS := $(minadbd_cflags)
LOCAL_C_INCLUDES := $(LOCAL_PATH) system/core/adb
LOCAL_STATIC_LIBRARIES := libminadbd
LOCAL_SHARED_LIBRARIES := liblog libbase libcutils

include $(BUILD_NATIVE_TEST)
