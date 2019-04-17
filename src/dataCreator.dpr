program dataCreator;

uses
  Vcl.Forms,
  umain in 'umain.pas' {frmMain},
  uAddFieldDialog in 'uAddFieldDialog.pas' {frmAddFieldDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAddFieldDialog, frmAddFieldDialog);
  Application.Run;
end.
