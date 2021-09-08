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

## ifeq ($(TARGET_PREBUILT_KERNEL),)
#LOCAL_KERNEL := device/samsung/m11q-kernel/kernel
#else
#LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
#endif

#PRODUCT_COPY_FILES := \
#	$(LOCAL_KERNEL):kernel

$(call inherit-product-if-exists, vendor/samsung/m11q/device-vendor.mk)


BOARD_DYNAMIC_PARTITION_ENABLE := true

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs
    
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_PACKAGES += fastbootd
# Add default implementation of fastboot HAL.
PRODUCT_PACKAGES += android.hardware.fastboot@1.0-impl-mock

PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstabs-4.9/fstab_AB_dynamic_partition_variant.qti:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom

PRODUCT_BUILD_PRODUCT_IMAGE := true
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
$(call inherit-product, build/make/target/product/gsi_keys.mk)

# Default vendor configuration.
ENABLE_VENDOR_IMAGE := true

-include $(QCPATH)/common/config/qtic-config.mk

# video seccomp policy files
# copy to system/vendor as well (since some devices may symlink to system/vendor and not create an actual partition for vendor)
PRODUCT_COPY_FILES += \
    device/samsung/m11q/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    device/samsung/m11q/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy
    
$(call inherit-product, device/qcom/common/common64.mk)

DEVICE_MANIFEST_FILE := device/samsung/m11q/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    vendor/qcom/opensource/core-utils/vendor_framework_compatibility_matrix.xml
    
# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8953/msm8953.mk
-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/msm8953/msm8953.mk

USE_LIB_PROCESS_GROUP := true

#Audio DLKM
AUDIO_DLKM := audio_apr.ko
AUDIO_DLKM += audio_q6_notifier.ko
AUDIO_DLKM += audio_adsp_loader.ko
AUDIO_DLKM += audio_q6.ko
AUDIO_DLKM += audio_usf.ko
AUDIO_DLKM += audio_pinctrl_wcd.ko
AUDIO_DLKM += audio_swr.ko
AUDIO_DLKM += audio_wcd_core.ko
AUDIO_DLKM += audio_swr_ctrl.ko
AUDIO_DLKM += audio_wsa881x.ko
AUDIO_DLKM += audio_wsa881x_analog.ko
AUDIO_DLKM += audio_platform.ko
AUDIO_DLKM += audio_cpe_lsm.ko
AUDIO_DLKM += audio_hdmi.ko
AUDIO_DLKM += audio_stub.ko
AUDIO_DLKM += audio_wcd9xxx.ko
AUDIO_DLKM += audio_mbhc.ko
AUDIO_DLKM += audio_wcd9335.ko
AUDIO_DLKM += audio_wcd_cpe.ko
AUDIO_DLKM += audio_digital_cdc.ko
AUDIO_DLKM += audio_analog_cdc.ko
AUDIO_DLKM += audio_native.ko
AUDIO_DLKM += audio_machine_sdm450.ko
AUDIO_DLKM += audio_machine_ext_sdm450.ko
AUDIO_DLKM += mpq-adapter.ko
AUDIO_DLKM += mpq-dmx-hw-plugin.ko
PRODUCT_PACKAGES += $(AUDIO_DLKM)

 MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

PRODUCT_PACKAGES += android.hardware.media.omx@1.0-impl

# Display/Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service \
    android.hardware.configstore@1.0-service

PRODUCT_PACKAGES += wcnss_service

# FBE support
PRODUCT_COPY_FILES += \
	device/samsung/m11q/init/init.qti.qseecomd.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.qseecomd.sh
	
# VB xml
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.software.verified_boot.xml:system/etc/permissions/android.software.verified_boot.xml
        
#wlan driver
PRODUCT_COPY_FILES += \
    device/samsung/m11q/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini \
    device/samsung/m11q/wifi/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat \
    device/samsung/m11q/wifi/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin
    
PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf
    
#for wlan
PRODUCT_PACKAGES += \
    wificond \
    wifilogd

# Powerhint configuration file
PRODUCT_COPY_FILES += \
     device/samsung/m11q/power/powerhint.xml:system/etc/powerhint.xml
     
#Healthd packages
PRODUCT_PACKAGES += android.hardware.health@2.0-impl \
                   android.hardware.health@2.0-service \
                   libhealthd.msm
                   
PRODUCT_FULL_TREBLE_OVERRIDE := true

PRODUCT_VENDOR_MOVE_ENABLED := true

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# Sensor HAL conf file
 PRODUCT_COPY_FILES += \
     device/samsung/m11q/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-service \
    android.hardware.power@1.0-impl
    
PRODUCT_PACKAGES += \
    vendor.display.color@1.0-service \
    vendor.display.color@1.0-impl

PRODUCT_PACKAGES += \
    libandroid_net \
    libandroid_net_32
    
#Enable Lights Impl HAL Compilation
PRODUCT_PACKAGES += android.hardware.light@2.0-impl

#set KMGK_USE_QTI_SERVICE to true to enable QTI KEYMASTER and GATEKEEPER HIDLs
KMGK_USE_QTI_SERVICE := true

#Enable AOSP KEYMASTER and GATEKEEPER HIDLs
PRODUCT_PACKAGES += android.hardware.gatekeeper@1.0-impl \
                    android.hardware.gatekeeper@1.0-service \
                    android.hardware.keymaster@3.0-impl \
                    android.hardware.keymaster@3.0-service

#A/B related packages
PRODUCT_PACKAGES += update_engine \
                   update_engine_client \
                   update_verifier \
                   bootctrl.msm8953 \
                   android.hardware.boot@1.0-impl \
                   android.hardware.boot@1.0-service

PRODUCT_HOST_PACKAGES += \
    brillo_update_payload

#Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += bootctl

PRODUCT_PACKAGES += \
  update_engine_sideload
  
# Enable telephpony ims feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml

PRODUCT_PACKAGES += libnbaio

