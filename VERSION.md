# Version Tracking

## Application Features
* Save and load all saber settings to a file
* Save and load settings for a single bank
* Update Firmware
* Manage Main, Swing and Clash colours for all eight banks
* With GUI colour picker (RGB to RGBW color correction does not take 
  into account each LED colour have different brightnesses)
* Preview each colour on saber
* Selects saber COM port automatically
* Application update over the Internet
* Help files

### v.0.01.01.03
* Changed numbering, padded sub version numbers

### v.0.1.1.02
* Improved Saber detection
* Auto offer upgrade for early saber firmware.
* Installer adds "Manual Firmware Update" command in Windows menu

### v.0.1.1.01
* Colour picker closer resembles actual saber LED colour

### v.0.1.1.00
* First batch of serious help files added

### v.0.1.0.66
* HTML help internal and external hypelinks working

### v.0.1.0.65
* HTML based About, Licence and Help Dialog Box

### v.0.1.0.64
* BUG: save data from old firmwares hung, upgrade firmware and save saber,
  Added timeout and disconnect button aborts
* Added master build of firmware 1.9.15
  
### v.0.1.0.63
* BUG: Save all settings did not save all data, fixed
* Moved Swing Panel to middle tab

### v.0.1.0.62
* Preview colours on saber

### v.0.1.0.61
* Set swing colour
* Changed names of firmware menu items
* Disabled menu for check on connect as not yet implmented

### v.0.1.0.59
* Set swing colour

### v.0.1.0.58
* Window size fixed for alternte screen resolutions
* Installer fixed for Windows 32bit
* All firmware update menus hidden if run standalone (no tycmd updater tools)

### v.0.1.0.57
* Installer now includes latest master build OpenCore.1.9.13_20200810.hex
* Giltoniel no changes

### v.0.1.0.56
* Corrected settings for Open and Save dialogs.
* Move get Internet code to it's own function
* Changed App update info url to a dynamic file

### v.0.1.0.55
* No saber detected, update firmware failed, was trying to access a 
  closed serial port, fixed

### v.0.1.0.54
* Changed Colour Picker Buttons to TColorButton
* Put color maths into functions RGBtoRGBW, RGBWtoRGB to allow future color correction
* Menu option to refresh ports
* Menu option to check for Gilthoniel Updates, download and install
  checks filesize and SHA1/SHA256 hashes of downloaded file for security

### v.0.1.0.53
* includes firmware json2 dated 08-Aug-2020

### v.0.1.0.52
* BUGFIX: If started with no saber connected labels remained in rgbw 
  text fields, initialise to zero
* BUGFIX: Save all settings was waiting for 17 data lines when should 
  be 18 as we added one comment/file identifier line manually
* BUGFIX: Save file-exists was asking twice, disabled custom duplicate 
  file exists dialog, use dialog built in version only
* Connect/Disconnect button labels were inconsistent, fixed

### 0.1.0.51 - Features
* BUGFIX: Save Dialogs were presenting full path, changed to filename 
  only, fixed

### 0.1.0.50 - Features
* Open/Save dialogs connect to Documents folder by default
