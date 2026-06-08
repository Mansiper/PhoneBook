unit uPoisk;

interface

uses
  Classes;

type
  TPoisk = class(TThread)
  public
    Gotovo: Boolean;  //True - поиск завершён
    Pusto: Boolean;   //True - записей не найдено
  protected
    procedure Execute; override;
  end;

var
  PtPoisk: TPoisk;

implementation

uses uDopFun, uTelefon, uRList;

procedure TPoisk.Execute;
var
  Cifry: Boolean;
  i, k, j: Word;
  Ptr, Nov: PRListEl;
  Str, Str2: String;
begin
  Gotovo:=False;
  Pusto:=False;
  Poisk.Clear;

  fGlav.bDob.Enabled:=False;
  fGlav.bPoryadok.Enabled:=False;

  {В Skype нет номера, там логин!!!}

  k:=0;
  If fGlav.cbPoisk.Text='Все поля' then               //========================
  Begin
    Ptr:=Spisok.First;
    Str:=LowCase(fGlav.ePoisk.Text);
    Str2:=Tel(fGlav.ePoisk.Text, False);
    if Str2='' then Cifry:=False
    else Cifry:=True;
    Str2:=Tel(fGlav.ePoisk.Text);

    for i:=1 to Spisok.Count do
    begin
      k:=0;
      for j:=0 to TAG_KOLVO-1 do
        if Pos(Str, LowCase(Ptr^.Value[j]))>0 then
        begin
          Nov:=Poisk.Add;
          Nov^.Value:=Ptr^.Value;
          Nov^.pValue:=Ptr;

          k:=1;
          Break;
        end;
      if Cifry and (k=0) and (
         (Pos(Str2, Tel(Ptr^.Value[1]))>0) or       //Домашний
         (Pos(Str2, Tel(Ptr^.Value[2]))>0) or       //Сотовый 1
         (Pos(Str2, Tel(Ptr^.Value[3]))>0) or       //Сотовый 2
         (Pos(Str2, Tel(Ptr^.Value[4]))>0) or       //Рабочий 1
         (Pos(Str2, Tel(Ptr^.Value[5]))>0) or       //Рабочий 2
         (Pos(Str2, Tel(Ptr^.Value[10]))>0) ) then  //ICQ
      begin
        Nov:=Poisk.Add;
        Nov^.Value:=Ptr^.Value;
        Nov^.pValue:=Ptr;
      end;

      Ptr:=Ptr^.Next;
    end;
  End
                                                      //========================
  Else if (fGlav.cbPoisk.Text='Имя') or
          (fGlav.cbPoisk.Text='Номер/ник ВКонтакте') or
          (fGlav.cbPoisk.Text='Ник в Skype') or
          (fGlav.cbPoisk.Text='Страница в инете') or
          (fGlav.cbPoisk.Text='Адрес проживания') or
          (fGlav.cbPoisk.Text='Адрес работы') or
          (fGlav.cbPoisk.Text='Компания') or
          (fGlav.cbPoisk.Text='Должность') or
          (fGlav.cbPoisk.Text='День рождения') or
          (fGlav.cbPoisk.Text='Дополнительная инфа') then
  Begin
    Ptr:=Spisok.First;
         if fGlav.cbPoisk.Text='Имя'                      then k:=0
    else if fGlav.cbPoisk.Text='Номер/ник ВКонтакте'      then k:=9
    else if fGlav.cbPoisk.Text='Ник в Skype'              then k:=11
    else if fGlav.cbPoisk.Text='Страница в инете'         then k:=12
    else if fGlav.cbPoisk.Text='Адрес проживания'         then k:=13
    else if fGlav.cbPoisk.Text='Адрес работы'             then k:=14
    else if fGlav.cbPoisk.Text='Компания'                 then k:=15
    else if fGlav.cbPoisk.Text='Должность'                then k:=16
    else if fGlav.cbPoisk.Text='День рождения'            then k:=17
    else if fGlav.cbPoisk.Text='Дополнительная инфа'      then k:=18;

    for i:=1 to Spisok.Count do
    begin
      if Pos(LowCase(fGlav.ePoisk.Text), LowCase(Ptr^.Value[k]))>0 then
      begin
        Nov:=Poisk.Add;
        Nov^.Value:=Ptr^.Value;
        Nov^.pValue:=Ptr;
      end;

      Ptr:=Ptr^.Next;
    end;
  End
  Else if fGlav.cbPoisk.Text='Телефоны' then          //========================
  Begin
    Ptr:=Spisok.First;
    Str:=Tel(fGlav.ePoisk.Text);
    for i:=1 to Spisok.Count do
    begin
      if (Pos(Str, Tel(Ptr^.Value[1]))>0) or (Pos(Str, Tel(Ptr^.Value[2]))>0) or
         (Pos(Str, Tel(Ptr^.Value[3]))>0) or (Pos(Str, Tel(Ptr^.Value[4]))>0) or
         (Pos(Str, Tel(Ptr^.Value[5]))>0) then
      begin
        Nov:=Poisk.Add;
        Nov^.Value:=Ptr^.Value;
        Nov^.pValue:=Ptr;
      end;

      Ptr:=Ptr^.Next;
    end;
  End
  Else if fGlav.cbPoisk.Text='Электронная почта' then //========================
  Begin
    Ptr:=Spisok.First;
    Str:=LowCase(fGlav.ePoisk.Text);
    for i:=1 to Spisok.Count do
    begin
      if (Pos(Str, LowCase(Ptr^.Value[6]))>0) or
         (Pos(Str, LowCase(Ptr^.Value[7]))>0) or
         (Pos(Str, LowCase(Ptr^.Value[8]))>0) then
      begin
        Nov:=Poisk.Add;
        Nov^.Value:=Ptr^.Value;
        Nov^.pValue:=Ptr;
      end;

      Ptr:=Ptr^.Next;
    end;
  End                                               //==========================
  Else if fGlav.cbPoisk.Text='Номер ICQ' {10} then
  Begin
    Ptr:=Spisok.First;
    Str:=Tel(fGlav.ePoisk.Text);

    if fGlav.cbPoisk.Text='Номер ICQ' then k:=10;

    for i:=1 to Spisok.Count do
    begin
      if Pos(Str, Tel(Ptr^.Value[k]))>0 then
      begin
        Nov:=Poisk.Add;
        Nov^.Value:=Ptr^.Value;
        Nov^.pValue:=Ptr;
      end;

      Ptr:=Ptr^.Next;
    end;
  End;

  //-----------------------------------

  BylPoisk:=True;
  If Poisk.Count>0 then
    Zagruzka(1)
  Else
    Pusto:=True;

  Gotovo:=True;
end;

end.
