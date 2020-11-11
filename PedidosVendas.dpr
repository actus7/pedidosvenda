program PedidosVendas;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Vcl.TCustomEditHelper in 'Vcl.TCustomEditHelper.pas',
  uDM in 'uDM.pas' {dm: TDataModule},
  uBusca in 'uBusca.pas' {frmBusca},
  Classes.SQL in 'Classes.SQL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
