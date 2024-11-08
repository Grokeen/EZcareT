

exec :IN_PT_NO := '';
exec :IN_FROM_DATE := '20240401';
exec :IN_TO_DATE := '20240531';
EXEC :IN_ENDYN := 'Y';
EXEC :IN_EMRYN := 'Y';


-- ASIS
SELECT * FROM APCHKLST  WHERE PT_NO = '01962766' ; -- 체크리스트
SELECT * FROM APREPLOPT  WHERE PT_NO = '01962766' ; -- 입원취소외래치환


-- TOBE
SELECT * FROM ACPPRITD  WHERE PT_NO = '01962766' ;
SELECT * FROM ACPPRAAM  WHERE PT_NO = '01962766'  ;
SELECT * FROM ACPPRRDE
 WHERE PT_NO = '01962766' ;
   AND INPT_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD') AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD') + .99999
   AND (   /* 완료 여부 */
	                (:IN_ENDYN = 'Y' AND CMPL_PRO_DTM IS NOT NULL)
	            OR  (:IN_ENDYN = 'N' AND CMPL_PRO_DTM IS NULL)
	            OR  (NVL(:IN_ENDYN,'*') = '*')
	            )
  ;
;;;



SELECT    /*+ HIS.PA.AC.PI.PS.SelectOtptReplacePatientAsk */
     PT_NO
    ,PT_NM
    ,ADS_DT
    ,MED_DEPT_CD
    ,MED_DR
    ,CNCL_YN
    ,EMR_YN
    ,INPT_DT
    ,CMPL_PRO_DTM
    ,CMPL_PRO_STF_NO
    ,TRAN_RMK
    ,CTN_CNTE
