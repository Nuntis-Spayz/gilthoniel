program gilthoniel;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main1, runtimetypeinfocontrols, LazSerialPort, frmHelp;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Gilthoniel';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormHelp, FormHelp);
  Application.Run;
end.

