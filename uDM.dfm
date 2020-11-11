object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 320
  Width = 484
  object conMariaDB: TFDConnection
    Params.Strings = (
      'Database=pedidos'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
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
      ReadOnly = True
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
  object qryPedidos: TFDQuery
    Connection = conMariaDB
    SQL.Strings = (
      
        'select pedidos.codigo, pedidos.dataemissao, pedidos.valortotal, ' +
        'pedidos.codcliente'
      'from pedidos'
      'inner join clientes on clientes.codigo = pedidos.codcliente'
      'where pedidos.codcliente = :codcliente')
    Left = 257
    Top = 12
    ParamData = <
      item
        Name = 'CODCLIENTE'
        ParamType = ptInput
      end>
    object qryPedidoscodigo: TFDAutoIncField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPedidosdataemissao: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data da Emiss'#227'o'
      FieldName = 'dataemissao'
      Origin = 'dataemissao'
      Required = True
    end
    object qryPedidosvalortotal: TSingleField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 20
      FieldName = 'valortotal'
      Origin = 'valortotal'
      Required = True
      EditFormat = '###,###,##0.00'
    end
    object qryPedidoscodcliente: TIntegerField
      FieldName = 'codcliente'
      Origin = 'codcliente'
      Required = True
      Visible = False
    end
  end
  object qryPedidosProdutos: TFDQuery
    OnCalcFields = qryPedidosProdutosCalcFields
    Connection = conMariaDB
    SQL.Strings = (
      'select pedidosprodutos.codigo,'
      '       pedidosprodutos.codproduto, '
      '       produtos.descricao, '
      '       pedidosprodutos.quantidade, '
      '       pedidosprodutos.valorunitario, '
      
        '       CAST(pedidosprodutos.quantidade * pedidosprodutos.valorun' +
        'itario AS DECIMAL(10,2)) as valortotal'
      'from pedidosprodutos'
      
        'inner join pedidos on pedidos.codigo = pedidosprodutos.codpedido' +
        ' '
      
        'inner join produtos on produtos.codigo = pedidosprodutos.codprod' +
        'uto'
      'where pedidos.codigo = :codpedido')
    Left = 257
    Top = 64
    ParamData = <
      item
        Name = 'CODPEDIDO'
        ParamType = ptInput
      end>
    object qryPedidosProdutoscodigo: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPedidosProdutoscodproduto: TIntegerField
      FieldName = 'codproduto'
      Origin = 'codproduto'
      Required = True
      Visible = False
    end
    object qryPedidosProdutosdescricao: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Produto'
      DisplayWidth = 30
      FieldName = 'descricao'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
    object qryPedidosProdutosquantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 10
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object qryPedidosProdutosvalorunitario: TSingleField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorunitario'
      Origin = 'valorunitario'
      Required = True
      EditFormat = '###,###,##0.00'
    end
    object qryPedidosProdutosvalortotal: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Total'
      DisplayWidth = 10
      FieldName = 'valortotal'
      Origin = 'valortotal'
      ProviderFlags = []
      ReadOnly = True
      EditFormat = '###,###,##0.00'
      Precision = 10
      Size = 2
    end
    object qryPedidosProdutosvalortotalpedido: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'valortotalpedido'
      Visible = False
      Calculated = True
    end
  end
end
