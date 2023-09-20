unit U_Configs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmConfigs = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfigs: TFrmConfigs;

implementation

{$R *.dfm}

end.
