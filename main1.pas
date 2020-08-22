unit main1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  Buttons, ComCtrls, ActnList, ExtCtrls, LCLType, LazHelpHTML, Math, StrUtils,
  LazFileUtils, RTTICtrls, FileInfo, crt, IniFiles, fphttpclient, Process,
  simpleipc, DCPsha256, DCPmd5, DCPsha1, registry , frmHelp
  {$IF defined(MSWindows)}
  , windirs, LazSerial
  {$elseif defined(DARWIN)}
  // mac os code

  {$ENDIF}
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnDisconnect: TBitBtn;
    btnPreview2: TSpeedButton;
    btnPreview3: TSpeedButton;
    btnResetColours: TBitBtn;
    btnSendBanks: TBitBtn;
    btnSend1: TBitBtn;
    btnSend2: TBitBtn;
    btnSend3: TBitBtn;
    ColorButtonClash: TColorButton;
    ColorButtonSwing: TColorButton;
    ColorButtonMain: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBox1: TComboBox;
    ComboBank: TComboBox;
    HTMLBrowserHelpViewer1: THTMLBrowserHelpViewer;
    InfoBank: TGroupBox;
    GroupPort: TGroupBox;
    GroupBanks: TGroupBox;
    Label1: TLabel;
    labSerial: TLabel;
    labBuild: TLabel;
    labStatus: TLabel;
    Label3: TLabel;
    ledFBlue: TLabeledEdit;
    ledSwBlue: TLabeledEdit;
    ledFGreen: TLabeledEdit;
    ledCRed: TLabeledEdit;
    ledCGreen: TLabeledEdit;
    ledCBlue: TLabeledEdit;
    ledSwGreen: TLabeledEdit;
    ledFRed: TLabeledEdit;
    ledCWhite: TLabeledEdit;
    ledSwRed: TLabeledEdit;
    ledFWhite: TLabeledEdit;
    appMainMenu: TMainMenu;
    ledSwWhite: TLabeledEdit;
    Memo1: TMemo;
    menuFile: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    menuItemLicence: TMenuItem;
    N2: TMenuItem;
    menuItemCheckOnConnect: TMenuItem;
    menuItemCheckFirmwareNow: TMenuItem;
    N1: TMenuItem;
    menuItemClearLog: TMenuItem;
    miSep10: TMenuItem;
    miHelp: TMenuItem;
    miOpenPort: TMenuItem;
    miSep13: TMenuItem;
    menuAbout: TMenuItem;
    menuCheckUpdate: TMenuItem;
    menuTools: TMenuItem;
    menuConnect: TMenuItem;
    miClosePort: TMenuItem;
    menuItemRescan: TMenuItem;
    menuItemDebug: TMenuItem;
    menuItemFirmware: TMenuItem;
    miSaveBank: TMenuItem;
    miSaveAll: TMenuItem;
    miLoadBank: TMenuItem;
    miLoadAll: TMenuItem;
    menuItemExit: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    SaveDialog1: TSaveDialog;
    btnPreview1: TSpeedButton;
    SimpleIPCClient1: TSimpleIPCClient;
    TabMain: TTabSheet;
    TabClash: TTabSheet;
    TabSwing: TTabSheet;
    TrackSwBlue: TTrackBar;
    TrackSwGreen: TTrackBar;
    trackSwRed: TTrackBar;
    TrackSwWhite: TTrackBar;
    TrackFGreen: TTrackBar;
    TrackFBlue: TTrackBar;
    TrackFWhite: TTrackBar;
    trackCRed: TTrackBar;
    TrackCGreen: TTrackBar;
    TrackCBlue: TTrackBar;
    TrackCWhite: TTrackBar;
    trackFRed: TTrackBar;
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnFirmwareClick(Sender: TObject);
    procedure btnPreview1Click(Sender: TObject);
    procedure btnPreview2Click(Sender: TObject);
    procedure btnPreview3Click(Sender: TObject);
    procedure btnResetColoursClick(Sender: TObject);
    procedure btnSend1Click(Sender: TObject);
    procedure btnSend2Click(Sender: TObject);
    procedure btnSend3Click(Sender: TObject);
    procedure btnSendBanksClick(Sender: TObject);
    procedure ColorButtonClashClick(Sender: TObject);
    procedure ColorButtonClashColorChanged(Sender: TObject);
    procedure ColorButtonMainClick(Sender: TObject);
    procedure ColorButtonMainColorChanged(Sender: TObject);
    procedure ColorButtonSwingClick(Sender: TObject);
    procedure ColorButtonSwingColorChanged(Sender: TObject);
    procedure ComboBankSelect(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure menuCheckUpdateClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure menuItemCheckFirmwareNowClick(Sender: TObject);
    procedure menuItemCheckOnConnectClick(Sender: TObject);
    procedure menuItemClearLogClick(Sender: TObject);
    procedure menuItemFirmwareClick(Sender: TObject);
    procedure menuItemExitClick(Sender: TObject);
    procedure menuItemDebugClick(Sender: TObject);
    procedure menuItemLicenceClick(Sender: TObject);
    procedure menuItemRescanClick(Sender: TObject);
    procedure miLoadAllClick(Sender: TObject);
    procedure miLoadBankClick(Sender: TObject);
    procedure miSaveAllClick(Sender: TObject);
    procedure miSaveBankClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RxData(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ledCRedChange(Sender: TObject);
    procedure TrackCBlueChange(Sender: TObject);
    procedure TrackCGreenChange(Sender: TObject);
    procedure trackCRedChange(Sender: TObject);
    procedure TrackCWhiteChange(Sender: TObject);
    procedure TrackFBlueChange(Sender: TObject);
    procedure TrackFGreenChange(Sender: TObject);
    procedure trackFRedChange(Sender: TObject);
    procedure TrackFWhiteChange(Sender: TObject);
    procedure TrackSwBlueChange(Sender: TObject);
    procedure TrackSwGreenChange(Sender: TObject);
    procedure trackSwRedChange(Sender: TObject);
    procedure TrackSwWhiteChange(Sender: TObject);
  private
    appVersion : String;
    validatedPort:String;
    serialInput:String;
    saveMode: Boolean;
    saveData: TStringList;
    defWidth, defHeight : Integer;
    {$IF defined(MSWindows)}
     winSerial: TLazSerial;
    {$elseif defined(DARWIN)}
    // mac os code

    {$ENDIF}
    procedure OpenSerial(Sender: TObject);
    procedure CloseSerial();
    procedure doFirmware(Sender: TObject);
    procedure loadFirmware(Sender:Tobject; filename:String);
    procedure checkFirmwareNow(Sender: TObject; silent:boolean);
    procedure WriteLn(msg: String);
    procedure DecColorStringtoBank(s:String);
    procedure HexColorStringtoBank(s:String);
    procedure DecClashStringtoBank(s:String);
    procedure HexClashStringtoBank(s:String);
    procedure DecSwingStringtoBank(s:String);
    procedure HexSwingStringtoBank(s:String);
    function RGBWtoRGB(red,green,blue,white: Integer) : Integer;
    function RGBtoRGBW(red,green,blue:Integer) : Integer;
    function md5Encrypt(fileName: String): String;
    function sha1Encrypt(fileName: String): String;
    function sha256Encrypt(fileName: String): String;
    procedure ZeroMemory(Destination: Pointer; Length: DWORD);
    function stringFromURL(url: String) : String;
    function iniFromURL(url: String) : TIniFile;
    procedure showHtml(title, url:String);

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
Info: TVersionInfo;
fpath : String;
bInstalled: Boolean;
begin
  defWidth:=0;
  defHeight:=0;

  saveMode:=false;
  saveData := TStringList.Create;
  saveData.Clear;

  self.Width:=1500;
  self.Height:=800;

  PageControl1.TabIndex:=0;

  fpath:=ExtractFilePath(Application.ExeName)+'firmware\';
  bInstalled:= FileExists(fpath+'upload.cmd') and FileExists(fpath+'tycmd.exe');
  //if the firmware directory files don't exist disable the firmware and update menu options
  menuItemFirmware.Visible := bInstalled;
  menuItemCheckFirmwareNow.Visible := bInstalled;
  menuItemCheckOnConnect.Visible := bInstalled;
  menuCheckUpdate.Visible  := bInstalled;

  btnPreview1.Caption:='Preview'+#13+'On Saber';
  //btnPreview1.Visible:=false;
  //btnPreview2.Visible:=false;
  //btnPreview3.Visible:=false;

  ColorButtonMain.Caption:='Pick Main '+#13+'Colour ';
  ColorButtonClash.Caption:='Pick Clash '+#13+'Colour ';
  ColorButtonSwing.Caption:='Pick Swing '+#13+'Colour ';

  serialInput:='';

  Memo1.Visible:=menuItemDebug.Checked;

  ledCRed.Caption:='0';
  ledCGreen.Caption:='0';
  ledCBlue.Caption:='0';
  ledCWhite.Caption:='0';

  ledFRed.Caption:='0';
  ledFGreen.Caption:='0';
  ledFBlue.Caption:='0';
  ledFWhite.Caption:='0';

  ledSwRed.Caption:='0';
  ledSwGreen.Caption:='0';
  ledSwBlue.Caption:='0';
  ledSwWhite.Caption:='0';

  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  // grab the Numbers
  //[0] = Major version, [1] = Minor ver, [2] = Revision, [3] = Build Number
  appVersion:= IntToStr(Info.FixedInfo.FileVersion[0])
      +'.'+IntToStr(Info.FixedInfo.FileVersion[1])
      +'.'+IntToStr(Info.FixedInfo.FileVersion[2])
      +'.'+IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;
  // Update the title string - include the version & ver #
  Form1.Caption := Form1.Caption+' v.' + appVersion;

  OpenSerial(Sender);

end;

procedure TForm1.OpenSerial(Sender: TObject);
var
  I:integer;
  {$IF defined(MSWindows)}
  Reg:TRegistry;
  {$elseif defined(DARWIN)}
  // mac os code to be done, fetch list of ports
  {$ENDIF}
  lastItem:String;
  rs, cs:String;
begin
 lastItem:='';
 ComboBox1.Items.Clear;
 {$IF defined(MSWindows)}
 // code for all kinds of windows
 Reg := TRegistry.Create;
 try
   Reg.RootKey := HKEY_LOCAL_MACHINE;
   if Reg.OpenKeyReadOnly('HARDWARE\DEVICEMAP\SERIALCOMM') then
   begin
     for I:=0 to 99 do
     begin
       // both anima and opencore present as --> \Device\USBSER000
       rs:='\Device\USBSER' + InttoStr(I).PadLeft(3,'0');

       //Memo1.Append(rs);
       if (reg.ValueExists(rs))then
       begin
         cs:= reg.ReadString(rs);
         Memo1.Append(cs+' : '+rs);
         ComboBox1.Items.Append(cs);
         lastItem:=cs;
       end;
     end;

   end;
   finally
     Reg.Free;
   end;
   //rNames.Free;
   //rData.Free;
   {$elseif defined(DARWIN)}
   // mac os code to be done, fetch list of ports

   {$ENDIF}

   //temporarily disabled for non-windows
   {$IF defined(MSWindows)}
   if(lastItem.IsEmpty()) then
   begin
     //ComboBox1.Items.Add('--');
     if MessageDlg(Form1.Caption,
                'No USB Sabers Ports Detected.'+#13+#13
                +'Connect an OpenCore saber.'+#13
                +'Use a Good Quality USB Cable that is for Data.'+#13+#13
                +'Do you wish to Start '+Form1.Caption+' anyway?',
                     mtConfirmation, [mbYes, mbNo],0) = mrNo then
     begin
       //exit application
       Application.Terminate;
       Halt; //<< ^Terminate seems to work Halt is boot and braces
     end;
   end
   else
   begin
     ComboBox1.Caption:=lastItem;
     ComboBox1Select(Sender);
   end;
   {$ENDIF}

end;
procedure TForm1.CloseSerial();
begin
  {$IF defined(MSWindows)}
  if Assigned(winSerial) then
    begin
     if winSerial.Active then
     begin
       winSerial.Close();
     end;
     winSerial.OnRxData:=nil;
     winSerial.OnStatus:=nil;
     winSerial.Device:='';
     winSerial.Destroy;
     winSerial:=nil;
  end;


  {$elseif defined(DARWIN)}
  // mac os code
  //DataPortSerial,

  {$ENDIF}

  validatedPort:='';
  serialInput:='';
  GroupBanks.Enabled:=False;
  PageControl1.Enabled:=False;

  btnDisconnect.Caption:='Connect';

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  CloseSerial();
  saveData.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
var
 x,c2 : Integer;
begin
 if(self.Width<defWidth) then
   self.Width:=defWidth;
 if(self.Height<defHeight) then
    self.Height:=defHeight;

 GroupPort.Left:=5;
 GroupPort.Width:=self.Width-10;

 GroupBanks.Top:=GroupPort.height+16;

 GroupBanks.Left:=5;
 GroupBanks.Width:=(self.Width * 68 div 100)-10;
 GroupBanks.Height:=self.Height-GroupBanks.Top-10;

 btnDisconnect.left:= GroupPort.width-btnDisconnect.width-16;

 InfoBank.top:=GroupPort.height+16;
 InfoBank.left:=GroupBanks.Width+10;
 InfoBank.width:=self.Width-GroupBanks.Width-20;
 InfoBank.height:=self.Height-InfoBank.Top-10;

 Memo1.width:= InfoBank.width-20;
 Memo1.height:= InfoBank.height -Memo1.top -50 - appMainMenu.Height  ;
 labSerial.left:=Memo1.left;
 labBuild.left:=Memo1.left;

 PageControl1.Width:=GroupBanks.Width-2*PageControl1.Left;

 x:=GroupBanks.width -20;
 btnSendBanks.left:= x - btnSendBanks.width;
 //btnSendBanks.top:= GroupBanks.height - btnSendBanks.height-40 - appMainMenu.Height ;
 //btnResetColours.Top:=btnSendBanks.top;

 c2:=(x div 2)+16; // <<-- ((x-32)/2)+16 -- div is integer division

 trackFRed.width:=c2- ledFRed.width -32;
 trackFGreen.width:=trackFRed.width;
 trackFBlue.width:=trackFRed.width;
 trackFWhite.width:=trackFRed.width;

 trackCRed.width:=trackFRed.width;
 trackCGreen.width:=trackFRed.width;
 trackCBlue.width:=trackFRed.width;
 trackCWhite.width:=trackFRed.width;

 trackSwRed.width:=trackFRed.width;
 trackSwGreen.width:=trackFRed.width;
 trackSwBlue.width:=trackFRed.width;
 trackSwWhite.width:=trackFRed.width;

 ColorButtonMain.Left := trackCRed.Left + trackCRed.width + 16;
 ColorButtonClash.Left := trackFRed.Left + trackFRed.width + 16;
 ColorButtonSwing.Left := trackSwRed.Left + trackSwRed.width + 16;

 btnPreview1.Left := PageControl1.Width -16 - btnPreview1.Width;
 btnPreview2.Left := PageControl1.Width -16 - btnPreview2.Width;
 btnPreview3.Left := PageControl1.Width -16 - btnPreview3.Width;

 btnSend1.Left := TabMain.Width -16 - btnSend1.Width;
 btnSend2.Left := TabClash.Width -16 - btnSend2.Width;
 btnSend3.Left := TabSwing.Width -16 - btnSend3.Width;

end;

function TForm1.RGBWtoRGB(red,green,blue,white:Integer) : Integer;
var
 r,g,b: Integer;
 mx : Integer;
begin
 r:=red+white;
 g:=green+white;
 b:=blue+white;
 //w:=white;

 mx := Max(Max(r,g),b);
 if(mx>255) then
 begin
   mx:=mx-255;
   r:=Max(0,r-mx);
   g:=Max(0,g-mx);
   b:=Max(0,b-mx);
 end;

 RGBWtoRGB:=  r + (g shl 8) + (b shl 16) ;
end;
function TForm1.RGBtoRGBW(red,green,blue:Integer) : Integer;
var
 r,g,b,w: Integer;
begin
 r:=red;
 g:=green;
 b:=blue;
 w:=Min(Min(r,g),b);

 r:=r-w;
 g:=g-w;
 b:=b-w;

 RGBtoRGBW:= r + (g shl 8) + (b shl 16) + (w shl 24);
end;

procedure TForm1.ColorButtonMainClick(Sender: TObject);
begin
  ColorButtonMain.OnColorChanged:=@ColorButtonMainColorChanged;
end;

procedure TForm1.ColorButtonMainColorChanged(Sender: TObject);
var
 rgbw : Integer;
begin
  ColorButtonMain.OnColorChanged:=nil;

  rgbw:=RGBtoRGBW(Byte(ColorButtonMain.ButtonColor),
                  Byte(ColorButtonMain.ButtonColor shr 8),
                  Byte(ColorButtonMain.ButtonColor shr 16));


  trackCRed.Position:=Byte(rgbw);
  trackCGreen.Position:=Byte(rgbw shr 8);
  trackCBlue.Position:=Byte(rgbw shr 16);
  trackCWhite.Position:=Byte(rgbw shr 24);
end;

procedure TForm1.ColorButtonSwingClick(Sender: TObject);
begin
 ColorButtonSwing.OnColorChanged:=@ColorButtonSwingColorChanged;
end;

procedure TForm1.ColorButtonClashClick(Sender: TObject);
begin
  ColorButtonClash.OnColorChanged:=@ColorButtonClashColorChanged;
end;

procedure TForm1.ColorButtonSwingColorChanged(Sender: TObject);
var
  rgbw : Integer;
begin
  ColorButtonSwing.OnColorChanged:= nil;

  rgbw:=RGBtoRGBW(Byte(ColorButtonSwing.ButtonColor),
                  Byte(ColorButtonSwing.ButtonColor shr 8),
                  Byte(ColorButtonSwing.ButtonColor shr 16));

  trackSwRed.Position:=Byte(rgbw);
  trackSwGreen.Position:=Byte(rgbw shr 8);
  trackSwBlue.Position:=Byte(rgbw shr 16);
  trackSwWhite.Position:=Byte(rgbw shr 24);
end;

procedure TForm1.ColorButtonClashColorChanged(Sender: TObject);
var
  rgbw : Integer;
begin
  ColorButtonClash.OnColorChanged:= nil;

  rgbw:=RGBtoRGBW(Byte(ColorButtonClash.ButtonColor),
                  Byte(ColorButtonClash.ButtonColor shr 8),
                  Byte(ColorButtonClash.ButtonColor shr 16));

  trackFRed.Position:=Byte(rgbw);
  trackFGreen.Position:=Byte(rgbw shr 8);
  trackFBlue.Position:=Byte(rgbw shr 16);
  trackFWhite.Position:=Byte(rgbw shr 24);
end;

procedure TForm1.RxData(Sender: TObject);
var
 inp : String;
 k : Integer;
begin
 inp:='';
 //Memo1.Append('*');

 {$IF defined(MSWindows)}
 while winSerial.DataAvailable do
 begin
   serialInput:=serialInput + winSerial.ReadData();
 end;
 {$elseif defined(DARWIN)}
 // mac os code
 {$ENDIF}

 serialInput:=TrimLeft(serialInput);
 //Memo1.Append('>'+serialInput+'<');

 while(serialInput.Contains(char(10))) do
 begin
   //Memo1.Append('10 detected');

   inp:=serialInput.Substring(0,serialInput.IndexOf(char(10)));
   //Memo1.Append('inp:='+inp+':');

   serialInput:=TrimLeft(serialInput.Substring(inp.Length));
   //Memo1.Append('serialInput:='+serialInput+':');
   inp:=trim(inp);
   while(inp.Chars[0]<=' ') do
   begin
     inp:=inp.Substring(1);
   end;


   if(Not(inp.IsEmpty)) then
   begin
     Memo1.Append(inp);
     if( inp.StartsWith('V=1.') or inp.StartsWith('V=2.') or inp.StartsWith('V=OpenCore')) then
     begin
       {$IF defined(MSWindows)}
       validatedPort:=winSerial.Device;
       {$elseif defined(DARWIN)}
       // mac os code
       {$ENDIF}

       labStatus.Caption:='Connected.';
       btnDisconnect.Caption:='Disconnect/Save';

       ComboBank.Enabled:=True;
       btnSendBanks.Enabled:=True;
       GroupBanks.Enabled:=True;
       PageControl1.Enabled:=True;

       labBuild.Caption:='Build: '+inp;

       //writeback data saved from before a firmware update
       if (saveData.Count>0) then
       begin
         for k:=0 to (saveData.Count-1) do
         begin
           WriteLn(saveData[k]);
           Application.ProcessMessages;
           Delay(250);
         end;
         saveData.Clear;
         Application.ProcessMessages;
         Delay(250);
         WriteLn('SAVE');
       end;

       WriteLn('S?');
       WriteLn('B?');

     end
     else if inp.StartsWith('S=') then
     begin
       labSerial.Caption:=inp.Replace('S=','Serial No. ');
       if menuItemCheckOnConnect.Visible and  menuItemCheckOnConnect.Checked then
          checkFirmwareNow(Sender, true);
     end
     else if saveMode then
       saveData.Add(inp)
     else if (inp.StartsWith('B=')) then
     begin
       //labSerial.Caption:=inp.Replace('S=','Serial No. ');
       Memo1.Append('switching to live bank '+InttoStr(Ord(inp.Chars[2])-48));
       ComboBank.ItemIndex:=Ord(inp.Chars[2])-48;
       ComboBankSelect(Sender);
     end
     else if( (inp.StartsWith('c')) and (inp.Chars[2]='=') ) then
       DecColorStringtoBank(inp.Substring(3))
     else if( (inp.StartsWith('C')) and (inp.Chars[2]='=') ) then
       HexColorStringtoBank(inp.Substring(3))
     else if( (inp.StartsWith('f')) and (inp.Chars[2]='=') ) then
       DecClashStringtoBank(inp.Substring(3))
     else if( (inp.StartsWith('F')) and (inp.Chars[2]='=') ) then
       HexClashStringtoBank(inp.Substring(3))
     else if( (inp.StartsWith('w')) and (inp.Chars[2]='=') ) then
     begin
       TabSwing.TabVisible:=true;
       DecSwingStringtoBank(inp.Substring(3));
     end
     else if( (inp.StartsWith('W')) and (inp.Chars[2]='=') ) then
     begin
       TabSwing.TabVisible:=true;
       HexSwingStringtoBank(inp.Substring(3));
     end;


   end; //inp not empty

 end; //while contains 13
end;

procedure TForm1.DecColorStringtoBank(s:String);
var
  colours: Array of String;
begin
  colours:=s.Split(',');
  ledCRed.Caption:=colours[0];
  ledCGreen.Caption:=colours[1];
  ledCBlue.Caption:=colours[2];
  ledCWhite.Caption:=colours[3];
end;

procedure TForm1.HexColorStringtoBank(s:String);
begin
  //hex values
  trackCRed.Position:=Hex2Dec(s.Substring(0,2));
  trackCGreen.Position:=Hex2Dec(s.Substring(2,2));
  trackCBlue.Position:=Hex2Dec(s.Substring(4,2));
  trackCWhite.Position:=Hex2Dec(s.Substring(6,2));
end;

procedure TForm1.DecClashStringtoBank(s:String);
var
  colours: Array of String;
begin
  colours:=s.Split(',');
  ledFRed.Caption:=colours[0];
  ledFGreen.Caption:=colours[1];
  ledFBlue.Caption:=colours[2];
  ledFWhite.Caption:=colours[3];
end;

procedure TForm1.HexClashStringtoBank(s:String);
begin
  //hex values
  trackFRed.Position:=Hex2Dec(s.Substring(0,2));
  trackFGreen.Position:=Hex2Dec(s.Substring(2,2));
  trackFBlue.Position:=Hex2Dec(s.Substring(4,2));
  trackFWhite.Position:=Hex2Dec(s.Substring(6,2));
end;

procedure TForm1.DecSwingStringtoBank(s:String);
var
  colours: Array of String;
begin
  colours:=s.Split(',');
  ledSwRed.Caption:=colours[0];
  ledSwGreen.Caption:=colours[1];
  ledSwBlue.Caption:=colours[2];
  ledSwWhite.Caption:=colours[3];
end;

procedure TForm1.HexSwingStringtoBank(s:String);
begin
  //hex values
  trackSwRed.Position:=Hex2Dec(s.Substring(0,2));
  trackSwGreen.Position:=Hex2Dec(s.Substring(2,2));
  trackSwBlue.Position:=Hex2Dec(s.Substring(4,2));
  trackSwWhite.Position:=Hex2Dec(s.Substring(6,2));
end;

procedure TForm1.ledCRedChange(Sender: TObject);
var
 i:LongInt;
 capt:String;
begin

  if(TryStrToInt((Sender as TLabeledEdit).Caption,i)) then
  begin
   if(i<0) then
     i:=0;
   if(i>255) then
     i:=255;

   capt:=(Sender as TLabeledEdit).EditLabel.Caption;

   if(capt.Contains('Col')) then
   begin
    if(capt.Contains('Red') and (trackCRed.Position<>i)) then
        trackCRed.Position:=i;
    if(capt.Contains('Green') and (trackCGreen.Position<>i)) then
        trackCGreen.Position:=i;
    if(capt.Contains('Blue') and (trackCBlue.Position<>i)) then
        trackCBlue.Position:=i;
    if(capt.Contains('White') and (trackCWhite.Position<>i)) then
        trackCWhite.Position:=i;
   end;
   if(capt.Contains('Cla')) then
   begin
    if(capt.Contains('Red') and (trackFRed.Position<>i)) then
        trackFRed.Position:=i;
    if(capt.Contains('Green') and (trackFGreen.Position<>i)) then
        trackFGreen.Position:=i;
    if(capt.Contains('Blue') and (trackFBlue.Position<>i)) then
        trackFBlue.Position:=i;
    if(capt.Contains('White') and (trackFWhite.Position<>i)) then
        trackFWhite.Position:=i;
   end;
   if(capt.Contains('Swi')) then
   begin
    if(capt.Contains('Red') and (trackSwRed.Position<>i)) then
        trackSwRed.Position:=i;
    if(capt.Contains('Green') and (trackSwGreen.Position<>i)) then
        trackSwGreen.Position:=i;
    if(capt.Contains('Blue') and (trackSwBlue.Position<>i)) then
        trackSwBlue.Position:=i;
    if(capt.Contains('White') and (trackSwWhite.Position<>i)) then
        trackSwWhite.Position:=i;
   end;

  end;

  //ColorButtonMain.ButtonColor:=TColor.cre;
end;

procedure TForm1.TrackCBlueChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCBlue.Position);
 if(ledCBlue.Caption<>s) then
   ledCBlue.Caption:=s;

 Application.ProcessMessages;
 ColorButtonMain.ButtonColor:=RGBWtoRGB(trackCRed.Position,
                                  trackCGreen.Position,
                                  trackCBlue.Position,
                                  trackCWhite.Position);
end;

procedure TForm1.TrackCGreenChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCGreen.Position);
 if(ledCGreen.Caption<>s) then
   ledCGreen.Caption:=s;

  Application.ProcessMessages;
  ColorButtonMain.ButtonColor:=RGBWtoRGB(trackCRed.Position,
                                  trackCGreen.Position,
                                  trackCBlue.Position,
                                  trackCWhite.Position);
