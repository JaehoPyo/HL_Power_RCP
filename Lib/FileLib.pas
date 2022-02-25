unit FileLib;

interface
uses
   Windows, SysUtils, Registry,inifiles, Variants, h_ReferLib;

     function  Decrypt(const S: String; Key: Word): String;
     function  Encrypt(const S: String; Key: Word): String;
     function  FileFine(FileName, FindName : string) : string;
     procedure DirMake(Filename: string);
     procedure LogWrite(Filename:string; Msg: string);
     procedure LogWriteII(Filename, Msg: string);
     procedure LogFileCopy(Filename:string);
     procedure LogFileCopyII(Filename:string);
     procedure LogRead (Filename:string; Msg: string);
     procedure IPWrite(Filename, Msg : string);
     function  IPRead(Filename : String) : String;
     Function  FileGetDateUser( FileName : string) : Integer;
     function  InitIPRead(var MyIP, FtpIP, HostIP, HostPort : String ) : Integer;
     function  SpaceAdd(Msg : string; Len : Integer) : string;
     function  CharAdd(Msg : string; Len : Integer; ch:Char) : string;
     function  SpaceAddint(Msg : string; Len : Integer) : string;
     procedure DabaseWriteInit(Filename, Msg: string);
     procedure DabaseWriteData(Filename, Msg: string);

     function  Change_16Byte_TO_HEX(Byte16 :string) : String; //'0000000100100011' -> 0123
     Function  HexaToChar(Rs : string ) : String;         // chr($FF) -> 'FF'
     Function  CharToHexa(Rs : string ) : char;           // 'FF' -> chr($FF)
     Function  CharToHexaChar(Rs : char ) : String;       // 'FF' -> chr($FF)
     Function  HexaCharToHexa(Rs : string ) : char;       // 'FF' -> chr($FF)
     Function  CharStrToBinStr(Rs : string ) : String;    // '01' -> '00000001'
     Function  CharStrToBinStrII(Rs : string ) : String;  // '01' -> '00001000'
     function  HexaTo1Char(ch : char) : char;             // chr($F)-> 'F'
     function  CharTo1Hexa(ch : char) : char;             // 'F'    -> chr($F)
     function  Data16To10(Rs : string) : integer;         // 'F'    -> 15
     function  Data10To16(Rs : Integer) : string;         // 15     -> 'F'
     function  DecToHexa(Rs : Integer) : string;          // 1024   -> Hexa('0100')
     Function  Change4Byte( Rs : String) : String;        // '1234' -> '4321'
     Function  Change2Byte( Rs : String) : String;        // '1234' -> '2143'
     Function  Change4Bit( Rs : String) : String;         // '0011' -> '1100'
     Function  ChangeWord( Rs : String) : String;         // '1234' -> '84C2'
     Function  CharToHexaStr( Rs : char; ShowByte : Byte = 2 ):String; // 'K'->'4B'
     Function  ASCII2ToChar(Chr1, Chr2:String):Char ;
     function GetBCC(argBuff : Array of Char; argStart, argEnd:Integer): String ;
     
     function  Data10To16II(Str : String) : Char;         // '18' -> chr($12)
     function  Data10To16Str(Str : String) : String;      // '2000' -> Hexa('07D0')
     function  HexaToDecimal( xHexa : String ) : String;   // '11' ->  '17'
     function  HexaToDecimal4( xHexa : String ) : String;   // Hexa('03E8') ->  '1000'
     function  CharToBinString( ch : Char ) : String;     // 'A' -> '1010'
     function  BinStringToChar( BinS : String ) : Char;   // '0010' -> '2'
     function  ZeroToOne( Rs : Char ) : Char;             // '0' -> '1', '1'->'0'

     Function  ChangeToConversion(Rs, Flag : string ) : String;
     Function  ChangeToConversionII(Rs, Flag : string ) : String;

     function  DataSum( SrcData : String ) : Char;        // data를 sum하여 1char로 변환
     function  DataSum2( SrcData : String ) : String;     // data를 sum하여 2char로('FF')변환
     function  Data1Bosu( SrcData : Char ) : Char;        // 1의 보수

     Function  GetComputerName : String;
     Function  GetErrorMessage( errStr : String) : String; 
     Function  GetErrorMessageNo( eCode : Integer ) : String;
     Function  GetErrorHome( errStr : String) : Boolean;

     procedure FileInit(Filename: string);
     procedure FileAdd(Filename, Msg: string);
     Function  ReadIni ( IniFileName, MainString, SubString :String ):String ;
     Function  WriteIni( IniFileName, MainString, SubString, WriteString :String ): Boolean ;
     Function  GetName( FileName :String ): String ;

     function  LTrim(const Str: String): String; //LTrim() - 문자열 왼쪽의 모든 공백을 제거
     function  RTrim(Str: String): String;//RTrim() - 문자열 오른쪽의 모든 공백을 제거
     function  Trim(Str: String): String;//Trim() - LTrim & RTrim
     function  RightStr(const Str: String; Size: Word): String;//RightStr() - 문자열의 오른쪽에서 부분문자열
     function  LeftStr(const Str: String; Size: Word): String;//LeftStr() - 문자열의 왼쪽에서 부분문자열
     function  MidStr(Const Str: String; Size: Word): String;//MidStr() - 문자열의 중간에서 부분문자열
     function  RPAD(Msg : string; Len : Integer; Addch:Char = '0') : string;
     function  LPAD(Msg : string; Len : Integer; Addch:Char = '0') : string;

     function  chStrToInt( Str : String) : Integer;
     function  GetMandoLotNo(Str : String) : String;
     function  GetMandoLotNoDate(Str : String) : String;
     Function  fnHanChk (Str : String; Cnt : Integer) : String;
     Function  BarIndex(xinStr : String) : String;
     Function  sameDataCheck( SrcStr, FindStr : String) : Boolean;
     Function  StrToChar(Str: String; Cnt: integer) : Char;

     // 2005.05.25 YEH Add.
     function HexToInt(Hex : string) : Integer ;//Cardinal;   {Hex-->Integer}
     function bytetohex(src: byte): string;   {byte-->hex}
     function Check_BCC(a,b:char):char;

     function StrBin8ToDecimal2(Rs:String):String;

const
  MonChar : array[1..12] of char = (  'A', 'B', 'C', 'D', 'E', 'F',
                                      'G', 'H', 'I', 'J', 'K', 'L' );
  DayChar : array[1..31] of char = (  'A', 'B', 'C', 'D', 'E',
                                      'F', 'G', 'H', 'I', 'J',
                                      'K', 'L', 'M', 'N', 'O',
                                      'P', 'Q', 'R', 'S', 'T',
                                      'U', 'V', 'W', 'X', 'Y',
                                      'Z', '1', '2', '3', '4',
                                      '5' );


  C1     = 45673; // 기준키1
  C2     = 89724; // 기준키2

  MY_KEY = 65961; // 사용자키

