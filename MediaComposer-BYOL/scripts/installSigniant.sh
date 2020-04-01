#!/bin/bash
# $1 = Signiant Media Shuttle Location
# $2 = Registration Key
# $3 = Avid Nexis Client Location


echo "Getting Signiant Media Shuttle"
wget -O Install_Signiant_Media_Shuttle.tar.gz $1
echo "tar Signiant Media Shuttle"
mkdir signiant
tar zxvf Install_Signiant_Media_Shuttle.tar.gz -C signiant
echo "Installing Signiant Media Shuttle"
./signiant/installer.sh -s -registration-key=$2
echo "Installing"
sudo yum -y install libicu
echo "Getting Avid Nexis Client"
wget -O AvidNEXISClient_el7.centos.x86_64_19.6.0_7.bin $3
echo "Installing Avid Nexis Client"
chmod +x AvidNEXISClient_el7.centos.x86_64_19.6.0_7.bin
sudo ./AvidNEXISClient_el7.centos.x86_64_19.6.0_7.bin
