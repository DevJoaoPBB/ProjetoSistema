unit U_CadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.FMTBcd, Data.DB, Data.SqlExpr,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, sBitBtn;

type
  TFrmCadUsuario = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    EdtLogin: TEdit;
    EdtSenha: TEdit;
    Qr: TSQLDataSet;
    Panel2: TPanel;
    BtIncluir: TSpeedButton;
    BtEditar: TSpeedButton;
    BtLocalizar: TSpeedButton;
    BtSair: TSpeedButton;
    BtSalvar: TSpeedButton;
    BtCancelar: TSpeedButton;
    P1: TPanel;
    Label4: TLabel;
    EdtCodigo: TEdit;
    procedure BtCancelarClick(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtIncluirClick(Sender: TObject);
    procedure BtSalvarClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure EdtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtLocalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);

  private
    procedure TamanhoForm;
    procedure LimpaCampos;
    procedure HabilitaCampos(Valor: String);
    function Ler(Codigo: String): Boolean;
  public

  end;

var
  FrmCadUsuario: TFrmCadUsuario;
  _Status: String;

implementation

{$R *.dfm}

uses
  U_DmDados,
  U_LocUsuarios;

procedure TFrmCadUsuario.HabilitaCampos(Valor: String);
begin

  BtSalvar.Left     := BtIncluir.Left;
  BtSalvar.Top      := BtIncluir.Top;
  BtCancelar.Left   := BtEditar.Left;
  BtCancelar.Top    := BtEditar.Top;
  if Valor = 'I' then
  begin
    //Botões
    BtIncluir.Visible  := False;
    BtEditar.Visible   := False;
    BtLocalizar.Visible:= False;
    BtSair.Visible     := False;
    BtSalvar.Visible   := True;
    BtCancelar.Visible := True;

    EdtCodigo.ReadOnly := True;
    EdtLogin.ReadOnly  := False;
    EdtSenha.ReadOnly  := False;
  end;

  if Valor = 'C' then
  begin
  //Botões
    BtIncluir.Visible  := True;
    BtEditar.Visible   := True;
    BtLocalizar.Visible:= True;
    BtSair.Visible     := True;
    BtSalvar.Visible   := False;
    BtCancelar.Visible := False;

    EdtCodigo.ReadOnly := False;
    EdtLogin.ReadOnly  := True;
    EdtSenha.ReadOnly  := True;
  end;
end;

procedure TFrmCadUsuario.TamanhoForm;
begin
    FrmCadUsuario.Width  :=505;
    FrmCadUsuario.Height :=260;
end;

procedure TFrmCadUsuario.BtCancelarClick(Sender: TObject);
begin
  if (_Status = 'INCLUIR') or (_Status = 'EDITAR') then
  begin
    LimpaCampos;
    HabilitaCampos('C');
    _Status := 'FECHAR';
    EdtCodigo.SetFocus;
  end;
end;

procedure TFrmCadUsuario.BtEditarClick(Sender: TObject);
begin
    if (_Status = 'NAVEGAR') and (EdtCodigo.Text <> '') then
  begin
    HabilitaCampos('I');
    EdtLogin.SetFocus;
    _Status := 'EDITAR';
  end;
end;
procedure TFrmCadUsuario.BtIncluirClick(Sender: TObject);
begin
    if (_Status = 'FECHAR') or (_Status = 'NAVEGAR') then
  begin
    LimpaCampos;
    HabilitaCampos('I');
    _Status := 'INCLUIR';
    EdtLogin.SetFocus;
  end;
end;


procedure TFrmCadUsuario.BtLocalizarClick(Sender: TObject);
begin
  if (_Status = 'FECHAR') or (_Status = 'NAVEGAR') then
  begin
    FrmLocUsuario.ShowModal;
    if FrmLocUsuario.Cds.FieldByName('T002_CODIGO').AsString <> '' then
    begin
      Ler(FrmLocUsuario.Cds.FieldByName('T002_CODIGO').AsString);
    end;
  end;
end;

procedure TFrmCadUsuario.BtSairClick(Sender: TObject);
begin
  if (_Status = 'FECHAR') or (_Status = 'NAVEGAR') then
  begin
    Close;
  end;
end;

procedure TFrmCadUsuario.BtSalvarClick(Sender: TObject);
var
  Codigo: String;
  Transacao : TTransactionDesc;
