unit uDopFun;

interface

uses uRazGestures, Dialogs, Forms, StdCtrls, SysUtils, uTelefon, Windows,
  Graphics;

var
  //<nz> - новая запись
  ParsTag: Array [0..TAG_KOLVO] of String=('<nz>', '<fio>', '<dt>', '<st1>',
    '<st2>', '<rt1>', '<rt2>', '<em1>', '<em2>', '<em3>', '<vko>', '<icq>',
    '<sky>', '<url>', '<add>', '<adr>', '<kom>', '<dol>', '<dr>', '<din>');

procedure Parsing;              //Разбор файла
procedure Zagruzka(Poz: Cardinal);  //Заполнение полей
procedure Strelki;              //Enabled для перехода вперёд и назад
function MsgDlg(Verh, Tekst: String; Tip: TMsgDlgType; Knopki: TMsgDlgButtons;
  KnTekst: Array of String): Byte;
function LowCase(const S: String): String;
function Tel(const S: String; Chisla: Boolean=True): String;
function Max(const A, B: Integer): Integer;
  //1 - создать резервный файл, 2 - удалить, 3 - восстановить
function Rezerv(Delo: Byte=0): Boolean;

  //Обработчики горячих комбинаций
procedure Do_Klavisha(Param: Integer);
procedure Do_Ctrl_Klavisha(Param: Integer);
  //Обработчик жестов мыши
procedure Do_Zhest_Gotov(Knopka: TMsButton; Str: String);

implementation

uses uRList, uNastroiki, uGorKlav;

//==============================================================================

procedure Parsing;
var
  Dobro: Boolean; //True - таг совпал
  i, k: Byte;     //Счётчик
  Tek: SmallInt;  //Текущий "рабочий" таг
  c, lc: Char;    //Прочитаный символ и он же в нижнем регистре
  Buf: String;    //Буфер для получения тага
  Str: String;    //Готовая строка
