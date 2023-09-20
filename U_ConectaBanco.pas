unit U_ConectaBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, IniFiles;

type
  TFrmConectaBanco = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    EdtBase: TEdit;
    Label1: TLabel;
    BtLocalizaBase: TBitBtn;
    Od1: TOpenDialog;
    BtConectar: TBitBtn;
    BtSair: TBitBtn;
    procedure BtLocalizaBaseClick(Sender: TObject);
    procedure BtConectarClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  
  private
    FCaminhoBanco: string; // Propriedade para armazenar o caminho do banco
  public
    property CaminhoBanco: string read FCaminhoBanco write FCaminhoBanco;

  end;

var
  FrmConectaBanco: TFrmConectaBanco;

implementation

{$R *.dfm}

uses

  U_DmDados,
  U_Menu;

procedure TFrmConectaBanco.BtLocalizaBaseClick(Sender: TObject);
begin
  if Od1.Execute then
  begin
    EdtBase.Text  := Od1.FileName;
    CaminhoBanco  := Od1.FileName;
  end;
end;

procedure TFrmConectaBanco.BtSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmConectaBanco.FormShow(Sender: TObject);
begin
  EdtBase.Text := DmDados.Conexao.Params.Values['Database'];
end;

procedure TFrmConectaBanco.BtConectarClick(Sender: TObject);
begin
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
      Params.Add('Database='+ EdtBase.Text);
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
      try
        DmDados.Conexao.Connected := True;

        if DmDados.Conexao.Connected = True then // Testa se a conexão foi bem-sucedida
        begin
          ShowMessage('Conexão bem-sucedida!');
          ModalResult := mrOK; // Feche o FrmConectaBanco com resultado OK
        end
        else
        begin
          ShowMessage('Falha ao conectar com o banco de dados!');
        end;

      finally
        Arquivo.Free;
      end;
    end;
end;

end.
