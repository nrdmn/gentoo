# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Image Hashing library"
HOMEPAGE="https://github.com/JohannesBuchner/imagehash"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="BSD-2"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pywavelets[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )"

python_test() {
	esetup.py test
}
