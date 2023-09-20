unit U_LocEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, Data.SqlExpr, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, sLabel, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmLocEmpresa = class(TForm)
    Dbg1: TDBGrid;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    LbLogin: TsLabel;
    EdtLocalizar: TEdit;
    Qr: TSQLQuery;
    QrT001_CODIGO: TIntegerField;
    QrT001_NOME: TStringField;
    QrT001_RAZAO_SOCIAL: TStringField;
    QrT001_ENDERECO: TStringField;
    QrT001_NUMERO: TStringField;
    QrT001_BAIRRO: TStringField;
    QrT001_CNPJ: TStringField;
    QrT001_IE: TStringField;
    Dsp: TDataSetProvider;
    Cds: TClientDataSet;
    Ds: TDataSource;
    CdsT001_CODIGO: TIntegerField;
    CdsT001_NOME: TStringField;
    CdsT001_RAZAO_SOCIAL: TStringField;
    CdsT001_ENDERECO: TStringField;
    CdsT001_NUMERO: TStringField;
    CdsT001_BAIRRO: TStringField;
    CdsT001_CNPJ: TStringField;
    CdsT001_IE: TStringField;

  private

  public

  end;

var
  FrmLocEmpresa: TFrmLocEmpresa;

implementation

{$R *.dfm}

uses
  U_DmDados,
  U_Menu;

end.
