program MoxaLink;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmMain},
  OptionFrm in 'OptionFrm.pas' {frmOption};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOption, frmOption);
  Application.Run;
end.
