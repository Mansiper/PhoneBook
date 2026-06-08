(*
  Алгоритмом Определения Изменений Направления Движений Мыши = АОИНДМ = ДИНАМО

  Краткая (примерная) инструкция по работе:
  =========================================

    Подключите этот модуль к своей программе:
  uses uRazGestures;

    В главной форме объявите глобальную переменную типа TDINAMO, например:
  var Dinamo: TDINAMO;

    В событие OnCreate главной формы создайте экземпляр класса TDINAMO, например:
  Dinamo:=TDINAMO.Create(True);

    Для обработки горячих клавиш создавайте процедуры следующего вида:
  procedure <имя>(<переменная>: Integer);
    Для обработки нажатий клавиш мыши:
  function <имя>: Boolean;
    Для обрабоки жестов:
  procedure <имя>(<переменная 1>: TMouseButton; <переменная 2>: String);

  (примеры обработки смотрите в процедурах Do_Key и Do_Gesture)

    При обработке нажатий мыши возвращается значение типа Boolean:
  True - запрещает реакцию компонента на нажатие на нём кнопки мыши;
  False - разрешает реакцию компонента на нажатие на нём кнопки мыши.
    Реакция на нажатие средней кнопкой мыши зависит от драйверов мыши.

    Подключаются функции обработки через:
  Dinamo.On_<...>:=<имя соответствующей функции>;

                    !!! - означает, что не срабатывало у меня в Windows XP SP3

  ============================================================================

  Разбойников Павел (Mansiper)
  Россия, Екатеринбург, 2010.
  ManProger@mail.ru

  Приятного использования! ;)
*)

unit uRazGestures;

interface

uses uRListZh, Classes, Controls, SysUtils, Forms, Windows, Messages;

