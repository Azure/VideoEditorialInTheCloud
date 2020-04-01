#!/bin/bash
# @@ AVID HEADER - DO NOT EDIT @@
# Copyright 2017 by Avid Technology, Inc.
# @@ AVID HEADER @@

# Usage:
#       installNexis.bash namePrefix __artifactsLocation __artifactsToken nexisBuild cloudPlatform

echo "deb http://debian-archive.trafficmanager.net/debian/ jessie main contrib non-free 
deb-src http://debian-archive.trafficmanager.net/debian/ jessie main contrib non-free
deb http://debian-archive.trafficmanager.net/debian-security/ jessie/updates main contrib non-free 
deb-src http://debian-archive.trafficmanager.net/debian-security/ jessie/updates main contrib non-free" > /etc/apt/sources.list

exec 2>&1
set -ex

namePrefix=$1
__artifactsLocation=$2
nexisBuild=$3
cloudPlatform=$4

wget $__artifactsLocation/${nexisBuild} -O /tmp/${nexisBuild}

/bin/bash /tmp/${nexisBuild} $namePrefix $cloudPlatform


