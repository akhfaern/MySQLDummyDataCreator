object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Data Creator for MySQL'
  ClientHeight = 503
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbStatus: TLabel
    Left = 8
    Top = 480
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object gbFieldList: TGroupBox
    Left = 8
    Top = 8
    Width = 449
    Height = 353
    Caption = 'Field List'
    TabOrder = 0
    object lvFieldList: TListView
      Left = 16
      Top = 24
      Width = 417
      Height = 281
      Columns = <
        item
          Caption = '#'
          Width = 30
        end
        item
          Caption = 'Field Name'
          Width = 100
        end
        item
          Caption = 'Field Type'
          Width = 140
        end
        item
          Caption = 'Max Field Len'
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
    end
    object btnAddField: TButton
      Left = 358
      Top = 311
      Width = 75
      Height = 25
      Caption = 'Add Field'
      TabOrder = 0
      OnClick = btnAddFieldClick
    end
    object btnRemoveField: TButton
      Left = 277
      Top = 311
      Width = 75
      Height = 25
      Caption = 'Remove Field'
      TabOrder = 1
      OnClick = btnRemoveFieldClick
    end
  end
  object gbRecords: TGroupBox
    Left = 8
    Top = 367
    Width = 449
    Height = 98
    Caption = 'Record'
    TabOrder = 1
    object lbRecordCount: TLabel
      Left = 232
      Top = 24
      Width = 70
      Height = 13
      Caption = 'Record Count:'
    end
    object lbSaveFile: TLabel
      Left = 29
      Top = 52
      Width = 47
      Height = 13
      Caption = 'Save File:'
    end
    object lbTablename: TLabel
      Left = 16
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Table Name:'
    end
    object edtRecordCount: TSpinEdit
      Left = 312
      Top = 24
      Width = 121
      Height = 22
      MaxValue = 1000000
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
    object edtSaveFile: TEdit
      Left = 92
      Top = 52
      Width = 309
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object btnSelectSaveFile: TButton
      Left = 403
      Top = 51
      Width = 30
      Height = 23
      Caption = '...'
      TabOrder = 2
      OnClick = btnSelectSaveFileClick
    end
    object edtTablename: TEdit
      Left = 92
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
    end
  end
  object btnCreateRecords: TButton
    Left = 366
    Top = 471
    Width = 91
    Height = 25
    Caption = 'Create Records'
    TabOrder = 2
    OnClick = btnCreateRecordsClick
  end
  object sdSaveSQLFile: TSaveDialog
    DefaultExt = '*.sql'
    Filter = 'SQL Files (*.sql)|*.sql'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Select SQL File to Save'
    Left = 208
    Top = 119
  end
end
