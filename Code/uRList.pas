(*
                            Двусвязный список.

    Список представляется в виде массива элементов (ячеек), проиндексированном
  слева направо, начиная с единицы.  
    Например, для массива [1, 2, 3, 4, 5] DeleteRight(3) - удалить справа от
  третьего будет означать удаление четвёртого элемента.
    Размер списка ограничен максимальным значением типа Cardinal или размером
  оперативной памяти вашего компьютера.

    Для включения модуля в свою программу просто добавьте в uses uRazList.

  ============================================================================

  Разбойников Павел (Mansiper)
  Россия, Екатеринбург, 2009.
  ManProger@mail.ru

  Приятного использования! ;)
*)
unit uRList;

interface

type
  PRListEl = ^TRListEl;
    //Элемент (ячейка) списка
  TRListEl = record
    Value: Array of String;
    pValue: Pointer;
    Prev: PRListEl; //Предыдущий элемент
    Next: PRListEl; //Следующий элемент
  end;

  TRazDList = class
  private
    FFirst, FLast: PRListEl;  //Первый и последний элементы списка
    FCount: Cardinal;         //Количество элементов

    function GetItem(Index: Cardinal): PRListEl;
    function GetNumber(Element: PRListEl): Cardinal;
  public
      //Количество элементов
    property Count: Cardinal read FCount default 0;
      //Первый элемент
    property First: PRListEl read FFirst default nil;
      //Последний элемент
    property Last: PRListEl read FLast default nil;
      //Элемент по номеру
    property Item[Index: Cardinal]: PRListEl read GetItem;
      //Номер элемента
    property Number[Element: PRListEl]: Cardinal read GetNumber;

    constructor Create;
    destructor Destroy; override;
      //Вставить в позицию (аналогично добавления слева)
    function Insert(Index: Cardinal): PRListEl; overload;
    //function Insert(Index: Cardinal; Value: Pointer): PRListEl; overload;
      //Добавить в конец
    function Add: PRListEl; overload;
    //function Add(Value: Pointer): PRListEl; overload;
      //Добавить слева (аналогично Insert)
    function AddLeft(Index: Cardinal): PRListEl; overload;
    //function AddLeft(Index: Cardinal; Value: Pointer): PRListEl; overload;
      //Добавить справа
    function AddRight(Index: Cardinal): PRListEl; overload;
    //function AddRight(Index: Cardinal; Value: Pointer): PRListEl; overload;
      //Удалить
    function Delete(Element: PRListEl): Boolean; overload;
    function Delete(Index: Cardinal): Boolean; overload;
      //Удалить слева
    function DeleteLeft(Index: Cardinal): Boolean;
      //Удалить справа
    function DeleteRight(Index: Cardinal): Boolean;
      //Заменить один элемент списка другим
    function Replace(SourEl, DestEl: PRListEl): PRListEl; overload;
    function Replace(SourIndex, DestIndex: Cardinal): Cardinal; overload;
      //Скопировать из одного элемента в другой
    function Copy(SourEl, DestEl: PRListEl): Boolean; overload;
    function Copy(SourIndex, DestIndex: Cardinal): Boolean; overload;
      //Поменять местами два элемента
    function Change(El1, El2: PRListEl): Boolean; overload;
    function Change(Index1, Index2: Cardinal): Boolean; overload;
      //Удалить все
    procedure Clear;
      //Пересчитать количество элементов
    function ReCalc: Cardinal;
  end;

implementation

//==============================================================================

constructor TRazDList.Create;
begin
  FCount:=0;
  FFirst:=nil;
  FLast:=nil;
end;

destructor TRazDList.Destroy;
begin
  Clear;
end;

//==================

function TRazDList.Insert(Index: Cardinal): PRListEl;
var
  Ptr, NPtr: PRListEl;
begin
  (* Вставляет новый элемент на место элемента под номером Index со сдвигом
    вправо *)

  If (Index<1) or (Index>FCount) or (FCount=0) then
  Begin
    Result:=nil;
    Exit;
  End;

  Ptr:=GetItem(Index);
    //Новый элемент
  Try
    New(NPtr);
  Except
    Result:=nil;
    Exit;
  End;
    //Переназначение ссылок
  NPtr^.Next:=Ptr;
  NPtr^.Prev:=Ptr^.Prev;
  Ptr^.Prev:=NPtr;
  If NPtr^.Prev=nil then
    FFirst:=NPtr
  Else
    NPtr^.Prev^.Next:=NPtr;

  Inc(FCount);
  Result:=NPtr;
