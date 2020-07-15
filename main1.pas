unit main1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  Buttons, ComCtrls, ActnList, ExtCtrls, LCLType, Math, StrUtils,
   FileInfo, crt
  {$IF defined(MSWindows)}
  ,registry,LazSerial
  {$elseif defined(DARWIN)}
  // mac os code

  {$ENDIF}
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnDisconnect: TBitBtn;
    btnResetColours: TBitBtn;
    btnFirmware: TBitBtn;
    btnSend: TBitBtn;
    cbDebug: TCheckBox;
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
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
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
    procedure cbDebugChange(Sender: TObject);
    procedure ComboBankSelect(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure RxData(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
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
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
ver : String;
Info: TVersionInfo;
fpath : String;
begin
  saveMode:=false;
  saveData := TStringList.Create;
  saveData.Clear;

  self.Width:=1500;
  self.Height:=800;

  fpath:=ExtractFilePath(Application.ExeName)+'firmware\';
  btnFirmware.Visible:= (FileExists(fpath+'tycmd.exe') and FileExists(fpath+'upload.cmd') );

  btnPreview1.Visible:=false;

  SpeedButton1.Caption:='Pick Main'+#13+'Colour';
  SpeedButton2.Caption:='Pick Clash'+#13+'Colour';
  btnPreview1.Caption:='Preview'+#13+'On Saber';

  serialInput:='';

  Memo1.Visible:=cbDebug.Checked;

  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  // grab the Numbers
  //[0] = Major version, [1] = Minor ver, [2] = Revision, [3] = Build Number
  ver:= IntToStr(Info.FixedInfo.FileVersion[0])
      +'.'+IntToStr(Info.FixedInfo.FileVersion[1])
      +'.'+IntToStr(Info.FixedInfo.FileVersion[2])
      +'.'+IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;
  // Update the title string - include the version & ver #
  Form1.Caption := Form1.Caption+' v.' + ver;

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
     ComboBox1.Items.Add('--');
     ShowMessage('No USB Sabers Ports Detected.'+#13+'Connect the OpenCore saber.'+#13+'Use a USB Cable that is for Data.'+#13+'and then restart the application');
     //Form1.Close; //<<does not work the form is still being created
     Application.Terminate;
     Halt; //<< ^Terminate seems to work Halt is boot and braces
     //exit application
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
  btnDisconnect.Caption:='Connect/Open';

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

 btnFirmware.left:=GroupPort.width-btnFirmware.width-10;
 cbDebug.left:= btnFirmware.left- cbDebug.width-20;
 btnDisconnect.left:= cbDebug.left - btnDisconnect.Width-16;

 InfoBank.top:=GroupPort.height+16;
 InfoBank.left:=GroupBanks.Width+10;
 InfoBank.width:=self.Width-GroupBanks.Width-20;
 InfoBank.height:=self.Height-InfoBank.Top-10;

 Memo1.width:= InfoBank.width-20;
 Memo1.height:= InfoBank.height-Memo1.top-50;
 labSerial.left:=Memo1.left;
 labBuild.left:=Memo1.left;

 x:=GroupBanks.width -20;
 btnSend.left:= x - btnSend.width;
 btnSend.top:= GroupBanks.height - btnSend.height-40;
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

 SpeedButton1.Left := trackCRed.Left + trackCRed.width - SpeedButton1.width - 16;
 SpeedButton2.Left := trackFRed.Left + trackFRed.width - SpeedButton2.width - 16;

end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
   r,g,b,w: Integer;
   mx : Integer;
begin
  w:=trackCWhite.Position;
  r:=trackCRed.Position+w;
  g:=trackCGreen.Position+w;
  b:=trackCBlue.Position+w;

  mx := Max(Max(r,g),b);
  if(mx>255) then
  begin
    mx:=mx-255;
    r:=Max(0,r-mx);
    g:=Max(0,g-mx);
    b:=Max(0,b-mx);
  end;
  ColorDialog1.Color:= r + 256*g + 65536*b;

  if ColorDialog1.Execute then
  begin
    r:=Byte(ColorDialog1.Color);
    g:=Byte(ColorDialog1.Color shr 8);
    b:=Byte(ColorDialog1.Color shr 16);
    w:=Min(Min(r,g),b);

    trackCRed.Position:=r-w;
    trackCGreen.Position:=g-w;
    trackCBlue.Position:=b-w;
    trackCWhite.Position:=w;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
   r,g,b,w: Integer;
   mx : Integer;
begin
  w:=trackFWhite.Position;
  r:=trackFRed.Position+w;
  g:=trackFGreen.Position+w;
  b:=trackFBlue.Position+w;

  mx := Max(Max(r,g),b);
  if(mx>255) then
  begin
    mx:=mx-255;
    r:=Max(0,r-mx);
    g:=Max(0,g-mx);
    b:=Max(0,b-mx);
  end;
  ColorDialog1.Color:= r + 256*g + 65536*b;

  if ColorDialog1.Execute then
  begin
    r:=Byte(ColorDialog1.Color);
    g:=Byte(ColorDialog1.Color shr 8);
    b:=Byte(ColorDialog1.Color shr 16);
    w:=Min(Min(r,g),b);

    trackFRed.Position:=r-w;
    trackFGreen.Position:=g-w;
    trackFBlue.Position:=b-w;
    trackFWhite.Position:=w;
  end; end;

procedure TForm1.RxData(Sender: TObject);
var
 inp : String;
 colours: Array of String;
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
     else if (inp.StartsWith('S=')) then
     begin
       labSerial.Caption:=inp.Replace('S=','Serial No. ');
     end
     else if (inp.StartsWith('B=')) then
     begin
       if(saveMode) then
       begin
         saveData.Add(inp);
       end
       else
       begin
         //labSerial.Caption:=inp.Replace('S=','Serial No. ');
         Memo1.Append('switching to live bank '+InttoStr(Ord(inp.Chars[2])-48));
         ComboBank.ItemIndex:=Ord(inp.Chars[2])-48;
         ComboBankSelect(Sender);
       end;
     end
     else if( (inp.StartsWith('c')) and (inp.Chars[2]='=') ) then
     begin
       if(saveMode) then
       begin
         saveData.Add(inp);
       end
       else
       begin
         inp:=inp.Substring(3);
         colours:=inp.Split(',');
         ledCRed.Caption:=colours[0];
         ledCGreen.Caption:=colours[1];
         ledCBlue.Caption:=colours[2];
         ledCWhite.Caption:=colours[3];
       end;
     end
     else if( (inp.StartsWith('C')) and (inp.Chars[2]='=') ) then
     begin
       if(saveMode) then
       begin
         saveData.Add(inp);
       end
       else
       begin
       //hex values
       trackCRed.Position:=Hex2Dec(inp.Substring(3,2));
       trackCGreen.Position:=Hex2Dec(inp.Substring(5,2));
       trackCBlue.Position:=Hex2Dec(inp.Substring(7,2));
       trackCWhite.Position:=Hex2Dec(inp.Substring(9,2));
       end;
     end
     else if( (inp.StartsWith('f')) and (inp.Chars[2]='=') ) then
     begin
       if(saveMode) then
       begin
         saveData.Add(inp);
       end
       else
       begin
       inp:=inp.Substring(3);
       colours:=inp.Split(',');
       ledFRed.Caption:=colours[0];
       ledFGreen.Caption:=colours[1];
       ledFBlue.Caption:=colours[2];
       ledFWhite.Caption:=colours[3];
       end;
     end
     else if( (inp.StartsWith('F')) and (inp.Chars[2]='=') ) then
     begin
       if(saveMode) then
       begin
         saveData.Add(inp);
       end
       else
       begin
         //hex values
         trackFRed.Position:=Hex2Dec(inp.Substring(3,2));
         trackFGreen.Position:=Hex2Dec(inp.Substring(5,2));
         trackFBlue.Position:=Hex2Dec(inp.Substring(7,2));
         trackFWhite.Position:=Hex2Dec(inp.Substring(9,2));
       end;
     end;

   end; //inp not empty

 end; //while contains 13
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
end;

procedure TForm1.TrackCBlueChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCBlue.Position);
 if(ledCBlue.Caption<>s) then
   ledCBlue.Caption:=s;
end;

procedure TForm1.TrackCGreenChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCGreen.Position);
 if(ledCGreen.Caption<>s) then
   ledCGreen.Caption:=s;
end;

procedure TForm1.trackCRedChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCRed.Position);
 if(ledCRed.Caption<>s) then
   ledCRed.Caption:=s;
