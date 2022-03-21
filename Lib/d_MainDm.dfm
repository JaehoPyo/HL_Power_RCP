object MainDm: TMainDm
  OldCreateOrder = False
  Height = 79
  Width = 205
  object MainDB: TADOConnection
    ConnectionString = 
      'Provider=OraOLEDB.Oracle.1;Password=DYMOSPASS;Persist Security I' +
      'nfo=True;User ID=DYMOSUSER;Data Source=COMMSERV'
    LoginPrompt = False
    Provider = 'OraOLEDB.Oracle.1'
    AfterConnect = MainDBAfterConnect
    BeforeConnect = MainDBBeforeConnect
    AfterDisconnect = MainDBAfterDisconnect
    BeforeDisconnect = MainDBBeforeDisconnect
    Left = 12
    Top = 8
  end
  object PD_INS_PGM_HIST: TADOStoredProc
    Connection = MainDB
    ProcedureName = 'PD_INS_PGM_HIST'
    Parameters = <
      item
        Name = 'I_MENU_ID'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_HIST_TYPE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_PGM_FUNCTION'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_EVENT_NAME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_EVENT_DESC'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_COMMAND_TYPE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_COMMAND_TEXT'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_PARAM'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_ERROR_MSG'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_USER_ID'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'O_ERR_CD'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdOutput
        Size = 4000
        Value = Null
      end
      item
        Name = 'O_ERR_MSG'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdOutput
        Size = 4000
        Value = Null
      end>
    Left = 61
    Top = 7
  end
end
