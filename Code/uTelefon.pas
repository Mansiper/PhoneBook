unit uTelefon;

(*
  pN1.Tag - номер просматриваемого элемента
  ePoisk.Tag - номер просматриваемого элемента среди найденных
*)

interface

uses
  Forms, StdCtrls, Controls, Classes, ExtCtrls, Buttons, Windows, SysUtils,
  Dialogs, IniFiles, Graphics, uRList, uRazGestures, uNForm;

type
  TfGlav = class(TNForm)
    bNazad: TButton;
    bVpered: TButton;
    bDob: TButton;
    bIzm: TButton;
    bUdal: TButton;
    bSohr: TButton;
    bOtmena: TButton;
    bPoryadok: TButton;
    bNastroiki: TButton;
    cbPoisk: TComboBox;
    ePoisk: TEdit;
    pN1: TPanel;
    pN2: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    eMail1: TEdit;
    eStranica: TEdit;
    eVKont: TEdit;
    eMail2: TEdit;
    eMail3: TEdit;
    pRaz2: TPanel;
    eICQ: TEdit;
    eSkype: TEdit;
    Label1: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    eFIO: TEdit;
    eDomTel: TEdit;
    eSotTel1: TEdit;
    eSotTel2: TEdit;
    eRabTel1: TEdit;
    eRabTel2: TEdit;
    pN3: TPanel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    pRaz3: TPanel;
    eDomAdres: TEdit;
    eRabAdres: TEdit;
    eKompania: TEdit;
    eDolzhn: TEdit;
    pN4: TPanel;
    Label52: TLabel;
    Label53: TLabel;
    pRaz4: TPanel;
    eDenRozhd: TEdit;
    mDopInfa: TMemo;
    bKonec: TButton;
    bNachalo: TButton;
    lSpravka: TLabel;
    bOchistit: TButton;
    lPusto: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bNazadClick(Sender: TObject);
    procedure bVperedClick(Sender: TObject);
    procedure bDobClick(Sender: TObject);
    procedure bIzmClick(Sender: TObject);
    procedure bUdalClick(Sender: TObject);
    procedure bSohrClick(Sender: TObject);
    procedure bOtmenaClick(Sender: TObject);
    procedure bPoryadokClick(Sender: TObject);
    procedure bNastroikiClick(Sender: TObject);
    procedure pRaz2Click(Sender: TObject);
    procedure bNachaloClick(Sender: TObject);
    procedure bKonecClick(Sender: TObject);
    procedure lSpravkaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ePoiskChange(Sender: TObject);
    procedure cbPoiskChange(Sender: TObject);
    procedure bOchistitClick(Sender: TObject);
  end;

const
  TAG_KOLVO = 19;

var
  fGlav: TfGlav;
  FileEst: Boolean=False; //True - ini-файл существует
  Dobavlenie: Boolean;    //True - добавляем запись, False - изменяем (для сохранения)
  BylPoisk: Boolean;      //True - просмотр среди найденных, False - простой просмотр
  fProchCv: TColor;
  fPrListCv: TColor;
  PorShr: TFont;
  Fail: TextFile;         //Рабочий файл с данными
  Papka: String;          //Путь к папке с программой
  PosledTekst: String;    //Последний введённый в поиске текст
  Spisok: TRazDList;      //Список данных
  Poisk: TRazDList;       //Список для поиска
  Dinamo: TDINAMO;        //Алгоритм ДИНАМО - для жестов мыши
  Chuvst: TRazSensit;     //Чувствительность алгоритма ДИНАМО

implementation

uses uDopFun, uPoryadok, uNastroiki, uSohranenie, uGorKlav, uPoisk;

{$R *.dfm}

//_______________________________Форма__________________________________________
//==============================================================================

procedure TfGlav.FormCreate(Sender: TObject);
var
  i: Word;
  iFile: TIniFile;
  ZagShr, PoleShr, PolPoiskShr: TFont;
  PolDanCv, RazCv, PoleCv, PolPoiskCv: TColor;
