unit U_LocEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, Data.SqlExpr, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, sLabel, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmLocEmpresa = class(TForm)
    Qr: TSQLQuery;
    Ds: TDataSource;
    Cds: TClientDataSet;
    Dsp: TDataSetProvider;
    Dbg1: TDBGrid;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    LbLogin: TsLabel;
    EdtLocalizar: TEdit;

  private

  public

  end;

var
  FrmLocEmpresa: TFrmLocEmpresa;

implementation

{$R *.dfm}

uses
  U_DmDados;

end.
