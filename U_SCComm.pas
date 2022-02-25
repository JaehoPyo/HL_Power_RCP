unit U_SCComm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StrUtils, Dialogs, h_MainLib, h_ReferLib, d_MainDm, FileLib, DB, ADODB,
  ExtCtrls, ComCtrls, StdCtrls, Buttons, Inifiles, ScktComp, CheckLst, Vcl.Grids  ;

type
  TfrmSCComm = class(TForm)
    pcStatus: TPageControl;
    tsCommLog: TTabSheet;
    tmrConnectCheck: TTimer;
    tmrStatusREAD: TTimer;
    qryInfo: TADOQuery;
    qrySearch: TADOQuery;
    qryUpdate: TADOQuery;
    tsStatus: TTabSheet;
    QryDelete: TADOQuery;
    qrySCIO: TADOQuery;
    qryError: TADOQuery;
    qryREAD: TADOQuery;
    qryWrite: TADOQuery;
    qryStock: TADOQuery;
    qryPos: TADOQuery;
    qryDBChk: TADOQuery;
    qryErrorRpt: TADOQuery;
    qryTemp: TADOQuery;
    PnlSC1: TPanel;
    gbStatus: TGroupBox;
    Bevel1: TBevel;
    edt_SCCMode: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    edt_DrvPosition: TEdit;
    Panel5: TPanel;
    edt_UDPosition: TEdit;
    Panel8: TPanel;
    edt_UnLoading: TEdit;
    Panel9: TPanel;
    edt_Emergency: TEdit;
    Panel11: TPanel;
    edt_ForkCenter: TEdit;
    edt_StroreOut: TEdit;
    Panel16: TPanel;
    Panel17: TPanel;
    edt_Loading: TEdit;
    edt_StroreIn: TEdit;
    Panel21: TPanel;
    edt_CargoExist: TEdit;
    Panel22: TPanel;
    edt_SCTMode: TEdit;
    Panel15: TPanel;
    staInfo: TStatusBar;
    Pnl_Main: TPanel;
    ListBoxOrder: TListBox;
    CommLog: TMemo;
    edt_CurrLevel: TEdit;
    Panel1: TPanel;
    Panel4: TPanel;
    edt_ErrorCode: TEdit;
    edt_CurrBay: TEdit;
    Panel10: TPanel;
    Panel7: TPanel;
    edt_Error: TEdit;
    Bevel2: TBevel;
    edt_Working: TEdit;
    Panel12: TPanel;
    Panel13: TPanel;
    edt_ForceComplete: TEdit;
    Panel14: TPanel;
    edt_Empty: TEdit;
    Panel19: TPanel;
    edt_Complete: TEdit;
    Panel20: TPanel;
    edt_InReady: TEdit;
    edt_Double: TEdit;
    Panel25: TPanel;
    edt_OutReady: TEdit;
    Panel26: TPanel;
    edt_StandBy: TEdit;
    Panel27: TPanel;
    PnlBtm: TPanel;
    gb_SC_COMM: TGroupBox;
    ShpCon: TShape;
    sbtStart: TBitBtn;
    sbtClose: TBitBtn;
    GroupBox6: TGroupBox;
    ckLog1: TCheckBox;
    gbOrder: TGroupBox;
    Panel24: TPanel;
    edt_MoveOn: TEdit;
    Panel28: TPanel;
    edt_DstBay: TEdit;
    Panel29: TPanel;
    edt_DataReset: TEdit;
    Panel30: TPanel;
    edt_SrcBay: TEdit;
    edt_DstBank: TEdit;
    Panel33: TPanel;
    edt_SrcLevel: TEdit;
    Panel35: TPanel;
    edt_DstLevel: TEdit;
    Panel36: TPanel;
    edt_SrcBank: TEdit;
    Panel37: TPanel;
    Panel6: TPanel;
    edt_ErrorDesc: TEdit;
    edt_Step: TEdit;
    Panel23: TPanel;
    edt_Lugg: TEdit;
    Panel18: TPanel;
    qryACS: TADOQuery;
    PD_GET_JOBNO: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CloseChkMsg(Sender: TObject);

    procedure tmrStatusREADTimer(Sender: TObject);
    procedure tmrConnectCheckTimer(Sender: TObject);

    procedure sbtClick(Sender: TObject);
    procedure sbtCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure fnCreateSet;                                                      // 프로그램 실행 시 설정
    procedure fnCloseSet;                                                       // 프로그램 종료 시 설정

    procedure SC_JOBClear(SC_NO:Integer) ;                                      // 작업 데이터 구조체 초기화
    procedure SC_OLDJOBClear(SC_NO:Integer) ;                                   // 이전 작업 데이터 구조체 초기화

    procedure SC_JOBCopy(SC_NO:Integer) ;                                       // 현재 데이터 -> 이전 데이터 복사
    procedure SC_OLDJOBCopy(SC_NO:Integer) ;                                    // 이전 데이터 -> 현재 데이터 복사
    procedure SC_ORDClear(SC_NO:Integer) ;                                      // 작업 지시 구조체 초기화

    // SC Read & Write & Process 관렴 함수
    procedure SCTREAD(SC_NO:Integer);                                           // SC 상태 READ
    procedure SCTWRITE(SC_NO:Integer);                                          // SC 지시 WRITE
    procedure SCControlProcess(SC_NO:Integer);                                  // SC 작업 처리

    // 화면 표시 관련 함수
    procedure SC_OrderDisplay(SC_NO:Integer);                                   // 지시 데이터 표시
    procedure SC_OrderDisplayClear(SC_NO:Integer);                              // 지시 데이터 클리어
    procedure SC_StatusDisplay(SC_NO:Integer);                                  // 상태 데이터 표시
    procedure SC_StatusDisplayClear(SC_NO:Integer);                             // 상태 데이터 클리어
    procedure ListBoxDisplay(xListBox:TListBox; Msg:String);                    // 작업 등록 데이터 표시

    function  fnSignalMsg(Signal:string): String;                               // 시그날 메시지
    function  fnModeMsg(Signal:string): String;                                 // 모드 메시지

    function  fnSignalFontColor(Signal,Flag: string): TColor;                   // 시그날 폰트 색상
    function  fnSignalEditColor(Signal,Flag: string): TColor;                   // 시그날 에디트색상

    // 작업 처리 관련 함수
    function  GetJobNo : Integer;                                               // 작업번호 생성
    function  SCNowStatusUpdate(SC_NO:Integer; Status: String): Boolean ;
    function  SCNowCycleUpdate(SC_NO:Integer; Cycle: String): Boolean ;

    function  fnGetSCSetInfo(SC_NO:Integer; GetField:String): Boolean ;         // SC 지시 상태 Get (홈복귀,작업취소..)
    function  fnGetSCSetLUGG(SC_NO:Integer; GetField:String): String ;          // SC 지시 상태 Get (홈복귀,작업취소..)
    function  fnSetSCSetInfo(SC_NO:Integer; SetField,SetValue:String): Boolean ;// SC 지시 상태 SET (0:OFF,1:ON)

    function  fnSetSCSetInfo_Clear(SC_NO:Integer): Boolean ;                    // SC 지시 상태 초기화 (All OFF)
    function  fnSetSCSetInfo_Clear2(SC_NO:Integer): Boolean ;                   // 모니터링 작업처리 상태 초기화 (All OFF)

    function  SetJobOrder : Boolean;

    // ACS 관련
    function  HasACS_Request(Line_No, In_Out: Integer): Boolean;                       // ACS의 요청건이 있는 지 확인
    procedure GetACS_Status(Line_No, In_Out: Integer);                                 // ACS 상태가져옴
    procedure ACSControlProcess(SC_NO: Integer);                                // ACS 관련처리
    function  SetAcsResponse(Line_No, In_Out: Integer; Status: String) : Boolean;
    procedure fnACS_Update(Line_No, In_Out: Integer; Gubn, FName, FValue: String);

    function  fnGetSCStatus(Src:TScStatus): String ;                            // SC 상태메시지 Get (영문)
    function  fnGetSCStatus2(Src:TScStatus): String ;                           // SC 상태메시지 Get (한글)

    function  fnGetSCCmdType(IO_TYPE:String): String ;                          // SC 작업타입 ID Get (확인필요)
    function  fnGetCVStatus(SC_NO:Integer; BuffNo,GetField:String ): Boolean ;  // CV 입&출고대 화물,레디,에러상태 Get
    function  fnSetWriteInfo(SC_NO:Integer;Job_Type:String): Boolean;           // SC 지시 데이터 SET
    function  fnSetSCORDWrite(SC_NO: Integer; Falg: String): Boolean;           // SC 지시 데이터 INSERT
    function  fnGetSCJOB(SC_NO:Integer;JFlag:TSCJobMode): Boolean ;             // SC 작업 검색
    function  fnChkSCJOB(SC_NO:Integer): Boolean ;                              // SC 작업 체크
    function  fnGetCVOrderStr(SC_NO: Integer; IO: String) : String;                            // TT_ORDER CVCURR 조건 설정

    // ORDER 테이블 관련 함수
    function  fnOrder_Value(SC_No: Integer; FName : String): String; overload;                       // ORDER 데이터 Get
    function  fnOrder_Value(WhereStr: String; FName : String) : String; overload;
    function  fnOrder_Cancel(SC_No: Integer; LUGG, REG_TIME: String): Boolean;                       // ORDER 데이터 Delete(작업취소 시)
    function  fnOrder_Delete(SC_No:Integer): Boolean;                                                // ORDER 데이터 Delete (확인필요)
    function  fnOrder_Update(SC_No:Integer;FName,FValue:String):Boolean;                  overload ; // ORDER 데이터 Update (Value1개)
    function  fnOrder_Update(SC_No:Integer;FName1,FValue1,FName2,FValue2:String):Boolean; overload ; // ORDER 데이터 Update (Value2개)
    function  fnOrder_Update(JobNo, FName, FValue:String):Boolean;                        overload ;

    // SCIO 테이블 관련 함수
    function  fnSCIO_Exist (SC_NO:Integer): Boolean;                            // SCIO 작업체크
    function  fnSCIO_ReLoad(SC_NO:Integer): Boolean;                            // SCIO 데이터 ReLoad
    function  fnSCIO_Insert(SC_No:Integer): Boolean;                            // SCIO 데이터 Insert
    function  fnSCIO_Update(SC_No:Integer): Boolean;                            // SCIO 데이터 Update
    function  fnSCIO_Delete(SC_No:Integer): Boolean;                            // SCIO 데이터 Delete

    // STOCK 테이블 관련 함수
    function  fnStockUpdateAll(SC_NO:Integer): Boolean;                            // 입출고 시 TT_STOCK 처리
    function  fnStockUpdate(SC_No:Integer;FName,FValue:String): Boolean; overload; // 셀 상태 변경 시
    function  fnStockUpdate(Loc, FName, FValue: String): Boolean; overload;
    function  fnGetStockLoc(ItemCode : String): String;                            // 품목 위치 반환

    // TM_ITEM 테이블 관련 함수
    function fnITEM_Value(SC_No: Integer; FName, FValue : String): String;

    // 이중입고&공출고 시 처리 함수
    function  fnCellPosChange(SC_NO:integer;Flag:String): Boolean;                          // 새로운 Postion 반환

    // Log 처리 관련 함수
    procedure ErrorLogWRITE(WRITEStr : String);                                 // 에러로그 저장
    procedure DisplayLog(SC_NO:Integer;Msg, SR_Type: String; Len:Integer);      // 로그 표시 및 저장

    // Error 처리 관련 함수
    function  fnGetErrMsg(SC_NO: integer; GetField,ErrCode: String): String;    // 에러메시지 Get
    function  fnSetMachError(SC_NO:Integer; ErrorCode:String): Boolean ;        // 에러 상태 Update (TT_ORDER)
    function  fnSetErrReport(SC_NO:Integer; ErrorCode:String): Boolean ;        // 에러 정보&시작시간 기록 (TT_ERROR)
    function  fnReSetErrReport(SC_NO:Integer): Boolean;                         // 에러 종료시간 기록 (TT_ERROR)
    function  fnGetErrReport(SC_NO:Integer): Boolean; overload ;                    // 종료할 에러 기록 체크 (TT_ERROR) -> 있으면 종료시키기 위해
    function  fnGetErrReport(SC_NO:Integer; ErrorCode: String): Boolean; overload ; // 발생한 에러 기록 체크 (TT_ERROR) -> 있으면 안넣기 위해

    // DB Connect 체크 함수
    function fnDBConChk : Boolean;


  end;

var
  frmSCComm: TfrmSCComm;

  xMCNo        : integer ;       // 통신할 SC 호기
  CloseChk     : Boolean ;       // 프로그램 종료 Flag
  LogWriteFlag : Boolean = True; // 로그저장 Flag

  JOB_FLAG      : Array[START_SCNO..End_SCNO] of TSCJobMode ;    // SC 작업 타입
  SC_STAT       : Array[START_SCNO..End_SCNO] of TScStatus ;     // SC 작업 상태
  SC_STAT_OLD   : Array[START_SCNO..End_SCNO] of TScStatus ;     // SC 작업 상태 (이전)

  SC_JOB        : Array[START_SCNO..End_SCNO] of TSC_JOB ;       // SC 작업
  SC_JOB_OLD    : Array[START_SCNO..End_SCNO] of TSC_JOB ;       // SC 이전 작업

  SC_STATUS     : Array[START_SCNO..End_SCNO] of TSC_STATUS ;    // SC 상태
  SC_STATUS_OLD : Array[START_SCNO..End_SCNO] of TSC_STATUS ;    // SC 상태 (이전)

  SC_ORDER      : Array[START_SCNO..End_SCNO] of TSC_ORDER ;     // SC 지시
  CONTROL_FLAG  : Array[START_SCNO..End_SCNO] of TCONTROL_FLAG ; // 프로그램 제어 Falg

  Rx_AcsData : Array [1..3, 1..2] of TRx_AcsData;
  Tx_AcsData : TTx_AcsData;
  PLC_WriteVal : TPLC_VAL;
  PLC_ReadVal : TPLC_VAL;
  OrderData : TJobOrder;
implementation

{$R *.dfm}

//==============================================================================
// FormCreate
//==============================================================================
procedure TfrmSCComm.FormCreate(Sender: TObject);
var
  Cap : String;
begin
  Cap  := IniRead(INI_PATH, 'Program', 'ProgramName',  'IniRead Failed');

  if  Findwindow(Nil, pChar(Cap)) <> 0 then
  begin
    Close;
    ExitProcess( 0 ); // 자신 프로그램을 죽이는 함수
  end;
  (Sender as TForm).Caption := Cap ;
end;

//==============================================================================
// FormShow
//==============================================================================
procedure TfrmSCComm.FormShow(Sender: TObject);
var
  i : Integer;
begin
  for i := 1 to 3 do
  begin
    PLC_WriteVal.InSt_Door[i] := '0';
    PLC_WriteVal.OtSt_Door[i] := '0';
  end;

  if ADOConnection then
  begin
    fnCreateSet ;
    sbtClick(sbtStart) ;  // 자동시작
    ShpCon.Brush.Color := clLime;
  end else
  begin
    ShpCon.Brush.Color := clRed;
    Exit;
  end;
end;

//==============================================================================
// fnCreateSet
//==============================================================================
procedure TfrmSCComm.fnCreateSet;
var
  i : integer ;
begin
  xMCNo := 0;
  CloseChk := False ;
  pcStatus.ActivePageIndex := 0 ;

  for i := START_SCNO to End_SCNO do
  begin
    SC_JOBClear(i);
    SC_OLDJOBClear(i);
    SC_ORDClear(i);

    SC_STAT[i]  := START ;
    Job_Flag[i] := None ;
    CONTROL_FLAG[i] := ComStart ;
  end;
  staInfo.Panels[2].Text := FormatDatetime('YYYY/MM/DD HH:MM:SS', Now())+'  ';
end;

//==============================================================================
// FormCloseQuery
//==============================================================================
procedure TfrmSCComm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not CloseChk then
  begin
    CloseChkMsg(nil);
    CanClose := False;
  end;
end;

//==============================================================================
// ACS의 요청건이 있는 지 확인
//==============================================================================
function TfrmSCComm.HasACS_Request(Line_No, In_Out: Integer): Boolean;
var
  StrSQL : String;
  Cnt : Integer;
begin
  Result := False;

  with qryACS do
  begin
    Close;
    SQL.Clear;
    StrSQL := ' SELECT COUNT(*) AS CNT ' +
              '   FROM TC_ACS_COMM ' +
              '  WHERE LINE_NO = ' + QuotedStr(IntToStr(Line_No)) +
              '    AND In_Out  = ' + QuotedStr(IntToStr(In_Out)) +
              '    AND PROCESS = ''N'' ' ;
    SQL.Text := StrSQL;
    Open;
    Cnt := FieldByName('CNT').AsInteger;
    if (Cnt > 0) then
      Result := True
    else
      Result := False;
  end;
end;

//==============================================================================
// ACS 상태 가져옴
//==============================================================================
procedure TfrmSCComm.GetACS_Status(Line_No, In_Out: Integer);
var
  StrSQL : String;
  i : Integer;
begin

  // RFID Read Data Check
  with qryACS do
  begin
    Close;
    SQL.Clear;
    StrSQL := ' SELECT TOP 1 * ' +
              '   FROM TC_ACS_COMM ' +
              '  WHERE GUBN = ''RECV'' ' +
              '    AND LINE_NO = ' + QuotedStr(IntToStr(Line_No)) +
              '    AND IN_OUT  = ' + QuotedStr(IntToStr(In_Out)) +
              '    AND PROCESS = ''N'' ' +
              '  ORDER BY UPD_DT ';
    SQL.Text := StrSQL;
    Open;

    if not (BOF and EOF) then
    begin
      Rx_AcsData[Line_No][In_Out].Heart_Beat       := FieldByName('HEART_BEAT').AsString;
      Rx_AcsData[Line_No][In_Out].Line_Name_Source := FieldByName('LINE_NAME_SOURCE').AsString;
      Rx_AcsData[Line_No][In_Out].Line_No_Source   := FieldByName('LINE_NO_SOURCE').AsString;
      Rx_AcsData[Line_No][In_Out].Port_No_Source   := FieldByName('PORT_NO_SOURCE').AsString;
      Rx_AcsData[Line_No][In_Out].Line_Name_Dest   := FieldByName('LINE_NAME_DEST').AsString;
      Rx_AcsData[Line_No][In_Out].Line_No_Dest     := FieldByName('LINE_NO_DEST').AsString;
      Rx_AcsData[Line_No][In_Out].Port_No_Dest     := FieldByName('PORT_NO_DEST').AsString;
      Rx_AcsData[Line_No][In_Out].Model_No         := FieldByName('MODEL_NO').AsString;
      Rx_ACSData[Line_No][In_Out].Call_Request     := FieldByName('CALL_REQUEST').AsString;
      Rx_ACSData[Line_No][In_Out].Call_Answer      := FieldByName('CALL_ANSWER').AsString;
      Rx_ACSData[Line_No][In_Out].Docking_Request  := FieldByName('DOCKING_REQ_APPR').AsString;
      Rx_ACSData[Line_No][In_Out].Docking_Complete := FieldByName('DOCKING_COMPLETE').AsString;
    end;
  end;
end;

//==============================================================================
// ACSControlProcess ACS 관련 처리
//==============================================================================
procedure TfrmSCComm.ACSControlProcess(SC_NO: Integer);
var
  StrSQL : String;
  i, j : Integer;
  JobNo, WhereStr : String;
  Loc, ItemCode, OtReady : String;