type
    //Чувствительность жеста к изменениям направления движения мыши
  TRazSensit = record
    Range: Byte;          //Диапазон
    Frequency: Cardinal;  //Частота
  end;

    //Возможные варианты кнопок мыши (взято из Controls и дополнено)
    //mbNone - поток прекращает отлавливать положения мыши
  TMsButton = (mbLeft, mbRight, mbMiddle, mbNone);

    //Событие для клавиатуры
  TKeyEventKb = procedure(Param: Integer);
    //Событие для мыши
  TKeyEventMs = function: Boolean;
    //Событие для обработки жестов
  TGestureEvent = procedure(Button: TMsButton; StrGest: String);

  TGestTrap = class;

  TDINAMO = class
  private
    FGestActive: Boolean;     //Включены/выключены жесты мыши
    FSensitivity: TRazSensit; //Чувствительность жестов
    FMsButton: TMsButton;     //Кнопка мыши для жестов

      //События для клавиатуры
    FOn_Key: TKeyEventKb;
    FOn_Ctrl_Key: TKeyEventKb;
    FOn_Shift_Key: TKeyEventKb;
    FOn_Alt_Key: TKeyEventKb;
    FOn_CtrlShift_Key: TKeyEventKb;
    FOn_CtrlAlt_Key: TKeyEventKb;
    FOn_ShiftAlt_Key: TKeyEventKb;
    FOn_CtrlShiftAlt_Key: TKeyEventKb;
      //События для мыши
    FOn_L_Button_Down: TKeyEventMs;
    FOn_L_Button_Up: TKeyEventMs;
    FOn_R_Button_Down: TKeyEventMs;
    FOn_R_Button_Up: TKeyEventMs;
    FOn_M_Button_Down: TKeyEventMs;
    FOn_M_Button_Up: TKeyEventMs;
      //Событие для обработки жестов
    FOn_Gesture: TGestureEvent;

    GestTrap: TGestTrap;  //Поток, высчитывающий жест (ловушка)

      //Обработка действий свойств
    procedure SetGestActive(Active: Boolean);
    procedure SetSensitivity(Sensit: TRazSensit);

      //Отлов сообщений приложения
    procedure AppMes(var Msg: TMsg; var Handled: Boolean);
  public
      //Включить/отключить жесты мыши
    property GestActive: Boolean read FGestActive write SetGestActive;
      //Чувствительность жестов
    property Sensitivity: TRazSensit read FSensitivity write SetSensitivity;
      //Кнопка мыши для жестов
    property MouseButton: TMsButton read FMsButton write FMsButton default mbRight;

      //События для клавиатуры
    property On_Key: TKeyEventKb read FOn_Key write FOn_Key;
    property On_Ctrl_Key: TKeyEventKb read FOn_Ctrl_Key write FOn_Ctrl_Key;
    property On_Shift_Key: TKeyEventKb read FOn_Shift_Key write FOn_Shift_Key;
    property On_Alt_Key: TKeyEventKb read FOn_Alt_Key write FOn_Alt_Key;
    property On_CtrlShift_Key: TKeyEventKb read FOn_CtrlShift_Key write FOn_CtrlShift_Key;
    property On_CtrlAlt_Key: TKeyEventKb read FOn_CtrlAlt_Key write FOn_CtrlAlt_Key;
    property On_ShiftAlt_Key: TKeyEventKb read FOn_ShiftAlt_Key write FOn_ShiftAlt_Key;
    property On_CtrlShiftAlt_Key: TKeyEventKb read FOn_CtrlShiftAlt_Key write FOn_CtrlShiftAlt_Key;
      //События для мыши
    property On_L_Button_Down: TKeyEventMs read FOn_L_Button_Down write FOn_L_Button_Down;
    property On_L_Button_Up: TKeyEventMs read FOn_L_Button_Up write FOn_L_Button_Up;
    property On_R_Button_Down: TKeyEventMs read FOn_R_Button_Down write FOn_R_Button_Down;
    property On_R_Button_Up: TKeyEventMs read FOn_R_Button_Up write FOn_R_Button_Up;
    property On_M_Button_Down: TKeyEventMs read FOn_M_Button_Down write FOn_M_Button_Down;
    property On_M_Button_Up: TKeyEventMs read FOn_M_Button_Up write FOn_M_Button_Up;
      //Событие для обработки жестов
    property On_Gesture: TGestureEvent read FOn_Gesture write FOn_Gesture;

    constructor Create(ActivateGestures: Boolean);
    destructor Destroy; override;
  protected
      //События для клавиатуры (обработчики горячих клавиш)
    procedure Do_Key(Param: Integer); dynamic;
    procedure Do_Ctrl_Key(Param: Integer); dynamic;
    procedure Do_Shift_Key(Param: Integer); dynamic;
    procedure Do_Alt_Key(Param: Integer); dynamic;
    procedure Do_CtrlShift_Key(Param: Integer); dynamic;
    procedure Do_CtrlAlt_Key(Param: Integer); dynamic;
    procedure Do_ShiftAlt_Key(Param: Integer); dynamic;
    procedure Do_CtrlShiftAlt_Key(Param: Integer); dynamic;
      //События для мыши (для пользователя при выключенных жестах)
    function Do_L_Button_Down: Boolean; dynamic;
    function Do_L_Button_Up: Boolean; dynamic;
    function Do_R_Button_Down: Boolean; dynamic;
    function Do_R_Button_Up: Boolean; dynamic;
    function Do_M_Button_Down: Boolean; dynamic;
    function Do_M_Button_Up: Boolean; dynamic;
      //Обработчик жестов мыши
    procedure Do_Gesture(Button: TMsButton; StrGest: String); dynamic;

      //Обработчик сообщений мыши (для жестов)
    function L_Button_Down: Boolean;
    function L_Button_Up: Boolean;
    function R_Button_Down: Boolean;
    function R_Button_Up: Boolean;
    function M_Button_Down: Boolean;
    function M_Button_Up: Boolean;
  end;

    (*
        В потоке отлавливается положение мыши, "рисуется" жест и распознаётся.
    *)
  TGestTrap = class(TThread)
  public
    DownTime: Cardinal;     //Время рисования жеста (удерживания мыши нажатой)
    ResultGest: TRazListZh; //Список направлений (конечный результат)

    constructor Create(CreateSuspended: Boolean);
  private
    MButton: TMsButton; //Используемая кнопка мыши
    OldP, NewP: TPoint; //Старая (предыдущая) и текущая точки
      //Чувствительность
    Freq: Cardinal; //Время между получениями координат (в милисекундах)
    Range: Byte;    //Диапазон точек для чувствительности жеста

    Pattern: TRazListZh;  //Список положений мыши для рисунка жеста

      //Точки представляю как вектор, определяю направление, записываю в ResultGest
    procedure DeCodingOnFly;
      //Конечная расшифровка списка ResultGest (удаление лишних значений)
    procedure DeCoding;
  protected
    procedure Execute; override;
  end;

const
    //Сообщения потоку и приложению
  LVK_STOP   = WM_USER+1001;  //Отключить жесты
  LVK_START  = WM_USER+1002;  //Начало рисования жеста
  LVK_FINISH = WM_USER+1003;  //Окончание рисования жеста
  LVK_READY  = WM_USER+1004;  //Жест расшифрован по направлениям (для приложения)
  LVK_SENSIT = WM_USER+1005;  //Установка чувствительности жеста

