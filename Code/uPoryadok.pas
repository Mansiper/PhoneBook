unit uPoryadok;

interface

uses
  Forms, StdCtrls, Controls, Classes, Buttons, SysUtils, ComCtrls, Windows,
  Dialogs;

type
  TfPoryadok = class(TForm)
    sbVverh: TSpeedButton;
    sbVniz: TSpeedButton;
    ListBox1: TListBox;
    bOtmena: TButton;
    bGotovo: TButton;
    bA_Ya: TButton;
    bYa_A: TButton;
    lZapis: TLabel;
    pb1: TProgressBar;
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sbVverhClick(Sender: TObject);
    procedure sbVnizClick(Sender: TObject);
    procedure bA_YaClick(Sender: TObject);
    procedure bGotovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bOtmenaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;
  TPerest = record
    Nom: Cardinal;
    Vverh: Boolean; //True - вверх, False - вниз
  end;

const
  WM_PB = $0400+2;

var
  fPoryadok: TfPoryadok;
  OldIdx: Integer =-1;
  Perest: Array of TPerest;

implementation

uses uTelefon, uRList, uDopFun, uSohranenie;

{$R *.dfm}

//==============================================================================

procedure TfPoryadok.FormCreate(Sender: TObject);
begin
  If FileEst then
  Begin
    Color:=fProchCv;
    ListBox1.Color:=fPrListCv;
    ListBox1.Font:=PorShr;
    lZapis.Font:=PorShr;
    PorShr.Free;
  End;
  PostMessage(pb1.Handle, $0409, 0, ListBox1.Color);
end;

procedure TfPoryadok.FormShow(Sender: TObject);
var
  N: Byte;
begin
  Top:=fGlav.Height DIV 2 - Height DIV 2 + fGlav.Top;
  Left:=fGlav.Width DIV 2 - Width DIV 2 + fGlav.Left;
  If Top>Screen.Height-Height then Top:=Screen.Height-Height;
  If Left>Screen.Width-Width then Left:=Screen.Width-Width;
  If Top<0 then Top:=0;
  If Left<0 then Left:=0;

  SetLength(Perest, 0);
  bA_Ya.Tag:=0;
  bYa_A.Tag:=0;

  bOtmena.Click;
  ListBox1.SetFocus;
  If Spisok.Count=0 then
    lZapis.Caption:='Нет записей'
  Else
  Begin
    (* 11-14 записей - исключение *)
    N:=Spisok.Count MOD 10;
    if (N>0) and (N<5) then
      if ( Spisok.Count-(N+10) ) MOD 100 = 0 then
      begin
        lZapis.Caption:=IntToStr(Spisok.Count)+' записей';
        Exit;
      end;

    case N of
      1:        lZapis.Caption:=IntToStr(Spisok.Count)+' запись';
      2..4:     lZapis.Caption:=IntToStr(Spisok.Count)+' записи';
      5..9, 0:  lZapis.Caption:=IntToStr(Spisok.Count)+' записей';
    end;
  End;
end;

//==============================================================================

procedure TfPoryadok.ListBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Idx: Longint;
begin
  With Sender as TListBox do
  Begin
    Idx:=ItemAtPos(Point(x, y), True);
    if (Idx<0) or (Idx=OldIdx) then Exit;
    Application.ProcessMessages;
    Application.CancelHint;
    OldIdx:=Idx;
    Hint:='';
    if Canvas.TextWidth(Items[Idx])>((Sender as TListBox).Width-4) then
      Hint:=Items[Idx];
  End;
end;

//==============================================================================

procedure TfPoryadok.sbVverhClick(Sender: TObject);
var
  len: Cardinal;
  i: Integer;
begin
  i:=ListBox1.ItemIndex;
  If ListBox1.ItemIndex>0 then
  Begin
    ListBox1.Items.Move(ListBox1.ItemIndex, ListBox1.ItemIndex-1);
    ListBox1.ItemIndex:=i-1;

    len:=Length(Perest);
    SetLength(Perest, len+1);
    Perest[len].Nom:=i;
    Perest[len].Vverh:=True;
  End;
  ListBox1.SetFocus;
end;

procedure TfPoryadok.sbVnizClick(Sender: TObject);
var
  len: Cardinal;
  i: Integer;
begin
  i:=ListBox1.ItemIndex;
  If (ListBox1.ItemIndex<ListBox1.Count-1)and(ListBox1.ItemIndex<>-1) then
  Begin
    ListBox1.Items.Move(ListBox1.ItemIndex, ListBox1.ItemIndex+1);
    ListBox1.ItemIndex:=i+1;

    len:=Length(Perest);
    SetLength(Perest, len+1);
    Perest[len].Nom:=i;
    Perest[len].Vverh:=False;
  End;
  ListBox1.SetFocus;
end;

//==============================================================================

procedure TfPoryadok.bA_YaClick(Sender: TObject);
var
  A_Ya: Boolean;    //True - сортировать по алфавиту, False - против
  Dobro: Boolean;   //Значение записано ("перестановка совершена")
  c1, c2: Char;
  i, j, k: Word;
  Tek: PRListEl;    //Текущий (рабочий) элемент гланого списка
