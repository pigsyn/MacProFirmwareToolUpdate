#!/bin/bash

updatesdir="/System/Library/CoreServices/Firmware Updates/MacProEFIUpdate15"
firmwaredir="/Volumes/RamDisk/MacProEFI2010-2009"
firmware="EfiUpdaterApp2.efi"
firmware2="MP51_007F_03B_LOCKED.fd"

rm -r "${updatesdir}"
mkdir "${updatesdir}"

cp "${firmwaredir}/${firmware}" "${updatesdir}"
cp "${firmwaredir}/${firmware2}" "${updatesdir}"

/usr/sbin/bless -mount / -firmware "${updatesdir}/${firmware}" -payload "${updatesdir}/${firmware2}" -options "-x efi-apple-payload0-data" --verbose

exit 0
