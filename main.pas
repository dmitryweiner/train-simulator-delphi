unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, ExtCtrls, global, train, wagon, map, Graphics, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Train: TTrain;
  Map: TMap;
  currentKey: Word;

implementation

{$R *.dfm}
{$R *.res}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Train := TTrain.Create(170, 157, 1, 4);
  Map := TMap.Create('1.dat');
  Map.Draw(Form1.Image1.Canvas);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  //Map.SaveToFile('1.dat');
  Map.Destroy;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  moving:boolean;
begin
  moving := true;
  //if moving then
  if true then
    begin
      Train.Move(Map);
      Train.Draw(Form1.Image1.Canvas);
    end;
  currentKey := 0;
end;



end.
