program Project2;

uses
  Forms,
  Unit1 in '..\02 mine\Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
