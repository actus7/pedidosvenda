unit Pedidos.Utils;

interface

uses
  Vcl.Dialogs, Vcl.Controls, uDm, Classes.SQL, Pedidos.Tipos;

type
  TPedidos = class
  private
    class function Pergunta(const pMsg: string): Boolean; static;
  public
    class function GravarProdutosPedido(const pCodPedido, pCodProduto, pQtdProduto: integer; pValorProduto: Currency; pAcaoPedidoProduto: TAcaoPedidoProduto): Boolean; static;
    class function RemoverProdutoPedido(const pCodPedidoProduto: integer): Boolean; static;

  public
  end;

implementation

class function TPedidos.Pergunta(const pMsg: string): Boolean;
begin
  Result := MessageDlg(pMsg, MtConfirmation, mbOKCancel, 0) = mrOk;
end;

{ TPedidos }

class function TPedidos.GravarProdutosPedido(const pCodPedido, pCodProduto, pQtdProduto: integer; pValorProduto: Currency; pAcaoPedidoProduto: TAcaoPedidoProduto): Boolean;
var
  lSQLAbstract: ISQLAbstract;
  procedure AtualizaValorTotalPedido;
  begin
    lSQLAbstract := TSQLAbstract.Create('pedidos');
    lSQLAbstract.AddPair(TPairFloat.Create('valortotal', dm.FValorTotalPedido));
    lSQLAbstract.AddKeyPair(TPairInteger.Create('codigo', pCodPedido));
    dm.conMariaDB.ExecSQL(lSQLAbstract.GetUpdateInstruction);
  end;

begin
  Result := False;
  dm.conMariaDB.StartTransaction;
  try
    lSQLAbstract := TSQLAbstract.Create('pedidosprodutos');
    lSQLAbstract.AddPair(TPairInteger.Create('codpedido', pCodPedido));
    lSQLAbstract.AddPair(TPairInteger.Create('codproduto', pCodProduto));
    lSQLAbstract.AddPair(TPairInteger.Create('quantidade', pQtdProduto));
    lSQLAbstract.AddPair(TPairFloat.Create('valorunitario', pValorProduto));
    case pAcaoPedidoProduto of
      tppIncluir:
        Result := dm.conMariaDB.ExecSQL(lSQLAbstract.GetInsertInstruction) = 1;
      tppAlterar:
        begin
          lSQLAbstract.AddKeyPair(TPairInteger.Create('codigo', dm.qryPedidosProdutoscodigo.Value));
          Result := dm.conMariaDB.ExecSQL(lSQLAbstract.GetUpdateInstruction) = 1;
        end;
    end;
    if Result then
      AtualizaValorTotalPedido;
    dm.conMariaDB.Commit;
  except
    dm.conMariaDB.Rollback;
    raise;
  end;
end;

class function TPedidos.RemoverProdutoPedido(const pCodPedidoProduto: integer): Boolean;
var
  lSQLAbstract: ISQLAbstract;
begin
  Result := False;
  if Pergunta('Confirma a exclusão do Produto?') then
  begin
    dm.conMariaDB.StartTransaction;
    try
      lSQLAbstract := TSQLAbstract.Create('pedidosprodutos');
      lSQLAbstract.AddKeyPair(TPairInteger.Create('codigo', pCodPedidoProduto));
      Result := dm.conMariaDB.ExecSQL(lSQLAbstract.GetDeleteInstruction) = 1;
      dm.conMariaDB.Commit;
    except
      dm.conMariaDB.Rollback;
      raise;
    end;
  end;
end;

end.
