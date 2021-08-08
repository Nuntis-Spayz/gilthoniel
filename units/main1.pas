unit main1;
{$mode objfpc}{$H+}
{$if defined(DARWIN)}
  {$modeswitch objectivec1}
{$endif}
interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  Buttons, ComCtrls, ActnList, ExtCtrls, LCLType, LazHelpHTML, Math, StrUtils,
  LazFileUtils, RTTICtrls, FileInfo, crt, IniFiles, fphttpclient, Process,
  simpleipc, DCPsha256, DCPmd5, DCPsha1, registry, reg, frmHelp, synaser,
  Clipbrd, CheckLst, RGBWColour, DateUtils
  {$IF defined(MSWindows)}
  , windirs
  {$elseif defined(DARWIN)}
  // mac os code
  , CocoaAll, lclintf
  {$ENDIF}
  ;
type
  { TForm1 }
  TForm1 = class(TForm)
    btnDisconnect: TBitBtn;
    btnPreview2: TSpeedButton;
    btnPreview3: TSpeedButton;
    btnRefreshLists: TSpeedButton;
    btnDeleteFiles: TSpeedButton;
    btnUpload: TSpeedButton;
    btnResetColours: TBitBtn;
    btnSendBanks: TBitBtn;
    btnSend1: TBitBtn;
    btnSend2: TBitBtn;
    btnSend3: TBitBtn;
    chOn: TCheckListBox;
    chOff: TCheckListBox;
    chHum: TCheckListBox;
    chSwing: TCheckListBox;
    chSmoothA: TCheckListBox;
    chSmoothB: TCheckListBox;
    chClash: TCheckListBox;
    ColorButtonClash: TColorButton;
    ColorButtonSwing: TColorButton;
    ColorButtonMain: TColorButton;
    ColorDialog1: TColorDialog;
    ComboBox1: TComboBox;
    ComboBank: TComboBox;
    labClashGreen: TLabel;
    labClashBlue: TLabel;
    labClashWhite: TLabel;
    labClash: TLabel;
    labOn: TLabel;
    labOff: TLabel;
    labHum: TLabel;
    labSwing: TLabel;
    labSmoothA: TLabel;
    labSmoothB: TLabel;
    ledFWhite: TEdit;
    ledFBlue: TEdit;
    ledFGreen: TEdit;
    labClashRed: TLabel;
    ledFRed: TEdit;
    labSwingWhite: TLabel;
    labSwingBlue: TLabel;
    labSwingGreen: TLabel;
    ledSwGreen: TEdit;
    ledSwBlue: TEdit;
    ledSwWhite: TEdit;
    labColourBlue: TLabel;
    labColourWhite: TLabel;
    ledCWhite: TEdit;
    ledCBlue: TEdit;
    labColourGreen: TLabel;
    ledCGreen: TEdit;
    labColourRed: TLabel;
    ledCRed: TEdit;
    labSwingRed: TLabel;
    ledSwRed: TEdit;
    HTMLBrowserHelpViewer1: THTMLBrowserHelpViewer;
    InfoBank: TGroupBox;
    GroupPort: TGroupBox;
    GroupBanks: TGroupBox;
    Label1: TLabel;
    labSerial: TLabel;
    labBuild: TLabel;
    labStatus: TLabel;
    Label3: TLabel;
    appMainMenu: TMainMenu;
    Memo1: TMemo;
    menuFile: TMenuItem;
    MenuItem1: TMenuItem;
    CopyFirmware: TMenuItem;
    CopySerial: TMenuItem;
    Cancel: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    miRGBW255: TMenuItem;
    miAdvancedOptions: TMenuItem;
    miAutoPreview: TMenuItem;
    miCopyColour: TMenuItem;
    miPasteColour: TMenuItem;
    MenuItem6: TMenuItem;
    miCopyBuild: TMenuItem;
    miCopySerial: TMenuItem;
    miCopyDebug: TMenuItem;
    miHelp: TMenuItem;
    miSendCommand: TMenuItem;
    miExtraDebugInfo: TMenuItem;
    miLicence: TMenuItem;
    N2: TMenuItem;
    miCheckOnConnect: TMenuItem;
    miCheckFirmwareNow: TMenuItem;
    N1: TMenuItem;
    miClearLog: TMenuItem;
    miSep10: TMenuItem;
    menuHelp: TMenuItem;
    miOpenPort: TMenuItem;
    miSep13: TMenuItem;
    miAbout: TMenuItem;
    miCheckUpdate: TMenuItem;
    menuTools: TMenuItem;
    menuConnect: TMenuItem;
    miClosePort: TMenuItem;
    miRescan: TMenuItem;
    miDebug: TMenuItem;
    miLoadFirmware: TMenuItem;
    miSaveBank: TMenuItem;
    miSaveAll: TMenuItem;
    miLoadBank: TMenuItem;
    miLoadAll: TMenuItem;
    miExit: TMenuItem;
    OpenDialog1: TOpenDialog;
    pageControl: TPageControl;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    btnPreview1: TSpeedButton;
    SimpleIPCClient1: TSimpleIPCClient;
    TabMain: TTabSheet;
    TabClash: TTabSheet;
    TabSounds: TTabSheet;
    TabSwing: TTabSheet;
    Timer1: TTimer;
    TimerRX: TTimer;
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
    procedure btnDeleteFilesClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnFirmwareClick(Sender: TObject);
    procedure btnPreview1Click(Sender: TObject);
    procedure btnPreview2Click(Sender: TObject);
    procedure btnPreview3Click(Sender: TObject);
    procedure btnRefreshListsClick(Sender: TObject);
    procedure btnResetColoursClick(Sender: TObject);
    procedure btnSend1Click(Sender: TObject);
    procedure btnSend2Click(Sender: TObject);
    procedure btnSend3Click(Sender: TObject);
    procedure btnSendBanksClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure chClashClickCheck(Sender: TObject);
    procedure chHumClickCheck(Sender: TObject);
    procedure chOffClickCheck(Sender: TObject);
    procedure chOnClickCheck(Sender: TObject);
    procedure chSmoothAClickCheck(Sender: TObject);
    procedure chSmoothBClickCheck(Sender: TObject);
    procedure chSwingClickCheck(Sender: TObject);
    procedure ColorButtonClashClick(Sender: TObject);
    procedure ColorButtonClashColorChanged(Sender: TObject);
    procedure ColorButtonMainClick(Sender: TObject);
    procedure ColorButtonMainColorChanged(Sender: TObject);
    procedure ColorButtonSwingClick(Sender: TObject);
    procedure ColorButtonSwingColorChanged(Sender: TObject);
    procedure ComboBankSelect(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure CopySerialClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CopyFirmwareClick(Sender: TObject);
    procedure labBuildClick(Sender: TObject);
    procedure labSerialClick(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure miAdvancedOptionsClick(Sender: TObject);
    procedure miAutoPreviewClick(Sender: TObject);
    procedure miCheckUpdateClick(Sender: TObject);
    procedure miCopyColourClick(Sender: TObject);
    procedure miCopyDebugClick(Sender: TObject);
    procedure miHelpClick(Sender: TObject);
    procedure miPasteColourClick(Sender: TObject);
    procedure miRGBW255Click(Sender: TObject);
    procedure miSendCommandClick(Sender: TObject);
    procedure miCheckFirmwareNowClick(Sender: TObject);
    procedure miCheckOnConnectClick(Sender: TObject);
    procedure miClearLogClick(Sender: TObject);
    procedure miLoadFirmwareClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miDebugClick(Sender: TObject);
    procedure miLicenceClick(Sender: TObject);
    procedure miRescanClick(Sender: TObject);
    procedure miExtraDebugInfoClick(Sender: TObject);
    procedure miLoadAllClick(Sender: TObject);
    procedure miLoadBankClick(Sender: TObject);
    procedure miSaveAllClick(Sender: TObject);
    procedure miSaveBankClick(Sender: TObject);
    procedure pageControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ledCRedChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TimerRXTimer(Sender: TObject);
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
    lastUploadPath:String;
    defWidth, defHeight : Integer;
    winSerial: TBlockSerial;
    serialOutQueue: TStringList;
    previewLive: Boolean;
    inList:Boolean;
    procedure setRange();
    procedure RxData();
    procedure OpenSerial(Sender: TObject);
    procedure CloseSerial();
    procedure doFirmware(Sender: TObject);
    procedure loadFirmware(Sender:Tobject; filename:String);
    procedure checkFirmwareNow(Sender: TObject; silent:boolean);
    procedure WriteLn(msg: String);
    procedure WriteLn(msg: String; log: Boolean); overload;
    procedure PushLn(msg: String);
    function getReply(): String;

    procedure SetBank(activePg:TTabSheet; col:TRGBWColour);
    function getActiveBank():TRGBWColour;
    function getBank(activePg: TTabSheet):TRGBWColour;
    procedure AutoPreview();
    procedure AutoPreview(c: TRGBWColour); overload;
    procedure Preview(c: TRGBWColour);
    procedure Preview(c: TRGBWColour; log: Boolean); overload;
    procedure ApplySoundCSV(ch: TCheckListBox; csv:String);
    procedure sendSoundCSV(prefix:String; ch: TCheckListBox);
    procedure clearSoundLists();
    procedure sendFile(fname : String);

    function md5Encrypt(fileName: String): String;
    function sha1Encrypt(fileName: String): String;
    function sha256Encrypt(fileName: String): String;
    procedure ZeroMemory(Destination: Pointer; Length: DWORD);
    function stringFromURL(url: String) : String;
    function iniFromURL(url: String) : TIniFile;
    procedure showHtml(title, url:String);
    procedure LoadReg();
    {$if defined(DARWIN)}
    // mac os code
    function GetSignificantDir(DirLocation: qword; DomainMask: qword; count: byte): string;
    {$endif}
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

  pageControl.TabIndex:=0;
  serialOutQueue := TStringList.Create();
  serialOutQueue.Sorted:=False;
  serialOutQueue.Duplicates:= dupAccept;
  serialOutQueue.CaseSensitive:=True;
  serialOutQueue.OwnsObjects:=True;
  previewLive:=False;

  {$IF defined(MSWindows)}
  fpath:=ExtractFilePath(Application.ExeName)+'firmware\';
  bInstalled:= FileExists(fpath+'upload.cmd') and FileExists(fpath+'tycmd.exe');
  {$elseif defined(DARWIN)}
  fpath:=ExtractFilePath(Application.ExeName)+'/../Resources/';
  bInstalled:= false; // Not yet implemented -- FileExists(fpath+'tycmd');
  {$endif}
  lastUploadPath:='';
  //if the firmware directory files don't exist disable the firmware and update menu options
  miLoadFirmware.Visible := bInstalled;
  miCheckFirmwareNow.Visible := bInstalled;
  miCheckOnConnect.Visible := bInstalled;

  loadReg();

  {$IF defined(MSWindows)}
  ColorButtonMain.Caption:='Pick Main'+#13+'Colour ';
  ColorButtonClash.Caption:='Pick Clash'+#13+'Colour ';
  ColorButtonSwing.Caption:='Pick Swing'+#13+'Colour ';

  btnPreview1.Caption:='Preview'+#13+'On Saber';
  btnPreview2.Caption:='Preview'+#13+'On Saber';
  btnPreview3.Caption:='Preview'+#13+'On Saber';

  {$elseif defined(DARWIN)}
  // mac os code
  btnPreview1.Glyph:=nil;
  btnPreview2.Glyph:=nil;
  btnPreview3.Glyph:=nil;

  //Change Menu Shortcuts from Ctrl- to Cmd-
  miSaveBank.ShortCut:= KeyToShortCut(VK_S, [ssShift, ssMeta]);
  miLoadBank.ShortCut:= KeyToShortCut(VK_O, [ssShift, ssMeta]);
  miSaveAll.ShortCut:= KeyToShortCut(VK_S, [ssMeta]);
  miLoadAll.ShortCut:= KeyToShortCut(VK_O, [ssMeta]);
  miExit.Visible:=False;  //Quit on MacOS exists in the default menu
  miCopyColour.Shortcut:=KeyToShortCut(VK_C, [ssMeta]);
  miPasteColour.Shortcut:=KeyToShortCut(VK_V, [ssMeta]);
  miRescan.ShortCut:= KeyToShortCut(VK_R, [ssMeta]);
  //miOpenPort.ShortCut:= KeyToShortCut(VK_L, [ssMeta]);
  //miClosePort.ShortCut:= KeyToShortCut(VK_L, [ssMeta]);
  miDebug.ShortCut:= KeyToShortCut(VK_D, [ssMeta]);
  //miExtraDebugInfo.ShortCut:= KeyToShortCut(VK_L, [ssMeta]);
  miSendCommand.ShortCut:= KeyToShortCut(VK_N, [ssMeta]);
  miClearLog.ShortCut:= KeyToShortCut(VK_C, [ssShift,ssMeta]);
  //miCheckOnConnect.ShortCut:= KeyToShortCut(VK_L, [ssMeta]);
  miCheckFirmwareNow.ShortCut:= KeyToShortCut(VK_M, [ssMeta]);
  miLoadFirmware.ShortCut:= KeyToShortCut(VK_F, [ssMeta]);
  miCheckUpdate.ShortCut:= KeyToShortCut(VK_A, [ssMeta]);
  miHelp.ShortCut:= KeyToShortCut(VK_F1, [ssMeta]);
  miLicence.ShortCut:= KeyToShortCut(VK_I, [ssMeta]);
  miAbout.ShortCut:= KeyToShortCut(VK_F1, [ssShift, ssMeta]);
  {$ENDIF}

  Memo1.Visible:=miDebug.Checked;

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
      +'.'+IntToStr(Info.FixedInfo.FileVersion[1]).PadLeft(2,'0')
      +'.'+IntToStr(Info.FixedInfo.FileVersion[2]).PadLeft(2,'0')
      +'.'+IntToStr(Info.FixedInfo.FileVersion[3]).PadLeft(2,'0');
  Info.Free;
  // Update the title string - include the version & ver #
  Form1.Caption := Form1.Caption+' v.' + appVersion;

  TabMain.TabVisible:=false;
  TabSwing.TabVisible:=false;
  TabClash.TabVisible:=false;

  Application.ProcessMessages;

  OpenSerial(Sender);
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
 GroupPort.Width:=self.ClientWidth-10;

 GroupBanks.Top:=GroupPort.height+16;

 GroupBanks.Left:=5;
 GroupBanks.Width:=(self.ClientWidth * 64 div 100)-10;
 GroupBanks.Height:=self.ClientHeight-GroupBanks.Top-10;

 pageControl.Width:=GroupBanks.Width-2*pageControl.Left;
 pageControl.Height:= GroupBanks.height - btnSendBanks.height- appMainMenu.Height
                       - 140;

 labOn.left := 16;
 labOff.left := labOn.Left;
 chOn.left := labOn.Left;
 chOff.left := labOn.Left;
 chOn.Width:= pageControl.ClientWidth div 4 -32;
 chOff.Width:= chOn.Width;

 labHum.left := 16+ ( 1 * pageControl.ClientWidth div 4);
 labSwing.left := labHum.left;
 chHum.left := labHum.left;
 chSwing.left := labHum.left;
 chHum.Width := chOn.Width;
 chSwing.Width := chOn.Width;

 labSmoothA.left := 16+ ( 2 * pageControl.ClientWidth div 4);
 labSmoothB.left := labSmoothA.left;
 chSmoothA.left := labSmoothA.left;
 chSmoothB.left := labSmoothA.left;
 chSmoothA.Width := chOn.Width;
 chSmoothB.Width := chOn.Width;

 labClash.left := 16+ ( 3 * pageControl.ClientWidth div 4);
 chClash.left := labClash.left;
 chClash.Width := chOn.Width;

 labOff.top := (pageControl.ClientHeight - (2 * labOn.top)) div 2;
 chOff.top := labOff.top + (chOn.top - labOn.top);
 chOff.height := pageControl.ClientHeight - chOff.top - 16 - labOn.top - labOn.height;
 chOn.height := chOff.height;
 chHum.height := chOff.height;
 chSwing.height := chOff.height;
 chSmoothA.height := chOff.height;
 chSmoothB.height := chOff.height;
 chClash.height := chOff.height;

 labHum.top := labOn.top;
 labSmoothA.top := labOn.top;
 labClash.top := labOn.top;

 chHum.top := chOn.top;
 chSmoothA.top := chOn.top;
 chClash.top := chOn.top;

 labSwing.top := labOff.top;
 labSmoothB.top := labOff.top;
 chSwing.top := chOff.top;
 chSmoothB.top := chOff.top;

 btnUpload.left:= pageControl.ClientWidth - btnUpload.width - 16;
 btnUpload.top := pageControl.ClientHeight - btnUpload.height - 16;

 btnRefreshLists.Left:=pageControl.ClientWidth - btnRefreshLists.width - 16;
 btnRefreshLists.top := btnUpload.top - btnRefreshLists.height - 16;

 btnDeleteFiles.left := pageControl.ClientWidth - btnDeleteFiles.width - 16;
 btnDeleteFiles.top := btnRefreshLists.top - btnDeleteFiles.height - 16;

 btnDisconnect.left:= GroupPort.width-btnDisconnect.width-16;

 InfoBank.top:=GroupPort.height+16;
 InfoBank.left:=GroupBanks.Width+10;
 InfoBank.width:=self.Width-GroupBanks.Width-20;
 InfoBank.height:=self.Height-InfoBank.Top-10;

 Memo1.width:= InfoBank.width-10;
 Memo1.height:= InfoBank.height -Memo1.top -50 - appMainMenu.Height  ;
 labSerial.left:=Memo1.left;
 labBuild.left:=Memo1.left;


 x:=GroupBanks.width -20;
 btnSendBanks.left:= x - btnSendBanks.width;
 btnSendBanks.top:= GroupBanks.height - btnSendBanks.height-40 - appMainMenu.Height ;
 btnResetColours.Top:=btnSendBanks.top;

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

 btnPreview1.Left := pageControl.Width -16 - btnPreview1.Width;
 btnPreview2.Left := pageControl.Width -16 - btnPreview2.Width;
 btnPreview3.Left := pageControl.Width -16 - btnPreview3.Width;

 btnSend1.Left := pageControl.Width -16 - btnSend1.Width;
 btnSend2.Left := btnSend1.Left;
 btnSend3.Left := btnSend1.Left;

end;
procedure TForm1.FormShow(Sender: TObject);
begin
  {$IF defined(MSWindows)}
    if defWidth=0 then
    begin
      self.width:=1500;
      defWidth:=self.Width;
    end;
    if defHeight=0 then
    begin
      self.Height:=800;
      defHeight:=self.Height;
    end;
    ComboBox1.Width:=200;
  {$elseif defined(DARWIN)}
    if defWidth=0 then
    begin
      self.width:=800;
      defWidth:=self.Width;
    end;
    if defHeight=0 then
    begin
      self.Height:=430;
      defHeight:=self.Height;
    end;
    ComboBox1.Width:=260;
  {$ENDIF}
  LabStatus.Left:=ComboBox1.Left+ComboBox1.Width+10;
end;

procedure TForm1.CopyFirmwareClick(Sender: TObject);
begin
  Clipboard.AsText := labBuild.Caption;
end;

procedure TForm1.labBuildClick(Sender: TObject);
begin
  PopupMenu1.PopUp;
end;

procedure TForm1.labSerialClick(Sender: TObject);
begin
  PopupMenu1.PopUp;
end;

procedure TForm1.OpenSerial(Sender: TObject);
var
  {$IF defined(MSWindows)}
  Reg:TRegistry;
  I:integer;
  cs : String;
  {$elseif defined(DARWIN)}
  // mac os code
  SearchResult  : TSearchRec;
  {$ENDIF}
  lastItem:String;
  rs:String;
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
   // List the files
   //Memo1.Append('Searching for devices');
   if FindFirst('/dev/cu*.*', faAnyFile, SearchResult)=0 then
   repeat
     rs := SearchResult.Name;
     if rs.StartsWith('cu.usb') then
     begin
       //Memo1.Append('? '+rs);
       lastItem:='/dev/'+rs;
       ComboBox1.Items.Append(lastItem);
     end;
   until FindNext(SearchResult)<>0;
   FindClose(SearchResult);
   //Memo1.Append('---------------------');

   //lastItem:='/dev/cu.usbmodem42949672951';
   //ComboBox1.Items.Append(lastItem);
   {$ENDIF}


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
end;
procedure TForm1.CloseSerial();
begin
  TimerRx.Enabled:=False;
  if Assigned(winSerial) then
    begin
     if Not(winSerial.Device.IsEmpty) then
     begin
       winSerial.CloseSocket;
     end;
     winSerial.Destroy;
     winSerial:=nil;
  end;

  GroupBanks.Enabled:=False;
  pageControl.Enabled:=False;

  labStatus.Caption:='Disconnected';
  btnDisconnect.Caption:='Connect';

  TabMain.TabVisible:=false;
  TabSwing.TabVisible:=false;
  TabClash.TabVisible:=false;

end;
procedure TForm1.ComboBox1Select(Sender: TObject);
var
 port:String;
begin
  labStatus.Caption:='Not an Open Core Saber';
  labBuild.Caption:='Build: --';
  labSerial.Caption:='Serial No.: --';
  validatedPort:='';
  serialInput:='';

  ComboBank.Enabled:=False;
  btnSendBanks.Enabled:=False;
  GroupBanks.Enabled:=False;

  pageControl.Enabled:=false;
  pageControl.TabIndex:=0;
  TabMain.TabVisible:=false;
  TabSwing.TabVisible:=false;
  TabClash.TabVisible:=false;

  btnDisconnect.Caption:='Disconnect/Save';

  if((ComboBox1.Caption<>'') and (ComboBox1.Caption<>'--')) then
  begin
    CloseSerial();

    winSerial := TBlockSerial.Create;

    //Memo1.Clear;
    Memo1.Append('-----------------');
    Memo1.Append('Opening '+ComboBox1.Caption);

    //winSerial.DeadlockTimeout:=10;
    try
      port:=ComboBox1.Caption;
      //devserial:=FPOpen(port.Trim([':',' ']));

      winSerial.config(115200, 8, 'N', SB1, False, False);
      winSerial.Connect(port.Trim([':',' ']));

      TimerRx.Enabled:=True;

      Memo1.Append('Port Open');
    finally
    end;
    inList:=False;

    WriteLn('V?');
  end;

end;

procedure TForm1.CopySerialClick(Sender: TObject);
begin
  Clipboard.AsText := labSerial.Caption;
end;

function TForm1.getReply():String;
var
 inp : String;
begin
 inp:=winSerial.RecvTerminated(10,#10);
 if Not(inp.IsEmpty) then
   Memo1.Append(inp);

 getReply:=inp;
end;

procedure TForm1.ApplySoundCSV(ch: TCheckListBox; csv:String);
var
 sounds : Array of String;
 k,i : Integer;
begin
     ch.CheckAll(TCheckBoxState.cbUnchecked);
     sounds := csv.Split(',');
     if length(sounds)>0 then
     begin
       for k:=Low(sounds) to High(sounds) do
       begin
         if Not(sounds[k].IsEmpty) then
         begin
           i:= ch.Items.IndexOf(sounds[k]);
           //Memo1.Append('>> '+IntToStr(i)+' '+sounds[k]);
           if (i>=0) and Not(ch.Checked[i]) then
             ch.Checked[i]:=True
           else
           begin
             if i>=0 then
             begin
               //item is already checked so we have it twice in the list, add it again
               ch.AddItem(sounds[k],nil);
               i:=ch.Items.IndexOf(sounds[k]);
               if i>=0 then
                 ch.Checked[i]:=True;
             end
             else
             begin
               // that file does not exists, so add it but disabled flagged
               ch.AddItem(sounds[k]+' **',nil);
               i:=ch.Items.IndexOf(sounds[k]);
               if i>=0 then
               begin
                 ch.Checked[i]:=True;
               end;

             end;
           end;
         end;
       end;
     end;
end;

procedure TForm1.clearSoundLists();
begin
 chOn.Clear;
 chOff.Clear;
 chHum.Clear;
 chSwing.Clear;
 chClash.Clear;
 chSmoothA.Clear;
 chSmoothB.Clear;
end;
procedure TForm1.RxData();
var
 inp : String;
 k : Integer;
begin
 TimerRx.Enabled:=False;
 inp:=getReply();

 while Not(inp.IsEmpty) do
 begin
   if validatedPort.IsEmpty and inp.StartsWith('Build: ') then
   begin
     labBuild.Caption:=inp;
     if( inp.StartsWith('Build: 1.9.1') and (inp<='Build: 1.9.12') ) then
     begin
       CloseSerial();

       labStatus.Caption:='Early Open Core Detected';
       if(MessageDlg('Early Open Core Saber Detected',
                    'You have the initial release of'+#13
                    +'OpenCore Saber Firmware '+inp+#13
                    +#13+'Upgrade Required for Colour Control, '+#13
                    +#13+'Do you want to update the saber now?',
                    mtConfirmation, [mbYes, mbNo],0)= mrYes ) then
       begin
         Application.ProcessMessages;
         ExecuteProcess( ExtractFilePath(Application.ExeName)+'firmware\upload.cmd',[],[]);
         Application.ProcessMessages;
         Delay(250);
         ComboBox1Select(nil);
       end;
     end
     else
     begin
         WriteLn('V?');
     end;
   end
   else if validatedPort.IsEmpty and inp.StartsWith('Serial: ') then
   begin
     labSerial.Caption:=inp;
     WriteLn('V?');
   end
   else if inp.StartsWith('V=') then
   begin
     validatedPort:=winSerial.Device;
     if inp<'V=1.9.16' then
     begin
         ComboBank.Items.Clear;
         ComboBank.Items.Add('0 - [Red]');
         ComboBank.Items.Add('1 - [Green]');
         ComboBank.Items.Add('2 - [Blue]');
         ComboBank.Items.Add('3 - [Yellow');
         ComboBank.Items.Add('4 - [Acqua]');
         ComboBank.Items.Add('5 - [Purple]');
         ComboBank.Items.Add('6 - [Orange]');
         ComboBank.Items.Add('7 - [White]');
     end
     else
     begin
         ComboBank.Items.Clear;
         ComboBank.Items.Add('0 - [Red]');
         ComboBank.Items.Add('1 - [Orange]');
         ComboBank.Items.Add('2 - [Yellow]');
         ComboBank.Items.Add('3 - [Green]');
         ComboBank.Items.Add('4 - [White]');
         ComboBank.Items.Add('5 - [Acqua]');
         ComboBank.Items.Add('6 - [Blue]');
         ComboBank.Items.Add('7 - [Purple]');
     end;

     labStatus.Caption:='Connected.';
     btnDisconnect.Caption:='Disconnect/Save';

     ComboBank.Enabled:=True;
     btnSendBanks.Enabled:=True;
     GroupBanks.Enabled:=True;
     pageControl.Enabled:=True;

     labBuild.Caption:='Build: '+inp;

     //writeback data saved from before a firmware update
     if (saveData.Count>0) then
     begin
       for k:=0 to (saveData.Count-1) do
       begin
         WriteLn(saveData[k]);
         Application.ProcessMessages;
         getReply();
       end;

       saveData.Clear;
       WriteLn('SAVE');
       Application.ProcessMessages;
       while Not(getReply().IsEmpty) do
         Application.ProcessMessages;
     end;

     PushLn('S?');
     PushLn('B?');
     PushLn('LIST?');

   end
   else if inp.Contains('Files on memory:') then
   begin
     inList:=True;
     clearSoundLists();
   end
   else if inList and (inp.StartsWith('Serial Flash Chip') or inp.StartsWith('JEDEC ID:')
           or inp.StartsWith('Memory Size:') or inp.StartsWith('Memory Free:')
           or inp.StartsWith('Memory Used:') or inp.StartsWith('Block Size:')) then
   begin
     inList:=False;
     PushLn('sON?');
     PushLn('sOFF?');
     PushLn('sHUM?');
     PushLn('sSW?');
     PushLn('sCL?');
     PushLn('sSMA?');
     PushLn('sSMB?');
   end
   else if inList and not(inp.StartsWith('config.ini')) then
   begin
     inp:=inp.Substring(0,inp.LastIndexOf(' ')).Trim();
     chOn.AddItem(inp,nil);
     chOff.AddItem(inp,nil);
     chHum.AddItem(inp,nil);
     chSwing.AddItem(inp,nil);
     chClash.AddItem(inp,nil);
     chSmoothA.AddItem(inp,nil);
     chSmoothB.AddItem(inp,nil);
   end
   else if (inp.StartsWith('sON=')) then
   begin
     ApplySoundCSV(chOn, inp.Substring(4).Trim());
   end
   else if (inp.StartsWith('sOFF=')) then
   begin
     ApplySoundCSV(chOff, inp.Substring(5).Trim());
   end
   else if (inp.StartsWith('sHUM=')) then
   begin
     ApplySoundCSV(chHum, inp.Substring(5).Trim());
   end
   else if (inp.StartsWith('sSW=')) then
   begin
     ApplySoundCSV(chSwing, inp.Substring(4).Trim());
   end
   else if (inp.StartsWith('sCL=')) then
   begin
     ApplySoundCSV(chClash, inp.Substring(4).Trim());
   end
   else if (inp.StartsWith('sSMA=')) then
   begin
     ApplySoundCSV(chSmoothA, inp.Substring(5).Trim());
   end
   else if (inp.StartsWith('sSMB=')) then
   begin
     ApplySoundCSV(chSmoothB, inp.Substring(5).Trim());
   end
   else if (inp.StartsWith('B=')) then
   begin
     Memo1.Append('switching to live bank '+InttoStr(Ord(inp.Chars[2])-48));
     ComboBank.ItemIndex:=Ord(inp.Chars[2])-48;
     ComboBankSelect(nil);
   end
   else if inp.StartsWith('S=') then
   begin
      labSerial.Caption:=inp.Replace('S=','Serial No. ');
      if miCheckOnConnect.Visible and  miCheckOnConnect.Checked then
         checkFirmwareNow(nil, true);
   end
   else if( (inp.StartsWith('c') or inp.StartsWith('C'))
             and (inp.Chars[2]='=') ) then
   begin
     TabMain.TabVisible:=true;
     if(miRGBW255.Checked) then
       SetBank(TabMain, TRGBWColour.getColour(inp.Substring(3)))
     else
       SetBank(TabMain, TRGBWColour.getColour(inp.Substring(3)).CorrectFromSaber());
   end
   else if( (inp.StartsWith('f') or inp.StartsWith('F'))
             and (inp.Chars[2]='=') ) then
   begin
     TabClash.TabVisible:=True;
     if(miRGBW255.Checked) then
       SetBank(TabClash, TRGBWColour.getColour(inp.Substring(3)))
     else
       SetBank(TabClash, TRGBWColour.getColour(inp.Substring(3)).CorrectFromSaber());
   end
   else if( (inp.StartsWith('w') or inp.StartsWith('W'))
             and (inp.Chars[2]='=') ) then
   begin
     TabSwing.TabVisible:=true;
     if(miRGBW255.Checked) then
       SetBank(TabSwing, TRGBWColour.getColour(inp.Substring(3)))
     else
       SetBank(TabSwing, TRGBWColour.getColour(inp.Substring(3)).CorrectFromSaber());
   end;

   inp:=getReply();
 end; //while

 TimerRx.Enabled:=True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled:=false;
   Timer1.OnTimer:=nil;
   if validatedPort.IsEmpty then
   begin
     labStatus.Caption:='No Open Core Saber Detected.';
     writeLn('V');
   end;

end;
procedure TForm1.TimerRXTimer(Sender: TObject);
var
 s : String;
begin
  if  Assigned(WinSerial) then
  begin
    if WinSerial.CanReadEx(1) then
    begin
       TimerRx.Enabled:=False;
       RxData();
       TimerRx.Enabled:=True;
     end;

     if serialOutQueue.Count>0 then
     begin
      s:=serialOutQueue.Strings[0];
      serialOutQueue.Delete(0);
      writeLn(s);
    end;
  end;
end;

procedure TForm1.ColorButtonMainClick(Sender: TObject);
begin
  ColorButtonMain.OnColorChanged:=@ColorButtonMainColorChanged;
end;
procedure TForm1.ColorButtonMainColorChanged(Sender: TObject);
var
  col : TRGBWColour;
begin
  ColorButtonMain.OnColorChanged:=nil;

  col:=TRGBWColour.Create;
  col.setRGB(ColorButtonMain.ButtonColor);

  trackCRed.Position:=col.getRedValue(Not miRGBW255.Checked);
  trackCGreen.Position:=col.getGreenValue(Not miRGBW255.Checked);
  trackCBlue.Position:=col.getBlueValue(Not miRGBW255.Checked);
  trackCWhite.Position:=col.getWhiteValue(Not miRGBW255.Checked);
end;
procedure TForm1.ColorButtonSwingClick(Sender: TObject);
begin
 ColorButtonSwing.OnColorChanged:=@ColorButtonSwingColorChanged;
end;
procedure TForm1.ColorButtonSwingColorChanged(Sender: TObject);
var
  col : TRGBWColour;
begin
  ColorButtonSwing.OnColorChanged:= nil;

  col:=TRGBWColour.Create;
  col.setRGB(ColorButtonSwing.ButtonColor);

  trackSwRed.Position:=col.getRedValue(Not miRGBW255.Checked);
  trackSwGreen.Position:=col.getGreenValue(Not miRGBW255.Checked);
  trackSwBlue.Position:=col.getBlueValue(Not miRGBW255.Checked);
  trackSwWhite.Position:=col.getWhiteValue(Not miRGBW255.Checked);
end;
procedure TForm1.ColorButtonClashClick(Sender: TObject);
begin
  ColorButtonClash.OnColorChanged:=@ColorButtonClashColorChanged;
end;
procedure TForm1.ColorButtonClashColorChanged(Sender: TObject);
var
  col : TRGBWColour;
begin
  ColorButtonClash.OnColorChanged:= nil;

  col:=TRGBWColour.Create;
  col.setRGB(ColorButtonClash.ButtonColor);

  trackFRed.Position:=col.getRedValue(Not miRGBW255.Checked);
  trackFGreen.Position:=col.getGreenValue(Not miRGBW255.Checked);
  trackFBlue.Position:=col.getBlueValue(Not miRGBW255.Checked);
  trackFWhite.Position:=col.getWhiteValue(Not miRGBW255.Checked);
end;
function TForm1.getActiveBank():TRGBWColour;
begin
 getActiveBank:=getBank(pageControl.ActivePage);
end;

function TForm1.getBank(activePg: TTabSheet):TRGBWColour;
begin
  getBank:=TRGBWColour.Create;
  if(miExtraDebugInfo.Checked) then
    getBank.setMemo(Memo1);

  if activePg=TabSwing then
   begin
     getBank.setRedValue(trackSwRed.Position, Not miRGBW255.Checked);
     getBank.setGreenValue(trackSwGreen.Position, Not miRGBW255.Checked);
     getBank.setBlueValue(trackSwBlue.Position, Not miRGBW255.Checked);
     getBank.setWhiteValue(trackSwWhite.Position, Not miRGBW255.Checked);
   end
   else if activePg=TabClash then
   begin
     getBank.setRedValue(trackFRed.Position, Not miRGBW255.Checked);
     getBank.setGreenValue(trackFGreen.Position, Not miRGBW255.Checked);
     getBank.setBlueValue(trackFBlue.Position, Not miRGBW255.Checked);
     getBank.setWhiteValue(trackFWhite.Position, Not miRGBW255.Checked);
   end
   else //if activePg=TabMain then
   begin
     getBank.setRedValue(trackCRed.Position, Not miRGBW255.Checked);
     getBank.setGreenValue(trackCGreen.Position, Not miRGBW255.Checked);
     getBank.setBlueValue(trackCBlue.Position, Not miRGBW255.Checked);
     getBank.setWhiteValue(trackCWhite.Position, Not miRGBW255.Checked);
   end;
end;

procedure TForm1.SetBank(activePg:TTabSheet; col:TRGBWColour);
begin
  if activePg=TabMain then
  begin
    trackCRed.Position:=col.getRedValue(Not miRGBW255.Checked);
    ledCRed.Caption:=IntToStr(trackCRed.Position);
    trackCGreen.Position:=col.getGreenValue(Not miRGBW255.Checked);
    ledCGreen.Caption:=IntToStr(trackCGreen.Position);
    trackCBlue.Position:=col.getBlueValue(Not miRGBW255.Checked);
    ledCBlue.Caption:=IntToStr(trackCBlue.Position);
    trackCWhite.Position:=col.getWhiteValue(Not miRGBW255.Checked);
    ledCWhite.Caption:=IntToStr(trackCWhite.Position);
  end
  else if activePg=TabSwing then
  begin
    trackSwRed.Position:=col.getRedValue(Not miRGBW255.Checked);
    ledSwRed.Caption:=IntToStr(trackSwRed.Position);
    trackSwGreen.Position:=col.getGreenValue(Not miRGBW255.Checked);
    ledSwGreen.Caption:=IntToStr(trackSwGreen.Position);
    trackSwBlue.Position:=col.getBlueValue(Not miRGBW255.Checked);
    ledSwBlue.Caption:=IntToStr(trackSwBlue.Position);
    trackSwWhite.Position:=col.getWhiteValue(Not miRGBW255.Checked);
    ledSwWhite.Caption:=IntToStr(trackSwWhite.Position);
  end
  else if activePg=TabClash then
  begin
    trackFRed.Position:=col.getRedValue(Not miRGBW255.Checked);
    ledFRed.Caption:=IntToStr(trackFRed.Position);
    trackFGreen.Position:=col.getGreenValue(Not miRGBW255.Checked);
    ledFGreen.Caption:=IntToStr(trackFGreen.Position);
    trackFBlue.Position:=col.getBlueValue(Not miRGBW255.Checked);
    ledFBlue.Caption:=IntToStr(trackFBlue.Position);
    trackFWhite.Position:=col.getWhiteValue(Not miRGBW255.Checked);
    ledFWhite.Caption:=IntToStr(trackFWhite.Position);
  end;

  if(pageControl.ActivePage=activePg) then
     AutoPreview();
end;

procedure TForm1.ledCRedChange(Sender: TObject);
var
 i:LongInt;
 capt:String;
begin

  if(TryStrToInt((Sender as TEdit).Caption,i)) then
  begin
   if(i<0) then
     i:=0;
   if(self.miRGBW255.Checked and (i>255)) then
     i:=255
   else if (Not(self.miRGBW255.Checked) and (i>100)) then
     i:=100;

   capt:=(Sender as TEdit).Name;

   if capt.StartsWith('ledC') then
   begin
    if(capt.Contains('Red') and (trackCRed.Position<>i)) then
        trackCRed.Position:=i;
    if(capt.Contains('Green') and (trackCGreen.Position<>i)) then
        trackCGreen.Position:=i;
    if(capt.Contains('Blue') and (trackCBlue.Position<>i)) then
        trackCBlue.Position:=i;
    if(capt.Contains('White') and (trackCWhite.Position<>i)) then
        trackCWhite.Position:=i;

   end
   else if(capt.startsWith('ledF')) then
   begin
    if(capt.Contains('Red') and (trackFRed.Position<>i)) then
        trackFRed.Position:=i;
    if(capt.Contains('Green') and (trackFGreen.Position<>i)) then
        trackFGreen.Position:=i;
    if(capt.Contains('Blue') and (trackFBlue.Position<>i)) then
        trackFBlue.Position:=i;
    if(capt.Contains('White') and (trackFWhite.Position<>i)) then
        trackFWhite.Position:=i;
   end
   else if(capt.StartsWith('ledSw')) then
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
  AutoPreview();
end;

procedure TForm1.TrackCBlueChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackCBlue.Position);
 if(ledCBlue.Caption<>s) then
 begin
   ledCBlue.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackCRed.Position, trackCGreen.Position,
               trackCBlue.Position, trackCWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;
procedure TForm1.TrackCGreenChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackCGreen.Position);
 if(ledCGreen.Caption<>s) then
 begin
   ledCGreen.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackCRed.Position, trackCGreen.Position,
               trackCBlue.Position, trackCWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();

   //AutoPreview(c);
 end;
end;
procedure TForm1.trackCRedChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackCRed.Position);
 if(ledCRed.Caption<>s) then
 begin
   ledCRed.Caption:=s;

   c:=TRGBWColour.Create();

   c.setColourValues(trackCRed.Position, trackCGreen.Position,
               trackCBlue.Position, trackCWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();

   //AutoPreview(c);
 end;
end;
procedure TForm1.TrackCWhiteChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackCWhite.Position);
 if(ledCWhite.Caption<>s) then
 begin
   ledCWhite.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackCRed.Position, trackCGreen.Position,
               trackCBlue.Position, trackCWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();

   //AutoPreview(c);
 end;
