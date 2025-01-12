unit Unit2;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls;

Type
  TInfo = record
    kol:string[20];
    nazv:string[20];
    Nc:string[20];
  end;

  TMas = array[1..1] of TInfo;
  PMas = ^TMas;

  TSaS = class (TObject)
    LInf,SInf:file of TInfo;
    TInf:textfile;
    bd,a:PMas;
    FileNameS,FileNameL:string;

    procedure PCreate(SD: TSaveDialog);
    procedure POpen(OD: TOpenDialog; M1: TMemo);
    procedure PSave(SD, SD2: TSaveDialog);
    procedure PAdd(E1,E2,E3:TEdit;M1:TMemo);
    procedure PLineSearch(E4:TEdit;M1:TMemo);
    procedure PPrChoice(M1:TMemo);
    procedure PQuickSort(M1:TMemo);
    procedure PDSearch(E4:TEdit;M1:TMemo);
    procedure PRead1(var c:TInfo);

  end;

  var
    num: word;
    k: string[20];

implementation

procedure TSaS.PCreate;
  begin
    if SD.Execute then
      begin
        FileNameL:=SD.FileName;
        AssignFile(LInf,FileNameL);
        Rewrite(LInf);
     end;
     num:=0;
  end;





procedure TSaS.POpen;
var
  i:byte;
begin
    if OD.Execute then
   begin
    FileNameL:=OD.FileName;
    AssignFile(LInf,FileNameL);
    Reset(LInf);
    num:=0;
    while not eof(LInf) do
      begin
        Inc(num);
        Seek(LInf,num);
      end;
    GetMem(bd,num*sizeof(TInfo));
    i:=1;
    Seek(LInf,0);
    while not eof(LInf) do
      begin
        Read(LInf,bd[i]);
        with bd[i] do
          M1.Lines.Add(IntToStr(i)+') ��� �'+Nc+', ��������: '+nazv+', ����������: '+kol);
        Inc(i);
      end;
   end;
end;




procedure TSaS.PSave;
var
  i:word;
begin
  if SD.Execute then
    begin
      FileNameS:=SD.FileName;
      AssignFile(SInf,FileNameS);
      Rewrite(SInf);
      for i:=1 to num do
      write(SInf,bd[i]);
      CloseFile(SInf);
    end;
   if SD2.Execute then
     begin
         FileNameS:=SD2.FileName;
         AssignFile(TInf,FileNameS);
         Rewrite(TInf);
         for i:=1 to num do
          with bd[i] do writeln(TInf,i:4,'.',' ��� �: ',Nc,', ����������: ',kol,', ��������: ',nazv);
         CloseFile(TInf);
     end;
end;

procedure TSaS.PAdd;
var i:byte;
begin
  GetMem(a,sizeof(TInfo)*(num+1));
  if num=0 then
    begin
      GetMem(bd,sizeof(TInfo)*(num+1));
      with bd[1] do
        begin
          kol:=E1.Text;
          nazv:=E2.Text;
          Nc:=E3.Text;
          M1.Lines.Add('�'+IntToStr(num+1)+', ��� �: '+Nc+', ����������: '+kol+', ��������: '+nazv);
        end;
      num:=num+1;
    end
  else
    begin
      for i:=1 to num do
      a[i]:=bd[i];
      FreeMem(bd,num*sizeof(TInfo));
      num:=num+1;
      with a[num] do
        begin
          kol:=E1.Text;
          nazv:=E2.Text;
          Nc:=E3.Text;
          M1.Lines.Add('�'+IntToStr(num)+', ��� �: '+Nc+', ����������: '+kol+', ��������: '+nazv);
        end;
      GetMem(bd,num*sizeof(TInfo));
      for i:=1 to num do
        bd[i]:=a[i];
      FreeMem(a,num*sizeof(TInfo));
    end;
end;

procedure TSaS.PLineSearch;
  var
    i:byte;
  begin
    M1.Clear;
    k:=E4.Text;
    for i:=1 to num do
      if bd[i].nc = k then
        with bd[i] do
         M1.Lines.Add('��� �: '+Nc+', ����������: '+kol+', ��������: '+nazv);
  end;

Procedure TSaS.PPrChoice;
  var
    i,j,m:byte;
    r:TInfo;
  begin
    M1.Clear;
    for i:=1 to num do
      begin
        m:=i;
        for j:=i+1 to num do
          if bd[j].kol > bd[m].kol then
            m:=j;
        r:=bd[m];
        bd[m]:=bd[i];
        bd[i]:=r;
        with bd[i] do
          M1.Lines.Add('��� �: '+Nc+', ����������: '+kol+', ��������: '+nazv);
      end;
  end;

procedure TSaS.PQuickSort;
  var
    i,j,m:byte;
    x: string [20];
    r: TInfo;
  begin
    M1.Clear;
    if Odd(num) then  m:=num div 2 + 1
                else  m:=num div 2;
    i:=1;
    j:=num;
    x:=bd[m].kol;
    repeat
      while bd[i].kol {<}> x do
        i:=i+1;
      while x {<}> bd[j].kol do
        j:=j-1;
      if i<=j then
        begin
          r:=bd[i];
          bd[i]:=bd[j];
          bd[j]:=r;
          i:=i+1;
          j:=j-1;
        end;
    until i>j;
    for i:=1 to num do
            with bd[i] do
          M1.Lines.Add('��� �: '+Nc+', ����������: '+kol+', ��������: '+nazv);
  end;

procedure TSaS.PDSearch;
  function Del(L,R:word;y:string):word;
    var m:word;
    begin
      if R<=L then Del:=R
      else begin
            m:=(L+R) div 2;
            if bd[m].nc < y then Del:=Del(m+1,R,y)
                                else Del:=Del(L,m,y);
           end;
    end;
  var
    i,j:word;
    x:string[20];
  begin
    x:=E4.Text;
    j:=0;
   while j<=num do
    begin
      i:=Del(j,num,x);
      j:=i+1;
      if bd[i].nc = x then
        with bd[i] do
            M1.Lines.Add('��� �: '+Nc+', ����������: '+kol+', ��������: '+nazv);
    end;
  end;

Procedure TSaS.PRead1;
  var i:word;
      mt:integer;
  begin
    mt:=sizeof(TInfo);
    if num > 0 then
      begin
        c:=bd[1];
        num:=num-1;
        if num > 0 then
          begin
            GetMem(a,num*mt);
            for i:=1 to num do
              a[i]:=bd[i+1];
          end
        else a:=nil;
        FreeMem(bd,mt*(num+1));
        bd:=a;
      end;
   end;
end.

