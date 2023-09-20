object FrmConectaBanco: TFrmConectaBanco
  Left = 351
  Top = 220
  BorderIcons = []
  Caption = 'Conex'#227'o com banco de dados...'
  ClientHeight = 210
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 531
    Height = 65
    Align = alTop
    Caption = 'Configura'#231#245'es Conex'#227'o com Base de Dados.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 75
    Width = 531
    Height = 135
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 166
      Height = 16
      Caption = 'Caminho banco de dados:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdtBase: TEdit
      Left = 8
      Top = 38
      Width = 394
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object BtLocalizaBase: TBitBtn
      Left = 408
      Top = 38
      Width = 97
      Height = 25
      Caption = 'Localizar Base'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtLocalizaBaseClick
    end
    object BtConectar: TBitBtn
      Left = 99
      Top = 88
      Width = 86
      Height = 33
      Caption = 'Conectar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BtConectarClick
    end
    object BtSair: TBitBtn
      Left = 248
      Top = 88
      Width = 86
      Height = 33
      Caption = 'Sair'
      TabOrder = 3
      OnClick = BtSairClick
    end
  end
  object Od1: TOpenDialog
    Filter = 'Firebird Databases|*.FDB'
    Left = 448
    Top = 56
  end
end