end;

procedure TForm1.TrackCWhiteChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackCWhite.Position);
 if(ledCWhite.Caption<>s) then
   ledCWhite.Caption:=s;
end;

procedure TForm1.TrackFBlueChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFBlue.Position);
 if(ledFBlue.Caption<>s) then
   ledFBlue.Caption:=s;
end;

procedure TForm1.TrackFGreenChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFGreen.Position);
 if(ledFGreen.Caption<>s) then
   ledFGreen.Caption:=s;
end;

procedure TForm1.trackFRedChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFRed.Position);
 if(ledFRed.Caption<>s) then
   ledFRed.Caption:=s;
end;

procedure TForm1.TrackFWhiteChange(Sender: TObject);
var
 s : String;
begin
 s:=IntToStr(trackFWhite.Position);
 if(ledFWhite.Caption<>s) then
   ledFWhite.Caption:=s;
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

procedure TForm1.cbDebugChange(Sender: TObject);
begin
  Memo1.Visible:=cbDebug.Checked;
  FormResize(Sender);
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
var
   filename:String;
begin
  if(validatedPort<>'') then
  begin

    Memo1.Append(ExtractFilePath(Application.ExeName)+'firmware\');
    OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName)+'firmware\';
    OpenDialog1.Filter:='*.hex';

    if OpenDialog1.Execute then
    begin
      filename := OpenDialog1.Filename;

      if (MessageDlg('Update',
                     'Do you wish to Update Firmware to '+filename+' ?',
                     mtConfirmation, [mbYes, mbNo],0) = mrYes ) then
      begin
        //read all the settings to save back after the upgrade/downgrade
        saveMode:=true;
        saveData.Clear;
        WriteLn('B?');
        WriteLn('C?');
        WriteLn('F?');
        while (saveData.Count<17) do
        begin
          Application.ProcessMessages;
          Delay(100);
        end;

        CloseSerial();
        saveMode:=false;

        Application.ProcessMessages;
        Delay(250);
        Application.ProcessMessages;
        Delay(250);
        Application.ProcessMessages;

        ExecuteProcess( ExtractFilePath(Application.ExeName)+'firmware\upload.cmd',[filename],[]);

        Delay(1500);
        Application.ProcessMessages;
        OpenSerial(Sender);
        //ComboBox1Select(Sender);
      end;
    end; //Open file yes
  end
  else
  begin
    ShowMessage('Update' + sLineBreak + 'You cannot update unless a saber has been detected!' );
  end; //is Serial Active
end;

procedure TForm1.btnPreview1Click(Sender: TObject);
begin
  WriteLn('P='+ledFRed.Caption+','+ledFGreen.Caption+','+ledFBlue.Caption+','+ledFWhite.Caption);
end;

procedure TForm1.btnDisconnectClick(Sender: TObject);
begin
   if (btnDisconnect.Caption='Connect') then
   begin
     btnDisconnect.Caption:='SAVE/DISCONNECT';
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

end.

