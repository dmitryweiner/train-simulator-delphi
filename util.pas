unit util;

interface
uses SysUtils;

type
  TStrArray = array of string;

type
  TArrayOfStrArray = array of array of string;

function Explode(var arr: TStrArray; Border, S: string): Integer;
procedure ReadFileToArray(fileName:string; var strArr:TStrArray);
procedure SaveArrayToFile(fileName:string; strArr:TStrArray);

implementation

function Explode(var arr: TStrArray; Border, S: string): Integer;
var
  S2: string;
begin
  Result  := 0;
  S2 := S + Border;
  repeat
    SetLength(arr, Length(arr) + 1);
    arr[Result] := Copy(S2, 0,Pos(Border, S2) - 1);
    Delete(S2, 1,Length(arr[Result] + Border));
    Inc(Result);
  until S2 = '';
end;

procedure ReadFileToArray(fileName:string; var strArr:TStrArray);
var
  s:string;
  str:string;
  str_enter, str_tab:string;
  f:TextFile;
begin
  SetLength(strArr,0);
  if FileExists(fileName) then
    begin
      AssignFile(F, fileName);
      Reset(F);
      while not eof(F) do
        begin
          SetLength(strArr,Length(strArr)+1);
          Readln(F, str);
          strArr[High(strArr)]:=str;
        end;
      CloseFile(F);
    end;
end;

procedure SaveArrayToFile(fileName:string; strArr:TStrArray);
var
  s:string;
  str:string;
  str_enter, str_tab:string;
  f:TextFile;
  i:integer;
begin
  AssignFile(F, fileName);
  Rewrite(F);
  for i:=0 to High(strArr) do
    begin
      Writeln(F, strArr[i]);
    end;
  CloseFile(F);
end;

end.
