#!/bin/sh

export VERSION=5.4.1

mkdir -p /tmp/libre
cd /tmp/libre
curl -OL http://download.documentfoundation.org/libreoffice/stable/${VERSION}/rpm/x86_64/LibreOffice_${VERSION}_Linux_x86-64_rpm.tar.gz
curl -OL http://download.documentfoundation.org/libreoffice/stable/${VERSION}/rpm/x86_64/LibreOffice_${VERSION}_Linux_x86-64_rpm_langpack_ja.tar.gz
tar xzf LibreOffice_${VERSION}_Linux_x86-64_rpm.tar.gz
tar xzf LibreOffice_${VERSION}_Linux_x86-64_rpm_langpack_ja.tar.gz
cd LibreOffice_${VERSION}.*_Linux_x86-64_rpm/RPMS
yum -y install *.rpm
cd ../../LibreOffice_${VERSION}.*_Linux_x86-64_rpm_langpack_ja/RPMS
yum -y install *.rpm
cd /tmp
rm -r /tmp/libre
echo LibreOffce install