begin

  for i := START_STATION to END_STATION do
  begin
    for j := 1 to 2 do
    begin
      // 응답해야할 ACS 요청이 없으면 Pass
      if (HasAcs_Request(i) = False) then continue;

      // 응답해야할 ACS요청이 있을 때 응답에 대응함.
      // ACS 요청이 있다면 ACS 요청의 값을 가져옴.
      // 글로벌 변수 Rx_AcsData[i][j]에 저장
      GetACS_Status(i, j);

      // ACS 요청에 맞는 대응을 하고 응답 값을 만듦

      //==================================//
      // (AGV가 커튼 앞에 위치) 입고 작업 //
      //==================================//
      // *** 입고 작업 생성 *** //
      if (Rx_AcsData[i][j].Port_No_Dest     = '1') and
         (Rx_AcsData[i][j].Call_Request     = '1' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin

        // 해당 AGV의 입고작업이 없으면 생성
        WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                    '   And JOBD = 1';
        if (fnOrder_Value(WhereStr, 'LINE_NO') = '') then
        begin

          ItemCode := Rx_AcsData[i][j].Model_No;

          // 입고작업 데이터 생성
          OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',Now) + FormatDateTime('HHNNSS',Now) ;
          OrderData.LUGG       := Format('%.4d', [GetJobNo]) ;  // 작업번호
          OrderData.JOBD       := '1';     // 입고지시

          OrderData.SRCSITE    := '0001';  // 적재 호기
          OrderData.SRCAISLE   := '0000';  // 적재 열
          OrderData.SRCBAY     := '0000';  // 적재 연
          OrderData.SRCLEVEL   := Format('%.4d', [i]);  // 적재 스테이션
          // 목적지 랙 열-연-단은 AGV->CV이동 완료 후 지정
          OrderData.DSTSITE    := '0000';
          OrderData.DSTAISLE   := '0000';
          OrderData.DSTBAY     := '0000';
          OrderData.DSTLEVEL   := '0000';
          OrderData.ID_CODE    := ItemCode;
          OrderData.NOWMC      := '4'; // 1: CV, 2 : SC Loading, 3 : SC Unloading, 4 : AGV
          OrderData.JOBSTATUS  := '4';
          OrderData.NOWSTATUS  := '4';
          OrderData.BUFFSTATUS := '0';
          OrderData.JOBREWORK  := '';
          OrderData.JOBERRORT  := '';
          OrderData.JOBERRORC  := '';
          OrderData.JOBERRORD  := '';
          OrderData.JOB_END    := '0';
          OrderData.CVFR       := '0';
          OrderData.CVTO       := '0';
          OrderData.CVCURR     := '0';
          OrderData.ETC        := '';
          OrderData.EMG        := '0';
          OrderData.LINE_NO    := IntToStr(i);
          OrderData.ITM_CD     := '';
          OrderData.UP_TIME    := 'GETDATE()';
          // 작업생성
          if (SetJobOrder) then
          begin
            // 입고스테이션 커튼 오픈
            if (Rx_AcsData[i][j].Port_No_Dest = '1') then
            begin
              if (PLC_ReadVal.InSt_Door[i] = '0') then
              begin
                if PLC_WriteVal.InSt_Door[i] = '0' then
                begin
                  CONTROL_FLAG[SC_NO] := ComWrite;
                end;
                PLC_WriteVal.InSt_Door[i] := '1';
              end;
            end;
          end;
        end;

        // 커튼 열린 상태라면 응답 전송
        if (PLC_ReadVal.InSt_Door[i] = '1') then
        begin
          // ACS 응답 데이터 생성
          Tx_AcsData.Heart_Beat       := '1';
          Tx_AcsData.Line_Name_Source := '';
          Tx_AcsData.Line_No_Source   := '';
          Tx_AcsData.Port_No_Source   := '';
          Tx_AcsData.Line_Name_Dest   := '';
          Tx_AcsData.Line_No_Dest     := '';
          Tx_AcsData.Port_No_Dest     := '';
          Tx_AcsData.Model_No         := '';
          Tx_AcsData.Call_Request     := '0';
          Tx_AcsData.Call_Answer      := '1';
          Tx_AcsData.Docking_Approve  := '1';
          Tx_AcsData.Docking_Complete := '0';
          SetAcsResponse(i, j, '진행중');

          // AGV 인터페이스 진행중 표시
          fnACS_Update(i, j, 'RECV', 'STATUS', '진행중');

          // 해당 요청 처리했음 표시 ( PROCESS : N = 처리전, Y = 처리후, E = 에러)
          fnACS_Update(i, j, 'RECV', 'PROCESS', 'Y');
        end;
      end;

      //==================================//
      // (AGV가 커튼 앞에 위치) 출고 작업 //
      //==================================//
      // *** 출고 작업 생성 *** //
      if (Rx_AcsData[i][j].Port_No_Dest     = '2' ) and
         (Rx_AcsData[i][j].Call_Request     = '1' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin
        if i = 1 then OtReady := SC_STATUS[SC_NO].D211[9]
        else if i = 2 then OtReady := SC_STATUS[SC_NO].D211[11]
        else if i = 3 then OtReady := SC_STATUS[SC_NO].D211[13] ;

        // 해당 AGV의 출고작업이 없고 출고레디 On일때
        WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                    '   And JOBD = ''2'' ' +
                    '   And JOB_END = ''0'' ';
        if (fnOrder_Value(WhereStr, 'LINE_NO') = '') and
           (OtReady = '1')  then
        begin

          // 품목 찾기
          ItemCode := Rx_AcsData[i][j].Model_No;
          // Loc = 110101  호기(1)/열(1)/연(2)/단(2)
          Loc := fnGetStockLoc(ItemCode);

          // 출고작업 데이터 생성
          OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',Now) + FormatDateTime('HHNNSS',Now) ;
          OrderData.LUGG       := Format('%.4d', [GetJobNo]) ;  // 작업번호
          OrderData.JOBD       := '2';     // 출고지시

          OrderData.SRCSITE    := Format('%.4d', [StrToInt(Copy(Loc, 1, 1))]) ;  // 적재 호기
          OrderData.SRCAISLE   := Format('%.4d', [StrToInt(Copy(Loc, 2, 1))]) ;  // 적재 열
          OrderData.SRCBAY     := Format('%.4d', [StrToInt(Copy(Loc, 3, 2))]) ;  // 적재 연
          OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(Copy(Loc, 5, 2))]) ;  // 적재 단
          // 목적지 랙 열-연-단은 AGV->CV이동 완료 후 지정
          OrderData.DSTSITE    := '0000';
          OrderData.DSTAISLE   := '0000';
          OrderData.DSTBAY     := '0000';
          OrderData.DSTLEVEL   := Format('%.4d', [i]); // 출고 스테이션 1, 2, 3
          OrderData.ID_CODE    := ItemCode;
          OrderData.NOWMC      := '2'; // 1: CV, 2 : SC Loading, 3 : SC Unloading, 4 : AGV
          OrderData.JOBSTATUS  := '1';
          OrderData.NOWSTATUS  := '1';
          OrderData.BUFFSTATUS := '0';
          OrderData.JOBREWORK  := '';
          OrderData.JOBERRORT  := '';
          OrderData.JOBERRORC  := '';
          OrderData.JOBERRORD  := '';
          OrderData.JOB_END    := '0';
          OrderData.CVFR       := '0';
          OrderData.CVTO       := '0';
          OrderData.CVCURR     := '0';
          OrderData.ETC        := '';
          OrderData.EMG        := '0';
          OrderData.LINE_NO    := IntToStr(i);
          OrderData.ITM_CD     := '';
          OrderData.UP_TIME    := 'GETDATE()';

          // 작업생성
          if (SetJobOrder) then
          begin
            // 셀 업데이트, 출고예약
            fnStockUpdate(Loc, 'ID_STATUS', '5');

            // 출고스테이션 커튼 오픈
            if (Rx_AcsData[i][j].Port_No_Dest = '2') then
            begin
              if (PLC_ReadVal.OtSt_Door[i] = '0') then
              begin
                if PLC_WriteVal.OtSt_Door[i] = '0' then
                begin
                  CONTROL_FLAG[SC_NO] := ComWrite;
                end;
                PLC_WriteVal.OtSt_Door[i] := '1';
              end;
            end;
          end;

          WhereStr := ' Where JOBD = ''2'' ' +
                        ' And NOWSTATUS = ''4'' ' +
                        ' And JOBSTATUS = ''7'' ' +
                        ' And JOB_END = ''1'' ' +
                        ' And LINE_NO = ' + QuotedStr(IntToStr(i)) +
                      ' Order By REG_TIME Desc ' ;
          ItemCode := fnOrder_Value(WhereStr, 'LINE_NO');
          // 커튼 열린 상태, 출고작업 완료상태, RFID 데이터 일치상태
          // 응답 전송
          if (PLC_ReadVal.InSt_Door[i] = '1') then
          begin
            // ACS 응답 데이터 생성
            Tx_AcsData.Heart_Beat       := '1';
            Tx_AcsData.Line_Name_Source := '';
            Tx_AcsData.Line_No_Source   := '';
            Tx_AcsData.Port_No_Source   := '';
            Tx_AcsData.Line_Name_Dest   := '';
            Tx_AcsData.Line_No_Dest     := '';
            Tx_AcsData.Port_No_Dest     := '';
            Tx_AcsData.Model_No         := '';
            Tx_AcsData.Call_Request     := '0';
            Tx_AcsData.Call_Answer      := '1';
            Tx_AcsData.Docking_Approve  := '1';
            Tx_AcsData.Docking_Complete := '0';
            SetAcsResponse(i, '진행중');
            // AGV 인터페이스 진행중 표시
            fnACS_Update(i, 'RECV', 'STATUS', '진행중');
            // 해당 요청 처리했음 표시 ( PROCESS : N = 처리전, Y = 처리후, E = 에러)
            fnACS_Update(i, 'RECV', 'PROCESS', 'Y');
          end;
        end;
      end;

      //==================//
      // 입/출고 공통부분 //
      //==================//
      // *** 인터페이스 시작 *** //
      if (Rx_AcsData[i][j].Call_Request     = '1' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '0' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin
        // ACS 응답 데이터 생성
        Tx_AcsData.Heart_Beat       := '1';
        Tx_AcsData.Line_Name_Source := '';
        Tx_AcsData.Line_No_Source   := '';
        Tx_AcsData.Port_No_Source   := '';
        Tx_AcsData.Line_Name_Dest   := '';
        Tx_AcsData.Line_No_Dest     := IntToStr(i);
        Tx_AcsData.Port_No_Dest     := IntToStr(j);
        Tx_AcsData.Model_No         := '';
        Tx_AcsData.Call_Request     := '0';
        Tx_AcsData.Call_Answer      := '1';
        Tx_AcsData.Docking_Approve  := '0';
        Tx_AcsData.Docking_Complete := '0';
        SetAcsResponse(i, j, '진행중');

        // AGV 인터페이스 진행중 표시
        fnACS_Update(i, j, 'RECV', 'STATUS', '진행중');

        // 해당 요청 처리했음 표시 ( PROCESS : N = 처리전, Y = 처리후, E = 에러)
        fnACS_Update(i, j, 'RECV', 'PROCESS', 'Y');
      end else
      // *** 도킹 완료 *** //
      if (Rx_AcsData[i][j].Call_Request     = '0' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin

        // ACS 응답 데이터 생성
        Tx_AcsData.Heart_Beat       := '1';
        Tx_AcsData.Line_Name_Source := '';
        Tx_AcsData.Line_No_Source   := '';
        Tx_AcsData.Port_No_Source   := '';
        Tx_AcsData.Line_Name_Dest   := '';
        Tx_AcsData.Line_No_Dest     := '';
        Tx_AcsData.Port_No_Dest     := '';
        Tx_AcsData.Model_No         := '';
        Tx_AcsData.Call_Request     := '0';
        Tx_AcsData.Call_Answer      := '0';
        Tx_AcsData.Docking_Approve  := '1';
        Tx_AcsData.Docking_Complete := '0';
        SetAcsResponse(i, '진행중');

        // AGV 인터페이스 진행중 표시
        fnACS_Update(i, 'RECV', 'STATUS', '진행중');

        // 해당 요청 처리했음 표시 ( PROCESS : N = 처리전, Y = 처리후, E = 에러)
        fnACS_Update(i, 'RECV', 'PROCESS', 'Y');
      end else
      // *** 적재물이 AGV에서 설비로 이동한 상태, 진출 요청 *** //
      if (Rx_AcsData[i][j].Call_Request     = '0' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '1' ) then
      begin

        // CV 화물감지 확인 ? 이부분 확인 필요 .
        // 입고작업이면 NOWMC = 1, NOWSTATUS = 4 변경
        if (Rx_AcsData[i][j].Port_No_Dest = '1') then
        begin
          // Order 데이터 CV로 변경
          WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                      '   And JOBD = ''1'' ' +
                      '   And JOB_END = ''0'' ';
          JobNo := fnOrder_Value(WhereStr, 'LUGG');
          fnOrder_Update(JobNo, 'NOWMC', '1');
        end;

        // 출고작업이면 변경없음.

        // ACS 응답 데이터 생성
        Tx_AcsData.Heart_Beat       := '1';
        Tx_AcsData.Line_Name_Source := '';
        Tx_AcsData.Line_No_Source   := '';
        Tx_AcsData.Port_No_Source   := '';
        Tx_AcsData.Line_Name_Dest   := '';
        Tx_AcsData.Line_No_Dest     := '';
        Tx_AcsData.Port_No_Dest     := '';
        Tx_AcsData.Model_No         := '';
        Tx_AcsData.Call_Request     := '0';
        Tx_AcsData.Call_Answer      := '0';
        Tx_AcsData.Docking_Approve  := '1';
        Tx_AcsData.Docking_Complete := '1';
        SetAcsResponse(i, '진행중');

        // AGV 인터페이스 진행중 표시
        fnACS_Update(i, 'RECV', 'STATUS', '진행중');

        // 해당 요청 처리했음 표시 ( PROCESS : N = 처리전, Y = 처리후, E = 에러)
        fnACS_Update(i, 'RECV', 'PROCESS', 'Y');
      end else
      // *** 초기상태로 돌아감... *** //
      if (Rx_AcsData[i][j].Call_Request     = '0' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '0' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin

        // 입고일 때 TT_ORDER 값 변경하면 스태커 작업시작 함.
        ///
        ///  ////////////
        ///  ////////////
        ///


        // ACS 응답 데이터 생성
        Tx_AcsData.Heart_Beat       := '1';
        Tx_AcsData.Line_Name_Source := '';
        Tx_AcsData.Line_No_Source   := '';
        Tx_AcsData.Port_No_Source   := '';
        Tx_AcsData.Line_Name_Dest   := '';
        Tx_AcsData.Line_No_Dest     := '';
        Tx_AcsData.Port_No_Dest     := '';
        Tx_AcsData.Model_No         := '';
        Tx_AcsData.Call_Request     := '0';
        Tx_AcsData.Call_Answer      := '0';
        Tx_AcsData.Docking_Approve  := '0';
        Tx_AcsData.Docking_Complete := '0';
        SetAcsResponse(i, '대기');

        // AGV 인터페이스 대기 표시
        fnACS_Update(i, 'RECV', 'STATUS', '대기');

        // 해당 요청 처리했음 표시 ( PROCESS : N = 처리전, Y = 처리후, E = 에러)
        fnACS_Update(i, 'RECV', 'PROCESS', 'Y');
      end;
    end;
  end;

end;

//==============================================================================
// CloseChkMsg
//==============================================================================
procedure TfrmSCComm.CloseChkMsg(Sender: TObject);
begin
  if MessageDlg('Terminate SC Program?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    CloseChk := True ;
    Close;
  end;
end;

//==============================================================================
// fnCloseSet
//==============================================================================
procedure TfrmSCComm.fnCloseSet;
var
  i : integer ;
begin
  for i := 0 to Self.Componentcount-1 do
  begin
    if (Self.Components[i] is TTimer) then
       (Self.Components[i] as TTimer).Enabled := False;

    if (Self.Components[i] is TADOQuery) then
       (Self.Components[i] as TADOQuery).Active := False;
  end;

  if MainDM.MainDB.Connected then MainDM.MainDB.Close ;
end;

//==============================================================================
// FormClose
//==============================================================================
procedure TfrmSCComm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : integer;
begin
  for i := START_SCNO to END_SCNO do
  begin
    fnSetSCSetInfo(i, 'PROGRAM_START', '0') ;
    fnSetSCSetInfo(i, 'PROGRAM_END'  , '1') ;
  end;

  fnCloseSet ;
  ExitProcess(0);
end;

//==============================================================================
// sbtClick
//==============================================================================
procedure TfrmSCComm.sbtClick(Sender: TObject);
var
  i : integer ;
begin
  for i := START_SCNO to End_SCNO do fnSCIO_Delete(i) ;

  if (Sender as TBitBtn).Caption = '통신시작' then
  begin
    xMCNo := 0;
    (Sender as TBitBtn).Caption := '통신중지' ;
    sbtClose.Enabled := False;
    tmrConnectCheck.Enabled := True;

    for i := START_SCNO to END_SCNO do
    begin
      CONTROL_FLAG[i] := ComStart ;
      fnSetSCSetInfo(i, 'PROGRAM_START', '1') ;
      fnSetSCSetInfo(i, 'PROGRAM_END'  , '0') ;
    end;
  end else
  begin
    ( Sender as TBitBtn ).Caption := '통신시작' ;
    sbtClose.Enabled := True ;
    fnCloseSet ;
  end;
end;

//==============================================================================
// sbtClose
//==============================================================================
procedure TfrmSCComm.sbtCloseClick(Sender: TObject);
begin
  Close ;
end;

//==============================================================================
// tmrConnectCheckTimer
//==============================================================================
procedure TfrmSCComm.tmrConnectCheckTimer(Sender: TObject);
var
  i : integer;
  strLog : String ;
begin
  try
    tmrConnectCheck.Enabled := False ;
    if not fnDBConChk then
    begin
      if tmrStatusREAD.Enabled then tmrStatusREAD.Enabled := False;
      StrLog := ' 데이터베이스 연결 실패..' ;
      DisplayLog(1, StrLog, 'E', Length(StrLog)) ;
      if ADOConnection then
      begin
        if not tmrStatusREAD.Enabled then tmrStatusREAD.Enabled := True;
        StrLog := ' 데이터베이스 연결 성공!!' ;
        DisplayLog(1, StrLog, 'E', Length(StrLog)) ;
      end else
      begin
        StrLog := ' 데이터베이스 재 연결 중....' ;
        DisplayLog(1, StrLog, 'E', Length(StrLog)) ;
      end;
    end else
    begin
      if not tmrStatusREAD.Enabled then tmrStatusREAD.Enabled := True;
    end;
  finally
    tmrConnectCheck.Enabled := True ;
  end;
end;

//==============================================================================
// tmrStatusREADTimer
//==============================================================================
procedure TfrmSCComm.tmrStatusREADTimer(Sender: TObject);
begin
  try
    (Sender as TTimer).Enabled := False;

    Case xMCNo of
      0 : inc(xMCNo) ;
      else xMCNo := 1 ;
    end;

    if m.ConChk then
    begin
      ShpCon.Brush.Color := clLime;

      SCTREAD(xMCNo);

      // ACS 인터페이스 관련 처리
      ACSControlProcess(xMCNo);

      // SC 제어
      SCControlProcess(xMCNo) ;

      if CONTROL_FLAG[xMCNo] = ComStart then
         CONTROL_FLAG[xMCNo] := ComRead ;

      SCTWRITE(xMCNo);
    end else
    begin
      ShpCon.Brush.Color := clRed;
    end;
    staInfo.Panels[2].Text := FormatDatetime('YYYY/MM/DD HH:MM:SS', Now())+'  ';

  finally
    (Sender as TTimer).Enabled := True;
  end;
end;

//==============================================================================
// fnDBConChk
//==============================================================================
function TfrmSCComm.fnDBConChk: Boolean;
var
  StrSQL : string;
begin
  Result := False ;
  StrSQL := ' SELECT GETDATE() ' ;

  try
    with qryDBChk do
    begin
      Close;
      SQL.Clear ;
      SQL.Text := StrSQL ;
      Open ;
      if not (Bof and Eof) then
      begin
        Result := True ;
        m.ConChk := True ;
      end;
    end;
  except
    qryDBChk.Close;
    m.ConChk := False ;
  end;
end;

{******************************************************************************}
{*                         화면 표시 관련 함수                                *}
{******************************************************************************}

//==============================================================================
// SC_OrderDisplay
//==============================================================================
procedure TfrmSCComm.SC_OrderDisplay(SC_NO: Integer);
begin
  TEdit(Self.FindComponent('edt_LUGG'     )).Text := SC_JOB[SC_NO].ID_ORDLUGG  ; // 작업번호
  TEdit(Self.FindComponent('edt_SrcBank'  )).Text := SC_JOB[SC_NO].LOAD_BANK   ; // 적재 열
  TEdit(Self.FindComponent('edt_SrcBay'   )).Text := SC_JOB[SC_NO].LOAD_BAY    ; // 적재 연
  TEdit(Self.FindComponent('edt_SrcLevel' )).Text := SC_JOB[SC_NO].LOAD_LEVEL  ; // 적재 단
  TEdit(Self.FindComponent('edt_DstBank'  )).Text := SC_JOB[SC_NO].UNLOAD_BANK ; // 하역 열
  TEdit(Self.FindComponent('edt_DstBay'   )).Text := SC_JOB[SC_NO].UNLOAD_BAY  ; // 하역 연
  TEdit(Self.FindComponent('edt_DstLevel' )).Text := SC_JOB[SC_NO].UNLOAD_LEVEL; // 하역 단
end;

//==============================================================================
// SC_OrderDisplayClear
//==============================================================================
procedure TfrmSCComm.SC_OrderDisplayClear(SC_NO: Integer);
begin
  TEdit(Self.FindComponent('edt_LUGG'     )).Text := ''; // 작업번호
  TEdit(Self.FindComponent('edt_SrcBank'  )).Text := ''; // 적재 열
  TEdit(Self.FindComponent('edt_SrcBay'   )).Text := ''; // 적재 연
  TEdit(Self.FindComponent('edt_SrcLevel' )).Text := ''; // 적재 단
  TEdit(Self.FindComponent('edt_DstBank'  )).Text := ''; // 하역 열
  TEdit(Self.FindComponent('edt_DstBay'   )).Text := ''; // 하역 연
  TEdit(Self.FindComponent('edt_DstLevel' )).Text := ''; // 하역 단
  TEdit(Self.FindComponent('edt_MoveOn'   )).Text := ''; // 기동지시
  TEdit(Self.FindComponent('edt_DataReset')).Text := ''; // 데이터초기화
end;

//==============================================================================
// SC_StatusDisplay
//==============================================================================
procedure TfrmSCComm.SC_StatusDisplay(SC_NO: Integer);
begin
  // D200
  TEdit(Self.FindComponent('edt_CurrBay'      )).Text := SC_STATUS[SC_NO].D200;  // 현재위치 연
  // D201
  TEdit(Self.FindComponent('edt_CurrLevel'    )).Text := SC_STATUS[SC_NO].D201;  // 현재위치 단
  // D205
  TEdit(Self.FindComponent('edt_ErrorCode'    )).Text := SC_STATUS[SC_NO].D205;  // 이상코드
  TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := fnGetErrMsg(SC_NO, 'ERR_NAME', SC_STATUS[SC_NO].D205);  // 이상내용


  //++++++++++++++++++++++++++++++++++++++++++++
  // 상태값 표시 (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[00]); // 지상반 모드
  TEdit(Self.FindComponent('edt_SCCMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[01]); // 기상반 모드
  TEdit(Self.FindComponent('edt_Emergency'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[02]); // 비상정지
  TEdit(Self.FindComponent('edt_StroreIn'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[03]); // 입고작업 중
  TEdit(Self.FindComponent('edt_StroreOut'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[04]); // 출고작업 중
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[06]); // 주행 정위치
  TEdit(Self.FindComponent('edt_UDPosition'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[07]); // 승강 정위치
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[08]); // 포크 센터
  TEdit(Self.FindComponent('edt_CargoExist'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[09]); // 포크 제품 유무
  TEdit(Self.FindComponent('edt_Loading'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[10]); // 로딩 중
  TEdit(Self.FindComponent('edt_UnLoading'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[11]); // 언로딩 중
  TEdit(Self.FindComponent('edt_Error'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[15]); // 이상발생
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[00]); // 대기중
  TEdit(Self.FindComponent('edt_Working'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[01]); // 작업중
  TEdit(Self.FindComponent('edt_Complete'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[02]); // 작업완료
  TEdit(Self.FindComponent('edt_Double'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[03]); // 이중입고
  TEdit(Self.FindComponent('edt_Empty'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[04]); // 공출고
  TEdit(Self.FindComponent('edt_ForceComplete')).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[07]); // 강제완료
  TEdit(Self.FindComponent('edt_InReady'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[08]); // 입고레디
  TEdit(Self.FindComponent('edt_OutReady'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[09]); // 출고레디

  //++++++++++++++++++++++++++++++++++++++++++++
  // 에디트 색상 변경 (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[00],'4'); // 지상반 모드
  TEdit(Self.FindComponent('edt_SCCMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[01],'4'); // 기상반 모드
  TEdit(Self.FindComponent('edt_Emergency'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[02],'1'); // 비상정지
  TEdit(Self.FindComponent('edt_StroreIn'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[03],'0'); // 입고작업 중
  TEdit(Self.FindComponent('edt_StroreOut'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[04],'0'); // 출고작업 중
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[06],'0'); // 주행 정위치
  TEdit(Self.FindComponent('edt_UDPosition'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[07],'0'); // 승강 정위치
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[08],'0'); // 포크 센터
  TEdit(Self.FindComponent('edt_CargoExist'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[09],'0'); // 포크 제품 유무
  TEdit(Self.FindComponent('edt_Loading'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[10],'0'); // 로딩 중
  TEdit(Self.FindComponent('edt_UnLoading'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[11],'0'); // 언로딩 중
  TEdit(Self.FindComponent('edt_Error'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[15],'1'); // 이상발생
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[00],'0'); // 대기중
  TEdit(Self.FindComponent('edt_Working'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[01],'0'); // 작업중
  TEdit(Self.FindComponent('edt_Complete'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[02],'3'); // 작업완료
  TEdit(Self.FindComponent('edt_Double'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[03],'1'); // 이중입고
  TEdit(Self.FindComponent('edt_Empty'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[04],'1'); // 공출고
  TEdit(Self.FindComponent('edt_ForceComplete')).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[07],'3'); // 강제완료
  TEdit(Self.FindComponent('edt_InReady'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[08],'2'); // 입고레디
  TEdit(Self.FindComponent('edt_OutReady'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[09],'2'); // 출고레디

  //++++++++++++++++++++++++++++++++++++++++++++
  // 에디트 폰트 색상 변경 (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[00],'4'); // 지상반 모드
  TEdit(Self.FindComponent('edt_SCCMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[01],'4'); // 기상반 모드
  TEdit(Self.FindComponent('edt_Emergency'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[02],'1'); // 비상정지
  TEdit(Self.FindComponent('edt_StroreIn'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[03],'0'); // 입고작업 중
  TEdit(Self.FindComponent('edt_StroreOut'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[04],'0'); // 출고작업 중
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[06],'0'); // 주행 정위치
  TEdit(Self.FindComponent('edt_UDPosition'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[07],'0'); // 승강 정위치
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[08],'0'); // 포크 센터
  TEdit(Self.FindComponent('edt_CargoExist'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[09],'0'); // 포크 제품 유무
  TEdit(Self.FindComponent('edt_Loading'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[10],'0'); // 로딩 중
  TEdit(Self.FindComponent('edt_UnLoading'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[11],'0'); // 언로딩 중
  TEdit(Self.FindComponent('edt_Error'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[15],'1'); // 이상발생
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[00],'0'); // 대기중
  TEdit(Self.FindComponent('edt_Working'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[01],'0'); // 작업중
  TEdit(Self.FindComponent('edt_Complete'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[02],'3'); // 작업완료
  TEdit(Self.FindComponent('edt_Double'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[03],'1'); // 이중입고
  TEdit(Self.FindComponent('edt_Empty'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[04],'1'); // 공출고
  TEdit(Self.FindComponent('edt_ForceComplete')).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[07],'3'); // 강제완료
  TEdit(Self.FindComponent('edt_InReady'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[08],'2'); // 입고레디
  TEdit(Self.FindComponent('edt_OutReady'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[09],'2'); // 출고레디
end;

//==============================================================================
// SC_StatusDisplayClear
//==============================================================================
procedure TfrmSCComm.SC_StatusDisplayClear(SC_NO: Integer);
begin
  // D200
  TEdit(Self.FindComponent('edt_CurrBay'      )).Text := ''; // 현재위치 연
  // D201
  TEdit(Self.FindComponent('edt_CurrLevel'    )).Text := ''; // 현재위치 단
  // D205
  TEdit(Self.FindComponent('edt_ErrorCode'    )).Text := ''; // 이상코드
  TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := ''; // 이상내용

  // D210.00 ~ D210.15
  TEdit(Self.FindComponent('edt_SCTMode'      )).Text := ''; // 지상반 모드
  TEdit(Self.FindComponent('edt_SCCMode'      )).Text := ''; // 기상반 모드
  TEdit(Self.FindComponent('edt_Emergency'    )).Text := ''; // 비상정지
  TEdit(Self.FindComponent('edt_StroreIn'     )).Text := ''; // 입고작업 중
  TEdit(Self.FindComponent('edt_StroreOut'    )).Text := ''; // 출고작업 중
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Text := ''; // 주행 정위치
  TEdit(Self.FindComponent('edt_UDPosition'   )).Text := ''; // 승강 정위치
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Text := ''; // 포크 센터
  TEdit(Self.FindComponent('edt_CargoExist'   )).Text := ''; // 포크 제품 유무
  TEdit(Self.FindComponent('edt_Loading'      )).Text := ''; // 로딩 중
  TEdit(Self.FindComponent('edt_UnLoading'    )).Text := ''; // 언로딩 중
  TEdit(Self.FindComponent('edt_Error'        )).Text := ''; // 이상발생

  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Text := ''; // 대기중
  TEdit(Self.FindComponent('edt_Working'      )).Text := ''; // 작업중
  TEdit(Self.FindComponent('edt_Complete'     )).Text := ''; // 작업완료
  TEdit(Self.FindComponent('edt_Double'       )).Text := ''; // 이중입고
  TEdit(Self.FindComponent('edt_Empty'        )).Text := ''; // 공출고
  TEdit(Self.FindComponent('edt_ForceComplete')).Text := ''; // 강제완료
  TEdit(Self.FindComponent('edt_InReady'      )).Text := ''; // 입고레디
  TEdit(Self.FindComponent('edt_OutReady'     )).Text := ''; // 출고레디
end;

//==============================================================================
// ListBoxDisplay
//==============================================================================
procedure TfrmSCComm.ListBoxDisplay(xListBox: TListBox; Msg: String);
begin
  if (xListBox.Items.Count >= 50) then xListBox.Items.Delete(0);
  xListBox.Items.Add(Msg);
  xListBox.ItemIndex := xListBox.Items.Count -1;
end;

//==============================================================================
// fnSignalMsg
//==============================================================================
function TfrmSCComm.fnSignalMsg(Signal: string): String;
begin
  Result := '';
  if      Signal='0'    then Result := ''
  else if Signal='1'    then Result := 'O'
  else                       Result := Signal;
end;

//==============================================================================
// fnModeMsg
//==============================================================================
function TfrmSCComm.fnModeMsg(Signal: string): String;
begin
  Result := '';
  if      Signal='0'    then Result := '수동'
  else if Signal='1'    then Result := '자동'
  else                       Result := Signal;
end;

//==============================================================================
// fnSignalEditColor
//==============================================================================
function TfrmSCComm.fnSignalEditColor(Signal,Flag: string): TColor;
begin
  Result := clWhite ;
  if Flag='0' then
  begin // 일반
    Result := clWhite
  end else
  if Flag='1' then
  begin // 에러
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clRed
    else                       Result := clWhite;
  end else
  if Flag='2' then
  begin // 레디
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clLime
    else                       Result := clWhite;
  end else
  if Flag='3' then
  begin // 완료
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clNavy
    else                       Result := clWhite;
  end else
  if Flag='4' then
  begin // 모드
    if      Signal='0'    then Result := clYellow
    else if Signal='1'    then Result := clLime
    else                       Result := clWhite;
  end else
end;

//==============================================================================
// fnSignalFontColor
//==============================================================================
function TfrmSCComm.fnSignalFontColor(Signal,Flag: string): TColor;
begin
  Result := clBlack ;
  if Flag='0' then
  begin // 일반
    Result := clNavy;
  end else
  if Flag='1' then
  begin // 에러
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='2' then
  begin // 레디
    Result := clBlack;
  end else
  if Flag='3' then
  begin // 완료
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='4' then
  begin // 모드
    Result := clBlack;
  end else
end;

{******************************************************************************}
{*                    SC Read & Write & Process 관렴 함수                     *}
{******************************************************************************}

//==============================================================================
// SCTREAD
//==============================================================================
procedure TfrmSCComm.SCTREAD(SC_NO: Integer);
var
  j, k : integer ;
  StrSql, TmpCol, StrLog, D210, D211, D212 : String ;
begin
  D210:=''; D211:=''; D212:='';

  StrSql := ' SELECT * FROM VW_SC_STAUS ' +
            '  WHERE SC_NO =''' + IntToStr(SC_NO) + ''' ';

  try
    with qryREAD do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSql;
      Open;
      if not (Bof and Eof ) then
      begin
        // Word Data -> 10 Word
        SC_STATUS[SC_NO].D200 := FormatFloat('0000',StrToInt('$' + FieldByName('D200').AsString)) ; // Hex -> Dec
        SC_STATUS[SC_NO].D201 := FormatFloat('0000',StrToInt('$' + FieldByName('D201').AsString)) ; // Hex -> Dec
        SC_STATUS[SC_NO].D202 := FieldByName('D202').AsString ;
        SC_STATUS[SC_NO].D203 := FieldByName('D203').AsString ;
        SC_STATUS[SC_NO].D204 := FieldByName('D204').AsString ;
        SC_STATUS[SC_NO].D205 := FormatFloat('0000',StrToInt('$' + FieldByName('D205').AsString)) ; // Hex -> Dec
        SC_STATUS[SC_NO].D206 := FieldByName('D206').AsString ;
        SC_STATUS[SC_NO].D207 := FieldByName('D207').AsString ;
        SC_STATUS[SC_NO].D208 := FieldByName('D208').AsString ;
        SC_STATUS[SC_NO].D209 := FieldByName('D209').AsString ;

        // Bit Data -> 2 Word
        for j := 0 to 15 do
        begin
          TmpCol := 'D210_' + FormatFloat('00',j) ;
          SC_STATUS[SC_NO].D210[j] := FieldByName(TmpCol).AsString ;
          D210 := D210 + SC_STATUS[SC_NO].D210[j] ;
          TmpCol := 'D211_' + FormatFloat('00',j) ;
          SC_STATUS[SC_NO].D211[j] := FieldByName(TmpCol).AsString ;
          D211 := D211 + SC_STATUS[SC_NO].D211[j] ;
          TmpCol := 'D212_' + FormatFloat('00',j) ;
          SC_STATUS[SC_NO].D212[j] := FieldByName(TmpCol).AsString ;
          D212 := D212 + SC_STATUS[SC_NO].D212[j] ;
        end;

        SC_STATUS[SC_NO].D1200 := FieldByName('D1200').AsString ;
        SC_STATUS[SC_NO].D1201 := FieldByName('D1201').AsString ;
        SC_STATUS[SC_NO].D1202 := FieldByName('D1202').AsString ;
        SC_STATUS[SC_NO].D1203 := FieldByName('D1203').AsString ;
        SC_STATUS[SC_NO].D1204 := FieldByName('D1204').AsString ;
        SC_STATUS[SC_NO].D1205 := FieldByName('D1205').AsString ;
        SC_STATUS[SC_NO].D1206 := FieldByName('D1206').AsString ;
        SC_STATUS[SC_NO].D1207 := FieldByName('D1207').AsString ;
        SC_STATUS[SC_NO].D1208 := FieldByName('D1208').AsString ;
        SC_STATUS[SC_NO].D1209 := FieldByName('D1209').AsString ;
        SC_STATUS[SC_NO].D1210 := FieldByName('D1210').AsString ;
        SC_STATUS[SC_NO].D1211 := FieldByName('D1211').AsString ;
        SC_STATUS[SC_NO].D1212 := FieldByName('D1212').AsString ;
        SC_STATUS[SC_NO].D1213 := FieldByName('D1213').AsString ;
        SC_STATUS[SC_NO].D1214 := FieldByName('D1214').AsString ;
        SC_STATUS[SC_NO].D1215 := FieldByName('D1215').AsString ;
        SC_STATUS[SC_NO].D1216 := FieldByName('D1216').AsString ;
        SC_STATUS[SC_NO].D1217 := FieldByName('D1217').AsString ;
        SC_STATUS[SC_NO].D1218 := FieldByName('D1218').AsString ;
        SC_STATUS[SC_NO].D1219 := FieldByName('D1219').AsString ;
        SC_STATUS[SC_NO].D1220 := FieldByName('D1220').AsString ;
        SC_STATUS[SC_NO].D1221 := FieldByName('D1221').AsString ;
        SC_STATUS[SC_NO].D1222 := FieldByName('D1222').AsString ;
        SC_STATUS[SC_NO].D1223 := FieldByName('D1223').AsString ;
        SC_STATUS[SC_NO].D1224 := FieldByName('D1224').AsString ;
        SC_STATUS[SC_NO].D1225 := FieldByName('D1225').AsString ;
        SC_STATUS[SC_NO].D1226 := FieldByName('D1226').AsString ;
        SC_STATUS[SC_NO].D1227 := FieldByName('D1227').AsString ;
        SC_STATUS[SC_NO].D1228 := FieldByName('D1228').AsString ;
        SC_STATUS[SC_NO].D1229 := FieldByName('D1229').AsString ;
        SC_STATUS[SC_NO].D1230 := FieldByName('D1230').AsString ;
        SC_STATUS[SC_NO].D1231 := FieldByName('D1231').AsString ;     //

        SC_STATUS[SC_NO].D1232 := FieldByName('D1232').AsString ;
        SC_STATUS[SC_NO].D1233 := FieldByName('D1233').AsString ;
        SC_STATUS[SC_NO].D1234 := FieldByName('D1234').AsString ;
        SC_STATUS[SC_NO].D1235 := FieldByName('D1235').AsString ;
        SC_STATUS[SC_NO].D1236 := FieldByName('D1236').AsString ;
        SC_STATUS[SC_NO].D1237 := FieldByName('D1237').AsString ;
        SC_STATUS[SC_NO].D1238 := FieldByName('D1238').AsString ;
        SC_STATUS[SC_NO].D1239 := FieldByName('D1239').AsString ;
        SC_STATUS[SC_NO].D1240 := FieldByName('D1240').AsString ;
        SC_STATUS[SC_NO].D1241 := FieldByName('D1241').AsString ;
        SC_STATUS[SC_NO].D1242 := FieldByName('D1242').AsString ;
        SC_STATUS[SC_NO].D1243 := FieldByName('D1243').AsString ;
        SC_STATUS[SC_NO].D1244 := FieldByName('D1244').AsString ;
        SC_STATUS[SC_NO].D1245 := FieldByName('D1245').AsString ;
        SC_STATUS[SC_NO].D1246 := FieldByName('D1246').AsString ;
        SC_STATUS[SC_NO].D1247 := FieldByName('D1247').AsString ;
        SC_STATUS[SC_NO].D1248 := FieldByName('D1248').AsString ;
        SC_STATUS[SC_NO].D1249 := FieldByName('D1249').AsString ;
        SC_STATUS[SC_NO].D1250 := FieldByName('D1250').AsString ;
        SC_STATUS[SC_NO].D1251 := FieldByName('D1251').AsString ;
        SC_STATUS[SC_NO].D1252 := FieldByName('D1252').AsString ;
        SC_STATUS[SC_NO].D1253 := FieldByName('D1253').AsString ;
        SC_STATUS[SC_NO].D1254 := FieldByName('D1254').AsString ;
        SC_STATUS[SC_NO].D1255 := FieldByName('D1255').AsString ;
        SC_STATUS[SC_NO].D1256 := FieldByName('D1256').AsString ;
        SC_STATUS[SC_NO].D1257 := FieldByName('D1257').AsString ;
        SC_STATUS[SC_NO].D1258 := FieldByName('D1258').AsString ;
        SC_STATUS[SC_NO].D1259 := FieldByName('D1259').AsString ;
        SC_STATUS[SC_NO].D1260 := FieldByName('D1260').AsString ;
        SC_STATUS[SC_NO].D1261 := FieldByName('D1261').AsString ;
        SC_STATUS[SC_NO].D1262 := FieldByName('D1262').AsString ;
        SC_STATUS[SC_NO].D1263 := FieldByName('D1263').AsString ;  //

        SC_STATUS[SC_NO].D1264 := FieldByName('D1264').AsString ;
        SC_STATUS[SC_NO].D1265 := FieldByName('D1265').AsString ;
        SC_STATUS[SC_NO].D1266 := FieldByName('D1266').AsString ;
        SC_STATUS[SC_NO].D1267 := FieldByName('D1267').AsString ;
        SC_STATUS[SC_NO].D1268 := FieldByName('D1268').AsString ;
        SC_STATUS[SC_NO].D1269 := FieldByName('D1269').AsString ;
        SC_STATUS[SC_NO].D1270 := FieldByName('D1270').AsString ;
        SC_STATUS[SC_NO].D1271 := FieldByName('D1271').AsString ;
        SC_STATUS[SC_NO].D1272 := FieldByName('D1272').AsString ;
        SC_STATUS[SC_NO].D1273 := FieldByName('D1273').AsString ;
        SC_STATUS[SC_NO].D1274 := FieldByName('D1274').AsString ;
        SC_STATUS[SC_NO].D1275 := FieldByName('D1275').AsString ;
        SC_STATUS[SC_NO].D1276 := FieldByName('D1276').AsString ;
        SC_STATUS[SC_NO].D1277 := FieldByName('D1277').AsString ;
        SC_STATUS[SC_NO].D1278 := FieldByName('D1278').AsString ;
        SC_STATUS[SC_NO].D1279 := FieldByName('D1279').AsString ;
        SC_STATUS[SC_NO].D1280 := FieldByName('D1280').AsString ;
        SC_STATUS[SC_NO].D1281 := FieldByName('D1281').AsString ;
        SC_STATUS[SC_NO].D1282 := FieldByName('D1282').AsString ;
        SC_STATUS[SC_NO].D1283 := FieldByName('D1283').AsString ;
        SC_STATUS[SC_NO].D1284 := FieldByName('D1284').AsString ;
        SC_STATUS[SC_NO].D1285 := FieldByName('D1285').AsString ;
        SC_STATUS[SC_NO].D1286 := FieldByName('D1286').AsString ;
        SC_STATUS[SC_NO].D1287 := FieldByName('D1287').AsString ;
        SC_STATUS[SC_NO].D1288 := FieldByName('D1288').AsString ;
        SC_STATUS[SC_NO].D1289 := FieldByName('D1289').AsString ;
        SC_STATUS[SC_NO].D1290 := FieldByName('D1290').AsString ;
        SC_STATUS[SC_NO].D1291 := FieldByName('D1291').AsString ;
        SC_STATUS[SC_NO].D1292 := FieldByName('D1292').AsString ;
        SC_STATUS[SC_NO].D1293 := FieldByName('D1293').AsString ;
        SC_STATUS[SC_NO].D1294 := FieldByName('D1294').AsString ;
        SC_STATUS[SC_NO].D1295 := FieldByName('D1295').AsString ;  //

        SC_STATUS[SC_NO].D1296 := FieldByName('D1296').AsString ;
        SC_STATUS[SC_NO].D1297 := FieldByName('D1297').AsString ;
        SC_STATUS[SC_NO].D1298 := FieldByName('D1298').AsString ;
        SC_STATUS[SC_NO].D1299 := FieldByName('D1299').AsString ;
        SC_STATUS[SC_NO].D1300 := FieldByName('D1300').AsString ;
        SC_STATUS[SC_NO].D1301 := FieldByName('D1301').AsString ;
        SC_STATUS[SC_NO].D1302 := FieldByName('D1302').AsString ;
        SC_STATUS[SC_NO].D1303 := FieldByName('D1303').AsString ;
        SC_STATUS[SC_NO].D1304 := FieldByName('D1304').AsString ;
        SC_STATUS[SC_NO].D1305 := FieldByName('D1305').AsString ;
        SC_STATUS[SC_NO].D1306 := FieldByName('D1306').AsString ;
        SC_STATUS[SC_NO].D1307 := FieldByName('D1307').AsString ;
        SC_STATUS[SC_NO].D1308 := FieldByName('D1308').AsString ;
        SC_STATUS[SC_NO].D1309 := FieldByName('D1309').AsString ;
        SC_STATUS[SC_NO].D1310 := FieldByName('D1310').AsString ;
        SC_STATUS[SC_NO].D1311 := FieldByName('D1311').AsString ;
        SC_STATUS[SC_NO].D1312 := FieldByName('D1312').AsString ;
        SC_STATUS[SC_NO].D1313 := FieldByName('D1313').AsString ;
        SC_STATUS[SC_NO].D1314 := FieldByName('D1314').AsString ;
        SC_STATUS[SC_NO].D1315 := FieldByName('D1315').AsString ;
        SC_STATUS[SC_NO].D1316 := FieldByName('D1316').AsString ;
        SC_STATUS[SC_NO].D1317 := FieldByName('D1317').AsString ;
        SC_STATUS[SC_NO].D1318 := FieldByName('D1318').AsString ;
        SC_STATUS[SC_NO].D1319 := FieldByName('D1319').AsString ;
        SC_STATUS[SC_NO].D1320 := FieldByName('D1320').AsString ;
        SC_STATUS[SC_NO].D1321 := FieldByName('D1321').AsString ;
        SC_STATUS[SC_NO].D1322 := FieldByName('D1322').AsString ;
        SC_STATUS[SC_NO].D1323 := FieldByName('D1323').AsString ;
        SC_STATUS[SC_NO].D1324 := FieldByName('D1324').AsString ;
        SC_STATUS[SC_NO].D1325 := FieldByName('D1325').AsString ;
        SC_STATUS[SC_NO].D1326 := FieldByName('D1326').AsString ;
        SC_STATUS[SC_NO].D1327 := FieldByName('D1327').AsString ;  //

        SC_STATUS[SC_NO].D1328 := FieldByName('D1328').AsString ;
        SC_STATUS[SC_NO].D1329 := FieldByName('D1329').AsString ;
        SC_STATUS[SC_NO].D1330 := FieldByName('D1330').AsString ;
        SC_STATUS[SC_NO].D1331 := FieldByName('D1331').AsString ;
        SC_STATUS[SC_NO].D1332 := FieldByName('D1332').AsString ;
        SC_STATUS[SC_NO].D1333 := FieldByName('D1333').AsString ;
        SC_STATUS[SC_NO].D1334 := FieldByName('D1334').AsString ;
        SC_STATUS[SC_NO].D1335 := FieldByName('D1335').AsString ;
        SC_STATUS[SC_NO].D1336 := FieldByName('D1336').AsString ;
        SC_STATUS[SC_NO].D1337 := FieldByName('D1337').AsString ;
        SC_STATUS[SC_NO].D1338 := FieldByName('D1338').AsString ;
        SC_STATUS[SC_NO].D1339 := FieldByName('D1339').AsString ;
        SC_STATUS[SC_NO].D1340 := FieldByName('D1340').AsString ;
        SC_STATUS[SC_NO].D1341 := FieldByName('D1341').AsString ;
        SC_STATUS[SC_NO].D1342 := FieldByName('D1342').AsString ;
        SC_STATUS[SC_NO].D1343 := FieldByName('D1343').AsString ;
        SC_STATUS[SC_NO].D1344 := FieldByName('D1344').AsString ;
        SC_STATUS[SC_NO].D1345 := FieldByName('D1345').AsString ;
        SC_STATUS[SC_NO].D1346 := FieldByName('D1346').AsString ;
        SC_STATUS[SC_NO].D1347 := FieldByName('D1347').AsString ;
        SC_STATUS[SC_NO].D1348 := FieldByName('D1348').AsString ;
        SC_STATUS[SC_NO].D1349 := FieldByName('D1349').AsString ;
        SC_STATUS[SC_NO].D1350 := FieldByName('D1350').AsString ;
        SC_STATUS[SC_NO].D1351 := FieldByName('D1351').AsString ;
        SC_STATUS[SC_NO].D1352 := FieldByName('D1352').AsString ;
        SC_STATUS[SC_NO].D1353 := FieldByName('D1353').AsString ;
        SC_STATUS[SC_NO].D1354 := FieldByName('D1354').AsString ;
        SC_STATUS[SC_NO].D1355 := FieldByName('D1355').AsString ;
        SC_STATUS[SC_NO].D1356 := FieldByName('D1356').AsString ;
        SC_STATUS[SC_NO].D1357 := FieldByName('D1357').AsString ;
        SC_STATUS[SC_NO].D1358 := FieldByName('D1358').AsString ;
        SC_STATUS[SC_NO].D1359 := FieldByName('D1359').AsString ;  //

        SC_STATUS[SC_NO].D1360 := FieldByName('D1360').AsString ;
        SC_STATUS[SC_NO].D1361 := FieldByName('D1361').AsString ;
        SC_STATUS[SC_NO].D1362 := FieldByName('D1362').AsString ;
        SC_STATUS[SC_NO].D1363 := FieldByName('D1363').AsString ;
        SC_STATUS[SC_NO].D1364 := FieldByName('D1364').AsString ;
        SC_STATUS[SC_NO].D1365 := FieldByName('D1365').AsString ;
        SC_STATUS[SC_NO].D1366 := FieldByName('D1366').AsString ;
        SC_STATUS[SC_NO].D1367 := FieldByName('D1367').AsString ;
        SC_STATUS[SC_NO].D1368 := FieldByName('D1368').AsString ;
        SC_STATUS[SC_NO].D1369 := FieldByName('D1369').AsString ;
        SC_STATUS[SC_NO].D1370 := FieldByName('D1370').AsString ;
        SC_STATUS[SC_NO].D1371 := FieldByName('D1371').AsString ;
        SC_STATUS[SC_NO].D1372 := FieldByName('D1372').AsString ;
        SC_STATUS[SC_NO].D1373 := FieldByName('D1373').AsString ;
        SC_STATUS[SC_NO].D1374 := FieldByName('D1374').AsString ;
        SC_STATUS[SC_NO].D1375 := FieldByName('D1375').AsString ;
        SC_STATUS[SC_NO].D1376 := FieldByName('D1376').AsString ;
        SC_STATUS[SC_NO].D1377 := FieldByName('D1377').AsString ;
        SC_STATUS[SC_NO].D1378 := FieldByName('D1378').AsString ;
        SC_STATUS[SC_NO].D1379 := FieldByName('D1379').AsString ;
        SC_STATUS[SC_NO].D1380 := FieldByName('D1380').AsString ;
        SC_STATUS[SC_NO].D1381 := FieldByName('D1381').AsString ;
        SC_STATUS[SC_NO].D1382 := FieldByName('D1382').AsString ;
        SC_STATUS[SC_NO].D1383 := FieldByName('D1383').AsString ;
        SC_STATUS[SC_NO].D1384 := FieldByName('D1384').AsString ;
        SC_STATUS[SC_NO].D1385 := FieldByName('D1385').AsString ;
        SC_STATUS[SC_NO].D1386 := FieldByName('D1386').AsString ;
        SC_STATUS[SC_NO].D1387 := FieldByName('D1387').AsString ;
        SC_STATUS[SC_NO].D1388 := FieldByName('D1388').AsString ;
        SC_STATUS[SC_NO].D1389 := FieldByName('D1389').AsString ;
        SC_STATUS[SC_NO].D1390 := FieldByName('D1390').AsString ;
        SC_STATUS[SC_NO].D1391 := FieldByName('D1391').AsString ;

        //라이트 커튼 상태
        PLC_ReadVal.InSt_Door[1] := SC_STATUS[SC_NO].D212[0];
        PLC_ReadVal.OtSt_Door[1] := SC_STATUS[SC_NO].D212[1];
        PLC_ReadVal.InSt_Door[2] := SC_STATUS[SC_NO].D212[2];
        PLC_ReadVal.OtSt_Door[2] := SC_STATUS[SC_NO].D212[3];
        PLC_ReadVal.InSt_Door[3] := SC_STATUS[SC_NO].D212[4];
        PLC_ReadVal.OtSt_Door[3] := SC_STATUS[SC_NO].D212[5];


        StrLog := ' READ SC'+IntToStr(SC_No)+
                  ' | D200-' + SC_STATUS[SC_NO].D200 +
                  ' | D201-' + SC_STATUS[SC_NO].D201 +
                  ' | D202-' + SC_STATUS[SC_NO].D202 +
                  ' | D203-' + SC_STATUS[SC_NO].D203 +
                  ' | D204-' + SC_STATUS[SC_NO].D204 +
                  ' | D205-' + SC_STATUS[SC_NO].D205 +
                  ' | D206-' + SC_STATUS[SC_NO].D206 +
                  ' | D207-' + SC_STATUS[SC_NO].D207 +
                  ' | D208-' + SC_STATUS[SC_NO].D208 +
                  ' | D209-' + SC_STATUS[SC_NO].D209 +
                  ' | D210-' + D210 +
                  ' | D211-' + D211 +
                  ' | D1200-' + SC_STATUS[SC_NO].D1200 +
                  ' | D1201-' + SC_STATUS[SC_NO].D1201 +
                  ' | D1202-' + SC_STATUS[SC_NO].D1202 +
                  ' | D1203-' + SC_STATUS[SC_NO].D1203 +
                  ' | D1204-' + SC_STATUS[SC_NO].D1204 +
                  ' | D1205-' + SC_STATUS[SC_NO].D1205 +
                  ' | D1206-' + SC_STATUS[SC_NO].D1206 +
                  ' | D1207-' + SC_STATUS[SC_NO].D1207 +
                  ' | D1208-' + SC_STATUS[SC_NO].D1208 +
                  ' | D1209-' + SC_STATUS[SC_NO].D1209 +
                  ' | D1210-' + SC_STATUS[SC_NO].D1210 +
                  ' | D1211-' + SC_STATUS[SC_NO].D1211 +
                  ' | D1212-' + SC_STATUS[SC_NO].D1212 +
                  ' | D1213-' + SC_STATUS[SC_NO].D1213 +
                  ' | D1214-' + SC_STATUS[SC_NO].D1214 +
                  ' | D1215-' + SC_STATUS[SC_NO].D1215 +
                  ' | D1216-' + SC_STATUS[SC_NO].D1216 +
                  ' | D1217-' + SC_STATUS[SC_NO].D1217 +
                  ' | D1218-' + SC_STATUS[SC_NO].D1218 +
                  ' | D1219-' + SC_STATUS[SC_NO].D1219 +
                  ' | D1220-' + SC_STATUS[SC_NO].D1220 +
                  ' | D1221-' + SC_STATUS[SC_NO].D1221 +
                  ' | D1222-' + SC_STATUS[SC_NO].D1222 +
                  ' | D1223-' + SC_STATUS[SC_NO].D1223 +
                  ' | D1224-' + SC_STATUS[SC_NO].D1224 +
                  ' | D1225-' + SC_STATUS[SC_NO].D1225 +
                  ' | D1226-' + SC_STATUS[SC_NO].D1226 +
                  ' | D1227-' + SC_STATUS[SC_NO].D1227 +
                  ' | D1228-' + SC_STATUS[SC_NO].D1228 +
                  ' | D1229-' + SC_STATUS[SC_NO].D1229 +
                  ' | D1230-' + SC_STATUS[SC_NO].D1230 +
                  ' | D1231-' + SC_STATUS[SC_NO].D1231 ;
        DisplayLog(SC_No, StrLog, 'N', Length(StrLog)) ;
      end;
      Close;
    end;
    SC_StatusDisplay(SC_NO); // SC상태 Display
  except
    On E:Exception do
    begin
      qryREAD.Close;
      ErrorLogWRITE( 'Procedure SCTREAD SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// SCTWRITE
//==============================================================================
procedure TfrmSCComm.SCTWRITE(SC_NO:Integer);
var
  str, StrHigh, StrLow : String ;
begin
  if CONTROL_FLAG[SC_NO] = ComRead then
  begin
    //
  end else
  if CONTROL_FLAG[SC_NO] = ComWrite then
  begin
    fnSetWriteInfo(SC_NO, SC_JOB[SC_NO].IO_TYPE) ;
  end;
end;

//==============================================================================
// SC Control Process
//==============================================================================
procedure TfrmSCComm.SCControlProcess(SC_NO:Integer);
var
  Str, StrLog : String ;
  ErrorCode, ErrHigh, ErrLow, MOV_NO : String ;
begin
  staInfo.Panels[0].Text := fnGetSCStatus(SC_STAT[SC_NO]) ;
  staInfo.Panels[1].Text := fnGetSCStatus2(SC_STAT[SC_NO]) ;

  TEdit(FindComponent('edt_Step')).Text := fnGetSCStatus(SC_STAT[SC_NO]) ;


  {*  SCNowStatusUpdate            *}    {*  SCNowCycleUpdate     *}
  {*   START                       *}    {*   0: Idle             *}
  {*   STANDBY                     *}    {*   1: 작업지시         *}
  {*   DATA1, ORDER1, RESET1, ERR1 *}    {*   2: 작업중           *}
  {*   DATA2, ORDER2, RESET2, ERR2 *}    {*   3: 화물 재하        *}
  {*   RETRY_REQ                   *}    {*   4: 작업완료         *}
  {*   CANCEL_REQ                  *}    {*   5: 작업 에러발생    *}
  {*   DATAERR                     *}    {*   6: 데이터 에러 발생 *}


  case SC_STAT[SC_NO] of
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // START : SC 프로그램이 최초 기동된 상태
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    START   :
    begin
      SCNowStatusUpdate(SC_NO,'START') ; // SC 현재 Status 업데이트[START]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read 구역
      SC_STAT[SC_NO] := STANDBY ;        // START -> STANDBY : SC작업 대기 상태로 변경.
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // STANDBY : SC 상태를 보고, 작업 지시 가능이면 READY1 으로 변경
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    STANDBY :
    begin
      SCNowStatusUpdate(SC_NO,'STANDBY') ; // SC 현재 상태 업데이트[STANDBY]
      CONTROL_FLAG[SC_NO] := ComRead ;     // Read 구역

      SC_OrderDisplayClear(SC_NO) ;      // SC 지시 데이터 표시 초기화
      fnSetSCSetInfo_Clear(SC_NO) ;      // 모니터링 작업지시 초기화1
      fnSetSCSetInfo_Clear2(SC_NO) ;     // 모니터링 작업지시 초기화2

      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG := '9999';
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        Exit;
      end ;


      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // 비상정지 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[08] = '1') and  // 포크센터 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[09] = '0') and  // 화물유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D210[15] = '0') and  // 에러유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D211[00] = '1') and  // 대기 중  (0: Off, 1: On )
         (SC_STATUS[SC_NO].D211[01] = '0') then // 작업 중  (0: Off, 1: On )
      begin
        SC_STAT[SC_NO] := READY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // READY : 작업을 검색하여 SC작업이 있으면 작업 데이터 등록 및 지시
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    READY  :
    begin
      SCNowStatusUpdate(SC_NO,'READY') ; // SC 현재 상태 업데이트[READY]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write 구역

      SC_OrderDisplayClear(SC_NO) ;      // SC 지시 데이터 표시 초기화
      fnSetSCSetInfo_Clear(SC_NO) ;      // 모니터링 작업지시 초기화1
      fnSetSCSetInfo_Clear2(SC_NO) ;     // 모니터링 작업지시 초기화2


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG := '9999';
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        Exit;
      end;


      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // 비상정지 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[08] = '1') and  // 포크센터 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[09] = '0') and  // 화물유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D210[15] = '0') and  // 에러유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D211[00] = '1') and  // 대기 중  (0: Off, 1: On )
         (SC_STATUS[SC_NO].D211[01] = '0') then // 작업 중  (0: Off, 1: On )
      begin
        if (SC_JOB[SC_NO].ID_ORDLUGG = '') and
           (SC_JOB[SC_NO].ID_REGTIME = '') then
        begin
          if      Job_Flag[SC_NO] = None       then Job_Flag[SC_NO] := StoreIn    // None   -> 입고
          else if Job_Flag[SC_NO] = StoreIn    then Job_Flag[SC_NO] := StoreOut   // 입고   -> 출고
          else if Job_Flag[SC_NO] = StoreOut   then Job_Flag[SC_NO] := RackToRack // 출고   -> 랙이동
          else if Job_Flag[SC_NO] = RackToRack then Job_Flag[SC_NO] := StoreIn;   // 랙이동 -> 입고

          if ( ((Job_Flag[SC_NO] = StoreIn)  and (not fnGetSCSetInfo(SC_No, 'SC_IN_USED'))) or
               ((Job_Flag[SC_NO] = StoreOut) and (not fnGetSCSetInfo(SC_No, 'SC_OT_USED'))) or
               ((Job_Flag[SC_NO] = RackToRack) and (not fnGetSCSetInfo(SC_NO, 'RACK_MOVE'))) ) then Exit;

          if fnGetSCJOB(SC_NO, Job_Flag[SC_NO]) then
          begin
            fnOrder_Update(SC_NO, 'NOWMC', '2') ;
            fnOrder_Update(SC_NO, 'JOBSTATUS', '2', 'NOWSTATUS', '2' ) ;
            SC_JOB[SC_NO].MOVE_ON := '1';     // 기동지시
            CONTROL_FLAG[SC_NO] := ComWrite ; // 작업지시
            SC_STAT[SC_NO] := DATA1 ;
          end;

        end;
      end else
      begin
        SC_STAT[SC_NO] := STANDBY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // DATA1 : SC에 작업이 정상등록 되었는지 확인
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    DATA1   :
    begin
      SCNowStatusUpdate(SC_NO,'DATA1') ; // SC 현재 상태 업데이트[DATA1]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write 구역


      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;


      //++++++++++++++++
      // 로딩 데이터 체크
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // 비상정지 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // 에러유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D210[10] = '1') then // 로딩이 시작 되면 Order1
      begin
        fnOrder_Update(SC_NO, 'JOBSTATUS', '3', 'NOWSTATUS', '3' ) ;
        SC_STAT[SC_NO] := ORDER1 ;

        if (fnOrder_Value(SC_No, 'JOBERRORD') <> '' ) and
           (fnOrder_Value(SC_No, 'JOBERRORD') <> '0') then fnSetMachError(SC_NO, '0') ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D205 = '0073') or   // 지령 Data 이상
             (SC_STATUS[SC_NO].D205 = '0074') then // 지령 Data 없음
          begin
            SC_STAT[SC_NO] := DATAERR ;
          end;
          fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;
        end;
      end;


      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // ORDER1 : SC 작업 완료 상태 및 에러 상태 체크
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ORDER1  :
    begin
      SCNowStatusUpdate(SC_NO,'ORDER1') ; // SC 현재 상태 업데이트[DATA1]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write 구역


      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;


      //++++++++++++++++
      // 로딩 완료 체크
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // 비상정지 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // 에러유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D210[10] <>'1') then // 로딩이 완료 되면 Reset1
      begin
        SC_STAT[SC_NO] := RESET1 ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D211[04] = '1') then // 공출고
          begin
            SC_STAT[SC_NO] := ERR1 ;
            fnStockUpdate(SC_NO,'ID_STATUS','7') ; // 셀상태 공출고로 변경
          end;
          fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;
        end;
      end;


      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // RESET1 : Loading작업 완료 처리 및 UnLoading(DATA2) 단계 진행
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RESET1  :
    begin
      SCNowStatusUpdate(SC_NO,'RESET1') ; // SC 현재 상태 업데이트[RESET1]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write 구역


      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;


      //++++++++++++++++
      // 로딩완료 처리
      //++++++++++++++++
      if (SC_JOB[SC_NO].SC_STEP = 'L') then // 작업단계 Loading이면
      begin
        if fnSCIO_Update(SC_NO) then // Loading -> UnLoading으로 변경
        begin
          fnOrder_Update(SC_NO, 'NOWMC', '3', 'NOWSTATUS', '2' ) ; // NOWMC(6:SC UnLoading) , NOWSTATUS(2:지시)로 변경 & JOBSTATUS(3:진행중) 상태
          SC_STAT[SC_NO] := DATA2 ;          // SC Unloading 작업 지시중이라는 상태로 만든다.
        end;
      end;


      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // DATA2 : SC에 작업이 정상등록 되었는지 확인
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    DATA2   :
    begin
      SCNowStatusUpdate(SC_NO,'DATA2') ; // SC 현재 상태 업데이트[DATA2]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write 구역


      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;


      //++++++++++++++++
      // 언로딩 데이터 체크
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // 비상정지 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // 에러유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D210[11] = '1') then // 언로딩이 시작 되면 Order2
      begin
        fnOrder_Update(SC_NO, 'JOBSTATUS', '3', 'NOWSTATUS', '3' ) ;
        SC_STAT[SC_NO] := ORDER2 ;


        if (fnOrder_Value(SC_No, 'JOBERRORD') <> '' ) and
           (fnOrder_Value(SC_No, 'JOBERRORD') <> '0') then fnSetMachError(SC_NO, '0') ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D205 = '0073') or   // 지령 Data 이상
             (SC_STATUS[SC_NO].D205 = '0074') then // 지령 Data 없음
          begin
            SC_STAT[SC_NO] := DATAERR ;
          end;
          fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;
        end;
      end;


      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // ORDER2 : SC 작업 완료 상태 및 에러 상태 체크
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ORDER2  :
    begin
      SCNowStatusUpdate(SC_NO,'ORDER2') ; // SC 현재 상태 업데이트[ORDER2]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write 구역


      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;


      //++++++++++++++++
      // 언로딩 완료 체크
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // 비상정지 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // 에러유무 (0:없음, 1:있음)
         (SC_STATUS[SC_NO].D211[02] = '1') then // 작업완료 (0: Off, 1: On )
      begin
        SC_STAT[SC_NO] := RESET2 ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D211[03] = '1') then // 이중입고
          begin
            SC_STAT[SC_NO] := ERR2 ;
            fnStockUpdate(SC_NO,'ID_STATUS','6') ;  // 셀상태 이중입고로 변경
          end else
          if (SC_STATUS[SC_NO].D210[09] = '0') then // 화물 없고
          begin
            SC_STAT[SC_NO] := RESET2 ;
          end;
          fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;
        end;
      end;


      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // RESET2 : UnLoading작업완료 처리 및 최종작업 완료
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RESET2  :
    begin
      SCNowStatusUpdate(SC_NO,'RESET2') ; // SC 현재 상태 업데이트[RESET2]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write 구역


      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;


      //++++++++++++++++
      // 언로딩 완료 처리
      //++++++++++++++++
      if SC_JOB[SC_NO].SC_STEP = 'U' then
      begin
        if fnOrder_Delete(SC_NO) then // 작업 완료 처리.
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
        end;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // ERR1,ERR2 : Loading, UnLoading 단계에서의 에러처리
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ERR1, ERR2 :
    begin
      SCNowStatusUpdate(SC_NO,'ERR') ;   // SC 현재 상태 업데이트[RETRY_REQ]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write 구역
      fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;

      //++++++++++++++++
      // 재기동
      //++++++++++++++++
      if (fnGetSCSetInfo(SC_No,'JOB_RETRY')) then // 모니터링 재기동 On
      begin
        fnSetSCSetInfo(SC_No, 'JOB_RETRY', '0');
        SC_JOB[SC_No].JOB_RETRY := '1';

        if (SC_STATUS[SC_NO].D211[03] = '1') then // 이중입고
        begin
          SC_JOB[SC_No].DATA_RESET := '1';
          SC_STAT[SC_NO] := ORDER2 ;
          fnCellPosChange(SC_NO,'1');
          fnChkSCJOB(SC_NO);
          CONTROL_FLAG[SC_NO] := ComWrite ;
          SC_JOB[SC_NO].MOVE_ON := '1';
        end else
        if (SC_STATUS[SC_NO].D211[04] = '1') then // 공출고
        begin
          SC_JOB[SC_No].DATA_RESET := '1';
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          SC_STAT[SC_NO] := STANDBY ;
          fnSCIO_Delete(SC_NO) ;
          CONTROL_FLAG[SC_NO] := ComWrite ;
        end;
        Exit;
      end;


      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;



      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // DATAERR : 작업지시 데이터 이상 에러 발생
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    DATAERR :
    begin
      SCNowStatusUpdate(SC_NO,'DATAERR') ; // SC 현재 상태 업데이트[RETRY_REQ]
      CONTROL_FLAG[SC_NO] := ComRead ;     // Read & Write 구역
      fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;

      //++++++++++++++++
      // 강제완료
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D211[07] = '1') then
      begin
        if fnOrder_Delete(SC_NO) then
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
          Exit;
        end;
      end;


      //++++++++++++++++
      // 데이터초기화
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER 삭제
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO 삭제
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // 셀상태 변경
        Exit;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // RETRY_REQ : 재기동 처리
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RETRY_REQ  :
    begin
      SCNowStatusUpdate(SC_NO,'RETRY_REQ') ; // SC 현재 상태 업데이트[RETRY_REQ]

      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC 자동 (0:수동, 1:자동)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // 비상정지 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[08] = '1') and  // 포크센터 (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') then // 에러유무 (0:없음, 1:있음)
      begin
        if      SC_JOB[SC_NO].SC_STEP = 'L' then SC_STAT[SC_NO] := ORDER1   // SC Loading   중이면 ORDER1 상태로
        else if SC_JOB[SC_NO].SC_STEP = 'U' then SC_STAT[SC_NO] := ORDER2 ; // SC UnLoading 중이면 ORDER2 상태로
        CONTROL_FLAG[SC_NO] := ComWrite ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // CANCEL_REQ : 작업 취소 Flag가 들어오면 변수 변경 후 STANDBY로 변경
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    CANCEL_REQ :
    begin
      SCNowStatusUpdate(SC_NO,'CANCEL_REQ') ;   // SC 현재 상태 업데이트[CANCEL_REQ]
    end;

  end;
end;

//==============================================================================
// fnSetWriteInfo : 지시 데이터 SET
//==============================================================================
function TfrmSCComm.fnSetWriteInfo(SC_NO:Integer;Job_Type:String): Boolean;
var
  TempIdx : Integer;
  StrLog : String ;
begin
  SC_ORDClear(SC_NO) ; // 지시 구조체 초기화

  //++++++++++++++++++++++++++
  // 데이터 Reset
  //++++++++++++++++++++++++++
  if (SC_STATUS[SC_NO].D211[03] = '1') or   // 이중입고
     (SC_STATUS[SC_NO].D211[04] = '1') or   // 공출고
     (fnGetSCSetInfo(SC_No,'JOB_CANCLE')) or
     (SC_JOB[SC_No].DATA_RESET = '1') then
  begin
    SC_JOB[SC_No].DATA_RESET := '0';
    fnSetSCSetInfo(SC_No, 'JOB_CANCLE', '0') ;
    SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ; //작업번호
    SC_ORDER[SC_NO].SCORD_D100 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D101 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D102 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D103 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D104 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D105 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D106 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D107 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D108 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D109 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D110 := '0032'; // DATA RESET

    fnSetSCORDWrite(SC_NO,'2'); // 지시데이터 생성 후 TT_SCORD 테이블에 지시 Insert
    fnSetSCSetInfo(SC_No,'DATA_RESET','1');
  end;


  //++++++++++++++++++++++++++++++++
  // 작업완료 보고 시 기동지시 OFF
  //++++++++++++++++++++++++++++++++
  if (SC_JOB[SC_No].JOB_COMPLETE = '1') or
     (fnGetSCSetInfo(SC_No,'JOB_COMPLETE')) then
  begin
    Sleep(1000);
    SC_JOB[SC_No].JOB_COMPLETE := '0';

    // 작업완료보고 Reset Command 데이터
    SC_ORDER[SC_NO].SCORD_NO := SC_JOB[SC_NO].ID_ORDLUGG ; //작업번호
    SC_ORDER[SC_NO].SCORD_D100 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D101 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D102 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D103 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D104 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D105 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D106 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D107 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D108 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D109 := '0000'; // NONE DATA
    SC_ORDER[SC_NO].SCORD_D110 := '0000'; // NONE DATA

    TEdit(Self.FindComponent('edt_MoveOn')).Text := '' ; // 기동지시 Off
    fnSetSCSetInfo(SC_No,'MOVE_ON','0');
    fnSetSCORDWrite(SC_NO,'2');
    SC_JOBClear(SC_NO);
  end else
  begin
    Sleep(500);
    //--------------------------------------------------------------------------
    // 정상입고&이중입고재기동, 정상출고&공출고재기동
    //--------------------------------------------------------------------------
    if (Job_Type = 'I') and (SC_JOB[SC_NO].ID_ORDLUGG<>'')  then // 정상입고
    begin
      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ;    // 작업번호
      SC_ORDER[SC_NO].SCORD_D100 := '0000';                       // 적재 열
      SC_ORDER[SC_NO].SCORD_D101 := '0000';                       // 적재 연
      SC_ORDER[SC_NO].SCORD_D102 := '0001';                       // 적재 단
      SC_ORDER[SC_NO].SCORD_D103 := SC_JOB[SC_NO].UNLOAD_BANK;    // 하역 열
      SC_ORDER[SC_NO].SCORD_D104 := SC_JOB[SC_NO].UNLOAD_BAY;     // 하역 연
      SC_ORDER[SC_NO].SCORD_D105 := SC_JOB[SC_NO].UNLOAD_LEVEL;   // 하역 단
      SC_ORDER[SC_NO].SCORD_D106 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D107 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D108 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D109 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D110 := '0000';                       // 예비

      SC_OrderDisplay(SC_NO);     // SC Order 화면 디스플레이
      fnSetSCORDWrite(SC_NO,'0'); // 지시데이터 생성 후 TT_SCORD 테이블에 지시 Insert
    end else
    if (Job_Type = 'O') and (SC_JOB[SC_NO].ID_ORDLUGG <> '') then // 정상출고
    begin
      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ;    // 작업번호
      SC_ORDER[SC_NO].SCORD_D100 := SC_JOB[SC_NO].LOAD_BANK;      // 적재 열
      SC_ORDER[SC_NO].SCORD_D101 := SC_JOB[SC_NO].LOAD_BAY;       // 적재 연
      SC_ORDER[SC_NO].SCORD_D102 := SC_JOB[SC_NO].LOAD_LEVEL;     // 적재 단
      SC_ORDER[SC_NO].SCORD_D103 := '0000';                       // 하역 열
      SC_ORDER[SC_NO].SCORD_D104 := '0000';                       // 하역 연
      SC_ORDER[SC_NO].SCORD_D105 := '0001';                       // 하역 단
      SC_ORDER[SC_NO].SCORD_D106 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D107 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D108 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D109 := '0000';                       // 예비
      SC_ORDER[SC_NO].SCORD_D110 := '0000';                       // 예비

      SC_OrderDisplay(SC_NO);     // SC Order 화면 디스플레이
      fnSetSCORDWrite(SC_NO,'0'); // 지시데이터 생성 후 TT_SCORD 테이블에 지시 Insert
    end;


    if (SC_JOB[SC_No].MOVE_ON = '1') then
    begin
      Sleep(500);
      SC_JOB[SC_No].MOVE_ON := '0' ;

      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ; //작업번호
      SC_ORDER[SC_NO].SCORD_D100 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D101 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D102 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D103 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D104 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D105 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D106 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D107 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D108 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D109 := '0000'; // NONE DATA
      SC_ORDER[SC_NO].SCORD_D110 := '0001'; // NONE DATA

      TEdit(Self.FindComponent('edt_MoveOn')).Text := 'O' ; // 기동지시 On
      fnSetSCSetInfo(SC_No,'MOVE_ON','1');
      fnSetSCORDWrite(SC_NO,'1'); // 지시데이터 생성 후 TT_SCORD 테이블에 지시 Insert
    end;

    // 커튼 on/off
//    if / True then

    Sleep(2000);
  end;
end;

//==============================================================================
// fnSetSCORDWrite : 지시 데이터 TT_SCORD에 INSERT (MELSEC 프로그램에서 TT_SCORD 폴링 중)
//==============================================================================
function TfrmSCComm.fnSetSCORDWrite(SC_NO: Integer; Falg: String): Boolean;
var
  StrSQL, StrLog, ComdType : String ;
  ExecNo : Integer ;
begin
  Result := False ;
  StrSQL  := ' INSERT INTO TT_SCORD ' +
             '  ( SC_NO, SCORD_NO,  ' +
             '    SCORD_D100, SCORD_D101, SCORD_D102 ,SCORD_D103, SCORD_D104, ' +
             '    SCORD_D105, SCORD_D106, SCORD_D107, SCORD_D108, SCORD_D109, ' +
             '    SCORD_D110, ' +
             '    SCORD_STATUS, SCORD_DT ) ' +
             ' VALUES ( ' +
             '''' + IntToStr(Sc_No) + ''', ' +             // 스태커 번호
             '''' + SC_ORDER[SC_NO].SCORD_NO + ''', ' +    // 작업번호
             '''' + SC_ORDER[SC_NO].SCORD_D100 + ''', ' +  // D100 - 적재 열
             '''' + SC_ORDER[SC_NO].SCORD_D101 + ''', ' +  // D101 - 적재 연
             '''' + SC_ORDER[SC_NO].SCORD_D102 + ''', ' +  // D102 - 적재 단
             '''' + SC_ORDER[SC_NO].SCORD_D103 + ''', ' +  // D103 - 하역 열
             '''' + SC_ORDER[SC_NO].SCORD_D104 + ''', ' +  // D104 - 하역 연
             '''' + SC_ORDER[SC_NO].SCORD_D105 + ''', ' +  // D105 - 하역 단
             '''' + SC_ORDER[SC_NO].SCORD_D106 + ''', ' +  // D106 - 예비
             '''' + SC_ORDER[SC_NO].SCORD_D107 + ''', ' +  // D107 - 예비
             '''' + SC_ORDER[SC_NO].SCORD_D108 + ''', ' +  // D108 - 예비
             '''' + SC_ORDER[SC_NO].SCORD_D109 + ''', ' +  // D109 - 예비
             '''' + SC_ORDER[SC_NO].SCORD_D110 + ''', ' +  // D110 - 기동 지시 또는 Data Reset
             '''' + Falg + ''', ' +                        // STATUS - 0: 지시데이터 1: 기동지시 또는 Data Reset
             'GETDATE() ) ' ;
  try
    with qryWrite do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | PLC Send Comd Type[' + ComdType + ']' +
                  '| SCORD INSERT Success' +
                  ' | ORD_IDX- ' + SC_JOB[SC_No].ID_ORDLUGG +
                  ' | ORD_D100- ' + SC_ORDER[SC_NO].SCORD_D100 +
                  ' | ORD_D101- ' + SC_ORDER[SC_NO].SCORD_D101 +
                  ' | ORD_D102- ' + SC_ORDER[SC_NO].SCORD_D102 +
                  ' | ORD_D103- ' + SC_ORDER[SC_NO].SCORD_D103 +
                  ' | ORD_D104- ' + SC_ORDER[SC_NO].SCORD_D104 +
                  ' | ORD_D105- ' + SC_ORDER[SC_NO].SCORD_D105 +
                  ' | ORD_D106- ' + SC_ORDER[SC_NO].SCORD_D106 +
                  ' | ORD_D107- ' + SC_ORDER[SC_NO].SCORD_D107 +
                  ' | ORD_D108- ' + SC_ORDER[SC_NO].SCORD_D108 +
                  ' | ORD_D109- ' + SC_ORDER[SC_NO].SCORD_D109 +
                  ' | ORD_D110- ' + SC_ORDER[SC_NO].SCORD_D110 ;
        DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      ErrorLogWRITE( 'Function fnSetSCORDWrite SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
      qryWrite.Close ;
    end;
  end;
end;

//==============================================================================
// SC_JOBClear
//==============================================================================
procedure TfrmSCComm.SC_JOBClear(SC_NO: Integer);
var
  i : Integer ;
begin
  if SC_NO = 0 then
  begin
    for i := START_SCNO to End_SCNO do
    begin
      SC_JOB[i].ID_ORDLUGG     := '' ; // 작업 번호
      SC_JOB[i].ID_REGTIME     := '' ; // 작업 생성 시간
      SC_JOB[i].ID_ORDDATE     := '' ; // 작업 생성 일자
      SC_JOB[i].ID_ORDTIME     := '' ; // 작업 생성 일시
      SC_JOB[i].IO_TYPE        := '' ; // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
      SC_JOB[i].LOAD_BANK      := '' ; // 적재 열
      SC_JOB[i].LOAD_BAY       := '' ; // 적재 연
      SC_JOB[i].LOAD_LEVEL     := '' ; // 적재 단
      SC_JOB[i].UNLOAD_BANK    := '' ; // 하역 열
      SC_JOB[i].UNLOAD_BAY     := '' ; // 하역 연
      SC_JOB[i].UNLOAD_LEVEL   := '' ; // 하역 단
      SC_JOB[i].ITM_CD         := '' ; // 기종코드
      SC_JOB[i].SC_STEP        := '' ; // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )
      SC_JOB[i].JOB_RETRY      := '' ; // 이중입고 재기동
      SC_JOB[i].JOB_CANCEL     := '' ; // 작업삭제
      SC_JOB[i].JOB_COMPLETE   := '' ; // 작업완료
      SC_JOB[i].DATA_RESET     := '' ; // 데이터초기화
      SC_JOB[i].MOVE_ON        := '' ; // 기동지시
    end;
  end else
  begin
    SC_JOB[SC_NO].ID_ORDLUGG     := '' ; // 작업 번호
    SC_JOB[SC_NO].ID_REGTIME     := '' ; // 작업 생성 시간
    SC_JOB[SC_NO].ID_ORDDATE     := '' ; // 작업 생성 일자
    SC_JOB[SC_NO].ID_ORDTIME     := '' ; // 작업 생성 일시
    SC_JOB[SC_NO].IO_TYPE        := '' ; // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
    SC_JOB[SC_NO].LOAD_BANK      := '' ; // 적재 열
    SC_JOB[SC_NO].LOAD_BAY       := '' ; // 적재 연
    SC_JOB[SC_NO].LOAD_LEVEL     := '' ; // 적재 단
    SC_JOB[SC_NO].UNLOAD_BANK    := '' ; // 하역 열
    SC_JOB[SC_NO].UNLOAD_BAY     := '' ; // 하역 연
    SC_JOB[SC_NO].UNLOAD_LEVEL   := '' ; // 하역 단
    SC_JOB[SC_NO].ITM_CD         := '' ; // 기종코드
    SC_JOB[SC_NO].SC_STEP        := '' ; // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )
    SC_JOB[SC_NO].JOB_RETRY      := '' ; // 이중입고 재기동
    SC_JOB[SC_NO].JOB_CANCEL     := '' ; // 작업삭제
    SC_JOB[SC_NO].JOB_COMPLETE   := '' ; // 작업완료
    SC_JOB[SC_NO].DATA_RESET     := '' ; // 데이터초기화
    SC_JOB[SC_NO].MOVE_ON        := '' ; // 기동지시
  end;
end;

//==============================================================================
// SC_OLDJOBClear
//==============================================================================
procedure TfrmSCComm.SC_OLDJOBClear(SC_NO: Integer);
var
  i : Integer ;
begin
  if SC_NO = 0 then
  begin
    for i := START_SCNO to End_SCNO do
    begin
      SC_JOB_OLD[i].ID_ORDLUGG       := '' ; // 작업 번호
      SC_JOB_OLD[i].ID_REGTIME       := '' ; // 작업 생성 시간
      SC_JOB_OLD[i].ID_ORDDATE       := '' ; // 작업 생성 일자
      SC_JOB_OLD[i].ID_ORDTIME       := '' ; // 작업 생성 일시
      SC_JOB_OLD[i].IO_TYPE          := '' ; // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
      SC_JOB_OLD[i].LOAD_BANK        := '' ; // 적재 열
      SC_JOB_OLD[i].LOAD_BAY         := '' ; // 적재 연
      SC_JOB_OLD[i].LOAD_LEVEL       := '' ; // 적재 단
      SC_JOB_OLD[i].UNLOAD_BANK      := '' ; // 하역 열
      SC_JOB_OLD[i].UNLOAD_BAY       := '' ; // 하역 연
      SC_JOB_OLD[i].UNLOAD_LEVEL     := '' ; // 하역 단
      SC_JOB_OLD[i].ITM_CD           := '' ; // 기종코드
      SC_JOB_OLD[i].SC_STEP          := '' ; // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )
      SC_JOB_OLD[i].JOB_RETRY        := '' ; // 재기동
      SC_JOB_OLD[i].JOB_CANCEL       := '' ; // 작업삭제
      SC_JOB_OLD[i].JOB_COMPLETE     := '' ; // 작업완료
      SC_JOB_OLD[i].DATA_RESET       := '' ; // 데이터초기화
      SC_JOB_OLD[i].MOVE_ON          := '' ; // 기동지시
    end;
  end else
  begin
    SC_JOB_OLD[SC_NO].ID_ORDLUGG     := '' ; // 작업 번호
    SC_JOB_OLD[SC_NO].ID_REGTIME     := '' ; // 작업 생성 시간
    SC_JOB_OLD[SC_NO].ID_ORDDATE     := '' ; // 작업 생성 일자
    SC_JOB_OLD[SC_NO].ID_ORDTIME     := '' ; // 작업 생성 일시
    SC_JOB_OLD[SC_NO].IO_TYPE        := '' ; // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
    SC_JOB_OLD[SC_NO].LOAD_BANK      := '' ; // 적재 열
    SC_JOB_OLD[SC_NO].LOAD_BAY       := '' ; // 적재 연
    SC_JOB_OLD[SC_NO].LOAD_LEVEL     := '' ; // 적재 단
    SC_JOB_OLD[SC_NO].UNLOAD_BANK    := '' ; // 하역 열
    SC_JOB_OLD[SC_NO].UNLOAD_BAY     := '' ; // 하역 연
    SC_JOB_OLD[SC_NO].UNLOAD_LEVEL   := '' ; // 하역 단
    SC_JOB_OLD[SC_NO].ITM_CD         := '' ; // 기종코드
    SC_JOB_OLD[SC_NO].SC_STEP        := '' ; // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )
    SC_JOB_OLD[SC_NO].JOB_RETRY      := '' ; // 재기동
    SC_JOB_OLD[SC_NO].JOB_CANCEL     := '' ; // 작업삭제
    SC_JOB_OLD[SC_NO].JOB_COMPLETE   := '' ; // 작업완료
    SC_JOB_OLD[SC_NO].DATA_RESET     := '' ; // 데이터초기화
    SC_JOB_OLD[SC_NO].MOVE_ON        := '' ; // 기동지시
  end;
end;

//==============================================================================
// SC_JOBCopy
//==============================================================================
procedure TfrmSCComm.SC_JOBCopy(SC_NO: Integer);
begin
  SC_JOB_OLD[SC_NO].ID_ORDLUGG     := SC_JOB[SC_NO].ID_ORDLUGG     ; // 작업 번호
  SC_JOB_OLD[SC_NO].ID_REGTIME     := SC_JOB[SC_NO].ID_REGTIME     ; // 작업 생성 시간
  SC_JOB_OLD[SC_NO].ID_ORDDATE     := SC_JOB[SC_NO].ID_ORDDATE     ; // 작업 생성 일자
  SC_JOB_OLD[SC_NO].ID_ORDTIME     := SC_JOB[SC_NO].ID_ORDTIME     ; // 작업 생성 일시
  SC_JOB_OLD[SC_NO].IO_TYPE        := SC_JOB[SC_NO].IO_TYPE        ; // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
  SC_JOB_OLD[SC_NO].LOAD_BANK      := SC_JOB[SC_NO].LOAD_BANK      ; // 적재 열
  SC_JOB_OLD[SC_NO].LOAD_BAY       := SC_JOB[SC_NO].LOAD_BAY       ; // 적재 연
  SC_JOB_OLD[SC_NO].LOAD_LEVEL     := SC_JOB[SC_NO].LOAD_LEVEL     ; // 적재 단
  SC_JOB_OLD[SC_NO].UNLOAD_BANK    := SC_JOB[SC_NO].UNLOAD_BANK    ; // 하역 열
  SC_JOB_OLD[SC_NO].UNLOAD_BAY     := SC_JOB[SC_NO].UNLOAD_BAY     ; // 하역 연
  SC_JOB_OLD[SC_NO].UNLOAD_LEVEL   := SC_JOB[SC_NO].UNLOAD_LEVEL   ; // 하역 단
  SC_JOB_OLD[SC_NO].ITM_CD         := SC_JOB[SC_NO].ITM_CD        ; // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )
  SC_JOB_OLD[SC_NO].SC_STEP        := SC_JOB[SC_NO].SC_STEP        ; // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )
  SC_JOB_OLD[SC_NO].JOB_RETRY      := SC_JOB[SC_NO].JOB_RETRY      ; // 재기동
  SC_JOB_OLD[SC_NO].JOB_CANCEL     := SC_JOB[SC_NO].JOB_CANCEL     ; // 작업삭제
  SC_JOB_OLD[SC_NO].JOB_COMPLETE   := SC_JOB[SC_NO].JOB_COMPLETE   ; // 작업완료
  SC_JOB_OLD[SC_NO].DATA_RESET     := SC_JOB[SC_NO].DATA_RESET     ; // 데이터초기화
  SC_JOB_OLD[SC_NO].MOVE_ON        := SC_JOB[SC_NO].MOVE_ON        ; // 기동지시

end;

//==============================================================================
// SC_OLDJOBCopy
//==============================================================================
procedure TfrmSCComm.SC_OLDJOBCopy(SC_NO: Integer);
begin
  SC_JOB[SC_NO].ID_ORDLUGG     := SC_JOB_OLD[SC_NO].ID_ORDLUGG     ; // 작업 번호
  SC_JOB[SC_NO].ID_REGTIME     := SC_JOB_OLD[SC_NO].ID_REGTIME     ; // 작업 생성 시간
  SC_JOB[SC_NO].ID_ORDDATE     := SC_JOB_OLD[SC_NO].ID_ORDDATE     ; // 작업 생성 일자
  SC_JOB[SC_NO].ID_ORDTIME     := SC_JOB_OLD[SC_NO].ID_ORDTIME     ; // 작업 생성 일시
  SC_JOB[SC_NO].IO_TYPE        := SC_JOB_OLD[SC_NO].IO_TYPE        ; // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
  SC_JOB[SC_NO].LOAD_BANK      := SC_JOB_OLD[SC_NO].LOAD_BANK      ; // 적재 열
  SC_JOB[SC_NO].LOAD_BAY       := SC_JOB_OLD[SC_NO].LOAD_BAY       ; // 적재 연
  SC_JOB[SC_NO].LOAD_LEVEL     := SC_JOB_OLD[SC_NO].LOAD_LEVEL     ; // 적재 단
  SC_JOB[SC_NO].UNLOAD_BANK    := SC_JOB_OLD[SC_NO].UNLOAD_BANK    ; // 하역 열
  SC_JOB[SC_NO].UNLOAD_BAY     := SC_JOB_OLD[SC_NO].UNLOAD_BAY     ; // 하역 연
  SC_JOB[SC_NO].UNLOAD_LEVEL   := SC_JOB_OLD[SC_NO].UNLOAD_LEVEL   ; // 하역 단
  SC_JOB[SC_NO].ITM_CD         := SC_JOB_OLD[SC_NO].ITM_CD         ; // 하역 단
  SC_JOB[SC_NO].SC_STEP        := SC_JOB_OLD[SC_NO].SC_STEP        ; // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )
  SC_JOB[SC_NO].JOB_RETRY      := SC_JOB_OLD[SC_NO].JOB_RETRY      ; // 재기동
  SC_JOB[SC_NO].JOB_CANCEL     := SC_JOB_OLD[SC_NO].JOB_CANCEL     ; // 작업삭제
  SC_JOB[SC_NO].JOB_COMPLETE   := SC_JOB_OLD[SC_NO].JOB_COMPLETE   ; // 작업완료
  SC_JOB[SC_NO].DATA_RESET     := SC_JOB_OLD[SC_NO].DATA_RESET     ; // 데이터초기화
  SC_JOB[SC_NO].MOVE_ON        := SC_JOB_OLD[SC_NO].MOVE_ON        ; // 기동지시
end;

//==============================================================================
// SC_ORDClear
//==============================================================================
procedure TfrmSCComm.SC_ORDClear(SC_NO: Integer);
var
  i : Integer ;
begin
  if SC_NO = 0 then
  begin
    for i := START_SCNO to End_SCNO do
    begin
      SC_ORDER[i].SCORD_NO     := '' ; // 작업번호
      SC_ORDER[i].SCORD_D100   := '' ; // 적재 열
      SC_ORDER[i].SCORD_D101   := '' ; // 적재 연
      SC_ORDER[i].SCORD_D102   := '' ; // 적재 단
      SC_ORDER[i].SCORD_D103   := '' ; // 하역 열
      SC_ORDER[i].SCORD_D104   := '' ; // 하역 연
      SC_ORDER[i].SCORD_D105   := '' ; // 하역 단
      SC_ORDER[i].SCORD_D106   := '' ; // 예비
      SC_ORDER[i].SCORD_D107   := '' ; // 예비
      SC_ORDER[i].SCORD_D108   := '' ; // 예비
      SC_ORDER[i].SCORD_D109   := '' ; // 예비
      SC_ORDER[i].SCORD_D110   := '' ; // 기동지시 and Data Reset
      SC_ORDER[i].SCORD_ST     := '' ; // 상태
      SC_ORDER[i].SCORD_DT     := '' ; // 지시 시간
    end;
  end else
  begin
    SC_ORDER[SC_NO].SCORD_NO     := '' ; // 작업번호
    SC_ORDER[SC_NO].SCORD_D100   := '' ; // 적재 열
    SC_ORDER[SC_NO].SCORD_D101   := '' ; // 적재 연
    SC_ORDER[SC_NO].SCORD_D102   := '' ; // 적재 단
    SC_ORDER[SC_NO].SCORD_D103   := '' ; // 하역 열
    SC_ORDER[SC_NO].SCORD_D104   := '' ; // 하역 연
    SC_ORDER[SC_NO].SCORD_D105   := '' ; // 하역 단
    SC_ORDER[SC_NO].SCORD_D106   := '' ; // 예비
    SC_ORDER[SC_NO].SCORD_D107   := '' ; // 예비
    SC_ORDER[SC_NO].SCORD_D108   := '' ; // 예비
    SC_ORDER[SC_NO].SCORD_D109   := '' ; // 예비
    SC_ORDER[SC_NO].SCORD_D110   := '' ; // 기동지시 and Data Reset
    SC_ORDER[SC_NO].SCORD_ST     := '' ; // 상태
    SC_ORDER[SC_NO].SCORD_DT     := '' ; // 지시 시간
  end;
end;



{******************************************************************************}
{*                         Log 처리 관련 함수                                 *}
{******************************************************************************}

//==============================================================================
// DisplayLog : Log Display & Save
//==============================================================================
procedure TfrmSCComm.DisplayLog(SC_NO:Integer;Msg, SR_Type: String; Len: Integer);
var
  StrLog : String ;
begin
  if CommLog.Lines.Count > 200 then CommLog.Lines.Clear;

  if      SR_TYPE = 'S' then // Send Log
       StrLog := FormatDatetime('HH:NN:SS', now) +
                 ' WRTE >> ['+ Msg + ' ]'
  else if SR_TYPE = 'R' then // Receive Log
       StrLog := FormatDatetime('HH:NN:SS', now) +
                 ' READ << ['+ Msg + ' ]'
  else if SR_TYPE = 'N' then // Normal Information
       StrLog := FormatDatetime('HH:NN:SS', now) +
                 ' INFO || ['+ Msg + ' ]'
  else if SR_TYPE = 'E' then // Error Log
       StrLog := FormatDatetime('HH:NN:SS', now) +
                 ' ERRR || ['+ Msg + ' ]' ;

  CommLog.Lines.Add(StrLog) ;
  if ckLog1.Checked then LogWRITE(LogFileName + IntToStr(SC_NO)+'.Log', StrLog);
end;

//==============================================================================
// ErrorLogWRITE : Error Log Write
//==============================================================================
procedure TfrmSCComm.ErrorLogWRITE(WRITEStr: String);
var
  FileName : String ;
begin
  if LogWRITEFlag then
  begin
    FileName := '.\Log\SCError_' + FormatDatetime('YYYYMMDD', Now) + '.log';
    LogWRITE(FileName,WRITEStr);
  end;
end;

{******************************************************************************}
{*                         작업 처리 관련 함수                                *}
{******************************************************************************}

//==============================================================================
// SCNowStatusUpdate -> SC 프로그램 현재 Status Update
//==============================================================================
function TfrmSCComm.SCNowStatusUpdate(SC_NO:Integer; Status: String): Boolean;
var
  StrSQL : String ;
  ExecNo : Integer;
begin
  Result := False;
  StrSQL := ' UPDATE TC_SCSETINFO ' +
            '    SET SC_STATUS  = ''' + Status + ''' ' +
            '  WHERE SC_NO = ''' + IntToStr(SC_NO) + ''' ' ;
  try
    with qryUpdate do
    begin
      Close ;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo   := ExecSQL ;
      Result   := Boolean( ExecNo > 0 ) ;
      Close ;
    end;
  except
    on E:Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function SCNowStatusUpdate SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// SCNowCycleUpdate -> SC 프로그램 현재 Cycle Update
//==============================================================================
function TfrmSCComm.SCNowCycleUpdate(SC_NO: Integer; Cycle: String): Boolean;
var
  StrSQL : String ;
  ExecNo : Integer;
begin
  Result := False;
  StrSQL := ' UPDATE TC_SCSETINFO ' +
            '    SET SC_CYCLE  = ''' + Cycle + ''' ' +
            '  WHERE SC_NO = ''' + IntToStr(SC_NO) + ''' ' ;
  try
    with qryUpdate do
    begin
      Close ;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo   := ExecSQL ;
      Result   := Boolean( ExecNo > 0 ) ;
      Close ;
    end;
  except
    on E:Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function SCNowCycleUpdate SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnGetSCSetInfo : 설비 명령 관련 데이터 반환
//==============================================================================
function TfrmSCComm.fnGetSCSetInfo(SC_NO: Integer; GetField: String): Boolean;
var
  StrSQL : String ;
begin
  Result := False ;
  StrSQL := ' SELECT ' + GetField + ' AS DATA ' +
            '   FROM TC_SCSETINFO ' +
            '  WHERE SC_NO = ' + IntToStr(SC_No)  ;

  try
    with qrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;

      if not ( Bof and Eof) then
      begin
        Result := Boolean( FieldByName('Data').AsString = '1' ) ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qrySearch.Close;
      ErrorLogWRITE( 'Function fnGetSCSetInfo SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnGetSCSetLugg : 설비 명령 관련 데이터 반환
//==============================================================================
function TfrmSCComm.fnGetSCSetLugg(SC_NO: Integer; GetField: String): String;
var
  StrSQL : String ;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + GetField + ' AS DATA ' +
            '   FROM TC_SCSETINFO ' +
            '  WHERE SC_NO = ' + IntToStr(SC_No)  ;

  try
    with qrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;

      if not ( Bof and Eof) then
      begin
        Result := Trim(FieldByName('Data').AsString);
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qrySearch.Close;
      ErrorLogWRITE( 'Function fnGetSCSetInfo SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSetSCSetInfo : 설비 명령 관련 데이터 저장
//==============================================================================
function TfrmSCComm.fnSetSCSetInfo(SC_NO: Integer; SetField, SetValue: String): Boolean;
var
  StrSQL : String ;
  ExecNo : Integer;
begin
  Result := False;
  StrSQL := ' UPDATE TC_SCSETINFO ' +
            '    SET ' + SetField + ' = ''' + SetValue + '''  ' +
            '  WHERE SC_NO = '    + IntToStr(SC_No)  ;

  try
    with qrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo   := ExecSQL ;
      Result   := Boolean( ExecNo > 0 ) ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qrySearch.Close;
      ErrorLogWRITE( 'Function fnSetSCSetInfo SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' + 'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSetSCSetInfo_Clear : WMS -> SC 작업 요청 비트 초기화
//==============================================================================
function TfrmSCComm.fnSetSCSetInfo_Clear(SC_NO:Integer): Boolean ;
begin
  if fnGetSCSetInfo(SC_No, 'JOB_RETRY'   ) then fnSetSCSetInfo(SC_No, 'JOB_RETRY'   , '0') ;  // [재기동 요청]
  if fnGetSCSetInfo(SC_No, 'JOB_COMPLETE') then fnSetSCSetInfo(SC_No, 'JOB_COMPLETE', '0') ;  // [작업완료 요청]
  if fnGetSCSetInfo(SC_No, 'DATA_RESET'  ) then fnSetSCSetInfo(SC_No, 'DATA_RESET'  , '0') ;  // [데이터초기화 요청]
  if fnGetSCSetInfo(SC_No, 'MOVE_ON'     ) then fnSetSCSetInfo(SC_No, 'MOVE_ON'     , '0') ;  // [기동지시 요청]
end;

//==============================================================================
// fnSetSCSetInfo_Clear2 : WMS -> SC 작업 요청 비트 초기화
//==============================================================================
function TfrmSCComm.fnSetSCSetInfo_Clear2(SC_NO:Integer): Boolean ;
begin
  if fnGetSCSetInfo(SC_No, 'SC_WMS_COM')        then fnSetSCSetInfo(SC_No, 'SC_WMS_COM', '0') ;  // 모니터링 작업완료 Off
  if fnGetSCSetInfo(SC_No, 'SC_WMS_CAN')        then fnSetSCSetInfo(SC_No, 'SC_WMS_CAN', '0') ;  // 모니터링 작업취소 Off
  if fnGetSCSetLugg(SC_No, 'SC_LUGG') <> '0000' then fnSetSCSetInfo(SC_No, 'SC_LUGG', '0000') ;  // 모니터링 작업완료&취소 작업번호
end;

//==============================================================================
// fnGetSCStatus : 설비 상태 반환(영문)
//==============================================================================
function TfrmSCComm.fnGetSCStatus(src: TScStatus): String;
begin
  case Src of
    START       : Result := 'START' ;
    STANDBY     : Result := 'STANDBY' ;
    READY       : Result := 'READY' ;

    DATA1       : Result := 'DATA1' ;
    ORDER1      : Result := 'ORDER1' ;
    RESET1      : Result := 'RESET1' ;
    ERR1        : Result := 'ERR1' ;

    DATA2       : Result := 'DATA2' ;
    ORDER2      : Result := 'ORDER2' ;
    RESET2      : Result := 'RESET2' ;
    ERR2        : Result := 'ERR2' ;

    RETRY_REQ   : Result := 'RETRY_REQ' ;
    CANCEL_REQ  : Result := 'CANCEL_REQ' ;
    DATAERR     : Result := 'DATAERR' ;
    else Result := '' ;
  end;
end;

//==============================================================================
// fnGetSCStatus : 설비 상태 반환(한글)
//==============================================================================
function TfrmSCComm.fnGetSCStatus2(src: TScStatus): String;
begin
  case Src of
    START       : Result := '최초시작' ;
    STANDBY     : Result := '상태체크' ;
    READY       : Result := '상태체크&작업검색' ;

    DATA1       : Result := '로딩 체크' ;
    ORDER1      : Result := '로딩 중' ;
    RESET1      : Result := '로딩 완료' ;
    ERR1        : Result := '로딩 에러' ;

    DATA2       : Result := '언로딩 체크' ;
    ORDER2      : Result := '언로딩 중' ;
    RESET2      : Result := '언로딩 완료' ;
    ERR2        : Result := '언로딩 에러' ;

    RETRY_REQ   : Result := '재기동' ;
    CANCEL_REQ  : Result := '작업삭제' ;
    DATAERR     : Result := '데이터에러' ;
    else Result := '' ;
  end;
end;

//==============================================================================
// fnGetSCCmdType : 작업 타입(Command ID) 반환
//==============================================================================
function TfrmSCComm.fnGetSCCmdType(IO_TYPE: String): String;
begin
  if      IO_TYPE='I' then Result := '0001' // I:입고
  else if IO_TYPE='O' then Result := '0002' // O:출고
  else if IO_TYPE='M' then Result := '0003' // M:Rack To Rack
  else if IO_TYPE='C' then Result := '0003' // C:SC Site to SC Site
end;


//==============================================================================
// fnGetCVOrderStr : TT_ORDER CVCURR 조건 설정
//==============================================================================
function TfrmSCComm.fnGetCVOrderStr(SC_NO: Integer; IO: String): String;
var
  CVCURR : String;
begin

  // 입고 스테이션 레디 조건에 따라 CVCURR 조건 설정
  if (IO = 'I') then
  begin
    if (SC_STATUS[SC_NO].D211[08] = '1') and
       (SC_STATUS[SC_NO].D211[10] = '0') and
       (SC_STATUS[SC_NO].D211[12] = '0') then
    begin
      CVCURR := ' And CVCURR In (''1'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '0') and
            (SC_STATUS[SC_NO].D211[10] = '1') and
            (SC_STATUS[SC_NO].D211[12] = '0') then
    begin
      CVCURR := ' And CVCURR In (''2'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '1') and
            (SC_STATUS[SC_NO].D211[10] = '1') and
            (SC_STATUS[SC_NO].D211[12] = '0') then
    begin
      CVCURR := ' And CVCURR In (''1'', ''2'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '0') and
            (SC_STATUS[SC_NO].D211[10] = '0') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And CVCURR In (''3'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '1') and
            (SC_STATUS[SC_NO].D211[10] = '0') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And CVCURR In (''1'', ''3'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '0') and
            (SC_STATUS[SC_NO].D211[10] = '1') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And CVCURR In (''2'', ''3'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '1') and
            (SC_STATUS[SC_NO].D211[10] = '1') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And CVCURR In (''1'', ''2'', ''3'')' ;
    end;
  end
  // 출고 스테이션 레디 조건에 따라 CVCURR 조건 설정
  else if (IO = 'O') then
  begin
    if (SC_STATUS[SC_NO].D211[09] = '1') and
       (SC_STATUS[SC_NO].D211[11] = '0') and
       (SC_STATUS[SC_NO].D211[13] = '0') then
    begin
      CVCURR := ' And CVCURR In (''1'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '0') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '0') then
    begin
      CVCURR := ' And CVCURR In (''2'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '1') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '0') then
    begin
      CVCURR := ' And CVCURR In (''1'', ''2'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '0') and
            (SC_STATUS[SC_NO].D211[11] = '0') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And CVCURR In (''3'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '1') and
            (SC_STATUS[SC_NO].D211[11] = '0') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And CVCURR In (''1'', ''3'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '0') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And CVCURR In (''2'', ''3'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '1') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And CVCURR In (''1'', ''2'', ''3'')' ;
    end;
  end;

  Result := CVCURR;
end;

//==============================================================================
// fnGetCVStatus : 입&출고대 상태(화물유무, 레디, 에러) 반환
//==============================================================================
function TfrmSCComm.fnGetCVStatus(SC_NO:Integer; BuffNo,GetField:String ): Boolean ;
var
  StrSQL : String ;
begin
  Result := False;
  StrSQL := ' SELECT ' + GetField + ' AS DATA ' +
            '   FROM VW_INOUT_CV_STATUS ' +
            '  WHERE CV_NO = ''' + BuffNo + ''' ';

  try
    with qrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;
      if not ( Bof and Eof) then
      begin
        Result := Boolean( FieldByName('DATA').AsString = '1' ) ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qrySearch.Close;
      ErrorLogWRITE( 'Function fnGetCVStatus SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnGetSCJOB : TT_ORDER 작업을 찾아 있으면 SC_JOB 구조체 넣고 True 반환
//==============================================================================
function TfrmSCComm.fnGetSCJOB(SC_NO:Integer; JFlag:TSCJobMode): Boolean;
var
  StrSQL, StrLog, JobLog, IO_Gubun, CVCURR, LoadBank, LoadBay : String ;
  TmpLugg : Array [START_SCNO..End_SCNO] of String ;
begin
  Result := False ;

  if JFlag = StoreIn then
  begin // 입고작업 검색
    IO_Gubun := 'I' ;
    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select TOP 1 * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''1''   ' +                                 // 입고 작업
              '    And NOWMC     = ''1''   ' +                                 // CV작업
              '    And NOWSTATUS = ''4''   ' +                                 // 완료 작업
              '    And DSTSITE   = ''' + FormatFloat('0000', SC_NO) + '''  ' + // 입고 호기
              CVCURR +
              '  Order By REG_TIME, LUGG ' ;
  end else
  if JFlag = StoreOut then
  begin // 출고작업 검색
    IO_Gubun := 'O' ;
    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select TOP 1 * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''2''   ' +                                 // 출고 작업
              '    And NOWMC     = ''2''   ' +                                 // SC작업
              '    And NOWSTATUS = ''1''   ' +                                 // 등록 작업
              '    And SRCSITE   = ''' + FormatFloat('0000', SC_NO) + ''' ' +  // 출고 호기
              CVCURR +
              '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
  end else
  if JFlag = RackToRack then
  begin // 랙이동작업 검색
    IO_Gubun := 'M' ;
    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select TOP 1 * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''7''   ' +                                 // 랙이동 작업
              '    And NOWMC     = ''2''   ' +                                 // SC작업
              '    And NOWSTATUS = ''1''   ' +                                 // 등록 작업
              '    And SRCSITE   = ''' + FormatFloat('0000', SC_NO) + ''' ' +  // 출고 호기
              CVCURR +
              '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
  end;


  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not (Bof and Eof) then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG := FormatFloat('0000', FieldByName('LUGG').AsInteger); // 작업 번호
        SC_JOB[SC_NO].ID_REGTIME := FieldByName('REG_TIME').AsString ;                  // 작업 생성 시간
        SC_JOB[SC_NO].ID_ORDDATE := Copy(SC_JOB[SC_NO].ID_REGTIME, 1, 8) ;              // 작업 생성 일자
        SC_JOB[SC_NO].ID_ORDTIME := Copy(SC_JOB[SC_NO].ID_REGTIME, 9, 6) ;              // 작업 생성 일시
        SC_JOB[SC_NO].IO_TYPE    := IO_Gubun ;                                          // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
        SC_JOB[SC_NO].ITM_CD     := UpperCase(Trim(FieldByName('ITM_CD').AsString)) ;

        SC_JOB[SC_NO].SC_STEP := 'L'   ;   // 작업 단계 (L:Loading, U:UnLoading)

        if JFlag = StoreIn then
        begin // 입고작업
          SC_JOB[SC_NO].LOAD_BANK     := '0000' ;                                  // 적재 열(0000)
          SC_JOB[SC_NO].LOAD_BAY      := '0000' ;                                  // 적재 연(0000)
          SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // 적재 단(0001) 입고스테이션 (0001 ~ 0003)
          SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // 하역 열(0001~0002)
          SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // 하역 연(0001~0011)
          SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // 하역 단(0001~0003)


          JobLog := '입고작업' +
                    ' | 작업번호-' + SC_JOB[SC_NO].ID_ORDLUGG +
                    ' | 적재위치-' + Copy(SC_JOB[SC_NO].LOAD_LEVEL,4,1)   +
                    ' | 하역위치-' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)  +
                    '-'            + Copy(SC_JOB[SC_NO].UNLOAD_BAY,3,2)   +
                    '-'            + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,3,2) ;
        end else
        if JFlag = StoreOut then
        begin // 출고작업
          SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // 적재 열(0001~0002)
          SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // 적재 연(0001~0011)
          SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // 적재 단(0001~0003)
          SC_JOB[SC_NO].UNLOAD_BANK   := '0000' ;                                  // 하역 열(0000
          SC_JOB[SC_NO].UNLOAD_BAY    := '0000' ;                                  // 하역 연(0000)
          SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // 하역 단(0001) 출고스테이션 (0001 ~ 0003)


          JobLog := '출고작업'   +
                    ' | 작업번호-' + SC_JOB[SC_NO].ID_ORDLUGG +
                    ' | 적재위치-' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +
                    ' | 하역위치-' + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,4,1)  ;
        end else
        if JFlag = RackToRack then
        begin
          SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // 적재 열(0001~0002)
          SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // 적재 연(0001~0011)
          SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // 적재 단(0001~0003)
          SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // 하역 열(0000
          SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // 하역 연(0000)
          SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // 하역 단(0001) 출고스테이션 (0001 ~ 0003)

          JobLog := '랙이동작업'   +
                    ' | 작업번호-' + SC_JOB[SC_NO].ID_ORDLUGG +
                    ' | 적재위치-' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +
                    ' | 하역위치-' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)  +
                    '-'            + Copy(SC_JOB[SC_NO].UNLOAD_BAY,3,2)   +
                    '-'            + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,3,2) ;
        end;

        if fnSCIO_Insert(SC_NO) then
        begin
          StrLog := ' COMD SC'+IntToStr(SC_No)+
                    ' | Start Job - Lugg [' + SC_JOB[SC_No].ID_ORDLUGG + ']' ;
          DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;


          StrLog := ' COMD SC'+IntToStr(SC_No)+
                    ' | Begining Proc Step[1]' +
                    ' | SCIO INSERT Success' +
                    ' | ORD_IDX- ' + SC_JOB[SC_No].ID_ORDLUGG +
                    ' | ORD_DATE- '+ SC_JOB[SC_No].ID_ORDDATE +
                    ' | ORD_TIME- '+ SC_JOB[SC_No].ID_ORDTIME ;

          ListBoxDisplay( ListBoxOrder, JobLog );
          DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
          Result := True ;
        end else
        begin
          StrLog := ' COMD SC'+IntToStr(SC_No)+
                    ' | Begining Proc Step[1]' +
                    ' | SCIO INSERT Fail' +
                    ' | ORD_IDX- ' + SC_JOB[SC_No].ID_ORDLUGG +
                    ' | ORD_DATE- '+ SC_JOB[SC_No].ID_ORDDATE +
                    ' | ORD_TIME- '+ SC_JOB[SC_No].ID_ORDTIME ;
          DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
          SC_JOBClear(SC_NO) ;
        end;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      ErrorLogWRITE( 'Function fnGetSCJOB SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' +
                     'ORD_LUGG [' + SC_JOB[SC_NO].ID_ORDLUGG + '], ' +
                     'ORD_DATE [' + SC_JOB[SC_NO].ID_ORDDATE + '], ' +
                     'ORD_TIME [' + SC_JOB[SC_NO].ID_ORDTIME + '], ' +
                     'SQL [' + StrSQL + ']' );
      qryInfo.Close ;
    end;
  end;
end;

//==============================================================================
// fnChkSCJOB : Order Check 해서 위치가 변경되었으면 SC_JOB 및 SCIO 값 변경
//==============================================================================
function TfrmSCComm.fnChkSCJOB(SC_NO: Integer): Boolean;
var
  StrSQL, JobD, StrLog, JobLog : String ;
  POS_Change : Boolean ;
  ExecNo : integer ;
begin
  // JOBD      -> 지시 타입 ( 1: 입고, 2: 출고, 3: 긴급입고, 4: 긴급출고, 5: Site To SC To Site, 6: Site To Site, 7: Rack To Rack, 8: SC Site to SC Site )
  // NOWMC     -> 현재 설비 ( 1: CV, 2: SCLoading, 3: SCUnloading )
  // NOWSTATUS -> 지시 상태 ( 0: Claer, 1: 등록,  2: 지시, 3: 진행중, 4: 완료 )
  // JOBSTATUS -> 완료 상태 ( 0: Claer, 1: 등록,  2: 지시, 3: 진행중, 4: 완료 )

  Result := False;
  StrSQL := ' SELECT * FROM TT_ORDER ' +
            '  WHERE LUGG     = ''' + SC_JOB[SC_NO].ID_ORDLUGG + ''' ' +
            '    AND REG_TIME = ''' + SC_JOB[SC_NO].ID_REGTIME + ''' ' ;

  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not (Bof and Eof) then
      begin
        POS_Change := False ;
        JobD := FieldByName('JobD').AsString ;  // 작업 종류
        if JobD = '1' then
        begin // 입고작업
          if (SC_JOB[SC_NO].UNLOAD_BANK  <> Trim(FieldByName('DSTAISLE').AsString)) OR   // 하역 열
             (SC_JOB[SC_NO].UNLOAD_BAY   <> Trim(FieldByName('DSTBAY'  ).AsString)) OR   // 하역 연
             (SC_JOB[SC_NO].UNLOAD_LEVEL <> Trim(FieldByName('DSTLEVEL').AsString)) then // 하역 단
          begin
            POS_Change := True ;

            JobLog := '입고위치 변경' +
                      ' | 작업번호- '  + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | 이전 하역위치- '  + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)    +  // 현재 하역 열
                      '-'                   + Copy(SC_JOB[SC_NO].UNLOAD_BAY,3,2)     +  // 현재 하역 연
                      '-'                   + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,3,2)   + #13#10 +  // 현재 하역 단
                      ' ->'                 +
                      ' 변경 하역위치- '    + Copy(Trim(FieldByName('DSTAISLE').AsString),4,1) + // 변경 하역 열
                      '-'                   + Copy(Trim(FieldByName('DSTBAY'  ).AsString),3,2) + // 변경 하역 연
                      '-'                   + Copy(Trim(FieldByName('DSTLEVEL').AsString),3,2) ; // 변경 하역 단

            SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // 하역 열
            SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // 하역 연
            SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // 하역 단
          end;
        end else
        if JobD = '2' then
        begin // 출고작업
          if (SC_JOB[SC_NO].LOAD_BANK   <> Trim(FieldByName('SRCAISLE').AsString)) OR    // 적재 열
             (SC_JOB[SC_NO].LOAD_BAY    <> Trim(FieldByName('SRCBAY'  ).AsString)) OR    // 적재 연
             (SC_JOB[SC_NO].LOAD_LEVEL  <> Trim(FieldByName('SRCLEVEL').AsString)) then  // 적재 단
          begin
            POS_Change := True ;

            JobLog := ' Pos Change' +
                      ' | LUGG- ' + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | TYPE- ' + 'StoreOut' +
                      ' | LOAD- ' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +  // 현재 적재 열
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +  // 현재 적재 연
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +  // 현재 적재 단
                      ' ->'       +
                      ' Change LOAD- ' + Copy(Trim(FieldByName('SRCAISLE').AsString),4,1) + // 변경 적재 열
                      '-'              + Copy(Trim(FieldByName('SRCBAY'  ).AsString),3,2) + // 변경 적재 연
                      '-'              + Copy(Trim(FieldByName('SRCLEVEL').AsString),3,2) ; // 변경 적재 단

            SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // 적재 열
            SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // 적재 연
            SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // 적재 단
          end;
        end else
        if JobD = '7' then
        begin // Rack To Rack
          if (SC_JOB[SC_NO].LOAD_BANK    <> Trim(FieldByName('SRCAISLE').AsString)) OR    // 적재 열
             (SC_JOB[SC_NO].LOAD_BAY     <> Trim(FieldByName('SRCBAY'  ).AsString)) OR    // 적재 연
             (SC_JOB[SC_NO].LOAD_LEVEL   <> Trim(FieldByName('SRCLEVEL').AsString)) OR    // 적재 단
             (SC_JOB[SC_NO].UNLOAD_BANK  <> Trim(FieldByName('DSTAISLE').AsString)) OR    // 하역 열
             (SC_JOB[SC_NO].UNLOAD_BAY   <> Trim(FieldByName('DSTBAY'  ).AsString)) OR    // 하역 연
             (SC_JOB[SC_NO].UNLOAD_LEVEL <> Trim(FieldByName('DSTLEVEL').AsString)) then  // 하역 단
          begin
            POS_Change := True ;

            JobLog := ' Pos Change' +
                      ' | LUGG- ' + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | TYPE- ' + 'RackToRack' +
                      ' | LOAD- ' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +  // 현재 적재 열
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +  // 현재 적재 연
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +  // 현재 적재 단
                      ' ->'       +
                      ' Change LOAD- ' + Copy(Trim(FieldByName('SRCAISLE').AsString),4,1) + // 변경 적재 열
                      '-'              + Copy(Trim(FieldByName('SRCBAY'  ).AsString),3,2) + // 변경 적재 연
                      '-'              + Copy( Trim(FieldByName('SRCLEVEL').AsString),3,2)+ // 변경 적재 단
                      ' | UNLOAD- ' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)    +  // 현재 하역 열
                      '-'           + Copy(SC_JOB[SC_NO].UNLOAD_BAY,3,2)     +  // 현재 하역 연
                      '-'           + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,3,2)   +  // 현재 하역 단
                      ' ->'         +
                      ' Change UNLOAD- ' + Copy(Trim(FieldByName('DSTAISLE').AsString),4,1) + // 변경 하역 열
                      '-'                + Copy(Trim(FieldByName('DSTBAY'  ).AsString),3,2) + // 변경 하역 연
                      '-'                + Copy(Trim(FieldByName('DSTLEVEL').AsString),3,2) ; // 변경 하역 단

            SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // 적재(열)
            SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // 적재(연)
            SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // 적재(단)
            SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // 하역(열)
            SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // 하역(연)
            SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // 하역(단)
          end;
        end else
        if JobD = '8' then
        begin // Cv To Cv
          if (SC_JOB[SC_NO].LOAD_BANK    <> Trim(FieldByName('SRCAISLE').AsString)) OR    // 적재 열
             (SC_JOB[SC_NO].UNLOAD_BANK  <> Trim(FieldByName('DSTAISLE').AsString)) then  // 하역 열
          begin
            POS_Change := True ;

            JobLog := ' Pos Change' +
                      ' | LUGG- '   + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | TYPE- '   + 'CvToCv' +
                      ' | LOAD- '   + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)   +    // 현재 적재 열
                      ' ->'         +
                      ' Change LOAD- ' + Copy(Trim(FieldByName('SRCAISLE').AsString),4,1) +   // 변경 적재 열
                      ' | UNLOAD- ' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1) +  // 현재 하역 열
                      ' ->'         +
                      ' Change UNLOAD- ' + Copy(Trim(FieldByName('DSTAISLE').AsString),4,1) ; // 변경 하역 열

            SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // 적재 열
            SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // 하역 열
          end;
        end;

        if POS_Change then
        begin
          Close;
          SQL.Clear;
          StrSQL  := ' UPDATE TT_SCIO ' +
                     '    SET LOAD_BANK    = ''' + SC_JOB[SC_NO].LOAD_BANK    + ''' ' +
                     '      , LOAD_BAY     = ''' + SC_JOB[SC_NO].LOAD_BAY     + ''' ' +
                     '      , LOAD_LEVEL   = ''' + SC_JOB[SC_NO].LOAD_LEVEL   + ''' ' +
                     '      , UNLOAD_BANK  = ''' + SC_JOB[SC_NO].UNLOAD_BANK  + ''' ' +
                     '      , UNLOAD_BAY   = ''' + SC_JOB[SC_NO].UNLOAD_BAY   + ''' ' +
                     '      , UNLOAD_LEVEL = ''' + SC_JOB[SC_NO].UNLOAD_LEVEL + ''' ' +
                     '  Where ID_NO    = ''' + IntToStr(SC_NO) + ''' ' +
                     '    and ID_INDEX = ''' + SC_JOB[SC_NO].ID_ORDLUGG + ''' ' ;
          SQL.Text := StrSQL ;
          ExecNo := ExecSQL ;

          if ExecNo > 0 then
          begin
            StrLog := ' COMD SC'+IntToStr(SC_No)+ ' | SCIO Pos Change Update Success ' ;
            ListBoxDisplay( ListBoxOrder, JobLog );
            DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
          end else
          begin
            StrLog := ' COMD SC'+IntToStr(SC_No)+ ' | SCIO Pos Change Update Fail ' ;
            DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
          end;
        end else
        begin
          StrLog := ' COMD SC'+IntToStr(SC_No)+ ' | SCIO Pos None Change ' ;
          DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
        end;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryInfo.Close;
      ErrorLogWRITE( 'Function fnChkSCJOB SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

{******************************************************************************}
{*                         ORDER 테이블 관련 함수                             *}
{******************************************************************************}

//==============================================================================
// fnOrder_Value : ORDER 데이터 반환
//==============================================================================
function TfrmSCComm.fnOrder_Value(SC_No: Integer; FName : String): String;
var
  StrSQL : string;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + Fname + ' as DATA ' +
            '   FROM TT_ORDER    ' +
            '  WHERE LUGG      = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
            '    AND REG_TIME  = ''' + SC_JOB[SC_No].ID_REGTIME + ''' ' ;

  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear ;
      SQL.Text := StrSQL ;
      Open ;
      if not (Bof and Eof) then
      begin
        Result := FieldByName('Data').AsString ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnOrder_Value SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnOrder_Value : ORDER 데이터 1개 반환
//==============================================================================
function TfrmSCComm.fnOrder_Value(WhereStr: String; FName : String): String;
var
  StrSQL : string;
begin
  Result := '' ;
  StrSQL := ' SELECT TOP 1 ' + FName + ' as DATA ' +
            '   FROM TT_ORDER ' + WhereStr;

  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear ;
      SQL.Text := StrSQL ;
      Open ;
      if not (Bof and Eof) then
      begin
        Result := FieldByName('Data').AsString ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnOrder_Value WhereStr [' + WhereStr + ']' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnITEM_Value : TM_ITEM 데이터 반환
//==============================================================================
function TfrmSCComm.fnITEM_Value(SC_No: Integer; FName, FValue : String): String;
var
  StrSQL : string;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + Fname + ' as DATA ' +
            '   FROM TM_ITEM    ' +
            '  WHERE ITM_CD = ''' + FValue + ''' ' ;


  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear ;
      SQL.Text := StrSQL ;
      Open ;
      if not (Bof and Eof) then
      begin
        Result := FieldByName('Data').AsString ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnOrder_Value SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;



//==============================================================================
// fnOrder_Delete : 작업 완료후 ORDER 및 SCIO 삭제
//==============================================================================
function TfrmSCComm.fnOrder_Delete(SC_No:Integer): Boolean;
var
  StrLog, StrJob, ORDERSQL, SCIOSQL, STOCKSQL, UpdateSQL : string;
  ExecNo, SQL_Step : Integer;
begin
  Result := False ;
  ORDERSQL:=''; SCIOSQL:=''; STOCKSQL:='';

  if      SC_JOB[SC_No].IO_TYPE = 'I' then StrJob := 'Store In '
  else if SC_JOB[SC_No].IO_TYPE = 'O' then StrJob := 'Store Out '
  else if SC_JOB[SC_No].IO_TYPE = 'M' then StrJob := 'RackToRack';


  //----------------------------------------------------------------------------
  // 입고 완료 일때
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TT_Order Delete
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'I') then    // 입고 작업 완료
  begin
    // Step 1. TT_STOCK Update
    if fnStockUpdateAll(SC_No) then
    begin
      // Step 2. TT_SCIO Delete
      SCIOSQL   := ' DELETE FROM TT_SCIO ' +
                   '  WHERE ID_NO = ''' + IntToStr(SC_No) + ''' ' +
                   '    AND ID_INDEX = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
                   '    AND ID_DT    = ''' + SC_JOB[SC_NO].ID_REGTIME + ''' ' ;

      // Step 3. TT_Order Update
      ORDERSQL  := ' UPDATE TT_ORDER ' +
                   '    SET NOWSTATUS = ''4'' ' +
                   '      , JOBSTATUS = ''7'' ' +
                   '      , JOB_END   = ''1'' ' +
                   '  WHERE LUGG      = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
                   '    AND REG_TIME  = ''' + SC_JOB[SC_NO].ID_REGTIME + ''' ' ;
    end else Exit;

  end else
  //----------------------------------------------------------------------------
  // 출고 완료 일때
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TT_Order Update
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'O') then
  begin
    // Step 1. TT_STOCK Update
    if fnStockUpdateAll(SC_No) then
    begin
      // Step 2. TT_SCIO Delete
      SCIOSQL   := ' DELETE FROM TT_SCIO ' +
                   '  WHERE ID_NO = ''' + IntToStr(SC_No) + ''' ' +
                   '    AND ID_INDEX = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
                   '    AND ID_DT    = ''' + SC_JOB[SC_NO].ID_REGTIME + ''' ' ;

      // Step 3. TT_Order Update
      ORDERSQL  := ' UPDATE TT_ORDER ' +
                   '    SET NOWSTATUS = ''4'' ' +
                   '      , JOBSTATUS = ''7'' ' +
                   '      , JOB_END   = ''1'' ' +
                   '  WHERE LUGG      = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
                   '    AND REG_TIME  = ''' + SC_JOB[SC_NO].ID_REGTIME + ''' ' ;

    end else Exit;
  end;

  if SCIOSQL <> '' then
  begin
    try
      with qryStock do
      begin
        Close;
        SQL.Clear;

        if not MainDM.MainDB.InTransaction then
               MainDM.MainDB.BeginTrans ;

        SQL_Step := 1 ;
        SQL.Text := SCIOSQL ;
        ExecNo   := ExecSQL ;

        if ExecNo > 0 then // TT_SCIO 삭제 성공
        begin
          StrLog := ' COMD SC'+IntToStr(SC_No)+
                    ' | Complete Proc Step[2]' +
                    '| SCIO DELETE Success ' +
                    ' | JOB_TYPE- '+ StrJob +
                    ' | ID_INDEX- '+ SC_JOB[SC_No].ID_ORDLUGG +
                    ' | ID_DT- '   + SC_JOB[SC_NO].ID_REGTIME ;
          DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;

          SQL_Step := 2 ;
          SQL.Text := ORDERSQL ;
          ExecNo   := ExecSQL ;

          if ExecNo > 0 then // TT_ORDER 변경&삭제 성공
          begin
            MainDM.MainDB.CommitTrans ;

            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | Complete Proc Step[3]' +
                      '| ORDER UPDATE 성공 ' +
                      ' | JOB_TYPE- '+ StrJob +
                      ' | LUGG- '    + SC_JOB[SC_No].ID_ORDLUGG +
                      ' | REG_DATE- '+ SC_JOB[SC_NO].ID_REGTIME ;
            DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
            Result := True ;
          end else
          begin              // TT_ORDER 변경&삭제 실패
            MainDM.MainDB.RollbackTrans ;
            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | Complete Proc Step[3]' +
                      '| ORDER UPDATE 실패 ' +
                      ' | JOB_TYPE- '+ StrJob +
                      ' | LUGG- '    + SC_JOB[SC_No].ID_ORDLUGG +
                      ' | REG_DATE- '+ SC_JOB[SC_NO].ID_REGTIME ;
            DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
          end;
        end else
        begin
          MainDM.MainDB.RollbackTrans ;
          StrLog := ' COMD SC'+IntToStr(SC_No)+
                    ' | Complete Proc Step[2]' +
                    '| SCIO DELETE Fail   ' +
                    ' | JOB_TYPE- '+ StrJob +
                    ' | ID_INDEX- '+ SC_JOB[SC_No].ID_ORDLUGG +
                    ' | ID_DT- '   + SC_JOB[SC_NO].ID_REGTIME ;
          DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
        end;
        Close;
      end;
    except
      on E: Exception do
      begin
        qryStock.Close ;
        ErrorLogWRITE( 'Function fnOrder_Delete SC(' + IntToStr(SC_No) + ') ' +
                       'Error[' + E.Message + '], ' + 'SQL_STEP [' + IntToStr(SQL_Step) + ']' );
      end;
    end;
  end;
end;

//==============================================================================
// fnOrder_Update : TT_ORDER의 필드1 데이터1 업데이트
//==============================================================================
function TfrmSCComm.fnOrder_Update(JobNo, FName, FValue: String): Boolean;
var
  StrSQL, StrLog : string;
  ExecNo  : Integer;
begin
  Result := False ;
  StrSQL := ' UPDATE TT_ORDER ' +
            '    SET ' + FName + '= ''' + FValue + '''  ' +
            '  WHERE LUGG     = ''' + JobNo + ''' ';

  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then Result := True ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnOrder_Update JobNo(' + JobNo + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnOrder_Update : TT_ORDER의 필드1 데이터1 업데이트
//==============================================================================
function TfrmSCComm.fnOrder_Update(SC_No:Integer; FName, FValue:String): Boolean;
var
  StrSQL, StrLog : string;
  ExecNo  : Integer;
begin
  Result := False ;
  StrSQL := ' UPDATE TT_ORDER ' +
            '    SET ' + FName + '= ''' + FValue + '''  ' +
            '  WHERE LUGG     = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
            '    AND REG_TIME = ''' + SC_JOB[SC_No].ID_REGTIME + ''' ' ;

  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then Result := True ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnOrder_Update SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnOrder_Update : TT_ORDER의 필드2 데이터2 업데이트
//==============================================================================
function TfrmSCComm.fnOrder_Update(SC_No: Integer; FName1, FValue1, FName2, FValue2: String): Boolean;
var
  StrSQL, StrLog : string;
  ExecNo  : Integer;
begin
  Result := False ;
  if (Trim(FName2) = '') and (Trim(FValue2) = '') then
  begin
    StrSQL := ' UPDATE TT_ORDER ' +
              '    SET ' + FName1 + '= ''' + FValue1 + ''' ' +
              '  WHERE LUGG     = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
              '    AND REG_TIME = ''' + SC_JOB[SC_No].ID_REGTIME + ''' ' ;
  end else
  begin
    StrSQL := ' UPDATE TT_ORDER ' +
              '    SET ' + FName1 + '= ''' + FValue1 + ''' ' +
              '      , ' + FName2 + '= ''' + FValue2 + ''' ' +
              '  WHERE LUGG     = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
              '    AND REG_TIME = ''' + SC_JOB[SC_No].ID_REGTIME + ''' ' ;
  end;

  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then Result := True ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnOrder_Update2 SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnGetErrMsg : 에러내용 Get
//==============================================================================
function TfrmSCComm.fnGetErrMsg(SC_NO: integer; GetField,ErrCode: String): String;
var
  StrSQL : String ;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + GetField + ' AS MSG ' +
            '   FROM TM_ERROR ' +
            '  WHERE ERR_DEV  = ''SC'' ' +
            '    AND ERR_CODE = ''' + ErrCode + ''' ';

  try
    with qrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open ;

      if not ( Bof and Eof) then
      begin
        Result := FieldByName('MSG').AsString ;
      end;
      Close ;
    end;
  except
    qrySearch.Close;
  end;
end;

//==============================================================================
// fnSetMachError : 설비 에러 발생 시 TT_ORDER에 에러내용 Update
//==============================================================================
function TfrmSCComm.fnSetMachError(SC_NO:Integer; ErrorCode:String): Boolean;
var
  UdtSQL, StrLog, StrProc, Step : string;
  JobErrorT, JobErrorc, JobErrord : String ;
  ExecNo  : Integer;
  NowErrCode : String ;
begin
  Result := False;

  if ErrorCode = fnOrder_Value(SC_No, 'JOBERRORD') then Exit ; // 오더의 현재 에러코드와 등록 에러코드가 같으면 패스

  if StrToIntDef(ErrorCode, 0) = 0 then
  begin // 에러 해제
    Step      := '2';
    StrProc   := ' Error Clear ' ;
    JobErrorT := '0' ;       // 에러타입 0:없음, A:AGV, S:SC, C:CV, P:Pallet, R:RGV
    JobErrorc := '0' ;       // 0: 정상, 1: 에러
    JobErrord := ErrorCode ; // 에러 코드
  end else
  begin // 에러 발생
    Step      := '1';
    StrProc   := ' Error ' ;
    JobErrorT := 'S' ;       // 에러타입 0:없음, A:AGV, S:SC, C:CV, P:Pallet, R:RGV
    JobErrorc := '1' ;       // 0: 정상, 1: 에러
    JobErrord := ErrorCode ; // 에러 코드
  end;

  UdtSQL := ' UPDATE TT_ORDER ' +
            '    SET JOBERRORT = ''' + JobErrorT + ''' ' + // 에러타입 0:없음, A:AGV, S:SC, C:CV, P:Pallet, R:RGV
            '      , JOBERRORC = ''' + JobErrorc + ''' ' + // 0: 정상, 1: 에러
            '      , JOBERRORD = ''' + JobErrord + ''' ' + // 에러 코드
            '  WHERE LUGG      = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
            '    AND REG_TIME  = ''' + SC_JOB[SC_No].ID_REGTIME + ''' ' ;

  try
    with qryError do
    begin
      Close;
      SQL.Clear;
      SQL.Text := UdtSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | SC Error Proc        ' +
                  '| ORDER UPDATE Success' +
                  ' | ' + StrProc +
                  ' | Error Code- '     + JobErrord  +
                  ' | ORDER LUGG- '     + SC_JOB[SC_No].ID_ORDLUGG +
                  ' | ORDER REG_TIME- ' + SC_JOB[SC_No].ID_REGTIME ;
        DisplayLog(SC_No, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end else
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | SC Error Proc        ' +
                  '| ORDER UPDATE Fail   ' +
                  ' | ' + StrProc +
                  ' | Error Code- '     + JobErrord  +
                  ' | ORDER LUGG- '     + SC_JOB[SC_No].ID_ORDLUGG +
                  ' | ORDER REG_TIME- ' + SC_JOB[SC_No].ID_REGTIME ;
        DisplayLog(SC_No, StrLog, 'E', Length(StrLog)) ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryError.Close ;
      ErrorLogWRITE( 'Function fnSetMachError SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + UdtSQL + ']' );
    end;
  end;
end;

function TfrmSCComm.fnSetErrReport(SC_NO: Integer; ErrorCode: String): Boolean;
var
  StrSQL, ERR_NAME : String ;
  ExecNo : Integer ;
begin
  Result := False ;
  ERR_NAME := fnGetErrMsg(1,'Err_Name',ErrorCode) ;

  if ERR_NAME='' then Exit;

  StrSQL  := ' INSERT INTO TT_ERROR ' +
             '  ( ERR_DEV, ERR_DEVNO, ERR_CODE, ERR_NAME, ' +
             '    ERR_DESC, ERR_START, ERR_END, ERR_DY )  ' +
             ' VALUES ( ' +
             '''SC'', ' +                                     // 스태커
             '''' + IntToStr(Sc_No) + ''', ' +                // 스태커 번호
             '''' + ErrorCode + ''', ' +                      // 에러코드
             '''' + ERR_NAME + ''', ' +                       // 에러코드 내용
             ''''', ' +                                       // 설명
             'GETDATE(), ' +                                    // 에러 시작 시간
             ''''', ' +                                       // 에러 종료 시간
             '''' + FormatDateTime('YYYYMMDD',Now) + ''') ' ; // 에러 일자

  try
    with qryErrorRpt do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        Result := True ;
      end;
      Close ;
    end;
  except
    qryErrorRpt.Close ;
  end;
end;

//==============================================================================
// fnGetErrReport : 종료안된 해당 에러가 TT_ERROR에 있는지 체크
//==============================================================================
function TfrmSCComm.fnGetErrReport(SC_NO: Integer; ErrorCode: String): Boolean;
var
  StrSQL : String ;
begin
  Result := False;
  StrSQL := ' SELECT COUNT(*) as CNT  ' +
            '   FROM TT_ERROR         ' +
            '  WHERE ERR_DEV   = ''SC'' ' +
            '    AND ERR_DEVNO = ''' + IntToStr(SC_NO) + ''' ' +
            '    AND ERR_CODE  = ''' + ErrorCode + ''' ' +
            '    AND ERR_END is Null ' +
            '    AND ERR_DY    = ''' + FormatDateTime('YYYYMMDD',Now) + ''' ';
  try
    with qryErrorRpt do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof) then
      begin
        Result := Boolean( FieldByName('CNT').AsInteger > 0 ) ;
      end;
      Close ;
    end;
  except
    qryErrorRpt.Close;
  end;
end;

//==============================================================================
// fnGetErrReport : 종료안된 해당 에러가 TT_ERROR에 있는지 체크
//==============================================================================
function TfrmSCComm.fnGetErrReport(SC_NO: Integer): Boolean;
var
  StrSQL : String ;
begin
  Result := False;
  StrSQL := ' SELECT COUNT(*) as CNT  ' +
            '   FROM TT_ERROR         ' +
            '  WHERE ERR_DEV   = ''SC'' ' +
            '    AND ERR_DEVNO = ''' + IntToStr(SC_NO) + ''' ' +
            '    AND ERR_END is Null ' +
            '    AND ERR_DY    = ''' + FormatDateTime('YYYYMMDD',Now) + ''' ';
  try
    with qryErrorRpt do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof) then
      begin
        Result := Boolean( FieldByName('CNT').AsInteger > 0 ) ;
      end;
      Close ;
    end;
  except
    qryErrorRpt.Close;
  end;
end;

//==============================================================================
// fnReSetErrReport : TT_ERROR에 에러 종료시간 기록
//==============================================================================
function TfrmSCComm.fnReSetErrReport(SC_NO: Integer): Boolean;
var
  StrSQL : String ;
  ExecNo : Integer;
begin
  Result := False;
  StrSQL := ' UPDATE TT_ERROR ' +
            '    SET ERR_END  = GETDATE() ' +
            '  WHERE ERR_DEV   = ''SC'' ' +
            '    AND ERR_DEVNO = ''' + IntToStr(SC_NO) + ''' ' +
            '    AND ERR_END is Null ' +
            '    AND ERR_DY    = ''' + FormatDateTime('YYYYMMDD',Now) + ''' ';
  try
    with qryErrorRpt do
    begin
      Close ;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo   := ExecSQL ;
      Result   := Boolean( ExecNo > 0 ) ;
      Close ;
    end;
  except
    qryErrorRpt.Close ;
  end;

end;

{******************************************************************************}
{*                         SCIO 테이블 관련 함수                              *}
{******************************************************************************}

//==============================================================================
// fnSCIO_Exist : 해당 호기가 현재 작업지시 중인 건이 있는지 확인
//==============================================================================
function TfrmSCComm.fnSCIO_Exist(SC_NO: integer): Boolean;
var
  StrSQL : String ;
begin
  Result := False;
  StrSQL := ' SELECT COUNT(*) as CNT ' +
            '   FROM TT_SCIO         ' +
            '  WHERE ID_NO = ''' + IntToStr(SC_NO) + ''' ';

  try
    with qrySCIO do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof) then
      begin
        Result := Boolean( FieldByName('CNT').AsInteger > 0 ) ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qrySCIO.Close;
      ErrorLogWRITE( 'Function fnSCIO_Exist SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '] , ' +'SQL ['  + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSCIO_Insert : SC_JOB Data를 가지고 TT_SCIO Table에 Insert
//==============================================================================
function TfrmSCComm.fnSCIO_Insert(SC_No: Integer): Boolean;
var
  StrSQL, StrLog : String ;
  ExecNo : Integer ;
begin
  Result := False ;
  StrSQL  := ' INSERT INTO TT_SCIO ' +
             '  ( ID_NO, ID_DT, ID_DATE, ID_TIME, ' +
             '    ID_INDEX, IO_TYPE,                      ' +
             '    LOAD_BANK, LOAD_BAY, LOAD_LEVEL,        ' +
             '    UNLOAD_BANK, UNLOAD_BAY, UNLOAD_LEVEL,  ' +
             '    SC_STATUS, SC_STEP, CR_DATE )           ' +
             ' VALUES ( ' +
             '''' + IntToStr(Sc_No) + ''', ' +
             '''' + SC_JOB[SC_NO].ID_REGTIME   + ''', ' +
             '''' + SC_JOB[SC_No].ID_ORDDATE   + ''', ' +
             '''' + SC_JOB[SC_No].ID_ORDTIME   + ''', ' +
             '''' + SC_JOB[SC_No].ID_ORDLUGG   + ''', ' +
             '''' + SC_JOB[SC_No].IO_TYPE      + ''', ' +
             '''' + SC_JOB[SC_No].LOAD_BANK    + ''', ' +
             '''' + SC_JOB[SC_No].LOAD_BAY     + ''', ' +
             '''' + SC_JOB[SC_No].LOAD_LEVEL   + ''', ' +
             '''' + SC_JOB[SC_No].UNLOAD_BANK  + ''', ' +
             '''' + SC_JOB[SC_No].UNLOAD_BAY   + ''', ' +
             '''' + SC_JOB[SC_No].UNLOAD_LEVEL + ''', ' +
             '''지시대기'', ''L'', GETDATE() ) ' ;
  try
    with qrySCIO do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then Result := True ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qrySCIO.Close ;
      ErrorLogWRITE( 'Function fnSCIO_Insert SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSCIO_Update : TT_SCIO의 작업단계 업데이트 ( Loading -> UnLoading )
//==============================================================================
function TfrmSCComm.fnSCIO_Update(SC_No: Integer): Boolean;
var
  StrSQL, StrLog : String ;
  ExecNo : Integer ;
begin
  Result := False ;

  SC_STAT[SC_No]        := DATA2 ; // SC 상태 UnLoading 처리로 변경
  SC_JOB[SC_No].SC_STEP := 'U'   ; // 작업 단계 (L:Loading, U:UnLoading)

  StrSQL  := ' UPDATE TT_SCIO ' +
             '    SET SC_STATUS = ''지시대기'' ' +    // SC 상태
             '      , SC_STEP   = ''U'' ' +           // 작업 단계
             '  WHERE ID_NO    = ''' + IntToStr(SC_No) + ''' ' +
             '    AND ID_INDEX = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
             '    AND ID_DATE  = ''' + SC_JOB[SC_No].ID_ORDDATE + ''' ' +
             '    AND ID_TIME  = ''' + SC_JOB[SC_No].ID_ORDTIME + ''' ' ;

  try
    with qrySCIO do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL;
      if ExecNo > 0 then
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | Begining Proc Step[2]' +
                  '| SCIO UPDATE Success' +
                  ' | Loading -> UnLoading' ;
        DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end else
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | Begining Proc Step[2]' +
                  '| SCIO UPDATE Fail   ' +
                  ' | Loading -> UnLoading' ;
        DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
      end;
      Close;
    end;
  except
    on E: Exception do
    begin
      qrySCIO.Close ;
      ErrorLogWRITE( 'Function fnSCIO_Update SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSCIO_ReLoad : 작업이 검색 되면 데이터를 다시 SET
//==============================================================================
function TfrmSCComm.fnSCIO_ReLoad(SC_NO: integer): Boolean;
var
  StrSQL : String ;
begin
  Result := False ;
  StrSQL := ' SELECT SCIO.*, ORD.* ' +
            '   FROM TT_SCIO SCIO  ' +
            '      , TT_ORDER ORD  ' +
            '  WHERE SCIO.ID_NO = ''' + IntToStr(SC_NO) + ''' ' +
            '    AND TRIM(SCIO.ID_INDEX) = TRIM(ORD.LUGG)' +
            '    AND TRIM(SCIO.ID_DATE)  = SUBSTR(TRIM(ORD.REG_TIME),1,8)  ' +
            '    AND TRIM(SCIO.ID_TIME)  = SUBSTR(TRIM(ORD.REG_TIME),9,6)  ' ;
  try
    with qrySCIO do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof ) then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG   := FieldByName('ID_INDEX' ).AsString ;       // 작업 번호
        SC_JOB[SC_NO].ID_ORDDATE   := FieldByName('ID_DATE'  ).AsString ;       // 작업 생성 일자
        SC_JOB[SC_NO].ID_ORDTIME   := FieldByName('ID_TIME'  ).AsString ;       // 작업 생성 일시
        SC_JOB[SC_NO].ID_REGTIME   := SC_JOB[SC_NO].ID_ORDDATE +                // 작업 등록 시간 ( 작업 생성 일자 + 작업 생성 일시 )
                                      SC_JOB[SC_NO].ID_ORDTIME ;
        SC_JOB[SC_NO].IO_TYPE      := FieldByName('IO_TYPE'     ).AsString ;    // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )
        SC_JOB[SC_NO].LOAD_BANK    := FieldByName('LOAD_BANK'   ).AsString ;    // 적재 열
        SC_JOB[SC_NO].LOAD_BAY     := FieldByName('LOAD_BAY'    ).AsString ;    // 적재 연
        SC_JOB[SC_NO].LOAD_LEVEL   := FieldByName('LOAD_LEVEL'  ).AsString ;    // 적재 단
        SC_JOB[SC_NO].UNLOAD_BANK  := FieldByName('UNLOAD_BANK' ).AsString ;    // 하역 열
        SC_JOB[SC_NO].UNLOAD_BAY   := FieldByName('UNLOAD_BAY'  ).AsString ;    // 하역 연
        SC_JOB[SC_NO].UNLOAD_LEVEL := FieldByName('UNLOAD_LEVEL').AsString ;    // 하역 단
        SC_JOB[SC_NO].SC_STEP      := FieldByName('SC_STEP').AsString ;         // 작업 단계

        if      FieldByName('SC_STEP').AsString = 'L' then SC_STAT[SC_NO] := ORDER1
        else if FieldByName('SC_STEP').AsString = 'U' then SC_STAT[SC_NO] := ORDER2
        else SC_STAT[SC_NO] := READY  ;
        Result := True ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qrySCIO.Close ;
      ErrorLogWRITE( 'Function fnSCIO_ReLoad SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

{******************************************************************************}
{*                        STOCK 테이블 관련 함수                              *}
{******************************************************************************}

//==============================================================================
// fnStockInsert : STOCK 모든 데이터 Update
//==============================================================================
function TfrmSCComm.fnStockUpdateAll(SC_NO: Integer): Boolean;
var
  StrSQL, StrLog, CellStatus, TmpBank, TmpBay, TmpLevel, StrJob : String ;
  ExecNo : Integer ;
begin
  // 0 : 공셀,     1 : 실셀(공Box)  2 : 실셀(실Box)  3 : 금지셀
  // 4 : 입고예약  5 : 출고예약     6 : 이중입고     7 : 공출고
  Result := False ;
  StrSQL:=''; CellStatus:=''; TmpBank:=''; TmpBay:=''; TmpLevel:='';

  if   UpperCase(SC_JOB[SC_NO].ITM_CD)='EPLT' then CellStatus := '1'
  else                                             CellStatus := '2';

  if      SC_JOB[SC_No].IO_TYPE = 'I' then StrJob := 'Store In '
  else if SC_JOB[SC_No].IO_TYPE = 'O' then StrJob := 'Store Out '
  else if SC_JOB[SC_No].IO_TYPE = 'M' then StrJob := 'Rack To Rack '
  else if SC_JOB[SC_No].IO_TYPE = 'S' then StrJob := 'Station To Station ' ;

  //----------------------------------------------------------------------------
  // 입고 완료 일때
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TBL_LOTNO_INFO Update 4. TT_Order Delete
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'I') or    // 입고 작업 완료
     (SC_JOB[SC_No].IO_TYPE = 'M') then  // RackToRack 작업 완료
  begin
    StrSQL := ' Update TT_STOCK ' +
              '    Set ITM_CD       = ' + QuotedStr(UpperCase(SC_JOB[SC_NO].ITM_CD)) +
              '      , ITM_NAME     = ' + QuotedStr(fnITEM_Value(SC_No, 'ITM_NAME', UpperCase(SC_JOB[SC_NO].ITM_CD))) +
              '      , ITM_SPEC     = ' + QuotedStr(fnITEM_Value(SC_No, 'ITM_SPEC', UpperCase(SC_JOB[SC_NO].ITM_CD))) +
              '      , ITM_QTY      = 1' +
              '      , ID_STATUS    = ' + QuotedStr(CellStatus) +
              '      , STOCK_IN_DT = GETDATE()   ' +
              '      , ID_MEMO      = ' + QuotedStr(fnOrder_Value(SC_No,'ETC')) +
              '  Where ID_HOGI   = '   + QuotedStr(IntToStr(SC_NO)) +
              '    AND ID_BANK   = ''' + Copy(SC_JOB[SC_No].UNLOAD_BANK, 4, 1)  + ''' ' + // 하역 열
              '    AND ID_BAY    = ''' + Copy(SC_JOB[SC_No].UNLOAD_BAY, 3, 2)   + ''' ' + // 하역 연
              '    AND ID_LEVEL  = ''' + Copy(SC_JOB[SC_No].UNLOAD_LEVEL, 3, 2) + ''' ' ; // 하역 단

    TmpBank  := SC_JOB[SC_No].UNLOAD_BANK;
    TmpBay   := SC_JOB[SC_No].UNLOAD_BAY;
    TmpLevel := SC_JOB[SC_No].UNLOAD_LEVEL;
  end else
  //----------------------------------------------------------------------------
  // 출고 완료 일때
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TBL_LOTNO_INFO Update
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'O') then
  begin
    StrSQL := ' Update TT_STOCK ' +
              '    Set ITM_CD       = ''''  ' +
              '      , ITM_NAME     = ''''  ' +
              '      , ITM_SPEC     = ''''  ' +
              '      , ITM_QTY      = 0     ' +
              '      , ID_STATUS    = ''0'' ' +
              '      , ID_MEMO      = ''''  ' +
              '  Where ID_HOGI   = '   + QuotedStr(IntToStr(SC_NO)) +
              '    AND ID_BANK   = ''' + Copy(SC_JOB[SC_No].LOAD_BANK, 4, 1)  + ''' ' + // 하역 열
              '    AND ID_BAY    = ''' + Copy(SC_JOB[SC_No].LOAD_BAY, 3, 2)   + ''' ' + // 하역 연
              '    AND ID_LEVEL  = ''' + Copy(SC_JOB[SC_No].LOAD_LEVEL, 3, 2) + ''' ' ; // 하역 단

    TmpBank  := SC_JOB[SC_No].LOAD_BANK;
    TmpBay   := SC_JOB[SC_No].LOAD_BAY;
    TmpLevel := SC_JOB[SC_No].LOAD_LEVEL;
  end;

  if StrSQL<>'' then
  begin
    try
      with qryStock do
      begin
        Close;
        SQL.Clear;
        SQL.Text := StrSQL ;
        ExecNo := ExecSQL;
        if ExecNo > 0 then
        begin
          StrLog := ' COMD SC'+IntToStr(SC_No)+
                    ' | Complete Proc Step[1]' +
                    '| STOCK UPDATE Success' +
                    ' | JOB_TYPE- '+ StrJob +
                    ' | ORD_BANK-' + TmpBank  +
                    ' | ORD_BAY-'  + TmpBay   +
                    ' | ORD_LEVEL-'+ TmpLevel ;
          DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
          Result := True ;
        end else
        begin
          StrLog := ' COMD SC'+IntToStr(SC_No)+
                    ' | Complete Proc Step[1]' +
                    '| STOCK UPDATE Fail   ' +
                    ' | JOB_TYPE- '+ StrJob +
                    ' | ORD_BANK-' + TmpBank  +
                    ' | ORD_BAY-'  + TmpBay   +
                    ' | ORD_LEVEL-'+ TmpLevel ;
          DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
        end;
        Close;
      end;
    except
      on E: Exception do
      begin
        qryStock.Close ;
        ErrorLogWRITE( 'Function fnSCIO_Update SC(' + IntToStr(SC_No) + ') ' +
                       'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
      end;
    end;
  end;
end;


function TfrmSCComm.fnGetStockLoc(ItemCode : String): String;
var
  StrSQL : String;
begin
  try
    Result := '';
    with qryStock do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' Select WMS_HL.DBO.fn_GetItemLoc(:item) ID_CODE ' ;
      Parameters[0].Value := ItemCode ;
      SQL.Text := StrSQL ;
      Open ;

      if ( RecordCount = 0 ) or
         ( Copy(FieldByName('ID_CODE').AsString, 1, 2) <> 'OK' ) then
      begin
        Exit;
      end;
      Result := Copy(FieldByName('ID_CODE').AsString, 4, 1) +
                Copy(FieldByName('ID_CODE').AsString, 5, 1) +
                Copy(FieldByName('ID_CODE').AsString, 6, 2) +
                Copy(FieldByName('ID_CODE').AsString, 8, 2) ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnGetStockLoc(' + ItemCode + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnStockUpdate : STOCK 해당 데이터 Update
//==============================================================================
function TfrmSCComm.fnStockUpdate(Loc, FName, FValue: String): Boolean;
var
  StrSQL : string;
begin
  Result := False ;
  StrSQL := '';
  try
    with qryStock do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' UPDATE TT_STOCK ' +
                '    SET ' + FName + ' = ' + QuotedStr(FValue) +
                '  Where ID_CODE = ' + QuotedStr(Loc) ;
      SQL.Text := StrSQL ;
      ExecSQL ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Function fnStockUpdate Loc(' + Loc + '), FName(' + FName + ')' + 'FValue(' + FValue + ')' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnStockUpdate : STOCK 해당 데이터 Update
//==============================================================================
function TfrmSCComm.fnStockUpdate(SC_No: Integer; FName, FValue: String): Boolean;
var
  StrSQL : string;
begin
  Result := False ;
  StrSQL:='';

  //+++++++++++++
  // 작업삭제
  //+++++++++++++
  if FValue='9' then
  begin
    if (SC_JOB[SC_No].IO_TYPE = 'I') then
    begin // 입고 (공셀)
      FValue := '0';
    end else
    if (SC_JOB[SC_No].IO_TYPE = 'O') then
    begin // 출고 (파레트셀 or 실셀)
      if (SC_JOB[SC_No].ITM_CD='EPLT') then FValue := '1' else FValue := '2';
    end;
  end;

  if (SC_JOB[SC_No].IO_TYPE = 'I') then
  begin
    StrSQL := ' UPDATE TT_STOCK ' +
              '    SET ' + FName + '= ''' + FValue + '''  ' +
              '  WHERE ID_HOGI   = ''' + IntToStr(SC_No) + ''' ' +                      // 하역 호기
              '    AND ID_BANK   = ''' + COPY(SC_JOB[SC_No].UNLOAD_BANK,4,1)  + ''' ' + // 하역 열
              '    AND ID_BAY    = ''' + COPY(SC_JOB[SC_No].UNLOAD_BAY,3,2)   + ''' ' + // 하역 연
              '    AND ID_LEVEL  = ''' + COPY(SC_JOB[SC_No].UNLOAD_LEVEL,3,2) + ''' ' ; // 하역 단
  end else
  if (SC_JOB[SC_No].IO_TYPE = 'O') then
  begin
    StrSQL := ' UPDATE TT_STOCK ' +
              '    SET ' + FName + '= ''' + FValue + '''  ' +
              '  WHERE ID_HOGI   = ''' + IntToStr(SC_No) + ''' ' +                      // 적재 호기
              '    AND ID_BANK   = ''' + COPY(SC_JOB[SC_No].LOAD_BANK,4,1)  + ''' ' +   // 적재 열
              '    AND ID_BAY    = ''' + COPY(SC_JOB[SC_No].LOAD_BAY,3,2)   + ''' ' +   // 적재 연
              '    AND ID_LEVEL  = ''' + COPY(SC_JOB[SC_No].LOAD_LEVEL,3,2) + ''' ' ;   // 적재 단
  end;

  if StrSQL<>'' then
  begin
    try
      with qryStock do
      begin
        Close;
        SQL.Clear;
        SQL.Text := StrSQL ;
        ExecSQL ;
        Close ;
      end;
    except
      on E: Exception do
      begin
        qryUpdate.Close ;
        ErrorLogWRITE( 'Function fnOrder_Update1 SC(' + IntToStr(SC_No) + ') ' +
                       'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
      end;
    end;
  end;
end;


{******************************************************************************}
{*                      이중입고&공출고 시 처리 함수                          *}
{******************************************************************************}

//==============================================================================
// fnCellPosChange : 이중입고 & 공출고 발생 시 셀 위치 변경
//==============================================================================
function TfrmSCComm.fnCellPosChange(SC_NO: integer; Flag: String): Boolean;
var
  StrSQL, StrLog, NewPos, Zone : String ;
begin
  Result := False ;

  if Flag = '1' then // 이중입고
  begin
    StrSQL := ' Select WMS_HL.DBO.fn_GetFreeLoc(:type) as NewPos ';
  end else
  if Flag='2' then // 공출고 :::: 사용안함
  begin
    StrSQL := ' SELECT fn_GetItemLoc(' + IntToStr(SC_NO) +  ') as NewPos' +
              '   FROM DUAL ' ;
  end;

  try
    with qryPos do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof ) then
      begin                                                                // Return Value
        if Copy(UpperCase(FieldByName('NewPos').AsString),1,2)='OK' then   // OK:110101
        begin                                                              // OK:CELL_HOGI(1) + CELL_BANK(1) + CELL_BAY(2) + CELL_LEVEL(2)
          NewPos := Copy(FieldByName('NewPos').AsString,5,5) ;             // NewPos -> CELL_BANK(1) + CELL_BAY(2) + CELL_LEVEL(2)

          if Flag='1' then
          begin
            fnOrder_Update(SC_NO, 'DSTAISLE', FormatFloat('0000',StrToInt(Copy(NewPos,1,1)))) ;
            fnOrder_Update(SC_NO, 'DSTBAY'  , FormatFloat('0000',StrToInt(Copy(NewPos,2,2)))) ;
            fnOrder_Update(SC_NO, 'DSTLEVEL', FormatFloat('0000',StrToInt(Copy(NewPos,4,2)))) ;

            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | 이중입고 하역위치 변경 성공 ' +
                      ' | 하역위치- ' + SC_JOB[SC_NO].UNLOAD_BANK  +  // 현재 하역 열
                      '-'           + SC_JOB[SC_NO].UNLOAD_BAY     +  // 현재 하역 연
                      '-'           + SC_JOB[SC_NO].UNLOAD_LEVEL   +  // 현재 하역 단
                      ' -> '        +
                      ' | 변경위치- ' + FormatFloat('0000',StrToInt(Copy(NewPos,1,1))) + // 변경 하역 열
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,2,2))) + // 변경 하역 연
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,4,2))) ; // 변경 하역 단
          end else
          if Flag='2' then
          begin
            fnOrder_Update(SC_NO, 'SRCAISLE', FormatFloat('0000',StrToInt(Copy(NewPos,1,1)))) ;
            fnOrder_Update(SC_NO, 'SRCBAY'  , FormatFloat('0000',StrToInt(Copy(NewPos,2,2)))) ;
            fnOrder_Update(SC_NO, 'SRCLEVEL', FormatFloat('0000',StrToInt(Copy(NewPos,4,2)))) ;

            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | 공출고 적재위치 변경 성공 ' +
                      ' | 적재위치- ' + SC_JOB[SC_NO].LOAD_BANK  +  // 현재 적재 열
                      '-'           + SC_JOB[SC_NO].LOAD_BAY     +  // 현재 적재 연
                      '-'           + SC_JOB[SC_NO].LOAD_LEVEL   +  // 현재 적재 단
                      ' -> '        +
                      ' | 변경위치- ' + FormatFloat('0000',StrToInt(Copy(NewPos,1,1))) + // 변경 적재 열
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,2,2))) + // 변경 적재 연
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,4,2))) ; // 변경 적재 단

          end;
          DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
          Result := True ;
        end else
        begin
          if Flag='1' then
          begin
            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | 이중입고 하역위치 변경 실패 ' +
                      ' | 하역위치- ' + SC_JOB[SC_NO].UNLOAD_BANK    +  // 현재 하역 열
                      '-'           + SC_JOB[SC_NO].UNLOAD_BAY     +  // 현재 하역 연
                      '-'           + SC_JOB[SC_NO].UNLOAD_LEVEL   ;  // 현재 하역 단
                              end else
          if Flag='2' then
          begin
            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | 공출고 적재위치 변경 실패 ' +
                      ' | 적재위치- ' + SC_JOB[SC_NO].LOAD_BANK    +  // 현재 적재 열
                      '-'         + SC_JOB[SC_NO].LOAD_BAY     +  // 현재 적재 연
                      '-'         + SC_JOB[SC_NO].LOAD_LEVEL   ;  // 현재 적재 단
          end;
          DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
        end;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryPos.Close ;
      ErrorLogWRITE( 'Function fnCellPosChange SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnOrder_Cancel : 작업 취소 시 Order 삭제
//==============================================================================
function TfrmSCComm.fnOrder_Cancel(SC_No: Integer; LUGG, REG_TIME: String): Boolean;
var
  StrSQL, StrLog : String ;
  ExecNo : Integer ;
begin
  Result := False ;
  StrSQL := ' DELETE FROM TT_ORDER ' +
            '  WHERE LUGG     = ''' + LUGG + ''' ' +
            '    AND REG_TIME = ''' + REG_TIME + ''' ' ;
  try
    with QryDelete do
    begin
      Close ;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | 작업삭제 단계[1]   ' +
                  '| ORDER 삭제 성공' +
                  ' | ORD_IDX- ' + LUGG +
                  ' | ORD_DATE- '+ Copy(REG_TIME,1,8) +
                  ' | ORD_TIME- '+ Copy(REG_TIME,9,6) ;
        DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end else
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | 작업삭제 단계[1]   ' +
                  '| ORDER 삭제 실패' +
                  ' | ORD_IDX- ' + LUGG +
                  ' | ORD_DATE- '+ Copy(REG_TIME,1,8) +
                  ' | ORD_TIME- '+ Copy(REG_TIME,9,6) ;
        DisplayLog(SC_NO, StrLog, 'E', Length(StrLog)) ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      QryDelete.Close ;
      ErrorLogWRITE( 'Function fnOrder_Cancel SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSCIO_Delete : SCIO Delete
//==============================================================================
function TfrmSCComm.fnSCIO_Delete(SC_No: Integer): Boolean;
var
  StrSQL, StrLog : String ;
  ExecNo : Integer ;
begin
  Result := False ;

  StrSQL  := ' DELETE FROM TT_SCIO ' +
             '  WHERE ID_NO = ''' + IntToStr(SC_No) + ''' ' ;

  try
    with qrySCIO do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL;
      if ExecNo > 0 then
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | 작업삭제 단계[2]   ' +
                  '| SCIO 삭제 성공' ;
        DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end;
      Close;
    end;
  except
    on E: Exception do
    begin
      qrySCIO.Close ;
      ErrorLogWRITE( 'Function fnSCIO_Delete SC(' + IntToStr(SC_No) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// SetJobOrder [입고지시 데이터 저장]
//==============================================================================
function TfrmSCComm.SetJobOrder : Boolean;
var
  i : Integer;
begin
  try
    Result := False;

    if not MainDm.MainDB.InTransaction then
           MainDm.MainDB.BeginTrans;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text :=
      ' INSERT INTO TT_ORDER (                             ' + #13#10+
      '    REG_TIME, LUGG, JOBD,                           ' + #13#10 +
      '    SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,            ' + #13#10 +
      '    DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,            ' + #13#10 +
      '    NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,        ' + #13#10 +
      '    JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD,     ' + #13#10 +
      '    JOB_END, CVFR, CVTO, CVCURR,                    ' + #13#10 +
      '    ETC, EMG, ITM_CD, LINE_NO, UP_TIME              ' + #13#10 +
      '  ) VALUES (                                        ' + #13#10 +
      '    :REG_TIME, :LUGG, :JOBD,                        ' + #13#10 +
      '    :SRCSITE, :SRCAISLE, :SRCBAY, :SRCLEVEL,        ' + #13#10 +
      '    :DSTSITE, :DSTAISLE, :DSTBAY, :DSTLEVEL,        ' + #13#10 +
      '    :NOWMC, :JOBSTATUS, :NOWSTATUS, :BUFFSTATUS,    ' + #13#10 +
      '    :JOBREWORK, :JOBERRORT, :JOBERRORC, :JOBERRORD, ' + #13#10 +
      '    :JOB_END, :CVFR, :CVTO, :CVCURR,                ' + #13#10 +
      '    :ETC, :EMG, :ITM_CD, :LINE_NO, :UP_TIME         ' + #13#10 +
      ' )';


      i := 0;
      Parameters[i].Value := OrderData.REG_TIME;    Inc(i);
      Parameters[i].Value := OrderData.LUGG;        Inc(i);
      Parameters[i].Value := OrderData.JOBD;        Inc(i);
      Parameters[i].Value := OrderData.SRCSITE;     Inc(i);
      Parameters[i].Value := OrderData.SRCAISLE;    Inc(i);
      Parameters[i].Value := OrderData.SRCBAY;      Inc(i);
      Parameters[i].Value := OrderData.SRCLEVEL;    Inc(i);
      Parameters[i].Value := OrderData.DSTSITE;     Inc(i);
      Parameters[i].Value := OrderData.DSTAISLE;    Inc(i);
      Parameters[i].Value := OrderData.DSTBAY;      Inc(i);
      Parameters[i].Value := OrderData.DSTLEVEL;    Inc(i);
      Parameters[i].Value := OrderData.NOWMC;       Inc(i);
      Parameters[i].Value := OrderData.JOBSTATUS;   Inc(i);
      Parameters[i].Value := OrderData.NOWSTATUS;   Inc(i);
      Parameters[i].Value := OrderData.BUFFSTATUS;  Inc(i);
      Parameters[i].Value := OrderData.JOBREWORK;   Inc(i);
      Parameters[i].Value := OrderData.JOBERRORT;   Inc(i);
      Parameters[i].Value := OrderData.JOBERRORC;   Inc(i);
      Parameters[i].Value := OrderData.JOBERRORD;   Inc(i);
      Parameters[i].Value := OrderData.JOB_END;     Inc(i);
      Parameters[i].Value := OrderData.CVFR;        Inc(i);
      Parameters[i].Value := OrderData.CVTO;        Inc(i);
      Parameters[i].Value := OrderData.CVCURR;      Inc(i);
      Parameters[i].Value := OrderData.ETC;         Inc(i);
      Parameters[i].Value := OrderData.EMG;         Inc(i);
      Parameters[i].Value := OrderData.ITM_CD;      Inc(i);
      Parameters[i].Value := OrderData.LINE_NO;     Inc(i);
      Parameters[i].Value := OrderData.UP_TIME;     Inc(i);
      ExecSql;
      Close;
    end;
    Result := True;

    if MainDm.MainDB.InTransaction then
       MainDm.MainDB.CommitTrans;
  except
    on E : Exception do
    begin
      if MainDm.MainDB.InTransaction then
        MainDm.MainDB.RollbackTrans;
      if qryTemp.Active then qryTemp.Close;
        qryTemp.Close;
    end;
  end;
end;

//==============================================================================
// SetAcsResponse [ACS 응답 전송 데이터 저장]
//==============================================================================
function TfrmSCComm.SetAcsResponse(Line_No, In_Out : Integer; Status: String) : Boolean;
var
  i : Integer;
  StrSQL : String;
begin
  try
    Result := False;

    if not MainDm.MainDB.InTransaction then
           MainDm.MainDB.BeginTrans;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL :=  ' SELECT * ' +
                 '   FROM TC_ACS_COMM ' +
                 '  WHERE GUBN = ''SEND'' ' +
                 '    AND LINE_NO = ' + QuotedStr(IntToStr(Line_No)) +
                 '    AND IN_OUT  = ' + QuotedStr(IntToStr(In_Out)) ;

      SQL.Text := StrSQL;
      Open;
      if (Bof and Eof) then
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' INSERT INTO TC_ACS_COMM (                           ' + #13#10 +
                    '    GUBN, LINE_NO, IN_OUT, STATUS, PROCESS,          ' + #13#10 +
                    '    HEART_BEAT, LINE_NAME_SOURCE, LINE_NO_SOURCE     ' + #13#10 +
                    '    PORT_NO_SOURCE, LINE_NAME_DEST,                  ' + #13#10 +
                    '    LINE_NO_DEST, PORT_NO_DEST, MODEL_NO,            ' + #13#10 +
                    '    CALL_REQUEST, CALL_ANSWER, DOCKING_REQ_APPR,     ' + #13#10 +
                    '    DOCKING_COMPLETE, CRT_DT, UPD_DT,                ' + #13#10 +
                    '  ) VALUES (                                         ' + #13#10 +
                    '    :GUBN, :LINE_NO, :IN_OUT, :STATUS, :PROCESS      ' + #13#10 +
                    '    :HEART_BEAT, :LINE_NAME_SOURCE, :LINE_NO_SOURCE  ' + #13#10 +
                    '    :PORT_NO_SOURCE, :LINE_NAME_DEST,                ' + #13#10 +
                    '    :LINE_NO_DEST, :PORT_NO_DEST, :MODEL_NO,         ' + #13#10 +
                    '    :CALL_REQUEST, :CALL_ANSWER, :DOCKING_REQ_APPR,  ' + #13#10 +
                    '    :DOCKING_COMPLETE, GETDATE(), GETDATE(),         ' + #13#10 +
                    '  )';
        i := 0;
        Parameters[i].Value := 'SEND';                        Inc(i);
        Parameters[i].Value := IntToStr(LINE_NO);             Inc(i);
        Parameters[i].Value := IntToStr(In_Out);              Inc(i);
        Parameters[i].Value := Status;                        Inc(i);
        Parameters[i].Value := 'N';                           Inc(i);
        Parameters[i].Value := Tx_AcsData.Heart_Beat;         Inc(i);
        Parameters[i].Value := Tx_AcsData.Line_Name_Source;   Inc(i);
        Parameters[i].Value := Tx_AcsData.Line_No_Source;     Inc(i);
        Parameters[i].Value := Tx_AcsData.Port_No_Source;     Inc(i);
        Parameters[i].Value := Tx_AcsData.Line_Name_Dest;     Inc(i);
        Parameters[i].Value := Tx_AcsData.Line_No_Dest;       Inc(i);
        Parameters[i].Value := Tx_AcsData.Port_No_Dest;       Inc(i);
        Parameters[i].Value := Tx_AcsData.Model_No;           Inc(i);
        Parameters[i].Value := Tx_AcsData.Call_Request;       Inc(i);
        Parameters[i].Value := Tx_AcsData.Call_Answer;        Inc(i);
        Parameters[i].Value := Tx_AcsData.Docking_Approve;    Inc(i);
        Parameters[i].Value := Tx_AcsData.Docking_Complete;   Inc(i);
      end
      else
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' UPDATE TC_ACS_COMM ' +
                    '    SET STATUS           = ' + QuotedStr(Status) +
                    '      , PROCESS          = ''N''' +
                    '      , HEART_BEAT       = ' + QuotedStr(Tx_AcsData.Heart_Beat) +
                    '      , LINE_NAME_SOURCE = ' + QuotedStr(Tx_AcsData.Line_Name_Source) +
                    '      , LINE_NO_SOURCE   = ' + QuotedStr(Tx_AcsData.Line_No_Source) +
                    '      , PORT_NO_SOURCE   = ' + QuotedStr(Tx_AcsData.Port_No_Source) +
                    '      , LINE_NAME_DEST   = ' + QuotedStr(Tx_AcsData.Line_Name_Dest) +
                    '      , LINE_NO_DEST     = ' + QuotedStr(Tx_AcsData.Line_No_Dest) +
                    '      , PORT_NO_DEST     = ' + QuotedStr(Tx_AcsData.Port_No_Dest) +
                    '      , MODEL_NO         = ' + QuotedStr(Tx_AcsData.Model_No) +
                    '      , CALL_REQUEST     = ' + QuotedStr(Tx_AcsData.Call_Request) +
                    '      , CALL_ANSWER      = ' + QuotedStr(Tx_AcsData.Call_Answer) +
                    '      , DOCKING_REQ_APPR = ' + QuotedStr(Tx_AcsData.Docking_Approve) +
                    '      , DOCKING_COMPLETE = ' + QuotedStr(Tx_AcsData.Docking_Complete) +
                    '      , UPD_DT           = GETDATE() ' +
                    '  WHERE GUBN = ''SEND'' ' +
                    '    AND LINE_NO = ' + QuotedStr(IntToStr(Line_No)) +
                    '    AND IN_OUT  = ' + QuotedStr(IntToStr(In_Out));
      end;
      ExecSql;
      Close;
    end;
    Result := True;

    if MainDm.MainDB.InTransaction then
       MainDm.MainDB.CommitTrans;
  except
    on E : Exception do
    begin
      if MainDm.MainDB.InTransaction then
        MainDm.MainDB.RollbackTrans;
      if qryTemp.Active then qryTemp.Close;
        qryTemp.Close;
    end;
  end;
end;

//==============================================================================
// fnACS_Update
//==============================================================================
procedure TfrmSCComm.fnACS_Update(Line_No, In_Out: Integer; Gubn, FName, FValue: String);
var
  StrSQL : string;
  ExecNo : Integer;
begin
  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' UPDATE TC_ACS_COMM ' +
                '    SET ' + FName + ' = ' + QuotedStr(FValue) +
                '  WHERE LINE_NO = ' + QuotedStr(IntToStr(Line_No)) +
                '    AND IN_OUT  = ' + QuotedStr(IntToStr(In_Out)) +
                '    AND GUBN = ' + QuotedStr(Gubn);
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Procedure fnACS_Update Line_No(' + IntToStr(Line_No) + ') ' + 'In_Out(' + IntToStr(In_Out) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// GetJobNo [작업번호 생성]
//==============================================================================
function TfrmSCComm.GetJobNo : Integer;
var
  StrSQL : String;
  returnValue : String;
begin
  try
    Result := 0;
    with PD_GET_JOBNO do
    begin
      Close;
      ProcedureName := 'PD_GET_JOBNO';
      Parameters.ParamByName('@I_TYPE').Value := 1;
      ExecProc;
      returnValue := Parameters.ParamValues['@o_JobNo'];

      if (returnValue.Substring(0, 2) = 'OK') then
        Result := StrToInt(returnValue.Substring(3, 4));
    end;
  except
    on E : Exception do
    begin
    end;
  end;
end;


initialization

  //중복 실행 방지 코드 부분
 CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, 1, 'RCP_SC');
  if GetlastError = ERROR_ALREADY_EXISTS then halt;

end.

