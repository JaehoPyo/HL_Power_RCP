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
    edt_InReady1: TEdit;
    edt_Double: TEdit;
    Panel25: TPanel;
    edt_OutReady1: TEdit;
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
    Panel31: TPanel;
    edt_InReady3: TEdit;
    edt_InReady2: TEdit;
    Panel34: TPanel;
    Panel38: TPanel;
    edt_OutReady3: TEdit;
    edt_OutReady2: TEdit;
    Panel40: TPanel;
    Panel32: TPanel;
    edt_Fire1: TEdit;
    edt_Fire2: TEdit;
    Panel39: TPanel;
    Panel41: TPanel;
    edt_Fire5: TEdit;
    edt_Fire3: TEdit;
    Panel42: TPanel;
    Panel43: TPanel;
    edt_Fire6: TEdit;
    edt_Fire4: TEdit;
    Panel44: TPanel;
    Panel45: TPanel;
    edt_Curtain1: TEdit;
    edt_Curtain2: TEdit;
    Panel46: TPanel;
    Panel47: TPanel;
    edt_Curtain5: TEdit;
    edt_Curtain3: TEdit;
    Panel48: TPanel;
    Panel49: TPanel;
    edt_Curtain6: TEdit;
    edt_Curtain4: TEdit;
    Panel50: TPanel;
    Bevel3: TBevel;
    qryHis: TADOQuery;
    qryRfid: TADOQuery;
    Bevel4: TBevel;
    Panel51: TPanel;
    edt_In_RfRead1: TEdit;
    edt_Ot_RfRead1: TEdit;
    Panel52: TPanel;
    Panel53: TPanel;
    edt_In_RfRead3: TEdit;
    edt_In_RfRead2: TEdit;
    Panel54: TPanel;
    Panel55: TPanel;
    edt_Ot_RfRead3: TEdit;
    edt_Ot_RfRead2: TEdit;
    Panel56: TPanel;
    Bevel5: TBevel;
    Panel57: TPanel;
    edt_CurtainW_5: TEdit;
    Panel58: TPanel;
    edt_CurtainW_2: TEdit;
    Panel59: TPanel;
    edt_CurtainW_6: TEdit;
    Panel60: TPanel;
    edt_CurtainW_1: TEdit;
    edt_CurtainW_3: TEdit;
    Panel61: TPanel;
    edt_CurtainW_4: TEdit;
    Panel62: TPanel;
    Bevel6: TBevel;
    Panel63: TPanel;
    edt_RfReadW_5: TEdit;
    Panel64: TPanel;
    edt_RfReadW_2: TEdit;
    Panel65: TPanel;
    edt_RfReadW_6: TEdit;
    Panel66: TPanel;
    edt_RfReadW_1: TEdit;
    edt_RfReadW_3: TEdit;
    Panel67: TPanel;
    edt_RfReadW_4: TEdit;
    Panel68: TPanel;
    GroupBox1: TGroupBox;
    Panel70: TPanel;
    edt_Docking6: TEdit;
    Panel72: TPanel;
    edt_Docking5: TEdit;
    edt_Docking4: TEdit;
    Panel73: TPanel;
    edt_Docking3: TEdit;
    Panel76: TPanel;
    edt_Docking1: TEdit;
    Panel77: TPanel;
    edt_Docking2: TEdit;
    Panel78: TPanel;
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
    procedure PLC_WriteDisplay;

    function  fnSignalMsg(Signal:string): String;                               // �ñ׳� �޽���
    function  fnModeMsg(Signal:string): String;                                 // ��� �޽���

    function  fnSignalFontColor(Signal,Flag: string): TColor;                   // �ñ׳� ��Ʈ ����
    function  fnSignalEditColor(Signal,Flag: string): TColor;                   // �ñ׳� ����Ʈ����

    // �۾� ó�� ���� �Լ�
    function  GetJobNo(Gubn: String) : Integer;                                 // �۾���ȣ ����
    function  SCNowStatusUpdate(SC_NO:Integer; Status: String): Boolean ;
    function  SCNowCycleUpdate(SC_NO:Integer; Cycle: String): Boolean ;

    function  fnGetSCSetInfo(SC_NO:Integer; GetField:String): Boolean ;         // SC ���� ���� Get (Ȩ����,�۾����..)
    function  fnGetSCSetLUGG(SC_NO:Integer; GetField:String): String ;          // SC ���� ���� Get (Ȩ����,�۾����..)
    function  fnSetSCSetInfo(SC_NO:Integer; SetField,SetValue:String): Boolean ;// SC ���� ���� SET (0:OFF,1:ON)

    function  fnSetSCSetInfo_Clear(SC_NO:Integer): Boolean ;                    // SC ���� ���� �ʱ�ȭ (All OFF)
    function  fnSetSCSetInfo_Clear2(SC_NO:Integer): Boolean ;                   // ����͸� �۾�ó�� ���� �ʱ�ȭ (All OFF)

    function  SetJobOrder(PortNo: Integer; Gubn, ItemCode, NOWMC, EMG: String) : String;

    // ACS ����
    procedure GetACS_Status(PortNo: Integer);                                   // ACS ���°�����
    procedure ACSControlProcess(SC_NO: Integer);                                // ACS ����ó��
    function  SetAcsResponse(PortNo: Integer) : Boolean;
    procedure fnACS_Update(PortNo: Integer; Gubn, FName, FValue: String);

    function  fnGetSCStatus(Src:TScStatus): String ;                            // SC ���¸޽��� Get (����)
    function  fnGetSCStatus2(Src:TScStatus): String ;                           // SC ���¸޽��� Get (�ѱ�)

    function  fnGetSCCmdType(IO_TYPE:String): String ;                          // SC �۾�Ÿ�� ID Get (Ȯ���ʿ�)
    function  fnGetCVStatus(SC_NO:Integer; BuffNo,GetField:String ): Boolean ;  // CV ��&���� ȭ��,����,�������� Get
    function  fnSetWriteInfo(SC_NO:Integer;Job_Type:String): Boolean;           // SC ���� ������ SET
    function  fnSetSCORDWrite(SC_NO: Integer; Flag: String): Boolean;           // SC ���� ������ INSERT
    function  fnSetPLCWriteInfo: Boolean;                                       // PLC ���� ������ SET
    function  fnSetPLCORDWrite(PLC_NO: Integer; Flag: String): Boolean;         // PLC ���� ������ INSERT
    function  fnGetSCJOB(SC_NO:Integer;JFlag:TSCJobMode): Boolean ;             // SC �۾� �˻�
    function  fnChkSCJOB(SC_NO:Integer): Boolean ;                              // SC �۾� üũ
    function  fnGetCVOrderStr(SC_NO: Integer; IO: String) : String;             // TT_ORDER CVCURR ���� ����
    function  fnGetRFID_Data(PortNo: Integer; FName: String): String;           // TC_RFID ������ ������

    // ORDER ���̺� ���� �Լ�
    function  fnOrder_Value(SC_No: Integer; FName : String): String; overload;    // ORDER ������ Get
    function  fnOrder_Value(WhereStr: String; FName : String) : String; overload;
    function  fnOrder_Cancel(SC_No: Integer; LUGG, REG_TIME: String): Boolean;    // ORDER ������ Delete(�۾���� ��)
    function  fnOrder_Delete(SC_No: Integer): Boolean; overload;                  // ORDER ������ Delete (Ȯ���ʿ�)
    function  fnOrder_Delete(JobNo: String): Boolean; overload;
    function  fnOrder_Update(SC_No: Integer; FName,FValue: String):Boolean; overload ; // ORDER ������ Update (Value1��)
    function  fnOrder_Update(SC_No: Integer; FName1, FValue1, FName2, FValue2: String):Boolean; overload ; // ORDER ������ Update (Value2��)
    function  fnOrder_Update(JobNo, FName, FValue:String):Boolean; overload ;
    function  fnOrder_RfidUpdate(JobNo: String; RfidData: TRFID_Data): Boolean;

    // PLC_BIT_Write
    procedure PLC_BIT_Write;

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
    function  fnGetStockCount(ItemCode: String): Integer;                          // ǰ�� ���� ��ȯ
    function  fnIsCellEmpty: Boolean;                                              // â�� �ڸ� �ִ��� ����
    function  fnGetCellCount(Status: String): Integer;                             // â�� �� ĭ ���� ��ȯ

    function  fnGet_Current(Cur_Name: String): Boolean; overload;
    function  fnGet_Current(Cur_Name, FName: String): Integer; overload;
    procedure fnSet_Current(Cur_Name, FName, FValue : String);

    // TM_ITEM ���̺� ���� �Լ�
    function fnITEM_Value(SC_No: Integer; FName, FValue : String): String;

    // �����԰�&����� �� ó�� �Լ�
    function  fnCellPosChange(SC_NO:integer; Flag:String): Boolean;               // ���ο� Postion ��ȯ

    // �� �� ã��
    function  fnGetFreeLoc : String;

    // TT_ORDER�� �����丮�� ����
    procedure fnIns_History(Line_No: Integer); overload;
    procedure fnIns_History(JobNo: String); overload;

    // TC_RFID�� TC_RFID_HIST�� ����
    procedure fnIns_RfidHistory(Line_No: Integer);

    // Log ó�� ���� �Լ�
    procedure ErrorLogWRITE(WRITEStr : String);                                 // �����α� ����
    procedure DisplayLog(SC_NO:Integer;Msg, SR_Type: String; Len:Integer);      // �α� ǥ�� �� ����

    // Error ó�� ���� �Լ�
    function  fnGetErrMsg(MC:String; SC_NO: integer; GetField,ErrCode: String): String;        // �����޽��� Get
    function  fnSetMachError(SC_NO:Integer; ErrorCode:String): Boolean ;            // ���� ���� Update (TT_ORDER)
    function  fnSetErrReport(MC:String; SC_NO:Integer; ErrorCode:String): Boolean ; // ���� ����&���۽ð� ��� (TT_ERROR)
    function  fnReSetErrReport(MC:String; SC_NO:Integer): Boolean;                  // ���� ����ð� ��� (TT_ERROR)
    function  fnGetErrReport(SC_NO:Integer): Boolean; overload ;                    // ������ ���� ��� üũ (TT_ERROR) -> ������ �����Ű�� ����
    function  fnGetErrReport(MC:String; SC_NO:Integer; ErrorCode: String): Boolean; overload ; // �߻��� ���� ��� üũ (TT_ERROR) -> ������ �ȳֱ� ����
    function  fnSetOrderError(LineNo: Integer; Error: String): Boolean;

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
  PLC_WRITE_FLAG  : TCONTROL_FLAG;

  PLC_ORDER : TPLC_ORDER;
  RFID_Data : TRFID_DATA;
  Rx_AcsData : Array [1..6] of TRx_AcsData;
  Tx_AcsData : Array [1..6] of TTx_AcsData;
  PLC_WriteVal : TPLC_VAL;
  RFID_Clear : Array[1..6] of Boolean;
  RFID_Read_REQ : Array[1..6] of Boolean;
  PLC_ReadVal : TPLC_VAL;
  OrderData : TJobOrder;
  IsStartUp : Boolean;
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
  ActivePCAddr := SysGetLocalIp(1);   // PC Ip-Address

  IsStartUp := True;

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
  for i := 1 to 6 do
  begin
    PLC_WriteVal.Curtain[i] := '0';
    PLC_WriteVal.RFID_Read[i] := '0';
  end;

  if ADOConnection then
  begin
    fnCreateSet ;
    sbtClick(sbtStart) ;  // �ڵ�����
    fnSet_Current('RCP', 'OPTION1', '1');
    ShpCon.Brush.Color := clLime;
  end else
  begin
    ShpCon.Brush.Color := clRed;
    Exit;
  end;
  InsertPGMHist('[RCP]', 'N', 'FormShow', '����', '', 'PGM', '', '', '');
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
// ACS ���� ������
//==============================================================================
procedure TfrmSCComm.GetACS_Status(PortNo: Integer);
var
  StrSQL : String;
begin

  // RFID Read Data Check
  with qryACS do
  begin
    Close;
    SQL.Clear;
    StrSQL := ' SELECT TOP 1 * ' +
              '   FROM TC_ACS_COMM ' +
              '  WHERE GUBN = ''RECV'' ' +
              '    AND PORT_NO = ' + QuotedStr(IntToStr(PortNo)) +
              '  ORDER BY UPD_DT ';
    SQL.Text := StrSQL;
    Open;

    if not (BOF and EOF) then
    begin
      Rx_AcsData[PortNo].Heart_Beat       := FieldByName('HEART_BEAT').AsString;
      Rx_AcsData[PortNo].Line_Name_Source := FieldByName('LINE_NAME_SOURCE').AsString;
      Rx_AcsData[PortNo].Line_No_Source   := FieldByName('LINE_NO_SOURCE').AsString;
      Rx_AcsData[PortNo].Port_No_Source   := FieldByName('PORT_NO_SOURCE').AsString;
      Rx_AcsData[PortNo].Line_Name_Dest   := FieldByName('LINE_NAME_DEST').AsString;
      Rx_AcsData[PortNo].Line_No_Dest     := FieldByName('LINE_NO_DEST').AsString;
      Rx_AcsData[PortNo].Port_No_Dest     := FieldByName('PORT_NO_DEST').AsString;
      Rx_AcsData[PortNo].Model_No         := FieldByName('MODEL_NO').AsString;
      Rx_ACSData[PortNo].Call_Request     := FieldByName('CALL_REQUEST').AsString;
      Rx_ACSData[PortNo].Call_Answer      := FieldByName('CALL_ANSWER').AsString;
      Rx_ACSData[PortNo].Docking_Request  := FieldByName('DOCKING_REQ_APPR').AsString;
      Rx_ACSData[PortNo].Docking_Complete := FieldByName('DOCKING_COMPLETE').AsString;
    end;
  end;
end;

//==============================================================================
// ACSControlProcess ACS ���� ó��
//==============================================================================
procedure TfrmSCComm.ACSControlProcess(SC_NO: Integer);
var
  i, Curtain_Param : Integer;
  NewJobNo, JobNo, WhereStr : String;
  ItemCode, RfidData, LogStr: String;
  HasEmptyCell, HasStock, RfidCheck, IsExist : Boolean;
  tRfidData : TRFID_Data;
