unit U_DmDados;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.FMTBcd, Data.DB,
  Data.SqlExpr;

type
  TDmDados = class(TDataModule)
    Conexao: TSQLConnection;
    QrCalculo: TSQLQuery;
    QrGravar: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmDados: TDmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
