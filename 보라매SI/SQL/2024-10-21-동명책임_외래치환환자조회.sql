




ROWNUM
AS ROW_NO			        --00.NO.

AS PT_NO		          --01.환자번호
AS PT_NM		          --02.환자명
AS ADS_DT		          --03.입원일자
AS DEPT_NO		        --04.진료과

AS MEDR_NM		        --05.진료의
AS CNCL_YN		        --06.취소여부
AS WK_CMPL_YN		      --07.EMR작업완료여부
AS WK_STR_DTM 		    --08.작업시작일시
AS PA_CMPL_DTM		    --09.원무완료일시
AS PRO_CMPL_STF_ID		--10.처리완료자
AS RMK_CNTE			      --11.비고
AS CHECKLIST_CNTE	    --12.체크리스트 내용


FROM


WHERE A.CHK_CLS = '23' --체크유형(23 :입원->외래치환)
	AND (
            (A.PT_NO = IN_PT_NO)
        OR	(NVL(IN_PT_NO,'*') = '*')
        )

	AND WK_DTM BETWEEN V_FROM_DTE AND V_TO_DTE + .99999
	AND A.PT_NO 	= B.PT_NO
	AND C.PT_NO 	= A.PT_NO
	AND C.PT_CHK_NO = A.PT_CHK_NO -- **환자체크번호
	AND D.PT_NO		(+)= C.PT_NO
	AND D.ADM_DTE	(+)= C.ADM_DTE

	AND (
            (IN_ENDYN = 'Y' AND A.FIN_DTM  IS NOT NULL)
        OR  (IN_ENDYN = 'N' AND A.FIN_DTM  IS NULL)
        OR  (NVL(IN_ENDYN,'*') = '*')
        )

    AND (
            (NVL(C.EMR_WORK_YN, 'N') = IN_EMRYN)
        OR  (NVL(IN_EMRYN,'*') = '*')
        )


ORDER BY 9


;;;


SELECT *
  FROM EMBUMENT
 WHERE ROWNUM < 10;
;





select *
  from ACPPRAAM--acppraam
where sihs_yn = 'Y'
  and apcn_dtm is null --취소를 안함
--  and PME_CLS_CD LIKE 'E%'
order by ads_dtm desc



