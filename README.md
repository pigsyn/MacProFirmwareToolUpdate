# MacProFirmwareToolUpdate
Patch for MacEFIRom's Mac Pro 2009-2010 Firmware Tool

## About this patch
* Mac Pro 4,1 (Early 2009) firmware update to 5,1
This patch fixes previously broken firmware images downloads from Apple website.

## Requirements
* EFI GPU
* OS X 10.7 and greater
* Starting with OS X 10.11 and greater you will need to disable SIP (System Integrity Proctection)
  * Reboot your Mac into Recovery Mode by restarting your computer and holding down Command+R until the Apple logo appears on your screen.
  * Click Utilities > Terminal. 
  * In the Terminal window, type in `csrutil disable` and press Enter.
  * Restart your Mac.
  * To re enable SIP, repeat this procedure and enter `csrutil enable`

## Releases
Download patched [`Mac Pro 2009-2010 Firmware Tool`][release] version

[release]: https://github.com/pigsyn/MacProFirmwareToolUpdate/releases/latest