begin
  if (EdtLogin.Text='')or (EdtSenha.Text='') then
  begin
    Application.MessageBox('Os campos Login e Senha devem ser preenchidos!','Sistema 1.0', MB_OK+MB_ICONQUESTION);
  end
  else
  begin
    begin
    if (_Status = 'INCLUIR') or (_Status = 'EDITAR') then
    begin

      try
        Transacao.TransactionID  := 1;
        Transacao.IsolationLevel := xilReadCommitted;
        DmDados.Conexao.StartTransaction(Transacao);
        with DmDados.QrGravar do
        begin
          Close;
          Sql.Clear;

          if _Status = 'INCLUIR' then
          begin
            Sql.Add('INSERT INTO T002_USUARIOS (');
            Sql.Add('T002_LOGIN,');
            Sql.Add('T002_SENHA)');
            Sql.Add('VALUES (');
            Sql.Add(':T002_LOGIN,');
            Sql.Add(':T002_SENHA)');
          end;

          if _Status = 'EDITAR' then
          begin
            Sql.Add('UPDATE T002_USUARIOS SET');
            Sql.Add('T002_LOGIN =:T002_LOGIN,');
            Sql.Add('T002_SENHA =:T002_SENHA');
            Sql.Add('WHERE T002_CODIGO =:T002_CODIGO');
            ParamByName('T002_CODIGO').AsInteger := StrToInt(EdtCodigo.Text);
          end;

          ParamByName('T002_LOGIN').AsString     := EdtLogin.Text;
          ParamByName('T002_SENHA').AsString     := EdtSenha.Text;

          ExecSql;
          Close;
        end;

         //Seleciona o codigo
        if _Status = 'INCLUIR' then
        begin
           with DmDados.QrGravar do
           begin
             Close;
             Sql.Clear;
             Sql.Add('SELECT MAX(T002_CODIGO)AS CODIGO FROM T002_USUARIOS');
             Sql.Add('WHERE T002_LOGIN =:T002_LOGIN');
             Sql.Add('AND T002_SENHA =:T002_SENHA');
             ParamByName('T002_LOGIN').AsString     := EdtLogin.Text;
             ParamByName('T002_SENHA').AsString     := EdtSenha.Text;
             Open;
             if (FieldByName('CODIGO').AsInteger <= 0) or (FieldByName('CODIGO').AsString = '') then
             begin
               ShowMessage('Ocorreu uma falha ao salvar o cadastro.' + #13#10 +
                           'Código não pode ser recuperado.');

               LimpaCampos;
               HabilitaCampos('C');
               _Status := 'FECHAR';
               EdtCodigo.SetFocus;
               Exit;
             end;
            Codigo := FieldByName('CODIGO').AsString;
           end;
        end;

        DmDados.Conexao.Commit(Transacao);
      except
        on e : exception do
        begin
          ShowMessage('Ocorreu uma falha ao salvar o cadastro.' + #13#10 + e.message);

          LimpaCampos;
          HabilitaCampos('C');
          _Status := 'FECHAR';
          EdtCodigo.SetFocus;
          Exit;
        end;
      end;

      LimpaCampos;
      HabilitaCampos('C');
      EdtCodigo.SetFocus;

      if _Status = 'INCLUIR' then
      begin
        EdtCodigo.Text := Codigo;
      end;

      _Status := 'FECHAR';
    end;

    end;
  end;
end;

procedure TFrmCadUsuario.EdtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 1, 0);

    if (_Status = 'FECHAR') or (_Status = 'NAVEGAR') then
    begin
      if EdtCodigo.Text = '' then
      begin
        _Status := 'FECHAR';
        LimpaCampos;
        BtIncluir.Click;
      end;

      if EdtCodigo.Text <> '' then
      begin
        Ler(EdtCodigo.Text);
      end;
    end;
  end;

  if (not (Key in ['0'..'9'])) and (Key <> #8) then
  begin
    Key := #0;
  end;
end;
procedure TFrmCadUsuario.EdtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 1, 0);
  end;
end;

procedure TFrmCadUsuario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
  if Key = Vk_F9 then
  begin
    BtLocalizar.Click;
  end;

  if Key = Vk_F2 then
  begin
    BtIncluir.Click;
  end;

  if Key = Vk_F4 then
  begin
    BtSalvar.Click;
  end;

  if Key = Vk_F5 then
  begin
    BtEditar.Click;
  end;

  if Key = Vk_F6 then
  begin
    BtCancelar.Click;
  end;

  if Key = VK_ESCAPE then
  begin
    BtSair.Click;
  end;
end;

procedure TFrmCadUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #27 then
  begin
    Key := #0;
  end;
end;

procedure TFrmCadUsuario.FormResize(Sender: TObject);
begin
  P1.Width := FrmCadUsuario.Width;
end;

procedure TFrmCadUsuario.FormShow(Sender: TObject);
begin
  TamanhoForm;
  LimpaCampos;
  HabilitaCampos('C');
  _Status := 'FECHAR';
  EdtCodigo.SetFocus;
end;

function TFrmCadUsuario.Ler(Codigo: String): Boolean;
begin
  Result := False;

  try
    with Qr do
    begin
      Close;
      ParamByName('T002_CODIGO').AsInteger := StrToInt(Codigo);
      Open;
      if FieldByName('T002_CODIGO').AsString = '' then
      begin
        ShowMessage('Usuario não cadastrado!');
        LimpaCampos;
        HabilitaCampos('C');
        _Status := 'FECHAR';
        EdtCodigo.SetFocus;
        Exit;
      end;

      EdtCodigo.Text := FieldByName('T002_CODIGO').AsString;
      EdtLogin.Text  := FieldByName('T002_LOGIN').AsString;
      EdtSenha.Text  := FieldByName('T002_SENHA').AsString;
      _Status        := 'NAVEGAR';
      Result         := True;

    end;

  except
  on e: exception do
  begin
    Result    := False;
    ShowMessage('Não é possivel realizar a consulta!' + #13#10 + e.Message);
    LimpaCampos;
    HabilitaCampos('C');
    _Status := 'FECHAR';
    EdtCodigo.SetFocus;
  end;

  end;
end;

procedure TFrmCadUsuario.LimpaCampos;
begin
   EdtCodigo.Clear;
   EdtLogin.Clear;
   EdtSenha.Clear;
end;

end.
