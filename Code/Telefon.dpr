program Telefon;

uses
  Forms,
  uTelefon in 'uTelefon.pas' {fGlav},
  uDopFun in 'uDopFun.pas',
  uNastroiki in 'uNastroiki.pas' {fNastroiki},
  uPoryadok in 'uPoryadok.pas' {fPoryadok},
  uRList in 'uRList.pas',
  uSohranenie in 'uSohranenie.pas',
  uGorKlav in 'uGorKlav.pas' {fGorKlav},
  uRListZh in 'uRListZh.pas',
  uPoisk in 'uPoisk.pas',
  uNForm in 'uNForm.pas',
  uRazGestures in 'uRazGestures.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Телефонно-адресный справочник';
  Application.CreateForm(TfGlav, fGlav);
  Application.CreateForm(TfNastroiki, fNastroiki);
  Application.CreateForm(TfPoryadok, fPoryadok);
  Application.CreateForm(TfGorKlav, fGorKlav);
  Application.Run;
end.
