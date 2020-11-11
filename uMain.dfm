object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 598
  ClientWidth = 565
  Color = clBtnFace
  Constraints.MinHeight = 572
  Constraints.MinWidth = 581
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblPedidosVenda: TLabel
    Left = 0
    Top = 0
    Width = 565
    Height = 33
    Align = alTop
    Alignment = taCenter
    Caption = 'Pedidos de Venda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 211
  end
  object pnlCliente: TPanel
    Left = 0
    Top = 33
    Width = 565
    Height = 61
    Align = alTop
    TabOrder = 0
    DesignSize = (
      565
      61)
    object lblNomeCliente: TLabel
      Left = 171
      Top = 37
      Width = 3
      Height = 13
    end
    object lblCliente: TLabel
      Left = 36
      Top = 37
      Width = 37
      Height = 13
      Caption = 'Cliente:'
    end
    object edtCodCliente: TEdit
      Left = 79
      Top = 33
      Width = 50
      Height = 21
      Hint = 'Informe o c'#243'digo do Cliente (F3 - para consulta)'
      Alignment = taRightJustify
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnExit = edtCodClienteExit
    end
    object btnBuscaCliente: TBitBtn
      Left = 135
      Top = 33
      Width = 30
      Height = 21
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFC0C0C0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF383838060606C0C0C0FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3737
        37000000383838FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF363636000000383838FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF9A9A9A777777838383BCBCBCFF00FFFF00FF3636360000003737
        37FF00FFFF00FFFF00FFFF00FFFF00FF79797905050500000000000000000000
        00002D2D2D878787000000363636FF00FFFF00FFFF00FFFF00FFFF00FF5F5F5F
        0000001B1B1B8A8A8ABCBCBCADADAD595959000000000000878787FF00FFFF00
        FFFF00FFFF00FFFF00FFB0B0B0000000323232FF00FFFF00FFFF00FFFF00FFFF
        00FFA7A7A70000002D2D2DFF00FFFF00FFFF00FFFF00FFFF00FF444444000000
        D3D3D3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF595959000000BCBCBCFF00
        FFFF00FFFF00FFFF00FF0D0D0D272727FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFADADAD000000838383FF00FFFF00FFFF00FFFF00FF030303353535
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBCBC000000777777FF00
        FFFF00FFFF00FFFF00FF2424240D0D0DFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF8A8A8A0000009A9A9AFF00FFFF00FFFF00FFFF00FF767676000000
        848484FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B1B1B050505FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF161616010101848484FF00FFFF00FFFF00FFD3
        D3D3323232000000797979FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCCCCCC
        1616160000000D0D0D3535352727270000000000005F5F5FFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676762424240303030D0D0D44
        4444B0B0B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnBuscaClienteClick
    end
    object btnBuscarPedido: TButton
      Left = 212
      Top = 6
      Width = 140
      Height = 21
      Anchors = [akTop]
      Caption = 'Buscar Pedido'
      TabOrder = 2
      OnClick = btnBuscarPedidoClick
    end
    object btnBuscarCancelarPedido: TButton
      Left = 400
      Top = 6
      Width = 140
      Height = 21
      Anchors = [akTop]
      Caption = 'Cancelar Pedido'
      TabOrder = 3
      OnClick = btnBuscarCancelarPedidoClick
    end
  end
  object pnlPedidos: TPanel
    Left = 0
    Top = 128
    Width = 565
    Height = 154
    Align = alTop
    TabOrder = 2
    object grpPedidosCliente: TGroupBox
      Left = 1
      Top = 1
      Width = 563
      Height = 152
      Align = alClient
      Caption = 'Lista de Pedidos do Cliente'
      TabOrder = 0
      object dbgPedidos: TDBGrid
        Left = 2
        Top = 15
        Width = 559
        Height = 135
        Align = alClient
        DataSource = dsPedidos
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object pnlAcoesPedido: TPanel
    Left = 0
    Top = 94
    Width = 565
    Height = 34
    Align = alTop
    TabOrder = 1
    DesignSize = (
      565
      34)
    object btnFazerPedido: TButton
      Left = 25
      Top = 6
      Width = 140
      Height = 21
      Anchors = [akTop]
      Caption = 'Fazer Pedido'
      Enabled = False
      TabOrder = 0
      OnClick = btnFazerPedidoClick
    end
    object btnAlterarPedido: TButton
      Left = 212
      Top = 6
      Width = 140
      Height = 21
      Anchors = [akTop]
      Caption = 'Alterar Pedido'
      Enabled = False
      TabOrder = 1
      OnClick = btnAlterarPedidoClick
    end
    object btnExcluirPedido: TButton
      Left = 400
      Top = 6
      Width = 140
      Height = 21
      Anchors = [akTop]
      Caption = 'Excluir Pedido'
      Enabled = False
      TabOrder = 2
      OnClick = btnExcluirPedidoClick
    end
  end
  object pnlDetalhesPedido: TPanel
    Left = 0
    Top = 282
    Width = 565
    Height = 263
    Align = alClient
    TabOrder = 3
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 563
      Height = 261
      Align = alClient
      Caption = 'Produtos do Pedido'
      TabOrder = 0
      object dbgPedidoProdutos: TDBGrid
        Left = 2
        Top = 81
        Width = 559
        Height = 178
        Align = alClient
        DataSource = dsPedidosProdutos
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object pnlDetalheGravar: TPanel
        Left = 2
        Top = 15
        Width = 559
        Height = 66
        Align = alTop
        TabOrder = 0
        object lblProduto: TLabel
          Left = 28
          Top = 11
          Width = 42
          Height = 13
          Caption = 'Produto:'
        end
        object lblQuantidade: TLabel
          Left = 10
          Top = 38
          Width = 60
          Height = 13
          Caption = 'Quantidade:'
        end
        object lblNomeProduto: TLabel
          Left = 168
          Top = 11
          Width = 3
          Height = 13
        end
        object edtCodProduto: TEdit
          Left = 76
          Top = 8
          Width = 50
          Height = 21
          Hint = 'Informe o c'#243'digo do Produto (F3 - para consulta)'
          Alignment = taRightJustify
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnExit = edtCodProdutoExit
        end
        object edtQuantidade: TEdit
          Left = 76
          Top = 35
          Width = 50
          Height = 21
          Alignment = taRightJustify
          TabOrder = 1
          OnChange = edtQuantidadeChange
        end
        object btnBuscaProduto: TBitBtn
          Left = 132
          Top = 8
          Width = 30
          Height = 21
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFC0C0C0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FF383838060606C0C0C0FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3737
            37000000383838FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF363636000000383838FF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF9A9A9A777777838383BCBCBCFF00FFFF00FF3636360000003737
            37FF00FFFF00FFFF00FFFF00FFFF00FF79797905050500000000000000000000
            00002D2D2D878787000000363636FF00FFFF00FFFF00FFFF00FFFF00FF5F5F5F
            0000001B1B1B8A8A8ABCBCBCADADAD595959000000000000878787FF00FFFF00
            FFFF00FFFF00FFFF00FFB0B0B0000000323232FF00FFFF00FFFF00FFFF00FFFF
            00FFA7A7A70000002D2D2DFF00FFFF00FFFF00FFFF00FFFF00FF444444000000
            D3D3D3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF595959000000BCBCBCFF00
            FFFF00FFFF00FFFF00FF0D0D0D272727FF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFADADAD000000838383FF00FFFF00FFFF00FFFF00FF030303353535
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBCBC000000777777FF00
            FFFF00FFFF00FFFF00FF2424240D0D0DFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FF8A8A8A0000009A9A9AFF00FFFF00FFFF00FFFF00FF767676000000
            848484FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B1B1B050505FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF161616010101848484FF00FFFF00FFFF00FFD3
            D3D3323232000000797979FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCCCCCC
            1616160000000D0D0D3535352727270000000000005F5F5FFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676762424240303030D0D0D44
            4444B0B0B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 6
          OnClick = btnBuscaProdutoClick
        end
        object btnAddProduto: TBitBtn
          Left = 132
          Top = 35
          Width = 88
          Height = 21
          Caption = 'Gravar'
          Enabled = False
          TabOrder = 2
          OnClick = btnAddProdutoClick
        end
        object btnEdtProduto: TBitBtn
          Left = 320
          Top = 35
          Width = 88
          Height = 21
          Caption = 'Altear'
          Enabled = False
          TabOrder = 4
          OnClick = btnEdtProdutoClick
        end
        object btnDelProduto: TBitBtn
          Left = 414
          Top = 35
          Width = 88
          Height = 21
          Caption = 'Excluir'
          Enabled = False
          TabOrder = 5
          OnClick = btnDelProdutoClick
        end
        object btnCanProduto: TBitBtn
          Left = 226
          Top = 35
          Width = 88
          Height = 21
          Caption = 'Cancelar'
          Enabled = False
          TabOrder = 3
          OnClick = btnCanProdutoClick
        end
      end
    end
  end
  object pnlGravarPedido: TPanel
    Left = 0
    Top = 545
    Width = 565
    Height = 34
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      565
      34)
    object btnGravarPedido: TButton
      Left = 212
      Top = 5
      Width = 140
      Height = 21
      Anchors = [akTop]
      Caption = 'Gravar'
      Enabled = False
      TabOrder = 0
      OnClick = btnGravarPedidoClick
    end
    object btnCancelarPedido: TButton
      Left = 400
      Top = 5
      Width = 140
      Height = 21
      Anchors = [akTop]
      Caption = 'Cancelar'
      Enabled = False
      TabOrder = 1
      OnClick = btnCancelarPedidoClick
    end
  end
  object stbPedidos: TStatusBar
    Left = 0
    Top = 579
    Width = 565
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 250
      end
      item
        Width = 50
      end>
  end
  object dsPedidos: TDataSource
    DataSet = dm.qryPedidos
    OnDataChange = dsPedidosDataChange
    Left = 241
    Top = 204
  end
  object dsPedidosProdutos: TDataSource
    DataSet = dm.qryPedidosProdutos
    OnDataChange = dsPedidosProdutosDataChange
    Left = 241
    Top = 398
  end
end
