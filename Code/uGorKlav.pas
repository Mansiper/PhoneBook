unit uGorKlav;

interface

uses
  Forms, Classes, Controls, StdCtrls, ExtCtrls, Graphics, ShellAPI;

type
  TfGorKlav = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Button1: TButton;
    l1: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Panel1: TPanel;
    iNazad: TImage;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    iVpered: TImage;
    Label46: TLabel;
    Label47: TLabel;
    iNachalo: TImage;
    Label48: TLabel;
    Label49: TLabel;
    iKonec: TImage;
    Label51: TLabel;
    Label52: TLabel;
    iPoisk: TImage;
    Label50: TLabel;
    Label53: TLabel;
    iPoryadok: TImage;
    Label54: TLabel;
    Label55: TLabel;
    iBlokiOtkr: TImage;
    Label56: TLabel;
    Label57: TLabel;
    iBlokiZakr: TImage;
    Label58: TLabel;
    Label59: TLabel;
    iOchistit: TImage;
    Label60: TLabel;
    Panel2: TPanel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    iVyhod: TImage;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label62Click(Sender: TObject);
  end;

var
  fGorKlav: TfGorKlav;

implementation

uses uTelefon;

{$R *.dfm}

//==============================================================================

procedure TfGorKlav.FormCreate(Sender: TObject);
begin
  If FileEst then
    Color:=fProchCv;
end;

procedure TfGorKlav.FormShow(Sender: TObject);
begin
  Top:=fGlav.Height DIV 2 - Height DIV 2 + fGlav.Top;
  Left:=fGlav.Width DIV 2 - Width DIV 2 + fGlav.Left;
  If Top>Screen.Height-Height then Top:=Screen.Height-Height;
  If Left>Screen.Width-Width then Left:=Screen.Width-Width;
  If Top<0 then Top:=0;
  If Left<0 then Left:=0;
end;

procedure TfGorKlav.Label62Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, 'mailto:ManProger@mail.ru', nil, nil, 5);
  //SW_SHOW = 5 (чтобы не использовать модуль Windows
end;

end.