implementation

//==============================================================================
//__________________________________ДИНАМО______________________________________
//==============================================================================

constructor TDINAMO.Create(ActivateGestures: Boolean);
begin
    //По своему опыту это наиболее удобная чувствительность
  FSensitivity.Range:=20;
  FSensitivity.Frequency:=25;
  FMsButton:=mbRight;
  FGestActive:=ActivateGestures;

  GestTrap:=TGestTrap.Create(not ActivateGestures);
  GestTrap.Priority:=tpNormal;
  GestTrap.FreeOnTerminate:=True;

    //Все сообщения приложения будут проходить через функцию AppMes
  Application.OnMessage:=AppMes;
end;

destructor TDINAMO.Destroy;
begin
  Application.OnMessage:=nil;
  GestTrap.Terminate;
end;

//==============================================================================
//__________________________________ДИНАМО______________________________________
//==============================================================================

procedure TDINAMO.SetGestActive(Active: Boolean);
begin
    (* Включаем/отключаем жесты (горячие комбинации остаются) *)

  If Active<>FGestActive then
  Begin
    FGestActive:=Active;
    if not FGestActive then
      PostThreadMessage(GestTrap.ThreadID, LVK_STOP, 0, 0)
    else //if FGestActive then
      GestTrap.Resume;
  End;
end;

procedure TDINAMO.SetSensitivity(Sensit: TRazSensit);
begin
    (* Изменение чувствительности *)

  (*
      Частота (желательно): 25-100. Период времени в милисекундах, через
    которое алгоритм распознаёт направление движения мыши. Чем ниже число, тем
    больше точек при движении мыши будет получено.
      Диапазон (желательно): 0-50. Расстояние в точках (пикселях), на которое
    может сместиться курсор (при рисовании жеста), но это не будет зафиксировано
    как смена направления движения мыши.
  *)

  If (Sensit.Range<>FSensitivity.Range) or
  (Sensit.Frequency<>FSensitivity.Frequency) then
  Begin
    FSensitivity:=Sensit;
    PostThreadMessage(GestTrap.ThreadID, LVK_SENSIT,
      Sensit.Frequency, Sensit.Range);
  End;
end;

//____________________________Отлов_сообщений___________________________________
//==============================================================================

procedure TDINAMO.AppMes(var Msg: TMsg; var Handled: Boolean);
var
  Ctrl, Shift, Alt: SHORT;
  i: Word;
  Str: String;
begin
    (* Обработка сообщений приложения *)

  Handled:=False;

    //Если нажата клавиша, то ...

  {If Msg.message=TWMNCHitTest then
  Begin                    HTCAPTION MOUSEHOOKSTRUCT
    Handled:=True;
    Exit;
  End;}
  If Msg.message=WM_KEYDOWN then
  Begin
      //Получаю состояния клавиш Ctrl, Shift и Alt
    Ctrl  :=  GetKeyState(VK_CONTROL);
    Shift :=  GetKeyState(VK_SHIFT);
    Alt   :=  GetKeyState(VK_MENU);

      //Если нажата клавиша БЕЗ Ctrl, Shift и Alt, то ...
    if (Ctrl>=0) and (Shift>=0) and (Alt>=0) then
      Do_Key(Msg.wParam)

      //Если нажата клавиша с Ctrl, то ...
    else if (Ctrl<0) and (Shift>=0) and (Alt>=0) then
      Do_Ctrl_Key(Msg.wParam)

      //Если нажата клавиша с Shift, то ...
    else if (Ctrl>=0) and(Shift<0) and (Alt>=0) then
      Do_Shift_Key(Msg.wParam)

      //Если нажата клавиша с Alt, то ...
    else if (Ctrl>=0) and (Shift>=0) and (Alt<0) then
      Do_Alt_Key(Msg.wParam)

      //Если нажата клавиша с Ctrl и Shift, то ...
    else if (Ctrl<0) and (Shift<0) and (Alt>=0) then
      Do_CtrlShift_Key(Msg.wParam)

      //Если нажата клавиша с Ctrl и Alt, то ...
    else if (Ctrl<0) and (Shift>=0) and (Alt<0) then
      Do_CtrlAlt_Key(Msg.wParam)

      //Если нажата клавиша с Shift и Alt, то ...
    else if (Ctrl>=0) and (Shift<0) and (Alt<0) then
      Do_ShiftAlt_Key(Msg.wParam)

      //Если нажата клавиша с Ctrl, Shift и Alt, то ...
    else if (Ctrl<0) and (Shift<0) and (Alt<0) then
      Do_CtrlShiftAlt_Key(Msg.wParam)

  End//If Msg.message=WM_KEYDOWN then

  //Ниже проверка сообщений мыши для работы жестов

    //Если нажали на ЛЕВУЮ
  Else if Msg.message=WM_LBUTTONDOWN then
    Handled:=L_Button_Down

    //Если отпустили ЛЕВУЮ
  Else if Msg.message=WM_LBUTTONUP then
    Handled:=L_Button_Up

    //Если нажали на ПРАВУЮ
  Else if Msg.message=WM_RBUTTONDOWN then
    Handled:=R_Button_Down

    //Если отпустили ПРАВУЮ
  Else if Msg.message=WM_RBUTTONUP then
    Handled:=R_Button_Up

    //Если нажали на СРЕДНЮЮ
  Else if Msg.message=WM_RBUTTONDOWN then
    Handled:=M_Button_Down

    //Если отпустили СРЕДНЮЮ
  Else if Msg.message=WM_RBUTTONUP then
    Handled:=M_Button_Up

    //Перехват сообщения о завершении расшифровки жеста
  Else if Msg.message=LVK_READY then
  Begin
      //Получение жеста в строковом виде
    Str:='';
    for i:=1 to GestTrap.ResultGest.Count do
      Str:=Str+IntToStr(GestTrap.ResultGest.Item[i]^.Value);

      //Обработка жеста
    Do_Gesture(FMsButton, Str);
      //Снимаю фокус со всех компонентов, а то глюки вылазят
    ReleaseCapture;
  End;
