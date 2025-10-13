#!/bin/bash

# 集成设备无线
mkdir -p package/base-files/files/lib/firmware/brcm
cp -a $GITHUB_WORKSPACE/configfiles/firmware/brcm/* package/base-files/files/lib/firmware/brcm/

# ================================================================
# 移植RK3399示例，其他RK3399可模仿
# ================================================================
# 增加tvi3315a设备
echo -e "\\ndefine Device/tvi_tvi3315a
  DEVICE_VENDOR := Tvi
  DEVICE_MODEL := TVI3315A
  SOC := rk3399
  UBOOT_DEVICE_NAME := tvi3315a-rk3399
endef
TARGET_DEVICES += tvi_tvi3315a" >> target/linux/rockchip/image/armv8.mk

# 替换package/boot/uboot-rockchip/Makefile
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/Makefile package/boot/uboot-rockchip/Makefile

# 复制U-Boot补丁到package/boot/uboot-rockchip/patches
cp -f $GITHUB_WORKSPACE/configfiles/patch/001-disable-efi-loader.patch package/boot/uboot-rockchip/patches/
#cp -f $GITHUB_WORKSPACE/configfiles/patch/001-rockchip-saradc-supports-rk3568.patch package/boot/uboot-rockchip/patches/
cp -f $GITHUB_WORKSPACE/configfiles/patch/101-rockchip-add-TVI-TVI3315A.patch package/boot/uboot-rockchip/patches/

# 复制内核补丁到target/linux/rockchip/patches-6.6
cp -f $GITHUB_WORKSPACE/configfiles/patch/128-arm64-dts-rockchip-rk3399-Add-TVI3315A.patch target/linux/rockchip/patches-6.6/
# ================================================================
# RK3399示例结束
# ================================================================

# ================================================================
# 移植RK3566示例，其他RK35xx可模仿
# ================================================================
# 增加station-m2设备
#echo -e "\\ndefine Device/firefly_station-m2
  #DEVICE_VENDOR := Firefly
  #DEVICE_MODEL := Station M2 / RK3566 ROC PC
  #SOC := rk3566
  #DEVICE_DTS := rockchip/rk3566-roc-pc
  #SUPPORTED_DEVICES += firefly,station-m2 firefly,rk3566-roc-pc
  #UBOOT_DEVICE_NAME := station-m2-rk3566
  #DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
#endef
#TARGET_DEVICES += firefly_station-m2" >> target/linux/rockchip/image/armv8.mk

# 复制U-Boot补丁到package/boot/uboot-rockchip/patches
#

# 复制内核补丁到target/linux/rockchip/patches-6.6
#
# ================================================================
# RK35xx示例结束
# ================================================================
