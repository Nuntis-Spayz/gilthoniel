#!/bin/sh
cd -- "$(dirname "$0")"

# Script Settings
version=1.02.00.01
appname=Gilthoniel
dmgfolder=gilthoniel-dmg
appfolder=$appname.app
macosfolder=$appfolder/Contents/MacOS
plistfile=$appfolder/Contents/Info.plist
appfile=Gilthoniel

clear
echo "================================================================"
echo "  App Bundle/DMG Creation script - to build version $version"
echo "================================================================"
echo "v.$version"
echo ""
echo " Please select which kind of bundle you would like to build:"
echo ""
echo " 1 > Debug App Bundle Only"
echo " 2 > Release App Bundle Only"
echo " 3 > Release App & DMG Redistributable"
echo " 0 > Exit / Cancel Builder"

read command

case $command in

  1) ;;

  2) ;;
  
  3) ;;
  
  0) echo ""
     echo "-------------------------------"
     echo "Press  cmd-W  to close Terminal"
     echo "-------------------------------"
     echo ""
     exit 0;;

  *) echo "Invalid Menu Option"
     echo ""
     echo "-------------------------------"
     echo "Press  cmd-W  to close Terminal"
     echo "-------------------------------"
     echo ""
     exit 0;;

esac  

# ------------------
# Creates the bundle
# ------------------

PkgInfoContents="Gilthoniel#"

rm -dfr $appfolder

#
if ! [ -e $appfile ]
then
  echo "$appfile does not exist"
  echo ""
  echo "-------------------------------"
  echo "Press  cmd-W  to close Terminal"
  echo "-------------------------------"
  echo ""
else
  echo "Creating $appfolder..."
  mkdir -p $appfolder/Contents/MacOS
  mkdir $appfolder/Contents/Frameworks  # optional, for including libraries or frameworks
  mkdir -p $appfolder/Contents/Resources/help/img

#
# For a debug bundle,
# Instead of copying executable into .app folder after each compile,
# simply create a symbolic link to executable.
#
  if [ $command = 1 ]; then
    ln -s ../../../$appname $macosfolder/$appname
  else
    cp $appname $macosfolder/$appname
  fi  

# Copy the resource files to the correct place
  cp *.bmp $appfolder/Contents/Resources/
  cp icon3.ico $appfolder/Contents/Resources/
  cp icon3.png $appfolder/Contents/Resources/
  cp gilthoniel.icns $appfolder/Contents/Resources/
  cp ./docs/*.* $appfolder/Contents/Resources/
  cp ./help/*.* $appfolder/Contents/Resources/help/
  cp ./help/img/*.* $appfolder/Contents/Resources/help/img/

  chmod +x firmware/tycmd
  cp ./firmware/tycmd $appfolder/Contents/Resources/
  cp ./firmware/*.hex $appfolder/Contents/Resources/
#
# Create PkgInfo file.
  echo $PkgInfoContents >$appfolder/Contents/PkgInfo
#
# Create information property list file (Info.plist).
  echo '<?xml version="1.0" encoding="UTF-8"?>' >$plistfile
  echo '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >>$plistfile
  echo '<plist version="1.0">' >>$plistfile
  echo '<dict>' >>$plistfile
  echo '  <key>CFBundleDevelopmentRegion</key>' >>$plistfile
  echo '  <string>English</string>' >>$plistfile
  echo '  <key>CFBundleExecutable</key>' >>$plistfile
  echo '  <string>'$appname'</string>' >>$plistfile
  echo '  <key>CFBundleIconFile</key>' >>$plistfile
  echo '  <string>gilthoniel.icns</string>' >>$plistfile
  echo '  <key>CFBundleIdentifier</key>' >>$plistfile
  echo '  <string>uk.amazer.gilthoniel</string>' >>$plistfile
  echo '  <key>CFBundleInfoDictionaryVersion</key>' >>$plistfile
  echo '  <string>6.0</string>' >>$plistfile
  echo '  <key>CFBundlePackageType</key>' >>$plistfile
  echo '  <string>APPL</string>' >>$plistfile
  echo '  <key>CFBundleSignature</key>' >>$plistfile
  echo '  <string>MAG#</string>' >>$plistfile
  echo '  <key>CFBundleVersion</key>' >>$plistfile
  echo '  <string>'$version'</string>' >>$plistfile
  echo '</dict>' >>$plistfile
  echo '</plist>' >>$plistfile

# Put it all into a DMG for re-distribution
  if [ $command = 3 ]; then
    rm -dfr $dmgfolder
    rm -f *.dmg
    mkdir -p $dmgfolder
    ln -s /Applications $dmgfolder/  
    cp -R $appfolder $dmgfolder
    hdiutil create tmp.dmg -ov -volname "Gilthoniel_Install" -fs HFS+ -srcfolder "./$dmgfolder/" 
    hdiutil convert tmp.dmg -format UDZO -o gilthoniel-macos-$version.dmg
    rm -f tmp.dmg
  fi  

fi

echo ""
echo "-------------------------------"
echo "Press  cmd-W  to close Terminal"
echo "-------------------------------"
echo ""    
exit 0