#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.100.31/g' package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/Tarabulus/g' package/base-files/files/bin/config_generate

# Modify the version number
sed -i "s/OpenWrt /LuckyGoldVenus@Wechat $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-opentomcat/g' feeds/luci/collections/luci/Makefile

# Modify banner
sed -i 's/%D %V, %C/OpenWrt SML v1.1[2021] | by "LuckyGoldVenus.Wechat"/g' package/base-files/files/etc/banner
# rm -rf package/base-files/files/etc/banner && cp -f ../banner package/base-files/files/etc/

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" x86_64.config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="luckygoldvenus@wechat"' >>x86_64.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"luckygoldvenus"@' x86_64.config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" x86_64.config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>x86_64.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' x86_64.config

# 打开旁路由防火墙规则，旁路由使用取消注释号#
echo "# iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