end;

{function TRazDList.Insert(Index: Cardinal; Value: Pointer): PRListEl;
begin
  (* Аналогично Insert, но сразу же записывает необходимое значение *)

  Result:=Insert(Index);
  Result^.Value:=Value;
end;}

//==================

function TRazDList.Add: PRListEl;
var
  Ptr: PRListEl;
begin
  (* Вставляет новый элемент в конец *)

    //Новый элемент
  Try
    New(Ptr);
  Except
    Result:=nil;
    Exit;
  End;

    //Переназначение ссылок
  If FCount=0 then
  Begin
    FFirst:=Ptr;
    FLast:=Ptr;
    Ptr^.Prev:=nil;
    Ptr^.Next:=nil;
  End
  Else if FCount>0 then
  Begin
    FLast^.Next:=Ptr;
    Ptr^.Prev:=FLast;
    Ptr^.Next:=nil;
    FLast:=Ptr;
  End;

  Inc(FCount);
  Result:=Ptr;
end;

{function TRazDList.Add(Value: Pointer): PRListEl;
begin
  (* Аналогично Add, но сразу же записывает необходимое значение *)

  Result:=Add;
  Result^.Value:=Value;
end;}

function TRazDList.AddLeft(Index: Cardinal): PRListEl;
begin
  (* Вставляет новый элемент слева от элемента под номером Index *)

  Result:=Insert(Index);
end;

{function TRazDList.AddLeft(Index: Cardinal; Value: Pointer): PRListEl;
begin
  (* Аналогично AddLeft, но сразу же записывает необходимое значение *)

  Result:=AddLeft(Index);
  Result^.Value:=Value;
end;}

function TRazDList.AddRight(Index: Cardinal): PRListEl;
begin
  (* Вставляет новый элемент справа от элемента под номером Index *)

  Result:=Insert(Index+1);
end;

{function TRazDList.AddRight(Index: Cardinal; Value: Pointer): PRListEl;
begin
  (* Аналогично AddLeft, но сразу же записывает необходимое значение *)

  Result:=AddRight(Index);
  Result^.Value:=Value;
end;}

//==================

function TRazDList.Delete(Element: PRListEl): Boolean;
begin
  (* Удаляет указанный элемент *)

  If Element=nil then
  Begin
    Result:=False;
    Exit;
  End;

    //Переназначение ссылок
  If Element^.Prev=nil then
    FFirst:=Element^.Next
  Else
    Element^.Prev^.Next:=Element^.Next;

  If Element^.Next=nil then
    FLast:=Element^.Prev
  Else
    Element^.Next^.Prev:=Element^.Prev;

    //Удаление
  Dispose(Element);

  Dec(FCount);
  Result:=True;
end;

function TRazDList.Delete(Index: Cardinal): Boolean;
begin
  (* Удаляет элемент с позиции Index *)

  Result:=Delete(GetItem(Index));
end;

function TRazDList.DeleteLeft(Index: Cardinal): Boolean;
begin
  (* Удаляет элемент слева от позиции Index *)

  Result:=Delete(Index-1);
end;

function TRazDList.DeleteRight(Index: Cardinal): Boolean;
begin
  (* Удаляет элемент справа от позиции Index *)

  Result:=Delete(Index+1);
end;

//==================

function TRazDList.Replace(SourEl, DestEl: PRListEl): PRListEl;
var
  SourIndex, DestIndex: Cardinal;
