unit uNForm;

interface

uses Forms, Messages, Types, Windows, Controls;

type
  TNForm = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    procedure WMNCPAINT(var msg: TMessage); message WM_NCPAINT;
    procedure WMNCACTIVATE(var msg: TMessage); message WM_NCACTIVATE;
    procedure WMNCMOUSEDOWN(var msg: TMessage); message WM_NCLBUTTONDOWN;
    procedure WMNCMOUSEMOVE(var msg: TMessage); message WM_NCMOUSEMOVE;
    procedure WMMOVE(var msg: TMessage); message WM_MOUSEMOVE;
    procedure WMLBUTTONUP(var msg: TMessage); message WM_LBUTTONUP;
    procedure WMNCMOUSEUP(var msg: TMessage); message WM_NCLBUTTONUP;
    procedure WNCLBUTTONDBLCLICK(var msg: TMessage); message WM_NCLBUTTONDBLCLK;
  end;

var
  h1: THandle;
  pressed: Boolean;
  focuslost: Boolean;
  rec: trect;

implementation

procedure TNForm.WMLBUTTONUP(var msg: TMessage);
begin
  pressed:=False;
  InvalidateRect(Handle, @rec, True);
  inherited;
end;

procedure TNForm.WMMOVE(var msg: TMessage);
var
  tmp: Boolean;
begin
  tmp:=focuslost;
  focuslost:=True;
  If tmp<>focuslost then
    InvalidateRect(Handle, @rec, True);
  inherited;
end;

procedure TNForm.WMNCMOUSEMOVE(var msg: TMessage);
var
  pt1: TPoint;
  tmp: Boolean;
begin
  tmp:=focuslost;
  pt1.X:=msg.LParamLo-Left;
  pt1.Y:=msg.LParamHi-Top;
  If not(PtInRect(rec, pt1)) then
    focuslost:=True
  Else
    focuslost:=False;
  If tmp<>focuslost then
    InvalidateRect(Handle, @rec, True);
end;

procedure TNForm.WNCLBUTTONDBLCLICK(var msg: TMessage);
var
  pt1: TPoint;
begin
  pt1.X:=msg.LParamLo-Left;
  pt1.Y:=msg.LParamHi-Top;
  If not(PtInRect(rec, pt1)) then
    inherited;
end;

procedure TNForm.WMNCMOUSEUP(var msg: TMessage);
var
  pt1: TPoint;
begin
  pt1.X:=msg.LParamLo-Left;
  pt1.Y:=msg.LParamHi-Top;
  If (PtInRect(rec, pt1)) and (focuslost=False) then
  Begin
    pressed:=False;
    {
      enter your code here when the button is clicked
    }
    InvalidateRect(Handle, @rec, True);
  End
  Else
  Begin
    pressed:=False;
    focuslost:=True;
    inherited;
  End;
end;

procedure TNForm.WMNCMOUSEDOWN(var msg: TMessage);
var
  pt1: TPoint;
begin
  pt1.X:=msg.LParamLo-Left;
  pt1.Y:=msg.LParamHi-Top;
  If PtInRect(rec, pt1) then
  Begin
    pressed:=True;
    InvalidateRect(Handle, @rec, True);
  End
  Else
  Begin
    Paint;
    inherited;
  End;
end;

procedure TNForm.WMNCACTIVATE(var msg: TMessage);
begin
  InvalidateRect(Handle, @rec, True);
  inherited;
end;

procedure TNForm.WMNCPAINT(var msg: TMessage);
begin
  InvalidateRect(Handle, @rec, True);
  inherited;
end;

procedure TNForm.FormPaint(Sender: TObject);
begin
  h1:=GetWindowDC(Handle);
  rec.Left:=Width-75;
  rec.Top:=6;
  rec.Right:=Width-60;
  rec.Bottom:=20;
  SelectObject(h1, GetStockObject(LTGRAY_BRUSH));
  Rectangle(h1, rec.Left, rec.Top, rec.Right, rec.Bottom);
  If (pressed=False) or (focuslost=True) then
    DrawEdge(h1, rec, EDGE_RAISED, BF_RECT)
  Else if (pressed=True) and (focuslost=False) then
    DrawEdge(h1, rec, EDGE_SUNKEN, BF_RECT);
  ReleaseDC(Handle, h1);
end;

procedure TNForm.FormResize(Sender: TObject);
begin
  Paint;
end;

procedure TNForm.FormCreate(Sender: TObject);
begin
  rec.Left:=0;
  rec.Top:=0;
  rec.Bottom:=0;
  rec.Right:=0;
end;

end.