//  F_HANDLE            = $FFFFFFFF;
//  MemoryName          = 'SharedMemory';

  Space     = #$20;
  backspace = #8 ;
  del       = #48;   //if not ((Key in [del,backspace,'0'..'9'])) then   Key := #0;
  Stx       = #2 ;
  Etx       = #3 ;
  CR        = #13;   //D
  LF        = #10;   //A
  ACK       = #6 ;
  NAK       = #21;
  Enq       = #5 ;



  // ----------------------------------------------
  // 메모리에서 사용되는 값들에대한 정의이다
  // ----------------------------------------------
  // SC Status
  ValueOfS1Emegency : array[0..3,1..2] of String = (
                    ('3','Error'),
                    ('0','초기'),('1','정상'),('2','정지')
                                         );   //
  ValueOfS1Mode : array[0..4,1..2] of String = (
                    ('4','Error'),
                    ('0','초기'),('1','자동'),('2','반자동'),('3','수동')
                                         );   //
  ValueOfS1Move : array[0..4,1..2] of String = (
                    ('4','Error'),
                    ('0','초기'),('1','대기중'),('2','동작중'),('3','에러')
                                         );   //
  ValueOfS1Stock : array[0..2,1..2] of String = (  //화물정보
                    ('2','Error'),
                    ('0','없음'),('1','있음')
                                         );   //
  ValueOfGubun : array[0..7,1..2] of String = (
                    ('7','Error'),
                    ('0','초기'),('1','입고'),('2','출고'),('3','직출고')
                    ,('4','이동'),('5','작업대이동'),('8','이중입고재지정')
                                         );   //
  ValueOfS1End : array[0..2,1..2] of String = (
                    ('2','Error'),
                    ('0','미완료'),('1','완료')
                                         );   //

  // SC Data Status
  ValueOfS2Move : array[0..7,1..2] of String = (
                    ('7','Error'),
                    ('0','초기'),('1','대기'),('2','작업중'),('3','완료'),
                    ('4','취소'),('5','에러'),('6','재작업')
                                         );   //
  ValueOfS2End : array[0..3,1..2] of String = (
                    ('3','Error'),
                    ('0','초기'),('1','미완료'),('2','완료')
                                         );   //
  ValueOfS2Write : array[0..4,1..2] of String = (
                    ('3','Error'),
                    ('0','초기'),('1','Send'),('2','Recv'),('3','진행중')
                                         );   //


  // 지시 데이터
  ValueOfOrder : array[0..2,1..2] of String = (
                    ('2','Error'),
                    ('0','INV'),('1','RCP')
                                         );   //
  ValueOfOrderEnd : array[0..7,1..2] of String = (
                    ('7','Error'),
                    ('0','초기'),('1','대기'),('2','지시'),('3','작업중'),
                    ('4','완료'),('5','취소'),('6','재작업')
                                         );   //
  ValueOfOrderSend : array[0..3,1..2] of String = (
                    ('3','Error'),
                    ('0','초기'),('1','전송'),('2','미전송')
                                         );   //

  // 전송된 작업번호
  ValueOfJobLugg : array[0..4,1..2] of String = (
                    ('3','Error'),
                    ('0','초기'),('1','대기'),('2','완료'),('3','전송')
                                         );   //


  // ***********************************************************
  // 공유메모리 바이트 수 ( 해당배열내 Byte 수를 표한다)
  // ***********************************************************
  MemConfig : array[1..6, 1..3] of Integer = ( // Byte * 건수 * 항목수
                                         ( 40 ,  5,  6),  // 프로그램 상태
                                         ( 40 ,  3, 12),  // SC 상태
                                         ( 50 ,  3, 14),  // SC 지시
                                         (100 , 30, 24),  // 작업지시
                                         ( 10 , 40,  4),  // 지시번호정보
                                         (  1 , 50,  1)   // CV 정보
                                         );      //


  // ***********************************************************
  //
  // 상세항목의 길이를 기록한 내용
  //
  // ***********************************************************
  MemCS : array[1..6] of Integer = (  //40 Byte
                                         10,  //   Pgrogram Name
                                         12,  //   시작시간
                                          3,  //   통신 On&Off
                                          6,  //   기록시간
                                          1,  //   사용여부
                                          8   //   여분버퍼
                                         );   //
  MemSC1 : array[1..12] of Integer = (  // 40 Byte
                                          3,   //   크레인 온/오프
                                          1,   //   긴급정지
                                          1,   //   모드
                                          1,   //   이동상태
                                          1,   //   화물유무 구분
                                          4,   //   이상코드
                                          4,   //   주행위치
                                          4,   //   승강위치
                                          4,   //   작업번호
                                          1,   //   입출고 구분
                                          1,   //   작업완료
                                         15    //   기타
                                         );   //
  MemSC2 : array[1..14] of Integer = (   // 50 Byte
                                          4,   //   작업번호
                                          1,   //   작업대기정보
                                          1,   //   완료여부
                                          1,   //   입출고구분
                                          4,   //   출발열
                                          4,   //   출발행
                                          4,   //   출발높이
                                          4,   //   출발작업대
                                          4,   //   도착행
                                          4,   //   도착열
                                          4,   //   도착높이
                                          4,   //   도착작업대
                                          1,   //   지시상태
                                         10   //   기타
                                         );   //
  MemOD : array[1..24] of Integer = (    //100 Byte
                                          4,   //   작업번호
                                          1,   //   생성자
                                          1,   //   완료정보
                                          1,   //   입출고구분
                                          1,   //   작업보고
                                          1,   //   우선순위
                                          2,   //   Error Code.
                                          2,   //   SC No.
                                          4,   //   출발열
                                          4,   //   출발행
                                          4,   //   출발높이
                                          4,   //   출발작업대SC
                                          4,   //   출발작업대CV
                                          4,   //   도착행
                                          4,   //   도착열
                                          4,   //   도착높이
                                          4,   //   도착작업대SC
                                          4,   //   도착작업대CV
                                         12,   //   지시시간
                                         12,   //   작업시간
                                          1,   //   DB Update JobEnd (2)로
                                          1,   //   기타
                                         13,   //   기타
                                          8    //   기타
                                         );   //

  MemLugg : array[1..4] of Integer = (  //10 Byte
                                         4,  //   LuggNo
                                         1,  //   코드 (1:대기, 2:완료,3:전송)
                                         3,  //   생성자 (RCP,INV)
                                         2   //   여분버퍼
                                         );   //



implementation


function HexToInt(Hex : string) : Integer ;//Cardinal;   {Hex-->Integer}
const
  cHex = '0123456789ABCDEF';
var 
  loop : integer;
  mult, i : int64;
begin
  result := 0;
  mult := 1;
  for loop := length(Hex) downto 1 do
  begin
    i := pos(Hex[loop],cHex)-1;
    if (i < 0) then i := 0;
    inc(result,(i*mult));
    mult := mult * 16;
  end;
  Result := Result ;
end;

function bytetohex(src: byte): string;   {byte-->hex}
begin
  setlength(result, 2);
  asm
  mov edi, [result]
  mov edi, [edi]
  mov al, src
  mov ah, al
  shr al, 4
  add al, '0'
  cmp al, '9'
  jbe @@outcharlo
  add al, 'a'-'9'-1
@@outcharlo:
  and ah, $f
  add ah, '0'
  cmp ah, '9'
  jbe @@outchar
  add ah, 'a'-'9'-1
@@outchar:
  stosw
  end;
end;

function Check_BCC(a,b:char):char;
var
  HBCC1, LBCC1, HBCC2, LBCC2  : Byte ;
  ba, bb : byte ;
  HSUM, LSUM, Temp : Byte ;
  sa, sb : string ;
  {str1,} TStr : String ;   // Log 용 변수.
begin
  ba := byte(a) ;
  bb := byte(b) ;
  sa := IntToHex(ba,2);
  sb := IntToHex(bb,2);

//  Form1.Memo.Lines.Add('BCC Check : P1[' + sa + '], P2[' + sb + ']') ;
  HBCC1 := Data16To10(copy(sa, 1,1));  //StrToIntDef(copy(sa, 1,1),0) ;
  LBCC1 := Data16To10(copy(sa, 2,1));  //StrToIntDef(copy(sa, 2,1),0) ;

  HBCC2 := Data16To10(copy(sb, 1,1));  //StrToIntDef(copy(sb, 1,1),0) ;
  LBCC2 := Data16To10(copy(sb, 2,1));  //StrToIntDef(copy(sb, 2,1),0) ;

  HSUM := HBCC1 XOR HBCC2 ;
  LSUM := LBCC1 XOR LBCC2 ;
  Tstr := '#$' + IntToHex(HSUM,1) + IntToHex(LSUM,1) ;
//  Form1.Memo.Lines.Add('BCC Result : P1[' + Tstr + ']') ;
  Temp := HexToInt(TStr);
//  str1 := 'HSUM : [' + bytetohex(HSUM) + '], LSUM : [' + bytetohex(LSUM) + '], ' +
//          'Result : [' + bytetohex(Temp) + ']' ;
  Result := Char(temp) ;
end;

function Encrypt(const S: String; Key: Word): String;
var
  i: byte;
  sEncrypt: String;
begin
  sEncrypt := '';
  for i := 1 to Length(S) do
  begin
    sEncrypt := sEncrypt + char(byte(S[i]) xor (Key shr 8));
    Key := (byte(sEncrypt[i]) + Key) * C1 + C2;
  end;
  Result := sEncrypt;
end;

function Decrypt(const S: String; Key: Word): String;
var
  i: byte;
  sDecrypt: String;
begin
  sDecrypt := '';
  for i := 1 to Length(S) do
  begin
    sDecrypt := sDecrypt + char(byte(S[i]) xor (Key shr 8));
    Key := (byte(S[i]) + Key) * C1 + C2;
  end;
  Result := sDecrypt;
end;

function  ZeroToOne( Rs : Char ) : Char;   // '0' -> '1', '1'->'0'
begin

   if Rs = '0' then Result := '1'
               else Result := '0';

end;

function GetErrorMessage( errStr : String ) : String;
var
  eCode : Integer;
begin

     eCode  := Data16To10(copy(errStr,1,1)) * 16 +
               Data16To10(copy(errStr,2,1)) ;
     Result := GetErrorMessageNo( eCode);

end;

