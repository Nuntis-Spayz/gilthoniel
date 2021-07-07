unit reg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, registry;
type
  TReg1 = class
  private
    class var baseKey : String;
  public
    class procedure setBaseKey(key : String) static;
    class function readString(key : String; default:String):String; static;
    class function readInteger(key : String; default:Integer):Integer; static;
    class function readBoolean(key : String; default:Boolean):Boolean; static;

    class procedure writeString(key : String; value:String); static;
    class procedure writeInteger(key : String; value:Integer); static;
    class procedure writeBoolean(key : String; value:Boolean); static;
  end;

implementation
Class procedure TReg1.setBaseKey(key : String);
begin
  baseKey:=key;
end;

Class function TReg1.readString(key : String; default:String):String;
var
  Registry: TRegistry;
begin
  readString:=default;
  try
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(baseKey) then
      try
        readString:=Registry.ReadString(key); //read the value of the key name
      except
        on e: Exception do
          writeString(key,default);
      end;
  finally
    Registry.Free;  // In non-Windows operating systems this flushes the reg.xml file to disk
  end;
end;
Class function TReg1.readInteger(key : String; default:Integer):Integer;
var
  Registry: TRegistry;
begin
  readInteger:=default;
  try
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(baseKey) then
      try
        readInteger:=Registry.ReadInt64(key); //read the value of the key name
      except
        on e: Exception do
          writeInteger(key,default);
      end;

  finally
    Registry.Free;  // In non-Windows operating systems this flushes the reg.xml file to disk
  end;
end;
Class function TReg1.readBoolean(key : String; default:Boolean):Boolean;
var
  Registry: TRegistry;
begin
  readBoolean:=default;
  try
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(baseKey) then
      try
        readBoolean:=Registry.ReadBool(key); //read the value of the key name
      except
        on e: Exception do
          writeBoolean(key,default);
      end;
    finally
    Registry.Free;  // In non-Windows operating systems this flushes the reg.xml file to disk
  end;
end;

Class procedure TReg1.writeString(key : String; value:String);
var
  Registry: TRegistry;
  canCreate: Boolean;
begin
  Registry := TRegistry.Create;
  canCreate:=true;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey(baseKey, canCreate) then
      Registry.WriteString(key, value);
  finally
    Registry.Free;  // In non-Windows operating systems this flushes the reg.xml file to disk
  end;
end;

Class procedure TReg1.writeInteger(key : String; value:Integer);
var
  Registry: TRegistry;
  canCreate: Boolean;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    canCreate:=true;
    if Registry.OpenKey(baseKey, canCreate) then
      Registry.WriteInteger(key, value);
  finally
    Registry.Free;  // In non-Windows operating systems this flushes the reg.xml file to disk
  end;
end;

Class procedure TReg1.writeBoolean(key : String; value:Boolean);
var
  Registry: TRegistry;
  canCreate: Boolean;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    canCreate:=true;
    if Registry.OpenKey(baseKey, canCreate) then
      Registry.WriteBool(key, value)
  finally
    Registry.Free;  // In non-Windows operating systems this flushes the reg.xml file to disk
  end;
end;


end.

