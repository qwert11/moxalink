unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdTelnet, StdCtrls, ExtCtrls, IdGlobal, ComCtrls, Menus;

type
  TfrmMain = class(TForm)
    idtlnt1: TIdTelnet;
    btnConnectMoxa: TButton;
    btnDisconnectMoxa: TButton;
    btn3: TButton;
    edt1: TEdit;
    mmoLog: TMemo;
    btn4: TButton;
    pnl1: TPanel;
    btn5: TButton;
    dlgOpen1: TOpenDialog;
    btn6: TButton;
    chkConvert: TCheckBox;
    chkDel0: TCheckBox;
    stat1: TStatusBar;
    chkConvertVithOrig: TCheckBox;
    chkStik: TCheckBox;
    btnAllData: TButton;
    btnReadLn: TButton;
    mm1: TMainMenu;
    File1: TMenuItem;
    Option1: TMenuItem;
    mniGit1: TMenuItem;
    procedure btnConnectMoxaClick(Sender: TObject);
    procedure btnDisconnectMoxaClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure edt1Change(Sender: TObject);
    procedure edt1Click(Sender: TObject);
    procedure chkConvertClick(Sender: TObject);
    procedure chkDel0Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkConvertVithOrigClick(Sender: TObject);
    procedure btnAllDataClick(Sender: TObject);
    procedure btnReadLnClick(Sender: TObject);
    procedure Option1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mniGit1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SendChFromStr(s: string);
    procedure GetText;
    procedure GetTextWaitFor;
    procedure GetTextAllData;
    procedure GetTextReadLn;
    procedure GetLine;
    procedure ConnectToMoxa;

    procedure StatProc;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses OptionFrm;

{$R *.dfm}

procedure TfrmMain.btnConnectMoxaClick(Sender: TObject);
begin
  ConnectToMoxa
end;

procedure TfrmMain.btnDisconnectMoxaClick(Sender: TObject);
begin
  if idtlnt1.Connected then
    idtlnt1.Disconnect;
  mmoLog.Clear;
end;

procedure TfrmMain.btn3Click(Sender: TObject);
var
  ch: Char;
begin
  ch := #13;
  edt1KeyPress(nil, ch)
end;

procedure TfrmMain.SendChFromStr(s: string);
var
  I: Integer;
begin
  for I := 1 to Length(s) do
    idtlnt1.SendCh(s[I]);
