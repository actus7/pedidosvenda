program PedidosVendas;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Vcl.TCustomEditHelper in 'Vcl.TCustomEditHelper.pas',
  uDM in 'uDM.pas' {dm: TDataModule},
  uBusca in 'uBusca.pas' {frmBusca};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmBusca, frmBusca);
  Application.Run;
end.
