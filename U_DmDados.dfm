object DmDados: TDmDados
  OldCreateOrder = False
  Left = 284
  Top = 171
  Height = 404
  Width = 553
  object Conexao: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=C:\Sistema\Base\BANCO.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Connected = True
    Left = 48
    Top = 56
  end
  object QrCalculo: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Conexao
    Left = 216
    Top = 56
  end
  object QrGravar: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Conexao
    Left = 136
    Top = 56
  end
end
