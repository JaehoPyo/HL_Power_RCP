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
     HOME_BACK      ,       // RCP Ȩ���� �䱸
     DOUBLE_RETRY   ,       // �����԰� ��⵿
     EMPTY_RETRY    ,       // ����� ��⵿
     DOUBLE_RESET   ,       // �����԰� RESET
     EMPTY_RESET    ,       // ����� RESET
     COMPLETE_RESET ,       // �ϷẸ�� RESET
     JOB_CANCEL     ,       // �۾�����
     MODE_CHANGE    : char; // ��庯�� (0:����,1:�ڵ�,2:����,3:�������)
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
    ID_ORDLUGG     ,          // �۾� ��ȣ
    ID_REGTIME     ,          // �۾� ��� �ð�
    ID_ORDDATE     ,          // �۾� ��� ����
    ID_ORDTIME     ,          // �۾� ��� �Ͻ�

    IO_TYPE        ,          // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )

    LOAD_BANK      ,          // ����(��)
    LOAD_BAY       ,          // ����(��)
    LOAD_LEVEL     ,          // ����(��)
    UNLOAD_BANK    ,          // �Ͽ�(��)
    UNLOAD_BAY     ,          // �Ͽ�(��)
    UNLOAD_LEVEL   ,          // �Ͽ�(��)

    ITM_CD         ,          // ������ �ڵ�

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


    SC_STEP        ,          // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )

    JOB_RETRY      ,          // ��⵿
    JOB_CANCEL     ,          // �۾����
    JOB_COMPLETE   ,          // �۾��Ϸ� Reset

    DATA_RESET     ,          // �������ʱ�ȭ

    MOVE_ON        : String   // �⵿����
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
    SCORD_NO  ,           // �۾���ȣ
    SCORD_D100,           // ���� ��
    SCORD_D101,           // ���� ��
    SCORD_D102,           // ���� ��
    SCORD_D103,           // �Ͽ� ��
    SCORD_D104,           // �Ͽ� ��
    SCORD_D105,           // �Ͽ� ��
    SCORD_D106,           // ����
    SCORD_D107,           // ����
    SCORD_D108,           // ����
    SCORD_D109,           // ����
    SCORD_D110,           // �⵿���� and Data Reset
    SCORD_D111,           // Door On/Off
    SCORD_ST  ,           // ����
    SCORD_DT  : String ;  // ���� �ð�
  end;

  TITEM_INFO = Record
    ITM_CD       ,         // ǰ���ڵ�
	  MACHTP       ,         // ���ӱ����
	  ITM_YN       ,         // ��ǰ����
	  ITM_SIZE     ,         // PARTNO
	  ITM_QTY      ,         // ��������
	  MODEL_SPEC   ,         // ��������
	  BYPASS       ,         // ��������
	  SHIFT_GOODS  ,         // �������
	  TM_CODE      ,         // T/M�ڵ�
	  PERF_CAR     ,         // �ϼ��� ����
	  UP_DATE      ,         // ��������
	  CR_DATE      ,         // CR_DATE
	  MEMO         ,         // ��������
	  ID_DESC      ,         // ǰ���
	  ITM_DESC     ,         // ǰ���
	  HIDE_YN      ,         //
	  MODEL_CODE   : String ;// ��ǰ�ڵ�
  end;



















implementation

end.