Function  GetErrorMessageNo( eCode : Integer ) : String;
begin

        // function HexaTo1Char(ch : char) : char; // chr($F) -> 'F'
        // function CharTo1Hexa(ch : char) : char;     // 'F' -> chr($F)
        // function Data16To10(Rs : string) : integer; // 'F' -> 'F'
        // function Data10To16(Rs : Integer) : string; // 15 -> 'F'

        case ecode of
             0:Result := '정상.';
             1: Result :='주행중이상 주행비상정지.';
             2: Result :='주행중이상 FORK CENTER 미검출.';
             3: Result :='주행중이상 .';
             4: Result :='주행중이상 COUNTER 이상.';
             5..18 : Result := IntToStr(ecode)+':주행중이상.';
             20..36: Result := IntToStr(ecode)+':승강 이상.';
             40..48: Result := IntToStr(ecode)+':포킹 이상 ';
             50: Result := '비상 정지.';
             51: Result := 'Wire 풀림.';
             52: Result := '과적재.';
             53: Result :=  '화물 붕괴.';
             54: Result :=  '모터 과부하.';
             55: Result :=  '인버터 이상.';
             58: Result :=  '수신 데이타 이상.';
             60: Result :=  '포크 초기 이상.';
             61: Result :=  '공출고 이상.';
             62: Result :=  '입고대 화물없음.';
             63: Result :=  '이중입고 이상.';
             66..68: Result := IntToStr(ecode)+':타임 오버.';
             69: Result :=  '제동용 저항 과열.';
             73..77: Result := IntToStr(ecode)+':타임 오버.';
             78: Result :=  '자동동비상정지.';
             82: Result :=  '수동시 주행상태.';
             87: Result :=  '수동시 승강상태.';
             92: Result :=  '수동시 포킹상태.';
             93: Result :=  '수동시 포킹상태.';
             else   Result := IntToStr(ecode)+':알수없는 오류.';
        end;

end;

function GetErrorHome( errStr : String ) : Boolean;
var ecode : integer;
begin
        ecode := Data16To10(copy(errStr,1,1)) * 16 +
                 Data16To10(copy(errStr,2,1)) ;
        case ecode of
             1,20,22,50..55,68,6977,78:Result := False;
             else   Result := True;
        end;
end;

function  HexaToDecimal4( xHexa : String ) : String;   // Hexa('03E8') ->  '1000'
var eCode : Integer;
    eStr : String;
begin

     eStr := LPad(xHexa, 4);

     eCode := Data16To10( xHexa[1] ) * 4096 +
              Data16To10( xHexa[2] ) * 256 +
              Data16To10( xHexa[3] ) * 16 +
              Data16To10( xHexa[4] ) ;
     Result := IntToStr( eCode );

end;


function HexaToDecimal( xHexa : String ) : String; // '11' ->  '17'
var
  eCode : Integer;
  eStr : String;
begin
  if length(xHexa) = 0 then eStr := '00'
  else if length(xHexa) = 1 then eStr := '0' +xHexa
  else                           eStr := Copy(xHexa,1,2);

  eCode := Data16To10( xHexa[1] ) * 16 +
           Data16To10( xHexa[2] ) ;
  Result := IntToStr( eCode );
end;

Function  CharToHexaStr( Rs : char; ShowByte : Byte = 2 )  : String;         // 'K'    -> '4B'
begin

   result := IntToHex( Byte ( Rs  ),2);

end;

Function  StrToChar(Str: String; Cnt: integer) : Char;
var
  i,j: integer;
  uChar: Char;
begin
  Result := '0';
  j := length(Str);
  for i := 1 to j do begin
      if i = Cnt then begin
          uChar := DataSum(Copy(Str,i,1));
          result := uChar;
      end;
  end;
end;

function  Change_16Byte_TO_HEX(Byte16 :string) : String;
var
  str : array[0..3] of String;
  str1, str2 : String;
  i : Integer;
begin
  str2 := '';

  str[0] := Copy(Byte16,  1, 4);
  str[1] := Copy(Byte16,  5, 4);
  str[2] := Copy(Byte16,  9, 4);
  str[3] := Copy(Byte16, 13, 4);

  for i := 0 to 3 do
  begin
    if str[i] = '0000' then str1 := '0';
    if str[i] = '0001' then str1 := '1';
    if str[i] = '0010' then str1 := '2';
    if str[i] = '0011' then str1 := '3';
    if str[i] = '0100' then str1 := '4';
    if str[i] = '0101' then str1 := '5';
    if str[i] = '0110' then str1 := '6';
    if str[i] = '0111' then str1 := '7';
    if str[i] = '1000' then str1 := '8';
    if str[i] = '1001' then str1 := '9';
    if str[i] = '1010' then str1 := 'A';
    if str[i] = '1011' then str1 := 'B';
    if str[i] = '1100' then str1 := 'C';
    if str[i] = '1101' then str1 := 'D';
    if str[i] = '1110' then str1 := 'E';
    if str[i] = '1111' then str1 := 'F';

    str2 := concat( str2, str1 );
  end;
  Result := copy(str2,3,2) + copy(str2,1,2);
end;


function Data10To16II(Str : String) : Char; // '18' -> chr($12)
var
  i, xDiv,xMod : Integer;
  xChk : Boolean;
begin

  result := chr($00);
  xChk := False;
  for i := 1 to Length(Str) do
    case Str[i] of
      chr($30)..chr($39): xChk := True;
      else
      begin
        xChk := False;
        break;
      end;
    end;

   if xChk = False then exit;

   xDiv := StrToInt(Str) div 16 ;
   xMod := StrToInt(Str) mod 16 ;

   if xDiv >= 16 then exit;

   Str := Data10To16(xDiv)+Data10To16(xMod);
   Result := HexaCharToHexa(Str);

end;

function Data10To16Str(Str : String) : String; // '2000' -> '07D0'
var
  i, xDiv,xMod : Integer;
  xChk : Boolean;
begin

   result := '0000';

   xChk := False;
   for i := 1 to Length(Str) do
     case Str[i] of
       chr($30)..chr($39): xChk := True;
       else
       begin
         xChk := False;
         break;
       end;
     end;

   if xChk = False then exit;

   // 4096보다 큰값
   xDiv := StrToInt(Str) div 4096 ;
   xMod := StrToInt(Str) mod 4096 ;
   Str := Data10To16(xDiv);
   if xMod = 0 then
   begin
      Result  := Str + '000';
      Exit;
   end;

   // 256보다 큰값
   xDiv := xMod div 256 ;
   xMod := xMod mod 256 ;
   Str  := Str + Data10To16(xDiv);
   if xMod = 0 then
   begin
      Result  := Str + '00';
      Exit;
   end;

   // 16보다 큰값
   xDiv := xMod div 16 ;
   xMod := xMod mod 16 ;
   Str  := Str + Data10To16(xDiv);
   if xMod = 0 then
   begin
      Result  := Str + '0';
      Exit;
   end;

   // 16이하값.
   Str  := Str + Data10To16(xMod);
   Result := Str;

end;


function  DecToHexa(Rs : Integer) : string;          // 1024 -> Hexa('0100')
var
  xDiv, xInt : Integer;
  xStr : String;
begin
   result := '0000';
   xInt := Rs;
   if xInt > 2048 then begin
      xDiv := xInt div 2048 ;
      xInt := xInt mod 2048 ;
      xStr := Data10To16(xDiv);
   end else xStr := '0';
   if xInt > 128 then begin
      xDiv := xInt div 128 ;
      xInt := xInt mod 128 ;
      xStr := xStr +Data10To16(xDiv);
   end else xStr := xStr +'0';
   if xInt > 16 then begin
      xDiv := xInt div 16 ;
      xInt := xInt mod 16 ;
      xStr := xStr +Data10To16(xDiv);
   end else xStr := xStr +'0';
   xStr := xStr +Data10To16(xInt);

   Result := LPad(xStr,4);

end;

function Data10To16(Rs : Integer) : string; // 15 -> 'F'
begin
   result := '0';
   case Rs of
   15 :  Result := 'F';
   14 :  Result := 'E';
   13 :  Result := 'D';
   12 :  Result := 'C';
   11 :  Result := 'B';
   10 :  Result := 'A';
   9  :  Result := '9';
   8  :  Result := '8';
   7  :  Result := '7';
   6  :  Result := '6';
   5  :  Result := '5';
   4  :  Result := '4';
   3  :  Result := '3';
   2  :  Result := '2';
   1  :  Result := '1';
   end;

end;

function Data16To10(Rs : string) : integer; // 'F' -> 15
begin
   result := 0;
   case Rs[1] of
   'F' :  Result := 15;
   'E' :  Result := 14;
   'D' :  Result := 13;
   'C' :  Result := 12;
   'B' :  Result := 11;
   'A' :  Result := 10;
   '9' :  Result := 9;
   '8' :  Result := 8;
   '7' :  Result := 7;
   '6' :  Result := 6;
   '5' :  Result := 5;
   '4' :  Result := 4;
   '3' :  Result := 3;
   '2' :  Result := 2;
   '1' :  Result := 1;
   end;
end;

