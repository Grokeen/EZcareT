SELECT *
  FROM ACPPRAAM
 WHERE PT_NO = '04890084'
;
SELECT *
  FROM ACPPRIRE                -- 입원환자유형
  WHERE PT_NO = '04889870'
;
SELECT *
  FROM ACPPRTSD                -- 전과전동정보
 WHERE PT_NO = '00000001'
;;
SELECT *
  FROM ACPPRARD                -- 입원예약정보
 WHERE PT_NO = '04890035'
;


SELECT *
  FROM ACPPRTRD                 -- 진료ㅕ간호에서 전과전동 요청한 내역
 WHERE PT_NO = '00000001'
;

