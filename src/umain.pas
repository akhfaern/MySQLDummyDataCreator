unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Samples.Spin, Math;

type
  TRandomDateTimeTypes = (rdtDate, rdtTime, rdtDateTime);

type
  TStringArray = array of string;

type
  TfrmMain = class(TForm)
    gbFieldList: TGroupBox;
    lvFieldList: TListView;
    btnAddField: TButton;
    gbRecords: TGroupBox;
    lbRecordCount: TLabel;
    edtRecordCount: TSpinEdit;
    lbSaveFile: TLabel;
    edtSaveFile: TEdit;
    btnSelectSaveFile: TButton;
    btnCreateRecords: TButton;
    sdSaveSQLFile: TSaveDialog;
    btnRemoveField: TButton;
    lbTablename: TLabel;
    edtTablename: TEdit;
    lbStatus: TLabel;
    procedure btnAddFieldClick(Sender: TObject);
    procedure btnSelectSaveFileClick(Sender: TObject);
    procedure btnCreateRecordsClick(Sender: TObject);
    procedure btnRemoveFieldClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setStatus(FStatus: string);
    procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);
    function getRandomString(FLen: integer): string;
    function getRandomInt(FLen: integer): integer;
    function getRandomEmail: string;
    function getRandomEmailFromNameSurname: string;
    function getRandomDateTime(FRandomDateTimeType
      : TRandomDateTimeTypes): string;
    function getRandomEnum(FEnumList: string): string;
  end;

var
  frmMain: TfrmMain;
  FNamesList, FSurnamesList: TStringList;

implementation

{$R *.dfm}

uses uAddFieldDialog;

procedure TfrmMain.btnAddFieldClick(Sender: TObject);
begin
  frmAddFieldDialog.ShowModal;
end;

procedure TfrmMain.btnCreateRecordsClick(Sender: TObject);
var
  I, J: integer;
  FFieldType, FSql, FValues, FSqlTemp: string;
  FSqlFile: TextFile;
  FArray: array of TVarRec;
