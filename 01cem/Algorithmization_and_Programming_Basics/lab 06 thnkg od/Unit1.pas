unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, Buttons, ExtCtrls, Unit2;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Xn,Xk,X,e,a,s,y,M,h:extended;
  n,k:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Edit1.Text:='1';
Edit2.Text:='3';
Edit3.Text:='0,2';
Edit4.Text:='0,001';
end;





procedure TForm1.Button1Click(Sender: TObject);
begin
 Memo1.Clear;
 Memo1.Lines.Add('Results:');
 Xn:=StrToFloat(Edit1.Text);
 Memo1.Lines.Add('Xn='+FloatToStrF(Xn,ffFixed,6,2));
 Xk:=StrToFloat(Edit2.Text);
 Memo1.Lines.Add('Xk='+FloatToStrF(Xk,ffFixed,6,2));
 h:=StrToFloat(Edit3.Text);
 Memo1.Lines.Add('M='+FloatToStrF(M,ffFixed,8,3));
 e:=StrToFloat(Edit4.Text);
 Memo1.Lines.Add('e='+FloatToStrF(e,ffFixed,8,5));
 //h:=(Xk-Xn)/M;
 X:=Xn;
 repeat

    s:=yx(x);
    y:=ys(x);
    if radiogroup1.ItemIndex=0
       then    Memo1.Lines.Add('Pri X='+FloatToStrF(X,ffFixed,6,2)+'  summa='+FloatToStrF(s,ffFixed,8,4))
        else  Memo1.Lines.Add('Pri X='+FloatToStrF(X,ffFixed,6,2)+'   y='+FloatToStrF(y,ffFixed,8,4) );

    X:=X+h;
  until X>(Xk+h/2)

end;

end.

