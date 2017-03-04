program ControlSearch;

uses
  Vcl.Forms,
  ControlSearchFrm in 'ControlSearchFrm.pas' {ControlSearchDlg},
  ControlSearchLib in 'ControlSearchLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TControlSearchDlg, ControlSearchDlg);
  Application.Run;
end.