end;

//________________________Функции_обработки_действий____________________________
//==============================================================================

procedure TDINAMO.Do_Key(Param: Integer);
begin
    (* Ctrl, Shift и Alt не нажаты *)
  If Assigned(FOn_Key) then FOn_Key(Param);

  { Пример:

  If Form1.Active then
    case <переменная типа Integer> of //в переменной будет код нажатой клавиши
      VK_ESCAPE:
        <какие-то действия 1>;
      Ord('Z'), Ord('Я'):             //используйте именно заглавные буквы
        <какие-то действия 2>;
    end;//case
  }
end;

procedure TDINAMO.Do_Ctrl_Key(Param: Integer);
begin
    (* Ctrl нажата, Shift и Alt не нажаты *)
  If Assigned(FOn_Ctrl_Key) then FOn_Ctrl_Key(Param);
end;

procedure TDINAMO.Do_Shift_Key(Param: Integer);
begin
    (* Shift нажата, Ctrl и Alt не нажаты *)
  If Assigned(FOn_Shift_Key) then FOn_Shift_Key(Param);
end;

procedure TDINAMO.Do_Alt_Key(Param: Integer);
begin
    (* Alt нажата, Ctrl и Shift не нажаты *)//              !!!
  If Assigned(FOn_Alt_Key) then FOn_Alt_Key(Param);
end;

procedure TDINAMO.Do_CtrlShift_Key(Param: Integer);
begin
    (* Ctrl и Shift нажаты, Alt не нажата *)//              !!!
  If Assigned(FOn_CtrlShift_Key) then FOn_CtrlShift_Key(Param);
end;

procedure TDINAMO.Do_CtrlAlt_Key(Param: Integer);
begin
    (* Ctrl и Alt нажаты, Shift не нажата *)
  If Assigned(FOn_CtrlAlt_Key) then FOn_CtrlAlt_Key(Param);
end;

procedure TDINAMO.Do_ShiftAlt_Key(Param: Integer);
begin
    (* Shift и Alt нажаты, Ctrl не нажата *)//              !!!
  If Assigned(FOn_ShiftAlt_Key) then FOn_ShiftAlt_Key(Param);
end;

procedure TDINAMO.Do_CtrlShiftAlt_Key(Param: Integer);
begin
    (* Ctrl, Shift и Alt нажаты *)
  If Assigned(FOn_CtrlShiftAlt_Key) then FOn_CtrlShiftAlt_Key(Param);
end;

function TDINAMO.Do_L_Button_Down: Boolean;
begin
    (* "Отлов" нажатия левой кнопки мыши *)
  If Assigned(FOn_L_Button_Down) then Result:=FOn_L_Button_Down
  Else Result:=False;
end;

function TDINAMO.Do_L_Button_Up: Boolean;
begin
    (* "Отлов" отпускания левой кнопки мыши *)
  If Assigned(FOn_L_Button_Up) then Result:=FOn_L_Button_Up
  Else Result:=False;
