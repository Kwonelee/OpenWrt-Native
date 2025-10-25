#!/bin/bash -e
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 集成设备无线
mkdir -p package/base-files/files/lib/firmware/brcm
cp -a $GITHUB_WORKSPACE/configfiles/firmware/brcm/* package/base-files/files/lib/firmware/brcm/

# 替换package/boot/uboot-rockchip/Makefile
cp -f $GITHUB_WORKSPACE/configfiles/uboot/Makefile package/boot/uboot-rockchip/Makefile

# ================================================================
# 移植RK3399示例
# ================================================================
# 增加tvi3315a设备
echo -e "\\ndefine Device/tvi_tvi3315a
  DEVICE_VENDOR := Tvi
  DEVICE_MODEL := TVI3315A
  SOC := rk3399
  UBOOT_DEVICE_NAME := tvi3315a-rk3399
  BOOT_FLOW := pine64-bin
endef
TARGET_DEVICES += tvi_tvi3315a" >> target/linux/rockchip/image/armv8.mk

# 复制U-Boot文件到package/boot/uboot-rockchip/patches
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3399/rk3399-tvi3315a.dts package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot/rk3399-tvi3315a-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot/tvi3315a-rk3399_defconfig package/boot/uboot-rockchip/src/configs/
cp -f $GITHUB_WORKSPACE/configfiles/uboot/900-arm-add-dts-files.patch package/boot/uboot-rockchip/patches/900-arm-add-dts-files.patch

# 复制内核文件到target/linux/rockchip/patches-6.6
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3399/rk3399-tvi3315a.dts target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/
cp -f $GITHUB_WORKSPACE/configfiles/target/900-arm64-boot-add-dts-files.patch target/linux/rockchip/patches-6.6/900-arm64-boot-add-dts-files.patch

# ================================================================
# 移植RK3566示例
# ================================================================
# 增加station-m2设备
echo -e "\\ndefine Device/firefly_station-m2
  DEVICE_VENDOR := Firefly
  DEVICE_MODEL := Station M2 / RK3566 ROC PC
  SOC := rk3566
  DEVICE_DTS := rockchip/rk3566-roc-pc
  SUPPORTED_DEVICES += firefly,station-m2 firefly,rk3566-roc-pc
  UBOOT_DEVICE_NAME := station-m2-rk3566
  BOOT_FLOW := pine64-img
  DEVICE_PACKAGES := kmod-nvme kmod-scsi-core
endef
TARGET_DEVICES += firefly_station-m2" >> target/linux/rockchip/image/armv8.mk

# 复制U-Boot文件到package/boot/uboot-rockchip/patches
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568/rk3566-roc-pc.dts package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot/rk3566-station-m2-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot/station-m2-rk3566_defconfig package/boot/uboot-rockchip/src/configs/

# 复制内核文件到target/linux/rockchip/patches-6.6
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568/rk3566-roc-pc.dts target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/
