unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    BitBtn1: TBitBtn;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.Button1Click(Sender: TObject);
var a,b,reve,e:string;
    i,g,s:integer;
begin
  reve:='';
  s:=0;
  a:=edit1.Text;
  b:=edit2.Text;
for i:=strtoint(a) to strtoint(b) do
 begin
 for g:=length(inttostr(i)) downto 0 do  // inttostr(i) -  following stroke
 begin                                    // reve - reverse stroke
   e:=inttostr(i);                        // input 120 output 021 should be)
   Delete(e,1,g-1);
   if length(e)>1 then
   Delete(e,g,10);
   insert(e,reve,g-1);
 end;
 if i=strtoint(reve) then
 begin
  memo1.Lines.add(reve);
  reve:='';
  S:=s+1;
  reve:='';
 end;
 end;
  memo1.Lines.add('Result:'+intToStr(s));
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.Clear;
end;

end.
