program Sistema;

uses
  Vcl.Forms,
  U_Menu in 'U_Menu.pas' {FrmPrincipal},
  U_DmDados in 'U_DmDados.pas' {DmDados: TDataModule},
  U_CadUsuario in 'U_CadUsuario.pas' {FrmCadUsuario},
  U_LocUsuarios in 'U_LocUsuarios.pas' {FrmLocUsuario},
  U_CadCliente in 'U_CadCliente.pas' {FrmCadCliente},
  U_CadEmpresa in 'U_CadEmpresa.pas' {FrmCadEmpresa},
  U_Configs in 'U_Configs.pas' {FrmConfigs},
  U_Vendas in 'U_Vendas.pas' {FrmVendas},
  U_LocEmpresa in 'U_LocEmpresa.pas' {FrmLocEmpresa},
  U_ConectaBanco in 'U_ConectaBanco.pas' {FrmConectaBanco};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDmDados, DmDados);
  Application.CreateForm(TFrmCadUsuario, FrmCadUsuario);
  Application.CreateForm(TFrmLocUsuario, FrmLocUsuario);
  Application.CreateForm(TFrmCadCliente, FrmCadCliente);
  Application.CreateForm(TFrmCadEmpresa, FrmCadEmpresa);
  Application.CreateForm(TFrmConfigs, FrmConfigs);
  Application.CreateForm(TFrmVendas, FrmVendas);
  Application.CreateForm(TFrmLocEmpresa, FrmLocEmpresa);
  Application.CreateForm(TFrmConectaBanco, FrmConectaBanco);
  Application.Run;
end.