begin
  If Spisok.Count<2 then
  Begin
    ListBox1.SetFocus;
    Exit;
  End;

  If TControl(Sender).Name='bA_Ya' then
    A_Ya:=True
  Else A_Ya:=False;
  pb1.Show;
  bA_Ya.Tag:=0;

  sbVverh.Enabled:=False;
  sbVniz.Enabled:=False;
  bA_Ya.Enabled:=False;
  bYa_A.Enabled:=False;
  bGotovo.Enabled:=False;

  Poisk.Clear;
  Poisk.Add^.Value:=Spisok.First^.Value;

  Tek:=Spisok.First^.Next;

  Dobro:=False;
  For i:=2 to Spisok.Count do       //Перебор записей
  Begin
    for j:=1 to i-1 do              //Перебор ранее просмотренных
    begin
      Dobro:=False;

      For k:=1 to                   //Перебор строк
      Max(Length(Spisok.Item[i]^.Value[0]), Length(Poisk.Item[j]^.Value[0])) do
      Begin
        c1:=Tek^.Value[0][k];             //Символ из строки текущей записи
        c2:=Poisk.Item[j]^.Value[0][k];   //Символ из строки ранней записи
        //Перевод символов в нижний регистр
        if ( (c1>='A') and (c1<='Z') ) OR
           ( (c1>='А') and (c1<='Я') and (c1<>'Ё') ) then Inc(c1, 32)
        else if c1='Ё' then Inc(c1, 16);
        if ( (c2>='A') and (c2<='Z') ) OR
           ( (c2>='А') and (c2<='Я') and (c2<>'Ё') ) then Inc(c2, 32)
        else if c2='Ё' then Inc(c2, 16);
        //Если c1<c2, то перемещаю текущую запись на место просматриваемой
        if ((c1<c2) and A_Ya) Or ((c1>c2) and not A_Ya) then
        begin
          Poisk.Insert(j)^.Value:=Tek^.Value;
          Dobro:=True;
          Break;
        end
        else if ((c1>c2) and A_Ya) Or ((c1<c2) and not A_Ya) then
          Break;
      End;//for //Перебор строк

      If Dobro then Break
    end;//for //Перебор ранее просмотренных

    If not Dobro then Poisk.Add^.Value:=Tek^.Value;
    Tek:=Tek^.Next;

    If i MOD 20 = 0 then
    Begin
      SendMessage(pb1.Handle, WM_PB, i * 81 DIV Spisok.Count, 0);
      Application.ProcessMessages;
      if bA_Ya.Tag<0 then
      begin
        pb1.Hide;
        ListBox1.SetFocus;
        SetLength(Perest, 0);
        sbVverh.Enabled:=True;
        sbVniz.Enabled:=True;
        bA_Ya.Enabled:=True;
        bYa_A.Enabled:=True;
        bGotovo.Enabled:=True;
        Exit;
      end;
    End;
  End;//for //Перебор записей

  pb1.Hide;
  ListBox1.SetFocus;
  sbVverh.Enabled:=True;
  sbVniz.Enabled:=True;
  bA_Ya.Enabled:=True;
  bYa_A.Enabled:=True;
  bGotovo.Enabled:=True;

  Zagruzka(fGlav.pN1.Tag);

  ListBox1.Clear;
  Tek:=Poisk.First;
  For i:=1 to Spisok.Count do
  Begin
    ListBox1.Items.Add(Tek^.Value[0]);
    Tek:=Tek^.Next;
  End;
  bA_Ya.Tag:=1;
  SetLength(Perest, 0);
end;

//==============================================================================

procedure TfPoryadok.bGotovoClick(Sender: TObject);
var
  i: Word;
  Ist, Kon: PRListEl;
begin
  If bA_Ya.Tag=1 then
  Begin
    Ist:=Poisk.First;
    Kon:=Spisok.First;
    for i:=1 to Spisok.Count do
    begin
      Kon^.Value:=Ist^.Value;
      Ist:=Ist^.Next;
      Kon:=Kon^.Next;
    end;
  End;

  If Length(Perest)>0 then
    for i:=0 to Length(Perest)-1 do
      if Perest[i].Vverh then
        Spisok.Change(Perest[i].Nom+1, Perest[i].Nom)
      else //if not Perest[i].Vverh then
        Spisok.Change(Perest[i].Nom+1, Perest[i].Nom+2);

  Zagruzka(1);
  Sohranenie.Resume;
  If Sohranenie.Oshibka then
    MsgDlg('Служебное сообщение', 'Не могу открыть файл!', mtError,
      [mbOK], ['&Ясно']);
end;

procedure TfPoryadok.bOtmenaClick(Sender: TObject);
var
  i: Word;
  Ptr: PRListEl;
begin
  bA_Ya.Tag:=-1;
  ListBox1.Clear;
  Ptr:=Spisok.First;
  For i:=1 to Spisok.Count do
  Begin
    ListBox1.Items.Add(Ptr^.Value[0]);
    Ptr:=Ptr^.Next;
  End;
end;

end.