function CharTo1Hexa(ch : char) : char;     // 'F' -> chr($F)
begin
//   result := chr($0);
   case ch of
   'F','f': Result := chr($F);
   'E','e': Result := chr($E);
   'D','d': Result := chr($D);
   'C','c': Result := chr($C);
   'B','b': Result := chr($B);
   'A','a': Result := chr($A);
   '9': Result := chr($9);
   '8': Result := chr($8);
   '7': Result := chr($7);
   '6': Result := chr($6);
   '5': Result := chr($5);
   '4': Result := chr($4);
   '3': Result := chr($3);
   '2': Result := chr($2);
   '1': Result := chr($1);
   else Result := chr($0);
   end;
end;


function HexaTo1Char(ch : char) : char; // chr($F) -> 'F'
begin

   case ch of
   chr($F)        : Result := 'F';
   chr($E)        : Result := 'E';
   chr($D)        : Result := 'D';
   chr($C)        : Result := 'C';
   chr($B)        : Result := 'B';
   chr($A)        : Result := 'A';
   chr($9)        : Result := '9';
   chr($8)        : Result := '8';
   chr($7)        : Result := '7';
   chr($6)        : Result := '6';
   chr($5)        : Result := '5';
   chr($4)        : Result := '4';
   chr($3)        : Result := '3';
   chr($2)        : Result := '2';
   chr($1)        : Result := '1';
   else Result := '0';
   end;

end;

// Delphi 기본 Function StrUtils.ReverseString 사용 하면 됨
Function  Change4Byte( Rs : String) : String;        // '1234' -> '4321'
var i : Integer;
    Str : String;
begin

   Result := '';
   for i := 1 to length(Rs) div 4 do
   begin
       Str := Copy(Rs, ((i-1)*4)+1, 4);
       Result :=  Result + Str[4] + Str[3] + Str[2] + Str[1];
   end;

end;

// Delphi 기본 Function StrUtils.ReverseString 사용 하면 됨
Function  Change2Byte( Rs : String) : String;        // '1234' -> '2143'
var i : Integer;
    Str : String;
begin

   Result := '';
   for i := 1 to length(Rs) div 2 do begin
       Str := Copy(Rs, ((i-1)*2)+1, 2);
       Result :=  Result + Str[2] + Str[1];
   end;
end;

// Delphi 기본 Function StrUtils.ReverseString 사용 하면 됨
Function  Change4Bit( Rs : String) : String;         // '0011' -> '1100'
var i : Integer;
    Str : String;
begin

   Result := '';
   for i := 1 to length(Rs) div 4 do begin
       Str := Copy(Rs, ((i-1)*4)+1, 4);
       Result :=  Result + Str[4] + Str[3] + Str[2] + Str[1];
   end;

end;

Function  ChangeWord( Rs : String) : String;         // '1234' -> '84C2'
var i : Integer;
    Str, Str2 : String;
begin

  for i := 1 to length(Rs) do
  begin
    Str  := CharToBinString( Rs[i] )    ;  // 'A' -> '1010'
    Str  := Change4Bit( Str )           ;  // '0011' -> '1100'
    Str2 := Str2 + BinStringToChar(Str) ;  // '0010' -> '2'
  end;
  Result := Change4Byte( Str2 ) ;  // '1234' -> '4321'

end;

Function CharStrToBinStr(Rs : string ) : String;
var
  Str,RStr : String;
  I   : Integer;
begin
  Str   := Rs ;
  RStr  := '' ;
  For i := 1 to Length(Str) do
  begin
    Case Str[I] of
       '0'      : RStr := RStr + '0000';
       '1'      : RStr := RStr + '0001';
       '2'      : RStr := RStr + '0010';
       '3'      : RStr := RStr + '0011';
       '4'      : RStr := RStr + '0100';
       '5'      : RStr := RStr + '0101';
       '6'      : RStr := RStr + '0110';
       '7'      : RStr := RStr + '0111';
       '8'      : RStr := RStr + '1000';
       '9'      : RStr := RStr + '1001';
       'a', 'A' : RStr := RStr + '1010';
       'b', 'B' : RStr := RStr + '1011';
       'c', 'C' : RStr := RStr + '1100';
       'd', 'D' : RStr := RStr + '1101';
       'e', 'E' : RStr := RStr + '1110';
       'f', 'F' : RStr := RStr + '1111';
    end;
  End;
  result := RStr;
end;

Function StrBin8ToDecimal2(Rs : string ) : String;
var
  Str : String;

  function Bin4ToDecimal2(src:String):String;
  var
    str1 : String ;
  begin
    str1   := '0' ;
    if Length(src) = 4 then
    begin
      if      src = '0000' then str1 := '0'
      else if src = '0001' then str1 := '1'
      else if src = '0010' then str1 := '2'
      else if src = '0011' then str1 := '3'
      else if src = '0100' then str1 := '4'
      else if src = '0101' then str1 := '5'
      else if src = '0110' then str1 := '6'
      else if src = '0111' then str1 := '7'
      else if src = '1000' then str1 := '8'
      else if src = '1001' then str1 := '9'
      else if src = '1010' then str1 := 'A'
      else if src = '1011' then str1 := 'B'
      else if src = '1100' then str1 := 'C'
      else if src = '1101' then str1 := 'D'
      else if src = '1110' then str1 := 'E'
      else if src = '1111' then str1 := 'F';
    end;
    Result := str1 ;
  end;
begin
  Result := '' ;
  if Length(Rs) <> 8 then Exit ;
  Str    := Bin4ToDecimal2(copy(Rs,1,4)) +
            Bin4ToDecimal2(copy(Rs,5,4)) ;
  result := Str;
end;

Function CharStrToBinStrII(Rs : string ) : String;
var
    Str,RStr : String;
    I   : Integer;
begin

    Str   := Rs ;
    RStr  := '' ;
    For i := 1 to Length(Str) do begin

        Case Str[I] of
           '0'      : RStr := RStr + '0000';
           '1'      : RStr := RStr + '1000';
           '2'      : RStr := RStr + '0100';
           '3'      : RStr := RStr + '1100';
           '4'      : RStr := RStr + '0010';
           '5'      : RStr := RStr + '1010';
           '6'      : RStr := RStr + '0110';
           '7'      : RStr := RStr + '1110';
           '8'      : RStr := RStr + '0001';
           '9'      : RStr := RStr + '1001';
           'a', 'A' : RStr := RStr + '0101';
           'b', 'B' : RStr := RStr + '1101';
           'c', 'C' : RStr := RStr + '0011';
           'd', 'D' : RStr := RStr + '1011';
           'e', 'E' : RStr := RStr + '0111';
           'f', 'F' : RStr := RStr + '1111';
        end;
    End;

    result := RStr;

end;

function CharToBinString( ch : Char ) : String;
begin
  Result := '0000';
  Case ch of
     '0'      : Result := '0000';
     '1'      : Result := '0001';
     '2'      : Result := '0010';
     '3'      : Result := '0011';
     '4'      : Result := '0100';
     '5'      : Result := '0101';
     '6'      : Result := '0110';
     '7'      : Result := '0111';
     '8'      : Result := '1000';
     '9'      : Result := '1001';
     'a', 'A' : Result := '1010';
     'b', 'B' : Result := '1011';
     'c', 'C' : Result := '1100';
     'd', 'D' : Result := '1101';
     'e', 'E' : Result := '1110';
     'f', 'F' : Result := '1111';
  end;
end;

function BinStringToChar( BinS : String ) : Char; // 0010 -> 2
var
  str : String;
begin
  Str := Data10To16 (
             ChStrToInt(copy(BinS,1,1)) * 8 +
             ChStrToInt(copy(BinS,2,1)) * 4 +
             ChStrToInt(copy(BinS,3,1)) * 2 +
             ChStrToInt(copy(BinS,4,1)) * 1 );
  Result := Str[1];
end;

