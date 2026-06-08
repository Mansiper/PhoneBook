unit uNForm;

interface

uses
  Windows, Buttons, Messages, Classes, Graphics, Forms;

type
  TNForm = class(TForm)
    procedure FormResize(Sender: TObject);
  private
    B4Down: Boolean;  //Дополнительная кнопка утоплена - было нажатие
    CaptionBtn: TRect;
    procedure DrawCaptButton;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPaint;
    procedure WMNCActivate(var Msg: TWMNCActivate); message WM_NCACTIVATE;
    procedure WMSetText(var Msg: TWMSetText); message WM_SETTEXT;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Msg: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCLButtonUp(var Msg: TWMNCLButtonUp); message WM_NCLBUTTONUP;
  public
    VysheVseh: Boolean; //True - приложение выше всех
    procedure Btn4Click(Down: Boolean);
  end;

implementation

const
  htCaptionBtn = htSizeLast+1;

procedure TNForm.DrawCaptButton;
var
  xFrame, yFrame, xSize, ySize: Integer;
  R: TRect;
begin
(*    //Dimensions of Sizeable Frame
  xFrame:=GetSystemMetrics(SM_CXFRAME);
  yFrame:=GetSystemMetrics(SM_CYFRAME);

    //Dimensions of Caption Buttons
  xSize:=GetSystemMetrics(SM_CXSIZE);
  ySize:=GetSystemMetrics(SM_CYSIZE);

    //Define the placement of the new caption button
  CaptionBtn:=Bounds(Width - xFrame - 4*xSize + 2,
                    yFrame + 1, xSize - 2, ySize - 4);

    //Get the handle to canvas using Form's device context
  Canvas.Handle:=GetWindowDC(Self.Handle);

  Canvas.Font.Name:='Verdana';
  Canvas.Font.Color:=clBlack;
  Canvas.Font.Style:=[fsBold];
  Canvas.Pen.Color:=clYellow;
  Canvas.Brush.Color:=clBtnFace;

  Try
    {if B4Down then
      DrawEdge(GetWindowDC(Self.Handle), CaptionBtn,
        EDGE_SUNKEN, BF_SOFT or BF_RECT)
    else
      DrawEdge(GetWindowDC(Self.Handle), CaptionBtn,
        EDGE_RAISED, BF_LEFT or BF_RECT);}

    if not B4Down then
      R:=Bounds(Width - xFrame - 4 * xSize + 4, yFrame + 3,
        xSize - 6, ySize - 8)
    else if B4Down then
      R:=Bounds(Width - xFrame - 4 * xSize + 5, yFrame + 4,
        xSize - 6, ySize - 8);

    DrawButtonFace(Canvas, CaptionBtn, 1, bsAutoDetect, False, B4Down, False);

      //Define a smaller drawing rectangle within the button
    with CaptionBtn do
      Canvas.TextRect(R, R.Left+2, R.Top-3, 'z');
  Finally
    ReleaseDC(Self.Handle, Canvas.Handle);
    Canvas.Handle := 0;
  End;*)
end;

procedure TNForm.WMNCPaint(var Msg : TWMNCPaint);
begin
  inherited;
  DrawCaptButton;
end;

procedure TNForm.WMNCActivate(var Msg : TWMNCActivate);
begin
  inherited;
  DrawCaptButton;
end;

procedure TNForm.WMSetText(var Msg: TWMSetText);
begin
  inherited;
  DrawCaptButton;
end;

procedure TNForm.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  With Msg do
    if PtInRect(CaptionBtn, Point(XPos - Left, YPos - Top)) then
      Result:=htCaptionBtn;
end;

procedure TNForm.WMNCLButtonDown(var Msg: TWMNCLButtonDown);
begin
  inherited;
  If (Msg.HitTest=htCaptionBtn) then
  Begin
  End;
end;

procedure TNForm.WMNCLButtonUp(var Msg: TWMNCLButtonUp);
begin
  inherited;
  If (Msg.HitTest=htCaptionBtn) then
  Begin
      //Было нажатие
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

    B4Down:=VysheVseh;
    DrawCaptButton;
  End;
end;

procedure TNForm.FormResize(Sender: TObject);
begin
    //Force a redraw of caption bar if form is resized
  Perform(WM_NCACTIVATE, Word(Active), 0);
end;

procedure TNForm.Btn4Click(Down: Boolean);
begin
  B4Down:=Down;
  DrawCaptButton;
end;

end.