begin
  (* Заменяет элемент DestEl списка элементом SourEl списка
    (DestEl удаляется со своей позиции) *)

  SourIndex:=GetNumber(SourEl);
  DestIndex:=GetNumber(DestEl);

  If (SourIndex>FCount) or (SourIndex<1) or (DestIndex>FCount) or
  (DestIndex<1) then
  Begin
    Result:=nil;
    Exit;
  End
  Else if SourIndex=DestIndex then
  Begin
    Result:=SourEl;
    Exit;
  End;

    //Элементы - соседи.
    //Аналогично простому удалению элемента с позиции DestIndex.
  If SourIndex-DestIndex=1 then
  Begin
    if not Delete(DestEl) then
      Result:=nil
    else Result:=SourEl;
  End
  Else if DestIndex-SourIndex=1 then
  Begin
    if not Delete(DestEl) then
      Result:=nil
    else Result:=SourEl;
  End
  Else  //Элементы - не соседи
  Begin
      //Новые связи перед изменением связей источника
    if SourEl^.Prev=nil then
      FFirst:=SourEl^.Next
    else
      SourEl^.Prev^.Next:=SourEl^.Next;

    if SourEl^.Next=nil then
      FLast:=SourEl^.Prev
    else
      SourEl^.Next^.Prev:=SourEl^.Prev;

      //Новые связи для источника и соседей старого элемента
    SourEl^.Next:=DestEl^.Next;
    SourEl^.Prev:=DestEl^.Prev;

    if DestEl^.Prev<>nil then
      DestEl^.Prev^.Next:=SourEl;
    if DestEl^.Next<>nil then
      DestEl^.Next^.Prev:=SourEl;

    if FFirst=DestEl then
      FFirst:=SourEl;
    if FLast=DestEl then
      FLast:=SourEl;

      //Удаление старого элемента
    Dispose(DestEl);
    Dec(FCount);

    Result:=SourEl;
  End;
end;

function TRazDList.Replace(SourIndex, DestIndex: Cardinal): Cardinal;
var
  SourEl, DestEl: PRListEl;
begin
  (* Заменяет элемент OldIndex элементом NewIndex по индексу внутри списка.
    Код этой функции почти повторяет код функции выше, но возвращаются иные
    значения и работает в отдельных случаях быстрее, чем
    Replace(GetItem(SourIndex), GetItem(DestIndex)); *)

  If (SourIndex>FCount) or (SourIndex<1) or (DestIndex>FCount) or
  (DestIndex<1) then
  Begin
    Result:=0;
    Exit;
  End
  Else if SourIndex=DestIndex then
  Begin
    Result:=DestIndex;
    Exit;
  End;

    //Элементы - соседи.
    //Аналогично простому удалению элемента с позиции DestIndex.
  If SourIndex-DestIndex=1 then       //Источник выше по списку
  Begin
    if not Delete(DestIndex) then
      Result:=0
    else Result:=DestIndex;
  End
  Else if DestIndex-SourIndex=1 then  //Источник ниже по списку
  Begin
    if not Delete(DestIndex) then
      Result:=0
    else Result:=DestIndex;
  End
  Else  //Элементы - не соседи
  Begin
    SourEl:=GetItem(SourIndex);
    DestEl:=GetItem(DestIndex);

      //Новые связи перед изменением связей источника
    if SourEl^.Prev=nil then
      FFirst:=SourEl^.Next
    else
      SourEl^.Prev^.Next:=SourEl^.Next;

    if SourEl^.Next=nil then
      FLast:=SourEl^.Prev
    else
      SourEl^.Next^.Prev:=SourEl^.Prev;

      //Новые связи для источника и соседей старого элемента
    SourEl^.Next:=DestEl^.Next;
    SourEl^.Prev:=DestEl^.Prev;

    if DestEl^.Prev<>nil then
      DestEl^.Prev^.Next:=SourEl;
    if DestEl^.Next<>nil then
      DestEl^.Next^.Prev:=SourEl;

    if FFirst=DestEl then
      FFirst:=SourEl;
    if FLast=DestEl then
      FLast:=SourEl;

      //Удаление старого элемента
    Dispose(DestEl);
    Dec(FCount);

    Result:=DestIndex;
  End;
end;

//==================

function TRazDList.Copy(SourEl, DestEl: PRListEl): Boolean;
begin
  (* Копирует только данные из элемента SourEl в элемент DestEl *)

  DestEl^.Value:=SourEl^.Value;
  Result:=True;
end;

function TRazDList.Copy(SourIndex, DestIndex: Cardinal): Boolean;
begin
  (* Копирует данные из элемента под номером SourIndex
    в элемент под номером DestIndex, НО НЕ ССЫЛКИ! *)
  Result:=Copy(GetItem(SourIndex), GetItem(DestIndex));
