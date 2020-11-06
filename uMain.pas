unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.TCustomEditHelper,
  Vcl.Buttons, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, System.TypInfo;

type
  TAcaoPedido = (tapVer, tapIncluir, tapAlterar);
  TAcaoPedidoProduto = (tppVer, tppIncluir, tppAlterar);

  TfrmMain = class(TForm)
    lblPedidosVenda: TLabel;
    pnlCliente: TPanel;
    lblNomeCliente: TLabel;
    edtCodCliente: TEdit;
    pnlPedidos: TPanel;
    grpPedidosCliente: TGroupBox;
    dbgPedidos: TDBGrid;
    pnlAcoesPedido: TPanel;
    btnFazerPedido: TButton;
    btnAlterarPedido: TButton;
    btnExcluirPedido: TButton;
    pnlDetalhesPedido: TPanel;
    GroupBox1: TGroupBox;
    dbgPedidoProdutos: TDBGrid;
    lblCliente: TLabel;
    pnlGravarPedido: TPanel;
    btnGravarPedido: TButton;
    pnlDetalheGravar: TPanel;
    lblProduto: TLabel;
    lblQuantidade: TLabel;
    edtCodProduto: TEdit;
    edtQuantidade: TEdit;
    lblNomeProduto: TLabel;
    dsPedidos: TDataSource;
    dsPedidosProdutos: TDataSource;
    qryPedidos: TFDQuery;
    qryPedidoscodigo: TFDAutoIncField;
    qryPedidosdataemissao: TDateTimeField;
    qryPedidosvalortotal: TSingleField;
    qryPedidoscodcliente: TIntegerField;
    stbPedidos: TStatusBar;
    qryPedidosProdutos: TFDQuery;
    qryPedidosProdutoscodigo: TFDAutoIncField;
    qryPedidosProdutosdescricao: TStringField;
    qryPedidosProdutosquantidade: TIntegerField;
    qryPedidosProdutosvalorunitario: TSingleField;
    qryPedidosProdutoscodproduto: TIntegerField;
    btnCancelarPedido: TButton;
    btnBuscaCliente: TBitBtn;
    btnBuscaProduto: TBitBtn;
    btnAddProduto: TBitBtn;
    btnEdtProduto: TBitBtn;
    qryPedidosProdutosvalortotalpedido: TCurrencyField;
    qryPedidosProdutosvalortotal: TBCDField;
    btnDelProduto: TBitBtn;
    btnCanProduto: TBitBtn;
    btnBuscarPedido: TButton;
    btnBuscarCancelarPedido: TButton;
    procedure edtCodClienteExit(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBuscaProdutoClick(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure btnAddProdutoClick(Sender: TObject);
    procedure btnFazerPedidoClick(Sender: TObject);
    procedure dsPedidosDataChange(Sender: TObject; Field: TField);
    procedure btnExcluirPedidoClick(Sender: TObject);
    procedure btnAlterarPedidoClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnEdtProdutoClick(Sender: TObject);
    procedure btnDelProdutoClick(Sender: TObject);
    procedure qryPedidosProdutosCalcFields(DataSet: TDataSet);
    procedure qryPedidosProdutosAfterScroll(DataSet: TDataSet);
    procedure btnCanProdutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure btnBuscarCancelarPedidoClick(Sender: TObject);
  private
    { Private declarations }
    FAcaoPedido: TAcaoPedido;
    FAcaoPedidoProduto: TAcaoPedidoProduto;
    FValorTotalPedido: Currency;
    procedure CarregaPedidosCliente(pCodigoCliente: integer);
    procedure CarregaProdutosPedido(pCodigoPedido: integer);
    procedure setAcaoPedido(const Value: TAcaoPedido);
    function GravarProdutosPedido(pCodPedido, pCodProduto, pQtdProduto: integer; pValorProduto: Currency): Boolean;
    procedure setAcaoPedidoProduto(const Value: TAcaoPedidoProduto);
    procedure AtualizaValorTotalPedido;
    function CancelarPedido: Boolean;
    function BuscarPedidoPorCodigo(pCodPedido: integer; out pCodCliente: integer): Boolean;
    property AcaoPedido: TAcaoPedido read FAcaoPedido write setAcaoPedido;
    property AcaoPedidoProduto: TAcaoPedidoProduto read FAcaoPedidoProduto write setAcaoPedidoProduto;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uDM, uBusca;

function TfrmMain.GravarProdutosPedido(pCodPedido, pCodProduto, pQtdProduto: integer; pValorProduto: Currency): Boolean;
const
  SQLInsert: String = 'INSERT INTO pedidosprodutos (codpedido, codproduto, quantidade, valorunitario) VALUES (:codpedido, :codproduto, :quantidade, :valorunitario)';
  SQLUpdate: String = 'UPDATE pedidosprodutos SET codproduto = :codproduto, quantidade = :quantidade WHERE codigo = :codpedidoproduto';
var
  qryTmp: TFDQuery;
begin
  Result := True;
  qryTmp := TFDQuery.Create(nil);
  try
    dm.conMariaDB.StartTransaction;
    try
      qryTmp.Connection := dm.conMariaDB;
      qryTmp.SQL.Clear;
      case AcaoPedidoProduto of
        tppIncluir:
          begin
            qryTmp.SQL.Add(SQLInsert);
            qryTmp.Params.ParamByName('codpedido').Value := pCodPedido;
            qryTmp.Params.ParamByName('codproduto').Value := pCodProduto;
            qryTmp.Params.ParamByName('quantidade').Value := pQtdProduto;
            qryTmp.Params.ParamByName('valorunitario').AsCurrency := pValorProduto;
          end;
        tppAlterar:
          begin
            qryTmp.SQL.Add(SQLUpdate);
            qryTmp.Params.ParamByName('codproduto').Value := pCodProduto;
            qryTmp.Params.ParamByName('quantidade').Value := pQtdProduto;
            qryTmp.Params.ParamByName('codpedidoproduto').Value := qryPedidosProdutoscodigo.Value;
          end;
      end;
      qryTmp.ExecSQL;
      dm.conMariaDB.Commit;
    except
      Result := False;
      dm.conMariaDB.Rollback;
      raise;
    end;
  finally
    qryTmp.Free;
    qryPedidosProdutos.Close;
    qryPedidosProdutos.Open;
  end;
end;

procedure TfrmMain.qryPedidosProdutosAfterScroll(DataSet: TDataSet);
begin
  stbPedidos.Panels[2].Text := 'Valor do Pedido: ' + CurrToStrF(FValorTotalPedido, ffFixed, 2);
end;

procedure TfrmMain.qryPedidosProdutosCalcFields(DataSet: TDataSet);
begin
  FValorTotalPedido := FValorTotalPedido + qryPedidosProdutosvalortotal.AsCurrency;
end;

procedure TfrmMain.AtualizaValorTotalPedido;
begin
  dm.conMariaDB.StartTransaction;
  try
    qryPedidos.Edit;
    qryPedidosvalortotal.Value := FValorTotalPedido;
    qryPedidos.Post;
    dm.conMariaDB.Commit;
  except
    dm.conMariaDB.Rollback;
    raise;
  end;
end;

procedure TfrmMain.btnAddProdutoClick(Sender: TObject);
begin
  if lblNomeProduto.Caption <> '' then
  begin
    if GravarProdutosPedido(qryPedidoscodigo.Value, dm.qryProdutoscodigo.Value, StrToIntDef(edtQuantidade.Text, 0), dm.qryProdutosprecovenda.AsCurrency) then
    begin
      AtualizaValorTotalPedido;
      edtCodProduto.Clear;
      edtQuantidade.Clear;
      AcaoPedidoProduto := tppIncluir;
    end;
  end
  else
    ShowMessage('Informe o código do produto');

  edtCodProduto.SetFocus;
end;

procedure TfrmMain.btnBuscaClienteClick(Sender: TObject);
begin
  Application.CreateForm(TfrmBusca, frmBusca);
  try
    frmBusca.Caption := 'Buscar Cliente';
    frmBusca.dsDados.DataSet := dm.qryClientes;
    frmBusca.ShowModal;
    edtCodCliente.Text := dm.qryClientescodigo.AsString;
    edtCodClienteExit(Sender);
  finally
    frmBusca.Free;
  end;
end;

procedure TfrmMain.btnBuscaProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TfrmBusca, frmBusca);
  try
    if not dm.qryProdutos.Active then
      dm.qryProdutos.Open;

    frmBusca.Caption := 'Buscar Produto';
    frmBusca.dsDados.DataSet := dm.qryProdutos;
    frmBusca.ShowModal;
    edtCodProduto.Text := dm.qryProdutoscodigo.AsString;
    edtCodProdutoExit(Sender);
  finally
    frmBusca.Free;
  end;
end;

function TfrmMain.BuscarPedidoPorCodigo(pCodPedido: integer; out pCodCliente: integer): Boolean;
const
  SQLBuscaPedido: String = 'SELECT codcliente FROM pedidos WHERE codigo = :codpedido';
var
  qryTmp: TFDQuery;
begin
  pCodCliente := 0;
  Result := False;
  qryTmp := TFDQuery.Create(nil);
  try
    qryTmp.Connection := dm.conMariaDB;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(SQLBuscaPedido);
    qryTmp.Params.ParamByName('codpedido').Value := pCodPedido;
    qryTmp.Open;
    if qryTmp.RecordCount > 0 then
    begin
      pCodCliente := qryTmp.FieldByName('codcliente').Value;
      Result := True;
    end
    else
      ShowMessage('Pedido não localizado!');
  finally
    qryTmp.Free;
  end;
end;

procedure TfrmMain.btnBuscarCancelarPedidoClick(Sender: TObject);
var
  lCodPedido: String;
  lCodCliente: integer;
begin
  InputQuery('Cancelar pedido por código', 'Informe o código do pedido:', lCodPedido);
  if BuscarPedidoPorCodigo(StrToIntDef(lCodPedido, 0), lCodCliente) then
  begin
    edtCodCliente.Text := IntToStr(lCodCliente);
    edtCodClienteExit(Sender);
    qryPedidos.Locate('codigo', lCodPedido, []);
    btnExcluirPedidoClick(Sender);
  end;
end;

procedure TfrmMain.btnBuscarPedidoClick(Sender: TObject);
var
  lCodPedido: String;
  lCodCliente: integer;
begin
  InputQuery('Buscar pedido por código', 'Informe o código do pedido:', lCodPedido);
  if BuscarPedidoPorCodigo(StrToIntDef(lCodPedido, 0), lCodCliente) then
  begin
    edtCodCliente.Text := IntToStr(lCodCliente);
    edtCodClienteExit(Sender);
    qryPedidos.Locate('codigo', lCodPedido, []);
  end;
end;

procedure TfrmMain.btnCanProdutoClick(Sender: TObject);
begin
  edtCodProduto.Clear;
  edtQuantidade.Clear;
  AcaoPedidoProduto := tppIncluir;
  edtCodProduto.SetFocus;
end;

function TfrmMain.CancelarPedido: Boolean;
begin
  Result := False;
  if (not dbgPedidos.DataSource.DataSet.IsEmpty) then
  begin
    if MessageDlg('Confirma o cancelamento?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Result := True;
      case AcaoPedido of
        tapIncluir:
          begin
            dm.conMariaDB.StartTransaction;
            try
              qryPedidos.Delete;
              dm.conMariaDB.Commit;
              AcaoPedido := tapVer;
            except
              dm.conMariaDB.Rollback;
              raise;
            end;
          end;
      end;
      AcaoPedido := tapVer;
    end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if AcaoPedido in [tapIncluir, tapAlterar] then
  begin
    if not CancelarPedido then
      Abort;
  end;
end;

procedure TfrmMain.btnCancelarPedidoClick(Sender: TObject);
begin
  CancelarPedido;
end;

procedure TfrmMain.btnDelProdutoClick(Sender: TObject);
begin
  if (not dbgPedidoProdutos.DataSource.DataSet.IsEmpty) then
  begin
    if MessageDlg('Confirma a exclusão do Produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      dm.conMariaDB.StartTransaction;
      try
        qryPedidosProdutos.Delete;
        dm.conMariaDB.Commit;
        edtCodProduto.SetFocus;
        AtualizaValorTotalPedido;
      except
        dm.conMariaDB.Rollback;
        raise;
      end;
    end;
  end;
end;

procedure TfrmMain.btnEdtProdutoClick(Sender: TObject);
begin
  if (not dbgPedidoProdutos.DataSource.DataSet.IsEmpty) then
  begin
    edtCodProduto.Text := qryPedidosProdutoscodigo.AsString;
    edtCodProdutoExit(Sender);
    edtCodProduto.SetFocus;
    edtQuantidade.Text := qryPedidosProdutosquantidade.AsString;
    AcaoPedidoProduto := tppAlterar;
  end;
end;

procedure TfrmMain.btnExcluirPedidoClick(Sender: TObject);
begin
  if (not dbgPedidos.DataSource.DataSet.IsEmpty) then
  begin
    if MessageDlg('Confirma a exclusão do Pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      dm.conMariaDB.StartTransaction;
      try
        qryPedidos.Delete;
        dm.conMariaDB.Commit;
      except
        dm.conMariaDB.Rollback;
        raise;
      end;
    end;
  end;
end;

procedure TfrmMain.btnFazerPedidoClick(Sender: TObject);
begin
  dm.conMariaDB.StartTransaction;
  try
    qryPedidos.Insert;
    qryPedidoscodcliente.Value := dm.qryClientescodigo.Value;
    qryPedidosdataemissao.Value := Now();
    qryPedidosvalortotal.Value := 0;
    qryPedidos.Post;
    dm.conMariaDB.Commit;
    AcaoPedido := tapIncluir;
  except
    dm.conMariaDB.Rollback;
    raise;
  end;
end;

procedure TfrmMain.btnGravarPedidoClick(Sender: TObject);
begin
  ShowMessage('Pedido Realizado com Sucesso!');
  AcaoPedido := tapVer;
end;

procedure TfrmMain.CarregaPedidosCliente(pCodigoCliente: integer);
begin
  qryPedidos.Close;
  qryPedidos.Params.ParamByName('codcliente').Value := pCodigoCliente;
  qryPedidos.Open;
end;

procedure TfrmMain.CarregaProdutosPedido(pCodigoPedido: integer);
begin
  qryPedidosProdutos.Close;
  qryPedidosProdutos.Params.ParamByName('codpedido').Value := pCodigoPedido;
  qryPedidosProdutos.Open;
end;

procedure TfrmMain.dsPedidosDataChange(Sender: TObject; Field: TField);
begin
  stbPedidos.Panels[0].Text := 'Pedido: ' + qryPedidoscodigo.AsString;
  btnAlterarPedido.Enabled := qryPedidos.RecordCount > 0;
  btnExcluirPedido.Enabled := btnAlterarPedido.Enabled;
  stbPedidos.Panels[2].Text := '';
  FValorTotalPedido := 0;
  CarregaProdutosPedido(qryPedidoscodigo.Value);
end;

procedure TfrmMain.edtCodClienteExit(Sender: TObject);
begin
  btnBuscarPedido.Enabled := Trim(edtCodCliente.Text).IsEmpty;
  btnBuscarCancelarPedido.Enabled := Trim(edtCodCliente.Text).IsEmpty;

  if edtCodCliente.Text <> edtCodCliente.OldValue then
  begin
    edtCodCliente.OldValue := edtCodCliente.Text;
    AcaoPedido := tapVer;
    lblNomeCliente.Caption := '';
    if not dm.qryClientes.Active then
      dm.qryClientes.Open;
    if dm.qryClientes.Locate('codigo', IntToStr(StrToIntDef(edtCodCliente.Text, 0)), []) then
      lblNomeCliente.Caption := dm.qryClientesnome.Value + ' (' + dm.qryClientescidade.Value + ' - ' + dm.qryClientesuf.Value + ')';
    CarregaPedidosCliente(StrToIntDef(edtCodCliente.Text, 0));
  end;
  btnFazerPedido.Enabled := not Trim(lblNomeCliente.Caption).IsEmpty;
  if btnFazerPedido.Enabled then
    btnFazerPedido.SetFocus;

end;

procedure TfrmMain.edtCodProdutoExit(Sender: TObject);
begin
  if edtCodProduto.Text <> edtCodProduto.OldValue then
  begin
    lblNomeProduto.Caption := '';
    if not dm.qryProdutos.Active then
      dm.qryProdutos.Open;
    if dm.qryProdutos.Locate('codigo', StrToIntDef(edtCodProduto.Text, 0), []) then
      lblNomeProduto.Caption := dm.qryProdutosdescricao.Value;
  end;
  btnAddProduto.Enabled := ((not Trim(lblNomeProduto.Caption).IsEmpty) and (StrToIntDef(edtQuantidade.Text, 0) > 0));
end;

procedure TfrmMain.edtQuantidadeChange(Sender: TObject);
begin
  btnAddProduto.Enabled := ((not Trim(lblNomeProduto.Caption).IsEmpty) and (StrToIntDef(edtQuantidade.Text, 0) > 0) and ((AcaoPedido = tapAlterar) or (AcaoPedido = tapIncluir)));
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        if not((Screen.ActiveControl is TCustomMemo) or (Screen.ActiveControl is TCustomGrid) or (Screen.ActiveForm.ClassName = 'TMessageForm') or (Screen.ActiveControl is TButton))
        then
          Screen.ActiveForm.Perform(WM_NextDlgCtl, 0, 0);
        if dbgPedidos.Focused then
          btnAlterarPedidoClick(Sender);
        if dbgPedidoProdutos.Focused then
          btnEdtProdutoClick(Sender);
      end;
    VK_DELETE:
      begin
        if dbgPedidos.Focused then
          btnExcluirPedidoClick(Sender);
        if dbgPedidoProdutos.Focused then
          btnDelProdutoClick(Sender);
      end;
    VK_F3:
      begin
        if edtCodCliente.Focused then
          btnBuscaClienteClick(Sender);
        if edtCodProduto.Focused then
          btnBuscaProdutoClick(Sender);
      end;
  end;
end;

procedure TfrmMain.setAcaoPedido(const Value: TAcaoPedido);
begin
  FAcaoPedido := Value;
  case AcaoPedido of
    tapVer:
      begin
        stbPedidos.Panels[1].Text := 'Status: Vendo o Pedido.';
        dbgPedidos.Enabled := True;
        dbgPedidos.Repaint;
        dbgPedidoProdutos.Enabled := True;
        pnlDetalhesPedido.Enabled := True;
        pnlDetalheGravar.Enabled := False;
        pnlCliente.Enabled := True;
        btnAlterarPedido.Enabled := False;
        btnFazerPedido.Enabled := True;
        btnAlterarPedido.Enabled := True;
        btnExcluirPedido.Enabled := True;
        btnGravarPedido.Enabled := False;
        btnCancelarPedido.Enabled := False;

        btnAddProduto.Enabled := False;
        btnEdtProduto.Enabled := False;
        btnDelProduto.Enabled := False;
      end;
    tapIncluir:
      begin
        AcaoPedidoProduto := tppIncluir;
        stbPedidos.Panels[1].Text := 'Status: Fazendo Pedido.';
        pnlDetalhesPedido.Enabled := True;
        pnlCliente.Enabled := False;
        btnAlterarPedido.Enabled := True;
        dbgPedidos.Enabled := False;
        btnFazerPedido.Enabled := False;
        btnAlterarPedido.Enabled := False;
        btnExcluirPedido.Enabled := False;
        btnGravarPedido.Enabled := True;
        btnCancelarPedido.Enabled := True;
        pnlDetalheGravar.Enabled := True;
        edtCodProduto.SetFocus;

        btnAddProduto.Enabled := True;
        btnEdtProduto.Enabled := True;
        btnDelProduto.Enabled := True;
      end;
    tapAlterar:
      begin
        AcaoPedidoProduto := tppIncluir;
        pnlCliente.Enabled := False;
        stbPedidos.Panels[1].Text := 'Status: Alterando Pedido.';
        pnlDetalhesPedido.Enabled := True;
        btnAlterarPedido.Enabled := True;
        dbgPedidos.Enabled := False;
        btnFazerPedido.Enabled := False;
        btnAlterarPedido.Enabled := False;
        btnExcluirPedido.Enabled := False;
        btnGravarPedido.Enabled := True;
        btnCancelarPedido.Enabled := True;
        pnlDetalheGravar.Enabled := True;
        edtCodProduto.SetFocus;

        btnAddProduto.Enabled := True;
        btnEdtProduto.Enabled := True;
        btnDelProduto.Enabled := True;
      end;
  end;
end;

procedure TfrmMain.setAcaoPedidoProduto(const Value: TAcaoPedidoProduto);
begin
  FAcaoPedidoProduto := Value;
  case AcaoPedidoProduto of
    tppIncluir:
      begin
        btnEdtProduto.Enabled := True;
        btnDelProduto.Enabled := True;
        dbgPedidoProdutos.Enabled := True;
        btnCanProduto.Enabled := False;
      end;
    tppAlterar:
      begin
        btnEdtProduto.Enabled := False;
        btnDelProduto.Enabled := False;
        dbgPedidoProdutos.Enabled := False;
        btnCanProduto.Enabled := True;
      end;
  end;
end;

procedure TfrmMain.btnAlterarPedidoClick(Sender: TObject);
begin
  if (not dbgPedidos.DataSource.DataSet.IsEmpty) then
    AcaoPedido := tapAlterar;
end;

end.