end;
procedure TForm1.TrackFBlueChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackFBlue.Position);
 if(ledFBlue.Caption<>s) then
 begin
   ledFBlue.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackFRed.Position, trackFGreen.Position,
               trackFBlue.Position, trackFWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;
procedure TForm1.TrackFGreenChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackFGreen.Position);
 if(ledFGreen.Caption<>s) then
 begin
   ledFGreen.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackFRed.Position, trackFGreen.Position,
               trackFBlue.Position, trackFWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;
procedure TForm1.trackFRedChange(Sender: TObject);
var
  s: String;
  c : TRGBWColour;
begin
 s:=IntToStr(trackFRed.Position);
 if(s<>ledFRed.Caption) then
 begin
   ledFRed.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackFRed.Position, trackFGreen.Position,
               trackFBlue.Position, trackFWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;
procedure TForm1.TrackFWhiteChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackFWhite.Position);
 if(ledFWhite.Caption<>s) then
 begin
   ledFWhite.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackFRed.Position, trackFGreen.Position,
               trackFBlue.Position, trackFWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
  end;
end;
procedure TForm1.TrackSwBlueChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackSwBlue.Position);
 if(ledSwBlue.Caption<>s) then
 begin
   ledSwBlue.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackSwRed.Position, trackSwGreen.Position,
               trackSwBlue.Position, trackSwWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;
