################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vdr-addon"
PKG_VERSION="7.0"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain vdr vdr-plugin-dummydevice vdr-plugin-dvbapi vdr-plugin-eepg vdr-plugin-epgfixer vdr-plugin-epgsearch vdr-plugin-iptv vdr-plugin-live vdr-plugin-restfulapi vdr-plugin-satip vdr-plugin-streamdev vdr-plugin-vnsiserver vdr-plugin-wirbelscan vdr-plugin-wirbelscancontrol vdr-plugin-xmltv2vdr"
PKG_PRIORITY="optional"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="VDR: a TV streaming server for Linux"
PKG_LONGDESC="VDR(2.2.0) is a TV streaming server for Linux supporting DVB-S/S2, DVB-C, DVB-T/T2, IPTV and SAT>IP"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="VDR PVR Backend"
PKG_ADDON_TYPE="xbmc.service"
PKG_AUTORECONF="no"
PKG_ADDON_REPOVERSION="7.0"
PKG_ADDON_REQUIRES="pvr.vdr.vnsi:0.0.0 script.config.vdr:0.0.0"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  VDR_DIR="$(get_build_dir vdr)"
  VDR_PLUGIN_LIVE_DIR="$(get_build_dir vdr-plugin-live)"
  VDR_PLUGIN_VNSISERVER_DIR="$(get_build_dir vdr-plugin-vnsiserver)"
  VDR_PLUGIN_STREAMVEV_DIR="$(get_build_dir vdr-plugin-streamdev)"
  VDR_PLUGIN_XMLTV2VDR="$(get_build_dir vdr-plugin-xmltv2vdr)"
  VDR_PLUGIN_EPGFIXER_DIR="$(get_build_dir vdr-plugin-epgfixer)"
  VDR_PLUGIN_RESTFULAPI_DIR="$(get_build_dir vdr-plugin-restfulapi)"

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
  touch $ADDON_BUILD/$PKG_ADDON_ID/config/channels.conf
  cp $VDR_DIR/diseqc.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/keymacros.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/scr.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/sources.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/svdrphosts.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  echo '0.0.0.0/0' >> $ADDON_BUILD/$PKG_ADDON_ID/config/svdrphosts.conf

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/epgsearch

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/live
  cp -PR $VDR_PLUGIN_LIVE_DIR/live/* $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/live

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/epgsources/
  cp $VDR_PLUGIN_XMLTV2VDR/dist/epgdata2xmltv/epgdata2xmltv.dist $ADDON_BUILD/$PKG_ADDON_ID/config/epgsources/epgdata2xmltv

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-iptv)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-wirbelscan)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-wirbelscancontrol)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-dvbapi)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-eepg)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_STREAMVEV_DIR/server/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_STREAMVEV_DIR/client/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_LIVE_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-epgsearch)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_XMLTV2VDR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-dummydevice)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-satip)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_EPGFIXER_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_RESTFULAPI_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/eepg

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/vnsiserver
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/vnsiserver/allowed_hosts.conf $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/vnsiserver

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $VDR_DIR/vdr $ADDON_BUILD/$PKG_ADDON_ID/bin/vdr.bin
  cp -P $VDR_PLUGIN_XMLTV2VDR/dist/epgdata2xmltv/epgdata2xmltv $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -PL $(get_build_dir tntnet)/.install_pkg/usr/lib/libtntnet.so.12 $ADDON_BUILD/$PKG_ADDON_ID/lib

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/streamdev-server
  cp -PR $VDR_PLUGIN_STREAMVEV_DIR/streamdev-server/streamdevhosts.conf $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/streamdev-server

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/epgfixer
  cp -PR $VDR_PLUGIN_EPGFIXER_DIR/epgfixer/*.conf $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/epgfixer

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/restfulapi
  cp -P $VDR_PLUGIN_RESTFULAPI_DIR/web/* $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/restfulapi
  cp -P $VDR_PLUGIN_RESTFULAPI_DIR/API.html $ADDON_BUILD/$PKG_ADDON_ID/res/plugins/restfulapi
}
