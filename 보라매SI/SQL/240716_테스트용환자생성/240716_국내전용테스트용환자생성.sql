SELECT *
	FROM TEMPPTRSV
	--where pt_nm like '신생아간호교육아기2'             -- 환자명 나이 성별 진료의 진료과 PACT_TP_CD ,MED_ADS_DT (예약일) , FRVS_RMDE_TP_CD(초진:1, 재진:2, 신환:3) ,  PME_CLS_CD(BB),  PSE_CLS_CD(000)  ,   ETC4(시나리오)
 order by PT_NM                -- 환자생성  ,  외래예약(입원)  ,
;                              -- 필요 시 외래진료비수납 에서 계산버튼 -> 수납버튼
SELECT *
	FROM TEMPPTRSV
 WHERE ETC4 IN ('57 입원','28-2 외래','48-2 외래','58 외래','69 입원','70 외래','82 외래')
;;

SELECT A.ROWID
     , B.PACT_ID AS OTPT_PACT_ID
     , A.*
  FROM TEMPPTRSV A
     , ACPPRODM  B
WHERE A.PT_NO = B.PT_NO(+)
  AND A.MED_ADS_DT = B.MED_DT(+)
;;

SELECT *
  FROM TEMPPTRSV
 WHERE PT_NM LIKE '통테%'
 ORDER BY TO_NUMBER(SUBSTR(PT_NM,3))
;

SELECT ETC4, PT_NO, PT_NM, A.*
	FROM TEMPPTRSV A
;

SELECT *
  FROM PCTPCPAM
 WHERE PT_NM LIKE '통테%'
;




