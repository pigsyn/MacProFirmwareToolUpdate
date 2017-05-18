# MacProFirmwareToolUpdate
Patch for MacEFIRom's Mac Pro 2009-2010 Firmware Tool

# About this patch
This patch fixes previously broken firmware images downloads from Apple website.

# Usage

* Download MacEFIRom's Mac Pro 2009-2010 Firmware Tool
* Download MacProFirmwareToolUpdate
* Unzip both files under Downloads
* Open /Application/Utilities/Terminal

```bash
cd Downloads/
patch 'Mac Pro 2009-2010 Firmware Tool.app/Contents/Resources/Scripts/Mac Pro 2009-2010 Firmware Tool.scpt' MacProFirmwareToolUpdate-master/2009_2010.patch
```

 * 2009_2010.patch md5: `674283f3cfaafad236d8f4aedff4a54a`

# Releases
You can also download a pre-patched version: https://github.com/pigsyn/MacProFirmwareToolUpdate/releases
* Disabling SIP is mandatory before running this firmware upgrade if you are running macOS 10.11 (El Capitan) or greater