end;

function TDINAMO.Do_R_Button_Down: Boolean;
begin
    (* "Отлов" нажатия правой кнопки мыши *)
  If Assigned(FOn_R_Button_Down) then Result:=FOn_R_Button_Down
  Else Result:=False;
end;

function TDINAMO.Do_R_Button_Up: Boolean;
begin
    (* "Отлов" отпускания правой кнопки мыши *)
  If Assigned(FOn_R_Button_Up) then Result:=FOn_R_Button_Up
  Else Result:=False;
end;

function TDINAMO.Do_M_Button_Down: Boolean;
begin
    (* "Отлов" нажатия средней кнопки мыши *)
  If Assigned(FOn_M_Button_Down) then Result:=FOn_M_Button_Down
  Else Result:=False;
end;

function TDINAMO.Do_M_Button_Up: Boolean;
begin
    (* "Отлов" отпускания средней кнопки мыши *)
  If Assigned(FOn_M_Button_Up) then Result:=FOn_M_Button_Up
  Else Result:=False;
end;

procedure TDINAMO.Do_Gesture(Button: TMsButton; StrGest: String);
begin
    (* Обработка жестов мыши *)
  If Assigned(FOn_Gesture) then FOn_Gesture(Button, StrGest);

  { Пример:

  If <переменная типа TMouseButton>=mbRight then  //Если нажата правая клавиша
  Begin
    if fGlav.Active then
    begin

      //1 - вверх, 2 - вправо, 3 - вниз, 4 - влево

      if <переменная типа String>='3214' then   //движение по кругу против часовой
        <какие-то дейсвия 1>
      else if <переменная типа String>='42' then  //движение влево-вправо
        <какие-то дейсвия 2>;

    end;//if fGlav.Active then
  End;//If <переменная типа TMouseButton>=mbRight then
  }
end;

//===========================================

function TDINAMO.L_Button_Down: Boolean;
begin
    (* "Отлов" нажатия левой кнопки мыши *)

  Result:=False;
  If FGestActive and (FMsButton=mbLeft) then
    PostThreadMessage(GestTrap.ThreadID, LVK_START, 0, Byte(FMsButton))
  Else
    Result:=Do_L_Button_Down;
end;

function TDINAMO.L_Button_Up: Boolean;
begin
    (* "Отлов" отпускания левой кнопки мыши *)

  Result:=False;
  If FGestActive and (FMsButton=mbLeft) then
  Begin
    GestTrap.DownTime:=GetTickCount-GestTrap.DownTime;
      //Если держали кнопку больше 30 мс и двигали, то ...
    if (GestTrap.DownTime>30) and (GestTrap.ResultGest.Count>1) then
    begin
      PostThreadMessage(GestTrap.ThreadID, LVK_FINISH, 0, 0);
        //Запрещаю реакцию компонента под мышью на сообщение
      Result:=True;
    end;
  End
  Else
    Result:=Do_L_Button_Up;
end;

function TDINAMO.R_Button_Down: Boolean;
begin
    (* "Отлов" нажатия правой кнопки мыши *)

  Result:=False;
  If FGestActive and (FMsButton=mbRight) then
    PostThreadMessage(GestTrap.ThreadID, LVK_START, 0, Byte(FMsButton))
  Else
    Result:=Do_R_Button_Down;
end;

function TDINAMO.R_Button_Up: Boolean;
begin
    (* "Отлов" отпускания правой кнопки мыши *)

  Result:=False;
  If FGestActive and (FMsButton=mbRight) then
  Begin
    GestTrap.DownTime:=GetTickCount-GestTrap.DownTime;
      //Если держали кнопку больше 30 мс и двигали, то ...
    if (GestTrap.DownTime>30) and (GestTrap.ResultGest.Count>1) then
    begin
      PostThreadMessage(GestTrap.ThreadID, LVK_FINISH, 0, 0);
        //Запрещаю реакцию компонента под мышью на сообщение
      Result:=True;
    end;
  End
  Else
    Result:=Do_R_Button_Up;
end;

function TDINAMO.M_Button_Down: Boolean;
begin
    (* "Отлов" нажатия средней кнопки мыши *)//           !!!

  Result:=False;
  If FGestActive and (FMsButton=mbMiddle) then
    PostThreadMessage(GestTrap.ThreadID, LVK_START, 0, Byte(FMsButton))
  Else
    Result:=Do_M_Button_Down;
end;

