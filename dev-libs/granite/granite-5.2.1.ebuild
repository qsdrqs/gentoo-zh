# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.40

inherit cmake gnome2-utils vala

DESCRIPTION="Elementary OS library that extends Gtk+"
HOMEPAGE="https://github.com/elementary/granite"
SRC_URI="https://github.com/elementary/granite/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="demo nls test"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8[introspection]
	>=x11-libs/gtk+-3.22:3[introspection]
"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.40.0
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {

	# Disable building of the demo application (if needed)
	use demo || cmake_comment_add_subdirectory demo

	# Disable generation of the translations (if needed)
	use nls || cmake_comment_add_subdirectory po

	cmake_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE=${VALAC}
	)

	cmake_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