procedure TForm1.TrackSwGreenChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackSwGreen.Position);
 if(ledSwGreen.Caption<>s) then
 begin
   ledSwGreen.Caption:=s;
  
   c:=TRGBWColour.Create;
   c.setColourValues(trackSwRed.Position, trackSwGreen.Position,
               trackSwBlue.Position, trackSwWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;

procedure TForm1.trackSwRedChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackSwRed.Position);
 if(ledSwRed.Caption<>s) then
 begin
   ledSwRed.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackSwRed.Position, trackSwGreen.Position,
               trackSwBlue.Position, trackSwWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;
procedure TForm1.TrackSwWhiteChange(Sender: TObject);
var
 s : String;
 c : TRGBWColour;
begin
 s:=IntToStr(trackSwWhite.Position);
 if(ledSwWhite.Caption<>s) then
 begin
   ledSwWhite.Caption:=s;

   c:=TRGBWColour.Create;
   c.setColourValues(trackSwRed.Position, trackSwGreen.Position,
               trackSwBlue.Position, trackSwWhite.Position,
               Not(miRGBW255.Checked));

   Application.ProcessMessages;
   ColorButtonMain.ButtonColor:=c.getRGB();
   //AutoPreview(c);
 end;
end;

procedure TForm1.miAboutClick(Sender: TObject);
begin
 showHtml('','help/about.html');