begin
  (* Создание главной формы *)

  Dinamo:=TDINAMO.Create(True);
  Dinamo.On_Key:=Do_Klavisha;
  Dinamo.On_Ctrl_Key:=Do_Ctrl_Klavisha;
  Dinamo.On_Gesture:=Do_Zhest_Gotov;
  //Dinamo.MouseButton:=mbLeft;
  
  Spisok:=TRazDList.Create;
  Poisk:=TRazDList.Create;

  Tag:=-1;
  VysheVseh:=False;
  Papka:=ExtractFilePath(Application.ExeName);

    //Попытка восстановления данных из файла резерва
  If Rezerv(2) then
    MsgDlg('Служебное сообщение', 'Данные восстановлены из резервного файла',
      mtInformation, [mbOK], ['&Добро']);

  If not FileExists(Papka+'tas.dat') then
  Begin
    Try
      AssignFile(Fail, Papka+'tas.dat');
      Rewrite(Fail);
      Strelki;
    Except
      MsgDlg('Служебное сообщение', 'Не могу создать файл данных!', mtError,
        [mbOK], ['&Ясно']);
      Application.Terminate;
    End;
  End
  Else
  Begin
    Try
      AssignFile(Fail, Papka+'tas.dat');
      Reset(Fail);

      Parsing;
      Zagruzka(1);
    Except
      MsgDlg('Служебное сообщение', 'Не могу открыть файл данных!', mtError,
        [mbOK], ['&Ясно']);
      Application.Terminate;
    End;
  End;

  CloseFile(Fail);

    //Загрузка настроек из ini-файла
  FileEst:=False;
  If FileExists(Papka+'tas.ini') then
  Begin
    FileEst:=True;
    TRY

    iFile:=TIniFile.Create(Papka+'tas.ini');

    ZagShr:=TFont.Create;
    PoleShr:=TFont.Create;
    PolPoiskShr:=TFont.Create;
    PorShr:=TFont.Create;

    ZagShr.Color:=iFile.ReadInteger('Шрифт загол', 'Цвет', clNavy);
    ZagShr.Name:=iFile.ReadString('Шрифт загол', 'Название', 'Verdana');
    ZagShr.Size:=iFile.ReadInteger('Шрифт загол', 'Размер', 9);
    ZagShr.Style:=[];
    If iFile.ReadBool('Шрифт загол', 'Жирный', False) then
      ZagShr.Style:=[fsBold];
    If iFile.ReadBool('Шрифт загол', 'Наклонный', False) then
      ZagShr.Style:=ZagShr.Style+[fsItalic];
    If iFile.ReadBool('Шрифт загол', 'Подчёркнутый', False) then
      ZagShr.Style:=ZagShr.Style+[fsUnderline];
    If iFile.ReadBool('Шрифт загол', 'Зачёркнутый', False) then
      ZagShr.Style:=ZagShr.Style+[fsStrikeOut];

    PoleShr.Color:=iFile.ReadInteger('Шрифт поля', 'Цвет', clWindowText);
    PoleShr.Name:=iFile.ReadString('Шрифт поля', 'Название', 'Verdana');
    PoleShr.Size:=iFile.ReadInteger('Шрифт поля', 'Размер', 12);
    PoleShr.Style:=[];
    If iFile.ReadBool('Шрифт поля', 'Жирный', False) then
      PoleShr.Style:=[fsBold];
    If iFile.ReadBool('Шрифт поля', 'Наклонный', False) then
      PoleShr.Style:=PoleShr.Style+[fsItalic];
    If iFile.ReadBool('Шрифт поля', 'Подчёркнутый', False) then
      PoleShr.Style:=PoleShr.Style+[fsUnderline];
    If iFile.ReadBool('Шрифт поля', 'Зачёркнутый', False) then
      PoleShr.Style:=PoleShr.Style+[fsStrikeOut];

    PolPoiskShr.Color:=iFile.ReadInteger('Шрифт поиска', 'Цвет', clWindowText);
    PolPoiskShr.Name:=iFile.ReadString('Шрифт поиска', 'Название', 'Verdana');
    PolPoiskShr.Size:=iFile.ReadInteger('Шрифт поиска', 'Размер', 9);
    PolPoiskShr.Style:=[];
    If iFile.ReadBool('Шрифт поиска', 'Жирный', False) then
      PolPoiskShr.Style:=[fsBold];
    If iFile.ReadBool('Шрифт поиска', 'Наклонный', False) then
      PolPoiskShr.Style:=PolPoiskShr.Style+[fsItalic];
    If iFile.ReadBool('Шрифт поиска', 'Подчёркнутый', False) then
      PolPoiskShr.Style:=PolPoiskShr.Style+[fsUnderline];
    If iFile.ReadBool('Шрифт поиска', 'Зачёркнутый', False) then
      PolPoiskShr.Style:=PolPoiskShr.Style+[fsStrikeOut];

    PorShr.Color:=iFile.ReadInteger('Шрифт порядка', 'Цвет', clWindowText);
    PorShr.Name:=iFile.ReadString('Шрифт порядка', 'Название', 'Verdana');
    PorShr.Size:=iFile.ReadInteger('Шрифт порядка', 'Размер', 9);
    PorShr.Style:=[];
    If iFile.ReadBool('Шрифт порядка', 'Жирный', False) then
      PorShr.Style:=[fsBold];
    If iFile.ReadBool('Шрифт порядка', 'Наклонный', False) then
      PorShr.Style:=PorShr.Style+[fsItalic];
    If iFile.ReadBool('Шрифт порядка', 'Подчёркнутый', False) then
      PorShr.Style:=PorShr.Style+[fsUnderline];
    If iFile.ReadBool('Шрифт порядка', 'Зачёркнутый', False) then
      PorShr.Style:=PorShr.Style+[fsStrikeOut];

    RazCv:=iFile.ReadInteger('Цвет', 'Разделитель', clRed);
    pRaz2.Color:=RazCv;
    pRaz3.Color:=RazCv;
    pRaz4.Color:=RazCv;
    PoleCv:=iFile.ReadInteger('Цвет', 'Поле', $00C0FBBF);
    PolPoiskCv:=iFile.ReadInteger('Цвет', 'Поиск', $00D7FDD5);
    cbPoisk.Color:=PolPoiskCv;
    ePoisk.Color:=PolPoiskCv;
    PolDanCv:=iFile.ReadInteger('Цвет', 'Блок', $00F8FFE1);
    pN1.Color:=PolDanCv;
    pN2.Color:=PolDanCv;
    pN3.Color:=PolDanCv;
    pN4.Color:=PolDanCv;
    Color:=iFile.ReadInteger('Цвет', 'Окно', $00FFE6F9);
    fProchCv:=iFile.ReadInteger('Цвет', 'Настройки', $00E4DAE4);
    fPrListCv:=iFile.ReadInteger('Цвет', 'Порядок', $00DCFDDB);

    For i:=0 to ComponentCount-1 do
      if Components[i] is TLabel then
      begin
        if Components[i].Tag=0 then
        begin
          (Components[i] as TLabel).Font.Color:=ZagShr.Color;
          (Components[i] as TLabel).Font.Name:=ZagShr.Name;
          (Components[i] as TLabel).Font.Size:=ZagShr.Size;
          (Components[i] as TLabel).Font.Style:=ZagShr.Style;
        end
      end
      else if Components[i] is TEdit then
      begin
        if Components[i].Tag=0 then
        begin
          (Components[i] as TEdit).Font.Color:=PoleShr.Color;
          (Components[i] as TEdit).Font.Name:=PoleShr.Name;
          (Components[i] as TEdit).Font.Size:=PoleShr.Size;
          (Components[i] as TEdit).Font.Style:=PoleShr.Style;

          (Components[i] as TEdit).Color:=PoleCv;
        end;
      end;
    mDopInfa.Font:=PoleShr;
    mDopInfa.Color:=PoleCv;

    If not iFile.ReadBool('Раздел', 'Номер 2', True) then pRaz2Click(pRaz2);
    If not iFile.ReadBool('Раздел', 'Номер 3', True) then pRaz2Click(pRaz3);
    If not iFile.ReadBool('Раздел', 'Номер 4', True) then pRaz2Click(pRaz4);

    Chuvst.Frequency:=iFile.ReadInteger('Жест', 'Частота',  25);
    Chuvst.Range    :=iFile.ReadInteger('Жест', 'Диапазон', 20);
    Dinamo.Sensitivity:=Chuvst;

    ZagShr.Free;
    PoleShr.Free;
    PolPoiskShr.Free;

    FINALLY

    iFile.Free;

    END;

  End//If FileExists(Papka+'tas.ini') then
  Else
  Begin
    pRaz2Click(pRaz2);
    pRaz2Click(pRaz3);
    pRaz2Click(pRaz4);
  End;

  Tag:=0;

  If Spisok.Count>1 then
    bPoryadok.Enabled:=True
  Else bPoryadok.Enabled:=False;

  Top:=Screen.Height DIV 2 - Height DIV 2;
  Left:=Screen.Width DIV 2 - Width DIV 2;
  AnimateWindow(Handle, 500, AW_ACTIVATE or AW_CENTER);
