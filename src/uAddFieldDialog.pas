unit uAddFieldDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ComCtrls;

type
  TfrmAddFieldDialog = class(TForm)
    lbFieldName: TLabel;
    edtFieldName: TEdit;
    lbFieldType: TLabel;
    cmbFieldTypes: TComboBox;
    lbMaxFieldLen: TLabel;
    edtMaxFieldLen: TSpinEdit;
    btnAddField: TButton;
    btnCancel: TButton;
    lbEnumValues: TLabel;
    edtEnumValues: TEdit;
    procedure cmbFieldTypesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddFieldClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddFieldDialog: TfrmAddFieldDialog;

implementation

{$R *.dfm}

uses umain;

procedure TfrmAddFieldDialog.btnAddFieldClick(Sender: TObject);
var
  Li: TListItem;
  FFieldName: string;
  i: integer;
begin
  FFieldName := edtFieldName.Text;
  FFieldName := StringReplace(FFieldName, ' ', '_', [rfReplaceAll]);
  if (Length(FFieldName) > 0) and (cmbFieldTypes.ItemIndex > -1) then
  begin
    for I := 0 to frmMain.lvFieldList.Items.Count - 1 do
      if frmMain.lvFieldList.Items[I].SubItems[0] = FFieldName then
      begin
        Application.MessageBox('This field name already exists!', 'Error',
          MB_OK + MB_ICONERROR);
        Exit;
      end;
    Li := frmMain.lvFieldList.Items.Add;
    Li.Caption := IntToStr(frmMain.lvFieldList.Items.Count);
    Li.SubItems.Add(FFieldName);
    if cmbFieldTypes.Text = 'Enum' then
      Li.SubItems.Add(cmbFieldTypes.Text + ' [' +
        Trim(edtEnumValues.Text) + ']')
    else
      Li.SubItems.Add(cmbFieldTypes.Text);
    if edtMaxFieldLen.Value < 0 then
      edtMaxFieldLen.Value := 0;
    Li.SubItems.Add(IntToStr(edtMaxFieldLen.Value));
    Close;
  end
  else
    Application.MessageBox('Please fill all fields!', 'Error',
      MB_OK + MB_ICONERROR);
end;

procedure TfrmAddFieldDialog.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddFieldDialog.cmbFieldTypesChange(Sender: TObject);
begin
  if cmbFieldTypes.Text = 'Enum' then
  begin
    frmAddFieldDialog.Height := 225;
    lbMaxFieldLen.Top := 121; // 88
    edtMaxFieldLen.Top := 121;
    lbEnumValues.Visible := True;
    edtEnumValues.Visible := True;
    btnCancel.Top := 160;
    btnAddField.Top := 160;
  end
  else
  begin
    frmAddFieldDialog.Height := 200;
    lbMaxFieldLen.Top := 88; // 88
    edtMaxFieldLen.Top := 88;
    lbEnumValues.Visible := False;
    edtEnumValues.Visible := False;
    btnCancel.Top := 128;
    btnAddField.Top := 128;
  end;
end;

procedure TfrmAddFieldDialog.FormShow(Sender: TObject);
begin
  edtFieldName.Clear;
  edtEnumValues.Text := '0, 1, 2';
  edtMaxFieldLen.Value := 0;
  cmbFieldTypes.ItemIndex := -1;
  edtFieldName.SetFocus;
end;

end.
