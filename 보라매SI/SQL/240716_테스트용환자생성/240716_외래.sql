SELECT *
  FROM ACPPRODM
 WHERE PT_NO = '04890141'
;
SELECT *
  FROM ACPPRORE
 WHERE PT_NO = '04890056'
;
SELECT *
  FROM ACPPEOPD
 WHERE PT_NO = '04890056'
;
SELECT *
  FROM ACPPRGCD    -- 중증,     이미 등록된 중증 내역들이 나온다~ 자격조회하면 자동으로 INsert 됨 ( 타병원, 본원 다)
 WHERE PT_NO = '04890116'
-- WHERE rownum < 30
;
SELECT *
  FROM ACPPRGHD    -- 중증,     얘는 본원에서 등록한 중증만 .. !
 WHERE PT_NO = '01667186'
;
SELECT *
  FROM CCCCCSTE
 WHERE COMN_GRP_CD = '357'     -- DTRL5 참고
;


