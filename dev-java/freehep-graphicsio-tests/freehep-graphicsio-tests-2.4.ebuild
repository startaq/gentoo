# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="freehep-vectorgraphics"
MY_P="${MY_PN}-${PV}"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="High Energy Physics Java library - FreeHEP GraphicsIO Test Library"
HOMEPAGE="http://java.freehep.org/"
SRC_URI="https://github.com/freehep/${MY_PN}/archive/${MY_P}.tar.gz"
LICENSE="Apache-2.0 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="~dev-java/freehep-graphics2d-${PV}:${SLOT}
	~dev-java/freehep-graphicsbase-${PV}:${SLOT}
	~dev-java/freehep-graphicsio-${PV}:${SLOT}
	dev-java/freehep-io:0
	dev-java/junit:4"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.7"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.7"

S="${WORKDIR}/${MY_PN}-${MY_P}/${PN}"
JAVA_SRC_DIR="src/main/java"
JAVA_GENTOO_CLASSPATH="freehep-graphics2d,freehep-graphicsbase,freehep-graphicsio,freehep-io,junit-4"

java_prepare() {
	# Avoid additional deps for "extra" tests.
	sed -i -r "/Test(Histogram|ScatterPlot)/d" \
		${JAVA_SRC_DIR}/org/freehep/graphicsio/test/TestSuite.java || die
}

src_compile() {
	java-pkg-simple_src_compile
	java-pkg_addres ${PN}.jar src/main/resources
}