Function CharToHexaChar(Rs : char ) : String;
begin

   case Rs of
     chr($00): Result := '00';
     chr($01): Result := '01';
     chr($02): Result := '02';
     chr($03): Result := '03';
     chr($04): Result := '04';
     chr($05): Result := '05';
     chr($06): Result := '06';
     chr($07): Result := '07';
     chr($08): Result := '08';
     chr($09): Result := '09';
     chr($0A): Result := '0A';
     chr($0B): Result := '0B';
     chr($0C): Result := '0C';
     chr($0D): Result := '0D';
     chr($0E): Result := '0E';
     chr($0F): Result := '0F';

     chr($10): Result := '10';
     chr($11): Result := '11';
     chr($12): Result := '12';
     chr($13): Result := '13';
     chr($14): Result := '14';
     chr($15): Result := '15';
     chr($16): Result := '16';
     chr($17): Result := '17';
     chr($18): Result := '18';
     chr($19): Result := '19';
     chr($1A): Result := '1A';
     chr($1B): Result := '1B';
     chr($1C): Result := '1C';
     chr($1D): Result := '1D';
     chr($1E): Result := '1E';
     chr($1F): Result := '1F';

     chr($20): Result := '20';
     chr($21): Result := '21';
     chr($22): Result := '22';
     chr($23): Result := '23';
     chr($24): Result := '24';
     chr($25): Result := '25';
     chr($26): Result := '26';
     chr($27): Result := '27';
     chr($28): Result := '28';
     chr($29): Result := '29';
     chr($2A): Result := '2A';
     chr($2B): Result := '2B';
     chr($2C): Result := '2C';
     chr($2D): Result := '2D';
     chr($2E): Result := '2E';
     chr($2F): Result := '2F';

     chr($30): Result := '30';
     chr($31): Result := '31';
     chr($32): Result := '32';
     chr($33): Result := '33';
     chr($34): Result := '34';
     chr($35): Result := '35';
     chr($36): Result := '36';
     chr($37): Result := '37';
     chr($38): Result := '38';
     chr($39): Result := '39';
     chr($3A): Result := '3A';
     chr($3B): Result := '3B';
     chr($3C): Result := '3C';
     chr($3D): Result := '3D';
     chr($3E): Result := '3E';
     chr($3F): Result := '3F';

     chr($40): Result := '40';
     chr($41): Result := '41';
     chr($42): Result := '42';
     chr($43): Result := '43';
     chr($44): Result := '44';
     chr($45): Result := '45';
     chr($46): Result := '46';
     chr($47): Result := '47';
     chr($48): Result := '48';
     chr($49): Result := '49';
     chr($4A): Result := '4A';
     chr($4B): Result := '4B';
     chr($4C): Result := '4C';
     chr($4D): Result := '4D';
     chr($4E): Result := '4E';
     chr($4F): Result := '4F';

     chr($50): Result := '50';
     chr($51): Result := '51';
     chr($52): Result := '52';
     chr($53): Result := '53';
     chr($54): Result := '54';
     chr($55): Result := '55';
     chr($56): Result := '56';
     chr($57): Result := '57';
     chr($58): Result := '58';
     chr($59): Result := '59';
     chr($5A): Result := '5A';
     chr($5B): Result := '5B';
     chr($5C): Result := '5C';
     chr($5D): Result := '5D';
     chr($5E): Result := '5E';
     chr($5F): Result := '5F';

     chr($60): Result := '60';
     chr($61): Result := '61';
     chr($62): Result := '62';
     chr($63): Result := '63';
     chr($64): Result := '64';
     chr($65): Result := '65';
     chr($66): Result := '66';
     chr($67): Result := '67';
     chr($68): Result := '68';
     chr($69): Result := '69';
     chr($6A): Result := '6A';
     chr($6B): Result := '6B';
     chr($6C): Result := '6C';
     chr($6D): Result := '6D';
     chr($6E): Result := '6E';
     chr($6F): Result := '6F';

     chr($70): Result := '70';
     chr($71): Result := '71';
     chr($72): Result := '72';
     chr($73): Result := '73';
     chr($74): Result := '74';
     chr($75): Result := '75';
     chr($76): Result := '76';
     chr($77): Result := '77';
     chr($78): Result := '78';
     chr($79): Result := '79';
     chr($7A): Result := '7A';
     chr($7B): Result := '7B';
     chr($7C): Result := '7C';
     chr($7D): Result := '7D';
     chr($7E): Result := '7E';
     chr($7F): Result := '7F';

     chr($80): Result := '80';
     chr($81): Result := '81';
     chr($82): Result := '82';
     chr($83): Result := '83';
     chr($84): Result := '84';
     chr($85): Result := '85';
     chr($86): Result := '86';
     chr($87): Result := '87';
     chr($88): Result := '88';
     chr($89): Result := '89';
     chr($8A): Result := '8A';
     chr($8B): Result := '8B';
     chr($8C): Result := '8C';
     chr($8D): Result := '8D';
     chr($8E): Result := '8E';
     chr($8F): Result := '8F';

     chr($90): Result := '90';
     chr($91): Result := '91';
     chr($92): Result := '92';
     chr($93): Result := '93';
     chr($94): Result := '94';
     chr($95): Result := '95';
     chr($96): Result := '96';
     chr($97): Result := '97';
     chr($98): Result := '98';
     chr($99): Result := '99';
     chr($9A): Result := '9A';
     chr($9B): Result := '9B';
     chr($9C): Result := '9C';
     chr($9D): Result := '9D';
     chr($9E): Result := '9E';
     chr($9F): Result := '9F';

     chr($A0): Result := 'A0';
     chr($A1): Result := 'A1';
     chr($A2): Result := 'A2';
     chr($A3): Result := 'A3';
     chr($A4): Result := 'A4';
     chr($A5): Result := 'A5';
     chr($A6): Result := 'A6';
     chr($A7): Result := 'A7';
     chr($A8): Result := 'A8';
     chr($A9): Result := 'A9';
     chr($AA): Result := 'AA';
     chr($AB): Result := 'AB';
     chr($AC): Result := 'AC';
     chr($AD): Result := 'AD';
     chr($AE): Result := 'AE';
     chr($AF): Result := 'AF';

     chr($B0): Result := 'B0';
     chr($B1): Result := 'B1';
     chr($B2): Result := 'B2';
     chr($B3): Result := 'B3';
     chr($B4): Result := 'B4';
     chr($B5): Result := 'B5';
     chr($B6): Result := 'B6';
     chr($B7): Result := 'B7';
     chr($B8): Result := 'B8';
     chr($B9): Result := 'B9';
     chr($BA): Result := 'BA';
     chr($BB): Result := 'BB';
     chr($BC): Result := 'BC';
     chr($BD): Result := 'BD';
     chr($BE): Result := 'BE';
     chr($BF): Result := 'BF';

     chr($C0): Result := 'C0';
     chr($C1): Result := 'C1';
     chr($C2): Result := 'C2';
     chr($C3): Result := 'C3';
     chr($C4): Result := 'C4';
     chr($C5): Result := 'C5';
     chr($C6): Result := 'C6';
     chr($C7): Result := 'C7';
     chr($C8): Result := 'C8';
     chr($C9): Result := 'C9';
     chr($CA): Result := 'CA';
     chr($CB): Result := 'CB';
     chr($CC): Result := 'CC';
     chr($CD): Result := 'CD';
     chr($CE): Result := 'CE';
     chr($CF): Result := 'CF';

     chr($D0): Result := 'D0';
     chr($D1): Result := 'D1';
     chr($D2): Result := 'D2';
     chr($D3): Result := 'D3';
     chr($D4): Result := 'D4';
     chr($D5): Result := 'D5';
     chr($D6): Result := 'D6';
     chr($D7): Result := 'D7';
     chr($D8): Result := 'D8';
     chr($D9): Result := 'D9';
     chr($DA): Result := 'DA';
     chr($DB): Result := 'DB';
     chr($DC): Result := 'DC';
     chr($DD): Result := 'DD';
     chr($DE): Result := 'DE';
     chr($DF): Result := 'DF';

     chr($E0): Result := 'E0';
     chr($E1): Result := 'E1';
     chr($E2): Result := 'E2';
     chr($E3): Result := 'E3';
     chr($E4): Result := 'E4';
     chr($E5): Result := 'E5';
     chr($E6): Result := 'E6';
     chr($E7): Result := 'E7';
     chr($E8): Result := 'E8';
     chr($E9): Result := 'E9';
     chr($EA): Result := 'EA';
     chr($EB): Result := 'EB';
     chr($EC): Result := 'EC';
     chr($ED): Result := 'ED';
     chr($EE): Result := 'EE';
     chr($EF): Result := 'EF';

     chr($F0): Result := 'F0';
     chr($F1): Result := 'F1';
     chr($F2): Result := 'F2';
     chr($F3): Result := 'F3';
     chr($F4): Result := 'F4';
     chr($F5): Result := 'F5';
     chr($F6): Result := 'F6';
     chr($F7): Result := 'F7';
     chr($F8): Result := 'F8';
     chr($F9): Result := 'F9';
     chr($FA): Result := 'FA';
     chr($FB): Result := 'FB';
     chr($FC): Result := 'FC';
     chr($FD): Result := 'FD';
     chr($FE): Result := 'FE';
     chr($FF): Result := 'FF';
     ELSE      Result := '00';
  end;

end;


Function HexaToChar(Rs : string ) : String; // chr($ff) -> 'FF'
begin

  if (Rs = '') or (Rs = Char($00)) then
  begin
    Result := '00';
    exit;
  end;
  Result := CharToHexaChar(Rs[1]) ;

end;


Function HexaCharToHexa(Rs : string ) : char; // 'FF' -> chr($FF)
var ch : byte;
    ck : boolean;
    i : integer;
begin

   for i := 1 to 2 do begin
      case Rs[i] of
        '0','1'..'9','A'..'F','a'..'f' : ck := true;
        else ck := false;
      end;
   end;

   Result := chr($0);
   if ck = false then Exit;

   ch     := BYTE(CharTo1Hexa(Rs[1])) SHL 4 +
             BYTE(CharTo1Hexa(Rs[2]));
   result := char(ch);

