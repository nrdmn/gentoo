# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake linux-info

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/"
	inherit git-r3
else
	SRC_URI="https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/archive/roc-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/ROCT-Thunk-Interface-roc-${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Radeon Open Compute Thunk Interface"
HOMEPAGE="https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface"
CONFIG_CHECK="~NUMA ~HSA_AMD ~HMM_MIRROR ~ZONE_DEVICE ~DRM_AMDGPU ~DRM_AMDGPU_USERPTR"
LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"

RDEPEND="sys-process/numactl
	sys-apps/pciutils"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "s:get_version ( \"1.0.0\" ):get_version ( \"${PV}\" ):" -i CMakeLists.txt || die
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
		-DCPACK_PACKAGING_INSTALL_PREFIX="${EPREFIX}/usr"
	)
	cmake_src_configure
}
src_compile() {
	cmake_src_compile build-dev
}
src_install() {
	cmake_src_install install-dev
}
