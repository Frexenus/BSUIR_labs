unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n,m:integer;

implementation

{$R *.dfm}

function st(k,z:integer):extended; //������� ���������� � �������
var i:integer;                     //k-�����, z-�������
    g:extended;
begin
 result:=k;
 if z>0 then
  for i:=1 to z do result:=result*n;
 if z<0 then
  begin
   g:=1;
   for i:=1 to abs(z) do g:=g*n;
   result:=k*(1/g);
  end;
end;

function ConvIn(s:char):integer;  //������� �������� �� ������� � �����
var x:integer;
begin
 case ord(s) of
  48..57: convin:=strtoint(s);
  65..90: convin:=ord(s)-55;
  97..122: convin:=ord(s)-87;
 end;
end;

function ConvOut(k:integer):char; //������� �������� �� ����� � ������
begin
 case k of
  0..9 : convout:=inttostr(k)[1];
  10..36 : convout:=chr(k+55);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.Text:='';
 Edit2.Text:='';
 Edit3.Text:='';
 Edit4.Text:='';
 Edit4.Visible:=false;        //������� ���� ����������
end;

procedure TForm1.Button1Click(Sender: TObject);
var r,h,g,x,z,i,j: integer;
a,b:string;
k,c:extended;
l:boolean;
begin
//������ �� ������
 if (Edit1.Text='') or (Edit2.Text='') or (Edit3.Text='')
  or (strtoint(Edit1.Text)>36) or (strtoint(Edit3.Text)>36) then
  begin
   Showmessage('��������� ��������');
   Exit;
  end;
//������� ��������
 n:=strtoint(Edit1.text);
 m:=strtoint(Edit3.text);
 a:=Edit2.Text;
 c:=0; b:=''; x:=0;
 l:=false;
 if a[1]='-' then        //�������� �� ���������������
  begin
   l:=true;
   delete(a,1,1);
  end;
 if pos('.',a)<>0 then   //������ �� ������ (������ ����� �� �������)
  begin
   z:=pos('.',a);
   a[z]:=',';
  end;
 z:=pos(',',a);          //����������� ��������� �������� ����������
 if z<>0 then
  x:=strtoint(InputBox('������� ����� ��������','������� ��������� ���-�� ������ ����� �������',inttostr(length(a)-z)));
 if x>0 then             //������������ �� ����� � ������� �����
  begin
//������� ����� ����� � ������������ �������
   for i:=1 to z-1 do
    c:=c+st(convin(a[i]),z-i-1);
//������� ������� ����� � ������������
   for i:=z+1 to length(a) do
    c:=c+st(convin(a[i]),z-i);
//������� ����� ����� � ������ �������
   g:=trunc(c);
   repeat
    h:=g mod m;
    g:=g div m;
    b:=convout(h)+b;
   until g<m;
   b:=convout(g)+b;
//������� ������� ����� � ������ �������
   k:=frac(c);
   b:=b+',';
   for i:=1 to x do
    begin
     k:=k*m;
     h:=trunc(k);
     k:=frac(k);
     b:=b+convout(h);
    end;
  end
 else
  begin
//������� ������ ����� � ���������� �������
   r:=length(a);
   if (z<>0) and (z<r) then r:=z;
   for i:=1 to r do
    c:=c+st(convin(a[i]),r-i);
//������� ������ ����� �� ���������� � ������ �������
   g:=trunc(c);
   repeat
    h:=g mod m;
    g:=g div m;
    b:=convout(h)+b;
   until g<m;
   b:=convout(g)+b;
  end;
 if l then b:='-'+b;       //����������� �����
 edit4.Visible:=true;      //��������� ���� ������
 edit4.Text:=b;            //����� ������
end;
{�����: ����� �����, ��.��.712502, ICQ:211268307
 ����: 15 ������� 2007 ����}
end.
