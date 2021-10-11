unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Button3: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Label4: TLabel;
    Label5: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure drawimage;
    procedure prjct;
    procedure drawredline(X1:integer;Y1:integer;X2:integer;Y2:integer);
    procedure drawgreenline(X1:integer;Y1:integer;X2:integer;Y2:integer);
    { Private declarations }
  public
    procedure extractpath(Str:string);
    { Public declarations }
  end;

var
  str:string;
  mas:array[0..100] of string;
  masx,masy,masz:array[0..100] of integer;
  count:integer;
  Form1: TForm1;
  yc, xr, xl:array[0..100] of integer; //Массив т. для im
  y, x, z:array[0..100] of integer; //Массив т. x-y-z
  kolwo:integer; //Количество точек
  r:integer;
  d:integer;
  scl:real;
  xt,yt,zt:integer;

implementation

uses Unit2, Unit3;

{$R *.DFM}

procedure TForm1.extractpath(Str:string);
var
  j,k:integer;
  tempstring:string;
begin
  k:=-1;
  j:=pos(':',str);
  tempstring:=copy(str,1,j-1);//First const
  repeat
    inc(k);
    xt:=masx[k];
    yt:=masy[k];
    zt:=masz[k];
  until (tempstring=mas[k]);
  tempstring:=inttostr(xt)+inttostr(yt)+inttostr(zt);
  str:=copy(str,j+1,length(str)-j);

  repeat
    j:=pos(':',str);
    tempstring:=copy(str,1,j-1);//First const
    if tempstring='' then tempstring:=str;
    k:=-1;
    repeat
      inc(k);
    until (tempstring=mas[k]);
    inc(kolwo);
    x[kolwo]:=masx[k];
    y[kolwo]:=masy[k];
    z[kolwo]:=masz[k];

    inc(kolwo);
    x[kolwo]:=xt;
    y[kolwo]:=yt;
    z[kolwo]:=zt;
      //Рисуем ще masx до xt ит.д.
    xt:=masx[k];
    yt:=masy[k];
    zt:=masz[k];
    str:=copy(str,j+1,length(str)-j);
  until (str=tempstring);
end;



procedure TForm1.drawimage;
var
  i:integer;
begin
  image1.Picture.Bitmap.Canvas.Brush.Color := ClWhite;
  image1.Picture.Bitmap.Canvas.FillRect(Canvas.ClipRect);

  i := 0;
  while i <= kolwo do
  begin
    drawredline(xl[i],yc[i],xl[i+1],yc[i+1]);
    inc(i,2);
  end;

  i := 0;
  while i <= kolwo do
  begin
    drawgreenline(xr[i],yc[i],xr[i+1],yc[i+1]);
    inc(i,2);
  end;
end;

procedure TForm1.prjct;
var
  mu: real;
  alf,bet,gam: real;
  i:integer;
begin
  for i:= 0 to kolwo do
  begin
    mu:=1/((r+z[i])*scl);
    alf:=r*y[i]*mu;
    bet:=r*x[i]*mu;
    gam:=d*z[i]*mu;

    yc[i]:=round(240+alf);
    xr[i]:=round(320+bet+gam);
    xl[i]:=round(320+bet-gam);
  end;
end;

procedure TForm1.drawredline(X1:integer;Y1:integer;X2:integer;Y2:integer);
begin
  image1.Picture.Bitmap.Canvas.MoveTo(x1,y1);
  image1.Picture.Bitmap.Canvas.Pen.Color := shape2.Brush.Color;
  image1.Picture.Bitmap.Canvas.LineTo(x2,y2);
end;


procedure TForm1.drawgreenline(X1:integer;Y1:integer;X2:integer;Y2:integer);
var
 buf,yk,xk,y,x,dx,dy:integer;
begin
  dx:=x2-x1;
  dy:=y2-y1;
  if abs(dx)>abs(dy) then
  begin
    if x1>x2 then
    begin
      buf:=x1; x1:=x2; x2:=buf;
      buf:=y1; y1:=y2; y2:=buf;
    end;
    for x:=x1 to x2 do
    begin
      yk:=(y1+((x-x1)*dy) div dx);
      if (image1.Picture.Bitmap.Canvas.Pixels[x,yk]=shape2.Brush.Color)
      or (image1.Picture.Bitmap.Canvas.Pixels[x,yk]=rgb(0,0,0))
      then image1.Picture.Bitmap.Canvas.Pixels[x,yk]:=rgb(0,0,0)
      else image1.Picture.Bitmap.Canvas.Pixels[x,yk]:=shape4.Brush.Color;
    end;
  end
  else
  begin
    if y1>y2 then
    begin
      buf:=x1; x1:=x2; x2:=buf;
      buf:=y1; y1:=y2; y2:=buf;
    end;
    for y:=y1 to y2 do
    begin
      xk:=(x1+((y-y1)*dx) div dy);
      if (image1.Picture.Bitmap.Canvas.Pixels[xk,y]=shape2.Brush.Color)
      or (image1.Picture.Bitmap.Canvas.Pixels[xk,y]=rgb(0,0,0))
      then image1.Picture.Bitmap.Canvas.Pixels[xk,y]:=rgb(0,0,0)
      else image1.Picture.Bitmap.Canvas.Pixels[xk,y]:=shape4.Brush.Color;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  f:textfile;
  str:string;
begin
  r:=240;
  d:=10;
  scl:=0.375;
  opendialog1.InitialDir := extractfilepath(application.exename);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  shape2.Brush.Color := rgb(trackbar1.position,trackbar2.position,trackbar3.position);
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
  shape4.Brush.Color := rgb(trackbar4.position,trackbar5.position,trackbar6.position);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  r:=strtoint(edit1.text);
  d:=strtoint(edit2.text);
  scl:=strtofloat(edit3.text);
  if kolwo=0 then exit;
  prjct;
  drawimage;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  edit1.text:='240';
  edit2.text:='30';
  edit3.text:='0,375';
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  f:textfile;
  i:integer;
  tempstr,str:string;
begin
  opendialog1.execute;
  if opendialog1.filename='' then exit;
  assignfile(f,opendialog1.filename);
  reset(f);
  count:=-1;
  kolwo:=-1;
  while not eof(f) do
  begin
    readln(f,str);
    i:=pos(' ',str);
    if i>0 then //Достаем описание точки
    begin
      inc(count);//Переместимся на сл.место
      tempstr:=copy(str,1,i-1);//Имя точки
      mas[count]:=tempstr;
      str:=copy(str,i+1,length(str)-i);
      i:=pos(',',str);
      tempstr:=copy(str,1,i-1);
      masx[count]:=strtoint(tempstr);
      str:=copy(str,i+1,length(str)-i);
      i:=pos(',',str);
      tempstr:=copy(str,1,i-1);
      masy[count]:=strtoint(tempstr);
      str:=copy(str,i+1,length(str)-i);
      masz[count]:=strtoint(str);
    end
    else ExtractPath(str);
  end;
  closefile(f);
  prjct;
  drawimage;
  form1.Caption := 'Анаглиф - '+opendialog1.FileName;
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
if key=38 then begin
  for i:=0 to kolwo do
  begin
    z[i]:=z[i]+10;
  end;
  prjct;
  drawimage;
end;
if key=40 then begin
  for i:=0 to kolwo do
  begin
    z[i]:=z[i]-10;
  end;
  prjct;
  drawimage;
end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  form2.show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  form3.show
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  close;
end;

end.