end;

//====================

procedure TfGlav.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  rez: Byte;
begin
  (* Закрытие главной формы *)

  CanClose:=True;
  If bSohr.Visible then
  Begin
    rez:=MsgDlg('Выход', 'Запись находится в состоянии редактирования.'+#13#10+
      'Сохранить изменения?', mtConfirmation, [mbYes, mbNo, mbCancel],
      ['&Да', '&Нет', '&Отмена']);
    if rez=mrYes then
    begin
      bSohrClick(fGlav);
      while not Sohranenie.Suspended do Application.ProcessMessages;
    end
    else if rez<>mrNo then
    begin
      CanClose:=False;
      Exit;
    end;
  End;

  If not Sohranenie.Suspended then
  Begin
    if MsgDlg('Выход',
      'Идёт сохранение '+IntToStr(Sohranenie.Kolvo)+
      ' из '+IntToStr(Spisok.Count)+' записей'+#13#10+
      'Прервать сохранение?', mtWarning, [mbYes, mbNo],
      ['&Да', '&Отмена'])<>mrYes then
    begin
      CanClose:=False;
      Exit;
    end;
  End;

  Dinamo.Destroy;
  Poisk.Destroy;
  Spisok.Destroy;

  //AnimateWindow(Handle, 500, AW_HIDE or AW_BLEND);
  AnimateWindow(Handle, 500, AW_HIDE or AW_CENTER);
