unit wagon;

interface
uses Graphics, SysUtils, Types, map;

type TWagon = class
  private
    Bitmaps: array [0..7] of TBitmap;
    filenamePrefix: string;
    currentDirection: Shortint;
    oldDirection: Shortint;
    SavedBitmap: TBitmap;
    x,y:integer;
    x_old,y_old:integer;
    function GetBitmap:TBitmap;
    function GetSavedBitmap:TBitmap;
  public
    constructor Create(x,y:integer; prefix:string; direction:shortInt);
    destructor Destroy;
    procedure setDirection(direction:Shortint);
    procedure Move(Map:TMap);
    procedure Draw(curCanvas:TCanvas);
    function GetX:integer;
    function GetY:integer;
    function GetX_old:integer;
    function GetY_old:integer;
    function ConvertDirection(direction, mapDirection:shortInt):shortInt;
end;

implementation

constructor TWagon.Create(x,y:integer; prefix:string; direction:shortInt);
var i:integer;
begin
  self.filenamePrefix := prefix;

  for i:=0 to 7 do
    begin
      self.Bitmaps[i] := TBitmap.Create;
      self.Bitmaps[i].LoadFromResourceName(HInstance, self.filenamePrefix+IntToStr(i));
      self.Bitmaps[i].Transparent := true;
      self.Bitmaps[i].TransparentColor := clWhite;
    end;

  self.SavedBitmap := TBitmap.Create;

  self.x := x;
  self.y := y;
  self.x_old := x;
  self.y_old := y;

  self.currentDirection := direction;
end;

destructor Twagon.Destroy;
var i:integer;
begin
  for i:=0 to 7 do
    self.Bitmaps[i].Free;
  self.SavedBitmap.Free;
end;

procedure Twagon.setDirection(direction:Shortint);
begin
  self.currentDirection := direction;
end;

procedure Twagon.Move(Map:TMap);
var
  mapDirection, newMapDirection, newDirection:ShortInt;
  x_new, y_new:integer;
begin
  self.x_old := self.x;
  self.y_old := self.y;
  self.oldDirection := self.currentDirection;

  mapDirection := Map.GetDirection(self.x, self.y);
  newDirection:=ConvertDirection(self.currentDirection, mapDirection);

  x_new := self.x;
  y_new := self.y;
  case newDirection of
  0:
    begin
      x_new:=self.x-1;
    end;
  1:
    begin
      x_new:=self.x-1;
      y_new:=self.y-1;
    end;
  2:
    begin
      y_new:=self.y-1;
    end;
  3:
    begin
      x_new:=self.x+1;
      y_new:=self.y-1;
    end;
  4:
    begin
      x_new:=self.x+1;
    end;
  5:
    begin
      x_new:=self.x+1;
      y_new:=self.y+1;
    end;
  6:
    begin
      y_new:=self.y+1;
    end;
  7:
    begin
      x_new:=self.x-1;
      y_new:=self.y+1;
    end;
  end;

  newMapDirection := Map.GetDirection(x_new, y_new);
  if((mapDirection <= 1) and (newMapDirection >= 2)) then
    newDirection:=ConvertDirection(self.currentDirection, mapDirection)
  else
  if((mapDirection >= 2) and (newMapDirection <= 1)) then
      newDirection:=ConvertDirection(self.currentDirection, newMapDirection)
  else
  if(mapDirection = newMapDirection ) then
    begin
      if mapDirection >= 2 then
        begin
        if Map.IsHorizontalBorder(self.x, self.y, self.currentDirection) then
          newDirection := ConvertDirection(self.currentDirection, 1)
        else if Map.IsVerticalBorder(self.x, self.y, self.currentDirection) then
          newDirection := ConvertDirection(self.currentDirection, 0);
        end
      else
        newDirection:=ConvertDirection(self.currentDirection, mapDirection);
    end;

  self.currentDirection := newDirection;
  case newDirection of
  0:
    begin
      self.x:=self.x-1;
    end;
  1:
    begin
      self.x:=self.x-1;
      self.y:=self.y-1;
    end;
  2:
    begin
      self.y:=self.y-1;
    end;
  3:
    begin
      self.x:=self.x+1;
      self.y:=self.y-1;
    end;
  4:
    begin
      self.x:=self.x+1;
    end;
  5:
    begin
      self.x:=self.x+1;
      self.y:=self.y+1;
    end;
  6:
    begin
      self.y:=self.y+1;
    end;
  7:
    begin
      self.x:=self.x-1;
      self.y:=self.y+1;
    end;
  end;

