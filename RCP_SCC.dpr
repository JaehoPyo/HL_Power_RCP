program RCP_SCC;

uses
  Forms,
  U_SCComm in 'U_SCComm.pas' {frmSCComm},
  d_MainDm in 'Lib\d_MainDm.pas' {MainDm: TDataModule},
  h_MainLib in 'Lib\h_MainLib.pas',
  h_ReferLib in 'Lib\h_ReferLib.pas',
  FileLib in 'Lib\FileLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SC ????';
  Application.CreateForm(TMainDm, MainDm);
  Application.CreateForm(TfrmSCComm, frmSCComm);
  Application.Run;
end.
