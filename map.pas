unit map;

interface
uses Graphics, SysUtils, Types, util;

const
  CELL_DIMENTION = 15; //cell height, width
  IMAGE_HEIGHT = 450;
  IMAGE_WIDTH = 750;
  MAX_CELL_I = 49;
  MAX_CELL_J = 29;

type TCell = class
  private
  public
    bitmapIndex: ShortInt;
    direction: ShortInt;
end;

type TMap = class
  private
    map: array [0..MAX_CELL_I] of array [0..MAX_CELL_J] of TCell;
    fileName:string;
    width, height:integer;
    cellWidth, cellHeight: integer;
    bitmaps: array [0..6] of TBitmap;
  public
    constructor Create(fileName:string);
    destructor Destroy;
    procedure Draw(curCanvas:TCanvas);
    function GetDirection(x,y:integer):ShortInt;
    procedure LoadFromFile(fileName:string);
    procedure SaveToFile(fileName:string);
    function ConvertBitmapIndexToDirection(bitmapIndex:shortInt):ShortInt;
    function IsHorizontalBorder(x,y:integer; currentDirection:ShortInt):boolean;
    function IsVerticalBorder(x,y:integer; currentDirection:ShortInt):boolean;
end;

implementation

constructor TMap.Create(fileName:string);
var i,j:integer;
begin
  self.fileName := fileName;

  for i:=0 to 6 do
    begin
      self.Bitmaps[i] := TBitmap.Create;
      self.Bitmaps[i].LoadFromResourceName(Hinstance, 'CELL'+IntToStr(i));
    end;

  for i:=0 to MAX_CELL_I do
    for j:=0 to MAX_CELL_J do
      self.map[i,j] := TCell.Create;

  LoadFromFile(fileName);
end;

destructor TMap.Destroy;
var i,j:integer;
begin
  for i:=0 to 6 do
    self.Bitmaps[i].Free;
  for i:=0 to MAX_CELL_I do
    begin
      for j:=0 to MAX_CELL_J do
        begin
          self.map[i,j].Free;
        end;
    end;
end;

procedure TMap.Draw(curCanvas:TCanvas);
var i,j:integer;
begin
  for i:=0 to MAX_CELL_I do
    begin
      for j:=0 to MAX_CELL_J do
        begin
          {curCanvas.Pen.Color := clGreen;
          curCanvas.Rectangle(i*CELL_DIMENTION, j*CELL_DIMENTION, (i+1)*CELL_DIMENTION, (j+1)*CELL_DIMENTION);}
          curCanvas.Draw(i*CELL_DIMENTION, j*CELL_DIMENTION, self.Bitmaps[self.map[i,j].bitmapIndex]);
        end;
    end;
end;

function TMap.GetDirection(x,y:integer):ShortInt;
begin
  GetDirection := self.map[x div CELL_DIMENTION, y div CELL_DIMENTION].direction;
end;

procedure TMap.LoadFromFile(fileName:string);
var
  strArr: TStrArray;
  exploded:TStrArray;
  i,j:integer;
begin
  ReadFileToArray(fileName, strArr);
  for i:=0 to High(strArr) do
    begin
      Explode(exploded, #9, strArr[i]);
      for j:=0 to High(exploded) do
        begin
          if(exploded[j] <> '') then
            begin
              self.map[i,j].bitmapIndex := StrToInt(exploded[j]);
              self.map[i,j].direction := ConvertBitmapIndexToDirection(self.map[i,j].bitmapIndex);
            end;
        end;
    end;
end;

procedure TMap.SaveToFile(fileName:string);
var
  strArr: TStrArray;
  i,j:integer;
begin
  setLength(strArr, 0);
  for i:=0 to High(self.map) do
    begin
      setLength(strArr, High(strArr)+2);
      strArr[i]:='';
      for j:=0 to High(self.map[i]) do
        begin
          strArr[i] := strArr[i] + IntToStr(self.map[i,j].bitmapIndex) + #9;
        end;
    end;
  SaveArrayToFile(fileName, strArr);  
end;

function TMap.ConvertBitmapIndexToDirection(bitmapIndex:shortInt):ShortInt;
begin
  case bitmapIndex of
    0:ConvertBitmapIndexToDirection := 0;
    1:ConvertBitmapIndexToDirection := 1;
    2:ConvertBitmapIndexToDirection := 3;
    3:ConvertBitmapIndexToDirection := 2;
    4:ConvertBitmapIndexToDirection := 3;
    5:ConvertBitmapIndexToDirection := 2;
    6:ConvertBitmapIndexToDirection := -1;
  end;
end;

function TMap.IsHorizontalBorder(x,y:integer; currentDirection:ShortInt):boolean;
begin
  if   ((y mod CELL_DIMENTION = 0) and ((currentDirection = 1) or (currentDirection = 2) or (currentDirection = 3)))
    or ((y mod CELL_DIMENTION = (CELL_DIMENTION-1)) and ((currentDirection = 5) or (currentDirection = 6) or (currentDirection = 7))) then
    IsHorizontalBorder := true
  else
    IsHorizontalBorder := false;
end;

function TMap.IsVerticalBorder(x,y:integer; currentDirection:ShortInt):boolean;
begin
  if   ((x mod CELL_DIMENTION = 0) and ((currentDirection = 0) or (currentDirection = 1) or (currentDirection = 7)))
    or ((x mod CELL_DIMENTION = (CELL_DIMENTION-1)) and ((currentDirection = 3) or (currentDirection = 4) or (currentDirection = 5))) then
    IsVerticalBorder := true
  else
    IsVerticalBorder := false;
end;


end.
