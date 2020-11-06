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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
