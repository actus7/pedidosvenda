unit uBusca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmBusca = class(TForm)
    dbgDados: TDBGrid;
    dsDados: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBusca: TfrmBusca;

implementation

{$R *.dfm}

uses
  uDM;

procedure TfrmBusca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (Key = VK_RETURN) then
    Close;
end;

procedure TfrmBusca.FormShow(Sender: TObject);
begin
  if not dm.qryClientes.Active then
    dm.qryClientes.Open;
end;

end.
