# Gilthoniel -- "Radiant Star"

## Manager software for OpenCore Light Saber Electronics

### Windows 64-bit/32-bit
The x64 an x32 executables will run on windows, but require the firmware subfolder
to do firmware upgrades.

Use the Windows installer which will install the correct 64/32 bit application on your system

### Mac OS
Although some development work is happening with a Mac OS version of the application 
progress getting the serial comms to work is on-going, please be patient.


## Development

### Lazarus IDE/Free Pascal
  https://www.lazarus-ide.org/index.php?page=downloads
  
  For 64bit Windows
  -- install the 64bit compiler and then 32bit cross compiler -- recommended approach
  
  For 32bit Windows
  -- install the 32bit compiler
  
     On 32bit Windows, if you also want to build for 64-bit Windows add the 64 bit cross compiler,
     but you will have to adjust the compile mode options in the project, so don't.

### InnoScript Studio QSP (Quick Setup Pack) [JR Software]
  https://jrsoftware.org/isdl.php
  
  Download the QuickStart Pack innosetup-qsp-6.0.5.exe
  During install please add the Studio and ISCrypt optional components
