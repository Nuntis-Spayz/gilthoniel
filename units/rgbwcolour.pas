unit RGBWColour;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Math, StrUtils, StdCtrls;
type
  TRGBWColour = class
  Private
    cRed, cGreen, cBlue, cWhite : Integer;
    outMemo : TMemo;
    procedure wrMemo(msg: String);
  Public
    Class Constructor Create; overload;

    procedure setMemo(tm : TMemo);

    procedure setRed(r : Integer);
    procedure setGreen(g : Integer);
    procedure setBlue(b : Integer);
    procedure setWhite(w : Integer);

    procedure setColour(r,g,b,w : Integer);
    procedure setColour(c : String);
    procedure setPercentage(r,g,b,w : Integer);
    procedure setColourValues(r,g,b,w : Integer; asPercentage : Boolean);

    procedure setRGB(r,g,b : Integer);
    procedure setRGB(c : TColor) overload;

    procedure setRedValue(r : Integer; asPercentage : Boolean);
    procedure setGreenValue(g : Integer; asPercentage : Boolean);
    procedure setBlueValue(b : Integer; asPercentage : Boolean);
    procedure setWhiteValue(w : Integer; asPercentage : Boolean);

    function getRed():Integer;
    function getGreen():Integer;
    function getBlue():Integer;
    function getWhite():Integer;
    function toCSV():string;

    function getRedValue(asPercentage : Boolean):Integer;
    function getGreenValue(asPercentage : Boolean):Integer;
    function getBlueValue(asPercentage : Boolean):Integer;
    function getWhiteValue(asPercentage : Boolean):Integer;

    function getRGB() : TColor;
    function correctToSaber():TRGBWColour;

    property red: Integer read getRed write setRed stored false default 0;
    property green: Integer read getGreen write setGreen stored false default 0;
    property blue: Integer read getBlue write setBlue stored false default 0;
    property white: Integer read getWhite write setWhite stored false default 0;
  end;

implementation

Class Constructor TRGBWColour.Create;
begin
 inherited;

end;

procedure TRGBWColour.setMemo(tm : TMemo);
begin
  outMemo:=tm;
end;
procedure TRGBWColour.wrMemo(msg: String);
begin
 if Assigned(outMemo) then
    outMemo.Append(msg);
end;

procedure TRGBWColour.setRed(r : Integer);
begin
  cRed:=r;
end;
procedure TRGBWColour.setGreen(g : Integer);
begin
  cGreen:=g;
end;
procedure TRGBWColour.setBlue(b : Integer);
begin
  cBlue:=b;
end;
procedure TRGBWColour.setWhite(w : Integer);
begin
  cWhite:=w;
end;

function TRGBWColour.getRed():Integer;
begin
  getRed:=cRed;
end;
function TRGBWColour.getGreen():Integer;
begin
  getGreen:=cGreen;
end;
function TRGBWColour.getBlue():Integer;
begin
  getBlue:=cBlue;
end;
function TRGBWColour.getWhite():Integer;begin
  getWhite:=cWhite;
end;

procedure TRGBWColour.setRedValue(r : Integer; asPercentage : Boolean);
begin
  if asPercentage then
    cRed:=r * 255 div 100
  else
    cRed:=r;
end;
procedure TRGBWColour.setGreenValue(g : Integer; asPercentage : Boolean);
begin
  //wrMemo('setGreen 1,'+IntToStr(g));

  if asPercentage then
    cGreen:=g * 255 div 100
  else
    cGreen:=g;

  //wrMemo('setGreen 2,'+IntToStr(cGreen));
end;
procedure TRGBWColour.setBlueValue(b : Integer; asPercentage : Boolean);
begin
  if asPercentage then
    cBlue:=b * 255 div 100
  else
    cBlue:=b;
end;
procedure TRGBWColour.setWhitevalue(w : Integer; asPercentage : Boolean);
begin
  if asPercentage then
    cWhite:=w * 255 div 100
  else
    cWhite:=w;
end;

procedure TRGBWColour.setColourValues(r,g,b,w : Integer; asPercentage : Boolean);
begin
  if asPercentage then
    setPercentage(r,g,b,w)
  else
    setColour(r,g,b,w);
end;

procedure TRGBWColour.setColour(r,g,b,w : Integer);
begin
  cRed:=r;
  cGreen:=g;
  cBlue:=b;
  cWhite:=w;
