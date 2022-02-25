unit crc16;

{* High-Order byte table *}

interface


function calcCRC16(const putMsg: string; nDataLen: word):WORD;
function calcCRC(const putMsg: String; nDataLen: word):WORD;
function calcSUMOR(const putMsg: String) : Char;
function calcSUMOR2(const putMsg: String) : String;

implementation

function calcCRC(const putMsg: String; nDataLen: word):WORD;
var
//   Buff : array[1..2] of char;
   i,j : integer;
   CRC_Sum, Carry :WORD;
//   Str : String;
//   Ch  : Char;
//   by : Byte;
begin

   CRC_Sum := $FFFF;
//   i := 1;
//   while nDataLen > 0 do
   for i := 1 to nDataLen  do
   begin

      CRC_Sum := CRC_Sum xor byte(putMsg[i]);

      for j := 1 to 8 do
      begin
         Carry :=  CRC_Sum and $01;
//         CRC_Sum := CRC_Sum shr 1;
         CRC_Sum := CRC_Sum shr 1;
         if Carry = 1 then  CRC_Sum := CRC_Sum xor $A001;
      end;

  end;
  //Result :=  Char(hi(CRC_Sum))+Char(lo(CRC_Sum));
  Result :=  CRC_Sum;
//  Str :=
//  Result := (CRC_Sum shl 8 or CRC_Sum);

end;

function calcCRC16(const putMsg: String; nDataLen: word):WORD;
var
   i,j : integer;
   CRC_Sum :WORD;
   ch : byte;
begin

   CRC_Sum := $FFFF;
   for i := 1 to nDataLen do begin
       ch := byte(putMsg[i]);
      CRC_Sum := CRC_Sum xor  ch;
      for j := 1 to 8  do
      begin

         if ((CRC_Sum AND 1) = 1) THEN CRC_Sum := (CRC_Sum shr 1) xor $A001
         else                          CRC_Sum := CRC_Sum shr 1;

      end;
  end;
  Result :=  CRC_Sum;

end;

function calcSUMOR(const putMsg: String) : Char;
var
   i : integer;
   CRC_Sum :WORD;
   ch : byte;
begin

   //CRC_Sum := $FFFF;
   CRC_Sum := $0000;
   for i := 1 to Length(putMsg) do begin
       ch := byte(putMsg[i]);
      CRC_Sum := CRC_Sum or  ch;
  end;
  CRC_Sum := CRC_Sum xor  $0001;

  Result :=  Char(lo(CRC_Sum));

end;

function calcSUMOR2(const putMsg: String) : String;
//var
   //i,j : integer;
//   CRC_Sum :WORD;
//   ch : byte;
//   ch1, ch2, chadd : Byte;

begin

{
   //CRC_Sum := $FFFF;
   CRC_Sum := $0000;
   for i := 1 to Length(putMsg) do begin
      ch := byte(putMsg[i]);
      CRC_Sum := CRC_Sum xor  ch;
      for j := 1 to 8  do
      begin

         if j = 1 then
         ch1 := CRC_SUM AND ( 2 * (j-1);


         if ((CRC_Sum AND 1) = 1) THEN CRC_Sum := (CRC_Sum shr 1) //xor $A001
         else                          CRC_Sum :=  CRC_Sum shr 1;
         //if ((CRC_Sum AND 1) = 1) THEN CRC_Sum := (CRC_Sum shr 1) xor $A001
         //else                          CRC_Sum :=  CRC_Sum shr 1;

      end;
   end;
   Result :=  Char(hi(CRC_Sum)) + Char(lo(CRC_Sum));
 exit;

   for i := 1 to Length(putMsg) do begin
       ch := byte(putMsg[i]);
       CRC_Sum := CRC_Sum or  ch;
   end;
 // CRC_Sum := CRC_Sum xor  $0001;

  Result :=  Char(hi(CRC_Sum)) + Char(lo(CRC_Sum));
}

end;

end.