end;

function Twagon.GetX:integer;
begin
  GetX := self.x;
end;

function Twagon.GetY:integer;
begin
  GetY := self.y;
end;

function Twagon.GetX_old:integer;
begin
  GetX_old := self.x_old;
end;

function Twagon.GetY_old:integer;
begin
  GetY_old := self.y_old;
end;

function Twagon.GetBitmap:TBitmap;
begin
  if self.currentDirection >= 0 then
    GetBitmap := self.Bitmaps[self.currentDirection]
  else
    GetBitmap := self.Bitmaps[0];
end;

function Twagon.GetSavedBitmap:TBitmap;
begin
  GetSavedBitmap := self.SavedBitmap;
end;

procedure TWagon.Draw(curCanvas:TCanvas);
var
  b,s: TBitmap;
begin
  b := GetBitmap;
  s := GetSavedBitmap;
  curCanvas.Draw(self.x_old - (s.Width div 2), self.y_old - (s.Height div 2), s);

  s.Width := b.Width;
  s.Height := b.Height;
  //debug
  //curCanvas.Draw(0,0,s);
  //curCanvas.Draw(50,0,b);

  {curCanvas.Pen.Color := clBlack;
  curCanvas.Brush.Color := clBlack;
  curCanvas.MoveTo(self.x, self.y);
  curCanvas.LineTo(self.x + 1, self.y + 1);}
  s.Canvas.CopyRect(Rect(0,0,b.Width,b.Height), curCanvas, Rect(self.x - (b.Width div 2), self.y - (b.Height div 2), self.x + b.Width - (b.Width div 2), self.y + b.Height - (b.Height div 2)));
  curCanvas.Draw(self.x - (b.Width div 2), self.y - (b.Height div 2), b);
end;

function TWagon.ConvertDirection(direction, mapDirection:shortInt):shortInt;
begin
  case direction of
  0:
    begin
      case mapDirection of
      0:ConvertDirection:=0;
      1:ConvertDirection:=-1;
      2:ConvertDirection:=7;
      3:ConvertDirection:=1;
      end;
    end;
  1:
    begin
      case mapDirection of
      0:ConvertDirection:=0;
      1:ConvertDirection:=2;
      2:ConvertDirection:=3;
      3:ConvertDirection:=1;
      end;
    end;
  2:
    begin
      case mapDirection of
      0:ConvertDirection:=-1;
      1:ConvertDirection:=2;
      2:ConvertDirection:=3;
      3:ConvertDirection:=1;
      end;
    end;
  3:
    begin
      case mapDirection of
      0:ConvertDirection:=4;
      1:ConvertDirection:=2;
      2:ConvertDirection:=3;
      3:ConvertDirection:=5;
      end;
    end;
  4:
    begin
      case mapDirection of
      0:ConvertDirection:=4;
      1:ConvertDirection:=-1;
      2:ConvertDirection:=3;
      3:ConvertDirection:=5;
      end;
    end;
  5:
    begin
      case mapDirection of
      0:ConvertDirection:=4;
      1:ConvertDirection:=6;
      2:ConvertDirection:=3;
      3:ConvertDirection:=5;
      end;
    end;
  6:
    begin
      case mapDirection of
      0:ConvertDirection:=-1;
      1:ConvertDirection:=6;
      2:ConvertDirection:=7;
      3:ConvertDirection:=5;
      end;
    end;
  7:
    begin
      case mapDirection of
      0:ConvertDirection:=0;
      1:ConvertDirection:=6;
      2:ConvertDirection:=7;
      3:ConvertDirection:=5;
      end;
    end;
  end;
end;


end.
