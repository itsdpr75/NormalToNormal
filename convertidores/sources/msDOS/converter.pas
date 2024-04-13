program ConvertToNormals;

uses
  math;

type
  ByteArray = array of Byte;

procedure ConvertToNormals(var data: ByteArray);
var
  i: Integer;
  r, g, x, y, z, length: Single;
begin
  for i := 0 to Length(data) - 1 do
  begin
    if i mod 4 = 0 then
    begin
      r := data[i] / 255.0;
      g := data[i + 1] / 255.0;

      x := (r * 2) - 1;
      y := (g * 2) - 1;
      z := sqrt(1 - x * x - y * y);

      length := sqrt(x * x + y * y + z * z);
      x := x / length;
      y := y / length;
      z := z / length;

      data[i] := Round((x + 1) / 2 * 255);
      data[i + 1] := Round((y + 1) / 2 * 255);
      data[i + 2] := Round((z + 1) / 2 * 255);
    end;
  end;
end;

var
  data: ByteArray;

begin
  // Aquí se supone que tienes una variable "data" que contiene los datos de la imagen
  // ConvertToNormals(data);
end.