end;

procedure TRGBWColour.setColour(c : String);
var
 colours: Array of String;
begin
  if c.Contains(',') then
  begin
    colours:=c.Split(',');
    cRed:=StrToInt(colours[0]);
    cGreen:=StrToInt(colours[1]);
    cBlue:=StrToInt(colours[2]);
    cWhite:=StrToInt(colours[3]);
  end
  else
  begin
    cRed:=Hex2Dec(c.Substring(0,2));
    cGreen:=Hex2Dec(c.Substring(2,2));
    cBlue:=Hex2Dec(c.Substring(4,2));
    cWhite:=Hex2Dec(c.Substring(6,2));
  end;
end;

procedure TRGBWColour.setPercentage(r,g,b,w : Integer);
begin
  cRed:=r * 255 div 100;
  cGreen:=g * 255 div 100;
  cBlue:=b * 255 div 100;
  cWhite:=w * 255 div 100;
end;

procedure TRGBWColour.setRGB(r,g,b : Integer);
begin
 //calculate a white
 cWhite:=Min(Min(r,g),b);
 cRed:=r-cWhite;
 cGreen:=g-cWhite;
 cBlue:=b-cWhite;

 //REVERSE NORMALISE THE RED
 cRed:=cRed * 170 div 255;
end;

procedure TRGBWColour.setRGB(c : TColor);
begin
  setRGB( Graphics.Red(c), Graphics.Green(c), Graphics.Blue(c));
end;

function TRGBWColour.getRedValue(asPercentage : Boolean):Integer;
begin
  if asPercentage then
    getRedValue:= cRed * 100 div 255
  else
    getRedValue:=cRed;
end;
function TRGBWColour.getGreenValue(asPercentage : Boolean):Integer;
begin
  if asPercentage then
    getGreenValue:= cGreen * 100 div 255
  else
    getGreenValue:=cGreen;
end;
function TRGBWColour.getBlueValue(asPercentage : Boolean):Integer;
begin
  if asPercentage then
    getBlueValue:= cBlue * 100 div 255
  else
    getBlueValue:= cBlue;
end;
function TRGBWColour.getWhiteValue(asPercentage : Boolean):Integer;begin
  if asPercentage then
    getWhiteValue:= cWhite * 100 div 255
  else
    getWhiteValue:= cWhite;
end;

function TRGBWColour.correctToSaber():TRGBWColour;
begin
  correctToSaber:=TRGBWColour.Create;
  correctToSaber.red:=cRed;
  correctToSaber.green:=cGreen;
  correctToSaber.blue:=cBlue;
  correctToSaber.white:=cWhite;

  if (cGreen<>0) or (cBlue<>0) or (cWhite<>0) then
  begin
    correctToSaber.red := cRed * 170 div 255
  end
  else  if (cRed=0) and ((cGreen<>0) or (cBlue<>0)) then
  begin
    correctToSaber.white:= cWhite * 200 div 255
  end;
end;

function TRGBWColour.getRGB() : TColor;
var
 r,g,b, w: Integer;
 mx : Integer;
begin
 wrMemo('RGBW : ' + IntToStr(red)+', ' + IntToStr(green)+', ' + IntToStr(blue)+', ' + IntToStr(white));

 r:=cRed;
 g:=cGreen;
 b:=cBlue;
 w:=cWhite;

  //Normalize RED
 r:=256 * r div 110;
 mx := Max(Max(r,g),b);
 if(mx>255) then
 begin
   mx:=mx-255;
   r:=Max(0,r-mx);
   g:=Max(0,g-mx);
   b:=Max(0,b-mx);
   //w:=Max(0,w-mx);
 end;

 r:=r+w;
 g:=g+w;
 b:=b+w;
 //normalize vs white
 mx := Max(Max(r,g),b);
 if(mx>255) then
 begin
   mx:=mx-255;
   r:=Max(0,r-mx);
   g:=Max(0,g-mx);
   b:=Max(0,b-mx);
 end;

 wrMemo('-> RGB : ' + IntToStr(r)+', ' + IntToStr(g)+', ' + IntToStr(b));
 getRGB:= RGBToColor(r,g,b) ;
end;

function TRGBWColour.toCSV():string;
begin
  toCSV:=IntToStr(cRed)+','+IntToStr(cGreen)+','+IntToStr(cBlue)+','+IntToStr(cWhite);
end;

end.