end;

//_________________________Кнопки_управления_списком____________________________
//==============================================================================

procedure TfGlav.bNazadClick(Sender: TObject);
begin
  (* На шаг назад *)

  If not BylPoisk then
    Zagruzka(pN1.Tag-1)
  Else //if BylPoisk then
    Zagruzka(ePoisk.Tag-1);
end;

//====================

procedure TfGlav.bVperedClick(Sender: TObject);
begin
  (* На шаг вперёд *)

  If not BylPoisk then
    Zagruzka(pN1.Tag+1)
  Else //if BylPoisk then
    Zagruzka(ePoisk.Tag+1);
end;

//====================

procedure TfGlav.bNachaloClick(Sender: TObject);
begin
  (* В начало списка *)
  Zagruzka(1);
end;

//====================

procedure TfGlav.bKonecClick(Sender: TObject);
begin
  (* В конец списка *)

  If not BylPoisk then
    Zagruzka(Spisok.Count)
  Else //if BylPoisk then
    Zagruzka(Poisk.Count);
end;

//_________________________Кнопки_управления_записью____________________________
//==============================================================================

procedure TfGlav.bDobClick(Sender: TObject);
var
  i: Word;
begin
  (* Добавить новую запись *)

  Dobavlenie:=True;
  For i:=0 to ComponentCount-1 do
    if Components[i] is TEdit then
    begin
      if Components[i].Tag=0 then
      begin
        (Components[i] as TEdit).ReadOnly:=False;
        (Components[i] as TEdit).BorderStyle:=bsSingle;
        (Components[i] as TEdit).Clear;
      end;
    end;
  mDopInfa.ReadOnly:=False;
  mDopInfa.BorderStyle:=bsSingle;
  mDopInfa.Clear;

  bDob.Hide;
  bIzm.Hide;
  bUdal.Hide;
  bSohr.Show;
  bOtmena.Show;
  bNazad.Enabled:=False;
  bVpered.Enabled:=False;
  bNachalo.Enabled:=False;
  bKonec.Enabled:=False;
  bPoryadok.Enabled:=False;
  bNastroiki.Enabled:=False;
  bOchistit.Enabled:=False;
  cbPoisk.Enabled:=False;
  ePoisk.Enabled:=False;
  eFIO.SetFocus;
