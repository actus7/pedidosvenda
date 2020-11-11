unit uPedido;

interface

uses
  Generics.Collections;

Type
  TPedido = class
  private
    { private declarations }
    FCodigo: Integer;
    FCodCliente: Integer;
    FDataEmissao: TDateTime;
    //FProdutosPedido: TObjectList<TProduto>;
  protected
    { protected declarations }
  public
    { public declarations }
    function AddPedido: Boolean;
    function EdtPedido: Boolean;
    function DelPedido: Boolean;
    function BuscaPedido: Boolean;

    property Codigo: Integer read FCodigo write FCodigo;
    property CodCliente: Integer read FCodCliente write FCodCliente;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    //property ProdutosPedido: TObjectList<TProduto> read FProdutosPedido write FProdutosPedido;
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarProduto(pProduto: String);
  published
    { published declarations }
  end;

implementation

uses
  uDM;

{ TPedido }

function TPedido.AddPedido: Boolean;
begin

end;

procedure TPedido.AdicionarProduto(pProduto: String);
begin
  dm.qryPClientes.Close;
  dm.qryClientes.Insert;
  dm.qryClientes

end;

function TPedido.BuscaPedido: Boolean;
begin

end;

constructor TPedido.Create;
begin

end;

function TPedido.DelPedido: Boolean;
begin

end;

destructor TPedido.Destroy;
begin

  inherited;
end;

function TPedido.EdtPedido: Boolean;
begin

end;

end.
