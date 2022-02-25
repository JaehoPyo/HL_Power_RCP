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
    procedure fnCreateSet;                                                      // ���α׷� ���� �� ����
    procedure fnCloseSet;                                                       // ���α׷� ���� �� ����

    procedure SC_JOBClear(SC_NO:Integer) ;                                      // �۾� ������ ����ü �ʱ�ȭ
    procedure SC_OLDJOBClear(SC_NO:Integer) ;                                   // ���� �۾� ������ ����ü �ʱ�ȭ

    procedure SC_JOBCopy(SC_NO:Integer) ;                                       // ���� ������ -> ���� ������ ����
    procedure SC_OLDJOBCopy(SC_NO:Integer) ;                                    // ���� ������ -> ���� ������ ����
    procedure SC_ORDClear(SC_NO:Integer) ;                                      // �۾� ���� ����ü �ʱ�ȭ

    // SC Read & Write & Process ���� �Լ�
    procedure SCTREAD(SC_NO:Integer);                                           // SC ���� READ
    procedure SCTWRITE(SC_NO:Integer);                                          // SC ���� WRITE
    procedure SCControlProcess(SC_NO:Integer);                                  // SC �۾� ó��

    // ȭ�� ǥ�� ���� �Լ�
    procedure SC_OrderDisplay(SC_NO:Integer);                                   // ���� ������ ǥ��
    procedure SC_OrderDisplayClear(SC_NO:Integer);                              // ���� ������ Ŭ����
    procedure SC_StatusDisplay(SC_NO:Integer);                                  // ���� ������ ǥ��
    procedure SC_StatusDisplayClear(SC_NO:Integer);                             // ���� ������ Ŭ����
    procedure ListBoxDisplay(xListBox:TListBox; Msg:String);                    // �۾� ��� ������ ǥ��

    function  fnSignalMsg(Signal:string): String;                               // �ñ׳� �޽���
    function  fnModeMsg(Signal:string): String;                                 // ��� �޽���

    function  fnSignalFontColor(Signal,Flag: string): TColor;                   // �ñ׳� ��Ʈ ����
    function  fnSignalEditColor(Signal,Flag: string): TColor;                   // �ñ׳� ����Ʈ����

    // �۾� ó�� ���� �Լ�
    function  GetJobNo : Integer;                                               // �۾���ȣ ����
    function  SCNowStatusUpdate(SC_NO:Integer; Status: String): Boolean ;
    function  SCNowCycleUpdate(SC_NO:Integer; Cycle: String): Boolean ;

    function  fnGetSCSetInfo(SC_NO:Integer; GetField:String): Boolean ;         // SC ���� ���� Get (Ȩ����,�۾����..)
    function  fnGetSCSetLUGG(SC_NO:Integer; GetField:String): String ;          // SC ���� ���� Get (Ȩ����,�۾����..)
    function  fnSetSCSetInfo(SC_NO:Integer; SetField,SetValue:String): Boolean ;// SC ���� ���� SET (0:OFF,1:ON)

    function  fnSetSCSetInfo_Clear(SC_NO:Integer): Boolean ;                    // SC ���� ���� �ʱ�ȭ (All OFF)
    function  fnSetSCSetInfo_Clear2(SC_NO:Integer): Boolean ;                   // ����͸� �۾�ó�� ���� �ʱ�ȭ (All OFF)

    function  SetJobOrder : Boolean;

    // ACS ����
    function  HasACS_Request(Line_No, In_Out: Integer): Boolean;                       // ACS�� ��û���� �ִ� �� Ȯ��
    procedure GetACS_Status(Line_No, In_Out: Integer);                                 // ACS ���°�����
    procedure ACSControlProcess(SC_NO: Integer);                                // ACS ����ó��
    function  SetAcsResponse(Line_No, In_Out: Integer; Status: String) : Boolean;
    procedure fnACS_Update(Line_No, In_Out: Integer; Gubn, FName, FValue: String);

    function  fnGetSCStatus(Src:TScStatus): String ;                            // SC ���¸޽��� Get (����)
    function  fnGetSCStatus2(Src:TScStatus): String ;                           // SC ���¸޽��� Get (�ѱ�)

    function  fnGetSCCmdType(IO_TYPE:String): String ;                          // SC �۾�Ÿ�� ID Get (Ȯ���ʿ�)
    function  fnGetCVStatus(SC_NO:Integer; BuffNo,GetField:String ): Boolean ;  // CV ��&���� ȭ��,����,�������� Get
    function  fnSetWriteInfo(SC_NO:Integer;Job_Type:String): Boolean;           // SC ���� ������ SET
    function  fnSetSCORDWrite(SC_NO: Integer; Falg: String): Boolean;           // SC ���� ������ INSERT
    function  fnGetSCJOB(SC_NO:Integer;JFlag:TSCJobMode): Boolean ;             // SC �۾� �˻�
    function  fnChkSCJOB(SC_NO:Integer): Boolean ;                              // SC �۾� üũ
    function  fnGetCVOrderStr(SC_NO: Integer; IO: String) : String;                            // TT_ORDER CVCURR ���� ����

    // ORDER ���̺� ���� �Լ�
    function  fnOrder_Value(SC_No: Integer; FName : String): String; overload;                       // ORDER ������ Get
    function  fnOrder_Value(WhereStr: String; FName : String) : String; overload;
    function  fnOrder_Cancel(SC_No: Integer; LUGG, REG_TIME: String): Boolean;                       // ORDER ������ Delete(�۾���� ��)
    function  fnOrder_Delete(SC_No:Integer): Boolean;                                                // ORDER ������ Delete (Ȯ���ʿ�)
    function  fnOrder_Update(SC_No:Integer;FName,FValue:String):Boolean;                  overload ; // ORDER ������ Update (Value1��)
    function  fnOrder_Update(SC_No:Integer;FName1,FValue1,FName2,FValue2:String):Boolean; overload ; // ORDER ������ Update (Value2��)
    function  fnOrder_Update(JobNo, FName, FValue:String):Boolean;                        overload ;

    // SCIO ���̺� ���� �Լ�
    function  fnSCIO_Exist (SC_NO:Integer): Boolean;                            // SCIO �۾�üũ
    function  fnSCIO_ReLoad(SC_NO:Integer): Boolean;                            // SCIO ������ ReLoad
    function  fnSCIO_Insert(SC_No:Integer): Boolean;                            // SCIO ������ Insert
    function  fnSCIO_Update(SC_No:Integer): Boolean;                            // SCIO ������ Update
    function  fnSCIO_Delete(SC_No:Integer): Boolean;                            // SCIO ������ Delete

    // STOCK ���̺� ���� �Լ�
    function  fnStockUpdateAll(SC_NO:Integer): Boolean;                            // ����� �� TT_STOCK ó��
    function  fnStockUpdate(SC_No:Integer;FName,FValue:String): Boolean; overload; // �� ���� ���� ��
    function  fnStockUpdate(Loc, FName, FValue: String): Boolean; overload;
    function  fnGetStockLoc(ItemCode : String): String;                            // ǰ�� ��ġ ��ȯ

    // TM_ITEM ���̺� ���� �Լ�
    function fnITEM_Value(SC_No: Integer; FName, FValue : String): String;

    // �����԰�&����� �� ó�� �Լ�
    function  fnCellPosChange(SC_NO:integer;Flag:String): Boolean;                          // ���ο� Postion ��ȯ

    // Log ó�� ���� �Լ�
    procedure ErrorLogWRITE(WRITEStr : String);                                 // �����α� ����
    procedure DisplayLog(SC_NO:Integer;Msg, SR_Type: String; Len:Integer);      // �α� ǥ�� �� ����

    // Error ó�� ���� �Լ�
    function  fnGetErrMsg(SC_NO: integer; GetField,ErrCode: String): String;    // �����޽��� Get
    function  fnSetMachError(SC_NO:Integer; ErrorCode:String): Boolean ;        // ���� ���� Update (TT_ORDER)
    function  fnSetErrReport(SC_NO:Integer; ErrorCode:String): Boolean ;        // ���� ����&���۽ð� ��� (TT_ERROR)
    function  fnReSetErrReport(SC_NO:Integer): Boolean;                         // ���� ����ð� ��� (TT_ERROR)
    function  fnGetErrReport(SC_NO:Integer): Boolean; overload ;                    // ������ ���� ��� üũ (TT_ERROR) -> ������ �����Ű�� ����
    function  fnGetErrReport(SC_NO:Integer; ErrorCode: String): Boolean; overload ; // �߻��� ���� ��� üũ (TT_ERROR) -> ������ �ȳֱ� ����

    // DB Connect üũ �Լ�
    function fnDBConChk : Boolean;


  end;

