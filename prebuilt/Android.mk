LOCAL_PATH := $(call my-dir)

RELINK := $(LOCAL_PATH)/relink.sh

#dummy file to trigger required modules
include $(CLEAR_VARS)
LOCAL_MODULE := teamwin
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin

# Manage list
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/dump_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/flash_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/erase_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/sh
ifeq ($(TW_USE_TOYBOX), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/toybox
    RELINK_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/unzip
    RELINK_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/zip
else
    RELINK_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/busybox
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/micro.toolbox
endif
RELINK_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/pigz
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/fsck.fat
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/fatlabel
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/mkfs.fat
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/e2fsck
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mke2fs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/tune2fs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/resize2fs
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/simg2img
ifneq ($(TARGET_ARCH), x86_64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker
endif
ifeq ($(TARGET_ARCH), x86_64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker64
endif
ifeq ($(TARGET_ARCH), arm64)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker64
endif
#RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/twrpmtp
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libc.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrecovery.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libusbhost.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libdl.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_com_err.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_e2p.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2fs.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_profile.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_uuid.so
ifneq ($(wildcard external/e2fsprogs/lib/quota/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_quota.so
endif
ifneq ($(wildcard external/e2fsprogs/lib/ext2fs/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2fs.so
endif
ifneq ($(wildcard external/e2fsprogs/lib/blkid/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_blkid.so
endif
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpng.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblog.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libm.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libstdc++.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libz.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libminuitwrp.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libminadbd.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libminzip.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libmtdutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext4_utils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtar_twrp.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libutil-linux.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libblkid.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libmmcutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbmlutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libflashutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfusesideload.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbootloader_message.so

# Android M libraries
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbacktrace.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libunwind.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbase.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libc++.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto_utils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpackagelistparser.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblzma.so
# Dynamically loaded by libc and may prevent unmounting system if it is not present in sbin
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libnetd_client.so

RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/toolbox
ifneq ($(TW_OEM_BUILD),true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/twrp
else
    TW_EXCLUDE_MTP := true
endif
ifneq ($(TW_EXCLUDE_MTP), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libtwrpmtp.so
endif
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libaosprecovery.so

RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libselinux.so

ifneq ($(TW_NO_EXFAT), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfuse.so
else ifeq ($(TW_INCLUDE_NTFS_3G), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libfuse.so
endif
ifneq ($(TW_NO_EXFAT), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mkfs.exfat
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fsck.exfat
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libexfat.so
else
    TW_NO_EXFAT_FUSE := true
endif
ifneq ($(TW_NO_EXFAT_FUSE), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mount.exfat
endif
ifeq ($(TW_INCLUDE_BLOBPACK), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/blobpack
endif
ifeq ($(TW_INCLUDE_INJECTTWRP), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/injecttwrp
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcryptfslollipop.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libgpt_twrp.so
    ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
        RELINK_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libcryptfs_hw.so
    endif
endif
ifeq ($(AB_OTA_UPDATER), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/bootctl
    ifneq ($(TW_INCLUDE_CRYPTO), true)
        RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libhardware.so
    endif
endif
ifeq ($(TARGET_USERIMAGES_USE_EXT4), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/make_ext4fs
endif
ifneq ($(wildcard system/core/libsparse/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libsparse.so
endif
ifneq ($(TW_EXCLUDE_ENCRYPTED_BACKUPS), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/openaes
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libopenaes.so
endif
ifeq ($(TARGET_USERIMAGES_USE_F2FS), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mkfs.f2fs
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libf2fs.so
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fsck.f2fs
endif
ifneq ($(wildcard system/core/reboot/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/reboot
endif
ifneq ($(TW_DISABLE_TTF), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libft2.so
endif
ifneq ($(TW_RECOVERY_ADDITIONAL_RELINK_FILES),)
    RELINK_SOURCE_FILES += $(TW_RECOVERY_ADDITIONAL_RELINK_FILES)
endif
ifneq ($(wildcard external/pcre/Android.mk),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libpcre.so
endif
ifeq ($(TW_INCLUDE_NTFS_3G), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mount.ntfs
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/fsck.ntfs
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mkfs.ntfs
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libntfs-3g.so
endif
ifeq ($(BOARD_HAS_NO_REAL_SDCARD),)
    RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/sgdisk
endif

TWRP_AUTOGEN := $(intermediates)/teamwin

GEN := $(intermediates)/teamwin
$(GEN): $(RELINK)
$(GEN): $(RELINK_SOURCE_FILES) $(call intermediates-dir-for,EXECUTABLES,init)/init
	$(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/sbin $(RELINK_SOURCE_FILES)

LOCAL_GENERATED_SOURCES := $(GEN)
LOCAL_SRC_FILES := teamwin $(GEN)
include $(BUILD_PREBUILT)

#permissive.sh
include $(CLEAR_VARS)
LOCAL_MODULE := permissive.sh
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#mke2fs.conf
include $(CLEAR_VARS)
LOCAL_MODULE := mke2fs.conf
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/etc
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

# copy license file for OpenAES
ifneq ($(TW_EXCLUDE_ENCRYPTED_BACKUPS), true)
    include $(CLEAR_VARS)
    LOCAL_MODULE := openaes_license
    LOCAL_MODULE_TAGS := eng
    LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/license/openaes
    LOCAL_SRC_FILES := ../openaes/LICENSE
    include $(BUILD_PREBUILT)
endif
