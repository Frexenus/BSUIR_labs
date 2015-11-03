unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Click(Sender: TObject);
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

procedure TForm1.FormCreate(Sender: TObject);
begin
 ComboBox1.Text:='';
 Memo1.Clear;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
 ComboBox1.SetFocus;
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then
  begin
   ComboBox1.Items.Add(ComboBox1.Text);
   ComboBox1.Text:='';
  end;
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
var s,sr:string;
      n,k,w,i,j:integer;
      a:array[1..100] of string;
begin
   memo1.clear;
   S:=ComboBox1.Text;
   sr:=s;
   S:=S+' ';
   repeat          //������������ ������ ������� ��� ���������� �� �����
    k:=Pos('  ',s);
    if k<>0 then Delete (s,k,1);
   until k=0;
   if S[1]=' ' then delete(s,1,1);

   n:=0;          //������������ ������� ����
   repeat
    k:=pos(' ',s);
    if k<>0 then
     begin
      inc(n);
      a[n]:=copy(s,1,k-1);
      delete(s,1,k);
     end;
    until k=0;

    w:=length(a[1]);     //����� ���������� ������
    for i:=1 to n do
     if length(a[i])>w then w:=length(a[i]);
    Memo1.Lines.add('����� �����: '+inttostr(w));
    Memo1.Lines.add('������ ����: ');

    for i:=1 to n do    //����� � ����� ���� ���� ���������� ������
     begin
      if length(a[i])=w then
       begin
        Memo1.Lines.Add(a[i]);
        Memo1.Lines.add('����� �����: '+inttostr(i));
        Memo1.Lines.add('��������� �������: '+inttostr(pos(a[i],sr)));
        delete(sr,pos(a[i],sr),w);   //������ ����� � ������������ ������� �� �������
        for j:=1 to w do sr:=' '+sr; //����� �� ���� ������� � ����������� �������
       end;
     end;
end;

end.
