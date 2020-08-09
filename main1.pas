unit main1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  Buttons, ComCtrls, ActnList, ExtCtrls, LCLType, Math, StrUtils, LazFileUtils,
  FileInfo, crt, IniFiles, fphttpclient, Process, DCPsha256, DCPmd5, DCPsha1
  {$IF defined(MSWindows)}
  , registry, windirs, LazSerial
  {$elseif defined(DARWIN)}
  // mac os code

  {$ENDIF}
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnDisconnect: TBitBtn;
    btnResetColours: TBitBtn;
    btnSend: TBitBtn;
    ColorButtonClash: TColorButton;
    ColorButtonMain: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBox1: TComboBox;
    ComboBank: TComboBox;
    InfoBank: TGroupBox;
    GroupPort: TGroupBox;
    GroupBanks: TGroupBox;
    Label1: TLabel;
    labSerial: TLabel;
    labBuild: TLabel;
    labStatus: TLabel;
    Label3: TLabel;
    ledFBlue: TLabeledEdit;
    ledFGreen: TLabeledEdit;
    ledCRed: TLabeledEdit;
    ledCGreen: TLabeledEdit;
    ledCBlue: TLabeledEdit;
    ledFRed: TLabeledEdit;
    ledCWhite: TLabeledEdit;
    ledFWhite: TLabeledEdit;
    appMainMenu: TMainMenu;
    Memo1: TMemo;
    menuFile: TMenuItem;
    MenuItem1: TMenuItem;
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
    SaveDialog1: TSaveDialog;
    btnPreview1: TSpeedButton;
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
    procedure btnResetColoursClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure ColorButtonClashClick(Sender: TObject);
    procedure ColorButtonClashColorChanged(Sender: TObject);
    procedure ColorButtonMainClick(Sender: TObject);
    procedure ColorButtonMainColorChanged(Sender: TObject);
    procedure ComboBankSelect(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure menuCheckUpdateClick(Sender: TObject);
    procedure menuItemClearLogClick(Sender: TObject);
    procedure menuItemFirmwareClick(Sender: TObject);
    procedure menuItemExitClick(Sender: TObject);
    procedure menuItemDebugClick(Sender: TObject);
    procedure menuItemRescanClick(Sender: TObject);
    procedure miLoadAllClick(Sender: TObject);
    procedure miLoadBankClick(Sender: TObject);
    procedure miSaveAllClick(Sender: TObject);
    procedure miSaveBankClick(Sender: TObject);
    procedure RxData(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ledCRedChange(Sender: TObject);
    procedure TrackCBlueChange(Sender: TObject);
    procedure TrackCGreenChange(Sender: TObject);
    procedure trackCRedChange(Sender: TObject);
    procedure TrackCWhiteChange(Sender: TObject);
    procedure TrackFBlueChange(Sender: TObject);
    procedure TrackFGreenChange(Sender: TObject);
    procedure trackFRedChange(Sender: TObject);
    procedure TrackFWhiteChange(Sender: TObject);
  private
    appVersion : String;
    validatedPort:String;
    serialInput:String;
    saveMode: Boolean;
    saveData: TStringList;
    {$IF defined(MSWindows)}
     winSerial: TLazSerial;
    {$elseif defined(DARWIN)}
    // mac os code

    {$ENDIF}
    procedure OpenSerial(Sender: TObject);
    procedure CloseSerial();
    procedure WriteLn(msg: String);
    procedure doFirmware(Sender: TObject);
    procedure DecColorStringtoBank(s:String);
    procedure HexColorStringtoBank(s:String);
    procedure DecClashStringtoBank(s:String);
    procedure HexClashStringtoBank(s:String);
    function RGBWtoRGB(red,green,blue,white: Integer) : Integer;
    function RGBtoRGBW(red,green,blue:Integer) : Integer;
    function md5Encrypt(fileName: String): String;
    function sha1Encrypt(fileName: String): String;
    function sha256Encrypt(fileName: String): String;
    procedure ZeroMemory(Destination: Pointer; Length: DWORD);

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
  saveMode:=false;
  saveData := TStringList.Create;
  saveData.Clear;

  self.Width:=1500;
  self.Height:=800;

  fpath:=ExtractFilePath(Application.ExeName)+'firmware\';
  bInstalled:= FileExists(fpath+'upload.cmd') and FileExists(fpath+'tycmd.exe');
  //if the firmware directory files don't exist disable the firmware and update menu options
  menuItemFirmware.Visible := bInstalled;
  menuCheckUpdate.Visible  := bInstalled;

  btnPreview1.Caption:='Preview'+#13+'On Saber';
  btnPreview1.Visible:=false;

  ColorButtonMain.Caption:='Pick Main '+#13+'Colour ';
  ColorButtonClash.Caption:='Pick Clash '+#13+'Colour ';

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
 if(self.Width<1500) then
   self.Width:=1500;
 if(self.Height<800) then
   self.Height:=800;

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

 x:=GroupBanks.width -20;
 btnSend.left:= x - btnSend.width;
 btnSend.top:= GroupBanks.height - btnSend.height-40 - appMainMenu.Height ;
 btnResetColours.Top:=btnSend.top;

 c2:=(x div 2)+16; // <<-- ((x-32)/2)+16 -- div is integer division
 ledFRed.left:=c2;
 trackFRed.left:=c2+ ledFRed.width +16;
 ledFGreen.left:=c2;
 trackFGreen.left:=trackFRed.left;
 ledFBlue.left:=c2;
 trackFBlue.left:=trackFRed.left;
 ledFWhite.left:=c2;
 trackFWhite.left:=trackFRed.left;

 trackFRed.width:=c2- ledFRed.width -32;
 trackFGreen.width:=trackFRed.width;
 trackFBlue.width:=trackFRed.width;
 trackFWhite.width:=trackFRed.width;

 trackCRed.width:=trackFRed.width;
 trackCGreen.width:=trackFRed.width;
 trackCBlue.width:=trackFRed.width;
 trackCWhite.width:=trackFRed.width;

 ColorButtonMain.Left := trackCRed.Left + trackCRed.width - ColorButtonMain.width - 16;
 ColorButtonClash.Left := trackFRed.Left + trackFRed.width - ColorButtonClash.width - 16;

end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin

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

procedure TForm1.ColorButtonClashClick(Sender: TObject);
begin
  ColorButtonClash.OnColorChanged:=@ColorButtonClashColorChanged;
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
       btnSend.Enabled:=True;
       GroupBanks.Enabled:=True;

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
       HexClashStringtoBank(inp.Substring(3));

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

  ColorButtonClash.ButtonColor:=RGBWtoRGB(trackFRed.Position,
                                  trackFGreen.Position,
                                  trackFBlue.Position,
                                  trackFWhite.Position);
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  labStatus.Caption:='Not an Open Core Saber';
  labBuild.Caption:='Build: --';
  labSerial.Caption:='Serial No.: --';
  validatedPort:='';
  serialInput:='';

  ComboBank.Enabled:=False;
  btnSend.Enabled:=False;
  GroupBanks.Enabled:=False;

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

procedure TForm1.menuAboutClick(Sender: TObject);
begin
  MessageDlg(Form1.Caption,
                Form1.Caption+#13+#13
                +'Settings Manager for OpenCore Saber'+#13
                +'(C) MMXX Nuntis'+#13+#13
                +'http://sabers.amazer.uk',
                     mtInformation, [mbOK],0);
end;

procedure TForm1.menuCheckUpdateClick(Sender: TObject);
var
 ini : TIniFile;
 cli : TFPHTTPClient;
 result,changes, newv, url, OS, fExec : String;
 bvis : Boolean;
 aProcess : TProcess;
 fSize, dSize : Int64;
 //efile : file of byte;
 Info : TSearchRec;
begin
  OS:='windows';
  cli := TFPHTTPClient.Create(nil);
  cli.AddHeader('User-Agent','Mozilla/5.0 (compatible; fpweb)');
  result:='';
  try
    try
      result:= cli.Get('http://sabers.amazer.uk/files/gilthoniel/release.ini?r='+InttoStr(Math.RandomRange(10000,99999)));
    except
      on E: Exception do
      begin
      Memo1.Append('Web exception raised: ' + E.Message);
      result:='';

      end;
    end;
  finally
    cli.free
  end;
  if result.IsEmpty then
  begin
    MessageDlg('Update Check',
               'Update Check Failed, see debug log',
                mtConfirmation, [mbOK],0);
  end
  else
  begin
    ini := TIniFile.Create(TStringStream.Create(result), false);
    //[windows]
    //v=0.1.0.53
    //changes=Beta Firmware OpenCore.1.9.13_20200808_json3.hex
    //url=http://sabers.amazer.uk/files/gilthoniel/install_gilthoniel_0.1.0.53.exe
    //size=12345667

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
        result:='';
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

procedure TForm1.menuItemRescanClick(Sender: TObject);
begin
  OpenSerial(Sender);
end;

procedure TForm1.miLoadAllClick(Sender: TObject);
var
 k: Integer;
begin
  OpenDialog1.Filter:='OpenCore Settings|*.openCoreSettings';

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
        if Not(saveData[k].StartsWith('!')) then
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
          HexClashStringtoBank(saveData[k].Substring(2));

        Application.ProcessMessages;
      end;
      saveData.Clear;
    end;
  end;

end;

procedure TForm1.miSaveAllClick(Sender: TObject);
var
 fname:String;
begin
  {$IF defined(MSWindows)}
  //Memo1.Append(GetWindowsSpecialDir(CSIDL_PERSONAL));
  OpenDialog1.InitialDir:=GetWindowsSpecialDir(CSIDL_PERSONAL);//CSIDL_COMMON_DOCUMENTS);
  {$elseif defined(DARWIN)}
  OpenDialog1.InitialDir:=AppendPathDelim(GetUserDir + 'Documents');
  {$ENDIF}
  SaveDialog1.Filter:='OpenCore Settings|*.openCoreSettings';
  OpenDialog1.Title:='Select an OpenCoreSettings File';
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
      btnSendClick(Sender);
      //expecting two responses
      while (saveData.Count<2) do
      begin
        Application.ProcessMessages;
        Delay(100);
      end;

      saveMode:=true;
      saveData.Clear;
      saveData.Add('!filetype=Giltoniel Saber Settings');
      WriteLn('B?');
      WriteLn('c?');
      WriteLn('f?');
      while (saveData.Count<18) do
      begin
        Application.ProcessMessages;
        Delay(10);
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
   OpenDialog1.Title:='Select an OpenCoreBank File';
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
       saveData.Add('!filetype=Giltoniel Saber Bank');
       saveData.Add('c='+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);
       saveData.Add('f='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);

       saveData.SaveToFile(fname);
       saveData.Clear;
     end;

   end;
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
    WriteLn('B='+bank);
  end;
end;

procedure TForm1.btnSendClick(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);
    WriteLn('c'+bank+'='+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);
    WriteLn('f'+bank+'='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);

    //WriteLn('DC'+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);

    //request values back to confirm
    WriteLn('c'+bank+'?');
    WriteLn('f'+bank+'?');

    //Sleep(1200);
    //WriteLn('DC'+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);
    //Sleep(400);
    //WriteLn('DC'+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption);
    //Sleep(500);
    //WriteLn('OFF');

  end;
end;

procedure TForm1.btnFirmwareClick(Sender: TObject);
begin
 doFirmware(Sender);
end;

procedure TForm1.doFirmware(Sender: TObject);
var
   filename:String;
begin
  Memo1.Append(ExtractFilePath(Application.ExeName)+'firmware');
  OpenDialog1.FileName:='';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName)+'firmware';
  OpenDialog1.Title:='Select an OpenCore Firmware HEX File';
  OpenDialog1.Filter:='Firmware HEX File|*.hex';

  if OpenDialog1.Execute then
  begin
    filename := OpenDialog1.Filename;

    if (MessageDlg('Update',
                   'Do you wish to Update Firmware to '+#13
                   + ExtractFileName(filename)+' ?',
                   mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
    begin
      //read all the settings to save back after the upgrade/downgrade
      saveMode:=true;
      saveData.Clear;
      if Assigned(winSerial) and winSerial.Active then
      begin
        WriteLn('B?');
        WriteLn('C?');
        WriteLn('F?');
        while (saveData.Count<17) do
        begin
          Application.ProcessMessages;
          Delay(10);
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
  end; //Open file yes
end;

procedure TForm1.btnPreview1Click(Sender: TObject);
begin
  WriteLn('P='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);
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
  //f:=  UTF8ToSys(fileName);
  try
    //한글 오류 수정 UTF8ToSys
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
  //f:=  UTF8ToSys(fileName);
  try
    //한글 오류 수정 UTF8ToSys
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
  //f:=  UTF8ToSys(fileName);
  try
    //한글 오류 수정 UTF8ToSys
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

