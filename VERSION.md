# Version Tracking

## Application Features
* Save and load all saber settings to a file
* Save and load settnigs for a single bank
* Update Firmware
* Manage Main and Clash colours for all eight banks
* With GUI colour picker
* Selects saber COM port automatically

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