end;

Function CharToHexa(Rs : string ) : char;     // 'FF' -> chr($FF)
begin

  Result := HexaCharToHexa(Rs);

end;

procedure LogFileCopy(Filename:string);
var
  F, R : TextFile;
  LogFile, LogFileOld, Msg : string;
  i : integer;
begin
  LogFile    := Filename ;

  for i := length(Filename) downto 1 do
  begin
     if  Filename[i] = '.' then
     begin
       msg := copy(Filename,1,i-1) + '_' + FormatDateTime('YYYYMMDDHHNN', Now) + '.'+
              copy(Filename,i+1,length(Filename)-i );
       break;
     end;
  end;

  if Msg = '' then
       LogFileOld := Filename + FormatDateTime('YYMMDDhhnn', Now)
  else LogFileOld := Msg ;

  // Read File 처리
  AssignFile(R, LogFile);
  Reset(R);
  ReadLn(R, Msg);

  // Write File  처리
  AssignFile(F, LogFileOld);
  Rewrite(F); // 파일 생성
  Writeln(F, Msg );

  while not Eof(R) do
  begin
    ReadLn( R, Msg );
    Writeln(F, Msg );
  end;
  CloseFile(R);
  CloseFile(F);
end;

procedure LogFileCopyII(Filename:string);
var F: TextFile;
    R: TextFile;
    LogFile    : string;
    LogFileOld : string;
    Msg        : string;
begin
  LogFile    := Filename ;
  LogFileOld := Filename + '.old';

  // Read File 처리
  AssignFile(R, LogFile);
  Reset(R);
  ReadLn(R, Msg);

  // Write File  처리
  AssignFile(F, LogFileOld);
  Rewrite(F); // 파일 생성
  Writeln(F, Msg );

  while not Eof(R) do
  begin
    ReadLn( R, Msg );
    Writeln(F, Msg );
  end;
  CloseFile(R);
  CloseFile(F);
end;

//------------------------------------------------------------------------------
// ASCII 2byte → Byte 1 으로 변경 : 30 40 -> 0A, 38 43 -> 8D
//------------------------------------------------------------------------------
function ASCII2ToChar(Chr1, Chr2: String): Char;
  function GetHexData(src:String):String ;
  var
    rStr : String ;
  begin
    rStr := '' ;
    case StrToIntDef(src, 0) of
      41 : rStr := 'A' ;
      42 : rStr := 'B' ;
      43 : rStr := 'C' ;
      44 : rStr := 'D' ;
      45 : rStr := 'E' ;
      46 : rStr := 'F' ;
      else rStr := '0' ;
    end;
    Result := rStr ;
  end;
var
  tStr : String ;
begin

  tStr := '' ;

  if StrToIntDef(Chr1, 0) in [30..39] then
       tStr := tStr + copy(Chr1, 2, 1)
  else tStr := tStr + GetHexData(Chr1) ;

  if StrToIntDef(Chr2, 0) in [30..39] then
       tStr := tStr + copy(Chr2, 2, 1)
  else tStr := tStr + GetHexData(Chr1) ;

  Result := Chr(StrToInt('$'+tStr)) ;
end;

//------------------------------------------------------------------------------
// BCC를 구한다 : GetBCC  from NewSkin C# Source
//------------------------------------------------------------------------------
function GetBCC(argBuff : Array of Char; argStart, argEnd:Integer): String ;
var
  i : Integer ;
  bSum, bSum2 : Byte ;
  Str, tStr1, tStr2 : String ;
begin
  bSum  := 0;

  for i := argStart to argEnd do
  begin
    // LF, ENQ, ACK, BCC, CR 제외
    if not ( argBuff[i-1] in [LF, ENQ, ACK, CR] ) then
    begin
      bSum := bSum + StrToInt('$' + CharToHexaChar(argBuff[i-1])) ;
    end;
  end;

  // bSum2 = (byte)(bSum % 0x100);
  bSum2 := bSum mod 256 ;

  // bSum3 = (byte)(~bSum2);
  tStr1 := CharStrToBinStr(IntToHEx(bSum2, 2)) ;
  tStr2 := '' ;
  for i := 1 to Length(tStr1) do
  begin
    if Copy(tStr1, i, 1) = '1' then
         tStr2 := tStr2 + '0'
    else tStr2 := tStr2 + '1' ;
  end;

  Str := BinStrToCharStr(tStr2) ;
  Result := Str;
end;

//------------------------------------------------------------------------------
// 디렉토리가 존재하는지 확인한다.
// Delphi 기본 Function Sysutils.ForceDirectories 와 유사함.
//------------------------------------------------------------------------------
procedure DirMake(Filename: string);
begin
  if not DirectoryExists(Filename) then MkDir(Filename);
end;


procedure LogWrite(Filename, Msg: string);
var
  F: TextFile;
  S: file of Byte;

  Rc : integer;
  size : Longint;
  LogFile    : string;
begin
  try
    LogFile := Filename ;

    if FileExists(LogFile) then
    begin
      AssignFile(S, LogFile);
      reset(S);

      size := FileSize(S);
      CloseFile(S);
      if (size > 5000000) then
      begin
        LogFileCopy(Filename);
        Rc := 0; // 0:생성
      end else Rc := 1; // 추가
    end else Rc := 0 ;

    try
      AssignFile(F, LogFile);
      if Rc = 1 then Append(F)   // 추가
                else Rewrite(F); // 파일 생성

      Writeln(F, Msg);
    finally
     CloseFile(F);
    end;
  except
    CloseFile(F);
  end;
end;

procedure LogWriteII(Filename, Msg: string);
var F: TextFile;
    S: file of Byte;

    Rc : integer;
    LogFile    : string;
begin

  LogFile := Filename ;

  if FileExists(LogFile) then
  begin

     AssignFile(S, LogFile);
     reset(S);

     Rc := 1; // 추가
  end
  else
     Rc := 0 ;

  AssignFile(F, LogFile);
  if Rc = 1 then
     Append(F)   // 추가
  else
     Rewrite(F); // 파일 생성

  Writeln(F, FormatDateTime('hh:nn:ss ', Now) +Msg);
  CloseFile(F);
end;

procedure LogRead(Filename:string; Msg: string);
var F: TextFile;
    LogFile : string;
begin

  LogFile := Filename + '.log';
  AssignFile(F, LogFile);

  Reset(F);
  ReadLn(F, Msg);

  while not Eof(F) do
  begin
    ReadLn( F, Msg );
    Break;
  end;

  CloseFile(F);

end;

procedure DabaseWriteInit(Filename, Msg: string);
var
  F: TextFile;
begin
  AssignFile(F, Filename);
  Rewrite(F); // 파일 생성
  Writeln(F, Msg);
  CloseFile(F);
end;

procedure DabaseWriteData(Filename, Msg: string);
var
  F: TextFile;
begin
  AssignFile(F, Filename);
  Append(F);   // 추가
  Writeln(F, Msg);
  CloseFile(F);
end;


function IPRead(Filename : String) : String;
var
  F   : TextFile;
  Msg : string;
begin
  Result := 'No.해당파일이 없습니다.';
  if FileExists(Filename) = False then
    Exit;

  AssignFile(F, Filename);
  Reset(F);
  ReadLn(F, Msg);
  CloseFile(F);
  if Msg <> '' then
     Result := Msg;
end;

procedure IPWrite(Filename, Msg : string);
var
  F: TextFile;
begin
  AssignFile(F, Filename);
  Rewrite(F); // 파일 생성
  Writeln(F, Msg);
  CloseFile(F);
end;

function  InitIPRead(var MyIP, FtpIP, HostIP, HostPort : String ) : Integer;
var F: TextFile;
    LogFile, Msg, Temp, Str : string;
    Row, Col, Cnt, i : Integer;
begin

  Result := 0;

  if FileExists(LogFile) = False then
    Exit;

  AssignFile(F, LogFile);
  Reset(F);
  ReadLn(F, Msg);

  Row := 0;

  while not Eof(F) do
  begin

      Col := 0;
      Cnt := 1;
      Temp := '';
      if ((Copy(Msg,1,1) >= chr($30)) and (Copy(Msg,1,1) <= chr($39))) or
         (Copy(Msg,1,1) = chr($2E))  then  begin
         for i:=0 to Strlen(Pchar(Msg))do begin
            Temp := Copy(Msg,i+1,1);
            if Temp = ' ' then begin
               if Col > 0 then
                  Row := Row+1;
               Cnt := 0;
               break;
            end else  begin
               str := Str+Temp;
               Col := 1;
            end;
         end;

         if (Col > 0)  then Row := Row + Cnt;

         Case Row of
         1 : begin
                MyIP  := Str;
                Str    := '';
             end;
         2 : begin
                FtpIP  := Str;
                Str    := '';
             end;
         3 : begin
                HostIP := Str;
                Str    := '';
             end;
         4 : begin
                HostPort := Str;
             end;
         end;

         if Row >= 4 then Break;
      end; // End of if

      ReadLn( F, Msg );

  end;

  CloseFile(F);
  result := Row;

