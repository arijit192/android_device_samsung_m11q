#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Use the non-open-source parts, if they're present
#-include vendor/samsung/m11q/BoardConfigVendor.mk

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
	
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_CPU_CORTEX_A53 := true

BOOTLOADER_PLATFORM := msm8953

### Dynamic partition Handling
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

## AB 
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
#BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x04000000

# Define the Dynamic Partition sizes and groups.
#BOARD_SUPER_PARTITION_SIZE := 12884901888
BOARD_SUPER_PARTITION_SIZE := 4399824896
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 4395630592
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product odm
#BOARD_EXT4_SHARE_DUP_BLOCKS := true
#BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864

# Metadata partition (applicable only for new launches)
#BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
BOARD_USES_METADATA_PARTITION := true


# Product partition support
TARGET_COPY_OUT_PRODUCT := product
BOARD_USES_PRODUCTIMAGE := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

#Enable HW based full disk encryption
TARGET_HW_DISK_ENCRYPTION := true
TARGET_HW_DISK_ENCRYPTION_PERF := true

# bring-up overrides
BOARD_USES_GENERIC_AUDIO := true

# Force camera module to be compiled only in 32-bit mode on 64-bit systems
# Once camera module can run in the native mode of the system (either
# 32-bit or 64-bit), the following line should be deleted
BOARD_QTI_CAMERA_32BIT_ONLY := true

# Enable System As Root even for non-A/B
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3112173568
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_DTBOIMG_PARTITION_SIZE := 0x0800000

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 androidboot.bootdevice=7824900.sdhci earlycon=msm_serial_dm,0x78af000 androidboot.usbconfigfs=true loop.max_part=7

BOARD_SECCOMP_POLICY := device/samsung/m11q/seccomp

TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTBO := $(DEVICE_PATH)/prebuilt/dtbo.img

BOARD_KERNEL_BASE        := 0x80000000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

#Generate DTBO image
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_INCLUDE_RECOVERY_DTBO := true

TARGET_ENABLE_MEDIADRM_64 := true