end;

procedure TForm1.trackCRedChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCRed.Position);
 if(ledCRed.Caption<>s) then
   ledCRed.Caption:=s;

 Application.ProcessMessages;
 ColorButtonMain.ButtonColor:=RGBWtoRGB(trackCRed.Position,
                                  trackCGreen.Position,
                                  trackCBlue.Position,
                                  trackCWhite.Position);
end;

procedure TForm1.TrackCWhiteChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCWhite.Position);
 if(ledCWhite.Caption<>s) then
   ledCWhite.Caption:=s;

 Application.ProcessMessages;
 ColorButtonMain.ButtonColor:=RGBWtoRGB(trackCRed.Position,
                                  trackCGreen.Position,
                                  trackCBlue.Position,
                                  trackCWhite.Position);
end;

procedure TForm1.TrackFBlueChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFBlue.Position);
 if(ledFBlue.Caption<>s) then
   ledFBlue.Caption:=s;

 Application.ProcessMessages;
 ColorButtonClash.ButtonColor:=RGBWtoRGB(trackFRed.Position,
                                  trackFGreen.Position,
                                  trackFBlue.Position,
                                  trackFWhite.Position);
end;

procedure TForm1.TrackFGreenChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFGreen.Position);
 if(ledFGreen.Caption<>s) then
   ledFGreen.Caption:=s;

 Application.ProcessMessages;
 ColorButtonClash.ButtonColor:=RGBWtoRGB(trackFRed.Position,
                                  trackFGreen.Position,
                                  trackFBlue.Position,
                                  trackFWhite.Position);
