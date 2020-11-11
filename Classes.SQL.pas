unit Classes.SQL;

interface

uses
  System.Classes, System.SysUtils, Generics.Collections;

type

  TPair = class
  private
    FIsPrimaryKey: Boolean;
    FKey: string;
    FValue: string;
  public
    function GetSQLParticle: string; virtual;
    property IsPrimaryKey: Boolean read FIsPrimaryKey;
    property Key: string read FKey write FKey;
    property Value: string read FValue write FValue;
    class constructor ClassCreate;
    class var FormatSettings: TFormatSettings;
  end;


  TPairLessThan = class(TPair)
  public
    function GetSQLParticle: string; override;
    constructor Create(const pKey: string; pValue: Int64; pIsPK: Boolean = False);
  end;

  TPairBiggerThen = class(TPair)
  public
    function GetSQLParticle: string; override;
    constructor Create(const pKey: string; pValue: Int64; pIsPK: Boolean = False);
  end;

  TPairString = class(TPair)
  public
    constructor Create(const pKey, pValue: string; pIsPK: Boolean = False);
  end;

  TPairInteger = class(TPair)
  public
    constructor Create(const pKey: string; pValue: Int64; pIsPK: Boolean = False);
  end;

  TPairFloat = class(TPair)
  public
    constructor Create(const pKey: string; pValue: Real; pPrecision: ShortInt = 2; pIsPK: Boolean = False);
  end;

  TPairDate = class(TPair)
  public
    constructor Create(const pKey: string; pValue: TDate; pIsPK: Boolean = False);
  end;

  TPairDateTime = class(TPair)
  public
    constructor Create(const pKey: string; pValue: TDateTime; pIsPK: Boolean = False);
  end;

  TPairTime = class(TPair)
  public
    constructor Create(const pKey: string; pValue: TDateTime; pIsPK: Boolean = False);
  end;

  TPairNull = class(TPair)
  public
    constructor Create(const pKey: string; pIsPK: Boolean = False);
  end;

  ISQLAbstract = interface
    ['{8CB809A5-5FB9-4F10-A846-4D2009CFF779}']
    function GetInsertInstruction: string;
    function GetUpdateInstruction: string;
    function GetSelectInstruction(const pOrderBy: string = ''): string;
    function GetDeleteInstruction: string;
    procedure AddPair(pPair: TPair);
    procedure AddKeyPair(pPair: TPair);
  end;

  TSQLAbstract = class(TInterfacedObject, ISQLAbstract)
  private
    FPair: TObjectList<TPair>;
    FPairKey: TObjectList<TPair>;
    FTableName: string;
    FFormatSettings: TFormatSettings;
    property Pair: TObjectList<TPair> read FPair;
    property PairKey: TObjectList<TPair> read FPairKey;
    function GetKeyClause: string;
    function GetKeyList: string;
    function GetValueList: string;
    function NormalizeKey(const pKey: string): string;
  public
    property TableName: string read FTableName;
    function GetInsertInstruction: string;
    function GetUpdateInstruction: string;
    function GetSelectInstruction(const pOrderBy: string = ''): string;
    function GetDeleteInstruction: string;
    procedure AddPair(pPair: TPair);
    procedure AddKeyPair(pPair: TPair);
    procedure ClearPairs;
    procedure ClearKeyPairs;
    procedure ClearAllPairs;
    constructor Create(const pTableName: string);
    destructor Destroy; override;
  end;

implementation

{ TSQLAbstract }

procedure TSQLAbstract.AddKeyPair(pPair: TPair);
var
  lPair: TPair;
  lAddKey: Boolean;
begin
  if Pos('.', pPair.Key) <= 0 then
    pPair.Key:= Self.TableName + '.' + pPair.Key;

  lAddKey:= True;
  for lPair in Self.PairKey do
  begin
    if lPair.Key = pPair.Key then
    begin
      lPair.Value := pPair.Value;
      lAddKey:= False;
    end;
  end;

  if lAddKey then
    Self.PairKey.Add(pPair)
  else
    pPair.Free;
end;

procedure TSQLAbstract.AddPair(pPair: TPair);
var
  lAddPair: Boolean;
  lPair: TPair;
begin
  if Pos('.', pPair.Key) <= 0 then
    pPair.Key:= Self.TableName + '.' + pPair.Key;

  lAddPair:= True;
  for lPair in Self.Pair do
  begin
    if lPair.Key = pPair.Key then
    begin
      lPair.Value := pPair.Value;
      lAddPair:= False;
    end;
  end;

  if lAddPair then
    Self.Pair.Add(pPair)
  else
    pPair.Free;
end;

procedure TSQLAbstract.ClearAllPairs;
begin
  Self.ClearPairs;
  Self.ClearKeyPairs;
end;

procedure TSQLAbstract.ClearKeyPairs;
begin
  Self.PairKey.Clear;
end;

procedure TSQLAbstract.ClearPairs;
begin
  Self.Pair.Clear;
end;

constructor TSQLAbstract.Create(const pTableName: string);
begin
  FPair:= TObjectList<TPair>.Create(True);
  FPairKey:= TObjectList<TPair>.Create(True);
  Self.FTableName:= pTableName;
  Self.FFormatSettings:= TFormatSettings.Create;
  Self.FFormatSettings.DecimalSeparator:= '.';
end;

destructor TSQLAbstract.Destroy;
begin
  FPair.Free;
  FPairKey.Free;
  inherited;
end;

function TSQLAbstract.GetDeleteInstruction: string;
begin
  if Self.PairKey.Count <= 0 then
    raise Exception.Create('Sem clausula WHERE em PairKey para DELETE');

  Result:= 'DELETE FROM ' + Self.TableName + ' WHERE ' + Self.GetKeyClause;
