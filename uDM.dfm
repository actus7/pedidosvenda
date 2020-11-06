object dm: Tdm
  OldCreateOrder = False
  Height = 164
  Width = 303
  object conMariaDB: TFDConnection
    Params.Strings = (
      'Database=pedidos'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object fdphysmysqldrvrlnk1: TFDPhysMySQLDriverLink
    VendorLib = 'D:\Projetos\Delphi\pedidosvendas\Lib\libmysql.dll'
    Left = 40
    Top = 64
  end
  object qryClientes: TFDQuery
    Connection = conMariaDB
    SQL.Strings = (
      'select * from clientes')
    Left = 168
    Top = 8
    object qryClientescodigo: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 7
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryClientesnome: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 30
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 60
    end
    object qryClientescidade: TStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 25
      FieldName = 'cidade'
      Origin = 'cidade'
      Required = True
      Size = 60
    end
    object qryClientesuf: TStringField
      DisplayLabel = 'UF'
      DisplayWidth = 5
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      FixedChar = True
      Size = 2
    end
  end
  object qryProdutos: TFDQuery
    Connection = conMariaDB
    SQL.Strings = (
      'select * from produtos')
    Left = 168
    Top = 64
    object qryProdutoscodigo: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 8
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryProdutosdescricao: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 35
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 150
    end
    object qryProdutosprecovenda: TSingleField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'precovenda'
      Origin = 'precovenda'
      Required = True
    end
  end
end