end;

procedure TForm1.LoadReg();
begin
  TReg1.setBaseKey('\SOFTWARE\AmazerUK\Gilthoniel');

  miAutoPreview.Checked := TReg1.readBoolean('AutoPreview', true);

  miAdvancedOptions.Checked:=TReg1.readBoolean('AdvancedOptions', false);
    miSendCommand.Visible:=miAdvancedOptions.Checked;
    miRGBW255.Visible:=miAdvancedOptions.Checked;

  miRGBW255.Checked:= TReg1.readBoolean('Show255', false);
  setRange();
end;

procedure TForm1.miAdvancedOptionsClick(Sender: TObject);
begin
  miAdvancedOptions.Checked:= Not(miAdvancedOptions.Checked);
  TReg1.writeBoolean('AdvancedOptions', miAdvancedOptions.Checked);

  miSendCommand.Visible:=miAdvancedOptions.Checked;
  miRGBW255.Visible:=miAdvancedOptions.Checked;
end;

procedure TForm1.miAutoPreviewClick(Sender: TObject);
begin
  miAutoPreview.Checked:= Not(miAutoPreview.Checked);
  TReg1.writeBoolean('AutoPreview', miAutoPreview.Checked);
end;

procedure TForm1.miRGBW255Click(Sender: TObject);
begin
 miRGBW255.Checked:= Not(miRGBW255.Checked);
 TReg1.writeBoolean('Show255', miRGBW255.Checked);
 setRange();
