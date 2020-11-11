unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  Tdm = class(TDataModule)
    conMariaDB: TFDConnection;
    fdphysmysqldrvrlnk1: TFDPhysMySQLDriverLink;
    qryClientes: TFDQuery;
    qryClientescodigo: TFDAutoIncField;
    qryClientesnome: TStringField;
    qryClientescidade: TStringField;
    qryClientesuf: TStringField;
    qryProdutos: TFDQuery;
    qryProdutoscodigo: TFDAutoIncField;
    qryProdutosdescricao: TStringField;
    qryProdutosprecovenda: TSingleField;
    qryPedidos: TFDQuery;
    qryPedidoscodigo: TFDAutoIncField;
    qryPedidosdataemissao: TDateTimeField;
    qryPedidosvalortotal: TSingleField;
    qryPedidoscodcliente: TIntegerField;
    qryPedidosProdutos: TFDQuery;
    qryPedidosProdutoscodigo: TFDAutoIncField;
    qryPedidosProdutoscodproduto: TIntegerField;
    qryPedidosProdutosdescricao: TStringField;
    qryPedidosProdutosquantidade: TIntegerField;
    qryPedidosProdutosvalorunitario: TSingleField;
    qryPedidosProdutosvalortotal: TBCDField;
    qryPedidosProdutosvalortotalpedido: TCurrencyField;
    procedure qryPedidosProdutosCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FValorTotalPedido: Currency;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  FValorTotalPedido := 0;
end;

procedure Tdm.qryPedidosProdutosCalcFields(DataSet: TDataSet);
begin
  FValorTotalPedido := FValorTotalPedido + dm.qryPedidosProdutosvalortotal.AsCurrency;
end;

end.
