#!/bin/bash

if [[ "$(id -g)" -ne "0" ]]; then
  echo "Please run with sudo $0"
  exit 1
fi

sysctl hw.model|egrep -q "MacPro4,1|MacPro5,1"
if [[ "$?" -ne "0" ]];then
  echo "This program is designed for 2009 and 2010 Mac Pro models only."
  exit 1
fi

sysctl hw.ncpu|egrep -q "12|24"
if [[ "$?" -eq "0" ]]; then
  echo "Warning! You have a 2010 Mac Pro with one or two 6-core CPUs. If you downgrade the firmware to a 2009 Mac Pro, it will not boot with these 6-core CPUs."
  echo "If you know exactly what you are doing, and plan to revert to 4-core CPUs after shutdown, then proceed. Otherwise, do not perfrom this downgrade."
fi

ping -o -c 1 www.apple.com >/dev/null 2>&1
if [[ "$?" -ne "0" ]]; then
  echo "This program requires Internet access. Please connect your Mac Pro to the Internet and try again."
  exit 1
fi

# old insecure urls
# MP4,1 http://support.apple.com/downloads/DL989/en_US/MacProEFIUpdate.dmg'
# MP5,1 before 2015 http://support.apple.com/downloads/DL1321/en_US/MacProEFIUpdate1.5.dmg
# MP5,1 after 2015  http://support.apple.com/downloads/DL1321/en_US/MacProEFIUpdate.dmg

# current urls (needs curl with tlsv1.2 support, MacOS 10.9 or above)
mp41url="https://updates.cdn-apple.com/2019/cert/041-85221-20191017-79244f0a-4ce2-487d-be9c-3426c8914340/MacProEFIUpdate.dmg"
mp51url="https://updates.cdn-apple.com/2019/cert/041-87779-20191017-fcbc4e09-65e2-4332-83bd-9dfe7013e409/MacProEFIUpdate.dmg"

completed () {
  echo "The Mac Pro 2010 firmware upgrade procedure is ready."
  echo "To complete the firmware update, shut down the system, and upon restarting, hold the power button down until the power indicator flashes, or you hear a long tone,"
  echo "then release the power button. A gray screen with an Apple logo and progress bar will appear while the update is taking place. When the update is complete your Mac Pro will startup normally."
  echo "The update may take a few minutes. Do not unplug, shutdown, restart or disturb your Mac Pro in any way while the update is taking place."
}

download_dmg () {
  curl -L -o '/Volumes/RamDisk/EFI2009.dmg' $mp41url
  curl -L -o '/Volumes/RamDisk/EFI2010.dmg' $mp51url
}

copy_files () {
  cp "Contents/Resources/DowngradeEFI2010-2009.sh" /Volumes/RamDisk
  cp "Contents/Resources/UpgradeEFI2009-2010.sh" /Volumes/RamDisk
  cp "Contents/Resources/EFIUpdater2009.patch" /Volumes/RamDisk
  cp "Contents/Resources/EFIUpdater2010.patch" /Volumes/RamDisk
  cp "Contents/Resources/ExtractAndPatchEFIFiles.sh" /Volumes/RamDisk
}

upgrade () {
  diskutil erasevolume HFS+ RamDisk `hdiutil attach -nomount ram://512000`
  download_dmg
  copy_files
  /Volumes/RamDisk/./ExtractAndPatchEFIFiles.sh
  /Volumes/RamDisk/./UpgradeEFI2009-2010.sh
  completed
}

downgrade () {
  diskutil erasevolume HFS+ RamDisk `hdiutil attach -nomount ram://512000`
  download_dmg
  copy_files
  /Volumes/RamDisk/./ExtractAndPatchEFIFiles.sh
  /Volumes/RamDisk/./DowngradeEFI2010-2009.sh
  completed
}

#
echo "Please choose firmware operation"
echo "1 - Upgrade to 2010"
echo "2 - Downgrade to 2009"
read choice;
case $choice in
  1) echo "upgrading to 2010 firmware..."
     upgrade;;
  2) echo "downgrading to 2009 firmware..."
     downgrade;;
  *) echo "This choice is not available."
     exit 1;;
esac
