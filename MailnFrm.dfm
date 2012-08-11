object frmMain: TfrmMain
  Left = 661
  Top = 132
  Width = 918
  Height = 517
  Caption = #1052#1086#1082#1089#1072' '#1082#1083#1080#1077#1085#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object mmoLog: TMemo
    Left = 0
    Top = 105
    Width = 910
    Height = 347
    Align = alClient
    Lines.Strings = (
      'mmoLog')
    TabOrder = 0
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 910
    Height = 105
    Align = alTop
    TabOrder = 1
    DesignSize = (
      910
      105)
    object edt1: TEdit
      Left = 16
      Top = 16
      Width = 121
      Height = 21
      Hint = 'Press ENTER'
      TabOrder = 0
      OnChange = edt1Change
      OnClick = edt1Click
      OnKeyPress = edt1KeyPress
    end
    object btn4: TButton
      Left = 104
      Top = 48
      Width = 75
      Height = 25
      Caption = 'backspase'
      TabOrder = 1
      OnClick = btn4Click
    end
    object btn3: TButton
      Left = 16
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 2
      OnClick = btn3Click
    end
    object btnDisconnectMoxa: TButton
      Left = 742
      Top = 64
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Disconnect'
      TabOrder = 3
      OnClick = btnDisconnectMoxaClick
    end
    object btnConnectMoxa: TButton
      Left = 742
      Top = 24
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Connect'
      TabOrder = 4
      OnClick = btnConnectMoxaClick
    end
    object btn5: TButton
      Left = 16
      Top = 80
      Width = 75
      Height = 25
      Caption = 'ReadText'
      TabOrder = 5
      OnClick = btn5Click
    end
    object btn6: TButton
      Left = 104
      Top = 80
      Width = 75
      Height = 25
      Caption = 'ReadLine'
      TabOrder = 6
      OnClick = btn6Click
    end
    object chkConvert: TCheckBox
      Left = 304
      Top = 48
      Width = 97
      Height = 17
      Caption = 'chkConvert'
      TabOrder = 7
      OnClick = chkConvertClick
    end
    object chkDel0: TCheckBox
      Left = 304
      Top = 80
      Width = 97
      Height = 17
      Caption = 'chkDel0'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = chkDel0Click
    end
    object chkConvertVithOrig: TCheckBox
      Left = 304
      Top = 24
      Width = 129
      Height = 17
      Caption = 'chkConvertVithOrig'
      TabOrder = 9
      OnClick = chkConvertVithOrigClick
    end
    object chkStik: TCheckBox
      Left = 432
      Top = 24
      Width = 97
      Height = 17
      Caption = 'chkSti'#1089'k'
      TabOrder = 10
    end
    object btnAllData: TButton
      Left = 192
      Top = 48
      Width = 75
      Height = 25
      Caption = 'AllData'
      TabOrder = 11
      OnClick = btnAllDataClick
    end
    object btnReadLn: TButton
      Left = 192
      Top = 80
      Width = 75
      Height = 25
      Caption = 'ReadLn'
      TabOrder = 12
      OnClick = btnReadLnClick
    end
  end
  object stat1: TStatusBar
    Left = 0
    Top = 452
    Width = 910
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object idtlnt1: TIdTelnet
    MaxLineAction = maException
    ReadTimeout = 0
    Host = '192.168.1.251'
    Port = 23
    Terminal = 'dumb'
    Left = 72
    Top = 16
  end
  object dlgOpen1: TOpenDialog
    Left = 464
    Top = 56
  end
  object mm1: TMainMenu
    Left = 336
    Top = 288
    object File1: TMenuItem
      Caption = 'File'
    end
    object Option1: TMenuItem
      Caption = 'Option'
      OnClick = Option1Click
    end
    object mniGit1: TMenuItem
      Caption = 'Test for Git'
      OnClick = mniGit1Click
    end
  end
end
