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
end
