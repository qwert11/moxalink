unit OptionFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  TfrmOption = class(TForm)
    cbbProcedure: TComboBox;
    btnSave: TButton;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetParam;
  end;

  function ReadIni(ASection, AString : String) : String;
  procedure WriteIni(ASection, AString, AValue : String);

var
  frmOption: TfrmOption;

implementation

{$R *.dfm}

function ReadIni(ASection, AString : String) : String;
var
  sIniFile: TIniFile;
  sPath: String[60];
begin
  GetDir(0, sPath);
  sIniFile := TIniFile.Create(sPath + '\Config.INI');
  try
    Result := sIniFile.ReadString(ASection, AString, ' ');
  finally
    sIniFile.Free;
  end;
end;

procedure WriteIni(ASection, AString, AValue : String);
var
  sIniFile: TIniFile;
  sPath: String[60];
begin
  GetDir(0, sPath);
  sIniFile := TIniFile.Create(sPath + '\Config.INI');
  try
    sIniFile.WriteString(ASection, AString, AValue);
  finally
    sIniFile.Free;
  end;
end;

{ TfrmOption }

procedure TfrmOption.SetParam;
var
  oo: string;
  I: Integer;
begin
  oo := ReadIni('Window', 'FunctionOne');
  for I := 0 to cbbProcedure.Items.Count - 1 do
    if oo = cbbProcedure.Items[I] then
      cbbProcedure.ItemIndex := I
end;

procedure TfrmOption.btnSaveClick(Sender: TObject);
begin
  WriteIni('Window', 'FunctionOne', cbbProcedure.Items[cbbProcedure.ItemIndex])
end;

end.
