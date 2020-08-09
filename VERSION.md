# Version Tracking

## Application Features
* Save and load all saber settings to a file
* Save and load settings for a single bank
* Update Firmware
* Manage Main and Clash colours for all eight banks
* With GUI colour picker
* Selects saber COM port automatically
* Application update over the Internet

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
