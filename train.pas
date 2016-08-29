unit train;

interface
uses Graphics, SysUtils, Types, wagon, map;


type TTrain = class
  private
    wagons: array of TWagon;
  public
    constructor Create(x,y:integer; Nwagons:integer; direction:shortInt);
    destructor Destroy;
    procedure Move(Map:TMap);
    procedure Draw(curCanvas:TCanvas);
end;

implementation

constructor TTrain.Create(x,y:integer; Nwagons:integer; direction:shortInt);
begin
  if(Nwagons > 0) then
    begin
      SetLength(self.wagons, Nwagons);
      self.wagons[0] := TWagon.Create(x,y,'LOC', direction);
    end;
end;

destructor TTrain.Destroy;
var i:integer;
begin
  for i:=0 to High(self.wagons) do
    self.wagons[i].Destroy;
end;

procedure TTrain.Move(Map:TMap);
var i:integer;
begin
  for i:=0 to High(self.wagons) do
    self.wagons[i].Move(Map);
end;

procedure TTrain.Draw(curCanvas:TCanvas);
var i:integer;
begin
  for i:=0 to High(self.wagons) do
    self.wagons[i].Draw(curCanvas);
end;

end.