end;

// ******************************************************
// FileFine 는 두개의 문자를 비교하여 같은값이 있으면
//          찾은 값으로 두번째 인자값을 돌려보낸다.
//          못찾은 경우 No Data found값을 Return한다.
// ******************************************************
function FileFine(FileName, FindName : string) : string;
var
   I,J,Rc,k : integer;
   Temp : string;
begin
  Result := 'No Data found';
  Rc := StrLen(Pchar(FileName));
  J := 0;
  for I :=0 to Rc do begin
      k :=   StrLen(PChar(FindName));
      if j+1+ k > Rc then Break;
      Temp  := copy(Filename, j+1,StrLen(PChar(FindName)));
      if StrComp(PChar(UpperCase(Temp)), PChar(UpperCase(FindName)) ) = 0 then begin
         Result := FindName;
         Break;
      end;
      J := J+1;
  end;
end;

Function FileGetDateUser( FileName : string) : Integer;
var
  Rc   : integer ;
  FileHandle : Integer;
begin

  result := -1;
  if FileExists( FileName ) then begin

     Rc := 0;
     FileHandle := FileOpen(FileName, fmShareDenyNone);
     if FileHandle > 0 then
        Rc := FileGetDate(FileHandle);

     Result := Rc;

     FileClose( FileHandle );

  end;

end;


function SpaceAdd(Msg : string; Len : Integer) : string;
var
  i, Len1 : integer;
begin
  Result := Msg;
  Len1 := length(Msg);
  if Len = Len1 then Exit;

  For i := 1 to Len do Begin
     if Len1 < i then
        Result := Result + ' ';
  end;
end;

function CharAdd(Msg : string; Len : Integer; ch:Char) : string;
var
  i, Len1 : integer;
begin
  Result := Msg;
  Len1 := length(Msg);
  if Len = Len1 then Exit;

  For i := 1 to Len do Begin
     if Len1 < i then
        Result := Result + ch;
  end;
end;

function SpaceAddint(Msg : string; Len : Integer) : string;
var
  i, Len1 : integer;
begin
  Result := Msg;
  Len1 := Strlen(PChar(Msg));
  For i := 0 to Len do Begin
     if Len1 <= i-1 then
        Result :=  ' '+Result;
  end;
end;


Function  GetComputerName : String;
var
   Msg : String;
   MyRegistry : TRegistry;

begin
     Msg := '';
     MyRegistry := TRegistry.Create;
     MyRegistry.RootKey := HKEY_LOCAL_MACHINE;
     if MyRegistry.OpenKeyReadOnly('\System\CurrentControlSet\Control\ComputerName\ComputerName') = true then
        begin
          Msg := Msg+MyRegistry.ReadString('ComputerName');
        end;
     MyRegistry.CloseKey;
     if Length(Msg) > 20 then
        Result := copy(Msg, 1,20)
     else
        Result := Msg;
end;

procedure FileInit(Filename: string);
var
  F: TextFile;
begin
  AssignFile(F, Filename);
  Rewrite(F); // 파일 생성
  Writeln(F, '');
  CloseFile(F);
end;

procedure FileAdd(Filename, Msg: string);
var
  F: TextFile;
  LogFile    : string;
begin

  LogFile := Filename ;

  if not FileExists(LogFile) then
  begin
     Exit;
  end;

  AssignFile(F, LogFile);
  Append(F);   // 추가
  //   Rewrite(F); // 파일 생성
  Writeln(F, Msg);
  CloseFile(F);

end;

//IniFile Reading INI 파일에서 데이타 읽어옴
function ReadIni(  IniFileName,MainString,SubString :String ):String ;
var Ini_File    : TIniFile;
    Read_String : String ;
begin
  try
    Ini_File    := TIniFile.Create( ExpandFileName ( IniFileName )  );
    Read_String := Ini_File.ReadString( MainString     ,SubString   , 'False'    );
  finally
    Result := Read_String ;
  end;
end;


//IniFile Writing
function WriteIni ( IniFileName, MainString, SubString, WriteString :String ): Boolean ;
var Ini_File    : TIniFile;
begin
  Try
    Ini_File := TIniFile.Create( ExpandFileName ( IniFileName )  );
    Ini_File.WriteString( MainString, SubString, WriteString  );
    Result := True;
  finally
//    Ini_File.Free;
    end;
end;

Function  GetName( FileName :String ): String ;
var
  l : Integer;