function TDINAMO.M_Button_Up: Boolean;
begin
    (* "Отлов" отпускания средней кнопки мыши *)//        !!!

  Result:=False;
  If FGestActive and (FMsButton=mbMiddle) then
  Begin
    GestTrap.DownTime:=GetTickCount-GestTrap.DownTime;
      //Если держали кнопку больше 30 мс и двигали, то ...
    if (GestTrap.DownTime>30) and (GestTrap.ResultGest.Count>1) then
    begin
      PostThreadMessage(GestTrap.ThreadID, LVK_FINISH, 0, 0);
        //Запрещаю реакцию компонента под мышью на сообщение
      Result:=True;
    end;
  End
  Else
    Result:=Do_M_Button_Up;
end;

//==============================================================================
//__________________________________Ловушка_____________________________________
//==============================================================================

constructor TGestTrap.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
    //По своему опыту наиболее удобная чувствительность
  Freq:=25;
  Range:=20;
end;

procedure TGestTrap.Execute;
var
  Start: Boolean; //Нужна для "ловли" начальной точки
  TMS: tagMSG;    //Для сообщения
begin
    (* Отлов положения мыши *)

    //Назначаю начальные значения
  MButton:=mbNone;
  Start:=False;
    //Создаю списки
  ResultGest:=TRazListZh.Create;
  Pattern:=TRazListZh.Create;

  WHILE not Terminated DO
  BEGIN

      //Проверка наличия необходимого сообщения в очереди сообщений потоку
    If PeekMessage(TMS, 0, 0, 0, PM_REMOVE) then
    Begin
      case TMS.message of

        LVK_STOP:     begin                           //Жесты отключены
                        MButton:=mbNone;
                        Suspend;
                      end;

        LVK_START:    begin                           //Начало жеста
                        MButton:=TMsButton(TMS.lParam);   //жесты включены
                        ResultGest.Clear;
                        Pattern.Clear;
                        Start:=True;
                          //На случай, если было простое нажатие, а не жест
                        DownTime:=GetTickCount;
                      end;

        LVK_FINISH:   begin                           //Конец жеста
                          //Если было не простое нажатие, а жест
                        if (ResultGest.Count>2) and (DownTime>=100) then
                          DeCoding;
                        MButton:=mbNone;
                      end;

        LVK_SENSIT:   begin                           //Чувствительность жестов
                        Freq:=TMS.wParam;
                        Range:=TMS.lParam;
                      end;

      end;//case
    End;//If PeekMessage(TMS, 0, 0, 0, PM_REMOVE) then

      //Считывание данных мыши для жестов
    If MButton<>mbNone then
    Begin
      if not Start then
      begin
        GetCursorPos(NewP);
          //Оталавливаю только изменения положения мыши
        if ( (NewP.X<>OldP.X) or (NewP.Y<>OldP.Y) ) AND
        (Pattern.Count<1000) then //Вдруг кто уснёт на мышке и будет ворочаться во сне...
        begin
          Pattern.Add^.Pnt:=NewP;
          DeCodingOnFly;
          OldP:=NewP;
        end;
      end
      else //if Start then    //"Ловлю" начальную точку. Все остальные выше
      begin
        GetCursorPos(OldP);
        Pattern.Add^.Pnt:=OldP;
        Start:=False;
      end;
    End;

      //Пауза
    Sleep(Freq);

  END;//WHILE not Terminated DO
end;

//____________________________Функции_ловушки___________________________________
//==============================================================================

procedure TGestTrap.DeCodingOnFly;
const
    //Числовые значения направлений в ResultGest:
  dUp = 1;
  dRight = 2;
  dDown = 3;
  dLeft = 4;
    //для диагоналей
  (* dRightUp = 5;  dRightDown = 6;  dLedtDown = 7;  dLeftUp = 8; *)
var
  Res: Byte;  //Текущий результат
  Pr: TPoint; //Проекция конца вектора на ось (прямой угол треугольника)