begin
(*  <nz><fio><dt><st1><st2><rt1><rt2><em1><em2><em3><vko><icq><sky><url><add>
    <adr><kom><dol><dr><din>  *)

  i:=0;
  Tek:=-1;
  Buf:='';
  Str:='';
  While not eof(Fail) do
  Begin
    Read(Fail, c);

    //Перевод в нижний регистр
    lc:=c;
    if c in ['A'..'Z'] then Inc(lc, 32)
    //TAB, Enter, перевод каретки и доп. инфа
    else if (c in [#9, #13, #10]) and (i<>TAG_KOLVO) then
      Continue;

    if (Buf='') and (c='<') then
      Buf:=c
    else if (Buf='') and (c<>'<') then
      Str:=Str+c
    else if Buf<>'' then
    begin
      if lc in ['a'..'z', '0'..'9'] then
        Buf:=Buf+lc
      else if c='>' then
      begin
        Buf:=Buf+c;
        Dobro:=False;
        for i:=0 to TAG_KOLVO do    //Поиск тага
          if Buf=ParsTag[i] then
          begin
            Dobro:=True;
            Break;
          end;
        if Dobro then
        begin
          if Buf=ParsTag[0] then    //Новая запись
          begin
            if Tek>0 then
            begin
              while True do
              begin
                k:=Length(Str);
                if Str[k] in [#13, #10] then
                  Delete(Str, k, 1)
                else Break;
              end;
              Spisok.Last^.Value[Tek-1]:=Str;
            end;
            Spisok.Add;
            SetLength(Spisok.Last^.Value, TAG_KOLVO);
          end
          else if Tek>=0 then       //Новое значение
          begin
            if Tek>0 then
            begin
              while True do
              begin
                k:=Length(Str);
                if Str[k] in [#13, #10] then
                  Delete(Str, k, 1)
                else Break;
              end;
              Spisok.Last^.Value[Tek-1]:=Str;
            end;
            Str:='';
          end;
          Buf:='';
          if (Tek>=0) or (i=0) then
            Tek:=i;
        end
        else if Tek>=0 then
        begin
          Str:=Str+Buf;
          Buf:='';
        end
        else
          Buf:='';
      end;
    end;
  End;//While not eof(Fail) do
  If (Str<>'') and (Tek<>0) then
    Spisok.Last^.Value[Tek-1]:=Str;
end;

//==============================================================================

function MsgDlg(Verh, Tekst: String; Tip: TMsgDlgType; Knopki: TMsgDlgButtons;
  KnTekst: Array of String): Byte;
const
  crHandPoint	= -21;
var
  i, k: Byte;
  MD: TForm;
begin
  MD:=CreateMessageDialog(Tekst, Tip, Knopki);
  MD.Caption:=Verh;
  Try   //На случай, если было восстановление из резерва
    MD.Color:=fNastroiki.Color;
  Except
  End;

  MD.Top:=fGlav.Height DIV 2 - MD.Height DIV 2 + fGlav.Top;
  MD.Left:=fGlav.Width DIV 2 - MD.Width DIV 2 + fGlav.Left;
  If MD.Top>Screen.Height-MD.Height then MD.Top:=Screen.Height-MD.Height;
  If MD.Left>Screen.Width-MD.Width then MD.Left:=Screen.Width-MD.Width;
  If MD.Top<0 then MD.Top:=0;
  If MD.Left<0 then MD.Left:=0;

  k:=0;
  For i:=0 to MD.ControlCount-1 do
  Begin
    if MD.Controls[i] is TButton then
    begin
      (MD.Controls[i] as TButton).Cursor:=crHandPoint;
      (MD.Controls[i] as TButton).Caption:=KnTekst[k];
      Inc(k);
    end;
  End;//For

  MD.ShowModal;
  Result:=MD.ModalResult;
end;

//==============================================================================

procedure Zagruzka(Poz: Cardinal);
var
  i: Word;
  Ptr: PRListEl;
begin
(*  <nz><fio><dt><st1><st2><rt1><rt2><em1><em2><em3><vko><icq><sky><url><add>
    <adr><kom><dol><dr><din>  *)

  If not BylPoisk then
  Begin
    if Spisok.Count=0 then
    begin
      //очистка полей
      For i:=0 to fGlav.ComponentCount-1 do
        if fGlav.Components[i] is TEdit then
          if fGlav.Components[i].Tag=0 then
            (fGlav.Components[i] as TEdit).Clear;
      fGlav.mDopInfa.Clear;
      fGlav.pN1.Tag:=0;
      Strelki;
      Exit;
    end;
    Ptr:=Spisok.Item[Poz];
  End
  Else //if BylPoisk then       //Для списка найденных
    Ptr:=Poisk.Item[Poz];

  With fGlav do
  Begin
    eFIO.Text:=       Ptr^.Value[0];
    eDomTel.Text:=    Ptr^.Value[1];
    eSotTel1.Text:=   Ptr^.Value[2];
    eSotTel2.Text:=   Ptr^.Value[3];
    eRabTel1.Text:=   Ptr^.Value[4];
    eRabTel2.Text:=   Ptr^.Value[5];
    eMail1.Text:=     Ptr^.Value[6];
    eMail2.Text:=     Ptr^.Value[7];
    eMail3.Text:=     Ptr^.Value[8];
    eVKont.Text:=     Ptr^.Value[9];
    eICQ.Text:=       Ptr^.Value[10];
    eSkype.Text:=     Ptr^.Value[11];
    eStranica.Text:=  Ptr^.Value[12];
    eDomAdres.Text:=  Ptr^.Value[13];
    eRabAdres.Text:=  Ptr^.Value[14];
    eKompania.Text:=  Ptr^.Value[15];
    eDolzhn.Text:=    Ptr^.Value[16];
    eDenRozhd.Text:=  Ptr^.Value[17];
    mDopInfa.Text:=   Ptr^.Value[18];
    if not BylPoisk then
      pN1.Tag:=Poz
    else //if BylPoisk then
      ePoisk.Tag:=Poz;
  End;

  Strelki;
end;

//==============================================================================

procedure Strelki;
begin
  WITH fGlav DO
  BEGIN
    If not BylPoisk then
    Begin
      if pN1.Tag<=1 then
      begin
        bNazad.Enabled:=False;
        bNachalo.Enabled:=False;
      end
      else
      begin
        bNazad.Enabled:=True;
        bNachalo.Enabled:=True;
      end;
      if (pN1.Tag=Spisok.Count) or (pN1.Tag=-1) then
      begin
        bVpered.Enabled:=False;
        bKonec.Enabled:=False;
      end
      else
      begin
        bVpered.Enabled:=True;
        bKonec.Enabled:=True;
      end;
      if Spisok.Count=0 then
      begin
        bIzm.Enabled:=False;
        bUdal.Enabled:=False;
      end
      else
      begin
        bIzm.Enabled:=True;
        bUdal.Enabled:=True;
      end;
    End
    Else //if BylPoisk then   //Для списка поиска
    Begin
      if ePoisk.Tag=1 then
      begin
        bNazad.Enabled:=False;
        bNachalo.Enabled:=False;
      end
      else
      begin
        bNazad.Enabled:=True;
        bNachalo.Enabled:=True;
      end;
      if ePoisk.Tag=Poisk.Count then
      begin
        bVpered.Enabled:=False;
        bKonec.Enabled:=False;
      end
      else
      begin
        bVpered.Enabled:=True;
        bKonec.Enabled:=True;
      end;
    End;
  END;//WITH fGlav DO
end;

//==============================================================================

function LowCase(const S: String): String;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L:=Length(S);
  SetLength(Result, L);
  Source:=Pointer(S);
  Dest:=Pointer(Result);
  While L<>0 do
  Begin
    Ch:=Source^;
    if ( (Ch>='A') and (Ch<='Z') ) OR
       ( (Ch>='А') and (Ch<='Я') and (Ch<>'Ё') ) then Inc(Ch, 32)
    else if Ch='Ё' then Inc(Ch, 16);
    Dest^:=Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  End;
end;

function Tel(const S: String; Chisla: Boolean=True): String;
var
  i, L: Integer;
begin
  L:=Length(S);

  Result:='';
  For i:=1 to L do
  Begin
    if S[i] in ['0'..'9'] then
      Result:=Result+S[i]
    else if (S[i] in ['a'..'z', 'A'..'Z', 'А'..'Я', 'а'..'я', 'ё', 'Ё']) and
      Chisla then
    Begin
      Result:='';
      Exit;
    End;
  End;
end;

function Max(const A, B: Integer): Integer;
begin
  If A>B then Result:=A
  Else Result:=B;
end;

function Rezerv(Delo: Byte=0): Boolean;
var
  RazO, RazR: Integer;  //Размеры основного и резервного файлов
  F: File of Byte;
begin
  Result:=False;
  If Delo=0 then                                              //Создать
  Begin
      //Переименовываю существующий
    if RenameFile(Papka+'tas.dat', Papka+'tas~.dat') then
    begin
        //Если успешно, создаю новый
      AssignFile(F, Papka+'tas.dat');
      Rewrite(F);
      CloseFile(F);
      Result:=True;
    end;
  End//If Delo=0 then

  Else if Delo=1 then                                         //Удалить
  Begin
    DeleteFile(PChar(Papka+'tas~.dat'));
    Result:=True;
  End//Else if Delo=1 then

  Else if Delo=2 then                                         //Восстановить
  Begin
      //Размер основного файла
    if FileExists(Papka+'tas.dat') then
    begin
      AssignFile(F, Papka+'tas.dat');
      Reset(F);
      RazO:=FileSize(F);
      CloseFile(F);
    end
    else RazO:=0;
      //Размер резервного файла
    if FileExists(Papka+'tas~.dat') then
    begin
      AssignFile(F, Papka+'tas~.dat');
      Reset(F);
      RazR:=FileSize(F);
      CloseFile(F);
    end
    else RazR:=0;

      //Если размер резервного > основного, то удаляю основной и переименовываю резерв
    if RazR>RazO then
    begin
      DeleteFile(PChar(Papka+'tas.dat'));
      RenameFile(Papka+'tas~.dat', Papka+'tas.dat');
      Result:=True;
    end
      //Иначе резервный файл не нужен
    else //if RazR<=RazO then
    begin
      DeleteFile(PChar(Papka+'tas~.dat'));
    end;
  End//Else if Delo=2 then

  Else if Delo=3 then                           //Принудительное восстановление
  Begin
    DeleteFile(PChar(Papka+'tas.dat'));
    RenameFile(Papka+'tas~.dat', Papka+'tas.dat');
    Result:=True;
  End;//Else if Delo=3 then
end;

//_______________________Функции_обработки_событий______________________________
//==============================================================================

procedure Do_Klavisha(Param: Integer);
begin
  //Ctrl, Shift и Alt не нажаты

    //Param указывает на номер клавиши в таблице символов
  With fGlav do
  Begin
    if Active then
      case Param of
        VK_F1:
          fGorKlav.ShowModal;
        VK_ESCAPE:
          if bOtmena.Visible then bOtmena.Click
          else if ePoisk.Focused then ePoisk.Clear;
        Ord('Z'), Ord('Я'), VK_PRIOR:
          if bNazad.Enabled and not ePoisk.Focused then bNazad.Click;
        Ord('X'), Ord('Ч'), VK_NEXT:
          if bVpered.Enabled and not ePoisk.Focused then bVpered.Click;
      end;//case
  End;//With fGlav do
end;

procedure Do_Ctrl_Klavisha(Param: Integer);
begin
  //Ctrl нажата, Shift и Alt не нажаты

  With fGlav do
  Begin
    if Active then
      case Param of
        Ord('1'): pRaz2Click(pRaz2);
        Ord('2'): pRaz2Click(pRaz3);
        Ord('3'): pRaz2Click(pRaz4);
        Ord('Q'), Ord('Й'):
          if bDob.Enabled and bDob.Visible then bDob.Click;
        Ord('W'), Ord('Ц'):
          if bIzm.Enabled and bIzm.Visible then bIzm.Click;
        Ord('E'), Ord('У'):
          if bUdal.Enabled and bUdal.Visible then bUdal.Click;
        Ord('S'), Ord('Ы'):
          if bSohr.Enabled and bSohr.Visible then bSohr.Click;
        Ord('F'), Ord('А'):
          if bOtmena.Enabled and bOtmena.Visible then bOtmena.Click;
        Ord('I'), Ord('Ш'):
          if not ePoisk.Focused and ePoisk.Enabled then ePoisk.SetFocus;
        Ord('O'), Ord('Щ'):
          if bPoryadok.Enabled then bPoryadok.Click;
        Ord('P'), Ord('З'):
          if bNastroiki.Enabled then bNastroiki.Click;
        Ord('T'), Ord('Е'):
          begin
            if not VysheVseh then
            begin
              VysheVseh:=SetWindowPos(Handle, HWND_TOPMOST,
              Left, Top, Width, Height, SWP_NOSENDCHANGING);
            end
            else //if VysheVseh then
            begin
              VysheVseh:=not SetWindowPos(Handle, HWND_NOTOPMOST,
              Left, Top, Width, Height, SWP_NOSENDCHANGING);
            end;
            Btn4Click(VysheVseh);
          end;
      end;//case
  End;//With fGlav do
end;

procedure Do_Zhest_Gotov(Knopka: TMsButton; Str: String);
var
  i: Word;
begin
  //Обработка жестов мыши

  If Knopka=mbRight then
  Begin
    if fGlav.Active then
    begin
      With fGlav do
      Begin

        if Str='3214' then
          Close
        else if Str='2' then
        begin
          if bVpered.Enabled then bVpered.Click;
        end
        else if Str='4' then
        begin
          if bNazad.Enabled then bNazad.Click;
        end
        else if Str='232' then
        begin
          if bKonec.Enabled then bKonec.Click;
        end
        else if Str='434' then
        begin
          if bNachalo.Enabled then bNachalo.Click;
        end
        else if Str='13' then
        begin
          if not ePoisk.Focused and ePoisk.Enabled then ePoisk.SetFocus
          {else if ePoisk.Focused and bPoisk.Enabled then bPoisk.Click};
        end
        else if Str='131' then
        begin
          if bOchistit.Enabled then bOchistit.Click;
        end
        else if Str='123' then
        begin
          if bPoryadok.Enabled then bPoryadok.Click;
        end
        else if Str='3' then
        begin
          if pN2.Height<=17 then
            pRaz2Click(pRaz2);
          if pN3.Height<=17 then
            pRaz2Click(pRaz3);
          if pN4.Height<=17 then
            pRaz2Click(pRaz4);
        end
        else if Str='1' then
        begin
          if pN2.Height>17 then
            pRaz2Click(pRaz2);
          if pN3.Height>17 then
            pRaz2Click(pRaz3);
          if pN4.Height>17 then
            pRaz2Click(pRaz4);
        end;

      End;//With fGlav do
    end//if fGlav.Active then

    else if fNastroiki.Active and
    (fNastroiki.PageControl1.ActivePageIndex=1) then
    begin
      With fNastroiki do
      Begin

        if Str='3214' then
          Kartinka.Picture:=fGorKlav.iVyhod.Picture
        else if Str='2' then
          Kartinka.Picture:=fGorKlav.iVpered.Picture
        else if Str='4' then
          Kartinka.Picture:=fGorKlav.iNazad.Picture
        else if Str='232' then
          Kartinka.Picture:=fGorKlav.iKonec.Picture
        else if Str='434' then
          Kartinka.Picture:=fGorKlav.iNachalo.Picture
        else if Str='13' then
          Kartinka.Picture:=fGorKlav.iPoisk.Picture
        else if Str='131' then
          Kartinka.Picture:=fGorKlav.iOchistit.Picture
        else if Str='123' then
          Kartinka.Picture:=fGorKlav.iPoryadok.Picture
        else if Str='3' then
          Kartinka.Picture:=fGorKlav.iBlokiOtkr.Picture
        else if Str='1' then
          Kartinka.Picture:=fGorKlav.iBlokiZakr.Picture
        else
          with Kartinka.Picture.Bitmap.Canvas DO
          begin
            Brush.Color:=lCv1.Color;
            Brush.Style:=bsSolid;
            Rectangle(0, 0, Width, Height);
          end;

      End;//With fNastroiki do
    end;//else if fNastroiki.Active and ...
  End;//If FKnopka=2 then
end;

end.
