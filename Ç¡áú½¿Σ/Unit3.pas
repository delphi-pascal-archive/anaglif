unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, shellapi, StdCtrls;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
  form3.Hide;
end;

procedure TForm3.SpeedButton2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'http://mixan.narod.ru',nil,nil,0);
end;

end.