begin
  (*  Расшифровка направления вектора между двумя последними точками.
    Запись резульатата в ResultGest.
  *)

  If ResultGest.Count>=1000 then Exit;

  If NewP.X=OldP.X then        //Вертикаль
  Begin
    if NewP.Y>OldP.Y then        //вниз
      Res:=dDown
    else //if NewP.Y<OldP.Y then //вверх
      Res:=dUp;
  End
  Else if NewP.Y=OldP.Y then   //Горизонталь
  Begin
    if NewP.X>OldP.X then        //вправо
      Res:=dRight
    else //if NewP.X<OldP.X then //влево
      Res:=dLeft;
  End

    (*  Ежели будет желание использовать диагонали в жестах (код ниже),
      то знайте: уменьшится точность срабатывания жеста.
    *)

  Else if Abs(NewP.X-OldP.X)>=Abs(NewP.Y-OldP.Y) then   //Проекция вектора на X
  Begin
      //Получение точки проекции конца вектора на X
    Pr.X:=NewP.X;
    Pr.Y:=OldP.Y;

    if Pr.X>OldP.X then         //вправо
      Res:=dRight
    else //if Pr.X<OldP.X then  //влево
      Res:=dLeft;

    (*         ---=== Код для диагоналей (проверено) ===---
    В uses добавьте модуль Math.
    В переменные процедуры добавьте:
      angle: Extended;  //Полученный угол наклона вектора

        //Расчёт угла (по формуле тангенса угла прямоугольного прямоугольника)
      angle:=ArcTan2(Abs(NewP.Y-Pr.Y), Abs(Pr.X-OldP.X));
      angle:=RadToGrad(angle);

    Вместо условий выше используйте эти условия:

      if angle<=22.5 then       //Горизонталь
      begin
        if Pr.X>OldP.X then         //вправо
          Res:=dRight
        else //if Pr.X<OldP.X then  //влево
          Res:=dLeft;
      end
      else if angle>22.5 then   //Диагонали
      begin
        if (Pr.X>OldP.X) and (Pr.Y>NewP.Y) then      //вправо вверх
          Res:=dRightUp
        else if (Pr.X>OldP.X) and (Pr.Y<NewP.Y) then //вправо вниз
          Res:=dRightDown
        else if (Pr.X<OldP.X) and (Pr.Y<NewP.Y) then //влево вниз
          Res:=dLeftDown
        else if (Pr.X<OldP.X) and (Pr.Y>NewP.Y) then //влево вверх
          Res:=dLeftUp;
      end;

    Раскомментируйте закоментированные константы.
    *)
  End//Проекция вектора на X

  Else //if Abs(NewP.X-OldP.X)<Abs(NewP.Y-OldP.Y) then  //Проекция вектора на Y
  Begin
      //Получение точки проекции конца вектора на Y
    Pr.Y:=NewP.Y;
    Pr.X:=OldP.X;

    if Pr.Y>OldP.Y then         //вниз
      Res:=dDown
    else //if Pr.Y<OldP.Y then  //вверх
      Res:=dUp;

    (*         ---=== Код для диагоналей (проверено) ===---
    В uses добавьте модуль Math.
    В переменные процедуры добавьте:
      angle: Extended;  //Полученный угол наклона вектора

        //Расчёт угла (по формуле тангенса угла прямоугольного прямоугольника)
      angle:=ArcTan2(Abs(NewP.X-Pr.X), Abs(Pr.Y-OldP.Y));
      angle:=RadToGrad(angle);

    Вместо условий выше используйте эти условия:

      if angle<=22.5 then       //Вертикаль
      begin
        if Pr.Y>OldP.Y then         //вниз
          Res:=dDown
        else //if Pr.Y<OldP.Y then  //вверх
          Res:=dUp;
      end
      else if angle>22.5 then   //Диагонали
      begin
        if (Pr.Y<OldP.Y) and (Pr.X<NewP.X) then      //вправо вверх
          Res:=dRightUp
        else if (Pr.Y>OldP.Y) and (Pr.X<NewP.X) then //вправо вниз
          Res:=dRightDown
        else if (Pr.Y>OldP.Y) and (Pr.X>NewP.X) then //влево вниз
          Res:=dLeftDown
        else if (Pr.Y<OldP.Y) and (Pr.X>NewP.X) then //влево вверх
          Res:=dLeftUp;
      end;

    Раскомментируйте закоментированные константы.
    *)
  End;//Проекция вектора на Y

    //Сохранение результата
  ResultGest.Add^.Value:=Res;
end;

procedure TGestTrap.DeCoding;
var
  Del: Boolean; //True - было удаление элемента
  SD: Byte;   //Начальное направление
  i: Word;    //Номер текущего проверяемого значения ResultGest
  j: Word;    //Счётчик для отметания повторяющихся значений
