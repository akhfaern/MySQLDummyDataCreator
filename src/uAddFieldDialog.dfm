object frmAddFieldDialog: TfrmAddFieldDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Field'
  ClientHeight = 171
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbFieldName: TLabel
    Left = 24
    Top = 24
    Width = 56
    Height = 13
    Caption = 'Field Name:'
  end
  object lbFieldType: TLabel
    Left = 24
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Field Type:'
  end
  object lbMaxFieldLen: TLabel
    Left = 24
    Top = 88
    Width = 69
    Height = 13
    Caption = 'Max Field Len:'
  end
  object lbEnumValues: TLabel
    Left = 24
    Top = 88
    Width = 60
    Height = 13
    Caption = 'Enum Values'
    Visible = False
  end
  object edtFieldName: TEdit
    Left = 104
    Top = 21
    Width = 161
    Height = 21
    TabOrder = 0
  end
  object cmbFieldTypes: TComboBox
    Left = 104
    Top = 52
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 1
    OnChange = cmbFieldTypesChange
    Items.Strings = (
      'Random String'
      'Random Int'
      'Name'
      'Name + '#39' '#39' + Surname'
      'Surname'
      'Random Email'
      'Email From Name + Surname + Random Int'
      'Random Date'
      'Random Time'
      'Random DateTime'
      'Enum')
  end
  object edtMaxFieldLen: TSpinEdit
    Left = 104
    Top = 85
    Width = 161
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object btnAddField: TButton
    Left = 190
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Add Field'
    TabOrder = 3
    OnClick = btnAddFieldClick
  end
  object btnCancel: TButton
    Left = 109
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object edtEnumValues: TEdit
    Left = 104
    Top = 86
    Width = 161
    Height = 21
    TabOrder = 5
    Text = '0, 1, 2'
    Visible = False
  end
end
