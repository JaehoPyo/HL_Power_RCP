unit h_MainLib;

interface

uses inifiles,Windows, Sysutils, ExtCtrls, ADODB, ScktComp, Graphics ;

Const
  WRHS : String = 'PRODUCT';

  LogFileName  : String = '.\Log\SCComm';

  INI_PATH : String = 'RCP_SCC.INI';

  START_SCNO = 1 ; // START SC NO
  End_SCNO   = 1 ; // END SC NO
  MaxSC_Cnt  = 1 ; // SC COUNT

  START_STATION = 1;
  END_STATION   = 6;

  IN_CV_NO  : Array [1..1] of String = ('100') ;
  OT_CV_NO  : Array [1..1] of String = ('100') ;
Type
  TScStatus = ( START, STANDBY, READY,
                DATA1, ORDER1, RESET1, ERR1,
                DATA2, ORDER2, RESET2, ERR2,
                RETRY_REQ, CANCEL_REQ, DATAERR ) ;

  TSCJobMode = (None, StoreIn, StoreOut, RackToRack) ;

  TCONTROL_FLAG = ( ComStart, ComRead, ComWrite );

  TSts_WMS = Record
  Case Integer Of
    1 : ( ALL : Array [01..08] Of char );
    2 : (
     HOME_BACK      ,       // RCP 홈복귀 요구
     DOUBLE_RETRY   ,       // 이중입고 재기동
     EMPTY_RETRY    ,       // 공출고 재기동
     DOUBLE_RESET   ,       // 이중입고 RESET
     EMPTY_RESET    ,       // 공출고 RESET
     COMPLETE_RESET ,       // 완료보고 RESET
     JOB_CANCEL     ,       // 작업삭제
     MODE_CHANGE    : char; // 모드변경 (0:수동,1:자동,2:원격,3:비상정지)
     );
  end;


  TDB_Info = Record
    DBProvider, DBAlias, DBUser, DBPswd : String;
  end;

  TJobOrder = Record
   REG_TIME,
   LUGG,
   JOBD,
   IS_AUTO,
   SRCSITE,
   SRCAISLE,
   SRCBAY,
   SRCLEVEL,
   DSTSITE,
   DSTAISLE,
   DSTBAY,
   DSTLEVEL,
   NOWMC,
   JOBSTATUS,
   NOWSTATUS,
   BUFFSTATUS,
   JOBREWORK,
   JOBERRORT,
   JOBERRORC,
   JOBERRORD,
   JOB_END,
   CVFR,
   CVTO,
   CVCURR,
   ETC,
   EMG,
   ITM_CD,
   JOB_MODEL_NO,
   JOB_NEW_BMA,
   LINE_NO,
   UP_TIME,
   ID_CODE : String;
  end;

  TRx_AcsData = Record
    Heart_Beat       : String;
    Line_Name_Source : String;
    Line_No_Source   : String;
    Port_No_Source   : String;
    Line_Name_Dest   : String;
    Line_No_Dest     : String;
    Port_No_Dest     : String;
    Model_No         : String;
    Call_Request     : String;
    Call_Answer      : String;
    Docking_Request  : String;
    Docking_Complete : String;
    Status           : String;
    Sell_Type        : String;
  End;

  TTx_AcsData = Record
    Heart_Beat       : String;
    Line_Name_Source : String;
    Line_No_Source   : String;
    Port_No_Source   : String;
    Line_Name_Dest   : String;
    Line_No_Dest     : String;
    Port_No_Dest     : String;
    Model_No         : String;
    Call_Request     : String;
    Call_Answer      : String;
    Docking_Approve  : String;
    Docking_Complete : String;
    Status           : String;
    Sell_Type        : String;
  End;

  TPLC_VAL = Record
    Curtain : Array [1..6] of String;
    RFID_Read : Array[1..6] of String;
    Alram : String;
  End;

  TSC_JOB = Record
    ID_ORDLUGG     ,          // 작업 번호
    ID_REGTIME     ,          // 작업 등록 시간
    ID_ORDDATE     ,          // 작업 등록 일자
    ID_ORDTIME     ,          // 작업 등록 일시

    IO_TYPE        ,          // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )

    LOAD_BANK      ,          // 적재(열)
    LOAD_BAY       ,          // 적재(연)
    LOAD_LEVEL     ,          // 적재(단)
    UNLOAD_BANK    ,          // 하역(열)
    UNLOAD_BAY     ,          // 하역(연)
    UNLOAD_LEVEL   ,          // 하역(단)

    ITM_CD         ,          // 아이템 코드

    RF_LINE_NAME1  ,
    RF_LINE_NAME2  ,
    RF_PALLET_NO1  ,
    RF_PALLET_NO2  ,
    RF_MODEL_NO1   ,
    RF_MODEL_NO2   ,
    RF_BMA_NO      ,
    RF_AREA ,
    RF_PALLET_BMA1 ,
    RF_PALLET_BMA2 ,
    RF_PALLET_BMA3 ,
    RF_NEW_BMA     ,


    SC_STEP        ,          // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )

    JOB_RETRY      ,          // 재기동
    JOB_CANCEL     ,          // 작업취소
    JOB_COMPLETE   ,          // 작업완료 Reset

    DATA_RESET     ,          // 데이터초기화

    MOVE_ON        : String   // 기동지시
  end;

  TSC_STATUS = Record
    D200  ,
    D201  ,
    D202  ,
    D203  ,
    D204  ,
    D205  ,
    D206  ,
    D207  ,
    D208  ,
    D209  : String ;
    D210  : Array [0..15] of String ;
    D211  : Array [0..15] of String ;
    D212  : Array [0..15] of String ;
    D213  : Array [0..15] of String ;
  end;

  TRFID_DATA = Record
    Line_Name_1      ,
    Line_Name_2      ,
    Pallet_No_1      ,
    Pallet_No_2      ,
    Model_No_1       ,
    Model_No_2       ,
    BMA_No           ,
    Area             ,
    BMA_1            ,
    BMA_2            ,
    BMA_3            ,
    NEW_BMA           : String;
  End;


  TPLC_ORDER = Record
    ORDER  ,
    D111   ,
    ORD_ST ,
    ORD_DT : String;
  End;

  TSC_ORDER = Record
    SCORD_NO  ,           // 작업번호
    SCORD_D100,           // 적재 열
    SCORD_D101,           // 적재 연
    SCORD_D102,           // 적재 단
    SCORD_D103,           // 하역 열
    SCORD_D104,           // 하역 연
    SCORD_D105,           // 하역 단
    SCORD_D106,           // 예비
    SCORD_D107,           // 예비
    SCORD_D108,           // 예비
    SCORD_D109,           // 예비
    SCORD_D110,           // 기동지시 and Data Reset
    SCORD_D111,           // Door On/Off
    SCORD_ST  ,           // 상태
    SCORD_DT  : String ;  // 지시 시간
  end;

  TITEM_INFO = Record
    ITM_CD       ,         // 품목코드
	  MACHTP       ,         // 변속기기종
	  ITM_YN       ,         // 제품여부
	  ITM_SIZE     ,         // PARTNO
	  ITM_QTY      ,         // 장착수량
	  MODEL_SPEC   ,         // 적용차종
	  BYPASS       ,         // 엔진기종
	  SHIFT_GOODS  ,         // 구동방식
	  TM_CODE      ,         // T/M코드
	  PERF_CAR     ,         // 완성차 구분
	  UP_DATE      ,         // 생성일자
	  CR_DATE      ,         // CR_DATE
	  MEMO         ,         // 변경일자
	  ID_DESC      ,         // 품목명
	  ITM_DESC     ,         // 품목명
	  HIDE_YN      ,         //
	  MODEL_CODE   : String ;// 제품코드
  end;



















implementation

end.

