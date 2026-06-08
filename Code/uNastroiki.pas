unit uNastroiki;

interface

uses
  Forms, IniFiles, Dialogs, StdCtrls, Controls, ExtCtrls, Classes, Graphics,
  ComCtrls;

type
  TfNastroiki = class(TForm)
    bPrinyat: TButton;
    fd1: TFontDialog;
    cd1: TColorDialog;
    bDobro: TButton;
    bOtmena: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lCv1: TLabel;
    bShZag: TButton;
    bShPolDan: TButton;
    pPrimerF: TPanel;
    pPrimer: TPanel;
    lPrimer: TLabel;
    ePrimer: TEdit;
    pPrimerR: TPanel;
    ePrimerP: TEdit;
    bCvRaz: TButton;
    bCvPolDan: TButton;
    bCvBlDan: TButton;
    bCvOkn: TButton;
    bCvOknNastr: TButton;
    bCvPolSpisok: TButton;
    bShPolPoisk: TButton;
    bCvPolPoisk: TButton;
    lbPrimer: TListBox;
    bShPolSpisok: TButton;
    pChastota: TPanel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    tbChastota: TTrackBar;
    pDizpazon: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    tbDiapazon: TTrackBar;
    stChuvstInfa: TStaticText;
    Kartinka: TImage;
    procedure bShZagClick(Sender: TObject);
    procedure bShPolDanClick(Sender: TObject);
    procedure bShPolPoiskClick(Sender: TObject);
    procedure bCvRazClick(Sender: TObject);
    procedure bCvPolDanClick(Sender: TObject);
    procedure bCvBlDanClick(Sender: TObject);
    procedure bCvOknClick(Sender: TObject);
    procedure bCvPolPoiskClick(Sender: TObject);
    procedure bCvOknNastrClick(Sender: TObject);
    procedure bCvPolSpisokClick(Sender: TObject);
    procedure bPrinyatClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bShPolSpisokClick(Sender: TObject);
    procedure pChastotaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  end;

var
  fNastroiki: TfNastroiki;

implementation

uses uTelefon, uPoryadok, uZhesty, uRazGestures;

{$R *.dfm}

//==============================================================================

procedure TfNastroiki.FormCreate(Sender: TObject);
begin
  If FileEst then
    Color:=fProchCv;
end;

procedure TfNastroiki.FormShow(Sender: TObject);
begin
  Top:=fGlav.Height DIV 2 - Height DIV 2 + fGlav.Top;
  Left:=fGlav.Width DIV 2 - Width DIV 2 + fGlav.Left;
  If Top>Screen.Height-Height then Top:=Screen.Height-Height;
  If Left>Screen.Width-Width then Left:=Screen.Width-Width;
  If Top<0 then Top:=0;
  If Left<0 then Left:=0;

  lPrimer.Font:=fGlav.Label1.Font;
  ePrimer.Font:=fGlav.eFIO.Font;
  ePrimerP.Font:=fGlav.cbPoisk.Font;
  ePrimer.Color:=fGlav.eFIO.Color;
  pPrimer.Color:=fGlav.pN1.Color;
  pPrimerF.Color:=fGlav.Color;
  ePrimerP.Color:=fGlav.cbPoisk.Color;
  lCv1.Color:=Color;
  lbPrimer.Font:=fPoryadok.ListBox1.Font;
  lbPrimer.Color:=fPoryadok.ListBox1.Color;

  PageControl1.ActivePageIndex:=0;
  bShZag.SetFocus;
  With Kartinka.Picture.Bitmap.Canvas DO
  Begin
    Brush.Color:=lCv1.Color;
    Brush.Style:=bsSolid;
    Rectangle(0, 0, Width, Height);
  End;
  tbChastota.Position:=Chuvst.Frequency;
  tbDiapazon.Position:=Chuvst.Range;
end;

//==============================================================================

procedure TfNastroiki.bShZagClick(Sender: TObject);
begin
  fd1.Font:=lPrimer.Font;
  If fd1.Execute then
    lPrimer.Font:=fd1.Font;
end;

procedure TfNastroiki.bShPolDanClick(Sender: TObject);
begin
  fd1.Font:=ePrimer.Font;
  If fd1.Execute then
    ePrimer.Font:=fd1.Font;
end;

procedure TfNastroiki.bShPolPoiskClick(Sender: TObject);
begin
  fd1.Font:=ePrimerP.Font;
  If fd1.Execute then
    ePrimerP.Font:=fd1.Font;
end;

procedure TfNastroiki.bCvRazClick(Sender: TObject);
begin
  cd1.Color:=pPrimerR.Color;
  If cd1.Execute then
    pPrimerR.Color:=cd1.Color;
end;

procedure TfNastroiki.bCvPolDanClick(Sender: TObject);
begin
  cd1.Color:=ePrimer.Color;
  If cd1.Execute then
    ePrimer.Color:=cd1.Color;
end;