end;

procedure TForm1.trackFRedChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFRed.Position);
 if(ledFRed.Caption<>s) then
   ledFRed.Caption:=s;

 Application.ProcessMessages;
 ColorButtonClash.ButtonColor:=RGBWtoRGB(trackFRed.Position,
                                  trackFGreen.Position,
                                  trackFBlue.Position,
                                  trackFWhite.Position);
end;

procedure TForm1.TrackFWhiteChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFWhite.Position);
 if(ledFWhite.Caption<>s) then
   ledFWhite.Caption:=s;

 Application.ProcessMessages;
 ColorButtonClash.ButtonColor:=RGBWtoRGB(trackFRed.Position,
                                  trackFGreen.Position,
                                  trackFBlue.Position,
                                  trackFWhite.Position);
end;

procedure TForm1.TrackSwBlueChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackSwBlue.Position);
 if(ledSwBlue.Caption<>s) then
   ledSwBlue.Caption:=s;

 Application.ProcessMessages;
 ColorButtonSwing.ButtonColor:=RGBWtoRGB(trackSwRed.Position,
                                  trackSwGreen.Position,
                                  trackSwBlue.Position,
                                  trackSwWhite.Position);

end;

procedure TForm1.TrackSwGreenChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackSwGreen.Position);
 if(ledSwGreen.Caption<>s) then
   ledSwGreen.Caption:=s;

 Application.ProcessMessages;
 ColorButtonSwing.ButtonColor:=RGBWtoRGB(trackSwRed.Position,
                                  trackSwGreen.Position,
                                  trackSwBlue.Position,
                                  trackSwWhite.Position);

