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
    Button2: TButton;
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Edit2: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    StringGrid2: TStringGrid;
    Button4: TButton;
    Button5: TButton;
    Label2: TLabel;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{
1.����� ���������� ���� ��������� ������������ ���������� ������� ��������
�� ������ ���� � ���������
2. � ���� Tools->Debuger Options ������� ��������� �����
"Stop on Delphi Exceptions" � �������� "Language Exceptions"
}

 Type TMas=array[1..1] of integer; //��������� ��� ������������� �������
 var
   Form1: TForm1;
   A,B:^TMas;     //������� ���������� ���� "���������", ����������
                  //����� ������� ����� ������ ����������� �������� ���� TMas
   N,M,i,j:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  N:=5; Edit1.Text:=inttostr(N); //������ ������� � ������� �������
  M:=5; Edit2.Text:=inttostr(M); //�� ��������� � ������ ��������� ����� 5
  StringGrid1.ColCount:=N+1;     //������ ���-�� �������� ������� ��� �������
  StringGrid2.ColCount:=M+1;     //� ������� �������
  StringGrid1.Cells[0,0]:='  A'; //�������� �������
  StringGrid2.Cells[0,0]:='  B';
{� ������ ������� ���������� ��� ������ ������ ��� ��������: ��� ��������
������� ������� ��������� � �� ������ ���������� ������� ������� � �������
������, ��� � � ������� �������}
  edit3.Text:='';   //������� ���� ������
end;

procedure TForm1.Button1Click(Sender: TObject);
begin   //������ ��������� ������� ������� �������
//��� ��������� ��� ���� ����� ��� � ��� �������� �����, �� ������ ���
//������� �������
  N:=StrToInt(Edit1.Text);
  StringGrid1.ColCount:=N+1;
  StringGrid1.Cells[0,0]:='  A';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin   //������ ��������� ������� ������� �������
  M:=StrToInt(Edit2.Text);
  StringGrid2.ColCount:=M+1;
  StringGrid2.Cells[0,0]:='  B';
end;

procedure TForm1.Button3Click(Sender: TObject);
 var k,ex,min:integer;
begin
//�������� ������ ��� ������ ������� ������� ����� ������
//� ��������� GetMem ���������� ������� ����� ������ � ������, ������� ��
//���������� ������� SizeOf ��� ����������� ���-�� ���� ����������� ��� ��� ����
//����� ������ � ������
 GetMem(a,n*sizeof(integer));
//���������� ��� ������� �������:
 GetMem(b,m*sizeof(integer));
//������ ������ �� ������� � ������
//(������� ��������� � �� ���������� ������� � ������):
 for i:=1 to N do
  A^[i]:=StrToInt(StringGrid1.Cells[i,0]);
 for i:=1 to M do
  B^[i]:=StrToInt(StringGrid2.Cells[i,0]);

//���������� ex (�� ����. exist-����������) �������� "0" ���� �����������
//�������� ���� �� ���������� ��� "1", ���� ��� ��� ���� ��� �������.
 ex:=0;
 for i:=1 to n do  //������ ����� �������� ��������� ������� �������
  begin
//������ ������� ������� ������� ���������� � ������ ��������� ������� �������
//����������� ���������� k �������� "1", ���� ������� ������� �������
//����������� �� ������ �������
   k:=0;
   for j:=1 to m do
    if a[i]=b[j] then k:=1;
//���� ���������� ��� ������� �������� ������� ������� �� ������� � �����������
//�������� ��� �� ���� ������, ������ �������� � �������� ���������� ex
   if (k=0) and (ex=0) then
    begin
     min:=a[i];
     ex:=1;
    end;
//���� ����������� �������� ��� ���� ������� ������, �� ������� �������, ������
//����� �������� � �������� �� �������, �� ���������� ����������� ��������
   if (k=0) and (ex=1) and (a[i]<min) then min:=a[i];
  end;             //����� ����� �������� ��������� ������� �������

//����� ����������:
 if ex=0 then Edit3.Text:='�� �������'
  else Edit3.Text:=inttostr(min);

//������������ ������, ���������� ������������ ��������
 freemem(a,n*sizeof(integer));
 freemem(b,m*sizeof(integer));
end;

procedure TForm1.Button4Click(Sender: TObject);
begin  //������-�������, ����������� ������� ������� ������� ���������� ������
//������� � ��������� �� 0 �� 99
 randomize;  //��������� ������������� ������� ������� ���������� ����� (random)
 for i:=1 to n do
   stringgrid1.Cells[i,0]:=inttostr(random(100));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin  //������-�������, ����������� ������� ������� �������
 randomize;
 for i:=1 to m do
   stringgrid2.Cells[i,0]:=inttostr(random(100));
end;
{��������� �� ������ ��������� ����������� ����� �����������, ��������
������ 712502. ����� ������������ ���� ���� ������� ��������� � ����� ���������
��� ������ ��������������� ����� �������������� � �������� ��� ������.
����� �� ������ �������� ����� ���� �������� ������� ���� � ������� ����������
�������� ��������������� � �� ��������� ��������������}
end.
{P.S. ����� � ����� ��? ������
���� ����� �������, �����������, ������� �� ��������� ������ ��������� ��������
����� +375297761673}