procedure TfNastroiki.bCvBlDanClick(Sender: TObject);
begin
  cd1.Color:=pPrimer.Color;
  If cd1.Execute then
    pPrimer.Color:=cd1.Color;
end;

procedure TfNastroiki.bCvOknClick(Sender: TObject);
begin
  cd1.Color:=pPrimerF.Color;
  If cd1.Execute then
    pPrimerF.Color:=cd1.Color;
end;

procedure TfNastroiki.bCvPolPoiskClick(Sender: TObject);
begin
  cd1.Color:=ePrimerP.Color;
  If cd1.Execute then
    ePrimerP.Color:=cd1.Color;
end;

procedure TfNastroiki.bCvOknNastrClick(Sender: TObject);
begin
  cd1.Color:=lCv1.Color;
  If cd1.Execute then
    lCv1.Color:=cd1.Color;
end;

procedure TfNastroiki.bCvPolSpisokClick(Sender: TObject);
begin
  cd1.Color:=lbPrimer.Color;
  If cd1.Execute then
    lbPrimer.Color:=cd1.Color;
end;

procedure TfNastroiki.bShPolSpisokClick(Sender: TObject);
begin
  fd1.Font:=lbPrimer.Font;
  If fd1.Execute then
    lbPrimer.Font:=fd1.Font;
end;

//==============================================================================

procedure TfNastroiki.bPrinyatClick(Sender: TObject);
var
  i: Word;
  iFile: TIniFile;