end;

procedure TForm1.trackSwRedChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackSwRed.Position);
 if(ledSwRed.Caption<>s) then
   ledSwRed.Caption:=s;

 Application.ProcessMessages;
 ColorButtonSwing.ButtonColor:=RGBWtoRGB(trackSwRed.Position,
                                  trackSwGreen.Position,
                                  trackSwBlue.Position,
                                  trackSwWhite.Position);
end;

procedure TForm1.TrackSwWhiteChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackSwWhite.Position);
 if(ledSwWhite.Caption<>s) then
   ledSwWhite.Caption:=s;

 Application.ProcessMessages;
 ColorButtonSwing.ButtonColor:=RGBWtoRGB(trackSwRed.Position,
                                  trackSwGreen.Position,
                                  trackSwBlue.Position,
                                  trackSwWhite.Position);
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  labStatus.Caption:='Not an Open Core Saber';
  labBuild.Caption:='Build: --';
  labSerial.Caption:='Serial No.: --';
  validatedPort:='';
  serialInput:='';

  ComboBank.Enabled:=False;
  btnSendBanks.Enabled:=False;
  GroupBanks.Enabled:=False;

  PageControl1.Enabled:=false;
  PageControl1.TabIndex:=0;
  TabSwing.TabVisible:=false;

  btnDisconnect.Caption:='Disconnect/Save';

  if((ComboBox1.Caption<>'') and (ComboBox1.Caption<>'--')) then
  begin
    CloseSerial();

    winSerial := TLazSerial.Create(Form1);
    winSerial.OnRxData:=@ RxData;


    //Memo1.Clear;
    Memo1.Append('-----------------');
    Memo1.Append('Opening '+ComboBox1.Caption);

    {$IF defined(MSWindows)}
    winSerial.Device:=ComboBox1.Caption;

    winSerial.Open();
    winSerial.SynSer.DeadlockTimeout:=10;

    Sleep(1400);
    if winSerial.Active then
    begin
      WriteLn('V?');
    end;
    {$elseif defined(DARWIN)}
    // mac os code
    {$ENDIF}

  end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if defWidth=0 then
      defWidth:=self.Width;
  if defHeight=0 then
      defHeight:=self.Height;