end;

procedure TForm1.setRange();
var
 range:String;
 mx : Integer;
begin
 if miRGBW255.Checked then
 begin
   mx:=255;
   range:=' Raw 0-255'
 end
 else
 begin
   mx:=100;
   range:=' %age 0-100'
 end;

 ColorButtonMain.Visible:=miRGBW255.Checked;
 ColorButtonSwing.Visible:=miRGBW255.Checked;
 ColorButtonClash.Visible:=miRGBW255.Checked;

 labColourRed.Caption:='Color Red ' + range;
 ledCGreen.Caption:='Color Green ' + range;
 ledCBlue.Caption:='Color Blue ' + range;
 ledCWhite.Caption:='Color White ' + range;

 labSwingRed.Caption:='Swing Red ' + range;
 labSwingGreen.Caption:='Swing Green ' + range;
 labSwingBlue.Caption:='Swing Blue ' + range;
 labSwingWhite.Caption:='Swing White ' + range;

 labClashRed.Caption:='Clash Red ' + range;
 labClashGreen.Caption:='Clash Green ' + range;
 labClashBlue.Caption:='Clash Blue ' + range;
 labClashWhite.Caption:='Clash White ' + range;

 trackCRed.Max:=mx;
 trackCGreen.Max:=mx;
 trackCBlue.Max:=mx;
 trackCWhite.Max:=mx;

 trackFRed.Max:=mx;
 trackFGreen.Max:=mx;
 trackFBlue.Max:=mx;
 trackFWhite.Max:=mx;

 trackSwRed.Max:=mx;
 trackSwGreen.Max:=mx;
 trackSwBlue.Max:=mx;
 trackSwWhite.Max:=mx;

 ComboBankSelect(nil);
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
   iniFromURL := TIniFile.Create(TStringStream.Create(str), TEncoding.ANSI,[ifoEscapeLineFeeds]);