//  if s <> NullAsStringValue then begin
//    idtlnt1.SendCmd(s + ';' + #13);
//    //idtlnt1.SendCh(';');
//  end;
  idtlnt1.SendCh(#13);
end;

{1
3
2111
5 ��� ����� }

procedure TfrmMain.btn4Click(Sender: TObject);
begin
  idtlnt1.SendCh(#8);
end;

function Del_0(const s: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(s) do
    if not (s[I] in [#0]) then
      Result := Result + s[I];
end;

function ConvertStr(s: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(s) do
    Result := Result + '<' + IntToStr(Ord(s[I])) + '>'
end;

function ConvertStrStick(s: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(s) do
    Result := Result + s[I] + '<' + IntToStr(Ord(s[I])) + '>'
end;

                          {WaitFor
AllData
ReadLn
ReadLine}

procedure TfrmMain.GetText;                                   {readmemorystring   stringstring}
begin
  with frmOption.cbbProcedure do
  if Items[ItemIndex] = 'WaitFor' then
    GetTextWaitFor else
  if Items[ItemIndex] = 'AllData' then
    GetTextAllData else
  if Items[ItemIndex] = 'ReadLn' then
    GetTextReadLn else
  if Items[ItemIndex] = 'ReadLine' then
    GetLine;
  StatProc
end;

{procedure TForm1.GetText;                                   //readmemorystring   stringstring
var
  s: string;                                                                  //readwait for
  //ch: Char;
  I: Integer;
begin
  //mmoLog.Lines.Add('InputLn: ' + idtlnt1.InputLn());            //#10#13#10#13
  //mmoLog.Lines.Add('AllData: ' + idtlnt1.AllData);
  //mmoLog.Lines.Add('Greeting.Text: ');
  //mmoLog.Lines.AddStrings(idtlnt1.Greeting.Text);
  //mmoLog.Lines.Add('CurrentReadBuffer: ' + idtlnt1.CurrentReadBuffer);
  //mmoLog.Lines.Add('ReadString: ' + idtlnt1.ReadString(15));

//  repeat
    //if idtlnt1.ReadChar = #13 then
    //ch := idtlnt1.ReadChar;

    //mmoLog.Lines.Add('ReadChar: ' + ch);
//    s := idtlnt1.ReadLn();
//    s := idtlnt1.ReadLn(#10);
    s := idtlnt1.WaitFor(#13#0);
    if chkConvert.Checked then
      s := ConvertStr(s);
    if chkDel0.Checked then
      s := Del_0(s);

    //s := ConvertStr(s);
    //s := idtlnt1.r
//    if Pos(#13, s) > 0 then
//      Delete(s, Pos(#13, s), 1);


    //mmoLog.Lines.Text := s;
    mmoLog.Lines.Add('Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + s);
//
//    for I := 1 to Length(s) do
//      mmoLog.Lines.Add(s[I]);
//  until (s[1] = #13) or (Length(s) < 3);// and (idtlnt1.ReadChar = #13);
end;}

procedure TfrmMain.btn5Click(Sender: TObject);
begin
  GetText
end;

procedure TfrmMain.GetLine;
var
  s: string;
begin
  s := idtlnt1.ReadLn(#10);
  if (chkConvert.Checked) and (chkStik.Checked) then begin
    s := ConvertStrStick(Del_0(s))
  end else
  if chkConvert.Checked then
    s := ConvertStr(s);
  if chkDel0.Checked then
    s := Del_0(s);
  mmoLog.Lines.Add('Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + s);
end;

procedure TfrmMain.btn6Click(Sender: TObject);
begin
  GetLine
end;

procedure TfrmMain.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (idtlnt1.Connected) then
    begin
      SendChFromStr(edt1.Text);
      edt1.Clear;
      GetText;
    end;
end;

procedure TfrmMain.edt1Change(Sender: TObject);
//var
//  s: string;
begin
//  if Length(edt1.Text) > 1 then begin
//    s := edt1.Text;
//    edt1.Text := s[Length(s)];
//  end;
//  edt1.SelectAll  
end;

procedure TfrmMain.edt1Click(Sender: TObject);
begin
  edt1.SelectAll
end;

procedure TfrmMain.chkConvertClick(Sender: TObject);
begin
  chkDel0.Checked := not chkConvert.Checked;
  chkConvertVithOrig.Checked := chkConvert.Checked;
end;

procedure TfrmMain.chkDel0Click(Sender: TObject);
begin
  chkConvert.Checked := not chkDel0.Checked
end;

procedure TfrmMain.ConnectToMoxa;
begin
  if idtlnt1.Connected then
    Exit;
  try
    idtlnt1.Connect;
    mmoLog.Clear;
    GetText
  except
    on E: Exception do begin
      Application.MessageBox(PChar(E.Message), '������', MB_ICONERROR);
      Application.Terminate;
    end;
  end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  WindowState := wsMaximized;
  if not FileExists(ExtractFilePath(Application.ExeName)  + 'Config.INI') then
    WriteIni('Window', 'FunctionOne', '1')
  else
    frmOption.SetParam;
  ConnectToMoxa
end;

procedure TfrmMain.chkConvertVithOrigClick(Sender: TObject);
begin
  chkStik.Checked := chkConvertVithOrig.Checked
end;

procedure TfrmMain.GetTextAllData;
var
  s,
  sConvert: string;                                                                  {readwait for}
begin
  s := idtlnt1.AllData;

  if (not chkConvert.Checked) and (chkDel0.Checked) then
    sConvert := Del_0(s);
  if (chkConvert.Checked) and (chkStik.Checked) then begin
    sConvert := Del_0(s);
    sConvert := ConvertStrStick(sConvert);
  end else
  if (chkConvert.Checked) then
    sConvert := ConvertStr(s);
  mmoLog.Lines.Add('Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + sConvert);
  stat1.Panels[2].Text := 'Length(s): ' + IntToStr(Length(s));
  if chkConvertVithOrig.Checked then begin
    s := Del_0(s);
    mmoLog.Lines.Add('Original Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + s);
  end;
end;

procedure TfrmMain.btnAllDataClick(Sender: TObject);
begin
  GetTextAllData
end;

procedure TfrmMain.btnReadLnClick(Sender: TObject);
begin
  GetTextReadLn
end;

procedure TfrmMain.GetTextReadLn;
var
  s,
  sConvert: string;                                                                  {readwait for}
begin
  s := idtlnt1.ReadLn();

  if (not chkConvert.Checked) and (chkDel0.Checked) then
    sConvert := Del_0(s);
  if (chkConvert.Checked) and (chkStik.Checked) then begin
    sConvert := Del_0(s);
    sConvert := ConvertStrStick(sConvert);
  end else
  if (chkConvert.Checked) then
    sConvert := ConvertStr(s);
  mmoLog.Lines.Add('Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + sConvert);
  stat1.Panels[2].Text := 'Length(s): ' + IntToStr(Length(s));
  if chkConvertVithOrig.Checked then begin
    s := Del_0(s);
    mmoLog.Lines.Add('Original Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + s);
  end;
end;

procedure TfrmMain.GetTextWaitFor;
var
  s,
  sConvert: string;                                                                  {readwait for}
begin
  s := idtlnt1.WaitFor(#13#0);
  if (not chkConvert.Checked) and (chkDel0.Checked) then
    sConvert := Del_0(s);
  if (chkConvert.Checked) and (chkStik.Checked) then begin
    sConvert := Del_0(s);
    sConvert := ConvertStrStick(sConvert);
  end else
  if (chkConvert.Checked) then
    sConvert := ConvertStr(s);
  mmoLog.Lines.Add('Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + sConvert);
  stat1.Panels[2].Text := 'Length(s): ' + IntToStr(Length(s));
  if chkConvertVithOrig.Checked then begin
    s := Del_0(s);
    mmoLog.Lines.Add('Original Length(s): ' + IntToStr(Length(s)) + ', ReadLn: ' + s);
  end;

end;

procedure TfrmMain.Option1Click(Sender: TObject);
begin
  frmOption.ShowModal;
  StatProc
end;

procedure TfrmMain.StatProc;
begin
  stat1.Panels[0].Text := frmOption.cbbProcedure.Items[frmOption.cbbProcedure.ItemIndex]
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  idtlnt1.Disconnect
end;

procedure TfrmMain.mniGit1Click(Sender: TObject);
begin
  ShowMessage('Test for Git');
end;

end.