begin
  Result := FileName;
  //S := FileName;
  { Convert spaces to zeroes }
  l := 1;
  while l > 0 do
  begin
     l:= Pos('\', Result);
     Result := RightStr(Result, length(Result)-l );
  end;

end;


//LTrim() - 문자열 왼쪽의 모든 공백을 제거
function LTrim(const Str: String): String;
var
len: Byte;
i: Integer;
begin

    LTrim := Str;
    if Str = '' then exit;

    len := Length(Str);
    i := 1;
    while (i <= len) and (Str[i] = Space) do
       Inc(i);
    LTrim := Copy(Str,i,len)
end;

//RTrim() - 문자열 오른쪽의 모든 공백을 제거
function RTrim(Str: String): String;
var
len: Byte;
begin

    RTrim := Str;
    if Str = '' then exit;

    len := Length(Str);
    while (Str[len] = Space) do
       Dec(len);
    RTrim := copy(Str,1,len);
end;

//Trim() - LTrim & RTrim
function Trim(Str: String): String;
begin
  Trim := LTrim(RTrim(Str))
end;

//RightStr() - 문자열의 오른쪽에서 부분문자열
function RightStr(const Str: String; Size: Word): String;
var
len: Byte;
begin
    len := Length(Str);
    if Size > len then
    Size := len;
    RightStr := Copy(Str,len-Size+1,Size)
end;

//LeftStr() - 문자열의 왼쪽에서 부분문자열
function LeftStr(const Str: String; Size: Word): String;
begin
   LeftStr := Copy(Str,1,Size)
end;

//MidStr() - 문자열의 중간에서 부분문자열
function MidStr(Const Str: String; Size: Word): String;
var
len: Byte;
begin
    len := Length(Str);
    if Size > len then
    Size := len;
    MidStr := Copy(Str,((len - Size) div 2)+1,Size)
end;

function LPAD(Msg : string; Len : Integer; Addch:Char) : string;
var
  i, Len1 : integer;
begin
  Result := Msg;
  Len1 := length(Msg);
  if Len = Len1 then Exit;

  For i := 1 to Len do
  Begin
    if Len1 < i then Result := Addch + Result ;
  end;
end;

function RPAD(Msg : string; Len : Integer; Addch:Char) : string;
var
  i, Len1 : integer;
begin
  Result := Msg;
  Len1 := length(Msg);
  if Len = Len1 then Exit;

  For i := 1 to Len do Begin
     if Len1 < i then
        Result :=  Result + Addch ;
  end;
end;


Function  ChangeToConversion(Rs, Flag : string ) : String;
//---------------------------------------------------
// 사용예제
//
//  Argv1 : 변환할 값
//  Argv2 : NEW: 새로운 데이터로 변경,
//          OLD: 변경된 데이터를 원위치 하는 함수
//
//---------------------------------------------------
var
   i : integer;
   Str, Chk : String;
   Key : Char;
begin

   Str := '';
   if Flag = 'OLD' then
     Rs := ChangeToConversionII(Rs , Flag );

   for i:=1 to length(Rs) do begin
       Chk := copy(Rs,i,1);
       StrMove(@key, Pchar(Chk), 1 );
//UPPER
       Flag := UpperCase(Flag);
       if (key > ' ') and
          (key < '~') then begin
       case i mod 8 of
         1,3,6,8,14,20,40,52,64 :
                   begin
                      case i mod 3 of
                        0 : begin
                              if Flag = 'NEW' then Dec(key,3)
                              else                 inc(key,3);
                            end;
                        1 : begin
                              if Flag = 'NEW' then Dec(key,4)
                              else                 inc(key,4);
                            end;
                        else begin
                              if Flag = 'NEW' then Dec(key,12)
                              else                 inc(key,12);
                        end;
                      end;
                      Str := Str + Key;
                   end;
         2,5,7,10,15,30,43,56,63,70   :
                   begin
                      case i mod 4 of
                        0 : begin
                              if Flag = 'NEW' then Dec(key,13)
                              else                 inc(key,13);
                            end;
                        1 : begin
                              if Flag = 'NEW' then Dec(key,5)
                              else                 inc(key,5);
                            end;
                        else begin
                              if Flag = 'NEW' then Dec(key,7)
                              else                 inc(key,7);
                        end;
                      end;
                      Str := Str + Key;
                   end;
         4,9,11,12,16,19,25,33,45,57,68,75  :
                   begin
                      case i mod 2 of
                        0 : begin
                              if Flag = 'NEW' then Dec(key,4)
                              else                 inc(key,4);
                            end;
                        1 : begin
                              if Flag = 'NEW' then Dec(key,6)
                              else                 inc(key,6);
                            end;
                        else begin
                              if Flag = 'NEW' then Dec(key,7)
                              else                 inc(key,7);
                        end;
                      end;
                      Str := Str + Key;
                   end;
         else
                   begin
                      case i mod 3 of
                        0 : begin
                              if Flag = 'NEW' then Dec(key,3)
                              else                 inc(key,3);
                            end;
                        1 : begin
                              if Flag = 'NEW' then Dec(key,12)
                              else                 inc(key,12);
                            end;
                        2 : begin
                              if Flag = 'NEW' then Dec(key,5)
                              else                 inc(key,5);
                            end;
                        else begin
                              if Flag = 'NEW' then Dec(key,6)
                              else                 inc(key,7);
                        end;
                      end;
                   end;
                   Str := Str + Key;
       end;  // End of Case
      end else
          Str := Str + Key;
   end;

   if Flag = 'NEW' then
     str := ChangeToConversionII(Str , Flag );

   result := str;

end;

Function  ChangeToConversionII(Rs, Flag : string ) : String;
var
    i : Integer;
    Str,Chk : String;
    Rc  : String;
begin

   for i:=1 to length(Rs) do begin
       Chk := copy(Rs,i,1);
       if Flag = 'NEW' then  begin

          Str := HexaToChar( Chk ) ; // '1' -> '31'
          Rc := Rc + Str;
       end else begin
          // '31' -> '1'
          if (i mod 2) = 1 then
             Str := Copy(Rs, i ,2)
          else begin // 짝수인경우
             Str := CharToHexa( Str )  ;
             Rc  := Rc + Str;
          end;
       end;
   end;

  result := Rc;

end;



function chStrToInt( Str : String) : Integer;
var
  xstr, xstr2 : String;
  i : Integer;
begin
  xStr := Trim(Str);
  xStr2 := '';
  if xStr = '' then xStr2 := '0'
  else begin
    for i := 1 to length(xStr) do
    begin
      if xStr[i] in ['1'..'9','0','-'] then xStr2 := xStr2 + xStr[i];
    end;
  end;
  if xStr2 = '' then xStr2 := '0';
  result := StrToInt(xStr2);
end;

function  GetMandoLotNo(Str : String) : String;
var  xLot, xStr : String;
     xInt : Integer;
begin

    //xDate := FormatDateTime('yyyy', now);
    xLot := copy(Str,4,1);

    xInt := chStrToInt(  copy(Str,5,2) );
    IF (xInt = 0) or (xInt > 12) then xStr := '0'
                                 else xStr := MonChar[xInt];
    xLot := xLot + xStr;

    xInt := chStrToInt(  copy(Str,7,2) );
    IF (xInt = 0) or (xInt > 31) then xStr := '0'
                                 else xStr := DayChar[xInt];
    xLot := xLot + xStr;

    Result := xLot;

end;

function  GetMandoLotNoDate(Str : String) : String;
var
  xLot, xStr, xCh : String;
  xInt,i : Integer;
begin

  // 년도를 구한다.
  xStr := FormatDatetime('yyyy',now);
  xLot := copy(xStr,1,3)+ copy(str,1,1);

  // 월을 구한다.
  xint := 0;
  xCh := Copy(Str,2,1);
  for i := 1 to 12 do
  begin
    if MonChar[i] =  xCh[1] then
    begin
      xInt := i;
      break;
    end;
  end;
  xLot := xLot + FormatFloat('00', xInt);

  // 일을 구한다.
  xint := 0;
  xCh := Copy(Str,2,1);
  for i := 1 to 12 do
  begin
    if DayChar[i] =  xCh[1] then
    begin
      xInt := i;
      break;
    end;
  end;
  xLot := xLot + FormatFloat('00', xInt);
  result := xLot;
end;



// =============================================================================
// function fnHanChk (Str : String; Cnt : Integer) : String;
// 복사할 경우 마지막 자릿수에 한글이 올경우 마지막 한글자리에 공백으로대치하는 함수
// 인자설명 인자1:해당문자, 인자2:전체자릿수
// Return : 전체자릿수만큼 마자막자 특수문자면 Space로 대치함.
// =============================================================================
Function fnHanChk (Str : String; Cnt : Integer) : String;
var
   j : Integer;
   mystr,Rc : String;
begin
   if( length(Str) >=Cnt ) then begin
      mystr := copy(Str,1,Cnt);
      j := 1;
      while ( j <= Cnt ) do begin
         if isDBCSLeadByte(Byte(mystr[j])) then begin //첫바이트가 한글이면
             If j < Cnt Then begin
               Rc := Rc + copy( mystr,j ,2 );
             end Else begin
               Rc := Rc + ' ';
             End;
             j:=j+2;
         end else begin
             Rc := Rc + copy( mystr, j , 1 );
             j:=j+1;
         end;
      end;
      result := Rc;
   end else
      result := Str;

end;


Function BarIndex(xinStr : String) : String;
var i, j : Integer;
    xStr : String;
    inStr : String;
begin


    inStr := xInStr+ ' ';

    j := 1;
    xStr := '';
    for i := 1 to length(inStr) do begin


       if  isDBCSLeadByte(Byte(inStr[j])) then begin
           xStr := xStr+HexaToChar( inStr[j]) +HexaToChar( inStr[j+1]);
           j := j+2;
       end else begin
           if inStr[j] <> ' ' then
              xStr := xStr+'00'+HexaToChar( inStr[j] );
           j := j+1;
       end;
       if j >= length(inStr)then break;

    end;
    result := xStr;

end;


Function sameDataCheck( SrcStr, FindStr : String) : Boolean;
var i, Len : Integer;
begin

    Result := False;
    Len := Length( FindStr );
    for i := 1 to length(SrcStr) do begin

      if i+Len > length(SrcStr) then break;
      if copy( SrcStr , i , Len ) = FindStr then Result := True;

    end;

end;

// =============================================================================
// 1의 보수로 변환한다.
// =============================================================================
function  Data1Bosu( SrcData : Char ) : Char;        // 1의 보수
var Str : String;
begin

     Str := HexaToChar(Char( Byte(SrcData) xor $FF ));         // chr($FF) -> 'FF'

     Result := HexaCharToHexa(STR ) ; // 'FF' -> chr($FF)

end;

// =============================================================================
// 문자변수를 합산결과를 2문자로 변환한다.
// =============================================================================
function  DataSum2( SrcData : String ) : String;
var xDInt : Byte ;
    i : Integer;
    xByte : Byte;
begin

   xDInt := 0;
   for i := 2 to length(SrcData) do
       xDInt := xDInt + Byte ( SrcData[i]  ) ;

   xByte := xDInt;
   result := IntToHex( xByte, 2 );    // 256 -> 'FF'

end;

// =============================================================================
// 문자변수를 합산결과를 1문자로 변환한다.
// =============================================================================
function  DataSum( SrcData : String ) : Char; // data를 sum하여 1char로 변환
var i, j, xadd : integer;
    str, str1, str2 : String;
    xStr : String;
    Ch   : Char;
    xarr : array[1..8] of char;
    tempstr: string;
begin

     xStr := SrcData;
     //xStr := Char($50) + Char($51) ;
     //xStr := Char($50) + Char($51) + Char($01) + Char($01) + Char($01) + Char($01) + Char($01) + Char($03) + Char($41) + Char($BD)  ;

     for i := 1 to 8 do
        xarr[i] := '0';
     tempstr := xStr[1];
     Str1 :=CharStrToBinStr( HexaToChar(xStr[1]) );    // Chr(FF) -> '11111111'
//     xadd := 0;
     for j := 2 to length(xStr) do begin
        Str2 := CharStrToBinStr(HexaToChar(xStr[j]) );
        xadd := 0;
        for i := 8 downto 1 do begin
            case   xadd + StrToInt(Str1[i]) + StrToInt(Str2[i]) of
               0 : begin
                      xarr[i] := '0';
                      xadd    := 0;
                   end;
               1 : begin
                      xarr[i] := '1';
                      xadd    := 0;
                   end;
               2 : begin
                      xarr[i] := '0';
                      xadd    := 1;
                   end;
               3 : begin
                      xarr[i] := '1';
                      xadd    := 1;
                   end;
            end;
        end;
        Str1 := xArr[1]+xArr[2]+xArr[3]+xArr[4]+xArr[5]+xArr[6]+xArr[7]+xArr[8];
     end;

     Str := BinStringToChar (Copy(Str1,1,4)) + BinStringToChar (Copy(Str1,5,4));
     Ch  := CharToHexa ( Str );
     Result := Ch;

end;


end.

