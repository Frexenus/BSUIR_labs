unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Button4: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 var
   Form1: TForm1;
   A:array of char;
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
//������ ������� �� ��������� � ������ ��������� ����� 5
  N:=5; Edit1.Text:=inttostr(N);
  Edit2.Clear;
  StringGrid1.ColCount:=N;     //������ ���-�� �������� �������
end;

procedure TForm1.Button1Click(Sender: TObject);
begin   //������ ��������� ������� �������
  N:=StrToInt(Edit1.Text);
  StringGrid1.ColCount:=N;
end;

procedure TForm1.Button3Click(Sender: TObject);
 var k:integer;
     t:char;
begin
//�������� ������ ��� ������ ������� ����� ������
 SetLength(a,n+1);
 k:=strtoint(edit2.Text);
//������ ������ �� ������� � ������
//(������� ��������� � �� ���������� ������� � ������):
 for i:=1 to N do
  A[i]:=StringGrid1.Cells[i-1,0][1];

 for i:=1 to k do
  begin
   t:=a[n];
   for j:=n-1 downto 1 do a[j+1]:=a[j];
   a[1]:=t;
  end;

//����� ����������:
 for i:=1 to n do stringgrid1.cells[i-1,0]:=a[i];
//������������ ������, ���������� ������������ ��������
 a:=nil;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin  //������-�������, ����������� ������� ������� ���������� ���������
 randomize;  //��������� ������������� ������� ������� ���������� ����� (random)
 for i:=0 to n do
   stringgrid1.Cells[i,0]:=chr(random(75)+48);
end;

end.