begin
  //Фильтрует вектора по чувствительности и удаляет повторяющиеся значения

  Del:=False;
  i:=2;

  IF (Freq=0) and (Range=0) THEN            //Сверхчувствительность
  BEGIN

    While True do
    Begin
      if ResultGest.Item[i]^.Value=ResultGest.Item[i-1]^.Value then
        ResultGest.Delete(i)
      else Inc(i);
      if ResultGest.Item[i-1]=ResultGest.Last then Break;
    End;

  END                                       //---------------------

  ELSE //IF (Freq<>0) or (Range<>0) THEN
  BEGIN
    SD:=0;

      //Определение начального направления
    If (ResultGest.Item[1]^.Value=ResultGest.Item[2]^.Value) or
    (ResultGest.Item[1]^.Value=ResultGest.Item[3]^.Value) then
      SD:=ResultGest.Item[1]^.Value
    Else if ResultGest.Item[2]^.Value=ResultGest.Item[3]^.Value then
      SD:=ResultGest.Item[2]^.Value;

    If (ResultGest.Item[1]^.Value<>SD) and (SD<>0) then
    Begin
      ResultGest.Delete(1);
      Pattern.Delete(1);
    End;

      //Очистка списка от лишних значений
    While True do
    Begin
      if ResultGest.Count=1 then Break;

        //Удаляю повторяющиеся значения
      if ResultGest.Item[i]^.Value=ResultGest.Item[i-1]^.Value then
      begin
        ResultGest.Delete(i);
        Pattern.Delete(i);

        if ResultGest.Item[i-1]=ResultGest.Last then Break;
      end
        //Если сменилось направление, то ...
      else //if ResultGest.Item[i]^.DownTime<>ResultGest.Item[i-1]^.Value then
      begin
          //Если не в конце списка и следующее значение равно текущему, то ...
        if (i<ResultGest.Count) and
        (ResultGest.Item[i+1]^.Value=ResultGest.Item[i]^.Value) then
        begin
          j:=i+1;
            //Удаляю повторяющиеся значения нового направления
          while j<=ResultGest.Count do
          begin
            if ResultGest.Item[j]^.Value<>ResultGest.Item[i]^.Value then
              Break
            else //if ResultGest.Item[j]^.Value=ResultGest.Item[i]^.Value then
            begin
              ResultGest.Delete(j);
              Pattern.Delete(j);
            end;
          end;

            //Если диапазон между крайними значениями нового направления меньше
          //установленного диапазона по чувствительности, то удаляю как лишний элемент
          case ResultGest.Item[i]^.Value of
            1, 3: if Abs(Pattern.Item[j]^.Pnt.Y-Pattern.Item[i]^.Pnt.Y)<Range then
                    Del:=ResultGest.Delete(i);
            2, 4: if Abs(Pattern.Item[j]^.Pnt.X-Pattern.Item[i]^.Pnt.X)<Range then
                    Del:=ResultGest.Delete(i);
          end;
        end

          //Если не в конце списка и следующее значение НЕ равно текущему, то ...
        else if (i<ResultGest.Count) and
        (ResultGest.Item[i+1]^.Value<>ResultGest.Item[i]^.Value) then
        begin
            //Если диапазон между крайним значениеми меньше установленного
          //диапазона по чувствительности, то удаляю как лишний элемент
          case ResultGest.Item[i]^.Value of
            1, 3: if Abs(Pattern.Item[i+1]^.Pnt.Y-Pattern.Item[i]^.Pnt.Y)<Range then
                    Del:=ResultGest.Delete(i);
            2, 4: if Abs(Pattern.Item[i+1]^.Pnt.X-Pattern.Item[i]^.Pnt.X)<Range then
                    Del:=ResultGest.Delete(i);
          end;
        end

          //Если дошли до конца списка
        else if i=ResultGest.Count then
        begin
            //Если диапазон между крайним значениеми меньше установленного
          //диапазона по чувствительности, то удаляю как лишний элемент
          case ResultGest.Item[i]^.Value of
            1, 3: if Abs(Pattern.Item[i+1]^.Pnt.Y-Pattern.Item[i]^.Pnt.Y)<Range then
                    Del:=ResultGest.Delete(i);
            2, 4: if Abs(Pattern.Item[i+1]^.Pnt.X-Pattern.Item[i]^.Pnt.X)<Range then
                    Del:=ResultGest.Delete(i);
          end;
        end;

        if (ResultGest.Item[i-1]=ResultGest.Last) or
           (ResultGest.Item[i]=ResultGest.Last) then
          Break;
          (*  Если не было удаления из-за диапазона, меньше установленного,
          то можно переходить к следующему элементу *)
        If not Del then
          Inc(i);
        Del:=False;

      end;//Если сменилось направление, то ...
    End;//While True do                           

  END;

    (*  Посылаю сообщение программе о завершении расшифровки
      (отлов происходит в процедуре TDINAMO.AppMes) *)
  PostMessage(Application.Handle, LVK_READY, 0, 0);
end;

end.
