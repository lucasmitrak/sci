# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 

DESCRIPTION="Needleman-Wunsch global sequence alignment in python2"
HOMEPAGE="https://pypi.python.org/pypi/nwalign"
SRC_URI="mirror://pypi/n/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-python/numpy
	dev-python/cython"
RDEPEND="${DEPEND}"