end;

//====================

procedure TfGlav.bIzmClick(Sender: TObject);
var
  i: Word;
begin
  (* Изменить текущую запись *)

  Dobavlenie:=False;
  For i:=0 to ComponentCount-1 do
    if Components[i] is TEdit then
    begin
      if Components[i].Tag=0 then
      begin
        (Components[i] as TEdit).ReadOnly:=False;
        (Components[i] as TEdit).BorderStyle:=bsSingle;
      end;
    end;
  mDopInfa.ReadOnly:=False;
  mDopInfa.BorderStyle:=bsSingle;

  bDob.Hide;
  bIzm.Hide;
  bUdal.Hide;
  bSohr.Show;
  bOtmena.Show;
  bNazad.Enabled:=False;
  bVpered.Enabled:=False;
  bNachalo.Enabled:=False;
  bKonec.Enabled:=False;
  bPoryadok.Enabled:=False;
  bOchistit.Enabled:=False;
  cbPoisk.Enabled:=False;
  ePoisk.Enabled:=False;
  eFIO.SetFocus;
end;

//====================

procedure TfGlav.bUdalClick(Sender: TObject);
begin
  (* Удалить текущую запись *)

  If MsgDlg('Удаление', 'Удалить запись?', mtConfirmation,
    [mbYes, mbNo], ['&Удалить', '&Отмена'])=mrYes then
  Begin
    if not BylPoisk then
    begin
      Spisok.Delete(pN1.Tag);
      if pN1.Tag>1 then
        Zagruzka(pN1.Tag-1)
      else Zagruzka(pN1.Tag);
    end
    else //if BylPoisk then
    begin
      Spisok.Delete( Spisok.Number[  Poisk.Item[ePoisk.Tag]^.pValue  ] );
      Poisk.Delete(ePoisk.Tag);

      pN1.Tag:=1;
      if Poisk.Count<>0 then
      begin
        if ePoisk.Tag>1 then
          Zagruzka(ePoisk.Tag-1)
        else Zagruzka(ePoisk.Tag);
      end
      else //if Poisk.Count=0 then
        ePoiskChange(ePoisk);
    end;

    Sohranenie.ReStart;
    if Sohranenie.Oshibka then
      MsgDlg('Служебное сообщение', 'Не могу открыть файл!', mtError,
        [mbOK], ['&Ясно']);
  End;
  If Spisok.Count<2 then
    bPoryadok.Enabled:=False;
end;

//___________________________Сохранение_или_отмена______________________________
//==============================================================================

procedure TfGlav.bSohrClick(Sender: TObject);
var
  i, k: Word;
  Ptr: PRListEl;
