unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unit2, StdCtrls, Buttons;

type

   // MM = Integer;
  //m=^MM;
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    SaveDialog1: TSaveDialog;
    Button1: TButton;
    btn1: TBitBtn;

    procedure Button1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  m:Integer;
  Form1: TForm1;
  FT:textfile;
  filename:string;


implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var a,b,h,n,x:Extended;


begin
a:=strtofloat(edt1.text);
b:=strtofloat(edt2.text);
n:=strtofloat(edt3.text);
m:=strtoint(edt4.text);

h:=Round((a+b)/n);
  if SaveDialog1.Execute then begin
    filename := SaveDialog1.FileName;
    AssignFile(FT,filename);
    Rewrite(FT);
  end;
while (x<b) do begin

podprog(FT,x,m);
x:=x+h

end;

Closefile(FT);

end;

end.