end;

procedure TForm1.menuAboutClick(Sender: TObject);
begin
 showHtml('','help/about.html');
 // MessageDlg(Form1.Caption,
 //               Form1.Caption+#13+#13
 //               +'Settings Manager for OpenCore Saber'+#13
 //               +'(C) MMXX Nuntis'+#13+#13
 //               +'http://sabers.amazer.uk',
 //                    mtInformation, [mbOK],0);
end;

function TForm1.stringFromURL(url: String) : String;
var
  httpresult : String;
  cli : TFPHTTPClient;
begin
 cli := TFPHTTPClient.Create(nil);
 cli.AddHeader('User-Agent','Mozilla/5.0 (compatible; fpweb)');
 httpresult:='';
 try
   try
     httpresult:= cli.Get(url+'?xrnd='+InttoStr(Math.RandomRange(10000,99999)));
   except
     on E: Exception do
     begin
     Memo1.Append('Web exception raised: ' + E.Message);
     httpresult:='';
     end;
   end;
 finally
   cli.free
 end;

 stringFromURL := httpresult;
end;

function TForm1.iniFromURL(url: String) : TIniFile;
var
  str : String;
begin
 str:=stringFromURL(url);

 if str.IsEmpty then
   iniFromURL := nil
 else
   iniFromURL := TIniFile.Create(TStringStream.Create(str), false);

end;

procedure TForm1.menuCheckUpdateClick(Sender: TObject);
var
 ini : TIniFile;
 changes, newv, url, OS, fExec : String;
 bvis : Boolean;
 aProcess : TProcess;
 fSize, dSize : Int64;
 //efile : file of byte;
 Info : TSearchRec;
 cli : TFPHTTPClient;
begin
  OS:='windows';

  ini:=iniFromURL('http://sabers.amazer.uk/files/gilthoniel/release.php');

  if Not(Assigned(ini)) then
  begin
    MessageDlg('Update Check',
               'Update Check Failed, see debug log',
                mtConfirmation, [mbOK],0);
  end
  else
  begin
    //[windows]
    //v=0.1.0.53
    //changes=Beta Firmware OpenCore.1.9.13_20200808_json3.hex
    //url=http://sabers.amazer.uk/files/gilthoniel/install_gilthoniel_0.1.0.53.exe
    //size=12345667
    //sha1=...
    //sha256=...

    newv:=ini.ReadString(OS,'v','');
    if newv<>appVersion then
    begin
      changes:=ini.ReadString(OS,'changes','');

      if(MessageDlg('New Version',
                    'There is a new version available,v= '+newv+#13
                    +#13+'New Features include...'+#13+changes+#13
                    +#13+'You have version '+appVersion+#13
                    +#13+'Do you want to download & update Gilthoniel?',
                    mtConfirmation, [mbYes, mbNo],0)= mrYes ) then
      begin
        bvis:=Memo1.Visible;
        Memo1.Visible:=true;
        Memo1.SelStart := Length(Memo1.Lines.Text);
        url:=ini.ReadString(OS,'url','');
        Memo1.Append('fetching url: '+url);
        fSize:= ini.ReadInt64(OS,'size',0);

        cli := TFPHTTPClient.Create(nil);
        cli.AddHeader('User-Agent','Mozilla/5.0 (compatible; fpweb)');
        try
          try
            begin
              fExec:=GetTempDir(true)+'\install_gilthoniel_'+newv+'.exe';
              DeleteFile(fExec);

              cli.Get(url,fExec);
              Memo1.Append(fExec);
              Memo1.Append('Download successful');

              dSize:=0;
              if FileExists(fExec) and (FindFirst (fExec,faAnyFile,Info)=0 ) then
              begin
                dSize:=Info.Size;
                FindClose(Info);
                Memo1.Append('Downloaded File Size: '+IntToStr(dSize));
              end;

              //add crc checks here
              //ini.ReadString(OS,'url','');
              //Memo1.Append('md5 # '+md5Encrypt(fExec));
              if sha1Encrypt(fExec)<>ini.ReadString(OS,'sha1','') then
              begin
                Memo1.Append('SHA1 file check invalid');
                dSize:=-1
              end;
              if sha256Encrypt(fExec)<>ini.ReadString(OS,'sha256','') then
              begin
                Memo1.Append('SHA256 file check invalid');
                dSize:=-2
              end;

              if(dSize=fSize) then
              begin
                Memo1.Append('Running Updater');

                aProcess := TProcess.Create(nil);
                aProcess.Executable:= fExec;
                //aProcess.Parameters.Add('-silent');
                //aProcess.Options := aProcess.Options + [poWaitOnExit];
                aProcess.Options := aProcess.Options - [poWaitOnExit];
                aProcess.Execute;
                Memo1.Append('Updater is Running');
                Application.ProcessMessages;
                //aProcess.Free; //doing this will wait for the process which we do not want

                //now exit the application the updater is running
                Application.Terminate;
                Halt;
              end;

              if(dSize<>fSize) then
              begin
                MessageDlg('Update',
                   'Downloaded file is incomplete/unverified.'+#13+'Update Aborted, please retry',
                   mtConfirmation, [mbOK],0);
              end;

              DeleteFile(fExec);
            end;

          except
            on E: Exception do
            begin
              Memo1.Append('Web exception raised: ' + E.Message);
              MessageDlg('Update',
                   'Downloaded file failed.'+#13+E.Message+#13+'Update Aborted, please retry',
                   mtConfirmation, [mbOK],0);
            end;
         end;
        finally
          cli.free
        end;
        Memo1.Visible:=bvis;
      end;
    end
    else
    begin
       MessageDlg('Current Version',
                   'You have the current version of Gilthoniel'+#13+'v= '+newv,
                   mtConfirmation, [mbOK],0);
    end;

    ini.Free;
  end;

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  showHtml('', 'help/index.html');
end;