end;

//==================

function TRazDList.Change(El1, El2: PRListEl): Boolean;
var
  Ptr: PRListEl;
begin
  (* Меняет местами элементы El1 и El2 в списке.
    Значения элементов не меняются. *)

  {Try
    New(Ptr);
  Except
    Result:=nil;
    Exit;
  End;}

    //Меняю данные соседей
  If El1^.Prev=El2 then     //Если элементы - соседи друг другу
  Begin
    El1^.Prev:=El2^.Prev;
    if El1^.Next<>nil then
      El1^.Next^.Prev:=El2;
    if El2^.Prev<>nil then
      El2^.Prev^.Next:=El1;
    El2^.Next:=El1^.Next;
  End
  Else if El1^.Next=El2 then
  Begin
    El2^.Prev:=El1^.Prev;
    if El2^.Next<>nil then
      El2^.Next^.Prev:=El1;
    if El1^.Prev<>nil then
      El1^.Prev^.Next:=El2;
    El1^.Next:=El2^.Next;
  End
  Else                      //Если они не соседи
  Begin
    If El1^.Prev<>nil then El1^.Prev^.Next:=El2;
    If El1^.Next<>nil then El1^.Next^.Prev:=El2;
    If El2^.Prev<>nil then El2^.Prev^.Next:=El1;
    If El2^.Next<>nil then El2^.Next^.Prev:=El1;

      //Пузырьковый метод
    Ptr^.Prev:=El1^.Prev;
    Ptr^.Next:=El1^.Next;

    El1^.Prev:=El2^.Prev;
    El1^.Next:=El2^.Next;

    El2^.Prev:=Ptr^.Prev;
    El2^.Next:=Ptr^.Next;              
  End;//Else

  If El1^.Prev=nil then FFirst:=El1;
  If El1^.Next=nil then FLast:=El1;
  If El2^.Prev=nil then FFirst:=El2;
  If El2^.Next=nil then FLast:=El2;

  {Dispose(Ptr);}
  Result:=True;
end;

function TRazDList.Change(Index1, Index2: Cardinal): Boolean;
begin
  (* Меняет местами элементы под номерами Index1 и Index2.
    Значения элементов не меняются *)

  Result:=Change(GetItem(Index1), GetItem(Index2));
end;

//==================

procedure TRazDList.Clear;
var
  Second: PRListEl;
begin
  (* Удаляет все элементы *)

  If FCount=0 then Exit;

  Repeat
    Second:=FFirst^.Next;
    Dispose(FFirst);
    FFirst:=Second;
    Dec(FCount);
  Until FFirst=nil;
  FLast:=nil;
end;

function TRazDList.ReCalc: Cardinal;
var
  i: Cardinal;
  Ptr: PRListEl;
begin
  (* Пересчитывает количество элементов списка *)

  i:=1;
  Ptr:=FFirst;
  While Ptr<>FLast do
  Begin
    Ptr:=Ptr^.Next;
    Inc(i);
  End;
  FCount:=i;
  Result:=FCount;
end;

//==============================================================================

function TRazDList.GetItem(Index: Cardinal): PRListEl;
var
  i: Cardinal;
  Ptr: PRListEl;
begin
  (* Возвращает элемент с позиции Index *)

  If (Index<1) or (Index>FCount) then
  Begin
    Result:=nil;
    Exit;
  End;

  If (FCount >= 500) and (Index > FCount DIV 2) then  //Для ускорения поиска
  Begin
    Ptr:=FLast;
    for i:=FCount downto Index do
      Ptr:=Ptr^.Prev;
  End
  Else
  Begin
    Ptr:=FFirst;
    for i:=2 to Index do
      Ptr:=Ptr^.Next;
  End;

  Result:=Ptr;
end;

function TRazDList.GetNumber(Element: PRListEl): Cardinal;
var
  i: Cardinal;
  Ptr: PRListEl;
begin
  (* Возвращает позицию элемента Element *)

  i:=1;
  Ptr:=FFirst;
  While Ptr<>Element do
  Begin
    Ptr:=Ptr^.Next;
    Inc(i);
  End;

  If Ptr<>Element then
    Result:=0
  Else
    Result:=i;
end;

end.