var
  frmSCComm: TfrmSCComm;

  xMCNo        : integer ;       // ����� SC ȣ��
  CloseChk     : Boolean ;       // ���α׷� ���� Flag
  LogWriteFlag : Boolean = True; // �α����� Flag

  JOB_FLAG      : Array[START_SCNO..End_SCNO] of TSCJobMode ;    // SC �۾� Ÿ��
  SC_STAT       : Array[START_SCNO..End_SCNO] of TScStatus ;     // SC �۾� ����
  SC_STAT_OLD   : Array[START_SCNO..End_SCNO] of TScStatus ;     // SC �۾� ���� (����)

  SC_JOB        : Array[START_SCNO..End_SCNO] of TSC_JOB ;       // SC �۾�
  SC_JOB_OLD    : Array[START_SCNO..End_SCNO] of TSC_JOB ;       // SC ���� �۾�

  SC_STATUS     : Array[START_SCNO..End_SCNO] of TSC_STATUS ;    // SC ����
  SC_STATUS_OLD : Array[START_SCNO..End_SCNO] of TSC_STATUS ;    // SC ���� (����)

  SC_ORDER      : Array[START_SCNO..End_SCNO] of TSC_ORDER ;     // SC ����
  CONTROL_FLAG  : Array[START_SCNO..End_SCNO] of TCONTROL_FLAG ; // ���α׷� ���� Falg

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
    ExitProcess( 0 ); // �ڽ� ���α׷��� ���̴� �Լ�
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
    sbtClick(sbtStart) ;  // �ڵ�����
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
// ACS�� ��û���� �ִ� �� Ȯ��
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
// ACS ���� ������
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
// ACSControlProcess ACS ���� ó��
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
      // �����ؾ��� ACS ��û�� ������ Pass
      if (HasAcs_Request(i) = False) then continue;

      // �����ؾ��� ACS��û�� ���� �� ���信 ������.
      // ACS ��û�� �ִٸ� ACS ��û�� ���� ������.
      // �۷ι� ���� Rx_AcsData[i][j]�� ����
      GetACS_Status(i, j);

      // ACS ��û�� �´� ������ �ϰ� ���� ���� ����

      //==================================//
      // (AGV�� Ŀư �տ� ��ġ) �԰� �۾� //
      //==================================//
      // *** �԰� �۾� ���� *** //
      if (Rx_AcsData[i][j].Port_No_Dest     = '1') and
         (Rx_AcsData[i][j].Call_Request     = '1' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin

        // �ش� AGV�� �԰��۾��� ������ ����
        WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                    '   And JOBD = 1';
        if (fnOrder_Value(WhereStr, 'LINE_NO') = '') then
        begin

          ItemCode := Rx_AcsData[i][j].Model_No;

          // �԰��۾� ������ ����
          OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',Now) + FormatDateTime('HHNNSS',Now) ;
          OrderData.LUGG       := Format('%.4d', [GetJobNo]) ;  // �۾���ȣ
          OrderData.JOBD       := '1';     // �԰�����

          OrderData.SRCSITE    := '0001';  // ���� ȣ��
          OrderData.SRCAISLE   := '0000';  // ���� ��
          OrderData.SRCBAY     := '0000';  // ���� ��
          OrderData.SRCLEVEL   := Format('%.4d', [i]);  // ���� �����̼�
          // ������ �� ��-��-���� AGV->CV�̵� �Ϸ� �� ����
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
          // �۾�����
          if (SetJobOrder) then
          begin
            // �԰����̼� Ŀư ����
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

        // Ŀư ���� ���¶�� ���� ����
        if (PLC_ReadVal.InSt_Door[i] = '1') then
        begin
          // ACS ���� ������ ����
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
          SetAcsResponse(i, j, '������');

          // AGV �������̽� ������ ǥ��
          fnACS_Update(i, j, 'RECV', 'STATUS', '������');

          // �ش� ��û ó������ ǥ�� ( PROCESS : N = ó����, Y = ó����, E = ����)
          fnACS_Update(i, j, 'RECV', 'PROCESS', 'Y');
        end;
      end;

      //==================================//
      // (AGV�� Ŀư �տ� ��ġ) ��� �۾� //
      //==================================//
      // *** ��� �۾� ���� *** //
      if (Rx_AcsData[i][j].Port_No_Dest     = '2' ) and
         (Rx_AcsData[i][j].Call_Request     = '1' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin
        if i = 1 then OtReady := SC_STATUS[SC_NO].D211[9]
        else if i = 2 then OtReady := SC_STATUS[SC_NO].D211[11]
        else if i = 3 then OtReady := SC_STATUS[SC_NO].D211[13] ;

        // �ش� AGV�� ����۾��� ���� ����� On�϶�
        WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                    '   And JOBD = ''2'' ' +
                    '   And JOB_END = ''0'' ';
        if (fnOrder_Value(WhereStr, 'LINE_NO') = '') and
           (OtReady = '1')  then
        begin

          // ǰ�� ã��
          ItemCode := Rx_AcsData[i][j].Model_No;
          // Loc = 110101  ȣ��(1)/��(1)/��(2)/��(2)
          Loc := fnGetStockLoc(ItemCode);

          // ����۾� ������ ����
          OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',Now) + FormatDateTime('HHNNSS',Now) ;
          OrderData.LUGG       := Format('%.4d', [GetJobNo]) ;  // �۾���ȣ
          OrderData.JOBD       := '2';     // �������

          OrderData.SRCSITE    := Format('%.4d', [StrToInt(Copy(Loc, 1, 1))]) ;  // ���� ȣ��
          OrderData.SRCAISLE   := Format('%.4d', [StrToInt(Copy(Loc, 2, 1))]) ;  // ���� ��
          OrderData.SRCBAY     := Format('%.4d', [StrToInt(Copy(Loc, 3, 2))]) ;  // ���� ��
          OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(Copy(Loc, 5, 2))]) ;  // ���� ��
          // ������ �� ��-��-���� AGV->CV�̵� �Ϸ� �� ����
          OrderData.DSTSITE    := '0000';
          OrderData.DSTAISLE   := '0000';
          OrderData.DSTBAY     := '0000';
          OrderData.DSTLEVEL   := Format('%.4d', [i]); // ��� �����̼� 1, 2, 3
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

          // �۾�����
          if (SetJobOrder) then
          begin
            // �� ������Ʈ, �����
            fnStockUpdate(Loc, 'ID_STATUS', '5');

            // ������̼� Ŀư ����
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
          // Ŀư ���� ����, ����۾� �Ϸ����, RFID ������ ��ġ����
          // ���� ����
          if (PLC_ReadVal.InSt_Door[i] = '1') then
          begin
            // ACS ���� ������ ����
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
            SetAcsResponse(i, '������');
            // AGV �������̽� ������ ǥ��
            fnACS_Update(i, 'RECV', 'STATUS', '������');
            // �ش� ��û ó������ ǥ�� ( PROCESS : N = ó����, Y = ó����, E = ����)
            fnACS_Update(i, 'RECV', 'PROCESS', 'Y');
          end;
        end;
      end;

      //==================//
      // ��/��� ����κ� //
      //==================//
      // *** �������̽� ���� *** //
      if (Rx_AcsData[i][j].Call_Request     = '1' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '0' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin
        // ACS ���� ������ ����
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
        SetAcsResponse(i, j, '������');

        // AGV �������̽� ������ ǥ��
        fnACS_Update(i, j, 'RECV', 'STATUS', '������');

        // �ش� ��û ó������ ǥ�� ( PROCESS : N = ó����, Y = ó����, E = ����)
        fnACS_Update(i, j, 'RECV', 'PROCESS', 'Y');
      end else
      // *** ��ŷ �Ϸ� *** //
      if (Rx_AcsData[i][j].Call_Request     = '0' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin

        // ACS ���� ������ ����
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
        SetAcsResponse(i, '������');

        // AGV �������̽� ������ ǥ��
        fnACS_Update(i, 'RECV', 'STATUS', '������');

        // �ش� ��û ó������ ǥ�� ( PROCESS : N = ó����, Y = ó����, E = ����)
        fnACS_Update(i, 'RECV', 'PROCESS', 'Y');
      end else
      // *** ���繰�� AGV���� ����� �̵��� ����, ���� ��û *** //
      if (Rx_AcsData[i][j].Call_Request     = '0' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '1' ) and
         (Rx_AcsData[i][j].Docking_Complete = '1' ) then
      begin

        // CV ȭ������ Ȯ�� ? �̺κ� Ȯ�� �ʿ� .
        // �԰��۾��̸� NOWMC = 1, NOWSTATUS = 4 ����
        if (Rx_AcsData[i][j].Port_No_Dest = '1') then
        begin
          // Order ������ CV�� ����
          WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                      '   And JOBD = ''1'' ' +
                      '   And JOB_END = ''0'' ';
          JobNo := fnOrder_Value(WhereStr, 'LUGG');
          fnOrder_Update(JobNo, 'NOWMC', '1');
        end;

        // ����۾��̸� �������.

        // ACS ���� ������ ����
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
        SetAcsResponse(i, '������');

        // AGV �������̽� ������ ǥ��
        fnACS_Update(i, 'RECV', 'STATUS', '������');

        // �ش� ��û ó������ ǥ�� ( PROCESS : N = ó����, Y = ó����, E = ����)
        fnACS_Update(i, 'RECV', 'PROCESS', 'Y');
      end else
      // *** �ʱ���·� ���ư�... *** //
      if (Rx_AcsData[i][j].Call_Request     = '0' ) and
         (Rx_AcsData[i][j].Call_Answer      = '0' ) and
         (Rx_AcsData[i][j].Docking_Request  = '0' ) and
         (Rx_AcsData[i][j].Docking_Complete = '0' ) then
      begin

        // �԰��� �� TT_ORDER �� �����ϸ� ����Ŀ �۾����� ��.
        ///
        ///  ////////////
        ///  ////////////
        ///


        // ACS ���� ������ ����
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
        SetAcsResponse(i, '���');

        // AGV �������̽� ��� ǥ��
        fnACS_Update(i, 'RECV', 'STATUS', '���');

        // �ش� ��û ó������ ǥ�� ( PROCESS : N = ó����, Y = ó����, E = ����)
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

  if (Sender as TBitBtn).Caption = '��Ž���' then
  begin
    xMCNo := 0;
    (Sender as TBitBtn).Caption := '�������' ;
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
    ( Sender as TBitBtn ).Caption := '��Ž���' ;
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
      StrLog := ' �����ͺ��̽� ���� ����..' ;
      DisplayLog(1, StrLog, 'E', Length(StrLog)) ;
      if ADOConnection then
      begin
        if not tmrStatusREAD.Enabled then tmrStatusREAD.Enabled := True;
        StrLog := ' �����ͺ��̽� ���� ����!!' ;
        DisplayLog(1, StrLog, 'E', Length(StrLog)) ;
      end else
      begin
        StrLog := ' �����ͺ��̽� �� ���� ��....' ;
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

      // ACS �������̽� ���� ó��
      ACSControlProcess(xMCNo);

      // SC ����
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
{*                         ȭ�� ǥ�� ���� �Լ�                                *}
{******************************************************************************}

//==============================================================================
// SC_OrderDisplay
//==============================================================================
procedure TfrmSCComm.SC_OrderDisplay(SC_NO: Integer);
begin
  TEdit(Self.FindComponent('edt_LUGG'     )).Text := SC_JOB[SC_NO].ID_ORDLUGG  ; // �۾���ȣ
  TEdit(Self.FindComponent('edt_SrcBank'  )).Text := SC_JOB[SC_NO].LOAD_BANK   ; // ���� ��
  TEdit(Self.FindComponent('edt_SrcBay'   )).Text := SC_JOB[SC_NO].LOAD_BAY    ; // ���� ��
  TEdit(Self.FindComponent('edt_SrcLevel' )).Text := SC_JOB[SC_NO].LOAD_LEVEL  ; // ���� ��
  TEdit(Self.FindComponent('edt_DstBank'  )).Text := SC_JOB[SC_NO].UNLOAD_BANK ; // �Ͽ� ��
  TEdit(Self.FindComponent('edt_DstBay'   )).Text := SC_JOB[SC_NO].UNLOAD_BAY  ; // �Ͽ� ��
  TEdit(Self.FindComponent('edt_DstLevel' )).Text := SC_JOB[SC_NO].UNLOAD_LEVEL; // �Ͽ� ��
end;

//==============================================================================
// SC_OrderDisplayClear
//==============================================================================
procedure TfrmSCComm.SC_OrderDisplayClear(SC_NO: Integer);
begin
  TEdit(Self.FindComponent('edt_LUGG'     )).Text := ''; // �۾���ȣ
  TEdit(Self.FindComponent('edt_SrcBank'  )).Text := ''; // ���� ��
  TEdit(Self.FindComponent('edt_SrcBay'   )).Text := ''; // ���� ��
  TEdit(Self.FindComponent('edt_SrcLevel' )).Text := ''; // ���� ��
  TEdit(Self.FindComponent('edt_DstBank'  )).Text := ''; // �Ͽ� ��
  TEdit(Self.FindComponent('edt_DstBay'   )).Text := ''; // �Ͽ� ��
  TEdit(Self.FindComponent('edt_DstLevel' )).Text := ''; // �Ͽ� ��
  TEdit(Self.FindComponent('edt_MoveOn'   )).Text := ''; // �⵿����
  TEdit(Self.FindComponent('edt_DataReset')).Text := ''; // �������ʱ�ȭ
end;

//==============================================================================
// SC_StatusDisplay
//==============================================================================
procedure TfrmSCComm.SC_StatusDisplay(SC_NO: Integer);
begin
  // D200
  TEdit(Self.FindComponent('edt_CurrBay'      )).Text := SC_STATUS[SC_NO].D200;  // ������ġ ��
  // D201
  TEdit(Self.FindComponent('edt_CurrLevel'    )).Text := SC_STATUS[SC_NO].D201;  // ������ġ ��
  // D205
  TEdit(Self.FindComponent('edt_ErrorCode'    )).Text := SC_STATUS[SC_NO].D205;  // �̻��ڵ�
  TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := fnGetErrMsg(SC_NO, 'ERR_NAME', SC_STATUS[SC_NO].D205);  // �̻󳻿�


  //++++++++++++++++++++++++++++++++++++++++++++
  // ���°� ǥ�� (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[00]); // ����� ���
  TEdit(Self.FindComponent('edt_SCCMode'      )).Text := fnModeMsg(  SC_STATUS[SC_NO].D210[01]); // ���� ���
  TEdit(Self.FindComponent('edt_Emergency'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[02]); // �������
  TEdit(Self.FindComponent('edt_StroreIn'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[03]); // �԰��۾� ��
  TEdit(Self.FindComponent('edt_StroreOut'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[04]); // ����۾� ��
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[06]); // ���� ����ġ
  TEdit(Self.FindComponent('edt_UDPosition'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[07]); // �°� ����ġ
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[08]); // ��ũ ����
  TEdit(Self.FindComponent('edt_CargoExist'   )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[09]); // ��ũ ��ǰ ����
  TEdit(Self.FindComponent('edt_Loading'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[10]); // �ε� ��
  TEdit(Self.FindComponent('edt_UnLoading'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[11]); // ��ε� ��
  TEdit(Self.FindComponent('edt_Error'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D210[15]); // �̻�߻�
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[00]); // �����
  TEdit(Self.FindComponent('edt_Working'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[01]); // �۾���
  TEdit(Self.FindComponent('edt_Complete'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[02]); // �۾��Ϸ�
  TEdit(Self.FindComponent('edt_Double'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[03]); // �����԰�
  TEdit(Self.FindComponent('edt_Empty'        )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[04]); // �����
  TEdit(Self.FindComponent('edt_ForceComplete')).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[07]); // �����Ϸ�
  TEdit(Self.FindComponent('edt_InReady'      )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[08]); // �԰���
  TEdit(Self.FindComponent('edt_OutReady'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[09]); // �����

  //++++++++++++++++++++++++++++++++++++++++++++
  // ����Ʈ ���� ���� (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[00],'4'); // ����� ���
  TEdit(Self.FindComponent('edt_SCCMode'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[01],'4'); // ���� ���
  TEdit(Self.FindComponent('edt_Emergency'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[02],'1'); // �������
  TEdit(Self.FindComponent('edt_StroreIn'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[03],'0'); // �԰��۾� ��
  TEdit(Self.FindComponent('edt_StroreOut'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[04],'0'); // ����۾� ��
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[06],'0'); // ���� ����ġ
  TEdit(Self.FindComponent('edt_UDPosition'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[07],'0'); // �°� ����ġ
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[08],'0'); // ��ũ ����
  TEdit(Self.FindComponent('edt_CargoExist'   )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[09],'0'); // ��ũ ��ǰ ����
  TEdit(Self.FindComponent('edt_Loading'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[10],'0'); // �ε� ��
  TEdit(Self.FindComponent('edt_UnLoading'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[11],'0'); // ��ε� ��
  TEdit(Self.FindComponent('edt_Error'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D210[15],'1'); // �̻�߻�
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[00],'0'); // �����
  TEdit(Self.FindComponent('edt_Working'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[01],'0'); // �۾���
  TEdit(Self.FindComponent('edt_Complete'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[02],'3'); // �۾��Ϸ�
  TEdit(Self.FindComponent('edt_Double'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[03],'1'); // �����԰�
  TEdit(Self.FindComponent('edt_Empty'        )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[04],'1'); // �����
  TEdit(Self.FindComponent('edt_ForceComplete')).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[07],'3'); // �����Ϸ�
  TEdit(Self.FindComponent('edt_InReady'      )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[08],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[09],'2'); // �����

  //++++++++++++++++++++++++++++++++++++++++++++
  // ����Ʈ ��Ʈ ���� ���� (D210.00 ~ D210.15)
  //++++++++++++++++++++++++++++++++++++++++++++
  TEdit(Self.FindComponent('edt_SCTMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[00],'4'); // ����� ���
  TEdit(Self.FindComponent('edt_SCCMode'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[01],'4'); // ���� ���
  TEdit(Self.FindComponent('edt_Emergency'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[02],'1'); // �������
  TEdit(Self.FindComponent('edt_StroreIn'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[03],'0'); // �԰��۾� ��
  TEdit(Self.FindComponent('edt_StroreOut'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[04],'0'); // ����۾� ��
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[06],'0'); // ���� ����ġ
  TEdit(Self.FindComponent('edt_UDPosition'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[07],'0'); // �°� ����ġ
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[08],'0'); // ��ũ ����
  TEdit(Self.FindComponent('edt_CargoExist'   )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[09],'0'); // ��ũ ��ǰ ����
  TEdit(Self.FindComponent('edt_Loading'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[10],'0'); // �ε� ��
  TEdit(Self.FindComponent('edt_UnLoading'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[11],'0'); // ��ε� ��
  TEdit(Self.FindComponent('edt_Error'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D210[15],'1'); // �̻�߻�
  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[00],'0'); // �����
  TEdit(Self.FindComponent('edt_Working'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[01],'0'); // �۾���
  TEdit(Self.FindComponent('edt_Complete'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[02],'3'); // �۾��Ϸ�
  TEdit(Self.FindComponent('edt_Double'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[03],'1'); // �����԰�
  TEdit(Self.FindComponent('edt_Empty'        )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[04],'1'); // �����
  TEdit(Self.FindComponent('edt_ForceComplete')).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[07],'3'); // �����Ϸ�
  TEdit(Self.FindComponent('edt_InReady'      )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[08],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[09],'2'); // �����
end;

//==============================================================================
// SC_StatusDisplayClear
//==============================================================================
procedure TfrmSCComm.SC_StatusDisplayClear(SC_NO: Integer);
begin
  // D200
  TEdit(Self.FindComponent('edt_CurrBay'      )).Text := ''; // ������ġ ��
  // D201
  TEdit(Self.FindComponent('edt_CurrLevel'    )).Text := ''; // ������ġ ��
  // D205
  TEdit(Self.FindComponent('edt_ErrorCode'    )).Text := ''; // �̻��ڵ�
  TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := ''; // �̻󳻿�

  // D210.00 ~ D210.15
  TEdit(Self.FindComponent('edt_SCTMode'      )).Text := ''; // ����� ���
  TEdit(Self.FindComponent('edt_SCCMode'      )).Text := ''; // ���� ���
  TEdit(Self.FindComponent('edt_Emergency'    )).Text := ''; // �������
  TEdit(Self.FindComponent('edt_StroreIn'     )).Text := ''; // �԰��۾� ��
  TEdit(Self.FindComponent('edt_StroreOut'    )).Text := ''; // ����۾� ��
  TEdit(Self.FindComponent('edt_DrvPosition'  )).Text := ''; // ���� ����ġ
  TEdit(Self.FindComponent('edt_UDPosition'   )).Text := ''; // �°� ����ġ
  TEdit(Self.FindComponent('edt_ForkCenter'   )).Text := ''; // ��ũ ����
  TEdit(Self.FindComponent('edt_CargoExist'   )).Text := ''; // ��ũ ��ǰ ����
  TEdit(Self.FindComponent('edt_Loading'      )).Text := ''; // �ε� ��
  TEdit(Self.FindComponent('edt_UnLoading'    )).Text := ''; // ��ε� ��
  TEdit(Self.FindComponent('edt_Error'        )).Text := ''; // �̻�߻�

  // D211.00 ~ D211.15
  TEdit(Self.FindComponent('edt_StandBy'      )).Text := ''; // �����
  TEdit(Self.FindComponent('edt_Working'      )).Text := ''; // �۾���
  TEdit(Self.FindComponent('edt_Complete'     )).Text := ''; // �۾��Ϸ�
  TEdit(Self.FindComponent('edt_Double'       )).Text := ''; // �����԰�
  TEdit(Self.FindComponent('edt_Empty'        )).Text := ''; // �����
  TEdit(Self.FindComponent('edt_ForceComplete')).Text := ''; // �����Ϸ�
  TEdit(Self.FindComponent('edt_InReady'      )).Text := ''; // �԰���
  TEdit(Self.FindComponent('edt_OutReady'     )).Text := ''; // �����
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
  if      Signal='0'    then Result := '����'
  else if Signal='1'    then Result := '�ڵ�'
  else                       Result := Signal;
end;

//==============================================================================
// fnSignalEditColor
//==============================================================================
function TfrmSCComm.fnSignalEditColor(Signal,Flag: string): TColor;
begin
  Result := clWhite ;
  if Flag='0' then
  begin // �Ϲ�
    Result := clWhite
  end else
  if Flag='1' then
  begin // ����
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clRed
    else                       Result := clWhite;
  end else
  if Flag='2' then
  begin // ����
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clLime
    else                       Result := clWhite;
  end else
  if Flag='3' then
  begin // �Ϸ�
    if      Signal='0'    then Result := clWhite
    else if Signal='1'    then Result := clNavy
    else                       Result := clWhite;
  end else
  if Flag='4' then
  begin // ���
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
  begin // �Ϲ�
    Result := clNavy;
  end else
  if Flag='1' then
  begin // ����
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='2' then
  begin // ����
    Result := clBlack;
  end else
  if Flag='3' then
  begin // �Ϸ�
    if      Signal='0'    then Result := clBlack
    else if Signal='1'    then Result := clWhite
    else                       Result := clBlack;
  end else
  if Flag='4' then
  begin // ���
    Result := clBlack;
  end else
end;

{******************************************************************************}
{*                    SC Read & Write & Process ���� �Լ�                     *}
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

        //����Ʈ Ŀư ����
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
    SC_StatusDisplay(SC_NO); // SC���� Display
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
  {*   STANDBY                     *}    {*   1: �۾�����         *}
  {*   DATA1, ORDER1, RESET1, ERR1 *}    {*   2: �۾���           *}
  {*   DATA2, ORDER2, RESET2, ERR2 *}    {*   3: ȭ�� ����        *}
  {*   RETRY_REQ                   *}    {*   4: �۾��Ϸ�         *}
  {*   CANCEL_REQ                  *}    {*   5: �۾� �����߻�    *}
  {*   DATAERR                     *}    {*   6: ������ ���� �߻� *}


  case SC_STAT[SC_NO] of
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // START : SC ���α׷��� ���� �⵿�� ����
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    START   :
    begin
      SCNowStatusUpdate(SC_NO,'START') ; // SC ���� Status ������Ʈ[START]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read ����
      SC_STAT[SC_NO] := STANDBY ;        // START -> STANDBY : SC�۾� ��� ���·� ����.
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // STANDBY : SC ���¸� ����, �۾� ���� �����̸� READY1 ���� ����
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    STANDBY :
    begin
      SCNowStatusUpdate(SC_NO,'STANDBY') ; // SC ���� ���� ������Ʈ[STANDBY]
      CONTROL_FLAG[SC_NO] := ComRead ;     // Read ����

      SC_OrderDisplayClear(SC_NO) ;      // SC ���� ������ ǥ�� �ʱ�ȭ
      fnSetSCSetInfo_Clear(SC_NO) ;      // ����͸� �۾����� �ʱ�ȭ1
      fnSetSCSetInfo_Clear2(SC_NO) ;     // ����͸� �۾����� �ʱ�ȭ2

      //++++++++++++++++
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG := '9999';
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        Exit;
      end ;


      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // ������� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[08] = '1') and  // ��ũ���� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[09] = '0') and  // ȭ������ (0:����, 1:����)
         (SC_STATUS[SC_NO].D210[15] = '0') and  // �������� (0:����, 1:����)
         (SC_STATUS[SC_NO].D211[00] = '1') and  // ��� ��  (0: Off, 1: On )
         (SC_STATUS[SC_NO].D211[01] = '0') then // �۾� ��  (0: Off, 1: On )
      begin
        SC_STAT[SC_NO] := READY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // READY : �۾��� �˻��Ͽ� SC�۾��� ������ �۾� ������ ��� �� ����
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    READY  :
    begin
      SCNowStatusUpdate(SC_NO,'READY') ; // SC ���� ���� ������Ʈ[READY]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write ����

      SC_OrderDisplayClear(SC_NO) ;      // SC ���� ������ ǥ�� �ʱ�ȭ
      fnSetSCSetInfo_Clear(SC_NO) ;      // ����͸� �۾����� �ʱ�ȭ1
      fnSetSCSetInfo_Clear2(SC_NO) ;     // ����͸� �۾����� �ʱ�ȭ2


      //++++++++++++++++
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG := '9999';
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        Exit;
      end;


      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // ������� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[08] = '1') and  // ��ũ���� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[09] = '0') and  // ȭ������ (0:����, 1:����)
         (SC_STATUS[SC_NO].D210[15] = '0') and  // �������� (0:����, 1:����)
         (SC_STATUS[SC_NO].D211[00] = '1') and  // ��� ��  (0: Off, 1: On )
         (SC_STATUS[SC_NO].D211[01] = '0') then // �۾� ��  (0: Off, 1: On )
      begin
        if (SC_JOB[SC_NO].ID_ORDLUGG = '') and
           (SC_JOB[SC_NO].ID_REGTIME = '') then
        begin
          if      Job_Flag[SC_NO] = None       then Job_Flag[SC_NO] := StoreIn    // None   -> �԰�
          else if Job_Flag[SC_NO] = StoreIn    then Job_Flag[SC_NO] := StoreOut   // �԰�   -> ���
          else if Job_Flag[SC_NO] = StoreOut   then Job_Flag[SC_NO] := RackToRack // ���   -> ���̵�
          else if Job_Flag[SC_NO] = RackToRack then Job_Flag[SC_NO] := StoreIn;   // ���̵� -> �԰�

          if ( ((Job_Flag[SC_NO] = StoreIn)  and (not fnGetSCSetInfo(SC_No, 'SC_IN_USED'))) or
               ((Job_Flag[SC_NO] = StoreOut) and (not fnGetSCSetInfo(SC_No, 'SC_OT_USED'))) or
               ((Job_Flag[SC_NO] = RackToRack) and (not fnGetSCSetInfo(SC_NO, 'RACK_MOVE'))) ) then Exit;

          if fnGetSCJOB(SC_NO, Job_Flag[SC_NO]) then
          begin
            fnOrder_Update(SC_NO, 'NOWMC', '2') ;
            fnOrder_Update(SC_NO, 'JOBSTATUS', '2', 'NOWSTATUS', '2' ) ;
            SC_JOB[SC_NO].MOVE_ON := '1';     // �⵿����
            CONTROL_FLAG[SC_NO] := ComWrite ; // �۾�����
            SC_STAT[SC_NO] := DATA1 ;
          end;

        end;
      end else
      begin
        SC_STAT[SC_NO] := STANDBY ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // DATA1 : SC�� �۾��� ������ �Ǿ����� Ȯ��
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    DATA1   :
    begin
      SCNowStatusUpdate(SC_NO,'DATA1') ; // SC ���� ���� ������Ʈ[DATA1]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write ����


      //++++++++++++++++
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;


      //++++++++++++++++
      // �ε� ������ üũ
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // ������� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // �������� (0:����, 1:����)
         (SC_STATUS[SC_NO].D210[10] = '1') then // �ε��� ���� �Ǹ� Order1
      begin
        fnOrder_Update(SC_NO, 'JOBSTATUS', '3', 'NOWSTATUS', '3' ) ;
        SC_STAT[SC_NO] := ORDER1 ;

        if (fnOrder_Value(SC_No, 'JOBERRORD') <> '' ) and
           (fnOrder_Value(SC_No, 'JOBERRORD') <> '0') then fnSetMachError(SC_NO, '0') ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D205 = '0073') or   // ���� Data �̻�
             (SC_STATUS[SC_NO].D205 = '0074') then // ���� Data ����
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
    // ORDER1 : SC �۾� �Ϸ� ���� �� ���� ���� üũ
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ORDER1  :
    begin
      SCNowStatusUpdate(SC_NO,'ORDER1') ; // SC ���� ���� ������Ʈ[DATA1]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write ����


      //++++++++++++++++
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;


      //++++++++++++++++
      // �ε� �Ϸ� üũ
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // ������� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // �������� (0:����, 1:����)
         (SC_STATUS[SC_NO].D210[10] <>'1') then // �ε��� �Ϸ� �Ǹ� Reset1
      begin
        SC_STAT[SC_NO] := RESET1 ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D211[04] = '1') then // �����
          begin
            SC_STAT[SC_NO] := ERR1 ;
            fnStockUpdate(SC_NO,'ID_STATUS','7') ; // ������ ������ ����
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
    // RESET1 : Loading�۾� �Ϸ� ó�� �� UnLoading(DATA2) �ܰ� ����
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RESET1  :
    begin
      SCNowStatusUpdate(SC_NO,'RESET1') ; // SC ���� ���� ������Ʈ[RESET1]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write ����


      //++++++++++++++++
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;


      //++++++++++++++++
      // �ε��Ϸ� ó��
      //++++++++++++++++
      if (SC_JOB[SC_NO].SC_STEP = 'L') then // �۾��ܰ� Loading�̸�
      begin
        if fnSCIO_Update(SC_NO) then // Loading -> UnLoading���� ����
        begin
          fnOrder_Update(SC_NO, 'NOWMC', '3', 'NOWSTATUS', '2' ) ; // NOWMC(6:SC UnLoading) , NOWSTATUS(2:����)�� ���� & JOBSTATUS(3:������) ����
          SC_STAT[SC_NO] := DATA2 ;          // SC Unloading �۾� �������̶�� ���·� �����.
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
    // DATA2 : SC�� �۾��� ������ �Ǿ����� Ȯ��
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    DATA2   :
    begin
      SCNowStatusUpdate(SC_NO,'DATA2') ; // SC ���� ���� ������Ʈ[DATA2]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write ����


      //++++++++++++++++
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;


      //++++++++++++++++
      // ��ε� ������ üũ
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // ������� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // �������� (0:����, 1:����)
         (SC_STATUS[SC_NO].D210[11] = '1') then // ��ε��� ���� �Ǹ� Order2
      begin
        fnOrder_Update(SC_NO, 'JOBSTATUS', '3', 'NOWSTATUS', '3' ) ;
        SC_STAT[SC_NO] := ORDER2 ;


        if (fnOrder_Value(SC_No, 'JOBERRORD') <> '' ) and
           (fnOrder_Value(SC_No, 'JOBERRORD') <> '0') then fnSetMachError(SC_NO, '0') ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D205 = '0073') or   // ���� Data �̻�
             (SC_STATUS[SC_NO].D205 = '0074') then // ���� Data ����
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
    // ORDER2 : SC �۾� �Ϸ� ���� �� ���� ���� üũ
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ORDER2  :
    begin
      SCNowStatusUpdate(SC_NO,'ORDER2') ; // SC ���� ���� ������Ʈ[ORDER2]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write ����


      //++++++++++++++++
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;


      //++++++++++++++++
      // ��ε� �Ϸ� üũ
      //++++++++++++++++
      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // ������� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') and  // �������� (0:����, 1:����)
         (SC_STATUS[SC_NO].D211[02] = '1') then // �۾��Ϸ� (0: Off, 1: On )
      begin
        SC_STAT[SC_NO] := RESET2 ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if (SC_STATUS[SC_NO].D211[03] = '1') then // �����԰�
          begin
            SC_STAT[SC_NO] := ERR2 ;
            fnStockUpdate(SC_NO,'ID_STATUS','6') ;  // ������ �����԰�� ����
          end else
          if (SC_STATUS[SC_NO].D210[09] = '0') then // ȭ�� ����
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
    // RESET2 : UnLoading�۾��Ϸ� ó�� �� �����۾� �Ϸ�
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RESET2  :
    begin
      SCNowStatusUpdate(SC_NO,'RESET2') ; // SC ���� ���� ������Ʈ[RESET2]
      CONTROL_FLAG[SC_NO] := ComRead ;    // Read & Write ����


      //++++++++++++++++
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;


      //++++++++++++++++
      // ��ε� �Ϸ� ó��
      //++++++++++++++++
      if SC_JOB[SC_NO].SC_STEP = 'U' then
      begin
        if fnOrder_Delete(SC_NO) then // �۾� �Ϸ� ó��.
        begin
          SC_JOB[SC_No].JOB_COMPLETE := '1';
          CONTROL_FLAG[SC_NO] := ComWrite ;

          SC_STAT[SC_NO] := STANDBY ;
        end;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // ERR1,ERR2 : Loading, UnLoading �ܰ迡���� ����ó��
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ERR1, ERR2 :
    begin
      SCNowStatusUpdate(SC_NO,'ERR') ;   // SC ���� ���� ������Ʈ[RETRY_REQ]
      CONTROL_FLAG[SC_NO] := ComRead ;   // Read & Write ����
      fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;

      //++++++++++++++++
      // ��⵿
      //++++++++++++++++
      if (fnGetSCSetInfo(SC_No,'JOB_RETRY')) then // ����͸� ��⵿ On
      begin
        fnSetSCSetInfo(SC_No, 'JOB_RETRY', '0');
        SC_JOB[SC_No].JOB_RETRY := '1';

        if (SC_STATUS[SC_NO].D211[03] = '1') then // �����԰�
        begin
          SC_JOB[SC_No].DATA_RESET := '1';
          SC_STAT[SC_NO] := ORDER2 ;
          fnCellPosChange(SC_NO,'1');
          fnChkSCJOB(SC_NO);
          CONTROL_FLAG[SC_NO] := ComWrite ;
          SC_JOB[SC_NO].MOVE_ON := '1';
        end else
        if (SC_STATUS[SC_NO].D211[04] = '1') then // �����
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
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // DATAERR : �۾����� ������ �̻� ���� �߻�
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    DATAERR :
    begin
      SCNowStatusUpdate(SC_NO,'DATAERR') ; // SC ���� ���� ������Ʈ[RETRY_REQ]
      CONTROL_FLAG[SC_NO] := ComRead ;     // Read & Write ����
      fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;

      //++++++++++++++++
      // �����Ϸ�
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
      // �������ʱ�ȭ
      //++++++++++++++++
      if fnGetSCSetInfo(SC_No,'JOB_CANCLE') then
      begin
        SC_JOB[SC_No].JOB_COMPLETE := '1';
        CONTROL_FLAG[SC_NO] := ComWrite ;

        SC_STAT[SC_NO] := STANDBY ;
        fnOrder_Cancel(SC_NO, SC_JOB[SC_NO].ID_ORDLUGG, SC_JOB[SC_NO].ID_REGTIME ) ;  // TT_ORDER ����
        fnSCIO_Delete(SC_NO) ;                                                        // TT_SCIO ����
        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // RETRY_REQ : ��⵿ ó��
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    RETRY_REQ  :
    begin
      SCNowStatusUpdate(SC_NO,'RETRY_REQ') ; // SC ���� ���� ������Ʈ[RETRY_REQ]

      if (SC_STATUS[SC_NO].D210[00] = '1') and  // SCT �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[01] = '1') and  // SCC �ڵ� (0:����, 1:�ڵ�)
         (SC_STATUS[SC_NO].D210[02] = '0') and  // ������� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[08] = '1') and  // ��ũ���� (0: Off, 1: On )
         (SC_STATUS[SC_NO].D210[15] = '0') then // �������� (0:����, 1:����)
      begin
        if      SC_JOB[SC_NO].SC_STEP = 'L' then SC_STAT[SC_NO] := ORDER1   // SC Loading   ���̸� ORDER1 ���·�
        else if SC_JOB[SC_NO].SC_STEP = 'U' then SC_STAT[SC_NO] := ORDER2 ; // SC UnLoading ���̸� ORDER2 ���·�
        CONTROL_FLAG[SC_NO] := ComWrite ;
      end;
    end;


    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // CANCEL_REQ : �۾� ��� Flag�� ������ ���� ���� �� STANDBY�� ����
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    CANCEL_REQ :
    begin
      SCNowStatusUpdate(SC_NO,'CANCEL_REQ') ;   // SC ���� ���� ������Ʈ[CANCEL_REQ]
    end;

  end;
end;

//==============================================================================
// fnSetWriteInfo : ���� ������ SET
//==============================================================================
function TfrmSCComm.fnSetWriteInfo(SC_NO:Integer;Job_Type:String): Boolean;
var
  TempIdx : Integer;
  StrLog : String ;
begin
  SC_ORDClear(SC_NO) ; // ���� ����ü �ʱ�ȭ

  //++++++++++++++++++++++++++
  // ������ Reset
  //++++++++++++++++++++++++++
  if (SC_STATUS[SC_NO].D211[03] = '1') or   // �����԰�
     (SC_STATUS[SC_NO].D211[04] = '1') or   // �����
     (fnGetSCSetInfo(SC_No,'JOB_CANCLE')) or
     (SC_JOB[SC_No].DATA_RESET = '1') then
  begin
    SC_JOB[SC_No].DATA_RESET := '0';
    fnSetSCSetInfo(SC_No, 'JOB_CANCLE', '0') ;
    SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ; //�۾���ȣ
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

    fnSetSCORDWrite(SC_NO,'2'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
    fnSetSCSetInfo(SC_No,'DATA_RESET','1');
  end;


  //++++++++++++++++++++++++++++++++
  // �۾��Ϸ� ���� �� �⵿���� OFF
  //++++++++++++++++++++++++++++++++
  if (SC_JOB[SC_No].JOB_COMPLETE = '1') or
     (fnGetSCSetInfo(SC_No,'JOB_COMPLETE')) then
  begin
    Sleep(1000);
    SC_JOB[SC_No].JOB_COMPLETE := '0';

    // �۾��ϷẸ�� Reset Command ������
    SC_ORDER[SC_NO].SCORD_NO := SC_JOB[SC_NO].ID_ORDLUGG ; //�۾���ȣ
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

    TEdit(Self.FindComponent('edt_MoveOn')).Text := '' ; // �⵿���� Off
    fnSetSCSetInfo(SC_No,'MOVE_ON','0');
    fnSetSCORDWrite(SC_NO,'2');
    SC_JOBClear(SC_NO);
  end else
  begin
    Sleep(500);
    //--------------------------------------------------------------------------
    // �����԰�&�����԰���⵿, �������&�������⵿
    //--------------------------------------------------------------------------
    if (Job_Type = 'I') and (SC_JOB[SC_NO].ID_ORDLUGG<>'')  then // �����԰�
    begin
      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ;    // �۾���ȣ
      SC_ORDER[SC_NO].SCORD_D100 := '0000';                       // ���� ��
      SC_ORDER[SC_NO].SCORD_D101 := '0000';                       // ���� ��
      SC_ORDER[SC_NO].SCORD_D102 := '0001';                       // ���� ��
      SC_ORDER[SC_NO].SCORD_D103 := SC_JOB[SC_NO].UNLOAD_BANK;    // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D104 := SC_JOB[SC_NO].UNLOAD_BAY;     // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D105 := SC_JOB[SC_NO].UNLOAD_LEVEL;   // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D106 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D107 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D108 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D109 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D110 := '0000';                       // ����

      SC_OrderDisplay(SC_NO);     // SC Order ȭ�� ���÷���
      fnSetSCORDWrite(SC_NO,'0'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
    end else
    if (Job_Type = 'O') and (SC_JOB[SC_NO].ID_ORDLUGG <> '') then // �������
    begin
      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ;    // �۾���ȣ
      SC_ORDER[SC_NO].SCORD_D100 := SC_JOB[SC_NO].LOAD_BANK;      // ���� ��
      SC_ORDER[SC_NO].SCORD_D101 := SC_JOB[SC_NO].LOAD_BAY;       // ���� ��
      SC_ORDER[SC_NO].SCORD_D102 := SC_JOB[SC_NO].LOAD_LEVEL;     // ���� ��
      SC_ORDER[SC_NO].SCORD_D103 := '0000';                       // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D104 := '0000';                       // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D105 := '0001';                       // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D106 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D107 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D108 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D109 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D110 := '0000';                       // ����

      SC_OrderDisplay(SC_NO);     // SC Order ȭ�� ���÷���
      fnSetSCORDWrite(SC_NO,'0'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
    end;


    if (SC_JOB[SC_No].MOVE_ON = '1') then
    begin
      Sleep(500);
      SC_JOB[SC_No].MOVE_ON := '0' ;

      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ; //�۾���ȣ
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

      TEdit(Self.FindComponent('edt_MoveOn')).Text := 'O' ; // �⵿���� On
      fnSetSCSetInfo(SC_No,'MOVE_ON','1');
      fnSetSCORDWrite(SC_NO,'1'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
    end;

    // Ŀư on/off
//    if / True then

    Sleep(2000);
  end;
end;

//==============================================================================
// fnSetSCORDWrite : ���� ������ TT_SCORD�� INSERT (MELSEC ���α׷����� TT_SCORD ���� ��)
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
             '''' + IntToStr(Sc_No) + ''', ' +             // ����Ŀ ��ȣ
             '''' + SC_ORDER[SC_NO].SCORD_NO + ''', ' +    // �۾���ȣ
             '''' + SC_ORDER[SC_NO].SCORD_D100 + ''', ' +  // D100 - ���� ��
             '''' + SC_ORDER[SC_NO].SCORD_D101 + ''', ' +  // D101 - ���� ��
             '''' + SC_ORDER[SC_NO].SCORD_D102 + ''', ' +  // D102 - ���� ��
             '''' + SC_ORDER[SC_NO].SCORD_D103 + ''', ' +  // D103 - �Ͽ� ��
             '''' + SC_ORDER[SC_NO].SCORD_D104 + ''', ' +  // D104 - �Ͽ� ��
             '''' + SC_ORDER[SC_NO].SCORD_D105 + ''', ' +  // D105 - �Ͽ� ��
             '''' + SC_ORDER[SC_NO].SCORD_D106 + ''', ' +  // D106 - ����
             '''' + SC_ORDER[SC_NO].SCORD_D107 + ''', ' +  // D107 - ����
             '''' + SC_ORDER[SC_NO].SCORD_D108 + ''', ' +  // D108 - ����
             '''' + SC_ORDER[SC_NO].SCORD_D109 + ''', ' +  // D109 - ����
             '''' + SC_ORDER[SC_NO].SCORD_D110 + ''', ' +  // D110 - �⵿ ���� �Ǵ� Data Reset
             '''' + Falg + ''', ' +                        // STATUS - 0: ���õ����� 1: �⵿���� �Ǵ� Data Reset
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
      SC_JOB[i].ID_ORDLUGG     := '' ; // �۾� ��ȣ
      SC_JOB[i].ID_REGTIME     := '' ; // �۾� ���� �ð�
      SC_JOB[i].ID_ORDDATE     := '' ; // �۾� ���� ����
      SC_JOB[i].ID_ORDTIME     := '' ; // �۾� ���� �Ͻ�
      SC_JOB[i].IO_TYPE        := '' ; // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
      SC_JOB[i].LOAD_BANK      := '' ; // ���� ��
      SC_JOB[i].LOAD_BAY       := '' ; // ���� ��
      SC_JOB[i].LOAD_LEVEL     := '' ; // ���� ��
      SC_JOB[i].UNLOAD_BANK    := '' ; // �Ͽ� ��
      SC_JOB[i].UNLOAD_BAY     := '' ; // �Ͽ� ��
      SC_JOB[i].UNLOAD_LEVEL   := '' ; // �Ͽ� ��
      SC_JOB[i].ITM_CD         := '' ; // �����ڵ�
      SC_JOB[i].SC_STEP        := '' ; // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )
      SC_JOB[i].JOB_RETRY      := '' ; // �����԰� ��⵿
      SC_JOB[i].JOB_CANCEL     := '' ; // �۾�����
      SC_JOB[i].JOB_COMPLETE   := '' ; // �۾��Ϸ�
      SC_JOB[i].DATA_RESET     := '' ; // �������ʱ�ȭ
      SC_JOB[i].MOVE_ON        := '' ; // �⵿����
    end;
  end else
  begin
    SC_JOB[SC_NO].ID_ORDLUGG     := '' ; // �۾� ��ȣ
    SC_JOB[SC_NO].ID_REGTIME     := '' ; // �۾� ���� �ð�
    SC_JOB[SC_NO].ID_ORDDATE     := '' ; // �۾� ���� ����
    SC_JOB[SC_NO].ID_ORDTIME     := '' ; // �۾� ���� �Ͻ�
    SC_JOB[SC_NO].IO_TYPE        := '' ; // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
    SC_JOB[SC_NO].LOAD_BANK      := '' ; // ���� ��
    SC_JOB[SC_NO].LOAD_BAY       := '' ; // ���� ��
    SC_JOB[SC_NO].LOAD_LEVEL     := '' ; // ���� ��
    SC_JOB[SC_NO].UNLOAD_BANK    := '' ; // �Ͽ� ��
    SC_JOB[SC_NO].UNLOAD_BAY     := '' ; // �Ͽ� ��
    SC_JOB[SC_NO].UNLOAD_LEVEL   := '' ; // �Ͽ� ��
    SC_JOB[SC_NO].ITM_CD         := '' ; // �����ڵ�
    SC_JOB[SC_NO].SC_STEP        := '' ; // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )
    SC_JOB[SC_NO].JOB_RETRY      := '' ; // �����԰� ��⵿
    SC_JOB[SC_NO].JOB_CANCEL     := '' ; // �۾�����
    SC_JOB[SC_NO].JOB_COMPLETE   := '' ; // �۾��Ϸ�
    SC_JOB[SC_NO].DATA_RESET     := '' ; // �������ʱ�ȭ
    SC_JOB[SC_NO].MOVE_ON        := '' ; // �⵿����
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
      SC_JOB_OLD[i].ID_ORDLUGG       := '' ; // �۾� ��ȣ
      SC_JOB_OLD[i].ID_REGTIME       := '' ; // �۾� ���� �ð�
      SC_JOB_OLD[i].ID_ORDDATE       := '' ; // �۾� ���� ����
      SC_JOB_OLD[i].ID_ORDTIME       := '' ; // �۾� ���� �Ͻ�
      SC_JOB_OLD[i].IO_TYPE          := '' ; // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
      SC_JOB_OLD[i].LOAD_BANK        := '' ; // ���� ��
      SC_JOB_OLD[i].LOAD_BAY         := '' ; // ���� ��
      SC_JOB_OLD[i].LOAD_LEVEL       := '' ; // ���� ��
      SC_JOB_OLD[i].UNLOAD_BANK      := '' ; // �Ͽ� ��
      SC_JOB_OLD[i].UNLOAD_BAY       := '' ; // �Ͽ� ��
      SC_JOB_OLD[i].UNLOAD_LEVEL     := '' ; // �Ͽ� ��
      SC_JOB_OLD[i].ITM_CD           := '' ; // �����ڵ�
      SC_JOB_OLD[i].SC_STEP          := '' ; // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )
      SC_JOB_OLD[i].JOB_RETRY        := '' ; // ��⵿
      SC_JOB_OLD[i].JOB_CANCEL       := '' ; // �۾�����
      SC_JOB_OLD[i].JOB_COMPLETE     := '' ; // �۾��Ϸ�
      SC_JOB_OLD[i].DATA_RESET       := '' ; // �������ʱ�ȭ
      SC_JOB_OLD[i].MOVE_ON          := '' ; // �⵿����
    end;
  end else
  begin
    SC_JOB_OLD[SC_NO].ID_ORDLUGG     := '' ; // �۾� ��ȣ
    SC_JOB_OLD[SC_NO].ID_REGTIME     := '' ; // �۾� ���� �ð�
    SC_JOB_OLD[SC_NO].ID_ORDDATE     := '' ; // �۾� ���� ����
    SC_JOB_OLD[SC_NO].ID_ORDTIME     := '' ; // �۾� ���� �Ͻ�
    SC_JOB_OLD[SC_NO].IO_TYPE        := '' ; // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
    SC_JOB_OLD[SC_NO].LOAD_BANK      := '' ; // ���� ��
    SC_JOB_OLD[SC_NO].LOAD_BAY       := '' ; // ���� ��
    SC_JOB_OLD[SC_NO].LOAD_LEVEL     := '' ; // ���� ��
    SC_JOB_OLD[SC_NO].UNLOAD_BANK    := '' ; // �Ͽ� ��
    SC_JOB_OLD[SC_NO].UNLOAD_BAY     := '' ; // �Ͽ� ��
    SC_JOB_OLD[SC_NO].UNLOAD_LEVEL   := '' ; // �Ͽ� ��
    SC_JOB_OLD[SC_NO].ITM_CD         := '' ; // �����ڵ�
    SC_JOB_OLD[SC_NO].SC_STEP        := '' ; // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )
    SC_JOB_OLD[SC_NO].JOB_RETRY      := '' ; // ��⵿
    SC_JOB_OLD[SC_NO].JOB_CANCEL     := '' ; // �۾�����
    SC_JOB_OLD[SC_NO].JOB_COMPLETE   := '' ; // �۾��Ϸ�
    SC_JOB_OLD[SC_NO].DATA_RESET     := '' ; // �������ʱ�ȭ
    SC_JOB_OLD[SC_NO].MOVE_ON        := '' ; // �⵿����
  end;
end;

//==============================================================================
// SC_JOBCopy
//==============================================================================
procedure TfrmSCComm.SC_JOBCopy(SC_NO: Integer);
begin
  SC_JOB_OLD[SC_NO].ID_ORDLUGG     := SC_JOB[SC_NO].ID_ORDLUGG     ; // �۾� ��ȣ
  SC_JOB_OLD[SC_NO].ID_REGTIME     := SC_JOB[SC_NO].ID_REGTIME     ; // �۾� ���� �ð�
  SC_JOB_OLD[SC_NO].ID_ORDDATE     := SC_JOB[SC_NO].ID_ORDDATE     ; // �۾� ���� ����
  SC_JOB_OLD[SC_NO].ID_ORDTIME     := SC_JOB[SC_NO].ID_ORDTIME     ; // �۾� ���� �Ͻ�
  SC_JOB_OLD[SC_NO].IO_TYPE        := SC_JOB[SC_NO].IO_TYPE        ; // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
  SC_JOB_OLD[SC_NO].LOAD_BANK      := SC_JOB[SC_NO].LOAD_BANK      ; // ���� ��
  SC_JOB_OLD[SC_NO].LOAD_BAY       := SC_JOB[SC_NO].LOAD_BAY       ; // ���� ��
  SC_JOB_OLD[SC_NO].LOAD_LEVEL     := SC_JOB[SC_NO].LOAD_LEVEL     ; // ���� ��
  SC_JOB_OLD[SC_NO].UNLOAD_BANK    := SC_JOB[SC_NO].UNLOAD_BANK    ; // �Ͽ� ��
  SC_JOB_OLD[SC_NO].UNLOAD_BAY     := SC_JOB[SC_NO].UNLOAD_BAY     ; // �Ͽ� ��
  SC_JOB_OLD[SC_NO].UNLOAD_LEVEL   := SC_JOB[SC_NO].UNLOAD_LEVEL   ; // �Ͽ� ��
  SC_JOB_OLD[SC_NO].ITM_CD         := SC_JOB[SC_NO].ITM_CD        ; // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )
  SC_JOB_OLD[SC_NO].SC_STEP        := SC_JOB[SC_NO].SC_STEP        ; // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )
  SC_JOB_OLD[SC_NO].JOB_RETRY      := SC_JOB[SC_NO].JOB_RETRY      ; // ��⵿
  SC_JOB_OLD[SC_NO].JOB_CANCEL     := SC_JOB[SC_NO].JOB_CANCEL     ; // �۾�����
  SC_JOB_OLD[SC_NO].JOB_COMPLETE   := SC_JOB[SC_NO].JOB_COMPLETE   ; // �۾��Ϸ�
  SC_JOB_OLD[SC_NO].DATA_RESET     := SC_JOB[SC_NO].DATA_RESET     ; // �������ʱ�ȭ
  SC_JOB_OLD[SC_NO].MOVE_ON        := SC_JOB[SC_NO].MOVE_ON        ; // �⵿����

end;

//==============================================================================
// SC_OLDJOBCopy
//==============================================================================
procedure TfrmSCComm.SC_OLDJOBCopy(SC_NO: Integer);
begin
  SC_JOB[SC_NO].ID_ORDLUGG     := SC_JOB_OLD[SC_NO].ID_ORDLUGG     ; // �۾� ��ȣ
  SC_JOB[SC_NO].ID_REGTIME     := SC_JOB_OLD[SC_NO].ID_REGTIME     ; // �۾� ���� �ð�
  SC_JOB[SC_NO].ID_ORDDATE     := SC_JOB_OLD[SC_NO].ID_ORDDATE     ; // �۾� ���� ����
  SC_JOB[SC_NO].ID_ORDTIME     := SC_JOB_OLD[SC_NO].ID_ORDTIME     ; // �۾� ���� �Ͻ�
  SC_JOB[SC_NO].IO_TYPE        := SC_JOB_OLD[SC_NO].IO_TYPE        ; // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
  SC_JOB[SC_NO].LOAD_BANK      := SC_JOB_OLD[SC_NO].LOAD_BANK      ; // ���� ��
  SC_JOB[SC_NO].LOAD_BAY       := SC_JOB_OLD[SC_NO].LOAD_BAY       ; // ���� ��
  SC_JOB[SC_NO].LOAD_LEVEL     := SC_JOB_OLD[SC_NO].LOAD_LEVEL     ; // ���� ��
  SC_JOB[SC_NO].UNLOAD_BANK    := SC_JOB_OLD[SC_NO].UNLOAD_BANK    ; // �Ͽ� ��
  SC_JOB[SC_NO].UNLOAD_BAY     := SC_JOB_OLD[SC_NO].UNLOAD_BAY     ; // �Ͽ� ��
  SC_JOB[SC_NO].UNLOAD_LEVEL   := SC_JOB_OLD[SC_NO].UNLOAD_LEVEL   ; // �Ͽ� ��
  SC_JOB[SC_NO].ITM_CD         := SC_JOB_OLD[SC_NO].ITM_CD         ; // �Ͽ� ��
  SC_JOB[SC_NO].SC_STEP        := SC_JOB_OLD[SC_NO].SC_STEP        ; // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )
  SC_JOB[SC_NO].JOB_RETRY      := SC_JOB_OLD[SC_NO].JOB_RETRY      ; // ��⵿
  SC_JOB[SC_NO].JOB_CANCEL     := SC_JOB_OLD[SC_NO].JOB_CANCEL     ; // �۾�����
  SC_JOB[SC_NO].JOB_COMPLETE   := SC_JOB_OLD[SC_NO].JOB_COMPLETE   ; // �۾��Ϸ�
  SC_JOB[SC_NO].DATA_RESET     := SC_JOB_OLD[SC_NO].DATA_RESET     ; // �������ʱ�ȭ
  SC_JOB[SC_NO].MOVE_ON        := SC_JOB_OLD[SC_NO].MOVE_ON        ; // �⵿����
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
      SC_ORDER[i].SCORD_NO     := '' ; // �۾���ȣ
      SC_ORDER[i].SCORD_D100   := '' ; // ���� ��
      SC_ORDER[i].SCORD_D101   := '' ; // ���� ��
      SC_ORDER[i].SCORD_D102   := '' ; // ���� ��
      SC_ORDER[i].SCORD_D103   := '' ; // �Ͽ� ��
      SC_ORDER[i].SCORD_D104   := '' ; // �Ͽ� ��
      SC_ORDER[i].SCORD_D105   := '' ; // �Ͽ� ��
      SC_ORDER[i].SCORD_D106   := '' ; // ����
      SC_ORDER[i].SCORD_D107   := '' ; // ����
      SC_ORDER[i].SCORD_D108   := '' ; // ����
      SC_ORDER[i].SCORD_D109   := '' ; // ����
      SC_ORDER[i].SCORD_D110   := '' ; // �⵿���� and Data Reset
      SC_ORDER[i].SCORD_ST     := '' ; // ����
      SC_ORDER[i].SCORD_DT     := '' ; // ���� �ð�
    end;
  end else
  begin
    SC_ORDER[SC_NO].SCORD_NO     := '' ; // �۾���ȣ
    SC_ORDER[SC_NO].SCORD_D100   := '' ; // ���� ��
    SC_ORDER[SC_NO].SCORD_D101   := '' ; // ���� ��
    SC_ORDER[SC_NO].SCORD_D102   := '' ; // ���� ��
    SC_ORDER[SC_NO].SCORD_D103   := '' ; // �Ͽ� ��
    SC_ORDER[SC_NO].SCORD_D104   := '' ; // �Ͽ� ��
    SC_ORDER[SC_NO].SCORD_D105   := '' ; // �Ͽ� ��
    SC_ORDER[SC_NO].SCORD_D106   := '' ; // ����
    SC_ORDER[SC_NO].SCORD_D107   := '' ; // ����
    SC_ORDER[SC_NO].SCORD_D108   := '' ; // ����
    SC_ORDER[SC_NO].SCORD_D109   := '' ; // ����
    SC_ORDER[SC_NO].SCORD_D110   := '' ; // �⵿���� and Data Reset
    SC_ORDER[SC_NO].SCORD_ST     := '' ; // ����
    SC_ORDER[SC_NO].SCORD_DT     := '' ; // ���� �ð�
  end;
end;



{******************************************************************************}
{*                         Log ó�� ���� �Լ�                                 *}
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
{*                         �۾� ó�� ���� �Լ�                                *}
{******************************************************************************}

//==============================================================================
// SCNowStatusUpdate -> SC ���α׷� ���� Status Update
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
// SCNowCycleUpdate -> SC ���α׷� ���� Cycle Update
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
// fnGetSCSetInfo : ���� ��� ���� ������ ��ȯ
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
// fnGetSCSetLugg : ���� ��� ���� ������ ��ȯ
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
// fnSetSCSetInfo : ���� ��� ���� ������ ����
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
// fnSetSCSetInfo_Clear : WMS -> SC �۾� ��û ��Ʈ �ʱ�ȭ
//==============================================================================
function TfrmSCComm.fnSetSCSetInfo_Clear(SC_NO:Integer): Boolean ;
begin
  if fnGetSCSetInfo(SC_No, 'JOB_RETRY'   ) then fnSetSCSetInfo(SC_No, 'JOB_RETRY'   , '0') ;  // [��⵿ ��û]
  if fnGetSCSetInfo(SC_No, 'JOB_COMPLETE') then fnSetSCSetInfo(SC_No, 'JOB_COMPLETE', '0') ;  // [�۾��Ϸ� ��û]
  if fnGetSCSetInfo(SC_No, 'DATA_RESET'  ) then fnSetSCSetInfo(SC_No, 'DATA_RESET'  , '0') ;  // [�������ʱ�ȭ ��û]
  if fnGetSCSetInfo(SC_No, 'MOVE_ON'     ) then fnSetSCSetInfo(SC_No, 'MOVE_ON'     , '0') ;  // [�⵿���� ��û]
end;

//==============================================================================
// fnSetSCSetInfo_Clear2 : WMS -> SC �۾� ��û ��Ʈ �ʱ�ȭ
//==============================================================================
function TfrmSCComm.fnSetSCSetInfo_Clear2(SC_NO:Integer): Boolean ;
begin
  if fnGetSCSetInfo(SC_No, 'SC_WMS_COM')        then fnSetSCSetInfo(SC_No, 'SC_WMS_COM', '0') ;  // ����͸� �۾��Ϸ� Off
  if fnGetSCSetInfo(SC_No, 'SC_WMS_CAN')        then fnSetSCSetInfo(SC_No, 'SC_WMS_CAN', '0') ;  // ����͸� �۾���� Off
  if fnGetSCSetLugg(SC_No, 'SC_LUGG') <> '0000' then fnSetSCSetInfo(SC_No, 'SC_LUGG', '0000') ;  // ����͸� �۾��Ϸ�&��� �۾���ȣ
end;

//==============================================================================
// fnGetSCStatus : ���� ���� ��ȯ(����)
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
// fnGetSCStatus : ���� ���� ��ȯ(�ѱ�)
//==============================================================================
function TfrmSCComm.fnGetSCStatus2(src: TScStatus): String;
begin
  case Src of
    START       : Result := '���ʽ���' ;
    STANDBY     : Result := '����üũ' ;
    READY       : Result := '����üũ&�۾��˻�' ;

    DATA1       : Result := '�ε� üũ' ;
    ORDER1      : Result := '�ε� ��' ;
    RESET1      : Result := '�ε� �Ϸ�' ;
    ERR1        : Result := '�ε� ����' ;

    DATA2       : Result := '��ε� üũ' ;
    ORDER2      : Result := '��ε� ��' ;
    RESET2      : Result := '��ε� �Ϸ�' ;
    ERR2        : Result := '��ε� ����' ;

    RETRY_REQ   : Result := '��⵿' ;
    CANCEL_REQ  : Result := '�۾�����' ;
    DATAERR     : Result := '�����Ϳ���' ;
    else Result := '' ;
  end;
end;

//==============================================================================
// fnGetSCCmdType : �۾� Ÿ��(Command ID) ��ȯ
//==============================================================================
function TfrmSCComm.fnGetSCCmdType(IO_TYPE: String): String;
begin
  if      IO_TYPE='I' then Result := '0001' // I:�԰�
  else if IO_TYPE='O' then Result := '0002' // O:���
  else if IO_TYPE='M' then Result := '0003' // M:Rack To Rack
  else if IO_TYPE='C' then Result := '0003' // C:SC Site to SC Site
end;


//==============================================================================
// fnGetCVOrderStr : TT_ORDER CVCURR ���� ����
//==============================================================================
function TfrmSCComm.fnGetCVOrderStr(SC_NO: Integer; IO: String): String;
var
  CVCURR : String;
begin

  // �԰� �����̼� ���� ���ǿ� ���� CVCURR ���� ����
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
  // ��� �����̼� ���� ���ǿ� ���� CVCURR ���� ����
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
// fnGetCVStatus : ��&���� ����(ȭ������, ����, ����) ��ȯ
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
// fnGetSCJOB : TT_ORDER �۾��� ã�� ������ SC_JOB ����ü �ְ� True ��ȯ
//==============================================================================
function TfrmSCComm.fnGetSCJOB(SC_NO:Integer; JFlag:TSCJobMode): Boolean;
var
  StrSQL, StrLog, JobLog, IO_Gubun, CVCURR, LoadBank, LoadBay : String ;
  TmpLugg : Array [START_SCNO..End_SCNO] of String ;
begin
  Result := False ;

  if JFlag = StoreIn then
  begin // �԰��۾� �˻�
    IO_Gubun := 'I' ;
    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select TOP 1 * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''1''   ' +                                 // �԰� �۾�
              '    And NOWMC     = ''1''   ' +                                 // CV�۾�
              '    And NOWSTATUS = ''4''   ' +                                 // �Ϸ� �۾�
              '    And DSTSITE   = ''' + FormatFloat('0000', SC_NO) + '''  ' + // �԰� ȣ��
              CVCURR +
              '  Order By REG_TIME, LUGG ' ;
  end else
  if JFlag = StoreOut then
  begin // ����۾� �˻�
    IO_Gubun := 'O' ;
    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select TOP 1 * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''2''   ' +                                 // ��� �۾�
              '    And NOWMC     = ''2''   ' +                                 // SC�۾�
              '    And NOWSTATUS = ''1''   ' +                                 // ��� �۾�
              '    And SRCSITE   = ''' + FormatFloat('0000', SC_NO) + ''' ' +  // ��� ȣ��
              CVCURR +
              '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
  end else
  if JFlag = RackToRack then
  begin // ���̵��۾� �˻�
    IO_Gubun := 'M' ;
    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select TOP 1 * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''7''   ' +                                 // ���̵� �۾�
              '    And NOWMC     = ''2''   ' +                                 // SC�۾�
              '    And NOWSTATUS = ''1''   ' +                                 // ��� �۾�
              '    And SRCSITE   = ''' + FormatFloat('0000', SC_NO) + ''' ' +  // ��� ȣ��
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
        SC_JOB[SC_NO].ID_ORDLUGG := FormatFloat('0000', FieldByName('LUGG').AsInteger); // �۾� ��ȣ
        SC_JOB[SC_NO].ID_REGTIME := FieldByName('REG_TIME').AsString ;                  // �۾� ���� �ð�
        SC_JOB[SC_NO].ID_ORDDATE := Copy(SC_JOB[SC_NO].ID_REGTIME, 1, 8) ;              // �۾� ���� ����
        SC_JOB[SC_NO].ID_ORDTIME := Copy(SC_JOB[SC_NO].ID_REGTIME, 9, 6) ;              // �۾� ���� �Ͻ�
        SC_JOB[SC_NO].IO_TYPE    := IO_Gubun ;                                          // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
        SC_JOB[SC_NO].ITM_CD     := UpperCase(Trim(FieldByName('ITM_CD').AsString)) ;

        SC_JOB[SC_NO].SC_STEP := 'L'   ;   // �۾� �ܰ� (L:Loading, U:UnLoading)

        if JFlag = StoreIn then
        begin // �԰��۾�
          SC_JOB[SC_NO].LOAD_BANK     := '0000' ;                                  // ���� ��(0000)
          SC_JOB[SC_NO].LOAD_BAY      := '0000' ;                                  // ���� ��(0000)
          SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // ���� ��(0001) �԰����̼� (0001 ~ 0003)
          SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // �Ͽ� ��(0001~0002)
          SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // �Ͽ� ��(0001~0011)
          SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // �Ͽ� ��(0001~0003)


          JobLog := '�԰��۾�' +
                    ' | �۾���ȣ-' + SC_JOB[SC_NO].ID_ORDLUGG +
                    ' | ������ġ-' + Copy(SC_JOB[SC_NO].LOAD_LEVEL,4,1)   +
                    ' | �Ͽ���ġ-' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)  +
                    '-'            + Copy(SC_JOB[SC_NO].UNLOAD_BAY,3,2)   +
                    '-'            + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,3,2) ;
        end else
        if JFlag = StoreOut then
        begin // ����۾�
          SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // ���� ��(0001~0002)
          SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // ���� ��(0001~0011)
          SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // ���� ��(0001~0003)
          SC_JOB[SC_NO].UNLOAD_BANK   := '0000' ;                                  // �Ͽ� ��(0000
          SC_JOB[SC_NO].UNLOAD_BAY    := '0000' ;                                  // �Ͽ� ��(0000)
          SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // �Ͽ� ��(0001) ������̼� (0001 ~ 0003)


          JobLog := '����۾�'   +
                    ' | �۾���ȣ-' + SC_JOB[SC_NO].ID_ORDLUGG +
                    ' | ������ġ-' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +
                    ' | �Ͽ���ġ-' + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,4,1)  ;
        end else
        if JFlag = RackToRack then
        begin
          SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // ���� ��(0001~0002)
          SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // ���� ��(0001~0011)
          SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // ���� ��(0001~0003)
          SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // �Ͽ� ��(0000
          SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // �Ͽ� ��(0000)
          SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // �Ͽ� ��(0001) ������̼� (0001 ~ 0003)

          JobLog := '���̵��۾�'   +
                    ' | �۾���ȣ-' + SC_JOB[SC_NO].ID_ORDLUGG +
                    ' | ������ġ-' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +
                    '-'            + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +
                    ' | �Ͽ���ġ-' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)  +
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
// fnChkSCJOB : Order Check �ؼ� ��ġ�� ����Ǿ����� SC_JOB �� SCIO �� ����
//==============================================================================
function TfrmSCComm.fnChkSCJOB(SC_NO: Integer): Boolean;
var
  StrSQL, JobD, StrLog, JobLog : String ;
  POS_Change : Boolean ;
  ExecNo : integer ;
begin
  // JOBD      -> ���� Ÿ�� ( 1: �԰�, 2: ���, 3: ����԰�, 4: ������, 5: Site To SC To Site, 6: Site To Site, 7: Rack To Rack, 8: SC Site to SC Site )
  // NOWMC     -> ���� ���� ( 1: CV, 2: SCLoading, 3: SCUnloading )
  // NOWSTATUS -> ���� ���� ( 0: Claer, 1: ���,  2: ����, 3: ������, 4: �Ϸ� )
  // JOBSTATUS -> �Ϸ� ���� ( 0: Claer, 1: ���,  2: ����, 3: ������, 4: �Ϸ� )

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
        JobD := FieldByName('JobD').AsString ;  // �۾� ����
        if JobD = '1' then
        begin // �԰��۾�
          if (SC_JOB[SC_NO].UNLOAD_BANK  <> Trim(FieldByName('DSTAISLE').AsString)) OR   // �Ͽ� ��
             (SC_JOB[SC_NO].UNLOAD_BAY   <> Trim(FieldByName('DSTBAY'  ).AsString)) OR   // �Ͽ� ��
             (SC_JOB[SC_NO].UNLOAD_LEVEL <> Trim(FieldByName('DSTLEVEL').AsString)) then // �Ͽ� ��
          begin
            POS_Change := True ;

            JobLog := '�԰���ġ ����' +
                      ' | �۾���ȣ- '  + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | ���� �Ͽ���ġ- '  + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)    +  // ���� �Ͽ� ��
                      '-'                   + Copy(SC_JOB[SC_NO].UNLOAD_BAY,3,2)     +  // ���� �Ͽ� ��
                      '-'                   + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,3,2)   + #13#10 +  // ���� �Ͽ� ��
                      ' ->'                 +
                      ' ���� �Ͽ���ġ- '    + Copy(Trim(FieldByName('DSTAISLE').AsString),4,1) + // ���� �Ͽ� ��
                      '-'                   + Copy(Trim(FieldByName('DSTBAY'  ).AsString),3,2) + // ���� �Ͽ� ��
                      '-'                   + Copy(Trim(FieldByName('DSTLEVEL').AsString),3,2) ; // ���� �Ͽ� ��

            SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // �Ͽ� ��
            SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // �Ͽ� ��
            SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // �Ͽ� ��
          end;
        end else
        if JobD = '2' then
        begin // ����۾�
          if (SC_JOB[SC_NO].LOAD_BANK   <> Trim(FieldByName('SRCAISLE').AsString)) OR    // ���� ��
             (SC_JOB[SC_NO].LOAD_BAY    <> Trim(FieldByName('SRCBAY'  ).AsString)) OR    // ���� ��
             (SC_JOB[SC_NO].LOAD_LEVEL  <> Trim(FieldByName('SRCLEVEL').AsString)) then  // ���� ��
          begin
            POS_Change := True ;

            JobLog := ' Pos Change' +
                      ' | LUGG- ' + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | TYPE- ' + 'StoreOut' +
                      ' | LOAD- ' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +  // ���� ���� ��
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +  // ���� ���� ��
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +  // ���� ���� ��
                      ' ->'       +
                      ' Change LOAD- ' + Copy(Trim(FieldByName('SRCAISLE').AsString),4,1) + // ���� ���� ��
                      '-'              + Copy(Trim(FieldByName('SRCBAY'  ).AsString),3,2) + // ���� ���� ��
                      '-'              + Copy(Trim(FieldByName('SRCLEVEL').AsString),3,2) ; // ���� ���� ��

            SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // ���� ��
            SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // ���� ��
            SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // ���� ��
          end;
        end else
        if JobD = '7' then
        begin // Rack To Rack
          if (SC_JOB[SC_NO].LOAD_BANK    <> Trim(FieldByName('SRCAISLE').AsString)) OR    // ���� ��
             (SC_JOB[SC_NO].LOAD_BAY     <> Trim(FieldByName('SRCBAY'  ).AsString)) OR    // ���� ��
             (SC_JOB[SC_NO].LOAD_LEVEL   <> Trim(FieldByName('SRCLEVEL').AsString)) OR    // ���� ��
             (SC_JOB[SC_NO].UNLOAD_BANK  <> Trim(FieldByName('DSTAISLE').AsString)) OR    // �Ͽ� ��
             (SC_JOB[SC_NO].UNLOAD_BAY   <> Trim(FieldByName('DSTBAY'  ).AsString)) OR    // �Ͽ� ��
             (SC_JOB[SC_NO].UNLOAD_LEVEL <> Trim(FieldByName('DSTLEVEL').AsString)) then  // �Ͽ� ��
          begin
            POS_Change := True ;

            JobLog := ' Pos Change' +
                      ' | LUGG- ' + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | TYPE- ' + 'RackToRack' +
                      ' | LOAD- ' + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)    +  // ���� ���� ��
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_BAY,3,2)     +  // ���� ���� ��
                      '-'         + Copy(SC_JOB[SC_NO].LOAD_LEVEL,3,2)   +  // ���� ���� ��
                      ' ->'       +
                      ' Change LOAD- ' + Copy(Trim(FieldByName('SRCAISLE').AsString),4,1) + // ���� ���� ��
                      '-'              + Copy(Trim(FieldByName('SRCBAY'  ).AsString),3,2) + // ���� ���� ��
                      '-'              + Copy( Trim(FieldByName('SRCLEVEL').AsString),3,2)+ // ���� ���� ��
                      ' | UNLOAD- ' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1)    +  // ���� �Ͽ� ��
                      '-'           + Copy(SC_JOB[SC_NO].UNLOAD_BAY,3,2)     +  // ���� �Ͽ� ��
                      '-'           + Copy(SC_JOB[SC_NO].UNLOAD_LEVEL,3,2)   +  // ���� �Ͽ� ��
                      ' ->'         +
                      ' Change UNLOAD- ' + Copy(Trim(FieldByName('DSTAISLE').AsString),4,1) + // ���� �Ͽ� ��
                      '-'                + Copy(Trim(FieldByName('DSTBAY'  ).AsString),3,2) + // ���� �Ͽ� ��
                      '-'                + Copy(Trim(FieldByName('DSTLEVEL').AsString),3,2) ; // ���� �Ͽ� ��

            SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // ����(��)
            SC_JOB[SC_NO].LOAD_BAY      := Trim(FieldByName('SRCBAY'  ).AsString) ;  // ����(��)
            SC_JOB[SC_NO].LOAD_LEVEL    := Trim(FieldByName('SRCLEVEL').AsString) ;  // ����(��)
            SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // �Ͽ�(��)
            SC_JOB[SC_NO].UNLOAD_BAY    := Trim(FieldByName('DSTBAY'  ).AsString) ;  // �Ͽ�(��)
            SC_JOB[SC_NO].UNLOAD_LEVEL  := Trim(FieldByName('DSTLEVEL').AsString) ;  // �Ͽ�(��)
          end;
        end else
        if JobD = '8' then
        begin // Cv To Cv
          if (SC_JOB[SC_NO].LOAD_BANK    <> Trim(FieldByName('SRCAISLE').AsString)) OR    // ���� ��
             (SC_JOB[SC_NO].UNLOAD_BANK  <> Trim(FieldByName('DSTAISLE').AsString)) then  // �Ͽ� ��
          begin
            POS_Change := True ;

            JobLog := ' Pos Change' +
                      ' | LUGG- '   + SC_JOB[SC_NO].ID_ORDLUGG +
                      ' | TYPE- '   + 'CvToCv' +
                      ' | LOAD- '   + Copy(SC_JOB[SC_NO].LOAD_BANK,4,1)   +    // ���� ���� ��
                      ' ->'         +
                      ' Change LOAD- ' + Copy(Trim(FieldByName('SRCAISLE').AsString),4,1) +   // ���� ���� ��
                      ' | UNLOAD- ' + Copy(SC_JOB[SC_NO].UNLOAD_BANK,4,1) +  // ���� �Ͽ� ��
                      ' ->'         +
                      ' Change UNLOAD- ' + Copy(Trim(FieldByName('DSTAISLE').AsString),4,1) ; // ���� �Ͽ� ��

            SC_JOB[SC_NO].LOAD_BANK     := Trim(FieldByName('SRCAISLE').AsString) ;  // ���� ��
            SC_JOB[SC_NO].UNLOAD_BANK   := Trim(FieldByName('DSTAISLE').AsString) ;  // �Ͽ� ��
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
{*                         ORDER ���̺� ���� �Լ�                             *}
{******************************************************************************}

//==============================================================================
// fnOrder_Value : ORDER ������ ��ȯ
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
// fnOrder_Value : ORDER ������ 1�� ��ȯ
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
// fnITEM_Value : TM_ITEM ������ ��ȯ
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
// fnOrder_Delete : �۾� �Ϸ��� ORDER �� SCIO ����
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
  // �԰� �Ϸ� �϶�
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TT_Order Delete
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'I') then    // �԰� �۾� �Ϸ�
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
  // ��� �Ϸ� �϶�
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

        if ExecNo > 0 then // TT_SCIO ���� ����
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

          if ExecNo > 0 then // TT_ORDER ����&���� ����
          begin
            MainDM.MainDB.CommitTrans ;

            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | Complete Proc Step[3]' +
                      '| ORDER UPDATE ���� ' +
                      ' | JOB_TYPE- '+ StrJob +
                      ' | LUGG- '    + SC_JOB[SC_No].ID_ORDLUGG +
                      ' | REG_DATE- '+ SC_JOB[SC_NO].ID_REGTIME ;
            DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
            Result := True ;
          end else
          begin              // TT_ORDER ����&���� ����
            MainDM.MainDB.RollbackTrans ;
            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | Complete Proc Step[3]' +
                      '| ORDER UPDATE ���� ' +
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
// fnOrder_Update : TT_ORDER�� �ʵ�1 ������1 ������Ʈ
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
// fnOrder_Update : TT_ORDER�� �ʵ�1 ������1 ������Ʈ
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
// fnOrder_Update : TT_ORDER�� �ʵ�2 ������2 ������Ʈ
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
// fnGetErrMsg : �������� Get
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
// fnSetMachError : ���� ���� �߻� �� TT_ORDER�� �������� Update
//==============================================================================
function TfrmSCComm.fnSetMachError(SC_NO:Integer; ErrorCode:String): Boolean;
var
  UdtSQL, StrLog, StrProc, Step : string;
  JobErrorT, JobErrorc, JobErrord : String ;
  ExecNo  : Integer;
  NowErrCode : String ;
begin
  Result := False;

  if ErrorCode = fnOrder_Value(SC_No, 'JOBERRORD') then Exit ; // ������ ���� �����ڵ�� ��� �����ڵ尡 ������ �н�

  if StrToIntDef(ErrorCode, 0) = 0 then
  begin // ���� ����
    Step      := '2';
    StrProc   := ' Error Clear ' ;
    JobErrorT := '0' ;       // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet, R:RGV
    JobErrorc := '0' ;       // 0: ����, 1: ����
    JobErrord := ErrorCode ; // ���� �ڵ�
  end else
  begin // ���� �߻�
    Step      := '1';
    StrProc   := ' Error ' ;
    JobErrorT := 'S' ;       // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet, R:RGV
    JobErrorc := '1' ;       // 0: ����, 1: ����
    JobErrord := ErrorCode ; // ���� �ڵ�
  end;

  UdtSQL := ' UPDATE TT_ORDER ' +
            '    SET JOBERRORT = ''' + JobErrorT + ''' ' + // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet, R:RGV
            '      , JOBERRORC = ''' + JobErrorc + ''' ' + // 0: ����, 1: ����
            '      , JOBERRORD = ''' + JobErrord + ''' ' + // ���� �ڵ�
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
             '''SC'', ' +                                     // ����Ŀ
             '''' + IntToStr(Sc_No) + ''', ' +                // ����Ŀ ��ȣ
             '''' + ErrorCode + ''', ' +                      // �����ڵ�
             '''' + ERR_NAME + ''', ' +                       // �����ڵ� ����
             ''''', ' +                                       // ����
             'GETDATE(), ' +                                    // ���� ���� �ð�
             ''''', ' +                                       // ���� ���� �ð�
             '''' + FormatDateTime('YYYYMMDD',Now) + ''') ' ; // ���� ����

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
// fnGetErrReport : ����ȵ� �ش� ������ TT_ERROR�� �ִ��� üũ
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
// fnGetErrReport : ����ȵ� �ش� ������ TT_ERROR�� �ִ��� üũ
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
// fnReSetErrReport : TT_ERROR�� ���� ����ð� ���
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
{*                         SCIO ���̺� ���� �Լ�                              *}
{******************************************************************************}

//==============================================================================
// fnSCIO_Exist : �ش� ȣ�Ⱑ ���� �۾����� ���� ���� �ִ��� Ȯ��
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
// fnSCIO_Insert : SC_JOB Data�� ������ TT_SCIO Table�� Insert
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
             '''���ô��'', ''L'', GETDATE() ) ' ;
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
// fnSCIO_Update : TT_SCIO�� �۾��ܰ� ������Ʈ ( Loading -> UnLoading )
//==============================================================================
function TfrmSCComm.fnSCIO_Update(SC_No: Integer): Boolean;
var
  StrSQL, StrLog : String ;
  ExecNo : Integer ;
begin
  Result := False ;

  SC_STAT[SC_No]        := DATA2 ; // SC ���� UnLoading ó���� ����
  SC_JOB[SC_No].SC_STEP := 'U'   ; // �۾� �ܰ� (L:Loading, U:UnLoading)

  StrSQL  := ' UPDATE TT_SCIO ' +
             '    SET SC_STATUS = ''���ô��'' ' +    // SC ����
             '      , SC_STEP   = ''U'' ' +           // �۾� �ܰ�
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
// fnSCIO_ReLoad : �۾��� �˻� �Ǹ� �����͸� �ٽ� SET
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
        SC_JOB[SC_NO].ID_ORDLUGG   := FieldByName('ID_INDEX' ).AsString ;       // �۾� ��ȣ
        SC_JOB[SC_NO].ID_ORDDATE   := FieldByName('ID_DATE'  ).AsString ;       // �۾� ���� ����
        SC_JOB[SC_NO].ID_ORDTIME   := FieldByName('ID_TIME'  ).AsString ;       // �۾� ���� �Ͻ�
        SC_JOB[SC_NO].ID_REGTIME   := SC_JOB[SC_NO].ID_ORDDATE +                // �۾� ��� �ð� ( �۾� ���� ���� + �۾� ���� �Ͻ� )
                                      SC_JOB[SC_NO].ID_ORDTIME ;
        SC_JOB[SC_NO].IO_TYPE      := FieldByName('IO_TYPE'     ).AsString ;    // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
        SC_JOB[SC_NO].LOAD_BANK    := FieldByName('LOAD_BANK'   ).AsString ;    // ���� ��
        SC_JOB[SC_NO].LOAD_BAY     := FieldByName('LOAD_BAY'    ).AsString ;    // ���� ��
        SC_JOB[SC_NO].LOAD_LEVEL   := FieldByName('LOAD_LEVEL'  ).AsString ;    // ���� ��
        SC_JOB[SC_NO].UNLOAD_BANK  := FieldByName('UNLOAD_BANK' ).AsString ;    // �Ͽ� ��
        SC_JOB[SC_NO].UNLOAD_BAY   := FieldByName('UNLOAD_BAY'  ).AsString ;    // �Ͽ� ��
        SC_JOB[SC_NO].UNLOAD_LEVEL := FieldByName('UNLOAD_LEVEL').AsString ;    // �Ͽ� ��
        SC_JOB[SC_NO].SC_STEP      := FieldByName('SC_STEP').AsString ;         // �۾� �ܰ�

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
{*                        STOCK ���̺� ���� �Լ�                              *}
{******************************************************************************}

//==============================================================================
// fnStockInsert : STOCK ��� ������ Update
//==============================================================================
function TfrmSCComm.fnStockUpdateAll(SC_NO: Integer): Boolean;
var
  StrSQL, StrLog, CellStatus, TmpBank, TmpBay, TmpLevel, StrJob : String ;
  ExecNo : Integer ;
begin
  // 0 : ����,     1 : �Ǽ�(��Box)  2 : �Ǽ�(��Box)  3 : ������
  // 4 : �԰���  5 : �����     6 : �����԰�     7 : �����
  Result := False ;
  StrSQL:=''; CellStatus:=''; TmpBank:=''; TmpBay:=''; TmpLevel:='';

  if   UpperCase(SC_JOB[SC_NO].ITM_CD)='EPLT' then CellStatus := '1'
  else                                             CellStatus := '2';

  if      SC_JOB[SC_No].IO_TYPE = 'I' then StrJob := 'Store In '
  else if SC_JOB[SC_No].IO_TYPE = 'O' then StrJob := 'Store Out '
  else if SC_JOB[SC_No].IO_TYPE = 'M' then StrJob := 'Rack To Rack '
  else if SC_JOB[SC_No].IO_TYPE = 'S' then StrJob := 'Station To Station ' ;

  //----------------------------------------------------------------------------
  // �԰� �Ϸ� �϶�
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TBL_LOTNO_INFO Update 4. TT_Order Delete
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'I') or    // �԰� �۾� �Ϸ�
     (SC_JOB[SC_No].IO_TYPE = 'M') then  // RackToRack �۾� �Ϸ�
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
              '    AND ID_BANK   = ''' + Copy(SC_JOB[SC_No].UNLOAD_BANK, 4, 1)  + ''' ' + // �Ͽ� ��
              '    AND ID_BAY    = ''' + Copy(SC_JOB[SC_No].UNLOAD_BAY, 3, 2)   + ''' ' + // �Ͽ� ��
              '    AND ID_LEVEL  = ''' + Copy(SC_JOB[SC_No].UNLOAD_LEVEL, 3, 2) + ''' ' ; // �Ͽ� ��

    TmpBank  := SC_JOB[SC_No].UNLOAD_BANK;
    TmpBay   := SC_JOB[SC_No].UNLOAD_BAY;
    TmpLevel := SC_JOB[SC_No].UNLOAD_LEVEL;
  end else
  //----------------------------------------------------------------------------
  // ��� �Ϸ� �϶�
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
              '    AND ID_BANK   = ''' + Copy(SC_JOB[SC_No].LOAD_BANK, 4, 1)  + ''' ' + // �Ͽ� ��
              '    AND ID_BAY    = ''' + Copy(SC_JOB[SC_No].LOAD_BAY, 3, 2)   + ''' ' + // �Ͽ� ��
              '    AND ID_LEVEL  = ''' + Copy(SC_JOB[SC_No].LOAD_LEVEL, 3, 2) + ''' ' ; // �Ͽ� ��

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
// fnStockUpdate : STOCK �ش� ������ Update
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
// fnStockUpdate : STOCK �ش� ������ Update
//==============================================================================
function TfrmSCComm.fnStockUpdate(SC_No: Integer; FName, FValue: String): Boolean;
var
  StrSQL : string;
begin
  Result := False ;
  StrSQL:='';

  //+++++++++++++
  // �۾�����
  //+++++++++++++
  if FValue='9' then
  begin
    if (SC_JOB[SC_No].IO_TYPE = 'I') then
    begin // �԰� (����)
      FValue := '0';
    end else
    if (SC_JOB[SC_No].IO_TYPE = 'O') then
    begin // ��� (�ķ�Ʈ�� or �Ǽ�)
      if (SC_JOB[SC_No].ITM_CD='EPLT') then FValue := '1' else FValue := '2';
    end;
  end;

  if (SC_JOB[SC_No].IO_TYPE = 'I') then
  begin
    StrSQL := ' UPDATE TT_STOCK ' +
              '    SET ' + FName + '= ''' + FValue + '''  ' +
              '  WHERE ID_HOGI   = ''' + IntToStr(SC_No) + ''' ' +                      // �Ͽ� ȣ��
              '    AND ID_BANK   = ''' + COPY(SC_JOB[SC_No].UNLOAD_BANK,4,1)  + ''' ' + // �Ͽ� ��
              '    AND ID_BAY    = ''' + COPY(SC_JOB[SC_No].UNLOAD_BAY,3,2)   + ''' ' + // �Ͽ� ��
              '    AND ID_LEVEL  = ''' + COPY(SC_JOB[SC_No].UNLOAD_LEVEL,3,2) + ''' ' ; // �Ͽ� ��
  end else
  if (SC_JOB[SC_No].IO_TYPE = 'O') then
  begin
    StrSQL := ' UPDATE TT_STOCK ' +
              '    SET ' + FName + '= ''' + FValue + '''  ' +
              '  WHERE ID_HOGI   = ''' + IntToStr(SC_No) + ''' ' +                      // ���� ȣ��
              '    AND ID_BANK   = ''' + COPY(SC_JOB[SC_No].LOAD_BANK,4,1)  + ''' ' +   // ���� ��
              '    AND ID_BAY    = ''' + COPY(SC_JOB[SC_No].LOAD_BAY,3,2)   + ''' ' +   // ���� ��
              '    AND ID_LEVEL  = ''' + COPY(SC_JOB[SC_No].LOAD_LEVEL,3,2) + ''' ' ;   // ���� ��
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
{*                      �����԰�&����� �� ó�� �Լ�                          *}
{******************************************************************************}

//==============================================================================
// fnCellPosChange : �����԰� & ����� �߻� �� �� ��ġ ����
//==============================================================================
function TfrmSCComm.fnCellPosChange(SC_NO: integer; Flag: String): Boolean;
var
  StrSQL, StrLog, NewPos, Zone : String ;
begin
  Result := False ;

  if Flag = '1' then // �����԰�
  begin
    StrSQL := ' Select WMS_HL.DBO.fn_GetFreeLoc(:type) as NewPos ';
  end else
  if Flag='2' then // ����� :::: ������
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
                      ' | �����԰� �Ͽ���ġ ���� ���� ' +
                      ' | �Ͽ���ġ- ' + SC_JOB[SC_NO].UNLOAD_BANK  +  // ���� �Ͽ� ��
                      '-'           + SC_JOB[SC_NO].UNLOAD_BAY     +  // ���� �Ͽ� ��
                      '-'           + SC_JOB[SC_NO].UNLOAD_LEVEL   +  // ���� �Ͽ� ��
                      ' -> '        +
                      ' | ������ġ- ' + FormatFloat('0000',StrToInt(Copy(NewPos,1,1))) + // ���� �Ͽ� ��
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,2,2))) + // ���� �Ͽ� ��
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,4,2))) ; // ���� �Ͽ� ��
          end else
          if Flag='2' then
          begin
            fnOrder_Update(SC_NO, 'SRCAISLE', FormatFloat('0000',StrToInt(Copy(NewPos,1,1)))) ;
            fnOrder_Update(SC_NO, 'SRCBAY'  , FormatFloat('0000',StrToInt(Copy(NewPos,2,2)))) ;
            fnOrder_Update(SC_NO, 'SRCLEVEL', FormatFloat('0000',StrToInt(Copy(NewPos,4,2)))) ;

            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | ����� ������ġ ���� ���� ' +
                      ' | ������ġ- ' + SC_JOB[SC_NO].LOAD_BANK  +  // ���� ���� ��
                      '-'           + SC_JOB[SC_NO].LOAD_BAY     +  // ���� ���� ��
                      '-'           + SC_JOB[SC_NO].LOAD_LEVEL   +  // ���� ���� ��
                      ' -> '        +
                      ' | ������ġ- ' + FormatFloat('0000',StrToInt(Copy(NewPos,1,1))) + // ���� ���� ��
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,2,2))) + // ���� ���� ��
                      '-'           + FormatFloat('0000',StrToInt(Copy(NewPos,4,2))) ; // ���� ���� ��

          end;
          DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
          Result := True ;
        end else
        begin
          if Flag='1' then
          begin
            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | �����԰� �Ͽ���ġ ���� ���� ' +
                      ' | �Ͽ���ġ- ' + SC_JOB[SC_NO].UNLOAD_BANK    +  // ���� �Ͽ� ��
                      '-'           + SC_JOB[SC_NO].UNLOAD_BAY     +  // ���� �Ͽ� ��
                      '-'           + SC_JOB[SC_NO].UNLOAD_LEVEL   ;  // ���� �Ͽ� ��
                              end else
          if Flag='2' then
          begin
            StrLog := ' COMD SC'+IntToStr(SC_No)+
                      ' | ����� ������ġ ���� ���� ' +
                      ' | ������ġ- ' + SC_JOB[SC_NO].LOAD_BANK    +  // ���� ���� ��
                      '-'         + SC_JOB[SC_NO].LOAD_BAY     +  // ���� ���� ��
                      '-'         + SC_JOB[SC_NO].LOAD_LEVEL   ;  // ���� ���� ��
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
// fnOrder_Cancel : �۾� ��� �� Order ����
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
                  ' | �۾����� �ܰ�[1]   ' +
                  '| ORDER ���� ����' +
                  ' | ORD_IDX- ' + LUGG +
                  ' | ORD_DATE- '+ Copy(REG_TIME,1,8) +
                  ' | ORD_TIME- '+ Copy(REG_TIME,9,6) ;
        DisplayLog(SC_NO, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end else
      begin
        StrLog := ' COMD SC'+IntToStr(SC_No)+
                  ' | �۾����� �ܰ�[1]   ' +
                  '| ORDER ���� ����' +
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
                  ' | �۾����� �ܰ�[2]   ' +
                  '| SCIO ���� ����' ;
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
// SetJobOrder [�԰����� ������ ����]
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
// SetAcsResponse [ACS ���� ���� ������ ����]
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
// GetJobNo [�۾���ȣ ����]
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

  //�ߺ� ���� ���� �ڵ� �κ�
 CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, 1, 'RCP_SC');
  if GetlastError = ERROR_ALREADY_EXISTS then halt;

end.