begin
  (* Сохранить изменения в записи или сохранить новую запись *)

  If eFIO.Text='' then
  Begin
    if Sender=Self then
    begin
      eFIO.Text:='Неизвестный';
      MsgDlg('Сохранение', 'Запись будет сохранена под именем "Неизвестный".',
        mtInformation, [mbOK], ['&Добро']);
    end
    else
    begin
      MsgDlg('Сохранение', 'Заполните поле для ФИО!',
        mtInformation, [mbOK], ['&Добро']);
      eFIO.SetFocus;
      Exit;
    end;
  End;

  If Dobavlenie then            //Была нажата "Добавить"
  Begin
    Spisok.Add;
    SetLength(Spisok.Last^.Value, TAG_KOLVO);

    k:=Spisok.Count;
    Ptr:=Spisok.Last;

    if Spisok.Count>1 then
      bPoryadok.Enabled:=True
    else bPoryadok.Enabled:=False;
  End
  Else if not Dobavlenie then   //Была нажата "Изменить"
  Begin
    if not BylPoisk then
    begin
      k:=pN1.Tag;
      Ptr:=Spisok.Item[k];

      if Spisok.Count>1 then
        bPoryadok.Enabled:=True
      else bPoryadok.Enabled:=False;
    end
    else //if BylPoisk then
    begin
      k:=ePoisk.Tag;
      Ptr:=Poisk.Item[k]^.pValue;
      bPoryadok.Enabled:=False;
    end;
  End
  Else Exit;

  Ptr^.Value[0]:=eFIO.Text;
  Ptr^.Value[1]:=eDomTel.Text;
  Ptr^.Value[2]:=eSotTel1.Text;
  Ptr^.Value[3]:=eSotTel2.Text;
  Ptr^.Value[4]:=eRabTel1.Text;
  Ptr^.Value[5]:=eRabTel2.Text;
  Ptr^.Value[6]:=eMail1.Text;
  Ptr^.Value[7]:=eMail2.Text;
  Ptr^.Value[8]:=eMail3.Text;
  Ptr^.Value[9]:=eVKont.Text;
  Ptr^.Value[10]:=eICQ.Text;
  Ptr^.Value[11]:=eSkype.Text;
  Ptr^.Value[12]:=eStranica.Text;
  Ptr^.Value[13]:=eDomAdres.Text;
  Ptr^.Value[14]:=eRabAdres.Text;
  Ptr^.Value[15]:=eKompania.Text;
  Ptr^.Value[16]:=eDolzhn.Text;
  Ptr^.Value[17]:=eDenRozhd.Text;
  Ptr^.Value[18]:=mDopInfa.Text;

  Zagruzka(k);

  For i:=0 to ComponentCount-1 do
    if Components[i] is TEdit then
    begin
      if Components[i].Tag=0 then
      begin
        if Components[i].Name='qwe' then
          Components[i].Tag:=0;
        (Components[i] as TEdit).ReadOnly:=True;
        (Components[i] as TEdit).BorderStyle:=bsNone;
      end;
    end;
  mDopInfa.ReadOnly:=True;
  mDopInfa.BorderStyle:=bsNone;

  bDob.Show;
  bIzm.Show;
  bUdal.Show;
  bSohr.Hide;
  bOtmena.Hide;
  bNastroiki.Enabled:=True;
  bOchistit.Enabled:=True;
  cbPoisk.Enabled:=True;
  ePoisk.Enabled:=True;
  eFIO.SetFocus;

  Sohranenie.ReStart;
  If Sohranenie.Oshibka then
    MsgDlg('Служебное сообщение', 'Не могу открыть файл!', mtError,
      [mbOK], ['&Ясно']);

  ePoiskChange(ePoisk);
end;

//====================

procedure TfGlav.bOtmenaClick(Sender: TObject);
var
  i: Word;
