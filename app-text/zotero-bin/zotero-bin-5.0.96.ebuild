# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Helps you collect, organize, cite, and share your research sources"
HOMEPAGE="https://www.zotero.org"
SRC_URI="https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=${PV} -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/nss
	x11-libs/gtk+:3
	x11-libs/libXt
"

S="${WORKDIR}/Zotero_linux-x86_64"

QA_PREBUILT="*"

src_prepare() {
	# disable update
	sed -i -e 's/\(pref("app.update.enabled"\).*/\1, false);/' defaults/preferences/prefs.js || die

	# disable default oo installation questions - manual installation is still possible
	sed -i -e 's/\(pref("extensions.zoteroOpenOfficeIntegration.skipInstallation"\).*/\1, true);/' \
		extensions/zoteroOpenOfficeIntegration@zotero.org/defaults/preferences/zoteroOpenOfficeIntegration.js || die

	# fix desktop-file
	sed -i -e 's#^Exec=.*#Exec=zotero#' zotero.desktop
	sed -i -e 's#Icon=zotero.*#Icon=zotero#' zotero.desktop

	default
}

src_install() {
	dodir opt/zotero
	cp -a "${S}"/* "${ED}/opt/zotero" || die

	dosym ../../opt/zotero/zotero usr/bin/zotero

	domenu zotero.desktop

	for size in 16 32 48; do
		newicon -s ${size} chrome/icons/default/default${size}.png zotero.png
	done
}
