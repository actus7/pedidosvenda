object frmBusca: TfrmBusca
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Buscar'
  ClientHeight = 241
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgDados: TDBGrid
    Left = 0
    Top = 0
    Width = 485
    Height = 204
    Align = alClient
    DataSource = dsDados
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlBotao: TPanel
    Left = 0
    Top = 204
    Width = 485
    Height = 37
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 205
    object btnOk: TButton
      Left = 384
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object dsDados: TDataSource
    Left = 176
    Top = 80
  end
end