begin
  (* Отменить изменения в записи *)

  For i:=0 to ComponentCount-1 do
    if Components[i] is TEdit then
    begin
      if Components[i].Tag=0 then
      begin
        (Components[i] as TEdit).ReadOnly:=True;
        (Components[i] as TEdit).BorderStyle:=bsNone;
      end;
    end;
  mDopInfa.ReadOnly:=True;
  mDopInfa.BorderStyle:=bsNone;

  bDob.Show;
  bIzm.Show;
  bUdal.Show;
  bSohr.Hide;
  bOtmena.Hide;
  bNastroiki.Enabled:=True;
  bOchistit.Enabled:=True;
  cbPoisk.Enabled:=True;
  ePoisk.Enabled:=True;

  If not BylPoisk then
  Begin
    Zagruzka(pN1.Tag);
    if Spisok.Count>1 then
      bPoryadok.Enabled:=True
    else bPoryadok.Enabled:=False;
  End
  Else //if BylPoisk then
  Begin
    Zagruzka(ePoisk.Tag);
    bPoryadok.Enabled:=False;
  End;

  eFIO.SetFocus;
end;

//__________________________Дополнительные_кнопки_______________________________
//==============================================================================

procedure TfGlav.bPoryadokClick(Sender: TObject);
begin
  (* Изменить порядок записей *)

  fPoryadok.ShowModal;
  Poisk.Clear;
end;

//====================

procedure TfGlav.bNastroikiClick(Sender: TObject);
begin
  (* Изменить настройки программы *)

  fNastroiki.ShowModal;
  If fNastroiki.ModalResult=mrOk then
    fNastroiki.bPrinyat.Click;
end;

procedure TfGlav.lSpravkaClick(Sender: TObject);
begin
  (* Открытие окна справки *)
  fGorKlav.ShowModal;
end;

//_______________________Управление_внешним_видом_______________________________
//==============================================================================

procedure TfGlav.pRaz2Click(Sender: TObject);
var
  tStop: Boolean; //Что делать TabStop компонентов внутри панели
  nom: Byte;      //Номер используемой панели
  i: Word;        //Счётчик
  Razn: SmallInt; //Разница в размерах
  Pan: TPanel;    //Родительская панель
  iFile: TIniFile;
begin
  (* Скрыть/показать панель *)

  Pan:=(Sender as TPanel).Parent as TPanel;
  Nom:=StrToInt(Copy(Pan.Name, 3, 1));
  Razn:=Pan.Height;

  If Pan.Height>17 then
  Begin
    Pan.Height:=17;
    tStop:=False;
  End
  Else
  Begin
    Pan.Height:=Pan.Tag;
    tStop:=True;
  End;

  Razn:=Pan.Height-Razn;

  For i:=Nom+1 to 4 do
  Begin
    Pan:=FindComponent('pN'+IntToStr(i)) as TPanel;
    Pan.Top:=Pan.Top+Razn;
  End;

  For i:=0 to ComponentCount-1 do
    if Components[i] is TButton then
      (Components[i] as TButton).Top:=(Components[i] as TButton).Top+Razn;
  cbPoisk.Top:=cbPoisk.Top+Razn;
  ePoisk.Top:=ePoisk.Top+Razn;
  lSpravka.Top:=lSpravka.Top+Razn;
  lSpravka.Cursor:=crHandPoint;
  lPusto.Top:=lPusto.Top+Razn;
  Height:=Height+Razn;

  Case Nom of
    2:  begin
          eMail1.TabStop:=tStop;
          eMail2.TabStop:=tStop;
          eMail3.TabStop:=tStop;
          eVKont.TabStop:=tStop;
          eICQ.TabStop:=tStop;
          eSkype.TabStop:=tStop;
          eStranica.TabStop:=tStop;
        end;
    3:  begin
          eDomAdres.TabStop:=tStop;
          eRabAdres.TabStop:=tStop;
          eKompania.TabStop:=tStop;
          eDolzhn.TabStop:=tStop;
        end;
    4:  begin
          eDenRozhd.TabStop:=tStop;
          mDopInfa.TabStop:=tStop;
        end;
  End;

  If Tag=0 then
    TRY
      iFile:=TIniFile.Create(Papka+'tas.ini');

      For i:=2 to 4 do
      Begin
        if (FindComponent('pN'+IntToStr(i)) as TPanel).Height>17 then
          iFile.WriteBool('Раздел', 'Номер '+IntToStr(i), True)
        else iFile.WriteBool('Раздел', 'Номер '+IntToStr(i), False);
      End;
    FINALLY
      iFile.Free;
    END;
