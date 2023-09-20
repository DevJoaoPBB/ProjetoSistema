unit U_LocUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Data.SqlExpr, Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls,
  sPanel, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, sLabel, Vcl.DBCtrls;

type
  TFrmLocUsuario = class(TForm)
    LbLogin: TsLabel;
    Dbg1: TDBGrid;
    EdtLocalizar: TEdit;
    Qr: TSQLQuery;
    Ds: TDataSource;
    Cds: TClientDataSet;
    Dsp: TDataSetProvider;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    CdsT002_CODIGO: TIntegerField;
    CdsT002_LOGIN: TStringField;
    CdsT002_SENHA: TStringField;
    procedure EdtLocalizarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure Dbg1DblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLocUsuario: TFrmLocUsuario;

implementation

{$R *.dfm}

procedure TFrmLocUsuario.BtSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLocUsuario.Dbg1DblClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLocUsuario.EdtLocalizarChange(Sender: TObject);
begin
    with Qr do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT');
    Sql.Add('T002_CODIGO,');
    Sql.Add('T002_LOGIN,');
    Sql.Add('T002_SENHA');
    Sql.Add('FROM T002_USUARIOS');
    Sql.Add('WHERE UPPER (T002_LOGIN) LIKE ' + QuotedStr('%' + EdtLocalizar.Text + '%'));
    Sql.Add('ORDER BY T002_LOGIN');
    Open;
    Cds.Active := False;
    Cds.Active := True;
  end;
end;

procedure TFrmLocUsuario.FormShow(Sender: TObject);
begin
  EdtLocalizar.Clear;
  EdtLocalizar.SetFocus;

  Dbg1.Columns[0].Width := 82;
end;

end.