procedure TForm1.menuItemCheckFirmwareNowClick(Sender: TObject);
begin
  checkFirmwareNow(Sender, false);
end;

procedure TForm1.checkFirmwareNow(Sender: TObject; silent:boolean);
var
 ini : TIniFile;
 newv, sver, fExec, url : String;
 cli : TFPHTTPClient;
 dSize, fSize :Int64;
 Info : TSearchRec;
begin
  if not(assigned(winSerial)) or Not(winSerial.Active) then
  begin
    if Not(silent) then
    begin
      MessageDlg('Update Check',
               'No saber connected',
                mtConfirmation, [mbOK],0);
    end;
    exit;
  end;

  ini:=form1.iniFromURL('http://sabers.amazer.uk/files/firmware/release.php');
  if Not(Assigned(ini)) or (ini=nil) then
  begin
    if Not(silent) then
    begin
      MessageDlg('Update Check',
               'Update Check Failed, see debug log',
                mtConfirmation, [mbOK],0);
    end;
  end
  else
  begin
    newv:=ini.ReadString('master','v','');
    if newv.IsEmpty then
    begin
      if Not(silent) then
      begin
        MessageDlg('Update Check',
               'Update Check Failed, see debug log',
                mtConfirmation, [mbOK],0);
      end;
    end
    else
    begin
      sver:=labBuild.Caption;
      if sver.EndsWith(newv) then
      begin
        if Not(silent) then
        begin
          MessageDlg('Update Check',
               'You have the current Firmware'+#13+'v.'+newv,
                mtConfirmation, [mbOK],0)
        end;
      end
      else
      begin
        url:=ini.ReadString('master','url','');
        if (MessageDlg('Update',
                 'Do you wish to Update Firmware to '+#13
                 + ExtractFileName(url)+' ?',
                 mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
        begin
          cli := TFPHTTPClient.Create(nil);
          cli.AddHeader('User-Agent','Mozilla/5.0 (compatible; fpweb)');
          try
            try
              begin
                fExec:=GetTempDir(true)+'\opencore.'+newv+'.hex';
                DeleteFile(fExec);
                fSize:=ini.ReadInt64('master','size',0);

                cli.Get(url,fExec);
                Memo1.Append(fExec);
                Memo1.Append('Download successful');

                dSize:=0;
                if FileExists(fExec) and (FindFirst (fExec,faAnyFile,Info)=0 ) then
                begin
                  dSize:=Info.Size;
                  FindClose(Info);
                  Memo1.Append('Downloaded File Size: '+IntToStr(dSize));
                end;

                //add crc checks here
                //ini.ReadString(OS,'url','');
                //Memo1.Append('md5 # '+md5Encrypt(fExec));
                if sha1Encrypt(fExec)<>ini.ReadString('master','sha1','') then
                begin
                  Memo1.Append('SHA1 file check invalid');
                  dSize:=-1
                end;
                if sha256Encrypt(fExec)<>ini.ReadString('master','sha256','') then
                begin
                  Memo1.Append('SHA256 file check invalid');
                  dSize:=-2
                end;

                if(dSize=fSize) then
                begin
                  Memo1.Append('Running Updater');
                  loadFirmware(Sender, fExec);
                end;

                if(dSize<>fSize) then
                begin
                  MessageDlg('Update',
                     'Downloaded file is incomplete/unverified.'+#13+'Update Aborted, please retry',
                     mtConfirmation, [mbOK],0);
                end;

                DeleteFile(fExec);
              end;
            except
                on E: Exception do
              begin
                Memo1.Append('Web exception raised: ' + E.Message);
                MessageDlg('Update',
                     'Downloaded file failed.'+#13+E.Message+#13+'Update Aborted, please retry',
                     mtConfirmation, [mbOK],0);
              end;
           end;
          finally
            cli.free
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm1.menuItemCheckOnConnectClick(Sender: TObject);
begin
  menuItemCheckOnConnect.Checked:= Not(menuItemCheckOnConnect.Checked);
end;

procedure TForm1.menuItemClearLogClick(Sender: TObject);
begin
 if (MessageDlg('Debug Log',
                   'Do you wish to clear the debug log ?',
                   mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
     Memo1.Clear;
end;

procedure TForm1.menuItemFirmwareClick(Sender: TObject);
begin
  doFirmware(Sender);
end;

procedure TForm1.menuItemExitClick(Sender: TObject);
begin
  // Exit Quit
  Form1.Close;
end;

procedure TForm1.menuItemDebugClick(Sender: TObject);
begin
  menuItemDebug.Checked:= Not(menuItemDebug.Checked);

  Memo1.Visible:=menuItemDebug.Checked;
  Memo1.SelStart := Length(Memo1.Lines.Text);
  FormResize(Sender);
end;

procedure TForm1.menuItemLicenceClick(Sender: TObject);
begin
  showHtml('Gilthoniel Licence','help/licence.html');
end;

procedure TForm1.showHtml(title, url:String);
var
 fh : TFormHelp;
begin
  fh := TFormHelp.Create(self);
  fh.Width:= self.Width * 9 div 10;
  fh.Height:= self.Height * 8 div 10;

  fh.OpenShow(title, url);
end;


procedure TForm1.menuItemRescanClick(Sender: TObject);
begin
  OpenSerial(Sender);
end;

procedure TForm1.miLoadAllClick(Sender: TObject);
var
 k: Integer;
begin
  OpenDialog1.Filter:='OpenCore Settings|*.openCoreSettings';
  OpenDialog1.Options:=OpenDialog1.Options + [ofFileMustExist, ofEnableSizing, ofDontAddToRecent];

  {$IF defined(MSWindows)}
  OpenDialog1.InitialDir:=GetWindowsSpecialDir(CSIDL_PERSONAL);
  {$elseif defined(DARWIN)}
  OpenDialog1.InitialDir:=AppendPathDelim(GetUserDir + 'Documents');
  {$ENDIF}
  OpenDialog1.FileName:='';

  OpenDialog1.Title:='Select an OpenCoreSettings File';

  if OpenDialog1.Execute then
  begin
    saveMode:=false;
    saveData.Clear;
    saveData.LoadFromFile(OpenDialog1.FileName);
    if (saveData.Count>0) then
    begin
      for k:=0 to (saveData.Count-1) do
      begin
        if Not(saveData[k].StartsWith('#')) and Not(saveData[k].StartsWith('!'))then
          WriteLn(saveData[k]);

        Application.ProcessMessages;
      end;
      saveData.Clear;
      writeLn('B?');
    end;

  end;
end;

procedure TForm1.miLoadBankClick(Sender: TObject);
var
 k : Integer;
begin
  OpenDialog1.Filter:='OpenCore Bank|*.openCoreBank';
  OpenDialog1.Options:=OpenDialog1.Options + [ofFileMustExist, ofEnableSizing, ofDontAddToRecent];
  //ofOldStyleDialog

  OpenDialog1.Title:='Select an OpenCoreBank File';
  {$IF defined(MSWindows)}
  OpenDialog1.InitialDir:=GetWindowsSpecialDir(CSIDL_PERSONAL);
  {$elseif defined(DARWIN)}
  OpenDialog1.InitialDir:=AppendPathDelim(GetUserDir + 'Documents');
  {$ENDIF}
  OpenDialog1.FileName:='';

  if OpenDialog1.Execute then
  begin
    saveMode:=false;
    saveData.Clear;
    saveData.LoadFromFile(OpenDialog1.FileName);

    if (saveData.Count>0) then
    begin
      for k:=0 to (saveData.Count-1) do
      begin
        if saveData[k].StartsWith('c=') then
          DecColorStringtoBank(saveData[k].Substring(2))
        else if saveData[k].StartsWith('C=') then
          HexColorStringtoBank(saveData[k].Substring(2))
        else if saveData[k].StartsWith('f=') then
          DecClashStringtoBank(saveData[k].Substring(2))
        else if saveData[k].StartsWith('F=') then
          HexClashStringtoBank(saveData[k].Substring(2))
        else if saveData[k].StartsWith('w=') then
          DecSwingStringtoBank(saveData[k].Substring(2))
        else if saveData[k].StartsWith('W=') then
          HexSwingStringtoBank(saveData[k].Substring(2));

        Application.ProcessMessages;
      end;
      saveData.Clear;
    end;
  end;

end;

procedure TForm1.miSaveAllClick(Sender: TObject);
var
 fname:String;
 getlines, abort : Integer;
begin
  {$IF defined(MSWindows)}
  //Memo1.Append(GetWindowsSpecialDir(CSIDL_PERSONAL));
  SaveDialog1.InitialDir:=GetWindowsSpecialDir(CSIDL_PERSONAL);//CSIDL_COMMON_DOCUMENTS);
  {$elseif defined(DARWIN)}
  SaveDialog1.InitialDir:=AppendPathDelim(GetUserDir + 'Documents');
  {$ENDIF}
  SaveDialog1.Filter:='OpenCore Settings|*.openCoreSettings';
  SaveDialog1.Options:=SaveDialog1.Options + [ofEnableSizing, ofDontAddToRecent];
  //ofOldStyleDialog

  SaveDialog1.Title:='Select an OpenCoreSettings File';
  SaveDialog1.FileName:= 'unnamed.openCoreSettings';

  if SaveDialog1.Execute then
  begin
    fname:=SaveDialog1.Filename;
     if Not(SaveDialog1.Filename.EndsWith('.openCoreSettings')) then
       fname:=SaveDialog1.Filename+'.openCoreSettings';

     //Use the built in file exists option in the dialog
     //if FileExists(fname) then
     //begin
     //  if (MessageDlg('Save Bank',
     //              ExtractFileName(fname)+' already Exists,'+#13+#13
     //              +'Do you wish to overwrite it ?',
     //              mtConfirmation, [mbYes, mbNo],0) = mrNo ) then
     //    fname:='';
     //end;
     if Not(fname.IsEmpty) then
     begin
       //save current bank to saber
      saveMode:=true;
      saveData.Clear;
      btnSendBanksClick(Sender);
      //expecting two responses
      while (saveData.Count<2) do
      begin
        Application.ProcessMessages;
        Delay(100);
      end;

      saveMode:=true;
      saveData.Clear;
      saveData.Add('#filetype=Giltoniel Saber Settings');
      WriteLn('B?');
      WriteLn('w?');
      WriteLn('c?');
      WriteLn('f?');

      getlines:=18;
      if tabSwing.TabVisible then
         getlines:=26;

      abort:=0;
      while (saveData.Count<getlines) and (abort<4096) and (WinSerial.Active) do
      begin
        Application.ProcessMessages;
        Delay(10);
        abort:=abort+1;
        Memo1.Append('#'+IntToStr(saveData.Count)+'/'+IntToStr(getlines)+' : '+IntToStr(abort));
      end;
      if (abort>=4096) or Not(WinSerial.Active) then
      begin
        saveData.Clear;
        Memo1.append('Saving data from saber timed out.');
        Memo1.append('Save settings aborted.');
        MessageDlg('Save Saber Settings',
                   'Saving data from saber timed out,'+#13+#13
                   +'Save settings aborted.',
                   mtConfirmation, [mbOK],0);
        exit;
      end;

      saveMode:=false;
      saveData.SaveToFile(fname);
      saveData.Clear;

     end;
  end;
end;

procedure TForm1.miSaveBankClick(Sender: TObject);
var
 fname:String;
begin
   SaveDialog1.Filter:='OpenCore Bank|*.openCoreBank';
   SaveDialog1.Options:=SaveDialog1.Options + [ofEnableSizing, ofDontAddToRecent];
   SaveDialog1.Title:='Select an OpenCoreBank File';
   {$IF defined(MSWindows)}
   //Memo1.Append(GetWindowsSpecialDir(CSIDL_PERSONAL));
   OpenDialog1.InitialDir:=GetWindowsSpecialDir(CSIDL_PERSONAL); //CSIDL_COMMON_DOCUMENTS);
   {$elseif defined(DARWIN)}
   OpenDialog1.InitialDir:=AppendPathDelim(GetUserDir + 'Documents');
   {$ENDIF}
   SaveDialog1.FileName:='unnamed.openCoreBank';

   if SaveDialog1.Execute then
   begin
     fname:=SaveDialog1.Filename;
     if Not(SaveDialog1.Filename.EndsWith('.openCoreBank')) then
       fname:=SaveDialog1.Filename+'.openCoreBank';

     // Use the built in file exists option in the dialog
     //if FileExists(fname) then
     //begin
     //  if (MessageDlg('Save Bank',
     //              ExtractFileName(fname)+' already Exists,'+#13+#13
     //              +'Do you wish to overwrite it ?',
     //              mtConfirmation, [mbYes, mbNo],0) = mrNo ) then
     //    fname:='';
     //end;
     if Not(fname.IsEmpty) then
     begin
       saveMode:=false;
       saveData.Clear;
       saveData.Add('#filetype=Giltoniel Saber Bank');
       saveData.Add('c='+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);
       saveData.Add('f='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);
       saveData.Add('w='+ledSwRed.Caption+','+ledSwGreen.Caption+','+ledSwBlue.Caption+','+ledSwWhite.Caption);

       saveData.SaveToFile(fname);
       saveData.Clear;
     end;

   end;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm1.ComboBankSelect(Sender: TObject);
var
 bank: String;
begin
  ledCRed.Caption:='';
  ledCGreen.Caption:='';
  ledCBlue.Caption:='';
  ledCWhite.Caption:='';
  ledFRed.Caption:='';
  ledFGreen.Caption:='';
  ledFBlue.Caption:='';
  ledFWhite.Caption:='';

  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);

    WriteLn('c'+bank+'?');
    WriteLn('f'+bank+'?');
    WriteLn('w'+bank+'?');
    WriteLn('B='+bank);
  end;
end;

procedure TForm1.btnSendBanksClick(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);
    WriteLn('c'+bank+'='+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);
    WriteLn('f'+bank+'='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);
    WriteLn('w'+bank+'='+ledSwRed.Caption+','+ledSwGreen.Caption+','+ledSwBlue.Caption+','+ledSwWhite.Caption);

    //request values back to confirm
    WriteLn('c'+bank+'?');
    WriteLn('f'+bank+'?');
    WriteLn('w'+bank+'?');
  end;
end;

procedure TForm1.btnFirmwareClick(Sender: TObject);
begin
 doFirmware(Sender);
end;

procedure TForm1.doFirmware(Sender: TObject);
begin
  //https://anfive.gnah.it/scintilla/?mode=opencore
  //1.9.12 XN6jGT8JyTXbxsPehWxsAYRynI6KkVcZy5oCufu1LTg= https://anfive.gnah.it/scintilla/firmware.hex

 Memo1.Append(ExtractFilePath(Application.ExeName)+'firmware');
  OpenDialog1.FileName:='';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName)+'firmware';
  OpenDialog1.Title:='Select an OpenCore Firmware HEX File';
  OpenDialog1.Filter:='Firmware HEX File|*.hex';
  OpenDialog1.Options:=OpenDialog1.Options + [ofFileMustExist, ofEnableSizing, ofDontAddToRecent];

  if OpenDialog1.Execute then
    if (MessageDlg('Update',
                 'Do you wish to Update Firmware to '+#13
                 + ExtractFileName(OpenDialog1.filename)+' ?',
                 mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
        loadFirmware(Sender, OpenDialog1.Filename);

end;
procedure TForm1.loadFirmware(Sender:Tobject; filename:String);
var
  getlines : Integer;
  abort : Integer;
begin
    //read all the settings to save back after the upgrade/downgrade
    saveMode:=true;
    saveData.Clear;
    if Assigned(winSerial) and winSerial.Active then
    begin
      WriteLn('B?');
      WriteLn('W?');
      WriteLn('C?');
      WriteLn('F?');
      getlines:=17;
      if tabSwing.TabVisible then
         getlines:=25;

      abort:=0;
      while (saveData.Count<getlines) and (abort<4096) and (WinSerial.Active) do
      begin
        Application.ProcessMessages;
        Delay(10);
        abort:=abort+1;
        Memo1.Append('#'+IntToStr(saveData.Count)+'/'+IntToStr(getlines)+' : '+IntToStr(abort));
      end;
      if (abort>=4096) or Not(WinSerial.Active) then
      begin
        saveData.Clear;
        Memo1.append('Saving data from saber timed out.');
        Memo1.append('Firmware update aborted');
        MessageDlg('Save Saber Settings',
                   'Saving data from saber timed out,'+#13+#13
                   +'Firmware update aborted.',
                   mtConfirmation, [mbOK],0);
        exit;
      end;

      CloseSerial();

      //wait to allow serial to disconnect properly
      Application.ProcessMessages;
      Delay(250);
      Application.ProcessMessages;
      Delay(250);
      Application.ProcessMessages;
    end;
    saveMode:=false;

    ExecuteProcess( ExtractFilePath(Application.ExeName)+'firmware\upload.cmd',[filename],[]);

    //wait before re-opening the serial device
    Application.ProcessMessages;
    Delay(1500);
    Application.ProcessMessages;

    OpenSerial(Sender);
    //ComboBox1Select(Sender);
end;

procedure TForm1.btnPreview1Click(Sender: TObject);
begin
  WriteLn('P='+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);
end;

procedure TForm1.btnPreview2Click(Sender: TObject);
begin
  WriteLn('P='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);
end;

procedure TForm1.btnPreview3Click(Sender: TObject);
begin
    WriteLn('P='+ledSwRed.Caption+','+ledSwGreen.Caption+','+ledSwBlue.Caption+','+ledSwWhite.Caption);
end;

procedure TForm1.btnDisconnectClick(Sender: TObject);
begin
   if (btnDisconnect.Caption='Connect') then
   begin
     btnDisconnect.Caption:='Disconnect/Save';
     labStatus.Caption:='Trying to Re-connect...';
     ComboBox1Select(Sender);
   end
   else
   begin
    {$IF defined(MSWindows)}
    if winSerial.Active  then
    begin
      WriteLn('SAVE');
      winSerial.Close();
    end;
    winSerial.Device:='';
    {$elseif defined(DARWIN)}
    // mac os code
    {$ENDIF}

     validatedPort:='';
     labStatus.Caption:='Disconnected';
     GroupBanks.Enabled:=False;
     PageControl1.Enabled:=false;

     btnDisconnect.Caption:='Connect';
   end;
end;

procedure TForm1.btnResetColoursClick(Sender: TObject);
begin
  if (MessageDlg('Reset',
                 'Do you wish to Reset all Colours to Defaults?',
                 mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
  begin

    WriteLn('RESET');
    delay(500);
    ComboBankSelect(Sender);
  end;
end;

procedure TForm1.btnSend1Click(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);
    WriteLn('c'+bank+'='+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);

    //request values back to confirm
    WriteLn('c'+bank+'?');
  end;
end;

procedure TForm1.btnSend2Click(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);
    WriteLn('f'+bank+'='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);

    //request values back to confirm
    WriteLn('f'+bank+'?');
  end;
end;

procedure TForm1.btnSend3Click(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);
    WriteLn('w'+bank+'='+ledSwRed.Caption+','+ledSwGreen.Caption+','+ledSwBlue.Caption+','+ledSwWhite.Caption);

    //request values back to confirm
    WriteLn('w'+bank+'?');
  end;
end;

procedure TForm1.WriteLn(msg:String);
begin
  Memo1.Append('>> '+msg);
  {$IF defined(MSWindows)}
  if winSerial.Active then
  begin
    winSerial.WriteData(msg+CHR(10));
  end;

  {$elseif defined(DARWIN)}
  // mac os code
  //DataPortSerial,

  //DataPortSerial1.SerialClient.SendString(msg+char(13));
  //DataPortSerial1.SerialClient.Serial.Flush;
  {$ENDIF}
end;


//------------------------ crc
function TForm1.sha256Encrypt(fileName: String): String;
var
  Hash: TDCP_sha256;
  Digest: array[0..63] of byte;
  Source: TFileStream;
  i: integer;
  s: string;
begin
  s:= '';
  // Local variable 'Digest' does not seem to be initialized Fix
  ZeroMemory(@Digest, SizeOf(Digest));
  Source:= nil;
  try
    Source:= TFileStream.Create(fileName,fmOpenRead);
  except
    MessageDlg('Unable to open file',mtError,[mbOK],0);
  end;
  if Source <> nil then
  begin
    Hash:= TDCP_sha256.Create(Self);
    Hash.Init;
    Hash.UpdateStream(Source,Source.Size);
    Hash.Final(Digest);
    Source.Free;
    s:= '';
    for i:= 0 to 31 do
      s:= s + IntToHex(Digest[i],2);

  end;
  sha256Encrypt:= s;
end;

function TForm1.sha1Encrypt(fileName: String): String;
var
  Hash: TDCP_sha1;
  Digest: array[0..39] of byte;
  Source: TFileStream;
  i: integer;
  s: string;
begin
  s:='';

  // Local variable 'Digest' does not seem to be initialized Fix
  ZeroMemory(@Digest, SizeOf(Digest));
  Source:= nil;
  try
    Source:= TFileStream.Create(fileName,fmOpenRead);
  except
    MessageDlg('Unable to open file',mtError,[mbOK],0);
  end;
  if Source <> nil then
  begin
    Hash:= TDCP_sha1.Create(Self);
    Hash.Init;
    Hash.UpdateStream(Source,Source.Size);
    Hash.Final(Digest);
    Source.Free;

    for i:= 0 to 19 do
      s:= s + IntToHex(Digest[i],2);

  end;
  sha1Encrypt:=s;
end;

function TForm1.md5Encrypt(fileName: String): String;
var
  Hash: TDCP_md5;
  Digest: array[0..31] of byte;
  Source: TFileStream;
  i: integer;
  s: string;
begin
  s:= '';
  // Local variable 'Digest' does not seem to be initialized Fix
  ZeroMemory(@Digest, SizeOf(Digest));
  Source:= nil;
  try
    Source:= TFileStream.Create(fileName,fmOpenRead);
  except
    MessageDlg('Unable to open file',mtError,[mbOK],0);
  end;
  if Source <> nil then
  begin
    Hash:= TDCP_md5.Create(Self);
    Hash.Init;
    Hash.UpdateStream(Source,Source.Size);
    Hash.Final(Digest);
    Source.Free;

    for i:= 0 to 15 do
      s:= s + IntToHex(Digest[i],2);

  end;
  md5Encrypt:=s;
end;
procedure TForm1.ZeroMemory(Destination: Pointer; Length: DWORD);
begin
  FillChar(Destination^, Length, 0);
end;

end.