end;

//___________________________Управление_поиском_________________________________
//==============================================================================

procedure TfGlav.ePoiskChange(Sender: TObject);
var
  i: Word;
  {iX, iY: Integer;
  Edit: TEdit;}
begin
  (* Изменение текста в поле поиска (реализация "живого" поиска) *)

    //Получение позиции курсора
  {iX:=0;
  If Sender is TEdit then
  Begin
    Edit:=TEdit(Sender);
    iY:=SendMessage(Edit.Handle, EM_LINEFROMCHAR, Edit.SelStart, 0);
    iX:=Edit.SelStart - SendMessage(Edit.Handle, EM_LINEINDEX, iY, 0);
  End;}

  If Length(ePoisk.Text)<2 then           //Если меньше двух символов
  Begin
    if BylPoisk then
    begin
      PtPoisk.Free;   //Уничтожаю поток, если он был ранее создан
      PtPoisk:=nil;
      Poisk.Clear;    //Очищаю список найденных
      lPusto.Hide;
      BylPoisk:=False;
      bDob.Enabled:=True;
      bNastroiki.Enabled:=True;
      Zagruzka(pN1.Tag);
    end;
    BylPoisk:=False;

    if Spisok.Count>1 then
      bPoryadok.Enabled:=True
    else bPoryadok.Enabled:=False;
  End//if Length(ePoisk.Text)<2 then

  Else //if Length(ePoisk.Text)>=2 then   //Если два и более символов
  Begin
      //Уничтожаю поток, если он был ранее создан
    PtPoisk.Free;
      //Создаю поток для поиска
    PtPoisk:=TPoisk.Create(False);
    BylPoisk:=True;
      //Жду окончания поиска
    while (PtPoisk<>nil) do
    begin
      if not PtPoisk.Gotovo then Application.ProcessMessages
      else Break;
    end;

      //Если поток существует
    if PtPoisk<>nil then
    begin
        //Если ничего не нашлось
      if PtPoisk.Gotovo and PtPoisk.Pusto then
      begin
        {MsgDlg('Поиск', 'По запросу "'+ePoisk.Text+'" ничего не найдено',
          mtInformation, [mbOK], ['&Ясно']);

        ePoisk.Text:=PosledTekst;
        if Sender is TEdit then
          ePoisk.SelStart:=iX-1;}

        for i:=0 to ComponentCount-1 do
          if Components[i] is TEdit then
          begin
            if Components[i].Tag=0 then
              (Components[i] as TEdit).Clear;
          end;
        mDopInfa.Clear;
        bNachalo.Enabled:=False;
        bNazad.Enabled:=False;
        bVpered.Enabled:=False;
        bKonec.Enabled:=False;
        bIzm.Enabled:=False;
        bUdal.Enabled:=False;

          //Показ сообщения "Пусто"
        lPusto.Visible:=True;
        lPusto.Caption:='Пусто';
      end
      else if PtPoisk.Gotovo and not PtPoisk.Pusto then
      begin
        lPusto.Show;
        lPusto.Caption:=IntToStr(Poisk.Count);
        PosledTekst:=ePoisk.Text;
        bIzm.Enabled:=True;
        bUdal.Enabled:=True;
      end;
    end;//if PtPoisk<>nil then
  End;//Else if Length(ePoisk.Text)>=2 then
end;

//====================

procedure TfGlav.cbPoiskChange(Sender: TObject);
begin
  (* Запуск поиска, если строка поиска не пуска *)
  If Length(ePoisk.Text)>=2 then ePoiskChange(Sender);
end;

procedure TfGlav.bOchistitClick(Sender: TObject);
begin
  (* Очистка поиска *)

  ePoisk.Clear;
  ePoisk.SetFocus;
end;

end.
{
  Добавить настройку цвета всплывающей подсказки.
}
