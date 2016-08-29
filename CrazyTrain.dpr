program CrazyTrain;

uses
  Forms,
  main in 'main.pas' {Form1},
  wagon in 'wagon.pas',
  map in 'map.pas',
  global in 'global.pas',
  util in 'util.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