begin
  if Trim(edtSaveFile.Text) = '' then
  begin
    Application.MessageBox('Please choose a file to save', 'Error',
      MB_OK + MB_ICONERROR);
    Exit;
  end;
  if Trim(edtTablename.Text) = '' then
  begin
    Application.MessageBox('Please enter a tablename', 'Error',
      MB_OK + MB_ICONERROR);
    Exit;
  end;
  if lvFieldList.Items.Count < 1 then
  begin
    Application.MessageBox('No fields to create SQL', 'Error',
      MB_OK + MB_ICONERROR);
    Exit;
  end;
  setStatus('Processing...');
  FSql := 'INSERT INTO ' + edtTablename.Text + ' (';
  for I := 0 to lvFieldList.Items.Count - 1 do
  begin
    FSql := FSql + '`' + lvFieldList.Items[I].SubItems[0] + '`, ';
    FValues := FValues + '''%s'', ';
    FFieldType := lvFieldList.Items[I].SubItems[1];
    if (FFieldType = 'Name') or (FFieldType = 'Name + '' '' + Surname') then
    begin
      if FNamesList = nil then
        FNamesList := TStringList.Create;
      FNamesList.Clear;
      FNamesList.LoadFromFile('names.txt');
    end;
    if (FFieldType = 'Surname') or (FFieldType = 'Name + '' '' + Surname') then
    begin
      if FSurnamesList = nil then
        FSurnamesList := TStringList.Create;
      FSurnamesList.Clear;
      FSurnamesList.LoadFromFile('surnames.txt');
    end;
  end;
  FValues := Copy(FValues, 0, Length(FValues) - 2);
  FSql := Copy(FSql, 0, Length(FSql) - 2) + ') VALUES (' + FValues + ');';
  try
    AssignFile(FSqlFile, edtSaveFile.Text);
    Rewrite(FSqlFile);
  except
    Application.MessageBox('SQL File Create Error', 'Error',
      MB_OK + MB_ICONERROR);
    Exit;
  end;
  setStatus('Creating records...');
  for I := 1 to edtRecordCount.Value do
  begin
    Randomize;
    Application.ProcessMessages;
    SetLength(FArray, 0);
    for J := 0 to lvFieldList.Items.Count - 1 do
    begin
      SetLength(FArray, Length(FArray) + 1);
      FFieldType := lvFieldList.Items[J].SubItems[1];
      if FFieldType = 'Random String' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(getRandomString(StrToInt(lvFieldList.Items[J]
          .SubItems[2]))));
      end
      else if FFieldType = 'Random Int' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(IntToStr(getRandomInt(StrToInt(lvFieldList.Items[J]
          .SubItems[2])))));
      end
      else if FFieldType = 'Name' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(FNamesList[Random(FNamesList.Count)]));
      end
      else if FFieldType = 'Name + '' '' + Surname' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(FNamesList[Random(FNamesList.Count)] + ' ' +
          FSurnamesList[Random(FSurnamesList.Count)]));
      end
      else if FFieldType = 'Surname' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(FSurnamesList[Random(FSurnamesList.Count)]));
      end
      else if FFieldType = 'Random Email' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(getRandomEmail()));
      end
      else if FFieldType = 'Email From Name + Surname + Random Int' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(getRandomEmailFromNameSurname()));
      end
      else if FFieldType = 'Random Date' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(getRandomDateTime(rdtDate)));
      end
      else if FFieldType = 'Random Time' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(getRandomDateTime(rdtTime)));
      end
      else if FFieldType = 'Random DateTime' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(getRandomDateTime(rdtDateTime)));
      end
      else if Copy(FFieldType, 1, 4) = 'Enum' then
      begin
        FArray[High(FArray)].VType := vtAnsiString;
        FArray[High(FArray)].VAnsiString :=
          Pointer(AnsiString(getRandomEnum(FFieldType)));
      end
    end;
    FSqlTemp := format(FSql, FArray);
    WriteLn(FSqlFile, FSqlTemp);
  end;
  CloseFile(FSqlFile);
  setStatus('Done! Records saved.');
end;

procedure TfrmMain.btnRemoveFieldClick(Sender: TObject);
var
  Li: TListItem;
  i: integer;
begin
  Li := lvFieldList.Selected;
  if Li <> nil then
    case Application.MessageBox('Are u sure that you want to delete this row?',
      'Warning', MB_OKCANCEL + MB_ICONWARNING) of
      IDOK:
        begin
          lvFieldList.Items.Delete(Li.Index);
          for I := 0 to lvFieldList.Items.Count - 1 do
            lvFieldList.Items[I].Caption := IntToStr(I + 1);
        end;
    end;
end;

procedure TfrmMain.btnSelectSaveFileClick(Sender: TObject);
begin
  if sdSaveSQLFile.Execute then
    edtSaveFile.Text := sdSaveSQLFile.FileName;
end;

function TfrmMain.getRandomDateTime(FRandomDateTimeType
  : TRandomDateTimeTypes): string;
var
  RandomDate, RandomTime: TDateTime;
  fmt: TFormatSettings;
begin
  fmt := TFormatSettings.Create;
  fmt.ShortDateFormat := 'yyyy-mm-dd';
  fmt.DateSeparator := '-';
  Randomize;
  RandomDate := Random(Trunc(Now) - Trunc(StrToDate('1970-01-01', fmt)) + 1) +
    StrToDate('1970-01-01', fmt);
  RandomTime := Random * (17 - 8) / 24 + 8 / 24;
  case FRandomDateTimeType of
    rdtDate:
      Result := DateToStr(RandomDate, fmt);
    rdtTime:
      Result := TimeToStr(RandomTime);
    rdtDateTime:
      Result := DateTimeToStr(RandomDate + RandomTime, fmt);
  end;
end;

function TfrmMain.getRandomEmail: string;
var
  FEmailServices: array [0 .. 2] of string;
begin
  FEmailServices[0] := '@gmail.com';
  FEmailServices[1] := '@hotmail.com';
  FEmailServices[2] := '@yandex.com';
  Result := getRandomString(12) + IntToStr(1 + Random(999)) + FEmailServices
    [Random(3)];
end;

function TfrmMain.getRandomEmailFromNameSurname: string;
var
  FEmailServices: array [0 .. 2] of string;
begin
  FEmailServices[0] := '@gmail.com';
  FEmailServices[1] := '@hotmail.com';
  FEmailServices[2] := '@yandex.com';
  Result := '';
  if (FNamesList <> nil) and (FSurnamesList <> nil) then
    Result := LowerCase(FNamesList[Random(FNamesList.Count)]) +
      LowerCase(FSurnamesList[Random(FSurnamesList.Count)]) +
      IntToStr(1 + Random(999)) + FEmailServices[Random(3)];
end;

function TfrmMain.getRandomEnum(FEnumList: string): string;
var
  FList: TStringList;
  FPos, FEnd: integer;
begin
  FPos := Pos('[', FEnumList) + 1;
  FEnd := Pos(']', FEnumList);
  FEnumList := Trim(Copy(FEnumList, FPos, FEnd - FPos));
  FList := TStringList.Create;
  try
    Split(',', FEnumList, FList);
    Result := Trim(FList[Random(FList.Count)]);
  finally
    FList.Free;
  end;
end;

function TfrmMain.getRandomInt(FLen: integer): integer;
var
  sMin, sMax: string;
  I: integer;
begin
  sMin := '1';
  for I := 1 to FLen do
    sMax := sMax + '9';
  for I := 1 to FLen - 1 do
    sMin := sMin + '0';
  Result := RandomRange(StrToInt(sMin), StrToInt(sMax));
end;

function TfrmMain.getRandomString(FLen: integer): string;
var
  FAlphabet: string;
  I: integer;
begin
  Result := '';
  FAlphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  for I := 1 to FLen do
    Result := Result + FAlphabet[1 + Random(52)];
end;

procedure TfrmMain.setStatus(FStatus: string);
begin
  lbStatus.Caption := FStatus;
end;

procedure TfrmMain.Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);
begin
  ListOfStrings.Clear;
  ListOfStrings.Delimiter := Delimiter;
  ListOfStrings.StrictDelimiter := True;
  ListOfStrings.DelimitedText := Str;
end;

end.
