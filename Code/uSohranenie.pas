unit uSohranenie;

interface

uses
  Classes, Dialogs;

type
  TSohranenie = class(TThread)
  public
    Oshibka: Boolean;
    Kolvo: Cardinal;
    procedure ReStart;
  private
    FRestart: Boolean;  //True - Ќачать сохранение заново
  protected
    procedure Execute; override;
  end;

var
  Sohranenie: TSohranenie;

implementation

uses uRList, uTelefon, uDopFun, SysUtils;

procedure TSohranenie.ReStart;
begin
  (* ќстанавливает текущее сохранение, если оно шло, и запускает сохранение *)

  If not Suspended then
    FRestart:=True
  Else
    Resume;
end;

procedure TSohranenie.Execute;
var
  TIP: Byte;
  j: Byte;
  i: Word;
  Ptr: PRListEl;
  FHan: Integer;
  Buf: String;
  Bufer: Array of String;
  n: Byte;
begin
  FRestart:=False;
  WHILE not Terminated DO
  BEGIN
    If FRestart then FRestart:=False;

    Oshibka:=False;
    Kolvo:=0;

      //—оздаю резервный файл
    Rezerv;

    TIP:=2;

    IF TIP=1 THEN
    BEGIN

    FHan:=FileCreate(Papka+'tas.dat', fmOpenWrite);
    if FHan=-1 then
    begin
      Oshibka:=True;
      Suspend;
      Continue;
    end;

    Ptr:=Spisok.First;
    For i:=1 to Spisok.Count do
    Begin
      if FRestart then Break;
      Buf:='<nz>';

      for j:=0 to TAG_KOLVO-1 do
        if Spisok.Item[i]^.Value[j]<>'' then
          Buf:=Buf+ParsTag[j+1]+Spisok.Item[i]^.Value[j];

      Buf:=Buf+#13#10;

      FileWrite(FHan, Buf, Length(Buf));
      Ptr:=Ptr^.Next;
      Inc(Kolvo);
    End;
    If FRestart then
    Begin
      FileClose(FHan);
      Rezerv(3);  //удал€ю недоделанный файл, возвращаюсь к резерву
      Continue;
    End;

    FileClose(FHan);

    END//IF TIP=1 THEN
    
    ELSE IF TIP=2 THEN
    BEGIN

    Try
      AssignFile(Fail, Papka+'tas.dat');
      Rewrite(Fail);
    Except
      Oshibka:=True;
      Suspend;
      Continue;
    End;

    Ptr:=Spisok.First;
    //SetLength(Bufer, (Spisok.Count DIV 5000)+1);
    Buf:='';
    For i:=1 to Spisok.Count do
    Begin
      if FRestart then Break;

      //n:=Kolvo DIV 5000;
      //Bufer[n]:=Bufer[n]+'<nz>';
      Buf:=Buf+'<nz>';

      for j:=0 to TAG_KOLVO-1 do
        if Spisok.Item[i]^.Value[j]<>'' then
          //Bufer[n]:=Bufer[n]+ParsTag[j+1]+Spisok.Item[i]^.Value[j];
          Buf:=Buf+ParsTag[j+1]+Spisok.Item[i]^.Value[j];

      //Bufer[n]:=Bufer[n]+#13#10;
      Buf:=Buf+#13#10;

      Ptr:=Ptr^.Next;
      Inc(Kolvo);
      if Kolvo MOD 5000 = 0 then
      begin
        Write(Fail, Buf);
        Flush(Fail);
        CloseFile(Fail);
        AssignFile(Fail, Papka+'tas.dat');
        Append(Fail);
        Buf:='';
      end;
    End;
    If FRestart then
    Begin
      CloseFile(Fail);
      Rezerv(3);  //удал€ю недоделанный файл, возвращаюсь к резерву
      Continue;
    End;
    {For i:=0 to Length(Bufer)-1 do
      Write(Fail, Bufer[i]);}
    Write(Fail, Buf);
    Flush(Fail);

    CloseFile(Fail);

    END;//ELSE IF TIP=2 THEN

      //”дал€ю резервный файл
    //Rezerv(1);

    SetLength(Bufer, 0);
    Suspend;
  END;
end;

initialization
  Sohranenie:=TSohranenie.Create(True);
  Sohranenie.FreeOnTerminate:=True;
  Sohranenie.Priority:=tpHighest;

finalization
  Sohranenie.Terminate;

end.
