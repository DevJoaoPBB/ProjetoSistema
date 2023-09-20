unit U_Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, IniFiles, Vcl.ComCtrls,
  Vcl.ExtCtrls, sPanel, Vcl.Buttons, sSpeedButton, sSkinManager, AeroButtons,
  Vcl.StdCtrls, Vcl.DBCtrls, Data.DB, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Data.SqlExpr;

var
 CaminhoIni : String;
 Arquivo: TIniFile;
type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    C1: TMenuItem;
    S1: TMenuItem;
    St1: TStatusBar;
    E1: TMenuItem;
    U1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    sPanel1: TsPanel;
    Timer1: TTimer;
    C2: TMenuItem;
    C3: TMenuItem;
    BtProdutos: TsSpeedButton;
    BtVendas: TsSpeedButton;
    BtCaixa: TsSpeedButton;
    BtSair: TsSpeedButton;
    BtContas: TsSpeedButton;
    BtPessoas: TsSpeedButton;
    sSkinManager1: TsSkinManager;
    procedure S1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure U1Click(Sender: TObject);
    procedure BtPessoasClick(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtSairClick(Sender: TObject);

  private

  public
    function ConectarBanco: Boolean;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
  U_DmDados,
  U_ConectaBanco,
  U_CadUsuario,
  U_CadCliente,
  U_Configs,
  U_CadEmpresa;


function TFrmPrincipal.ConectarBanco: Boolean;
var
  ConectarBanco, NomeBanco : String;

begin
  Result  := False;
  Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Base\Config.ini');
  ConectarBanco := Arquivo.ReadString('CONEXAO_BASE','Database',ConectarBanco);
  St1.Panels[0].Text := 'Caminho Banco de Dados: '+ ConectarBanco;

 //==========================CONECTA COM A CONEXAO BANCO SISTEMA====================
  try
    with DmDados.Conexao do
    begin
      Connected := False;
      Params.Clear;
      Params.Add('DriverUnit=Data.DBXFirebird');
      Params.Add('DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver220.bpl');
      Params.Add('DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
      Params.Add('MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver220.bpl');
      Params.Add('MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
      Params.Add('GetDriverFunc=getSQLDriverINTERBASE');
      Params.Add('LibraryName=dbxfb.dll');
      Params.Add('LibraryNameOsx=libsqlfb.dylib');
      Params.Add('VendorLib=fbclient.dll');
      Params.Add('VendorLibWin64=fbclient.dll');
      Params.Add('VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird');
      Params.Add('Role=RoleName');
      Params.Add('MaxBlobSize=-1');
      Params.Add('TrimChar=False');
      Params.Add('DriverName=Firebird');
      Params.Add('Database='+ ConectarBanco);
      Params.Add('RoleName=RoleName');
      Params.Add('User_Name=sysdba');
      Params.Add('Password=masterkey');
      Params.Add('ServerCharSet=WIN1252');
      Params.Add('SQLDialect=3');
      Params.Add('ErrorResourceFile=');
      Params.Add('LocaleCode=0000');
      Params.Add('BlobSize=-1');
      Params.Add('CommitRetain=False');
      Params.Add('WaitOnLocks=True');
      Params.Add('IsolationLevel=ReadCommitted');
      Params.Add('Trim Char=False');
      Open;
      Connected := True;
      Result    := True;
    end;
  except
    on e: exception do
    begin
      Result    := False;
  end;
  end;
end;

procedure TFrmPrincipal.E1Click(Sender: TObject);
begin
  FrmCadEmpresa.ShowModal;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  FrmPrincipal.WindowState := wsMaximized;

  if not ConectarBanco then
  begin
     Application.MessageBox('Banco de Dados não localizado!','Sistema 1.0', MB_OK+MB_ICONERROR);
     DmDados.Conexao.Connected := False;
     FrmConectaBanco.ShowModal;

     if FrmConectaBanco.ModalResult = mrOK then
    begin
      // O usuário confirmou a configuração, então atualize o caminho do banco no arquivo .ini.
      Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Base\Config.ini');
      Arquivo.WriteString('CONEXAO_BASE', 'Database', FrmConectaBanco.CaminhoBanco);
      try
    with DmDados.Conexao do
    begin
      Connected := False;
      Params.Clear;
      Params.Add('DriverUnit=Data.DBXFirebird');
      Params.Add('DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver220.bpl');
      Params.Add('DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
      Params.Add('MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver220.bpl');
      Params.Add('MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
      Params.Add('GetDriverFunc=getSQLDriverINTERBASE');
      Params.Add('LibraryName=dbxfb.dll');
      Params.Add('LibraryNameOsx=libsqlfb.dylib');
      Params.Add('VendorLib=fbclient.dll');
      Params.Add('VendorLibWin64=fbclient.dll');
      Params.Add('VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird');
      Params.Add('Role=RoleName');
      Params.Add('MaxBlobSize=-1');
      Params.Add('TrimChar=False');
      Params.Add('DriverName=Firebird');
      Params.Add('Database='+ FrmConectaBanco.CaminhoBanco);
      Params.Add('RoleName=RoleName');
      Params.Add('User_Name=sysdba');
      Params.Add('Password=masterkey');
      Params.Add('ServerCharSet=WIN1252');
      Params.Add('SQLDialect=3');
      Params.Add('ErrorResourceFile=');
      Params.Add('LocaleCode=0000');
      Params.Add('BlobSize=-1');
      Params.Add('CommitRetain=False');
      Params.Add('WaitOnLocks=True');
      Params.Add('IsolationLevel=ReadCommitted');
      Params.Add('Trim Char=False');
      Open;
      Connected := True;
      Arquivo.Free;
    end;
    finally

    end;
end;
end;
end;

procedure TFrmPrincipal.S1Click(Sender: TObject);
begin
  BtSair.Click;
end;

procedure TFrmPrincipal.BtSairClick(Sender: TObject);
begin
if
  Application.MessageBox('Deseja sair do sistema?', 'Sistema 1.0',
  MB_YESNO + MB_ICONQUESTION) = IDYES then
begin
  Application.Terminate;
end;
end;

procedure TFrmPrincipal.Timer1Timer(Sender: TObject);
begin
   St1.Panels[1].Text := '' + FormatDateTime('hh:nn:ss',now);
   St1.Panels[2].Text := ' ' + FormatDateTime ('dddd" - "dd""/""mm""/""yyyy',now);
end;

procedure TFrmPrincipal.BtPessoasClick(Sender: TObject);
begin
  FrmCadCliente.ShowModal;
end;

procedure TFrmPrincipal.U1Click(Sender: TObject);
begin
  FrmCadUsuario.ShowModal;
end;

end.