--    ,CHECKED_CTN_CNTE



 FROM
    (SELECT
            COALESCE(C.PT_NO,B.PT_NO,A.PT_NO)             AS PT_NO		      --01.환자번호
					, (SELECT D.PT_NM
					     FROM PCTPCPAM D --환자기본
					    WHERE D.PT_NO = COALESCE(C.PT_NO,B.PT_NO,A.PT_NO)
					      AND	ROWNUM =1)								            AS PT_NM	      	--02.환자명


					, TO_CHAR(B.ADS_DT, 'YYYY-MM-DD')			          AS ADS_DT		      --03.입원일자
					, B.MED_DEPT_CD                                 AS MED_DEPT_CD		--04.진료과


          , CASE WHEN B.ANDR_STF_NO IS NOT NULL
					       THEN B.ANDR_STF_NO||'['||FT_STF_INF(B.ANDR_STF_NO,'STF_NM')||']'
					       ELSE ''
					  END                                            AS MED_DR         --05.진료의

--					,CASE WHEN TRUNC(SYSDATE) >= TO_DATE('20170301', 'YYYYMMDD')
--					          THEN (NVL(  XCOM.FT_CNL_SELSTFINFO( '4',B.ANDR_STF_NO, TO_CHAR(TO_DATE(:IN_FROM_DATE,'YYYYMMDD'),'YYYY-MM-DD'))
--                              , XCOM.FT_CNL_SELSTFINFO( '4', B.ANDR_STF_NO, TO_CHAR(SYSDATE,'YYYY-MM-DD'))
--                              )
--                          )
--                    ELSE (NVL(
--                             NVL(  XCOM.FT_CNL_SELSTFINFO( '4',B.ANDR_STF_NO , '20170228')
--                                 , XCOM.FT_CNL_SELSTFINFO( '4', B.ANDR_STF_NO , TO_CHAR(SYSDATE,'YYYY-MM-DD'))
--                                 )
--                             ,XCOM.FT_CNL_SELSTFINFO( '4', B.ANDR_STF_NO , '20170301')
--                             )
--                          )
--           END                                             AS MED_DR2 --05.진료의


					, DECODE(B.APCN_DTM, NULL, 'N', 'Y')		         AS CNCL_YN		      --06.취소상태
					, NVL(C.CMPT_WK_CMPL_YN, 'N')				             AS EMR_YN		      --07.EMR작업완료여부
					, TO_CHAR(A.INPT_DT, 'YYYY-MM-DD')   		         AS INPT_DT 		    --08.작업시작일시(입력일자)
					, TO_CHAR(A.CMPL_PRO_DTM, 'YYYY-MM-DD')  		     AS CMPL_PRO_DTM	  --09.원무완료일시
					, CASE WHEN A.CMPL_PRO_STF_NO IS NOT NULL
					       THEN A.CMPL_PRO_STF_NO||'['||FT_STF_INF(A.CMPL_PRO_STF_NO,'STF_NM')||']'
					       ELSE ''
					  END                                            AS CMPL_PRO_STF_NO  --10.처리완료자
          , C.TRAN_RMK
          , A.CTN_CNTE           							             AS CTN_CNTE         --12.체크리스트 내용



          /* UPDATE/INSERT 필요값 */
          , NVL(A.CTN_TGPT_SEQ,C.CTN_TGPT_SEQ )             AS OUT_CTN_TGPT_SEQ --A.주의대상환자순번
          , NVL(A.BOBD_PT_NO,C.BOBD_PT_NO)                 AS OUT_BOBD_PT_NO   --B.합본이전환자번호

          , NVL(TO_CHAR(A.BIND_DTM, 'YYYY-MM-DD') ,TO_CHAR(C.BIND_DTM, 'YYYY-MM-DD') )
                                                           AS OUT_BIND_DTM     --C.합본일시
          , NVL(B.PACT_ID,C.PACT_ID)                       AS OUT_PACT_ID      --D.원무접수ID
     FROM
					 ACPPRRDE A  --주의대상환자상세 테이블
					,ACPPRAAM	B  --입원접수 테이블
          ,ACPPRITD C  --입원취소외래치환정보 테이블

    WHERE     A.PT_INSP_LIST_CLS_CD = '23' /* 체크유형(23 :입원->외래치환) */

          AND B.PT_NO = A.PT_NO
          AND B.PT_NO (+)= C.PT_NO
          AND B.PACT_ID (+)= C.PACT_ID
          AND DECODE(B.APCN_DTM, NULL, 'N', 'Y') = 'Y'  /* 입원 취소 여부 */

          /* 주의대상환자순번 = 1*/
          AND A.CTN_TGPT_SEQ = 1

					AND B.ADS_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD') AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD') + .99999
--          AND A.INPT_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD') AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD') + .99999


--        <IsNotEmpty Property="IN_PT_NO">
--          <IsNotNull Property="IN_PT_NO" >
--          ANd A.PT_NO  = :IN_PT_NO
--          </IsNotNull>
--        </IsNotEmpty>




          -- 아래 두개의 차이를 모르겠습니다.
					AND (   /* 원무처리 여부 -> 주의대상환자상세 테이블 완료 여부 */
	                (:IN_ENDYN = 'Y' AND A.PRO_YN IS NOT NULL)
	            OR  (:IN_ENDYN = 'N' AND A.PRO_YN IS NULL)
	            OR  (NVL(:PRO_YN,'*') = '*')
	            )

	        AND (   /* EMR처리 여부 -> 입원취소외래치환정보 테이블 완료 여부 */
	                (NVL(C.CMPT_WK_CMPL_YN, 'N') = :IN_EMRYN)
	            OR  (NVL(:IN_EMRYN,'*') = '*')
	            )



)
   GROUP BY
     PT_NO
    ,PT_NM
    ,ADS_DT
    ,MED_DEPT_CD
    ,MED_DR
    ,CNCL_YN
    ,EMR_YN
    ,INPT_DT
    ,CMPL_PRO_DTM
    ,CMPL_PRO_STF_NO
    ,TRAN_RMK
    ,CTN_CNTE
--    ,CHECKED_CTN_CNTE

   ORDER BY ADS_DT ASC
