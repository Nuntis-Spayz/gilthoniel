unit RGBWColour;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Math, StrUtils;
type
  TRGBWColour = class
  Private
    cRed, cGreen, cBlue, cWhite : Integer;

  Public
    Class Constructor Create; overload;

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

    property red: Integer read getRed write setRed stored true default 0;
    property green: Integer read getGreen write setGreen stored true default 0;
    property blue: Integer read getBlue write setBlue stored true default 0;
    property white: Integer read getWhite write setWhite stored true default 0;
  end;

implementation

Class Constructor TRGBWColour.Create;
begin
 inherited;

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
    red:=r * 255 div 100
  else
    red:=r;
end;
procedure TRGBWColour.setGreenValue(g : Integer; asPercentage : Boolean);
begin
  if asPercentage then
    green:=g * 255 div 100
  else
    green:=g;
end;
procedure TRGBWColour.setBlueValue(b : Integer; asPercentage : Boolean);
begin
  if asPercentage then
    blue:=b * 255 div 100
  else
    blue:=b;
end;
procedure TRGBWColour.setWhitevalue(w : Integer; asPercentage : Boolean);
begin
  if asPercentage then
    white:=w * 255 div 100
  else
    white:=w;
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
  red:=r;
  green:=g;
  blue:=b;
  white:=w;
end;

procedure TRGBWColour.setColour(c : String);
var
 colours: Array of String;
begin
  if c.Contains(',') then
  begin
    colours:=c.Split(',');
    red:=StrToInt(colours[0]);
    green:=StrToInt(colours[1]);
    blue:=StrToInt(colours[2]);
    white:=StrToInt(colours[3]);
  end
  else
  begin
    red:=Hex2Dec(c.Substring(0,2));
    green:=Hex2Dec(c.Substring(2,2));
    blue:=Hex2Dec(c.Substring(4,2));
    white:=Hex2Dec(c.Substring(6,2));
  end;
end;

procedure TRGBWColour.setPercentage(r,g,b,w : Integer);
begin
  red:=r * 255 div 100;
  green:=g * 255 div 100;
  blue:=b * 255 div 100;
  white:=w * 255 div 100;
end;

procedure TRGBWColour.setRGB(r,g,b : Integer);
begin
 //calculate a white
 white:=Min(Min(r,g),b);
 red:=r-white;
 green:=g-white;
 blue:=b-white;

 //REVERSE NORMALISE THE RED
 red:=red * 110 div 255;
end;

procedure TRGBWColour.setRGB(c : TColor);
begin
  setRGB( Graphics.Red(c), Graphics.Green(c), Graphics.Blue(c));
end;

function TRGBWColour.getRedValue(asPercentage : Boolean):Integer;
begin
  if asPercentage then
    getRedValue:= red * 100 div 255
  else
    getRedValue:=red;
end;
function TRGBWColour.getGreenValue(asPercentage : Boolean):Integer;
begin
  if asPercentage then
    getGreenValue:= green * 100 div 255
  else
    getGreenValue:=green;
end;
function TRGBWColour.getBlueValue(asPercentage : Boolean):Integer;
begin
  if asPercentage then
    getBlueValue:= blue * 100 div 255
  else
    getBlueValue:=blue;
end;
function TRGBWColour.getWhiteValue(asPercentage : Boolean):Integer;begin
  if asPercentage then
    getWhiteValue:= white * 100 div 255
  else
    getWhiteValue:=white;
end;

function TRGBWColour.correctToSaber():TRGBWColour;
begin
  correctToSaber:=TRGBWColour.Create;
  correctToSaber.red:=self.red;
  correctToSaber.green:=self.green;
  correctToSaber.blue:=self.blue;
  correctToSaber.white:=self.white;

  if (green<>0) or (blue<>0) or (white<>0) then
  begin
    correctToSaber.red := red * 170 div 255
  end
  else  if (red=0) and ((green<>0) or (blue<>0)) then
  begin
    correctToSaber.white:= white * 200 div 255
  end;
end;

function TRGBWColour.getRGB() : TColor;
var
 r,g,b, w: Integer;
 mx : Integer;
begin
 //if miExtraDebugInfo.Checked then
 //  Memo1.Append('RGBW : ' + IntToStr(red)+', ' + IntToStr(green)+', ' + IntToStr(blue)+', ' + IntToStr(white));
 r:=red;
 g:=green;
 b:=blue;
 w:=white;

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


 //if miExtraDebugInfo.Checked then
 //  Memo1.Append('-> RGB : ' + IntToStr(r)+', ' + IntToStr(g)+', ' + IntToStr(b));
 getRGB:= RGBToColor(r,g,b) ;
end;

function TRGBWColour.toCSV():string;
begin
  toCSV:=IntToStr(red)+','+IntToStr(green)+','+IntToStr(blue)+','+IntToStr(white);
end;

end.