end;

procedure TForm1.miCheckUpdateClick(Sender: TObject);
var
 ini : TIniFile;
 changes, newv, url, OS, fExec : String;
 bvis : Boolean;
 {$IF defined(MSWindows)}
 aProcess : TProcess;
 {$EndIf}
 fSize, dSize : Int64;
 Info : TSearchRec;
 cli : TFPHTTPClient;
begin
  {$IF defined(MSWindows)}
  OS:='windows';
  {$elseif defined(DARWIN)}
  OS:='macos';
  {$ENDIF}

  ini:=iniFromURL('http://sabers.amazer.uk/files/gilthoniel/release.php');
  if Not(Assigned(ini)) then
  begin
    MessageDlg('Update Check',
               'Update Check Failed, see debug log',
                mtConfirmation, [mbOK],0);
  end
  else
  begin
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
        Application.ProcessMessages;

        cli := TFPHTTPClient.Create(nil);
        cli.AddHeader('User-Agent','Mozilla/5.0 (compatible; fpweb)');
        try
          try
            begin
              {$IF defined(MSWindows)}
              fExec:=GetTempDir(true)+'\install_gilthoniel_'+newv+'.exe';
              {$elseif defined(DARWIN)}
              fExec:=GetSignificantDir(NSDownloadsDirectory,NSUserDomainMask,0)+'/gilthoniel-macos-1.00.00.02'+newv+'.dmg';
              {$ENDIF}
              DeleteFile(fExec);
              Application.ProcessMessages;

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
                Memo1.Append('Starting Updater');

                {$IF defined(MSWindows)}
                aProcess := TProcess.Create(nil);
                aProcess.Executable:= fExec;
                //aProcess.Parameters.Add('-silent');
                //aProcess.Options := aProcess.Options + [poWaitOnExit];
                aProcess.Options := aProcess.Options - [poWaitOnExit];
                aProcess.Execute;
                {$elseif defined(DARWIN)}
                OpenDocument(fExec);
                {$ENDIF}

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

procedure TForm1.miCopyColourClick(Sender: TObject);
begin
  if pageControl.ActivePage=TabMain then
  begin
    Clipboard.AsText:='colour:'+ledCRed.Caption+','+ledCGreen.Caption+','+ledCBlue.Caption+','+ledCWhite.Caption;
  end
  else if pageControl.ActivePage=TabSwing then
  begin
    Clipboard.AsText:='colour:'+ledSwRed.Caption+','+ledSwGreen.Caption+','+ledSwBlue.Caption+','+ledSwWhite.Caption;
  end
  else if pageControl.ActivePage=TabClash then
  begin
    Clipboard.AsText:='colour:'+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption;
  end;
  Memo1.Append('Colour Copied to Clipboard: '+Clipboard.AsText);
end;

procedure TForm1.miCopyDebugClick(Sender: TObject);
begin
  Clipboard.AsText:=Memo1.Text;
end;

procedure TForm1.miHelpClick(Sender: TObject);
begin
  showHtml('', 'help/index.html');
end;

procedure TForm1.miPasteColourClick(Sender: TObject);
var
 s : String;
begin
 if Clipboard.AsText.StartsWith('colour:') then
 begin
   s:=MidStr(Clipboard.AsText,8,999);
   setBank(pageControl.ActivePage, TRGBWColour.getColour(s));
   Memo1.Append('Paste Clipboard to Bank: '+s);
 end;
end;

procedure TForm1.miSendCommandClick(Sender: TObject);
var
 s:String;
begin
  s:=InputBox('Send Manual Command...','Enter the command to be sent to the saber', '');
  if(Not(s.IsEmpty)) then
  begin
    miDebug.Checked:=True;
    memo1.Visible:=True;
    writeLn(s);

    //s:=getReply();
    //while Not(s.IsEmpty) do
    //  s:=getReply();

  end;
end;
procedure TForm1.miCheckFirmwareNowClick(Sender: TObject);
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
  if not(assigned(winSerial)) then
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
procedure TForm1.miCheckOnConnectClick(Sender: TObject);
begin
  miCheckOnConnect.Checked:= Not(miCheckOnConnect.Checked);
