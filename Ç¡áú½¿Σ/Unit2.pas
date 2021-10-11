unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, shellapi, StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  form2.Hide;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://mixan.narod.ru',nil,nil,0);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  memo1.Lines.LoadFromFile('readme.txt');
end;

end.