begin

  for i := START_STATION to END_STATION do
  begin
    // �۷ι� ���� Rx_AcsData[i]�� ����
    GetACS_Status(i);

    // ACS ��û�� �´� ������ �ϰ� ���� ���� ����

    // �԰� ��Ʈ
    if( i in [1, 3, 5]) then
    begin
      // ���� �ڸ��� ���� ���
      if (fnIsCellEmpty) then
      begin
        Tx_AcsData[i].Status := '0';
        HasEmptyCell := True;
      end else
      begin
        Tx_AcsData[i].Status := '1';
        HasEmptyCell := False;
      end;
    end
    // ��� ��Ʈ
    else
    begin
      // â�� �ƿ� ������� ���
      if (fnGetCellCount('0') = 100) then
      begin
        Tx_AcsData[i].Status := '2';
      end else
      begin
        Tx_AcsData[i].Status := '0';
      end;
    end;

    
    //==================================//
    // (AGV�� Ŀư �տ� ��ġ) �԰� �۾� //
    //==================================//
    if (i in [1, 3, 5])                        and
       (Rx_AcsData[i].Model_No         <> '' ) and
       (Rx_AcsData[i].Call_Request     = '1' ) and
       (Rx_AcsData[i].Call_Answer      = '0' ) and
       (Rx_AcsData[i].Docking_Request  = '1' ) and
       (Rx_AcsData[i].Docking_Complete = '0' ) then
    begin

      // �� ���� �ְ� �ش� ���ο� �۾��� ���� �� �۾� ����
      if (HasEmptyCell) then
      begin
        WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                    '   And JOBD    = 1 ' +
                    '   And JOB_END = 0 ' ;
        if (fnOrder_Value(WhereStr, 'LINE_NO') = '') then
        begin
          ItemCode := IfThen(Rx_AcsData[i].Model_No = '0', 'EPLT', 'FULL');

          // �۾�����
          JobNo := SetJobOrder(i, 'I', ItemCode, '4', '0');
          if (JobNo <> '') then
          begin
            // Ŀư ����
            if (PLC_ReadVal.Curtain[i] = '0') then
            begin
              if (PLC_WriteVal.Curtain[i] = '0') then
              begin
                PLC_ORDER.ORDER := '1';
                PLC_WRITE_FLAG := ComWrite;
                fnSet_Current('CUR_PARAM', 'OPTION'+IntToStr(i), '2'); //LHB
              end;
              PLC_WriteVal.Curtain[i] := '1';
            end;
          end;
        end;
      end;

      // Ŀư ���� ���¶�� ���� ����
      if (PLC_ReadVal.Curtain[i] = '1') then
      begin
        // ACS ���� ������ ����
        Tx_AcsData[i].Heart_Beat       := '1';
        Tx_AcsData[i].Line_Name_Source := '';
        Tx_AcsData[i].Line_No_Source   := '';
        Tx_AcsData[i].Port_No_Source   := '';
        Tx_AcsData[i].Line_Name_Dest   := '';
        Tx_AcsData[i].Line_No_Dest     := '';
        Tx_AcsData[i].Port_No_Dest     := '';
        Tx_AcsData[i].Model_No         := '';
        Tx_AcsData[i].Call_Request     := '0';
        Tx_AcsData[i].Call_Answer      := '1';
        Tx_AcsData[i].Docking_Approve  := '1';
        Tx_AcsData[i].Docking_Complete := '0';
      end;
    end else

    //==================================//
    // (AGV�� Ŀư �տ� ��ġ)  ����۾� //
    //==================================//
    if (i in [2, 4, 6] )                       and
       (Rx_AcsData[i].Model_No         <> '' ) and
       (Rx_AcsData[i].Call_Request     = '1' ) and
       (Rx_AcsData[i].Call_Answer      = '0' ) and
       (Rx_AcsData[i].Docking_Request  = '1' ) and
       (Rx_AcsData[i].Docking_Complete = '0' ) then
    begin

      // �ش� AGV�� ����۾��� ���� �� �۾� ����
      WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                  '   And JOBD = ''2'' ';
      if (fnOrder_Value(WhereStr, 'LINE_NO') = '') then
      begin
        ItemCode := IfThen(Rx_AcsData[i].Model_No = '0', 'EPLT', 'FULL');

        if (fnGetStockCount(ItemCode) > 0) then
        begin
          HasStock := True;

          // �۾�����
          JobNo := SetJobOrder(i, 'O', ItemCode, '2', '0');
        end
        // ��� ���� ��
        else
        begin
          HasStock := False;
        end;
      end
      // �۾��� �ִ� ���
      else
      begin
        HasStock := True;
      end;

      // ��� ���� ���
      if not (HasStock) then
      begin
        if (PLC_ReadVal.Curtain[i] = '1') then
        begin
          // ACS ���� ������ ����
          Tx_AcsData[i].Heart_Beat       := '1';
          Tx_AcsData[i].Line_Name_Source := '';
          Tx_AcsData[i].Line_No_Source   := '';
          Tx_AcsData[i].Port_No_Source   := '';
          Tx_AcsData[i].Line_Name_Dest   := '';
          Tx_AcsData[i].Line_No_Dest     := '';
          Tx_AcsData[i].Port_No_Dest     := '';
          Tx_AcsData[i].Model_No         := '';
          Tx_AcsData[i].Call_Request     := '0';
          Tx_AcsData[i].Call_Answer      := '2';
          Tx_AcsData[i].Docking_Approve  := '0';
          Tx_AcsData[i].Docking_Complete := '0';
        end;
      end
      // ��� �־ ������� �� ���, ��� �Ϸ� �� ����
      else
      begin
        JobNo := '';
        // �ش� ������ ��� �Ϸ�� �۾��� ã�ƿ�.
        WhereStr := ' Where JOBD      = ''2'' ' +
                      ' And NOWMC     = ''3'' ' +
                      ' And NOWSTATUS = ''4'' ' +
                      ' And JOBSTATUS = ''4'' ' +
                      ' And JOB_END   = ''0'' ' +
                      ' And LINE_NO   = ' + QuotedStr(IntToStr(i)) +
                    ' Order By REG_TIME Desc ' ;
        ItemCode := fnOrder_Value(WhereStr, 'ITM_CD');
        JobNo := fnOrder_Value(WhereStr, 'LUGG');

        // ��� �� ��쿡�� ����
        if (JobNo <> '') then
        begin
          // Ŀư ����
          if (PLC_ReadVal.Curtain[i] = '0') then
          begin
            if (PLC_WriteVal.Curtain[i] = '0') then
            begin
              PLC_ORDER.ORDER := '1';
              PLC_WRITE_FLAG := ComWrite;
              fnSet_Current('CUR_PARAM', 'OPTION'+IntToStr(i), '2'); //LHB
            end;
            PLC_WriteVal.Curtain[i] := '1';
          end;

          if (PLC_WriteVal.RFID_Read[i] = '0') then
          begin
            PLC_WriteVal.RFID_Read[i] := '1';
            PLC_ORDER.ORDER := '1';
            PLC_WRITE_FLAG := ComWrite;
          end else
          if (PLC_ReadVal.RFID_Read[i] = '1') then
          begin

            // RFID �ʱ�ȭ
            if (PLC_WriteVal.RFID_Read[i] = '1') and
               (PLC_ReadVal.RFID_Read[i] = '1')  then
            begin
              PLC_WriteVal.RFID_Read[i] := '0';
              PLC_ORDER.ORDER := '1';
              PLC_WRITE_FLAG := ComWrite;
            end;

            if (Rx_AcsData[i].Model_No = '0') then
            begin
              if (fnGetRFID_Data(i, 'H18') = '0') then
              begin
                RfidCheck := True;
              end else
              begin
                RfidCheck := False;
              end;
            end else
            if (Rx_AcsData[i].Model_No = '1') then
            begin
              if (fnGetRFID_Data(i, 'H18') = '36') then
              begin
                RfidCheck := True;
              end else
              begin
                RfidCheck := False;
              end;
            end;

            // RFID�� �߸� �� ���.
            if not (RfidCheck) then
            begin
              // TT_ORDER�� ���� ǥ��
              if (fnOrder_Value(WhereStr, 'JOBERRORC') <> '1') then
              begin
                fnOrder_Update(JobNo, 'JOBERRORC', '1');
                fnOrder_Update(JobNo, 'JOBERRORT', 'R');
                fnOrder_Update(JobNo, 'JOBERRORD', 'RFID ����ġ');
              end;
            end
            // RFID�� ������ ���
            else
            begin

              fnOrder_Update(JobNo, 'NOWMC', '4');

              // Ŀư ���� ����
              if (PLC_ReadVal.Curtain[i] = '1') then
              begin
                // ACS ���� ������ ����
                Tx_AcsData[i].Heart_Beat       := '1';
                Tx_AcsData[i].Line_Name_Source := '';
                Tx_AcsData[i].Line_No_Source   := '';
                Tx_AcsData[i].Port_No_Source   := '';
                Tx_AcsData[i].Line_Name_Dest   := '';
                Tx_AcsData[i].Line_No_Dest     := '';
                Tx_AcsData[i].Port_No_Dest     := '';
                Tx_AcsData[i].Model_No         := '';
                Tx_AcsData[i].Call_Request     := '0';
                Tx_AcsData[i].Call_Answer      := '1';
                Tx_AcsData[i].Docking_Approve  := '1';
                Tx_AcsData[i].Docking_Complete := '0';
              end;
            end;
          end;
        end;
      end;
    end;

    //==================//
    // ��/��� ����κ� //
    //==================//
    // *** �������̽� ���� *** //
    if (Rx_AcsData[i].Call_Request     = '1' ) and
       (Rx_AcsData[i].Call_Answer      = '0' ) and
       (Rx_AcsData[i].Docking_Request  = '0' ) and
       (Rx_AcsData[i].Docking_Complete = '0' ) then
    begin
      // ����� ��� ǰ���� �ִ��� Ȯ��
      // ������ CallAnswer = 2
      if (i in [2, 4, 6]) then
      begin
        ItemCode := IfThen(Rx_AcsData[i].Model_No = '1', 'FULL', 'EPLT');
        if (fnGetStockCount(ItemCode) > 0) then
        begin
          Tx_AcsData[i].Call_Answer := '1';
        end else
        begin
          Tx_AcsData[i].Call_Answer := '2';
        end;
      end else
      begin
        Tx_AcsData[i].Call_Answer := '1';
      end;

      // ACS ���� ������ ����
      Tx_AcsData[i].Heart_Beat       := '1';
      Tx_AcsData[i].Line_Name_Source := '';
      Tx_AcsData[i].Line_No_Source   := '';
      Tx_AcsData[i].Port_No_Source   := '';
      Tx_AcsData[i].Line_Name_Dest   := '';
      Tx_AcsData[i].Line_No_Dest     := '';
      Tx_AcsData[i].Port_No_Dest     := '';
      Tx_AcsData[i].Model_No         := '';
      Tx_AcsData[i].Call_Request     := '0';
