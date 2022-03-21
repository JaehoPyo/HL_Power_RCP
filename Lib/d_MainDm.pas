unit d_MainDm;

interface

uses
  Windows, SysUtils, ADODB, DB, Dialogs, Classes, h_MainLib, h_ReferLib;

type
  TMainDm = class(TDataModule)
    MainDB: TADOConnection;
    PD_INS_PGM_HIST: TADOStoredProc;
    procedure MainDBAfterDisconnect(Sender: TObject);
    procedure MainDBAfterConnect(Sender: TObject);
    procedure MainDBBeforeConnect(Sender: TObject);
    procedure MainDBBeforeDisconnect(Sender: TObject);
  private
     { Private declarations }
  public
    { Public declarations }
  end;
    function  ADOConnection : Boolean;
    procedure InsertPGMHist(MENU_ID, HIST_TYPE, FUNC_NAME, EVENT_NAME, EVENT_DESC, COMMAND_TYPE, COMMAND_TEXT, PARAM, ERROR_MSG: String);
type
  TDB_Info = Record
    DbOle    : String ;
    DbType   : String ;
    DbUser   : String ;
    DbPswd   : String ;
    DbAlais  : String ;
    DbSource : String;
    WRHS     : String ;
    ConChk   : Boolean ;
  end;

var
  MainDm: TMainDm;
  m : TDB_Info ;
  ActivePCAddr : String;

implementation

{$R *.dfm}
//==============================================================================
// ADOConnection -> Database Connect
//==============================================================================
function ADOConnection: Boolean;
var
  connStr : String;
begin
  Result := False;
  m.ConChk := False;
  m.DbType := UpperCase(IniRead(INI_PATH, 'Database', 'Connection', 'IniRead Fail') );
  m.DbOle   := IniRead(INI_PATH, 'Database', 'Provider', 'IniRead Fail');
  m.DbAlais := IniRead(INI_PATH, 'Database', 'Alais'   , 'IniRead Fail');
  m.DbUser  := IniRead(INI_PATH, 'Database', 'User'    , 'IniRead Fail');
  m.DbPswd  := IniRead(INI_PATH, 'Database', 'Pswd'    , 'IniRead Fail');
  m.DbSource := IniRead(INI_PATH, 'Database', 'DataSource', 'IniRead Fail');

  if  m.DbType = 'ORACLE' then
  begin
    connStr := 'Provider=' + m.DbOLE +
               ';Data Source=' + m.DbAlais +
               ';Persist Security Info=True' +
               ';User ID =' + m.DbUser +
               ';Password=' + m.DbPswd ;
  end
  else if (m.DbType = 'MSSQL') then
  begin
    connStr := 'Provider=' + m.DbOLE +
               ';Initial Catalog=' + m.DbAlais +
               ';Data Source=' + m.DbSource +
               ';Persist Security Info=True' +
               ';User ID =' + m.DbUser +
               ';Password=' + m.DbPswd ;
  end;

  try
    with MainDm.MainDB do
    begin
      Close;
      ConnectionString := connStr;
      Connected := True;
      Result := True;
      m.ConChk := True ;
    end;
  except
    m.ConChk := False ;
  end;
end;

procedure TMainDm.MainDBBeforeConnect(Sender: TObject);
begin
  m.ConChk := True ;
end;

procedure TMainDm.MainDBAfterConnect(Sender: TObject);
begin
  m.ConChk := True ;
end;

procedure TMainDm.MainDBAfterDisconnect(Sender: TObject);
begin
  m.ConChk := False ;
end;

procedure TMainDm.MainDBBeforeDisconnect(Sender: TObject);
begin
  m.ConChk := False ;
end;


//==============================================================================
// InsertPGMHist ( W_PROGRAM_HIST 테이블에 이력을 넣음)                       //
//==============================================================================
procedure InsertPGMHist(MENU_ID, HIST_TYPE, FUNC_NAME, EVENT_NAME, EVENT_DESC, COMMAND_TYPE, COMMAND_TEXT, PARAM, ERROR_MSG: String);
begin
  try
    with MainDm.PD_INS_PGM_HIST do
    begin
      Close;
      ProcedureName := 'PD_INS_PGM_HIST';
      Parameters.ParamByName('i_MENU_ID'     ).Value := MENU_ID;
      Parameters.ParamByName('i_HIST_TYPE'   ).Value := HIST_TYPE;
      Parameters.ParamByName('i_PGM_FUNCTION').Value := FUNC_NAME;
      Parameters.ParamByName('i_EVENT_NAME'  ).Value := EVENT_NAME;
      Parameters.ParamByName('i_EVENT_DESC'  ).Value := EVENT_DESC;
      Parameters.ParamByName('i_COMMAND_TYPE').Value := COMMAND_TYPE;
      Parameters.ParamByName('i_COMMAND_TEXT').Value := COMMAND_TEXT;
      Parameters.ParamByName('i_PARAM'       ).Value := PARAM;
      Parameters.ParamByName('i_ERROR_MSG'   ).Value := ERROR_MSG;
      Parameters.ParamByName('i_USER_ID'     ).Value := ' ['+ActivePCAddr+']';
      ExecProc;
      Close;
    end;
  except
    on E : Exception do
    begin
      MainDm.PD_INS_PGM_HIST.Close;
    end;
  end;
end;


end.