end;
procedure TForm1.miClearLogClick(Sender: TObject);
begin
 if (MessageDlg('Debug Log',
                   'Do you wish to clear the debug log ?',
                   mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
     Memo1.Clear;
end;
procedure TForm1.miLoadFirmwareClick(Sender: TObject);
begin
  doFirmware(Sender);
end;

procedure TForm1.miExitClick(Sender: TObject);
begin
  // Exit Quit
  Form1.Close;
end;
procedure TForm1.miDebugClick(Sender: TObject);
begin
  miDebug.Checked:= Not(miDebug.Checked);

  Memo1.Visible:=miDebug.Checked;
  miSendCommand.Visible:=miDebug.Checked;
  miExtraDebugInfo.Visible:=miDebug.Checked;
  miClearLog.Visible:=miDebug.Checked;

  Memo1.SelStart := Length(Memo1.Lines.Text);

  FormResize(Sender);
end;
procedure TForm1.miLicenceClick(Sender: TObject);
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

  {$IF defined(MSWindows)}
  fh.OpenShow(title, url);
  {$elseif defined(DARWIN)}
  fh.OpenShow(title, ExtractFilePath(Application.ExeName)+'/../Resources/'+url);
  {$ENDIF}
end;

procedure TForm1.miRescanClick(Sender: TObject);
begin
  OpenSerial(Sender);
end;
procedure TForm1.miExtraDebugInfoClick(Sender: TObject);
begin
  miExtraDebugInfo.Checked:= Not(miExtraDebugInfo.Checked);
end;
procedure TForm1.miLoadAllClick(Sender: TObject);
var
 k: Integer;
begin
  OpenDialog1.Filter:='OpenCore Settings|*.openCoreSettings';
  OpenDialog1.Options:=OpenDialog1.Options + [ofFileMustExist, ofEnableSizing, ofDontAddToRecent] - [ ofAllowMultiSelect ];

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
      PushLn('B?');
    end;

  end;
end;
procedure TForm1.miLoadBankClick(Sender: TObject);
var
 k : Integer;
begin
  OpenDialog1.Filter:='OpenCore Bank|*.openCoreBank';
  OpenDialog1.Options:=OpenDialog1.Options + [ofFileMustExist, ofEnableSizing, ofDontAddToRecent]  - [ ofAllowMultiSelect ];
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
        if saveData[k].StartsWith('c=') or saveData[k].StartsWith('C=')then
          setBank(TabMain, TRGBWColour.getColour(saveData[k].Substring(2)))
        else if saveData[k].StartsWith('f=') or saveData[k].StartsWith('F=')then
          setBank(TabClash, TRGBWColour.getColour(saveData[k].Substring(2)))
        else if saveData[k].StartsWith('w=') or saveData[k].StartsWith('W=') then
          setBank(TabSwing, TRGBWColour.getColour(saveData[k].Substring(2)));

        Application.ProcessMessages;
      end;
      saveData.Clear;
    end;
  end;

end;
procedure TForm1.miSaveAllClick(Sender: TObject);
var
 fname, inp:String;
 getlines, abort, i : Integer;
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

     if Not(fname.IsEmpty) then
     begin
      TimerRx.Enabled:=False;

      //save current bank to saber
      btnSendBanksClick(Sender);
      //expecting 2 or 3 responses
      for i:=0 to 3 do
      begin
        Application.ProcessMessages;
        getReply();
      end;

      saveData.Clear;
      saveData.Add('#filetype=Giltoniel Saber Settings');
      WriteLn('B?');
      PushLn('w?');
      PushLn('c?');
      PushLn('f?');
      //expecting 18 or 26 responses
      getlines:=18;
      if tabSwing.TabVisible then
         getlines:=26;

      abort:=0;
      while (saveData.Count<getlines) and (abort<4096) do
      begin
        Application.ProcessMessages;
        inp:=getReply();
        if Not(inp.IsEmpty) then
          saveData.Append(inp);

        abort:=abort+1;
        Memo1.Append('#'+IntToStr(saveData.Count)+'/'+IntToStr(getlines)+' : '+IntToStr(abort));

        if serialOutQueue.Count>0 then
        begin
          inp:=serialOutQueue.Strings[0];
          serialOutQueue.Delete(0);
          writeLn(inp);
        end;
      end;
      if (abort>=4096) then
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

      saveData.SaveToFile(fname);
      saveData.Clear;

      TimerRx.Enabled:=True;
     end;
  end;
end;
procedure TForm1.miSaveBankClick(Sender: TObject);
var
 fname:String;
begin
   SaveDialog1.Filter:='OpenCore Bank|*.openCoreBank';
   SaveDialog1.Options:=SaveDialog1.Options + [ofEnableSizing, ofDontAddToRecent] ;
   SaveDialog1.Title:='Select an OpenCoreBank File';
   {$IF defined(MSWindows)}
   //Memo1.Append(GetWindowsSpecialDir(CSIDL_PERSONAL));
   SaveDialog1.InitialDir:=GetWindowsSpecialDir(CSIDL_PERSONAL); //CSIDL_COMMON_DOCUMENTS);
   {$elseif defined(DARWIN)}
   SaveDialog1.InitialDir:=AppendPathDelim(GetUserDir + 'Documents');
   {$ENDIF}
   SaveDialog1.FileName:='unnamed.openCoreBank';

   if SaveDialog1.Execute then
   begin
     fname:=SaveDialog1.Filename;
     if Not(SaveDialog1.Filename.EndsWith('.openCoreBank')) then
       fname:=SaveDialog1.Filename+'.openCoreBank';

     if Not(fname.IsEmpty) then
     begin
       saveMode:=false;
       saveData.Clear;
       saveData.Add('#filetype=Giltoniel Saber Bank');
       saveData.Add('c='+getBank(TabMain).toCSV());
       saveData.Add('f='+getBank(TabClash).toCSV());
       saveData.Add('w='+getBank(TabSwing).toCSV());

       saveData.SaveToFile(fname);
       saveData.Clear;
     end;

   end;
end;
procedure TForm1.pageControlChange(Sender: TObject);
begin
  AutoPreview();//getBank(pageControl.ActivePage));
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

    PushLn('c'+bank+'?');
    PushLn('f'+bank+'?');
    PushLn('w'+bank+'?');
    PushLn('B='+bank);

    pageControl.ActivePage:=TabMain;
    previewLive:=True;
    AutoPreview();
  end;
end;
procedure TForm1.btnSendBanksClick(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);

    if self.miRGBW255.Checked then
    begin
      WriteLn('c'+bank+'='+getBank(TabMain).toCSV());
      WriteLn('f'+bank+'='+getBank(TabClash).toCSV());
      WriteLn('w'+bank+'='+getBank(TabSwing).toCSV());
    end
    else
    begin
      WriteLn('c'+bank+'='+getBank(TabMain).correctToSaber().toCSV());
      WriteLn('f'+bank+'='+getBank(TabClash).correctToSaber().toCSV());
      WriteLn('w'+bank+'='+getBank(TabSwing).correctToSaber().toCSV());
    end;

    //request values back to confirm
    PushLn('c'+bank+'?');
    PushLn('f'+bank+'?');
    PushLn('w'+bank+'?');

  end;
end;

procedure TForm1.sendFile(fname : String);
var
  fullname, inp : String;
  datFile : File of Byte;
  rByte : Byte;
  freespace, fsize, ctr,lastctr, diff : LongInt;
  tStart : TDateTime;
  sTime, ss : String;
  rx : boolean;
  Buf : Array[1..2048] of byte;
  NumRead,NumWritten : Word;
begin
  Memo1.append('');
  fullname:='';
  if FileExists(fname) then
  begin
    fullname:=fname
  end;

  if fullname.IsEmpty then
  begin
    Memo1.append('File '+fname+' not found.');
    exit;
  end;

  rx:=TimerRX.Enabled;
  TimerRX.Enabled:=False;

  serialOutQueue.Clear;
  WriteLn('WR?');
  inp:=  winSerial.RecvTerminated(500,#10);
  if (inp='OK, Write Ready') then
  begin
      Memo1.append(inp);
      Memo1.append('Saber Ready to Write to Serial Flash');
      Memo1.append('');

      AssignFile(datFile, fullname);
      Reset(datFile);
      freespace:=-1;
      fsize:=FileSize(datFile);
      NumRead:=0;

      WriteLn('FREE?');
      inp:= winSerial.RecvTerminated(500,#10);
      if inp.StartsWith('FREE=') then
      begin
        freespace:=StrToInt(inp.Substring(5));

        if freespace<fsize then
        begin
          Memo1.append('Space on Saber: '+IntToStr(freespace));
          Memo1.append('Filesize: '+IntToStr(fsize));
          Memo1.append('');
          Memo1.append('ERROR.');
          Memo1.append('Insufficient Space on saber, ERASE-ALL and re-upload all files.');
          Memo1.append('');

          TimerRX.Enabled:=rx;
          exit;
        end;

      end;

      Memo1.append('Sending: '+fullname+' to saber');
      Memo1.append('as Serial Flash Name: '+ExtractFileName(fullname));
      if freespace>0 then
         Memo1.append('Space on Saber: '+IntToStr(freespace));
      Memo1.append('Filesize: '+IntToStr(fsize));

      tStart := Time;
      ctr:=fsize;
      lastctr:=ctr;
      WriteLn('WR='+ExtractFileName(fullname)+','+IntToStr(FileSize(datFile))+#10);
      inp:= winSerial.RecvTerminated(2500,#10);
      writeLn(inp);
      if inp.StartsWith('OK, Write ') then
      begin
        While not eof(datfile) do
        begin
            read(datFile, rByte);
            winSerial.SendByte(rByte);
            dec(ctr);
          {
            //@TODO: read buffers worth at a time
            //read(datFile, rByte);
            BlockRead (datFile,buf,Sizeof(buf),NumRead);
            //BlockWrite (Fout,Buf,NumRead,NumWritten);
            winSerial.SendBuffer(@Buf,NumRead);
            dec(ctr,NumRead);
          }
          // we update the count and est time only every few hundred bytes
          if (lastctr - ctr)>4096 then
          begin
           ss:='Remaining, Bytes: '+IntToStr(ctr)+', ';

           diff:=DateUtils.MilliSecondsBetween(Time, tStart);
           diff:= (ctr * diff) div (1000 * (fsize-ctr));
           sTime:=IntToStr(diff div 360)+':';
           diff:= diff - 360 * (diff div 360);
           if diff<600 then
             sTime:=sTime+'0';
           sTime:=sTime+IntToStr(diff div 60)+':';
           diff:= diff - 60 * (diff div 60);
           if diff<10 then
             sTime:=sTime+'0';
           sTime:=sTime+IntToStr(diff);

           ss:=ss+'Time '+sTime+'  ';
           Memo1.Lines.Strings[Memo1.Lines.Count-1]:=ss;

           lastctr:=ctr;
          end;

        end;
      end;

    end
  else
  begin
    Memo1.append('Saber Not Ready to Write File, aborting.');
  end;

  //restore comms interrupt
  TimerRX.Enabled:=rx;
end;



procedure TForm1.btnUploadClick(Sender: TObject);
var
 i: Integer;
begin
  //Get a list of files
  OpenDialog1.FileName:='';

  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName)+'firmware';
  OpenDialog1.Title:='Select one or more RAW sound files';
  OpenDialog1.Filter:='Any file|*.*';
  OpenDialog1.Options:=OpenDialog1.Options + [ofFileMustExist, ofEnableSizing, ofDontAddToRecent, ofAllowMultiSelect ];
  if lastUploadPath.IsEmpty then
  begin

    {$IF defined(MSWindows)}
    OpenDialog1.InitialDir:=GetWindowsSpecialDir(CSIDL_PERSONAL);
    {$elseif defined(DARWIN)}
    OpenDialog1.InitialDir:=AppendPathDelim(GetUserDir + 'Documents');
    {$ENDIF}
  end
  else
   OpenDialog1.InitialDir:=lastUploadPath;

  OpenDialog1.FileName:='';

  // then - one at a time upload them
  if not OpenDialog1.Execute then
    ShowMessage('File upload cancelled')
  else
  begin
   // force the debug windows on
    if Not(miDebug.Checked) then
    begin
      miDebug.Checked:= True;

      Memo1.Visible:=miDebug.Checked;
      miSendCommand.Visible:=miDebug.Checked;
      miExtraDebugInfo.Visible:=miDebug.Checked;
      miClearLog.Visible:=miDebug.Checked;

      Memo1.SelStart := Length(Memo1.Lines.Text);
    end;

    serialOutQueue.Clear;
    TimerRX.Enabled:=False;

    // Display the selected file names
    for i := 0 to OpenDialog1.Files.Count-1 do
    begin
      if i>0 then
        delay(1500);
      sendFile(OpenDialog1.Files[i]);
    end;


    lastUploadPath:=OpenDialog1.GetNamePath();
    TimerRX.Enabled:=True;
    PushLn('LIST?');
  end;
end;

procedure TForm1.chClashClickCheck(Sender: TObject);
begin
  sendSoundCSV('sCL', chClash);
end;

procedure TForm1.chHumClickCheck(Sender: TObject);
begin
  sendSoundCSV('sHUM', chHum);
end;

procedure TForm1.chOffClickCheck(Sender: TObject);
begin
  sendSoundCSV('sOFF', chOff);
end;

procedure TForm1.sendSoundCSV(prefix:String; ch: TCheckListBox);
var
 csv : String;
 i : Integer;
begin
   csv:='';
   for i := 0 to ch.Count -1 do
   begin
     if ch.Items[i].EndsWith(' **') then
       ch.Checked[i]:=False
     else
      if ch.Checked[i] then
      begin
        if Not(csv.IsEmpty) then
          csv:=csv+',';

        csv:=csv+ch.Items[i];
      end;
   end;

   WriteLn(prefix+'='+csv);
   PushLn(prefix+'?');
end;

procedure TForm1.chOnClickCheck(Sender: TObject);
begin
  sendSoundCSV('sON', chOn);
end;

procedure TForm1.chSmoothAClickCheck(Sender: TObject);
begin
  sendSoundCSV('sSMA', chSmoothA);
end;

procedure TForm1.chSmoothBClickCheck(Sender: TObject);
begin
  sendSoundCSV('sSMB', chSmoothB);
end;

procedure TForm1.chSwingClickCheck(Sender: TObject);
begin
  sendSoundCSV('sSW', chSwing);
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
  OpenDialog1.Options:=OpenDialog1.Options + [ofFileMustExist, ofEnableSizing, ofDontAddToRecent]  - [ ofAllowMultiSelect ];

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
  inp:String;
begin
    //read all the settings to save back after the upgrade/downgrade
    TimerRx.Enabled:=False;
    saveData.Clear;

    if Assigned(winSerial) then
    begin
      WriteLn('B?');
      PushLn('W?');
      PushLn('C?');
      PushLn('F?');
      getlines:=17;
      if tabSwing.TabVisible then
         getlines:=25;

      abort:=0;
      while (saveData.Count<getlines) and (abort<4096) do
      begin
        Application.ProcessMessages;
        inp:=getReply();
        if Not(inp.IsEmpty) then
          saveData.Append(inp);
        abort:=abort+1;
        Memo1.Append('#'+IntToStr(saveData.Count)+'/'+IntToStr(getlines)+' : '+IntToStr(abort));

        if serialOutQueue.Count>0 then
        begin
          inp:=serialOutQueue.Strings[0];
          serialOutQueue.Delete(0);
          writeLn(inp);
        end;
      end;
      if (abort>=4096) then
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
      TimerRx.Enabled:=False;
      CloseSerial();

      //wait to allow serial to disconnect properly
      Application.ProcessMessages;
      Delay(250);
      Application.ProcessMessages;
      Delay(250);
      Application.ProcessMessages;
    end;

    ExecuteProcess( ExtractFilePath(Application.ExeName)+'firmware\upload.cmd',[filename],[]);

    //wait before re-opening the serial device
    Application.ProcessMessages;
    Delay(1500);
    Application.ProcessMessages;

    OpenSerial(Sender);
    //ComboBox1Select(Sender);
end;

procedure TForm1.AutoPreview();
begin
  AutoPreview(getActiveBank());
end;

procedure TForm1.AutoPreview(c: TRGBWColour);
begin
  if miAutoPreview.Checked then
    Preview(c, miExtraDebugInfo.Checked)
end;

procedure TForm1.Preview(c: TRGBWColour);
begin
  Preview(c, miExtraDebugInfo.Checked);
end;

procedure TForm1.Preview(c: TRGBWColour; log: Boolean);
begin
 if (serialOutQueue.Count=0) and previewLive then
 begin
   Memo1.append('preview '+IntToStr(c.red)+','+IntToStr(c.green)+','+IntToStr(c.blue)+','+IntToStr(c.white));
   if miRGBW255.Checked then
     WriteLn('P='+c.toCSV(), log)
   else
     WriteLn('P='+c.correctToSaber().toCSV(), log);
 end;
end;

procedure TForm1.btnPreview1Click(Sender: TObject);
begin
  Preview(getBank(TabMain), true);
end;
procedure TForm1.btnPreview2Click(Sender: TObject);
begin
  Preview(getBank(TabClash), true);
end;
procedure TForm1.btnPreview3Click(Sender: TObject);
begin
  Preview(getBank(TabSwing), true);
end;

procedure TForm1.btnRefreshListsClick(Sender: TObject);
begin
  PushLn('LIST?');
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
     winSerial.CloseSocket;

     //validatedPort:='';
     labStatus.Caption:='Disconnected';
     GroupBanks.Enabled:=False;
     pageControl.Enabled:=false;

     btnDisconnect.Caption:='Connect';
   end;
end;

procedure TForm1.btnDeleteFilesClick(Sender: TObject);
begin

  if (MessageDlg('DELETE',
                 'Do you wish to Delete ALL the files on the saber?'+#010+#010
                 +'This will take a few minutes and cannot be undone.',
                 mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
  begin
    // force the debug windows on
    if Not(miDebug.Checked) then
    begin
      miDebug.Checked:= True;

      Memo1.Visible:=miDebug.Checked;
      miSendCommand.Visible:=miDebug.Checked;
      miExtraDebugInfo.Visible:=miDebug.Checked;
      miClearLog.Visible:=miDebug.Checked;

      Memo1.SelStart := Length(Memo1.Lines.Text);
    end;

    clearSoundLists();

    FormResize(Sender);

    if (MessageDlg('SERIOUSLY',
                 'This will Delete ALL the files on the saber?'+#010+#010
                 +'You will have to re-upload every Sound File.'+#010+#010
                 +'Delete them all?',
                 mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
    begin
      WriteLn('ERASE=ALL')
    end
    else
    begin
      PushLn('LIST?');
    end;
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
    if(miRGBW255.Checked) then
      WriteLn('c'+bank+'='+getBank(TabMain).toCSV())
    else
      WriteLn('c'+bank+'='+getBank(TabMain).correctToSaber().toCSV());

    //request values back to confirm
    PushLn('c'+bank+'?');

  end;
end;
procedure TForm1.btnSend2Click(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);
    if(miRGBW255.Checked) then
      WriteLn('f'+bank+'='+getBank(TabClash).toCSV())
    else
      WriteLn('f'+bank+'='+getBank(TabClash).correctToSaber().toCSV());
    //request values back to confirm
    PushLn('f'+bank+'?');

  end;
end;
procedure TForm1.btnSend3Click(Sender: TObject);
var
   bank:String;
begin
  if(validatedPort<>'') then
  begin
    bank:=IntToStr(ComboBank.ItemIndex);
    if(miRGBW255.Checked) then
      WriteLn('w'+bank+'='+getBank(TabSwing).toCSV())
    else
      WriteLn('w'+bank+'='+getBank(TabSwing).correctToSaber().toCSV());

    //request values back to confirm
    PushLn('w'+bank+'?');

  end;
end;

procedure TForm1.WriteLn(msg:String);
begin
  Writeln(msg, true);
end;

procedure TForm1.WriteLn(msg: String; log: Boolean);
begin
  if log then
    Memo1.Append('>> '+msg);
  if Assigned(winSerial) and winSerial.CanWrite(10) then
  begin
    winSerial.SendString(msg+#10);
  end;
end;

procedure TForm1.PushLn(msg: String);
begin
  if Assigned(winSerial) then
  begin
    serialOutQueue.Add(msg);
    TimerRX.Enabled:=True;
  end;
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

{$if defined(DARWIN)}
// mac os code
function TForm1.GetSignificantDir(DirLocation: qword; DomainMask: qword; count: byte): string;
var
  paths : NSArray;
begin
  paths := NSSearchPathForDirectoriesInDomains(DirLocation, DomainMask, True);
  if(count < paths.count) then
    Result := NSString(paths.objectAtIndex(0)).UTF8String
  else
    Result := '';
end;
{$ENDIF}

{$push}
{$warn 6058 off}
procedure TForm1.ZeroMemory(Destination: Pointer; Length: DWORD);
begin
  FillChar(Destination^, Length, 0);
end;
{$pop}
end.