//      Tx_AcsData.Call_Answer      := '1';
      Tx_AcsData[i].Docking_Approve  := '0';
      Tx_AcsData[i].Docking_Complete := '0';
    end else
    // *** ��ŷ �Ϸ� *** //
    if (Rx_AcsData[i].Call_Request     = '0' ) and
       (Rx_AcsData[i].Call_Answer      = '0' ) and
       (Rx_AcsData[i].Docking_Request  = '1' ) and
       (Rx_AcsData[i].Docking_Complete = '0' ) then
    begin
      // Ŀư ����
      if (PLC_ReadVal.Curtain[i] = '0') then
      begin
        if (PLC_WriteVal.Curtain[i] = '0') then
        begin
          PLC_ORDER.ORDER := '1';
          PLC_WRITE_FLAG := ComWrite;
          fnSet_Current('CUR_PARAM', 'OPTION'+IntToStr(i), '2'); //LHB
        end;
        PLC_WriteVal.Curtain[i] := '1';
      end;

      // Ŀư�� ���� ���� ������ ����
      if (PLC_ReadVal.Curtain[i] = '1') then
      begin
        // ACS ���� ������ ����
        Tx_AcsData[i].Heart_Beat       := '1';
        Tx_AcsData[i].Line_Name_Source := '';
        Tx_AcsData[i].Line_No_Source   := '';
        Tx_AcsData[i].Port_No_Source   := '';
        Tx_AcsData[i].Line_Name_Dest   := '';
        Tx_AcsData[i].Line_No_Dest     := '';
        Tx_AcsData[i].Port_No_Dest     := '';
        Tx_AcsData[i].Model_No         := '';
        Tx_AcsData[i].Call_Request     := '0';
        Tx_AcsData[i].Call_Answer      := '0';
        Tx_AcsData[i].Docking_Approve  := '1';
        Tx_AcsData[i].Docking_Complete := '0';
      end;
    end else
    // *** ���繰�� AGV���� ����� �̵��� ����, ���� ��û *** //
    // *** ���繰�� ���񿡼� AGV�� �̵��� ����, ���� ��û *** //
    if (Rx_AcsData[i].Call_Request     = '0' ) and
       (Rx_AcsData[i].Call_Answer      = '0' ) and
       (Rx_AcsData[i].Docking_Request  = '1' ) and
       (Rx_AcsData[i].Docking_Complete = '1' ) then
    begin

      // Ŀư ����
      if (PLC_ReadVal.Curtain[i] = '0') then
      begin
        if (PLC_WriteVal.Curtain[i] = '0') then
        begin
          PLC_ORDER.ORDER := '1';
          PLC_WRITE_FLAG := ComWrite;
          fnSet_Current('CUR_PARAM', 'OPTION'+IntToStr(i), '2'); //LHB
        end;
        PLC_WriteVal.Curtain[i] := '1';
      end;

      // Ŀư�� ���� ���� ������ ����
      if (PLC_ReadVal.Curtain[i] = '1') then
      begin
        // ACS ���� ������ ����
        Tx_AcsData[i].Heart_Beat       := '1';
        Tx_AcsData[i].Line_Name_Source := '';
        Tx_AcsData[i].Line_No_Source   := '';
        Tx_AcsData[i].Port_No_Source   := '';
        Tx_AcsData[i].Line_Name_Dest   := '';
        Tx_AcsData[i].Line_No_Dest     := '';
        Tx_AcsData[i].Port_No_Dest     := '';
        Tx_AcsData[i].Model_No         := '';
        Tx_AcsData[i].Call_Request     := '0';
        Tx_AcsData[i].Call_Answer      := '0';
        Tx_AcsData[i].Docking_Approve  := '1';
        Tx_AcsData[i].Docking_Complete := '1';
      end;
    end else
    // *** ����Ϸ�, �ʱ���·� ���ư�... *** //
    if (Rx_AcsData[i].Call_Request     = '0' ) and
       (Rx_AcsData[i].Call_Answer      = '0' ) and
       (Rx_AcsData[i].Docking_Request  = '0' ) and
       (Rx_AcsData[i].Docking_Complete = '0' ) then
    begin

      JobNo := '';
      IsExist := False;
      case i of
        1 : IsExist := Boolean(SC_STATUS[SC_NO].D211[08] = '1');
        2 : IsExist := Boolean(SC_STATUS[SC_NO].D211[09] = '1');
        3 : IsExist := Boolean(SC_STATUS[SC_NO].D211[10] = '1');
        4 : IsExist := Boolean(SC_STATUS[SC_NO].D211[11] = '1');
        5 : IsExist := Boolean(SC_STATUS[SC_NO].D211[12] = '1');
        6 : IsExist := Boolean(SC_STATUS[SC_NO].D211[13] = '1');
      end;
      // �԰� ST�̰�, �����̼ǿ� ȭ���� ������ RFID�а� �Ϸ�
      if (i in [1, 3, 5]) then
      begin

        JobNo := '';
        WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(i)) +
                        '   And JOBD    = ''1'' ' +
                        '   And JOB_END = ''0'' ' +
                        '   And IS_AUTO = ''Y'' ' +
                        '   And NOWMC   = ''4'' ';
        JobNo := fnOrder_Value(WhereStr, 'LUGG');
        ItemCode := fnOrder_Value(WhereStr, 'ITM_CD');
        if (JobNo <> '') and
           (IsExist = True) then
        begin
          if (PLC_ReadVal.RFID_Read[i] = '0') and
             (PLC_WriteVal.RFID_Read[i] = '0') then
          begin
            PLC_WriteVal.RFID_Read[i] := '1';
            PLC_ORDER.ORDER := '1';
            PLC_WRITE_FLAG := ComWrite;
          end else
          if (PLC_ReadVal.RFID_Read[i] = '1') then
          begin
            // RFID �ʱ�ȭ
            if (PLC_WriteVal.RFID_Read[i] = '1') and
               (PLC_ReadVal.RFID_Read[i] = '1')  then
            begin
              PLC_WriteVal.RFID_Read[i] := '0';
              PLC_ORDER.ORDER := '1';
              PLC_WRITE_FLAG := ComWrite;

              fnIns_RfidHistory(i);
            end;

            if (ItemCode = 'EPLT') then
            begin
              if (fnGetRFID_Data(i, 'H18') = '0') then
              begin
                RfidCheck := True;
              end else
              begin
                RfidCheck := False;
              end;
            end else
            if (ItemCode = 'FULL') then
            begin
              if (fnGetRFID_Data(i, 'H18') = '36') then
              begin
                RfidCheck := True;
              end else
              begin
                RfidCheck := False;
              end;
            end;

            if (RfidCheck = True) then
            begin
              tRfidData.Line_Name_1 := fnGetRFID_Data(i, 'H00');
              tRfidData.Line_Name_2 := fnGetRFID_Data(i, 'H01');
              tRfidData.Pallet_No_1 := fnGetRFID_Data(i, 'H02');
              tRfidData.Pallet_No_2 := fnGetRFID_Data(i, 'H03');
              tRfidData.Model_No_1  := fnGetRFID_Data(i, 'H16');
              tRfidData.Model_No_2  := fnGetRFID_Data(i, 'H17');
              tRfidData.BMA_No      := fnGetRFID_Data(i, 'H18');
              tRfidData.Cell_Production := fnGetRFID_Data(i, 'H19');
              tRfidData.BMA_1       := fnGetRFID_Data(i, 'H20');
              tRfidData.BMA_2       := fnGetRFID_Data(i, 'H21');
              tRfidData.BMA_3       := fnGetRFID_Data(i, 'H22');
              fnOrder_RfidUpdate(JobNo, tRfidData);

              // AGV �۾� �Ϸ�
              fnOrder_Update(JobNo, 'NOWSTATUS', '4') ;
              fnOrder_Update(JobNo, 'JOBSTATUS', '4') ;
            end else
            begin
              if (JobNo <> '') then
              begin
                // TT_ORDER�� ���� ǥ��
                if (fnOrder_Value(WhereStr, 'JOBERRORC') <> '1') then
                begin
                  fnOrder_Update(JobNo, 'JOBERRORC', '1');
                  fnOrder_Update(JobNo, 'JOBERRORT', 'R');
                  fnOrder_Update(JobNo, 'JOBERRORD', 'RFID ����ġ');
                end;
              end;
            end;
          end;
        end;
      end;


      // ����۾��̸� HISTORY �̵�
      // ���Ϸ�
      if (i in [2, 4, 6]) then
      begin
        JobNo := '';
        WhereStr := ' Where JOBD      = ''2'' ' +
                      ' And NOWMC     = ''4'' ' +
                      ' And NOWSTATUS = ''4'' ' +
                      ' And JOBSTATUS = ''4'' ' +
                      ' And JOB_END   = ''0'' ' +
                      ' And LINE_NO   = ' + QuotedStr(IntToStr(i));
        JobNo := fnOrder_Value(WhereStr, 'LUGG');
        if (JobNo <> '') then
        begin
          fnOrder_Update(JobNo, 'JOB_END', '1');
          fnIns_History(i);
        end;
      end;

      // �۾� ���� RFID ���� �����ΰ�� �ʱ�ȭ
      if (JobNo = '') and
         (not IsExist) then
      begin
        // RFID �ʱ�ȭ
        if (PLC_WriteVal.RFID_Read[i] = '1') and
           (PLC_ReadVal.RFID_Read[i] = '1')  then
        begin
          PLC_WriteVal.RFID_Read[i] := '0';
          PLC_ORDER.ORDER := '1';
          PLC_WRITE_FLAG := ComWrite;

          fnIns_RfidHistory(i);
        end;
      end;

      //LHB
      if fnGet_Current('CUR_PARAM','OPTION'+IntToStr(i)) <> 1 then
      begin
        // Ŀư ����
        if (PLC_ReadVal.Curtain[i] = '1') then
        begin
          if PLC_WriteVal.Curtain[i] = '1' then
          begin
            PLC_ORDER.ORDER := '1';
            PLC_WRITE_Flag := ComWrite;
            fnSet_Current('CUR_PARAM', 'OPTION'+IntToStr(i), '0');
          end;
          PLC_WriteVal.Curtain[i] := '0';
        end;
      end;

      // ACS ���� ������ ����
      Tx_AcsData[i].Heart_Beat       := '1';
      Tx_AcsData[i].Line_Name_Source := '';
      Tx_AcsData[i].Line_No_Source   := '';
      Tx_AcsData[i].Port_No_Source   := '';
      Tx_AcsData[i].Line_Name_Dest   := '';
      Tx_AcsData[i].Line_No_Dest     := '';
      Tx_AcsData[i].Port_No_Dest     := '';
      Tx_AcsData[i].Model_No         := '';
      Tx_AcsData[i].Call_Request     := '0';
      Tx_AcsData[i].Call_Answer      := '0';
      Tx_AcsData[i].Docking_Approve  := '0';
      Tx_AcsData[i].Docking_Complete := '0';
    end;
    SetAcsResponse(i);
  end; // end for statement
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
    if MainDM.MainDB.Connected then
    begin
      fnSet_Current('RCP', 'OPTION1', '0');
      fnSetSCSetInfo(i, 'PROGRAM_START', '0') ;
      fnSetSCSetInfo(i, 'PROGRAM_END'  , '1') ;
    end;
  end;

  InsertPGMHist('[RCP]', 'N', 'FormClose', '����', '', 'PGM', '', '', '');

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

      PLC_BIT_Write;

      SCTWRITE(xMCNo);

      PLC_WriteDisplay;
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
  if (StrToInt(SC_STATUS[SC_NO].D205) > 29) and
     (StrToInt(SC_STATUS[SC_NO].D205) < 42) then
  begin
    TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := fnGetErrMsg('PLC', SC_NO, 'ERR_NAME', SC_STATUS[SC_NO].D205);  // �̻󳻿�
  end else
  begin
    TEdit(Self.FindComponent('edt_ErrorDesc'    )).Text := fnGetErrMsg('SC', SC_NO, 'ERR_NAME', SC_STATUS[SC_NO].D205);  // �̻󳻿�
  end;



  //++++++++++++++++++++++++++++++++++++++++++++
  // ���°� ǥ�� (D210.00 ~ D213.15)
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
  TEdit(Self.FindComponent('edt_InReady1'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[08]); // �԰���
  TEdit(Self.FindComponent('edt_OutReady1'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[09]); // �����
  TEdit(Self.FindComponent('edt_InReady2'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[10]); // �԰���
  TEdit(Self.FindComponent('edt_OutReady2'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[11]); // �����
  TEdit(Self.FindComponent('edt_InReady3'     )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[12]); // �԰���
  TEdit(Self.FindComponent('edt_OutReady3'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D211[13]); // �����
  // D212.00 ~ D212.15
  TEdit(Self.FindComponent('edt_Curtain1'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[00]); // ����ƮĿư1
  TEdit(Self.FindComponent('edt_Curtain2'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[01]); // ����ƮĿư2
  TEdit(Self.FindComponent('edt_Curtain3'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[02]); // ����ƮĿư3
  TEdit(Self.FindComponent('edt_Curtain4'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[03]); // ����ƮĿư4
  TEdit(Self.FindComponent('edt_Curtain5'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[04]); // ����ƮĿư5
  TEdit(Self.FindComponent('edt_Curtain6'    )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[05]); // ����ƮĿư6
  TEdit(Self.FindComponent('edt_Fire1'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[10]); // ȭ��溸��1
  TEdit(Self.FindComponent('edt_Fire2'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[11]); // ȭ��溸��2
  TEdit(Self.FindComponent('edt_Fire3'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[12]); // ȭ��溸��3
  TEdit(Self.FindComponent('edt_Fire4'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[13]); // ȭ��溸��4
  TEdit(Self.FindComponent('edt_Fire5'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[14]); // ȭ��溸��5
  TEdit(Self.FindComponent('edt_Fire6'       )).Text := fnSignalMsg(SC_STATUS[SC_NO].D212[15]); // ȭ��溸��6
  // D213.00 ~ D213.15
  TEdit(Self.FindComponent('edt_In_RfRead1'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[00]); // �԰�ST1 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead1'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[01]); // ���ST1 RF Read
  TEdit(Self.FindComponent('edt_In_RfRead2'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[02]); // �԰�ST2 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead2'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[03]); // ���ST2 RF Read
  TEdit(Self.FindComponent('edt_In_RfRead3'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[04]); // �԰�ST3 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead3'  )).Text := fnSignalMsg(SC_STATUS[SC_NO].D213[05]); // ���ST3 RF Read

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
  TEdit(Self.FindComponent('edt_InReady1'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[08],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady1'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[09],'2'); // �����
  TEdit(Self.FindComponent('edt_InReady2'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[10],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady2'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[11],'2'); // �����
  TEdit(Self.FindComponent('edt_InReady3'     )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[12],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady3'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D211[13],'2'); // �����
  // D212.00 ~ D212.15
  TEdit(Self.FindComponent('edt_Curtain1'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[00],'2'); // ����ƮĿư1
  TEdit(Self.FindComponent('edt_Curtain2'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[01],'2'); // ����ƮĿư2
  TEdit(Self.FindComponent('edt_Curtain3'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[02],'2'); // ����ƮĿư3
  TEdit(Self.FindComponent('edt_Curtain4'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[03],'2'); // ����ƮĿư4
  TEdit(Self.FindComponent('edt_Curtain5'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[04],'2'); // ����ƮĿư5
  TEdit(Self.FindComponent('edt_Curtain6'    )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[05],'2'); // ����ƮĿư6
  TEdit(Self.FindComponent('edt_Fire1'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[10],'2'); // ȭ��溸��1
  TEdit(Self.FindComponent('edt_Fire2'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[11],'2'); // ȭ��溸��2
  TEdit(Self.FindComponent('edt_Fire3'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[12],'2'); // ȭ��溸��3
  TEdit(Self.FindComponent('edt_Fire4'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[13],'2'); // ȭ��溸��4
  TEdit(Self.FindComponent('edt_Fire5'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[14],'2'); // ȭ��溸��5
  TEdit(Self.FindComponent('edt_Fire6'       )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D212[15],'2'); // ȭ��溸��6
  // D213.00 ~ D213.15
  TEdit(Self.FindComponent('edt_In_RfRead1'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[00],'2'); // �԰�ST1 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead1'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[01],'2'); // ���ST1 RF Read
  TEdit(Self.FindComponent('edt_In_RfRead2'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[02],'2'); // �԰�ST2 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead2'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[03],'2'); // ���ST2 RF Read
  TEdit(Self.FindComponent('edt_In_RfRead3'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[04],'2'); // �԰�ST3 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead3'  )).Color := fnSignalEditColor(SC_STATUS[SC_NO].D213[05],'2'); // ���ST3 RF Read


  //++++++++++++++++++++++++++++++++++++++++++++
  // ����Ʈ ��Ʈ ���� ���� (D210.00 ~ D213.15)
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
  TEdit(Self.FindComponent('edt_InReady1'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[08],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady1'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[09],'2'); // �����
  TEdit(Self.FindComponent('edt_InReady2'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[10],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady2'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[11],'2'); // �����
  TEdit(Self.FindComponent('edt_InReady3'     )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[12],'2'); // �԰���
  TEdit(Self.FindComponent('edt_OutReady3'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D211[13],'2'); // �����
  // D212.00 ~ D212.15
  TEdit(Self.FindComponent('edt_Curtain1'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[00],'2'); // ����ƮĿư1
  TEdit(Self.FindComponent('edt_Curtain2'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[01],'2'); // ����ƮĿư2
  TEdit(Self.FindComponent('edt_Curtain3'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[02],'2'); // ����ƮĿư3
  TEdit(Self.FindComponent('edt_Curtain4'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[03],'2'); // ����ƮĿư4
  TEdit(Self.FindComponent('edt_Curtain5'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[04],'2'); // ����ƮĿư5
  TEdit(Self.FindComponent('edt_Curtain6'    )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[05],'2'); // ����ƮĿư6
  TEdit(Self.FindComponent('edt_Fire1'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[10],'2'); // ȭ��溸��1
  TEdit(Self.FindComponent('edt_Fire2'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[11],'2'); // ȭ��溸��2
  TEdit(Self.FindComponent('edt_Fire3'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[12],'2'); // ȭ��溸��3
  TEdit(Self.FindComponent('edt_Fire4'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[13],'2'); // ȭ��溸��4
  TEdit(Self.FindComponent('edt_Fire5'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[14],'2'); // ȭ��溸��5
  TEdit(Self.FindComponent('edt_Fire6'       )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D212[15],'2'); // ȭ��溸��6
  // D213.00 ~ D213.15
  TEdit(Self.FindComponent('edt_In_RfRead1'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[00],'2'); // �԰�ST1 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead1'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[01],'2'); // ���ST1 RF Read
  TEdit(Self.FindComponent('edt_In_RfRead2'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[02],'2'); // �԰�ST2 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead2'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[03],'2'); // ���ST2 RF Read
  TEdit(Self.FindComponent('edt_In_RfRead3'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[04],'2'); // �԰�ST3 RF Read
  TEdit(Self.FindComponent('edt_Ot_RfRead3'  )).Font.Color := fnSignalFontColor(SC_STATUS[SC_NO].D213[05],'2'); // ���ST3 RF Read
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
// PLC_WriteDisplay
//==============================================================================
procedure TfrmSCComm.PLC_BIT_Write;
var
  i, OpenVal, CloseVal : Integer;
begin
  OpenVal := fnGet_Current('CURTAIN', 'OPTION1');
  CloseVal := fnGet_Current('CURTAIN', 'OPTION2');
  if (OpenVal <> 0) then
  begin
    // Ŀư ����
    if (PLC_ReadVal.Curtain[OpenVal] = '0') then
    begin
      if (PLC_WriteVal.Curtain[OpenVal] = '0') then
      begin
        PLC_ORDER.ORDER := '1';
        PLC_WRITE_FLAG := ComWrite;
      end;
      PLC_WriteVal.Curtain[OpenVal] := '1';
    end;
    fnSet_Current('CURTAIN', 'OPTION1', '0');
  end;

  if (CloseVal <> 0) then
  begin
    // Ŀư ����
    if (PLC_ReadVal.Curtain[CloseVal] = '1') then
    begin
      if (PLC_WriteVal.Curtain[CloseVal] = '1') then
      begin
        PLC_ORDER.ORDER := '1';
        PLC_WRITE_FLAG := ComWrite;
      end;
      PLC_WriteVal.Curtain[CloseVal] := '0';
    end;
    fnSet_Current('CURTAIN', 'OPTION2', '0');
  end;

  for i := 1 to 6 do
  begin
    // RFID Read ��û ON
    if (fnGet_Current('RF_READ', 'OPTION' + IntToStr(i)) = 1) and
       (PLC_WriteVal.RFID_Read[i] = '0') then
    begin
      PLC_ORDER.ORDER := '1';
      PLC_WRITE_FLAG := ComWrite;
      PLC_WriteVal.RFID_Read[i] := '1';
    end else
    // RFID Read �Ϸ� ǥ��
    if (fnGet_Current('RF_READ', 'OPTION' + IntToStr(i)) = 1) and
       (PLC_ReadVal.RFID_Read[i] = '1' ) then
    begin
      fnSet_Current('RF_READ', 'OPTION' + IntToStr(i), '2');
    end else
    // RFID Read ��û OFF
    if (fnGet_Current('RF_READ', 'OPTION' + IntToStr(i)) = 3) and
       (PLC_WriteVal.RFID_Read[i] = '1') then
    begin
      PLC_ORDER.ORDER := '1';
      PLC_WRITE_FLAG := ComWrite;
      PLC_WriteVal.RFID_Read[i] := '0';
      fnSet_Current('RF_READ', 'OPTION' + IntToStr(i), '0');

      fnIns_RfidHistory(i);
    end;
  end;
end;

//==============================================================================
// PLC_WriteDisplay
//==============================================================================
procedure TfrmSCComm.PLC_WriteDisplay;
begin
  TEdit(Self.FindComponent('edt_CurtainW_1')).Text := fnSignalMsg(PLC_WriteVal.Curtain[1]);
  TEdit(Self.FindComponent('edt_CurtainW_2')).Text := fnSignalMsg(PLC_WriteVal.Curtain[2]);
  TEdit(Self.FindComponent('edt_CurtainW_3')).Text := fnSignalMsg(PLC_WriteVal.Curtain[3]);
  TEdit(Self.FindComponent('edt_CurtainW_4')).Text := fnSignalMsg(PLC_WriteVal.Curtain[4]);
  TEdit(Self.FindComponent('edt_CurtainW_5')).Text := fnSignalMsg(PLC_WriteVal.Curtain[5]);
  TEdit(Self.FindComponent('edt_CurtainW_6')).Text := fnSignalMsg(PLC_WriteVal.Curtain[6]);

  TEdit(Self.FindComponent('edt_RfReadW_1')).Text := fnSignalMsg(PLC_WriteVal.RFID_Read[1]);
  TEdit(Self.FindComponent('edt_RfReadW_2')).Text := fnSignalMsg(PLC_WriteVal.RFID_Read[2]);
  TEdit(Self.FindComponent('edt_RfReadW_3')).Text := fnSignalMsg(PLC_WriteVal.RFID_Read[3]);
  TEdit(Self.FindComponent('edt_RfReadW_4')).Text := fnSignalMsg(PLC_WriteVal.RFID_Read[4]);
  TEdit(Self.FindComponent('edt_RfReadW_5')).Text := fnSignalMsg(PLC_WriteVal.RFID_Read[5]);
  TEdit(Self.FindComponent('edt_RfReadW_6')).Text := fnSignalMsg(PLC_WriteVal.RFID_Read[6]);
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
  i, j : integer ;
  StrSql, TmpCol, StrLog, D210, D211, D212, D213 : String ;
begin
  D210:=''; D211:=''; D212:=''; D213:='';

  StrSql := ' SELECT * FROM VW_SC_STAUS ' +
            '  WHERE SC_NO =''' + IntToStr(SC_NO) + ''' ';

  SC_STATUS_OLD[SC_NO] := SC_STATUS[SC_NO];

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
          TmpCol := 'D210_' + FormatFloat('00', j) ;
          SC_STATUS[SC_NO].D210[j] := FieldByName(TmpCol).AsString ;
          D210 := D210 + SC_STATUS[SC_NO].D210[j] ;
          TmpCol := 'D211_' + FormatFloat('00', j) ;
          SC_STATUS[SC_NO].D211[j] := FieldByName(TmpCol).AsString ;
          D211 := D211 + SC_STATUS[SC_NO].D211[j] ;
          TmpCol := 'D212_' + FormatFloat('00', j) ;
          SC_STATUS[SC_NO].D212[j] := FieldByName(TmpCol).AsString ;
          D212 := D212 + SC_STATUS[SC_NO].D212[j] ;
          Tmpcol := 'D213_' + FormatFloat('00', j);
          SC_STATUS[SC_NO].D213[j] := FieldByName(TmpCol).AsString ;
          D213 := D213 + SC_STATUS[SC_NO].D213[j];
        end;

        //����Ʈ Ŀư ����
        PLC_ReadVal.Curtain[1] := SC_STATUS[SC_NO].D212[0];
        PLC_ReadVal.Curtain[2] := SC_STATUS[SC_NO].D212[1];
        PLC_ReadVal.Curtain[3] := SC_STATUS[SC_NO].D212[2];
        PLC_ReadVal.Curtain[4] := SC_STATUS[SC_NO].D212[3];
        PLC_ReadVal.Curtain[5] := SC_STATUS[SC_NO].D212[4];
        PLC_ReadVal.Curtain[6] := SC_STATUS[SC_NO].D212[5];

        // RFID Read ����
        PLC_ReadVal.RFID_Read[1] := SC_STATUS[SC_NO].D213[0];
        PLC_ReadVal.RFID_Read[2] := SC_STATUS[SC_NO].D213[1];
        PLC_ReadVal.RFID_Read[3] := SC_STATUS[SC_NO].D213[2];
        PLC_ReadVal.RFID_Read[4] := SC_STATUS[SC_NO].D213[3];
        PLC_ReadVal.RFID_Read[5] := SC_STATUS[SC_NO].D213[4];
        PLC_ReadVal.RFID_Read[6] := SC_STATUS[SC_NO].D213[5];

        if (IsStartUp) then
        begin
          IsStartUp := False;

          for i := 1 to 6 do
          begin
            PLC_WriteVal.RFID_Read[i] := PLC_ReadVal.RFID_Read[i];
            PLC_WriteVal.Curtain[i] := PLC_ReadVal.Curtain[i];
          end;
        end;

        // ����ǥ��
        if (SC_STATUS[SC_NO].D205 <> '0000') then
        begin
          if not (fnGetErrReport('PLC', 1, SC_STATUS[SC_NO].D205)) then
          begin
            fnSetErrReport('PLC', SC_NO, SC_STATUS[SC_NO].D205);
          end;
        end else
        // ��������
        if (SC_STATUS_OLD[SC_NO].D205 <> '0000') and
           (SC_STATUS[SC_NO].D205 = '0000') then
        begin
          fnReSetErrReport('PLC', SC_NO);
        end;


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
                  ' | D212-' + D212 +
                  ' | D213-' + D213 ;

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
begin
  if CONTROL_FLAG[SC_NO] = ComRead then
  begin
    //
  end else
  if (CONTROL_FLAG[SC_NO] = ComWrite) then
  begin
    fnSetWriteInfo(SC_NO, SC_JOB[SC_NO].IO_TYPE) ;
  end;

  if (PLC_WRITE_FLAG = ComWrite) then
  begin
    fnSetPLCWriteInfo;
    PLC_WRITE_FLAG := ComRead;
  end;

end;

//==============================================================================
// SC Control Process
//==============================================================================
procedure TfrmSCComm.SCControlProcess(SC_NO:Integer);
var
  LineNo : Integer;
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

      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;

      //+++++++++++++++
      // ��ŷ���� ��� ���� �ܰ� ���� X
      //+++++++++++++++
      LineNo := StrToInt(fnOrder_Value(SC_NO, 'LINE_NO'));
      if (SC_STATUS[SC_NO].D213[LineNo + 9] = '1') then
      begin
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
          if not (fnGetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205))then
          begin
            fnSetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205);
          end;

          if (SC_STATUS[SC_NO].D205 = '0073') or   // ���� Data �̻�
             (SC_STATUS[SC_NO].D205 = '0074') then // ���� Data ����
          begin
            SC_STAT[SC_NO] := DATAERR ;
          end else
          if (SC_STATUS[SC_NO].D211[04] = '1') then // �����
          begin
            SC_STAT[SC_NO] := ERR1 ;
            fnStockUpdate(SC_NO,'ID_STATUS','7') ; // ������ ������ ����
            fnSetSCSetInfo(SC_NO, 'JOB_RETRY', '1');
          end;
          fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;
        end;
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

      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;

      //+++++++++++++++
      // ��ŷ���� ��� ���� �ܰ� ���� X
      //+++++++++++++++
      LineNo := StrToInt(fnOrder_Value(SC_NO, 'LINE_NO'));
      if (SC_STATUS[SC_NO].D213[LineNo + 9] = '1') then
      begin
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
        if (fnOrder_Value(SC_No, 'JOBERRORD') <> '' ) and
           (fnOrder_Value(SC_No, 'JOBERRORD') <> '0') then fnSetMachError(SC_NO, '0') ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if not (fnGetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205))then
          begin
            fnSetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205);
          end;

          if (SC_STATUS[SC_NO].D211[04] = '1') then // �����
          begin
            SC_STAT[SC_NO] := ERR1 ;
            fnStockUpdate(SC_NO,'ID_STATUS','7') ; // ������ ������ ����
            fnSetSCSetInfo(SC_NO, 'JOB_RETRY', '1');
          end;
          fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;
        end;
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

      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;

      //+++++++++++++++
      // ��ŷ���� ��� ���� �ܰ� ���� X
      //+++++++++++++++
      LineNo := StrToInt(fnOrder_Value(SC_NO, 'LINE_NO'));
      if (SC_STATUS[SC_NO].D213[LineNo + 9] = '1') then
      begin
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


      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;

      //+++++++++++++++
      // ��ŷ���� ��� ���� �ܰ� ���� X
      //+++++++++++++++
      LineNo := StrToInt(fnOrder_Value(SC_NO, 'LINE_NO'));
      if (SC_STATUS[SC_NO].D213[LineNo + 9] = '1') then
      begin
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
          if not (fnGetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205))then
          begin
            fnSetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205);
          end;

          if (SC_STATUS[SC_NO].D205 = '0073') or   // ���� Data �̻�
             (SC_STATUS[SC_NO].D205 = '0074') then // ���� Data ����
          begin
            SC_STAT[SC_NO] := DATAERR ;
          end else
          if (SC_STATUS[SC_NO].D211[03] = '1') then // �����԰�
          begin
            SC_STAT[SC_NO] := ERR2 ;
            fnStockUpdate(SC_NO,'ID_STATUS','6') ;  // ������ �����԰�� ����
            fnSetSCSetInfo(SC_NO, 'JOB_RETRY', '1');
          end ;
          fnSetMachError(SC_NO, SC_STATUS[SC_NO].D205) ;
        end;
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
//        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        Exit;
      end;


      if not fnSCIO_Exist(SC_NO) then
      begin
        SC_JOBClear(SC_NO) ;
        CONTROL_FLAG[SC_NO] := ComRead ;
        SC_STAT[SC_NO] := STANDBY ;
      end;

      //+++++++++++++++
      // ��ŷ���� ��� ���� �ܰ� ���� X
      //+++++++++++++++
      LineNo := StrToInt(fnOrder_Value(SC_NO, 'LINE_NO'));
      if (SC_STATUS[SC_NO].D213[LineNo + 9] = '1') then
      begin
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
        if (fnOrder_Value(SC_No, 'JOBERRORD') <> '' ) and
           (fnOrder_Value(SC_No, 'JOBERRORD') <> '0') then fnSetMachError(SC_NO, '0') ;
      end else
      begin
        if (SC_STATUS[SC_NO].D210[15] = '1') then
        begin
          if not (fnGetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205))then
          begin
            fnSetErrReport('SC', SC_NO, SC_STATUS[SC_NO].D205);
          end;

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
//        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
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
        fnOrder_Update(SC_JOB[SC_NO].ID_ORDLUGG, 'JOBERRORC', '');
        if (SC_STATUS[SC_NO].D211[03] = '1') then // �����԰�
        begin
          if (fnCellPosChange(SC_NO,'1') = True) then
          begin
            SC_JOB[SC_No].DATA_RESET := '1';
            SC_STAT[SC_NO] := ORDER2 ;
            fnChkSCJOB(SC_NO);
            CONTROL_FLAG[SC_NO] := ComWrite ;
            SC_JOB[SC_NO].MOVE_ON := '1';
          end;
        end else
        if (SC_STATUS[SC_NO].D211[04] = '1') then // �����
        begin
          if (SC_JOB[SC_NO].ITM_CD = 'FULL') or
             (SC_JOB[SC_NO].ITM_CD = 'EPLT') then
          begin
            if (fnCellPosChange(SC_NO, '2') = True) then
            begin
              SC_JOB[SC_NO].DATA_RESET := '1';
              SC_STAT[SC_NO] := ORDER1;
              fnChkSCJOB(SC_NO);
              CONTROL_FLAG[SC_NO] := ComWrite ;
              SC_JOB[SC_NO].MOVE_ON := '1';
            end;
          end else
          begin
            SC_JOB[SC_No].DATA_RESET := '1';
            SC_JOB[SC_No].JOB_COMPLETE := '1';
            SC_STAT[SC_NO] := STANDBY ;
            fnSCIO_Delete(SC_NO) ;
            CONTROL_FLAG[SC_NO] := ComWrite ;
          end;
        end;

        fnReSetErrReport('SC', SC_NO);

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

          fnReSetErrReport('SC', SC_NO);
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
//        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        fnReSetErrReport('SC', SC_NO);
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
          fnReSetErrReport('SC', SC_NO);
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
//        fnStockUpdate(SC_NO,'ID_STATUS','9') ;                                        // ������ ����
        fnReSetErrReport('SC', SC_NO);
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
function TfrmSCComm.fnSetWriteInfo(SC_NO: Integer; Job_Type: String): Boolean;
var
  i : Integer;
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
    if (Job_Type = 'I') and (SC_JOB[SC_NO].ID_ORDLUGG <> '') then // �����԰�
    begin
      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ;    // �۾���ȣ
      SC_ORDER[SC_NO].SCORD_D100 := '0000';                       // ���� ��
      SC_ORDER[SC_NO].SCORD_D101 := '0000';                       // ���� ��
      SC_ORDER[SC_NO].SCORD_D102 := SC_JOB[SC_NO].LOAD_LEVEL;     // ���� ��
      SC_ORDER[SC_NO].SCORD_D103 := SC_JOB[SC_NO].UNLOAD_BANK;    // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D104 := SC_JOB[SC_NO].UNLOAD_BAY;     // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D105 := SC_JOB[SC_NO].UNLOAD_LEVEL;   // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D106 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D107 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D108 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D109 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D110 := '0000';                       // ����

      SC_OrderDisplay(SC_NO);     // SC Order ȭ�� ���÷���
      fnSetSCORDWrite(SC_NO, '0'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
    end else
    if (Job_Type = 'O') and (SC_JOB[SC_NO].ID_ORDLUGG <> '') then // �������
    begin
      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ;    // �۾���ȣ
      SC_ORDER[SC_NO].SCORD_D100 := SC_JOB[SC_NO].LOAD_BANK;      // ���� ��
      SC_ORDER[SC_NO].SCORD_D101 := SC_JOB[SC_NO].LOAD_BAY;       // ���� ��
      SC_ORDER[SC_NO].SCORD_D102 := SC_JOB[SC_NO].LOAD_LEVEL;     // ���� ��
      SC_ORDER[SC_NO].SCORD_D103 := '0000';                       // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D104 := '0000';                       // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D105 := SC_JOB[SC_NO].UNLOAD_LEVEL;   // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D106 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D107 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D108 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D109 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D110 := '0000';                       // ����

      SC_OrderDisplay(SC_NO);     // SC Order ȭ�� ���÷���
      fnSetSCORDWrite(SC_NO, '0'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
    end  else
    if (Job_Type = 'M') and (SC_JOB[SC_NO].ID_ORDLUGG <> '') then // �������
    begin
      SC_ORDER[SC_NO].SCORD_NO   := SC_JOB[SC_NO].ID_ORDLUGG ;    // �۾���ȣ
      SC_ORDER[SC_NO].SCORD_D100 := SC_JOB[SC_NO].LOAD_BANK;      // ���� ��
      SC_ORDER[SC_NO].SCORD_D101 := SC_JOB[SC_NO].LOAD_BAY;       // ���� ��
      SC_ORDER[SC_NO].SCORD_D102 := SC_JOB[SC_NO].LOAD_LEVEL;     // ���� ��
      SC_ORDER[SC_NO].SCORD_D103 := SC_JOB[SC_NO].UNLOAD_BANK;    // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D104 := SC_JOB[SC_NO].UNLOAD_BAY;     // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D105 := SC_JOB[SC_NO].UNLOAD_LEVEL;   // �Ͽ� ��
      SC_ORDER[SC_NO].SCORD_D106 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D107 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D108 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D109 := '0000';                       // ����
      SC_ORDER[SC_NO].SCORD_D110 := '0000';                       // ����

      SC_OrderDisplay(SC_NO);     // SC Order ȭ�� ���÷���
      fnSetSCORDWrite(SC_NO, '0'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
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

    Sleep(2000);
  end;
end;

//==============================================================================
// fnSetPLCWriteInfo : ���� ������ TT_PLCORD INSERT (MELSEC ���α׷����� TT_PLCORD ���� ��)
//==============================================================================
function TfrmSCComm.fnSetPLCWriteInfo: Boolean;
var
 BinDoor, RfidReq, TotalWrite : String;
 i : Integer;
begin
  // Ŀư on/off
  if (PLC_ORDER.ORDER = '1') then
  begin
    Sleep(500);
    PLC_ORDER.ORDER := '0';

    BinDoor := '00';
    RfidReq := '';
    for i := 6 downto 1 do
    begin
      BinDoor := BinDoor + PLC_WriteVal.Curtain[i];
      RfidReq := RfidReq + PLC_WriteVal.RFID_Read[i];
    end;
    TotalWrite := RfidReq + '00' + BinDoor;
    PLC_ORDER.D111 := IntToStr(Bin2Dec(TotalWrite)); //  FormatFloat('0000', Bin2Dec(TotalWrite));

    fnSetPLCORDWrite(1, '0'); // ���õ����� ���� �� TT_SCORD ���̺� ���� Insert
  end;

  for i := 1 to 6 do
  begin
    if (Rfid_Clear[i]) then
    begin
      fnSetPLCORDWrite(1, IntToStr(i));
      Rfid_Clear[i] := False;
    end;
  end;

  Sleep(2000);
end;

//==============================================================================
// fnSetSCORDWrite : ���� ������ TT_SCORD�� INSERT (MELSEC ���α׷����� TT_SCORD ���� ��)
//==============================================================================
function TfrmSCComm.fnSetPLCORDWrite(PLC_NO: Integer; Flag: String): Boolean;
var
  StrSQL, StrLog : String ;
  ExecNo : Integer ;
begin
  Result := False ;
  StrSQL  := ' INSERT INTO TT_PLCORD ' +
             '  ( PLC_NO, ' +
             '    D111, ' +
             '    ORD_STATUS, ORD_DT ) ' +
             ' VALUES ( ' +
             ' ''' + IntToStr(PLC_NO) + ''', ' +
             ' ''' + PLC_ORDER.D111 + ''', ' +
             ' ''' + Flag + ''', ' +
             ' GETDATE() ) ' ;
  try
    with qryWrite do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        StrLog := ' COMD PLC' + IntToStr(PLC_NO) +
                   ' | PLCORD INSERT Success' +
                  ' | ORD_D111- ' + PLC_ORDER.D111 ;
        DisplayLog(1, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      ErrorLogWRITE( 'Function fnSetPLCORDWrite Flag(' + Flag + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
      qryWrite.Close ;
    end;
  end;
end;

//==============================================================================
// fnSetSCORDWrite : ���� ������ TT_SCORD�� INSERT (MELSEC ���α׷����� TT_SCORD ���� ��)
//==============================================================================
function TfrmSCComm.fnSetSCORDWrite(SC_NO: Integer; Flag: String): Boolean;
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
             '''' + Flag + ''', ' +                        // STATUS - 0: ���õ����� 1: �⵿���� �Ǵ� Data Reset
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
      SC_JOB[i].RF_LINE_NAME1  := '';
      SC_JOB[i].RF_LINE_NAME2  := '';
      SC_JOB[i].RF_PALLET_NO1  := '';
      SC_JOB[i].RF_PALLET_NO2  := '';
      SC_JOB[i].RF_MODEL_NO1   := '';
      SC_JOB[i].RF_MODEL_NO2   := '';
      SC_JOB[i].RF_BMA_NO      := '';
      SC_JOB[i].RF_PALLET_BMA1 := '';
      SC_JOB[i].RF_PALLET_BMA2 := '';
      SC_JOB[i].RF_PALLET_BMA3 := '';
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
    SC_JOB[SC_NO].RF_LINE_NAME1  := '';
    SC_JOB[SC_NO].RF_LINE_NAME2  := '';
    SC_JOB[SC_NO].RF_PALLET_NO1  := '';
    SC_JOB[SC_NO].RF_PALLET_NO2  := '';
    SC_JOB[SC_NO].RF_MODEL_NO1   := '';
    SC_JOB[SC_NO].RF_MODEL_NO2   := '';
    SC_JOB[SC_NO].RF_BMA_NO      := '';
    SC_JOB[SC_NO].RF_PALLET_BMA1 := '';
    SC_JOB[SC_NO].RF_PALLET_BMA2 := '';
    SC_JOB[SC_NO].RF_PALLET_BMA3 := '';
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
      SC_JOB_OLD[i].RF_LINE_NAME1    := '' ;
      SC_JOB_OLD[i].RF_LINE_NAME2    := '' ;
      SC_JOB_OLD[i].RF_PALLET_NO1    := '' ;
      SC_JOB_OLD[i].RF_PALLET_NO2    := '' ;
      SC_JOB_OLD[i].RF_MODEL_NO1     := '' ;
      SC_JOB_OLD[i].RF_MODEL_NO2     := '' ;
      SC_JOB_OLD[i].RF_BMA_NO        := '' ;
      SC_JOB_OLD[i].RF_PALLET_BMA1   := '' ;
      SC_JOB_OLD[i].RF_PALLET_BMA2   := '' ;
      SC_JOB_OLD[i].RF_PALLET_BMA3   := '' ;
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
    SC_JOB_OLD[SC_NO].RF_LINE_NAME1  := '' ;
    SC_JOB_OLD[SC_NO].RF_LINE_NAME2  := '' ;
    SC_JOB_OLD[SC_NO].RF_PALLET_NO1  := '' ;
    SC_JOB_OLD[SC_NO].RF_PALLET_NO2  := '' ;
    SC_JOB_OLD[SC_NO].RF_MODEL_NO1   := '' ;
    SC_JOB_OLD[SC_NO].RF_MODEL_NO2   := '' ;
    SC_JOB_OLD[SC_NO].RF_BMA_NO      := '' ;
    SC_JOB_OLD[SC_NO].RF_PALLET_BMA1 := '' ;
    SC_JOB_OLD[SC_NO].RF_PALLET_BMA2 := '' ;
    SC_JOB_OLD[SC_NO].RF_PALLET_BMA3 := '' ;

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
  SC_JOB_OLD[SC_NO].RF_LINE_NAME1  := SC_JOB[SC_NO].RF_LINE_NAME1  ;
  SC_JOB_OLD[SC_NO].RF_LINE_NAME2  := SC_JOB[SC_NO].RF_LINE_NAME2  ;
  SC_JOB_OLD[SC_NO].RF_PALLET_NO1  := SC_JOB[SC_NO].RF_PALLET_NO1  ;
  SC_JOB_OLD[SC_NO].RF_PALLET_NO2  := SC_JOB[SC_NO].RF_PALLET_NO2  ;
  SC_JOB_OLD[SC_NO].RF_MODEL_NO1   := SC_JOB[SC_NO].RF_MODEL_NO1   ;
  SC_JOB_OLD[SC_NO].RF_MODEL_NO2   := SC_JOB[SC_NO].RF_MODEL_NO2   ;
  SC_JOB_OLD[SC_NO].RF_BMA_NO      := SC_JOB[SC_NO].RF_BMA_NO      ;
  SC_JOB_OLD[SC_NO].RF_PALLET_BMA1 := SC_JOB[SC_NO].RF_PALLET_BMA1 ;
  SC_JOB_OLD[SC_NO].RF_PALLET_BMA2 := SC_JOB[SC_NO].RF_PALLET_BMA2 ;
  SC_JOB_OLD[SC_NO].RF_PALLET_BMA3 := SC_JOB[SC_NO].RF_PALLET_BMA3 ;

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
  SC_JOB[SC_NO].RF_LINE_NAME1  := SC_JOB_OLD[SC_NO].RF_LINE_NAME1  ;
  SC_JOB[SC_NO].RF_LINE_NAME2  := SC_JOB_OLD[SC_NO].RF_LINE_NAME2  ;
  SC_JOB[SC_NO].RF_PALLET_NO1  := SC_JOB_OLD[SC_NO].RF_PALLET_NO1  ;
  SC_JOB[SC_NO].RF_PALLET_NO2  := SC_JOB_OLD[SC_NO].RF_PALLET_NO2  ;
  SC_JOB[SC_NO].RF_MODEL_NO1   := SC_JOB_OLD[SC_NO].RF_MODEL_NO1   ;
  SC_JOB[SC_NO].RF_MODEL_NO2   := SC_JOB_OLD[SC_NO].RF_MODEL_NO2   ;
  SC_JOB[SC_NO].RF_BMA_NO      := SC_JOB_OLD[SC_NO].RF_BMA_NO      ;
  SC_JOB[SC_NO].RF_PALLET_BMA1 := SC_JOB_OLD[SC_NO].RF_PALLET_BMA1 ;
  SC_JOB[SC_NO].RF_PALLET_BMA2 := SC_JOB_OLD[SC_NO].RF_PALLET_BMA2 ;
  SC_JOB[SC_NO].RF_PALLET_BMA3 := SC_JOB_OLD[SC_NO].RF_PALLET_BMA3 ;
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
      CVCURR := ' And SRCLEVEL In (''0001'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '0') and
            (SC_STATUS[SC_NO].D211[10] = '0') and
            (SC_STATUS[SC_NO].D211[12] = '0') then
    begin
      CVCURR := ' And SRCLEVEL In (''0002'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '1') and
            (SC_STATUS[SC_NO].D211[10] = '1') and
            (SC_STATUS[SC_NO].D211[12] = '0') then
    begin
      CVCURR := ' And SRCLEVEL In (''0001'', ''0003'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '0') and
            (SC_STATUS[SC_NO].D211[10] = '0') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And SRCLEVEL In (''0005'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '1') and
            (SC_STATUS[SC_NO].D211[10] = '0') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And SRCLEVEL In (''0001'', ''0005'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '0') and
            (SC_STATUS[SC_NO].D211[10] = '1') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And SRCLEVEL In (''0003'', ''0005'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[08] = '1') and
            (SC_STATUS[SC_NO].D211[10] = '1') and
            (SC_STATUS[SC_NO].D211[12] = '1') then
    begin
      CVCURR := ' And SRCLEVEL In (''0001'', ''0003'', ''0005'')' ;
    end;
  end
  // ��� �����̼� ���� ���ǿ� ���� CVCURR ���� ����
  else if (IO = 'O') then
  begin
    if (SC_STATUS[SC_NO].D211[09] = '1') and
       (SC_STATUS[SC_NO].D211[11] = '0') and
       (SC_STATUS[SC_NO].D211[13] = '0') then
    begin
      CVCURR := ' And DSTLEVEL In (''0002'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '0') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '0') then
    begin
      CVCURR := ' And DSTLEVEL In (''0004'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '1') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '0') then
    begin
      CVCURR := ' And DSTLEVEL In (''0002'', ''0004'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '0') and
            (SC_STATUS[SC_NO].D211[11] = '0') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And DSTLEVEL In (''0006'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '1') and
            (SC_STATUS[SC_NO].D211[11] = '0') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And DSTLEVEL In (''0002'', ''0006'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '0') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And DSTLEVEL In (''0004'', ''0006'')' ;
    end
    else if (SC_STATUS[SC_NO].D211[09] = '1') and
            (SC_STATUS[SC_NO].D211[11] = '1') and
            (SC_STATUS[SC_NO].D211[13] = '1') then
    begin
      CVCURR := ' And DSTLEVEL In (''0002'', ''0004'', ''0006'')' ;
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
  LineNo : Integer;
begin
  Result := False ;

  if JFlag = StoreIn then
  begin // �԰��۾� �˻�
    IO_Gubun := 'I' ;
//    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''1''   ' +  // �԰� �۾�
              '    And NOWMC     = ''4''   ' +  // AGV�۾�
              '    And NOWSTATUS = ''4''   ' +  // �Ϸ� �۾�
//              '    And DSTSITE   = ''' + FormatFloat('0000', SC_NO) + '''  ' + // �԰� ȣ��
//              CVCURR +
              '  Order By EMG DESC, REG_TIME, LUGG ' ;
  end else
  if JFlag = StoreOut then
  begin // ����۾� �˻�
    IO_Gubun := 'O' ;
    CVCURR := fnGetCVOrderStr(SC_NO, IO_Gubun);
    StrSQL := ' Select * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''2''   ' +  // ��� �۾�
              '    And NOWMC     = ''2''   ' +  // SC�۾�
              '    And NOWSTATUS = ''1''   ' +  // ��� �۾�
//              '    And SRCSITE   = ''' + FormatFloat('0000', SC_NO) + ''' ' +  // ��� ȣ��
//              CVCURR +
              '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
  end else
  if JFlag = RackToRack then
  begin // ���̵��۾� �˻�
    IO_Gubun := 'M' ;
    StrSQL := ' Select TOP 1 * ' +
              '   From TT_ORDER ' +
              '  Where JOBD      = ''7''   ' +  // ���̵� �۾�
              '    And NOWMC     = ''2''   ' +  // SC�۾�
              '    And NOWSTATUS = ''1''   ' +  // ��� �۾�
//              '    And SRCSITE   = ''' + FormatFloat('0000', SC_NO) + ''' ' +  // ��� ȣ��
              '  Order By EMG DESC, REG_TIME, LUGG ASC ' ;
  end;


  try
    with qryInfo do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not (JFlag = RackToRack) then
      begin
        while not (Eof) do
        begin
          LineNo := FieldByName('LINE_NO').AsInteger + 7;
          if (JFlag = StoreIn) and
             (SC_STATUS[SC_NO].D211[LineNo] = '1') and
             (SC_STATUS[SC_NO].D213[LineNo + 2] = '0') then
          begin
            break;
          end else
          if (JFlag = StoreOut) and
             (SC_STATUS[SC_NO].D211[LineNo] = '0') and
             (SC_STATUS[SC_NO].D213[LineNo + 2] = '0') then
          begin
            break;
          end;
          Next;
        end;
      end;

      if not (Eof) then
      begin
        SC_JOB[SC_NO].ID_ORDLUGG := FormatFloat('0000', FieldByName('LUGG').AsInteger); // �۾� ��ȣ
        SC_JOB[SC_NO].ID_REGTIME := FieldByName('REG_TIME').AsString ;                  // �۾� ���� �ð�
        SC_JOB[SC_NO].ID_ORDDATE := Copy(SC_JOB[SC_NO].ID_REGTIME, 1, 8) ;              // �۾� ���� ����
        SC_JOB[SC_NO].ID_ORDTIME := Copy(SC_JOB[SC_NO].ID_REGTIME, 9, 6) ;              // �۾� ���� �Ͻ�
        SC_JOB[SC_NO].IO_TYPE    := IO_Gubun ;                                          // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )
        SC_JOB[SC_NO].ITM_CD     := UpperCase(Trim(FieldByName('ITM_CD').AsString)) ;

        SC_JOB[SC_NO].RF_LINE_NAME1   := Trim(FieldByName('RF_LINE_NAME1').AsString);
        SC_JOB[SC_NO].RF_LINE_NAME2   := Trim(FieldByName('RF_LINE_NAME2').AsString);
        SC_JOB[SC_NO].RF_PALLET_NO1   := Trim(FieldByName('RF_PALLET_NO1').AsString);
        SC_JOB[SC_NO].RF_PALLET_NO2   := Trim(FieldByName('RF_PALLET_NO2').AsString);
        SC_JOB[SC_NO].RF_MODEL_NO1    := Trim(FieldByName('RF_MODEL_NO1').AsString);
        SC_JOB[SC_NO].RF_MODEL_NO2    := Trim(FieldByName('RF_MODEL_NO2').AsString);
        SC_JOB[SC_NO].RF_BMA_NO       := Trim(FieldByName('RF_BMA_NO').AsString);
        SC_JOB[SC_NO].Cell_Production := Trim(FieldByName('RF_AREA').AsString);
        SC_JOB[SC_NO].RF_PALLET_BMA1  := Trim(FieldByName('RF_PALLET_BMA1').AsString);
        SC_JOB[SC_NO].RF_PALLET_BMA2  := Trim(FieldByName('RF_PALLET_BMA2').AsString);
        SC_JOB[SC_NO].RF_PALLET_BMA3  := Trim(FieldByName('RF_PALLET_BMA3').AsString);

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
        begin // ���̵�
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
  StrSQL := ' SELECT * FROM TT_ORDER with(nolock) ' +
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
            '   FROM TT_ORDER with(nolock) ' +
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
            '   FROM TT_ORDER with(nolock) ' + WhereStr;

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
                   '      , JOBSTATUS = ''4'' ' +
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
                   '    SET NOWMC     = ''3'' ' +
                   '      , NOWSTATUS = ''4'' ' +
                   '      , JOBSTATUS = ''4'' ' +
                   '      , JOB_END   = ''0'' ' +
                   '  WHERE LUGG      = ''' + SC_JOB[SC_No].ID_ORDLUGG + ''' ' +
                   '    AND REG_TIME  = ''' + SC_JOB[SC_NO].ID_REGTIME + ''' ' ;

    end else Exit;
  end else
  //----------------------------------------------------------------------------
  // ������ �Ϸ� �϶�
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TT_Order Update
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'M') then
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
                   '      , JOBSTATUS = ''4'' ' +
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

            // ���� ��/��� �۾� �̷� ����
            if (fnOrder_Value(SC_NO, 'IS_AUTO') = 'N')  then
            begin
              fnIns_History(SC_JOB[SC_No].ID_ORDLUGG);
            end;

            // �԰�Ϸ� �Ǵ� ���̵��� �̷»���
            if (SC_JOB[SC_No].IO_TYPE = 'I') or
               (SC_JOB[SC_No].IO_TYPE = 'M') then
            begin
              fnIns_History(SC_JOB[SC_No].ID_ORDLUGG);
            end;

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
// fnOrder_Delete : �۾�����
//==============================================================================
function TfrmSCComm.fnOrder_Delete(JobNo: String): Boolean;
var
  StrSQL, StrLog : string;
  ExecNo  : Integer;
begin
  Result := False ;
  StrSQL := ' DELETE FROM TT_ORDER ' +
            '  WHERE LUGG = ''' + JobNo + ''' ';

  try
    with qryDelete do
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
      qryDelete.Close ;
      ErrorLogWRITE( 'Function fnOrder_Delete JobNo(' + JobNo + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnOrder_RfidUpdate : TT_ORDER�� RFID ������ ������Ʈ
//==============================================================================
function TfrmSCComm.fnOrder_RfidUpdate(JobNo: String; RfidData: TRFID_Data): Boolean;
var
  StrSQL : string;
  ExecNo  : Integer;
begin
  Result := False ;
  StrSQL := ' UPDATE TT_ORDER ' +
            '    SET RF_LINE_NAME1 = ' + QuotedStr(RfidData.Line_Name_1) +
               '   , RF_LINE_NAME2 = ' + QuotedStr(RfidData.Line_Name_2) +
               '   , RF_PALLET_NO1 = ' + QuotedStr(RfidData.Pallet_No_1) +
               '   , RF_PALLET_NO2 = ' + QuotedStr(RfidData.Pallet_No_2) +
               '   , RF_MODEL_NO1 = ' + QuotedStr(RfidData.Model_No_1) +
               '   , RF_MODEL_NO2 = ' + QuotedStr(RfidData.Model_No_2) +
               '   , RF_BMA_NO = ' + QuotedStr(RfidData.BMA_No) +
               '   , RF_PALLET_BMA1 = ' + QuotedStr(RfidData.BMA_1) +
               '   , RF_PALLET_BMA2 = ' + QuotedStr(RfidData.BMA_2) +
               '   , RF_PALLET_BMA3 = ' + QuotedStr(RfidData.BMA_3) +
               '   , RF_AREA = ' + QuotedStr(RfidData.Cell_Production) +
            '  WHERE LUGG = ''' + JobNo + ''' ';
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
function TfrmSCComm.fnOrder_Update(JobNo, FName, FValue: String): Boolean;
var
  StrSQL : string;
  ExecNo : Integer;
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
  StrSQL : string;
  ExecNo : Integer;
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
  StrSQL : string;
  ExecNo : Integer;
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
function TfrmSCComm.fnGetErrMsg(MC: String; SC_NO: integer; GetField,ErrCode: String): String;
var
  StrSQL : String ;
begin
  Result := '' ;
  StrSQL := ' SELECT ' + GetField + ' AS MSG ' +
            '   FROM TM_ERROR ' +
            '  WHERE ERR_DEV  = ' + QuotedStr(MC) +
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
begin
  Result := False;

  if ErrorCode = fnOrder_Value(SC_No, 'JOBERRORD') then Exit ; // ������ ���� �����ڵ�� ��� �����ڵ尡 ������ �н�

  if StrToIntDef(ErrorCode, 0) = 0 then
  begin // ���� ����
    Step      := '2';
    StrProc   := ' Error Clear ' ;
    JobErrorT := '0' ;       // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet,
    JobErrorc := '0' ;       // 0: ����, 1: ����
    JobErrord := ErrorCode ; // ���� �ڵ�
  end else
  begin // ���� �߻�
    Step      := '1';
    StrProc   := ' Error ' ;
    JobErrorT := 'S' ;       // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet,
    JobErrorc := '1' ;       // 0: ����, 1: ����
    JobErrord := ErrorCode ; // ���� �ڵ�
  end;

  UdtSQL := ' UPDATE TT_ORDER ' +
            '    SET JOBERRORT = ''' + JobErrorT + ''' ' + // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet,
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

//==============================================================================
// fnSetMachError : ���� ���� �߻� �� TT_ORDER�� �������� Update
//==============================================================================
function TfrmSCComm.fnSetOrderError(LineNo: Integer; Error: String): Boolean;
var
  UdtSQL, StrLog, StrProc, Step : string;
  JobErrorT, JobErrorc, JobErrord : String ;
  ExecNo  : Integer;
  WhereStr : String;
begin
  Result := False;

  WhereStr := ' Where LINE_NO = ' + QuotedStr(IntToStr(LineNo));
  if Error = fnOrder_Value(WhereStr, 'JOBERRORD') then Exit ; // ������ ���� �����ڵ�� ��� �����ڵ尡 ������ �н�

  if StrToIntDef(Error, 0) = 0 then
  begin // ���� ����
    Step      := '2';
    StrProc   := ' Error Clear ' ;
    JobErrorT := '0' ;       // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet, R:RFID
    JobErrorc := '0' ;       // 0: ����, 1: ����
    JobErrord := Error ;     // ���� �ڵ�
  end else
  begin // ���� �߻�
    Step      := '1';
    StrProc   := ' Error ' ;
    JobErrorT := 'R' ;       // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet, R:RFID
    JobErrorc := '1' ;       // 0: ����, 1: ����
    JobErrord := Error ;     // ���� �ڵ�
  end;

  UdtSQL := ' UPDATE TT_ORDER ' +
            '    SET JOBERRORT = ''' + JobErrorT + ''' ' + // ����Ÿ�� 0:����, A:AGV, S:SC, C:CV, P:Pallet, R:RFID
            '      , JOBERRORC = ''' + JobErrorc + ''' ' + // 0: ����, 1: ����
            '      , JOBERRORD = ''' + JobErrord + ''' ' + // ���� �ڵ�
            '  WHERE LINE_NO   = ''' + IntToStr(LineNO) + ''' ' ;

  try
    with qryError do
    begin
      Close;
      SQL.Clear;
      SQL.Text := UdtSQL ;
      ExecNo := ExecSQL ;
      if ExecNo > 0 then
      begin
        StrLog := ' COMD SC' + IntToStr(1) +
                  ' | SC Error Proc        ' +
                  '| ORDER UPDATE Success' +
                  ' | ' + StrProc +
                  ' | Error Code- '     + JobErrord ;
        DisplayLog(1, StrLog, 'N', Length(StrLog)) ;
        Result := True ;
      end else
      begin
        StrLog := ' COMD SC' + IntToStr(1) +
                  ' | SC Error Proc        ' +
                  '| ORDER UPDATE Fail   ' +
                  ' | ' + StrProc +
                  ' | Error Code- '     + JobErrord ;
        DisplayLog(1, StrLog, 'E', Length(StrLog)) ;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryError.Close ;
      ErrorLogWRITE( 'Function fnSetOrderError LineNo(' + IntToStr(1) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + UdtSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSetErrReport
//==============================================================================
function TfrmSCComm.fnSetErrReport(MC: String; SC_NO: Integer; ErrorCode: String): Boolean;
var
  StrSQL, ERR_NAME : String ;
  ExecNo : Integer ;
begin
  Result := False ;
  ERR_NAME := fnGetErrMsg(MC, SC_NO, 'Err_Name', ErrorCode) ;

  if ERR_NAME='' then Exit;

  StrSQL  := ' INSERT INTO TT_ERROR ' +
             '  ( ERR_DEV, ERR_DEVNO, ERR_CODE, ERR_NAME, ' +
             '    ERR_DESC, ERR_START, ERR_END, ERR_DY )  ' +
             ' VALUES ( ' +
             '' + QuotedStr(MC) + ', ' +                      // �ӽ�
             '''' + IntToStr(Sc_No) + ''', ' +                // PLC ��ȣ
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
function TfrmSCComm.fnGetErrReport(MC: String; SC_NO: Integer; ErrorCode: String): Boolean;
var
  StrSQL : String ;
begin
  Result := False;
  StrSQL := ' SELECT COUNT(*) as CNT  ' +
            '   FROM TT_ERROR         ' +
            '  WHERE ERR_DEV   = ' + QuotedStr(MC) +
            '    AND ERR_DEVNO = ''' + IntToStr(SC_NO) + ''' ' +
            '    AND ERR_CODE  = ''' + ErrorCode + ''' ' +
            '    AND ERR_END < ''2000-01-01 00:00:00'' ' +
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
function TfrmSCComm.fnReSetErrReport(MC: String; SC_NO: Integer): Boolean;
var
  StrSQL : String ;
  ExecNo : Integer;
begin
  Result := False;
  StrSQL := ' UPDATE TT_ERROR ' +
            '    SET ERR_END  = GETDATE() ' +
            '  WHERE ERR_DEV   = ' + QuotedStr(MC) +
            '    AND ERR_DEVNO = ''' + IntToStr(SC_NO) + ''' ' +
            '    AND ERR_END < ''2000-01-01 00:00:00'' ' +
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
  StrSQL : String ;
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
  StrSQL, StrSQL2, StrLog, CellStatus, TmpBank, TmpBay, TmpLevel, StrJob : String ;
  ExecNo : Integer ;
begin
  // 0 : ����,     1 : �Ǽ�(��Box)  2 : �Ǽ�(��Box)  3 : ������
  // 4 : �԰���  5 : �����     6 : �����԰�     7 : �����
  Result := False ;
  StrSQL := ''; StrSQL2:= ''; CellStatus := ''; TmpBank := ''; TmpBay := ''; TmpLevel := '';

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
  if (SC_JOB[SC_No].IO_TYPE = 'I') then
  begin
    StrSQL := ' Update TT_STOCK ' +
              '    Set ITM_CD       = ' + QuotedStr(UpperCase(SC_JOB[SC_NO].ITM_CD)) +
              '      , ITM_NAME     = ' + QuotedStr(fnITEM_Value(SC_No, 'ITM_NAME', UpperCase(SC_JOB[SC_NO].ITM_CD))) +
              '      , ITM_SPEC     = ' + QuotedStr(fnITEM_Value(SC_No, 'ITM_SPEC', UpperCase(SC_JOB[SC_NO].ITM_CD))) +
              '      , ITM_QTY      = ' + QuotedStr(SC_JOB[SC_NO].RF_BMA_NO) +
              '      , RF_LINE_NAME1  = ' + QuotedStr(SC_JOB[SC_NO].RF_LINE_NAME1 ) +
              '      , RF_LINE_NAME2  = ' + QuotedStr(SC_JOB[SC_NO].RF_LINE_NAME2 ) +
              '      , RF_PALLET_NO1  = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_NO1 ) +
              '      , RF_PALLET_NO2  = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_NO2 ) +
              '      , RF_MODEL_NO1   = ' + QuotedStr(SC_JOB[SC_NO].RF_MODEL_NO1  ) +
              '      , RF_MODEL_NO2   = ' + QuotedStr(SC_JOB[SC_NO].RF_MODEL_NO2  ) +
              '      , RF_BMA_NO      = ' + QuotedStr(SC_JOB[SC_NO].RF_BMA_NO     ) +
              '      , RF_PALLET_BMA1 = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_BMA1) +
              '      , RF_PALLET_BMA2 = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_BMA2) +
              '      , RF_PALLET_BMA3 = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_BMA3) +
              '      , RF_AREA        = ' + QuotedStr(SC_JOB[SC_NO].Cell_Production) +
              '      , ID_STATUS    = ' + QuotedStr(CellStatus) +
              '      , STOCK_IN_DT  = GETDATE()   ' +
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
              '      , RF_LINE_NAME1  = '''' ' +
              '      , RF_LINE_NAME2  = '''' ' +
              '      , RF_PALLET_NO1  = '''' ' +
              '      , RF_PALLET_NO2  = '''' ' +
              '      , RF_MODEL_NO1   = '''' ' +
              '      , RF_MODEL_NO2   = '''' ' +
              '      , RF_BMA_NO      = '''' ' +
              '      , RF_PALLET_BMA1 = '''' ' +
              '      , RF_PALLET_BMA2 = '''' ' +
              '      , RF_PALLET_BMA3 = '''' ' +
              '      , RF_AREA        = '''' ' +
              '  Where ID_HOGI   = '   + QuotedStr(IntToStr(SC_NO)) +
              '    AND ID_BANK   = ''' + Copy(SC_JOB[SC_No].LOAD_BANK, 4, 1)  + ''' ' + // �Ͽ� ��
              '    AND ID_BAY    = ''' + Copy(SC_JOB[SC_No].LOAD_BAY, 3, 2)   + ''' ' + // �Ͽ� ��
              '    AND ID_LEVEL  = ''' + Copy(SC_JOB[SC_No].LOAD_LEVEL, 3, 2) + ''' ' ; // �Ͽ� ��

    TmpBank  := SC_JOB[SC_No].LOAD_BANK;
    TmpBay   := SC_JOB[SC_No].LOAD_BAY;
    TmpLevel := SC_JOB[SC_No].LOAD_LEVEL;
  end else
  //----------------------------------------------------------------------------
  // ���̵� �Ϸ� �϶�
  // 1. TT_STOCK Update 2. TT_SCIO Delete 3. TBL_LOTNO_INFO Update
  //----------------------------------------------------------------------------
  if (SC_JOB[SC_No].IO_TYPE = 'M') then
  begin
    StrSQL := ' Update TT_STOCK ' +
              '    Set ITM_CD       = ''''  ' +
              '      , ITM_NAME     = ''''  ' +
              '      , ITM_SPEC     = ''''  ' +
              '      , ITM_QTY      = 0     ' +
              '      , ID_STATUS    = ''0'' ' +
              '      , ID_MEMO      = ''''  ' +
              '      , RF_LINE_NAME1  = '''' ' +
              '      , RF_LINE_NAME2  = '''' ' +
              '      , RF_PALLET_NO1  = '''' ' +
              '      , RF_PALLET_NO2  = '''' ' +
              '      , RF_MODEL_NO1   = '''' ' +
              '      , RF_MODEL_NO2   = '''' ' +
              '      , RF_BMA_NO      = '''' ' +
              '      , RF_PALLET_BMA1 = '''' ' +
              '      , RF_PALLET_BMA2 = '''' ' +
              '      , RF_PALLET_BMA3 = '''' ' +
              '      , RF_AREA        = '''' ' +
              '  Where ID_HOGI   = '   + QuotedStr(IntToStr(SC_NO)) +
              '    AND ID_BANK   = ''' + Copy(SC_JOB[SC_No].LOAD_BANK, 4, 1)  + ''' ' + // ���� ��
              '    AND ID_BAY    = ''' + Copy(SC_JOB[SC_No].LOAD_BAY, 3, 2)   + ''' ' + // ���� ��
              '    AND ID_LEVEL  = ''' + Copy(SC_JOB[SC_No].LOAD_LEVEL, 3, 2) + ''' ' ; // ���� ��

    if (fnOrder_Value(SC_No, 'EMG') <> '2') then
    begin
      StrSQL2 := ' Update TT_STOCK ' +
                 '    Set ITM_CD       = ' + QuotedStr(UpperCase(SC_JOB[SC_NO].ITM_CD)) +
                 '      , ITM_NAME     = ' + QuotedStr(fnITEM_Value(SC_No, 'ITM_NAME', UpperCase(SC_JOB[SC_NO].ITM_CD))) +
                 '      , ITM_SPEC     = ' + QuotedStr(fnITEM_Value(SC_No, 'ITM_SPEC', UpperCase(SC_JOB[SC_NO].ITM_CD))) +
                 '      , ITM_QTY      = ' + QuotedStr(SC_JOB[SC_NO].RF_BMA_NO     ) +
                 '      , RF_LINE_NAME1  = ' + QuotedStr(SC_JOB[SC_NO].RF_LINE_NAME1 ) +
                 '      , RF_LINE_NAME2  = ' + QuotedStr(SC_JOB[SC_NO].RF_LINE_NAME2 ) +
                 '      , RF_PALLET_NO1  = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_NO1 ) +
                 '      , RF_PALLET_NO2  = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_NO2 ) +
                 '      , RF_MODEL_NO1   = ' + QuotedStr(SC_JOB[SC_NO].RF_MODEL_NO1  ) +
                 '      , RF_MODEL_NO2   = ' + QuotedStr(SC_JOB[SC_NO].RF_MODEL_NO2  ) +
                 '      , RF_BMA_NO      = ' + QuotedStr(SC_JOB[SC_NO].RF_BMA_NO     ) +
                 '      , RF_PALLET_BMA1 = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_BMA1) +
                 '      , RF_PALLET_BMA2 = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_BMA2) +
                 '      , RF_PALLET_BMA3 = ' + QuotedStr(SC_JOB[SC_NO].RF_PALLET_BMA3) +
                 '      , RF_AREA        = ' + QuotedStr(SC_JOB[SC_NO].Cell_Production) +
                 '      , ID_STATUS    = ' + QuotedStr(CellStatus) +
                 '      , STOCK_IN_DT  = GETDATE()   ' +
                 '      , ID_MEMO      = ' + QuotedStr(fnOrder_Value(SC_No,'ETC')) +
                 '  Where ID_HOGI   = '   + QuotedStr(IntToStr(SC_NO)) +
                 '    AND ID_BANK   = ''' + Copy(SC_JOB[SC_No].UNLOAD_BANK, 4, 1)  + ''' ' + // �Ͽ� ��
                 '    AND ID_BAY    = ''' + Copy(SC_JOB[SC_No].UNLOAD_BAY, 3, 2)   + ''' ' + // �Ͽ� ��
                 '    AND ID_LEVEL  = ''' + Copy(SC_JOB[SC_No].UNLOAD_LEVEL, 3, 2) + ''' ' ; // �Ͽ� ��
    end;


    TmpBank  := SC_JOB[SC_No].LOAD_BANK;
    TmpBay   := SC_JOB[SC_No].LOAD_BAY;
    TmpLevel := SC_JOB[SC_No].LOAD_LEVEL;
  end;

  if (StrSQL <> '') then
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
          if (StrSQL2 <> '') then
          begin
            Close;
            SQL.Clear;
            SQL.Text := StrSQL2 ;
            ExecNo := ExecSQL;
            if (ExecNo > 0) then
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
          end else
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
          end;
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

//==============================================================================
// fnGetStockLoc : ǰ�� ��ġ ��ȯ
//==============================================================================
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
      SQL.Text := StrSQL ;
      Parameters[0].Value := ItemCode ;
      Open ;

      if ( RecordCount = 0 ) or
         ( Copy(FieldByName('ID_CODE').AsString, 1, 2) <> 'OK' ) then
      begin
        Exit;
      end;
      Result := Copy(FieldByName('ID_CODE').AsString, 5, 5);
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
// fnGet_Current : �Ķ���� ������.
//==============================================================================
function TfrmSCComm.fnGet_Current(Cur_Name, FName: String): Integer;
var
  StrSQL : string;
begin
  Result := 0;
  StrSQL := '';
  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT ' + FName +
                 '  FROM TC_CURRENT ' +
                 ' WHERE CURRENT_NAME = ' + QuotedStr(Cur_Name);
      SQL.Text := StrSQL ;
      Open ;
      Result := FieldByName(FName).AsInteger;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryStock.Close ;
      ErrorLogWRITE( 'Function fnGet_Current Cur_Name(' + Cur_Name + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnGet_Current : �Ķ���� ������.
//==============================================================================
function TfrmSCComm.fnGet_Current(Cur_Name: String): Boolean;
var
  StrSQL : string;
begin
  Result := False;
  StrSQL := '';
  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT OPTION1' +
                 '  FROM TC_CURRENT ' +
                 ' WHERE CURRENT_NAME = ' + QuotedStr(Cur_Name);
      SQL.Text := StrSQL ;
      Open ;
      Result := Boolean(FieldByName('OPTION1').AsInteger);
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryStock.Close ;
      ErrorLogWRITE( 'Function fnGet_Current Cur_Name(' + Cur_Name + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnSet_Current : �Ķ���� ����.
//==============================================================================
procedure TfrmSCComm.fnSet_Current(Cur_Name, FName, FValue: String);
var
  StrSQL : string;
begin
  StrSQL := '';
  try
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' UPDATE TC_CURRENT' +
                   ' SET ' + FName + ' = ' + QuotedStr(FValue) +
                 ' WHERE CURRENT_NAME = ' + QuotedStr(Cur_Name);
      SQL.Text := StrSQL ;
      ExecSql ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryTemp.Close ;
      ErrorLogWRITE( 'Function fnSet_Current Cur_Name, FName, FValue(' + Cur_Name + ', ' + FName + ', ' + FValue + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;

end;

//==============================================================================
// fnGetSocktCount : ǰ�� ���� ��ȯ
//==============================================================================
function TfrmSCComm.fnGetStockCount(ItemCode: String): Integer;
var
  StrSQL : string;
begin
  Result := 0 ;
  StrSQL := '';
  try
    with qryStock do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT COUNT(*) as CNT ' +
                '   FROM TT_STOCK with(NOLOCK) ' +
                '  WHERE ITM_CD = ' + QuotedStr(ItemCode) +
                '    AND ID_STATUS in(''1'', ''2'') ';
      SQL.Text := StrSQL ;
      Open ;
      Result := FieldByName('CNT').AsInteger;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryStock.Close ;
      ErrorLogWRITE( 'Function fnGetSocktCount ItemCode(' + ItemCode + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnIsCellEmpty : ���� ����ִ��� Ȯ�� ��������� True, �� �� ������ False
//==============================================================================
function TfrmSCComm.fnIsCellEmpty: Boolean;
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
      StrSQL := ' SELECT COUNT(*) as CNT ' +
                '   FROM TT_STOCK with(NOLOCK) ' +
                '  WHERE ID_STATUS = ''0'' ';
      SQL.Text := StrSQL ;
      Open ;
      Result := Boolean(FieldByName('CNT').AsInteger);
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryStock.Close ;
      ErrorLogWRITE( 'Function fnIsCellEmpty ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;


//==============================================================================
// fnIsCellEmpty : �� ��ĭ ���� ��ȯ
//==============================================================================
function TfrmSCComm.fnGetCellCount(Status: String): Integer;
var
  StrSQL : string;
begin
  Result := 0 ;
  StrSQL := '';
  try
    with qryStock do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' SELECT COUNT(*) as CNT ' +
                '   FROM TT_STOCK with(NOLOCK)' +
                '  WHERE ID_STATUS = ' + QuotedStr(Status);
      SQL.Text := StrSQL ;
      Open ;
      Result := FieldByName('CNT').AsInteger;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryStock.Close ;
      ErrorLogWRITE( 'Function fnIsCellEmpty ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;

end;

//==============================================================================
// fnIns_History : TT_ORDER�� History�� �ְ� ����
//==============================================================================
procedure TfrmSCComm.fnIns_History(Line_No: Integer);
var
  StrSQL : string;
  ExecNo : Integer;
begin
  StrSQL := '';
  try
    with qryHis do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' INSERT INTO TT_HISTORY (REG_TIME, LUGG, JOBD, LINE_NO, IS_AUTO, ' +
                                        ' SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL, ' +
                            					  ' DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL, ' +
					                              '	NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS, ' +
					                              '	JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +
					                              ' JOB_END, CVFR, CVTO, CVCURR, ' +
					                              '	ETC, EMG, ITM_CD, UP_TIME, ' +
					                              '	HIS_TIME) ' +
                      ' SELECT REG_TIME, LUGG, JOBD, LINE_NO, IS_AUTO, ' +
                             ' SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL, ' +
		                         ' DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL, ' +
		                         ' NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS, ' +
		                         ' JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +
		                         ' JOB_END, CVFR, CVTO, CVCURR, ' +
		                         ' ETC, EMG, ITM_CD, UP_TIME, GETDATE() ' +
                        ' FROM TT_ORDER ' +
                       ' WHERE LINE_NO = '  + IntToStr(Line_No) ;
      SQL.Text := StrSQL ;
      ExecNo := ExecSql ;

      if (ExecNo > 0) then
      begin
        Close;
        SQL.Clear;
        StrSQL := ' DELETE FROM TT_ORDER ' +
                  '  WHERE LINE_NO = ' + IntToStr(Line_No);
        SQL.Text := StrSQL;
        ExecSql;
      end;

      Close ;
    end;
  except
    on E: Exception do
    begin
      qryHis.Close ;
      ErrorLogWRITE( 'Function fnIns_History ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;

end;


//==============================================================================
// fnIns_History : TT_ORDER�� History�� �ְ� ����
//==============================================================================
procedure TfrmSCComm.fnIns_History(JobNo: String);
var
  StrSQL : string;
  ExecNo : Integer;
begin
  StrSQL := '';
  try
    with qryHis do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' INSERT INTO TT_HISTORY (REG_TIME, LUGG, JOBD, IS_AUTO, LINE_NO, ' +
                                        ' SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL, ' +
                            					  ' DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL, ' +
					                              '	NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS, ' +
					                              '	JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +
					                              ' JOB_END, CVFR, CVTO, CVCURR, ' +
					                              '	ETC, EMG, ITM_CD, UP_TIME, ' +
					                              '	HIS_TIME) ' +
                      ' SELECT REG_TIME, LUGG, JOBD, IS_AUTO, LINE_NO, ' +
                             ' SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL, ' +
		                         ' DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL, ' +
		                         ' NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS, ' +
		                         ' JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD, ' +
		                         ' JOB_END, CVFR, CVTO, CVCURR, ' +
		                         ' ETC, EMG, ITM_CD, UP_TIME, GETDATE() ' +
                        ' FROM TT_ORDER ' +
                       ' WHERE LUGG = '  + QuotedStr(JobNo) ;
      SQL.Text := StrSQL ;
      ExecNo := ExecSql ;

      if (ExecNo > 0) then
      begin
        Close;
        SQL.Clear;
        StrSQL := ' DELETE FROM TT_ORDER ' +
                  '  WHERE LUGG = '  + QuotedStr(JobNo) ;
        SQL.Text := StrSQL;
        ExecSql;
      end;

      Close ;
    end;
  except
    on E: Exception do
    begin
      qryHis.Close ;
      ErrorLogWRITE( 'Function fnIns_History ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;

end;


//==============================================================================
// fnIns_RfidHistory
//==============================================================================
procedure TfrmSCComm.fnIns_RfidHistory(Line_No: Integer);
var
  StrSQL : string;
  ExecNo : Integer;
begin
  StrSQL := '';
  try
    with qryHis do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' INSERT INTO TC_RFID_HIST (CRT_DT, UPD_DT, PORT_NO, ' +
                '         H00, H01, H02, H03, H04, H05, H06, H07, H08, H09, ' +
					      '  	      H10, H11, H12, H13, H14, H15, H16, H17, H18, H19, ' +
						    '         H20, H21, H22, H23, H24, H25, H26, H27, H28, H29, ' +
						    '         H30, H31, H32, H33, H34, H35, H36, H37, H38, H39, ' +
				        '   		  H40, H41, H42, H43, H44, H45, H46, H47, H48, H49, ' +
					      '     	  H50, H51, H52, H53, H54, H55, H56, H57, H58, H59, ' +
					      '	        H60, H61, H62, H63, H64, H65, H66, H67, H68, H69, ' +
					      '	        H70, H71, H72, H73, H74, H75, H76, H77, H78, H79, ' +
				        '   		  H80, H81, H82, H83, H84, H85, H86, H87, H88, H89, ' +
					      '     	  H90, H91, H92, H93, H94, H95, H96, H97, H98, H99) ' +
                ' SELECT GETDATE(), UPD_DT, PORT_NO, ' +
                '         H00, H01, H02, H03, H04, H05, H06, H07, H08, H09, ' +
		            '         H10, H11, H12, H13, H14, H15, H16, H17, H18, H19, ' +
		            '         H20, H21, H22, H23, H24, H25, H26, H27, H28, H29, ' +
		            '         H30, H31, H32, H33, H34, H35, H36, H37, H38, H39, ' +
	              '       	H40, H41, H42, H43, H44, H45, H46, H47, H48, H49, ' +
		            '         H50, H51, H52, H53, H54, H55, H56, H57, H58, H59, ' +
		            '         H60, H61, H62, H63, H64, H65, H66, H67, H68, H69, ' +
		            '         H70, H71, H72, H73, H74, H75, H76, H77, H78, H79, ' +
                '         H80, H81, H82, H83, H84, H85, H86, H87, H88, H89, ' +
                '         H90, H91, H92, H93, H94, H95, H96, H97, H98, H99  ' +
                '   FROM TC_RFID ' +
                '  WHERE PORT_NO = ' + QuotedStr(IntToStr(Line_No));
      SQL.Text := StrSQL ;
      ExecNo := ExecSql ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryHis.Close ;
      ErrorLogWRITE( 'Function fnIns_RfidHistory ' +
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
    with qryUpdate do
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
  StrSQL, StrLog, NewPos : String ;
begin
  Result := False ;

  if Flag = '1' then // �����԰�
  begin
    StrSQL := ' Select WMS_HL.DBO.fn_GetFreeLoc(0) as NewPos ';
  end else
  if Flag = '2' then // �����
  begin

    StrSQL := ' SELECT WMS_HL.DBO.fn_GetItemLoc(' + QuotedStr(SC_JOB[SC_NO].ITM_CD) +  ') as NewPos';
  end;

  try
    with qryPos do
    begin
      Close;
      SQL.Clear;
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof ) then
      begin                                                                  // Return Value
        if Copy(UpperCase(FieldByName('NewPos').AsString), 1, 2) = 'OK' then // OK:110101
        begin                                                                // OK:CELL_HOGI(1) + CELL_BANK(1) + CELL_BAY(2) + CELL_LEVEL(2)
          NewPos := Copy(FieldByName('NewPos').AsString, 5, 5) ;             // NewPos -> CELL_BANK(1) + CELL_BAY(2) + CELL_LEVEL(2)

          if Flag='1' then
          begin
            fnOrder_Update(SC_NO, 'DSTAISLE', FormatFloat('0000',StrToInt(Copy(NewPos,1,1)))) ;
            fnOrder_Update(SC_NO, 'DSTBAY'  , FormatFloat('0000',StrToInt(Copy(NewPos,2,2)))) ;
            fnOrder_Update(SC_NO, 'DSTLEVEL', FormatFloat('0000',StrToInt(Copy(NewPos,4,2)))) ;
            fnStockUpdate(NewPos, 'ID_STATUS', '3');
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
            fnStockUpdate(NewPos, 'ID_STATUS', '3');
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
// fnGetFreeLoc : �� �� ã��
//==============================================================================
function TfrmSCComm.fnGetFreeLoc : String;
var
  StrSQL, StrLog, NewPos : String ;
begin
  Result := '';

  try
    with qryPos do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' Select WMS_HL.DBO.fn_GetFreeLoc(0) as NewPos ';
      SQL.Text := StrSQL ;
      Open;

      if not ( Bof and Eof ) then
      begin                                                                    // Return Value
        if Copy(UpperCase(FieldByName('NewPos').AsString), 1, 2) = 'OK' then   // OK:110101
        begin                                                                  // OK:CELL_HOGI(1) + CELL_BANK(1) + CELL_BAY(2) + CELL_LEVEL(2)
          NewPos := Copy(FieldByName('NewPos').AsString, 5, 5) ;               // NewPos -> CELL_BANK(1) + CELL_BAY(2) + CELL_LEVEL(2)
          DisplayLog(1, StrLog, 'N', Length(StrLog)) ;
          Result := NewPos ;
        end else
        begin
          Result := '';
        end;
      end;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryPos.Close ;
      ErrorLogWRITE( 'Function fnGetFreeLoc ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// fnGetRFID_Data : TC_RFID ������ ������.
//==============================================================================
function TfrmSCComm.fnGetRFID_Data(PortNo: Integer; FName: String): String;
var
  StrSQL : String ;
begin
  Result := '' ;

  try
    with qryRfid do
    begin
      Close ;
      SQL.Clear;
      StrSQL := ' SELECT ' + FNAME +
                  ' FROM TC_RFID ' +
                 ' WHERE PORT_NO = ' + QuotedStr(IntToStr(PortNo));
      SQL.Text := StrSQL ;
      Open;

      Result := FieldByName(FName).AsString;

      Close ;
    end;
  except
    on E: Exception do
    begin
      QryDelete.Close ;
      ErrorLogWRITE( 'Function fnGetRFID_Data PortNo(' + IntToStr(PortNo) + ') ' +
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
// SetJobOrder [���� ������ ����]
//==============================================================================
function TfrmSCComm.SetJobOrder(PortNo: Integer; Gubn, ItemCode, NOWMC, EMG: String) : String;
var
  i : Integer;
  Loc: String;
  EventDesc : String;
begin
  try
    Result := '';

    if (Gubn = 'I') then
    begin
      // �� �� ã��
      Loc := fnGetFreeLoc;
      if (Loc = '') then Exit;

      // �԰��۾� ������ ����
      OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',Now) + FormatDateTime('HHNNSS',Now) ;
      OrderData.LUGG       := Format('%.4d', [GetJobNo(Gubn)]) ;  // �۾���ȣ
      OrderData.JOBD       := '1';     // �԰�����
      OrderData.IS_AUTO    := 'Y';     // �ڵ�����

      OrderData.SRCSITE    := '0001';  // ���� ȣ��
      OrderData.SRCAISLE   := '0000';  // ���� ��
      OrderData.SRCBAY     := '0000';  // ���� ��
      OrderData.SRCLEVEL   := Format('%.4d', [PortNo]);  // ���� �����̼�
      OrderData.DSTSITE    := '0001';   // �Ͽ� ȣ��
      OrderData.DSTAISLE   := Format('%.4d', [StrToInt(Copy(Loc, 1, 1))]) ;  // �Ͽ� ��
      OrderData.DSTBAY     := Format('%.4d', [StrToInt(Copy(Loc, 2, 2))]) ;  // �Ͽ� ��
      OrderData.DSTLEVEL   := Format('%.4d', [StrToInt(Copy(Loc, 4, 2))]) ;  // �Ͽ� ��
      OrderData.ID_CODE    := '';
      OrderData.NOWMC      := NOWMC; // 1: CV, 2 : SC Loading, 3 : SC Unloading, 4 : AGV
      OrderData.JOBSTATUS  := '3';
      OrderData.NOWSTATUS  := '3';
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
      OrderData.EMG        := EMG;
      OrderData.LINE_NO    := IntToStr(PortNo);
      OrderData.ITM_CD     := ItemCode;
      OrderData.UP_TIME    := 'GETDATE()';

      // �� ������Ʈ, �԰���
      fnStockUpdate(Loc, 'ID_STATUS', '4');

      EventDesc := '�԰��۾����� �۾���ȣ[' + OrderData.LUGG + '] ����['+ IntToStr(PortNo) +
                   ' ��ġ[' + OrderData.DSTAISLE + '-' + OrderData.DSTBAY + OrderData.DSTLEVEL + ']';
    end
    else
    begin
      // ǰ�� ã��
      // Loc = 10101 ��(1)/��(2)/��(2)
      Loc := fnGetStockLoc(ItemCode);
      if (Loc = '') then Exit;

      // ����۾� ������ ����
      OrderData.REG_TIME   := FormatDateTime('YYYYMMDD',Now) + FormatDateTime('HHNNSS',Now) ;
      OrderData.LUGG       := Format('%.4d', [GetJobNo(Gubn)]) ;  // �۾���ȣ
      OrderData.JOBD       := '2';     // �������
      OrderData.IS_AUTO    := 'Y';     // �ڵ�����

      OrderData.SRCSITE    := '0001' ;  // ���� ȣ��
      OrderData.SRCAISLE   := Format('%.4d', [StrToInt(Copy(Loc, 1, 1))]) ;  // ���� ��
      OrderData.SRCBAY     := Format('%.4d', [StrToInt(Copy(Loc, 2, 2))]) ;  // ���� ��
      OrderData.SRCLEVEL   := Format('%.4d', [StrToInt(Copy(Loc, 4, 2))]) ;  // ���� ��
      // ������ �� ��-��-���� AGV->CV�̵� �Ϸ� �� ����
      OrderData.DSTSITE    := '0001';
      OrderData.DSTAISLE   := '0000';
      OrderData.DSTBAY     := '0000';
      OrderData.DSTLEVEL   := Format('%.4d', [PortNo]);
      OrderData.ID_CODE    := '';
      OrderData.NOWMC      := NOWMC; // 1: CV, 2 : SC Loading, 3 : SC Unloading, 4 : AGV
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
      OrderData.EMG        := EMG;
      OrderData.LINE_NO    := IntToStr(PortNo);
      OrderData.ITM_CD     := ItemCode;
      OrderData.UP_TIME    := 'GETDATE()';

      // �� ������Ʈ, �����
      fnStockUpdate(Loc, 'ID_STATUS', '5');

      EventDesc := '����۾����� �۾���ȣ[' + OrderData.LUGG + '] ����['+ IntToStr(PortNo) +
                   ' ��ġ[' + OrderData.SRCAISLE + '-' + OrderData.SRCBAY + OrderData.SRCLEVEL + ']';
    end;

    if not MainDm.MainDB.InTransaction then
           MainDm.MainDB.BeginTrans;

    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text :=
      ' INSERT INTO TT_ORDER (                             ' + #13#10+
      '    REG_TIME, LUGG, JOBD, IS_AUTO,                  ' + #13#10 +
      '    SRCSITE, SRCAISLE, SRCBAY, SRCLEVEL,            ' + #13#10 +
      '    DSTSITE, DSTAISLE, DSTBAY, DSTLEVEL,            ' + #13#10 +
      '    NOWMC, JOBSTATUS, NOWSTATUS, BUFFSTATUS,        ' + #13#10 +
      '    JOBREWORK, JOBERRORT, JOBERRORC, JOBERRORD,     ' + #13#10 +
      '    JOB_END, CVFR, CVTO, CVCURR,                    ' + #13#10 +
      '    ETC, EMG, ITM_CD, LINE_NO, UP_TIME              ' + #13#10 +
      '  ) VALUES (                                        ' + #13#10 +
      '    :REG_TIME, :LUGG, :JOBD, :IS_AUTO,              ' + #13#10 +
      '    :SRCSITE, :SRCAISLE, :SRCBAY, :SRCLEVEL,        ' + #13#10 +
      '    :DSTSITE, :DSTAISLE, :DSTBAY, :DSTLEVEL,        ' + #13#10 +
      '    :NOWMC, :JOBSTATUS, :NOWSTATUS, :BUFFSTATUS,    ' + #13#10 +
      '    :JOBREWORK, :JOBERRORT, :JOBERRORC, :JOBERRORD, ' + #13#10 +
      '    :JOB_END, :CVFR, :CVTO, :CVCURR,                ' + #13#10 +
      '    :ETC, :EMG, :ITM_CD, :LINE_NO, GETDATE()        ' + #13#10 +
      ' )';


      i := 0;
      Parameters[i].Value := OrderData.REG_TIME;    Inc(i);
      Parameters[i].Value := OrderData.LUGG;        Inc(i);
      Parameters[i].Value := OrderData.JOBD;        Inc(i);
      Parameters[i].Value := OrderData.IS_AUTO;     Inc(i);
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
      ExecSql;
      Close;
    end;
    Result := OrderData.LUGG;

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
function TfrmSCComm.SetAcsResponse(PortNo : Integer) : Boolean;
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
                 '    AND PORT_NO = ' + QuotedStr(IntToStr(PortNo)) ;

      SQL.Text := StrSQL;
      Open;
      if (Bof and Eof) then
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' INSERT INTO TC_ACS_COMM (                           ' + #13#10 +
                    '    GUBN, PORT_NO, HEART_BEAT,                       ' + #13#10 +
                    '    LINE_NAME_SOURCE, LINE_NO_SOURCE                 ' + #13#10 +
                    '    PORT_NO_SOURCE, LINE_NAME_DEST,                  ' + #13#10 +
                    '    LINE_NO_DEST, PORT_NO_DEST, MODEL_NO,            ' + #13#10 +
                    '    CALL_REQUEST, CALL_ANSWER, DOCKING_REQ_APPR,     ' + #13#10 +
                    '    DOCKING_COMPLETE, STATUS, CRT_DT, UPD_DT         ' + #13#10 +
                    '  ) VALUES (                                         ' + #13#10 +
                    '    :GUBN, :PORT_NO, :HEART_BEAT,                    ' + #13#10 +
                    '    :LINE_NAME_SOURCE, :LINE_NO_SOURCE               ' + #13#10 +
                    '    :PORT_NO_SOURCE, :LINE_NAME_DEST,                ' + #13#10 +
                    '    :LINE_NO_DEST, :PORT_NO_DEST, :MODEL_NO,         ' + #13#10 +
                    '    :CALL_REQUEST, :CALL_ANSWER, :DOCKING_REQ_APPR,  ' + #13#10 +
                    '    :DOCKING_COMPLETE, :STATUS, GETDATE(), GETDATE() ' + #13#10 +
                    '  )';
        i := 0;
        Parameters[i].Value := 'SEND';                        Inc(i);
        Parameters[i].Value := IntToStr(PortNo);              Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Heart_Beat;         Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Line_Name_Source;   Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Line_No_Source;     Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Port_No_Source;     Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Line_Name_Dest;     Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Line_No_Dest;       Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Port_No_Dest;       Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Model_No;           Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Call_Request;       Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Call_Answer;        Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Docking_Approve;    Inc(i);
        Parameters[i].Value := Tx_AcsData[PortNo].Docking_Complete;   Inc(i);
      end
      else
      begin
        Close;
        SQL.Clear;
        StrSQL := ' UPDATE TC_ACS_COMM ' +
                    '    SET HEART_BEAT       = ' + QuotedStr(Tx_AcsData[PortNo].Heart_Beat) +
                    '      , LINE_NAME_SOURCE = ' + QuotedStr(Tx_AcsData[PortNo].Line_Name_Source) +
                    '      , LINE_NO_SOURCE   = ' + QuotedStr(Tx_AcsData[PortNo].Line_No_Source) +
                    '      , PORT_NO_SOURCE   = ' + QuotedStr(Tx_AcsData[PortNo].Port_No_Source) +
                    '      , LINE_NAME_DEST   = ' + QuotedStr(Tx_AcsData[PortNo].Line_Name_Dest) +
                    '      , LINE_NO_DEST     = ' + QuotedStr(Tx_AcsData[PortNo].Line_No_Dest) +
                    '      , PORT_NO_DEST     = ' + QuotedStr(Tx_AcsData[PortNo].Port_No_Dest) +
                    '      , MODEL_NO         = ' + QuotedStr(Tx_AcsData[PortNo].Model_No) +
                    '      , CALL_REQUEST     = ' + QuotedStr(Tx_AcsData[PortNo].Call_Request) +
                    '      , CALL_ANSWER      = ' + QuotedStr(Tx_AcsData[PortNo].Call_Answer) +
                    '      , DOCKING_REQ_APPR = ' + QuotedStr(Tx_AcsData[PortNo].Docking_Approve) +
                    '      , DOCKING_COMPLETE = ' + QuotedStr(Tx_AcsData[PortNo].Docking_Complete) +
                    '      , STATUS           = ' + QuotedStr(Tx_AcsData[PortNo].Status) +
                    '      , UPD_DT           = GETDATE() ' +
                    '  WHERE GUBN = ''SEND'' ' +
                    '    AND PORT_NO = ' + QuotedStr(IntToStr(PortNo));
        SQL.Text := StrSQL;
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
procedure TfrmSCComm.fnACS_Update(PortNo: Integer; Gubn, FName, FValue: String);
var
  StrSQL : string;
begin
  try
    with qryUpdate do
    begin
      Close;
      SQL.Clear;
      StrSQL := ' UPDATE TC_ACS_COMM ' +
                '    SET ' + FName + ' = ' + QuotedStr(FValue) +
                '  WHERE PORT_NO = ' + QuotedStr(IntToStr(PortNo)) +
                '    AND GUBN = ' + QuotedStr(Gubn);
      SQL.Text := StrSQL ;
      ExecSQL ;
      Close ;
    end;
  except
    on E: Exception do
    begin
      qryUpdate.Close ;
      ErrorLogWRITE( 'Procedure fnACS_Update PortNo(' + IntToStr(PortNo) + ') ' +
                     'Error[' + E.Message + '], ' + 'SQL [' + StrSQL + ']' );
    end;
  end;
end;

//==============================================================================
// GetJobNo [�۾���ȣ ����]
//==============================================================================
function TfrmSCComm.GetJobNo(Gubn: String) : Integer;
var
  returnValue : String;
  iType : Integer;
begin
  try
    Result := 0;
    if (Gubn = 'I') then
    begin
      iType := 1;
    end else
    if (Gubn = 'O') then
    begin
      iType := 2;
    end else
    begin
      iType := 3;
    end;


    with PD_GET_JOBNO do
    begin
      Close;
      ProcedureName := 'PD_GET_JOBNO';
      Parameters.ParamByName('@I_TYPE').Value := iType;
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

