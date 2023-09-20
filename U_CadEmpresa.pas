unit U_CadEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Data.FMTBcd,
  Data.DB, Data.SqlExpr, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.ExtDlgs,
  Vcl.DBCtrls;

type
  TFrmCadEmpresa = class(TForm)
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
    Qr: TSQLDataSet;
    QrT001_CODIGO: TIntegerField;
    QrT001_NOME: TStringField;
    QrT001_RAZAO_SOCIAL: TStringField;
    QrT001_ENDERECO: TStringField;
    QrT001_NUMERO: TStringField;
    QrT001_BAIRRO: TStringField;
    QrT001_COMPLEMENTO: TStringField;
    QrT001_CNPJ: TStringField;
    QrT001_IE: TStringField;
    QrT001_TELEFONE: TStringField;
    QrT001_CELULAR: TStringField;
    QrT001_EMAIL: TStringField;
    QrT003_CODIGO: TIntegerField;
    QrCidade: TSQLDataSet;
    QrCidadeT003_CODIGO: TIntegerField;
    QrCidadeT003_NOME: TStringField;
    QrCidadeT003_UF: TStringField;
    QrCidadeT003_IBGE: TStringField;
    QrCidadeT003_CEP: TStringField;
    Opd1: TOpenPictureDialog;
    QrT001_LOGO: TBlobField;
    Pg1: TPageControl;
    TbDadosPrinc: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EdtNome: TEdit;
    EdtRS: TEdit;
    EdtEnde: TEdit;
    EdtNr: TEdit;
    EdtBairro: TEdit;
    EdtComp: TEdit;
    EdtCNPJ: TEdit;
    EdtIE: TEdit;
    EdtTelefone: TEdit;
    EdtCelular: TEdit;
    EdtCodCid: TEdit;
    EdtNomeCid: TEdit;
    EdtEmail: TEdit;
    EdtUf: TEdit;
    EdtCep: TMaskEdit;
    TbLogo: TTabSheet;
    Label16: TLabel;
    Panel3: TPanel;
    img: TImage;
    procedure FormResize(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtIncluirClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtSalvarClick(Sender: TObject);
    procedure EdtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure BtEditarClick(Sender: TObject);
    procedure EdtCodCidExit(Sender: TObject);
    procedure ImgDblClick(Sender: TObject);

  private
    procedure TamanhoForm;
    procedure HabilitaCampos(Valor : String);
    procedure LimpaCampos;
    function Ler (Codigo : String): Boolean;
    function LerCidade(CodigoCidade : String): Boolean;

  public

  end;

var
  FrmCadEmpresa: TFrmCadEmpresa;
  _Status: String;

implementation

{$R *.dfm}

uses
  U_DmDados,
  U_Menu;

procedure TFrmCadEmpresa.HabilitaCampos(Valor: String);
begin

  BtSalvar.Left     := BtIncluir.Left;
  BtSalvar.Top      := BtIncluir.Top;
  BtCancelar.Left   := BtEditar.Left;
  BtCancelar.Top    := BtEditar.Top;
  if Valor = 'I' then

  begin
    //Botões
    BtIncluir.Visible   := False;
    BtEditar.Visible    := False;
    BtLocalizar.Visible := False;
    BtSair.Visible      := False;
    BtSalvar.Visible    := True;
    BtCancelar.Visible  := True;

    EdtCodigo.ReadOnly  := True;
    EdtNome.ReadOnly    := False;
    EdtRS.ReadOnly      := False;
    EdtEnde.ReadOnly    := False;
    EdtNr.ReadOnly      := False;
    EdtBairro.ReadOnly  := False;
    EdtComp.ReadOnly    := False;
    EdtCodCid.ReadOnly  := False;
    EdtNomeCid.ReadOnly := False;
    EdtCNPJ.ReadOnly    := False;
    EdtIE.ReadOnly      := False;
    EdtTelefone.ReadOnly:= False;
    EdtCelular.ReadOnly := False;
    Img.Enabled         := True;
  end;

  if Valor = 'C' then
  begin
  //Botões
    BtIncluir.Visible   := True;
    BtEditar.Visible    := True;
    BtLocalizar.Visible := True;
    BtSair.Visible      := True;
    BtSalvar.Visible    := False;
    BtCancelar.Visible  := False;

    EdtCodigo.ReadOnly  := False;
    EdtNome.ReadOnly    := True;
    EdtRS.ReadOnly      := True;
    EdtEnde.ReadOnly    := True;
    EdtNr.ReadOnly      := True;
    EdtBairro.ReadOnly  := True;
    EdtComp.ReadOnly    := True;
    EdtCodCid.ReadOnly  := True;
    EdtNomeCid.ReadOnly := True;
    EdtCNPJ.ReadOnly    := True;
    EdtIE.ReadOnly      := True;
    EdtTelefone.ReadOnly:= True;
    EdtCelular.ReadOnly := True;
    Img.Enabled         := False;
  end;
end;

procedure TFrmCadEmpresa.ImgDblClick(Sender: TObject);
var
  bmp: TBitmap;
begin
  if Opd1.Execute then
  begin
  bmp:= Tbitmap.Create;
  bmp.LoadFromFile(Opd1.FileName);
  img.Picture.Bitmap.Assign(bmp);
  bmp.Free;
  end;

end;

function TFrmCadEmpresa.Ler(Codigo: String): Boolean;
begin
  Result := False;

  try
    with Qr do
    begin
      Close;
      ParamByName('T001_CODIGO').AsInteger := StrToInt(Codigo);
      Open;
      if FieldByName('T001_CODIGO').AsString = '' then
      begin
        ShowMessage('Empresa não cadastrada!');
        LimpaCampos;
        HabilitaCampos('C');
        _Status := 'FECHAR';
        EdtCodigo.SetFocus;
        Exit;
      end;
        EdtCodigo.Text       := FieldByName('T001_CODIGO').AsString;
        EdtNome.Text         := FieldByName('T001_NOME').AsString;
        EdtRS.Text           := FieldByName('T001_RAZAO_SOCIAL').AsString;
        EdtEnde.Text         := FieldByName('T001_ENDERECO').AsString;
        EdtNr.Text           := FieldByName('T001_NUMERO').AsString;
        EdtBairro.Text       := FieldByName('T001_BAIRRO').AsString;
        EdtComp.Text         := FieldByName('T001_COMPLEMENTO').AsString;
        EdtCNPJ.Text         := FieldByName('T001_CNPJ').AsString;
        EdtIE.Text           := FieldByName('T001_IE').AsString;
        EdtTelefone.Text     := FieldByName('T001_TELEFONE').AsString;
        EdtCelular.Text      := FieldByName('T001_CELULAR').AsString;
        EdtEmail.Text        := FieldByName('T001_EMAIL').AsString;
        Img.Picture.Assign(QrT001_LOGO);
        EdtCodCid.Text       := FieldByName('T003_CODIGO').AsString;
        EdtNomeCid.Text      := QrCidade.FieldByName('T003_NOME').AsString;
        EdtUf.Text           := QrCidade.FieldByName('T003_UF').AsString;
        EdtCEP.Text          := QrCidade.FieldByName('T003_CEP').AsString;
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

function TFrmCadEmpresa.LerCidade(CodigoCidade: String): Boolean;
begin
  Result := False;

  try
    with QrCidade do
    begin
      Close;
      ParamByName('T003_CODIGO').AsInteger := StrToInt(CodigoCidade);
      Open;
      if FieldByName('T003_CODIGO').AsString = '' then
      begin
        ShowMessage('Cidade não cadastrada!');
        _Status := 'FECHAR';
        Exit;
      end;
        EdtNomeCid.Text      :=FieldByName('T003_NOME').AsString;
        EdtUf.Text           :=FieldByName('T003_UF').AsString;
        EdtCEP.Text          :=FieldByName('T003_CEP').AsString;
        _Status        := 'NAVEGAR';
        Result         := True;
        Active := False;
        Active := True;
    end;

  except
  on e: exception do
  begin
    Result    := False;
    ShowMessage('Não é possivel realizar a consulta!' + #13#10 + e.Message);
  end;
  end;
end;


procedure TFrmCadEmpresa.LimpaCampos;
var
  i: Integer;
begin
  for i := 0 to FrmCadEmpresa.ComponentCount-1 do
  begin
  if FrmCadEmpresa.Components[i] is TEdit then
  (FrmCadEmpresa.Components[i] as TEdit).Clear;
  EdtCep.Clear;
  img.Picture :=Nil;
  end;
end;

procedure TFrmCadEmpresa.TamanhoForm;
begin
  FrmCadEmpresa.Width  :=530;
  FrmCadEmpresa.Height :=545;
end;

procedure TFrmCadEmpresa.BtCancelarClick(Sender: TObject);
begin
  if (_Status = 'INCLUIR') or (_Status = 'EDITAR') then
  begin
    LimpaCampos;
    HabilitaCampos('C');
    _Status := 'FECHAR';
    EdtCodigo.SetFocus;
  end;
end;

procedure TFrmCadEmpresa.BtEditarClick(Sender: TObject);
begin
  if (_Status = 'NAVEGAR') and (EdtCodigo.Text <> '') then
  begin
    Pg1.TabIndex:=0;
    HabilitaCampos('I');
    EdtNome.SetFocus;
    _Status := 'EDITAR';
  end;
end;

procedure TFrmCadEmpresa.BtIncluirClick(Sender: TObject);
begin
  if (_Status = 'FECHAR') or (_Status = 'NAVEGAR') then
  begin
    LimpaCampos;
    HabilitaCampos('I');
    _Status := 'INCLUIR';
    EdtNome.SetFocus;
  end;
end;

procedure TFrmCadEmpresa.BtSairClick(Sender: TObject);
begin
  if (_Status = 'FECHAR') or (_Status = 'NAVEGAR') then
  begin
    Close;
  end;
end;

procedure TFrmCadEmpresa.BtSalvarClick(Sender: TObject);
var
  Codigo: String;
  Transacao : TTransactionDesc;
begin
  if (EdtNome.Text='')or (EdtRS.Text='') then
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
            Sql.Add('INSERT INTO T001_EMPRESA(');
            Sql.Add('T001_NOME,');
            Sql.Add('T001_RAZAO_SOCIAL,');
            Sql.Add('T001_ENDERECO,');
            Sql.Add('T001_NUMERO,');
            Sql.Add('T001_BAIRRO,');
            Sql.Add('T001_COMPLEMENTO,');
            Sql.Add('T001_CNPJ,');
            Sql.Add('T001_IE,');
            Sql.Add('T001_TELEFONE,');
            Sql.Add('T001_CELULAR,');
            Sql.Add('T001_EMAIL,');
            Sql.Add('T001_LOGO,');
            Sql.Add('T003_CODIGO)');
            Sql.Add('VALUES(');
            Sql.Add(':T001_NOME,');
            Sql.Add(':T001_RAZAO_SOCIAL,');
            Sql.Add(':T001_ENDERECO,');
            Sql.Add(':T001_NUMERO,');
            Sql.Add(':T001_BAIRRO,');
            Sql.Add(':T001_COMPLEMENTO,');
            Sql.Add(':T001_CNPJ,');
            Sql.Add(':T001_IE,');
            Sql.Add(':T001_TELEFONE,');
            Sql.Add(':T001_CELULAR,');
            Sql.Add(':T001_EMAIL,');
            Sql.Add(':T001_LOGO');
            Sql.Add(':T003_CODIGO)');
          end;

          if _Status = 'EDITAR' then
          begin
            Sql.Add('UPDATE T001_EMPRESA SET');
            Sql.Add('T001_NOME=:T001_NOME,');
            Sql.Add('T001_RAZAO_SOCIAL=:T001_RAZAO_SOCIAL,');
            Sql.Add('T001_ENDERECO=:T001_ENDERECO,');
            Sql.Add('T001_NUMERO=:T001_NUMERO,');
            Sql.Add('T001_BAIRRO=:T001_BAIRRO,');
            Sql.Add('T001_COMPLEMENTO=:T001_COMPLEMENTO,');
            Sql.Add('T001_CNPJ=:T001_CNPJ,');
            Sql.Add('T001_IE=:T001_IE,');
            Sql.Add('T001_TELEFONE=:T001_TELEFONE,');
            Sql.Add('T001_CELULAR=:T001_CELULAR,');
            Sql.Add('T001_EMAIL=:T001_EMAIL,');
            Sql.Add('T001_LOGO=:T001_LOGO,');
            Sql.Add('T003_CODIGO=:T003_CODIGO');
            Sql.Add('WHERE T001_CODIGO=:T001_CODIGO');
            ParamByName('T001_CODIGO').AsInteger := StrToInt(EdtCodigo.Text);
          end;
            ParamByName('T001_NOME').AsString         :=EdtNome.Text;
            ParamByName('T001_RAZAO_SOCIAL').AsString :=EdtRS.Text;
            ParamByName('T001_ENDERECO').AsString     :=EdtEnde.Text;
            ParamByName('T001_NUMERO').AsString       :=EdtNr.Text;
            ParamByName('T001_BAIRRO').AsString       :=EdtBairro.Text;
            ParamByName('T001_COMPLEMENTO').AsString  :=EdtComp.Text;
            ParamByName('T001_CNPJ').AsString         :=EdtCNPJ.Text;
            ParamByName('T001_IE').AsString           :=EdtIE.Text;
            ParamByName('T001_TELEFONE').AsString     :=EdtTelefone.Text;
            ParamByName('T001_CELULAR').AsString      :=EdtCelular.Text;
            ParamByName('T001_EMAIL').AsString        :=EdtEmail.Text;
            ParamByName('T001_LOGO').Assign(img.Picture.Graphic);
            ParamByName('T003_CODIGO').AsString       :=EdtCodCid.Text;
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
             Sql.Add('SELECT MAX(T001_CODIGO)AS CODIGO FROM T001_EMPRESA');
             Sql.Add('WHERE T001_NOME=:T001_NOME');
             Sql.Add('AND T001_RAZAO_SOCIAL=:T001_RAZAO_SOCIAL');
             Sql.Add('AND T001_ENDERECO=:T001_ENDERECO');
             Sql.Add('AND	T001_NUMERO=:T001_NUMERO');
             Sql.Add('AND	T001_BAIRRO=:T001_BAIRRO');
             Sql.Add('AND	T001_COMPLEMENTO=:T001_COMPLEMENTO');
             Sql.Add('AND	T001_CNPJ=:T001_CNPJ');
             Sql.Add('AND	T001_IE=:T001_IE');
             Sql.Add('AND	T001_TELEFONE=:T001_TELEFONE');
             Sql.Add('AND	T001_CELULAR=:T001_CELULAR');
             Sql.Add('AND	T001_EMAIL=:T001_EMAIL');
             Sql.Add('AND	T001_LOGO=:T001_LOGO');
             Sql.Add('AND	T003_CODIGO=:T003_CODIGO');
             ParamByName('T001_NOME').AsString         :=EdtNome.Text;
             ParamByName('T001_RAZAO_SOCIAL').AsString :=EdtRS.Text;
             ParamByName('T001_ENDERECO').AsString     :=EdtEnde.Text;
             ParamByName('T001_NUMERO').AsString       :=EdtNr.Text;
             ParamByName('T001_BAIRRO').AsString       :=EdtBairro.Text;
             ParamByName('T001_COMPLEMENTO').AsString  :=EdtComp.Text;
             ParamByName('T001_CNPJ').AsString         :=EdtCNPJ.Text;
             ParamByName('T001_IE').AsString           :=EdtIE.Text;
             ParamByName('T001_TELEFONE').AsString     :=EdtTelefone.Text;
             ParamByName('T001_CELULAR').AsString      :=EdtCelular.Text;
             ParamByName('T001_EMAIL').AsString        :=EdtEmail.Text;
             ParamByName('T001_LOGO').Assign(img.Picture.Graphic);
             ParamByName('T003_CODIGO').AsString       :=EdtCodCid.Text;
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

procedure TFrmCadEmpresa.EdtCodCidExit(Sender: TObject);
begin
  if (_Status = 'INSERIR') or (_Status = 'EDITAR') then
 begin
  if EdtCodCid.Text = '' then
   begin
    EdtNomeCid.Clear;
    EdtUf.Clear;
    EdtCep.Clear;
   end;
   if EdtCodCid.Text <> '' then
    begin
     With QrCidade do
      begin
       Close;
       ParamByName('T003_CODIGO').AsInteger := Strtoint(EdtCodCid.Text);
       Open;
       if not isEmpty then
        begin
         EdtNomeCid.Text := FieldByName('T003_NOME').AsString;
         EdtUf.Text      := FieldByName('T003_UF').AsString;
         EdtCep.Text     := FieldByName('T003_CEP').AsString;
        end
        else
        begin
         //MsgAlerta('Cidade Não Cadastrada!', 'Alerta');
         EdtCodCid.Clear;
         EdtNomeCid.Clear;
         EdtUf.Clear;
         EdtCep.Clear;
         EdtCodCid.SetFocus;
        end;
       end;
    end;
  end;
end;

procedure TFrmCadEmpresa.EdtCodigoKeyPress(Sender: TObject; var Key: Char);
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
        Pg1.TabIndex:=0;
        LerCidade(EdtCodCid.Text);
      end;
    end;
  end;
  end;

procedure TFrmCadEmpresa.FormResize(Sender: TObject);
begin
  P1.Width := FrmCadEmpresa.Width;
end;

procedure TFrmCadEmpresa.FormShow(Sender: TObject);
begin
  TamanhoForm;
  LimpaCampos;
  HabilitaCampos('C');
  _Status := 'FECHAR';
  EdtCodigo.SetFocus;
  QrCidade.Active :=False;
  QrCidade.Active :=True;
end;

end.