begin
  (* Принятие изменений *)

  With fGlav do
  Begin
    for i:=0 to fGlav.ComponentCount-1 do
      if Components[i] is TLabel then
      begin
        if Components[i].Tag=0 then
          (Components[i] as TLabel).Font:=lPrimer.Font;
      end
      else if Components[i] is TEdit then
      begin
        if Components[i].Tag=0 then
        begin
          (Components[i] as TEdit).Font:=ePrimer.Font;
          (Components[i] as TEdit).Color:=ePrimer.Color;
        end;
      end;

    mDopInfa.Font:=ePrimer.Font;
    mDopInfa.Color:=ePrimer.Color;
    pRaz2.Color:=pPrimerR.Color;
    pRaz3.Color:=pPrimerR.Color;
    pRaz4.Color:=pPrimerR.Color;
    pN1.Color:=pPrimer.Color;
    pN2.Color:=pPrimer.Color;
    pN3.Color:=pPrimer.Color;
    pN4.Color:=pPrimer.Color;
    Color:=pPrimerF.Color;
    cbPoisk.Font:=ePrimerP.Font;
    cbPoisk.Color:=ePrimerP.Color;
    ePoisk.Font:=ePrimerP.Font;
    ePoisk.Color:=ePrimerP.Color;
  End;
  Color:=lCv1.Color;
  fPoryadok.Color:=lCv1.Color;
  fPoryadok.lZapis.Font:=lbPrimer.Font;
  fPoryadok.ListBox1.Font:=lbPrimer.Font;
  fPoryadok.ListBox1.Color:=lbPrimer.Color;

    //Изменение чувствительности жеста
  Chuvst.Frequency:=tbChastota.Position;
  Chuvst.Range:=tbDiapazon.Position;
  Dinamo.Sensitivity:=Chuvst;

  iFile:=TIniFile.Create(Papka+'tas.ini');
  FileEst:=True;

  iFile.WriteInteger('Шрифт загол', 'Цвет', lPrimer.Font.Color);
  iFile.WriteString('Шрифт загол', 'Название', lPrimer.Font.Name);
  iFile.WriteInteger('Шрифт загол', 'Размер', lPrimer.Font.Size);
  If fsBold in lPrimer.Font.Style then
    iFile.WriteBool('Шрифт загол', 'Жирный', True)
  Else iFile.WriteBool('Шрифт загол', 'Жирный', False);
  If fsItalic in lPrimer.Font.Style then
    iFile.WriteBool('Шрифт загол', 'Наклонный', True)
  Else iFile.WriteBool('Шрифт загол', 'Наклонный', False);
  If fsUnderline in lPrimer.Font.Style then
    iFile.WriteBool('Шрифт загол', 'Подчёркнутый', True)
  Else iFile.WriteBool('Шрифт загол', 'Подчёркнутый', False);
  If fsStrikeOut in lPrimer.Font.Style then
    iFile.WriteBool('Шрифт загол', 'Зачёркнутый', True)
  Else iFile.WriteBool('Шрифт загол', 'Зачёркнутый', False);

  iFile.WriteInteger('Шрифт поля', 'Цвет', ePrimer.Font.Color);
  iFile.WriteString('Шрифт поля', 'Название', ePrimer.Font.Name);
  iFile.WriteInteger('Шрифт поля', 'Размер', ePrimer.Font.Size);
  If fsBold in ePrimer.Font.Style then
    iFile.WriteBool('Шрифт поля', 'Жирный', True)
  Else iFile.WriteBool('Шрифт поля', 'Жирный', False);
  If fsItalic in ePrimer.Font.Style then
    iFile.WriteBool('Шрифт поля', 'Наклонный', True)
  Else iFile.WriteBool('Шрифт поля', 'Наклонный', False);
  If fsUnderline in ePrimer.Font.Style then
    iFile.WriteBool('Шрифт поля', 'Подчёркнутый', True)
  Else iFile.WriteBool('Шрифт поля', 'Подчёркнутый', False);
  If fsStrikeOut in ePrimer.Font.Style then
    iFile.WriteBool('Шрифт поля', 'Зачёркнутый', True)
  Else iFile.WriteBool('Шрифт поля', 'Зачёркнутый', False);

  iFile.WriteInteger('Шрифт поиска', 'Цвет', ePrimerP.Font.Color);
  iFile.WriteString('Шрифт поиска', 'Название', ePrimerP.Font.Name);
  iFile.WriteInteger('Шрифт поиска', 'Размер', ePrimerP.Font.Size);
  If fsBold in ePrimerP.Font.Style then
    iFile.WriteBool('Шрифт поиска', 'Жирный', True)
  Else iFile.WriteBool('Шрифт поиска', 'Жирный', False);
  If fsItalic in ePrimerP.Font.Style then
    iFile.WriteBool('Шрифт поиска', 'Наклонный', True)
  Else iFile.WriteBool('Шрифт поиска', 'Наклонный', False);
  If fsUnderline in ePrimerP.Font.Style then
    iFile.WriteBool('Шрифт поиска', 'Подчёркнутый', True)
  Else iFile.WriteBool('Шрифт поиска', 'Подчёркнутый', False);
  If fsStrikeOut in ePrimerP.Font.Style then
    iFile.WriteBool('Шрифт поиска', 'Зачёркнутый', True)
  Else iFile.WriteBool('Шрифт поиска', 'Зачёркнутый', False);

  iFile.WriteInteger('Шрифт порядка', 'Цвет', lbPrimer.Font.Color);
  iFile.WriteString('Шрифт порядка', 'Название', lbPrimer.Font.Name);
  iFile.WriteInteger('Шрифт порядка', 'Размер', lbPrimer.Font.Size);
  If fsBold in lbPrimer.Font.Style then
    iFile.WriteBool('Шрифт порядка', 'Жирный', True)
  Else iFile.WriteBool('Шрифт порядка', 'Жирный', False);
  If fsItalic in lbPrimer.Font.Style then
    iFile.WriteBool('Шрифт порядка', 'Наклонный', True)
  Else iFile.WriteBool('Шрифт порядка', 'Наклонный', False);
  If fsUnderline in lbPrimer.Font.Style then
    iFile.WriteBool('Шрифт порядка', 'Подчёркнутый', True)
  Else iFile.WriteBool('Шрифт порядка', 'Подчёркнутый', False);
  If fsStrikeOut in lbPrimer.Font.Style then
    iFile.WriteBool('Шрифт порядка', 'Зачёркнутый', True)
  Else iFile.WriteBool('Шрифт порядка', 'Зачёркнутый', False);

  iFile.WriteInteger('Цвет', 'Разделитель', pPrimerR.Color);
  iFile.WriteInteger('Цвет', 'Поле',        ePrimer.Color);
  iFile.WriteInteger('Цвет', 'Блок',        pPrimer.Color);
  iFile.WriteInteger('Цвет', 'Окно',        pPrimerF.Color);
  iFile.WriteInteger('Цвет', 'Поиск',       ePrimerP.Color);
  iFile.WriteInteger('Цвет', 'Настройки',   lCv1.Color);
  iFile.WriteInteger('Цвет', 'Порядок',     lbPrimer.Color);

    //Запись чувствительности жеста
  iFile.WriteInteger('Жест', 'Частота',  Chuvst.Frequency);
  iFile.WriteInteger('Жест', 'Диапазон', Chuvst.Range);

  iFile.Free;
end;

procedure TfNastroiki.pChastotaMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  (* Вывод инфы о ползунке изменения частоты *)

  If TControl(Sender).Name='pChastota' then
    stChuvstInfa.Caption:=
      '  Скорость определения изменения'+#13#10+
      ' положений мыши. Чем выше частота, тем'+#13#10+
      ' выше чувствительность жеста. Определяет'+#13#10+
      ' скорость рисования жеста.' 

  Else if TControl(Sender).Name='pDizpazon' then
    stChuvstInfa.Caption:=
      '  Расстояние, перемещение мыши на которое'+#13#10+
      ' не считается за изменение направления'+#13#10+
      ' движения. Чем меньше диапазон, тем выше'+#13#10+
      ' чувствительность жеста.'

  Else
    stChuvstInfa.Caption:=
      '  Нажмите кнопку "Применить" и нарисуйте'+#13#10+
      ' любой из жестов, использующихся в '+#13#10+
      ' программе, чтобы подобрать'+#13#10+
      ' чувствительность для себя.';
end;

end.
