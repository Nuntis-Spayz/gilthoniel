# Gilthoniel -- "Starkindler" (or Radiant Star)

## Manager/Settings Software for OpenCore Light Saber Electronics

### Windows 7,8,X -- 64-bit/32-bit
The x64 an x32 executables will run standalone on windows, but do 
require the firmware subfolder to do firmware upgrades, just copying the 
binary will run - but the firmware upgrade menu option will not be 
enabled/visible.

Use the Windows installer which will install the correct 64/32 bit 
application on your system, along with the firmware folder and tools.

* Binary files available at http://sabers.amazer.uk (see right hand 
  download panel) -- Not available until after OpenCore has been released

The installer (and application) has been tested on Windows 10 (32 and 
64-bit) and Windows 7 (32 and 64-bit).

The installer does not run under Windows XP - though the core application 
itself does if you want to downlod the 32-bit binary from here and save 
it to a folder manually.

### Mac OS
Compiling for MAC OS now works with basic saber management features, update
and firmware features are under development to bring the app level in features
with the Windows version.

Download the .dmg file, open it and copy the enclosed app to Applications as is
normal on any Apple Mac

## Development

### Lazarus IDE/Free Pascal
  https://www.lazarus-ide.org/index.php?page=downloads
  
  For 64bit Windows
  -- install the 64bit compiler and then 32bit cross compiler -- recommended approach
     Project compile many modes will then build both the 64 and 32 bit executables
  
  For 32bit Windows
  -- install the 32bit compiler
  
     On 32bit Windows, if you also want to build for 64-bit Windows add 
     the 64 bit cross compiler, but you will have to adjust the compile 
     mode options in the project, so don't.

  For Mac-OS
  -- Install Lazarus Pascal per instrcutions on Lazarus Website (it's a multi-stage process and you also need the Mac-OS Xcode developer tools)

Once up and running, before you open the project you will have to use 
the online pacakage manager, in the Lazarus IDE, to install the following packages

* Synapse 40.1 (cross-platform serial library in latest MAC/Windows version)
* DCPcrypt (used to verify the digital signatures of any downloads from the internet)

### InnoScript Studio QSP (Quick Setup Pack)
  https://jrsoftware.org/isdl.php [JR Software]
  
  This program is used to package up a Windows installer with the 
  application and any ancillary files.
  
  Download the "QuickStart Pack" innosetup-qsp-6.0.5.exe
  
  During install please add the Studio and ISCrypt optional components.
  
  When editing an/the .iss file use InnoScriptStudio (not InnoScript 
  itself) to edit the file, (right click on the .iss project file) as 
  studio provides extra features such as macros and pre-processing.
  
  Version 6 does not build installers that work on Windows XP, which is 
  why the installer does not work on XP systems.

### Building the App bundle and DMG for Mac-OS
  Edit the "build-macos.command" script to update the version number.

  Running this command builds a MAC-OS application bundle and optionally creates 
  a redistributable DMG file.