end;

function TSQLAbstract.GetInsertInstruction: string;
begin
  Result:= 'INSERT INTO ' + Self.TableName + ' (' + Self.GetKeyList + ') VALUES (' +
                                                   GetValueList + ')';
end;

function TSQLAbstract.GetKeyClause: string;
var
  lPair: TPair;
  lKey, lValue: string;
  lStringList: TStringList;
begin
  lStringList:= TStringList.Create;
  try
    lStringList.StrictDelimiter:= True;
    lStringList.Delimiter:= '|';
    for lPair in Self.PairKey do
      lStringList.Add(lPair.GetSQLParticle);
    Result:= lStringList.DelimitedText;
    Result:= StringReplace(Result, lStringList.Delimiter, ' AND ', [rfReplaceAll, rfIgnoreCase]);
  finally
    lStringList.Free;
  end;
end;

function TSQLAbstract.GetKeyList: string;
var
  lStringList: TStringList;
  lKey: string;
  lPair: TPair;
begin
  lStringList:= TStringList.Create;
  try
    lStringList.Delimiter:= ',';
    lStringList.StrictDelimiter:= True;

    for lPair in Self.Pair do
    begin
      lStringList.Add(lPair.Key)
    end;

    Result:= lStringList.DelimitedText;

  finally
    lStringList.Free;
  end;
end;

function TSQLAbstract.GetSelectInstruction(const pOrderBy: string): string;
begin
  if Self.Pair.Count > 0 then
    Result:= 'SELECT ' + Self.GetKeyList + ' FROM ' + Self.TableName
  else
    Result:= 'SELECT * FROM ' + Self.TableName;

  if Self.PairKey.Count > 0 then
    Result:= Result + ' WHERE ' + Self.GetKeyClause;

  if pOrderBy <> '' then
    Result:= Result + ' ORDER BY ' + pOrderBy;
end;

function TSQLAbstract.GetUpdateInstruction: string;
var
  lSQLParts: string;
  lPair: TPair;
begin

  for lPair in Self.Pair do
    if Trim(lSQLParts) = '' then
      lSQLParts:= lPair.GetSQLParticle
    else
      lSQLParts:= lSQLParts + ',' + lPair.GetSQLParticle;

  Result:= 'UPDATE ' + Self.TableName + ' SET ' + lSQLParts;
  if Self.PairKey.Count > 0 then
    Result:= Result + ' WHERE ' + Self.GetKeyClause;
end;

function TSQLAbstract.GetValueList: string;
var
  lValue: string;
  lPair: TPair;
begin
  for lPair in Self.Pair do
    if Trim(lPair.Value) <> '' then
      if Trim(Result) = '' then
        Result:= lPair.Value
      else
        Result:= Result + ',' + lPair.Value;
end;

function TSQLAbstract.NormalizeKey(const pKey: string): string;
begin
  if Pos('.', pKey) <= 0 then
    Result:= Self.TableName + '.' + pKey;
end;

{ TPair }

class constructor TPair.ClassCreate;
begin
  TPair.FormatSettings:= TFormatSettings.Create;
  TPair.FormatSettings.DecimalSeparator:= '.';
end;

function TPair.GetSQLParticle: string;
begin
  Result:= Self.FKey + ' = ' + Self.FValue
end;

{ TPairString }

constructor TPairString.Create(const pKey, pValue: string; pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FValue:= QuotedStr(pValue);
  Self.FIsPrimaryKey:= pIsPK;
end;

{ TPairInteger }

constructor TPairInteger.Create(const pKey: string; pValue: Int64; pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FValue:= pValue.ToString;
  Self.FIsPrimaryKey:= pIsPK;
end;

{ TPairFloat }

constructor TPairFloat.Create(const pKey: string; pValue: Real; pPrecision: ShortInt = 2; pIsPK: Boolean = False);
begin
  Self.FKey:= pKey;
  Self.FIsPrimaryKey:= pIsPK;
  Self.FValue:= FormatFloat('#########0.' + StringOfChar('0', pPrecision),
                pValue,
                TPair.FormatSettings);

end;

{ TPairDate }

constructor TPairDate.Create(const pKey: string; pValue: TDate; pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FIsPrimaryKey:= pIsPK;
  Self.FValue:= QuotedStr(FormatDateTime('YYYY-MM-DD', pValue));
end;

{ TPairDateTime }

constructor TPairDateTime.Create(const pKey: string; pValue: TDateTime; pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FIsPrimaryKey:= pIsPK;
  Self.FValue:= QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', pValue));
end;

{ TPairTime }

constructor TPairTime.Create(const pKey: string; pValue: TDateTime;
  pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FIsPrimaryKey:= pIsPK;
  Self.FValue:= QuotedStr(FormatDateTime('hh:mm:ss', pValue));
end;

{ TPairNull }

constructor TPairNull.Create(const pKey: string; pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FIsPrimaryKey:= pIsPK;
  Self.FValue:= 'NULL';
end;

{ TPairBiggerThen }

constructor TPairBiggerThen.Create(const pKey: string; pValue: Int64; pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FValue:= pValue.ToString;
  Self.FIsPrimaryKey:= pIsPK;
end;

function TPairBiggerThen.GetSQLParticle: string;
begin
  Result:= Self.FKey + ' > ' + Self.FValue
end;

{ TPairLessThan }

constructor TPairLessThan.Create(const pKey: string; pValue: Int64; pIsPK: Boolean);
begin
  Self.FKey:= pKey;
  Self.FValue:= pValue.ToString;
  Self.FIsPrimaryKey:= pIsPK;
end;

function TPairLessThan.GetSQLParticle: string;
begin
  Result:= Self.FKey + ' < ' + Self.FValue
end;

end.
