
--후원금납입조회(후원금내역조회)
-- - ASIS : APSPONMT
-- - TOBE : ACPSMSMM

EXEC :IN_PT_NO :=''--A.환자번호
EXEC :IN_SASS_ORG_TP_CD := ''; --B.기관불류
EXEC :IN_DEPT_NM := '';--C.진료과
EXEC :IN_FROM_DT :='2024-01-01';--D.FROM일자
EXEC :IN_TO_DT :='2024-12-12';--E.TO일자

SELECT /*+ */
   a.SASS_MBR_NM                             AS SASS_MBR_NM           /*1.성명*/
   ,a.SASS_MBR_NO                            AS SASS_MBR_NO           /*2.등록번호*/
   ,(SELECT c.PME_CLS_CD ||'  '|| d.CLDG_NM
     FROM SCBCMIWD c/*사업자초기면접정보*/
     WHERE NVL(b.DEL_YN,'N')='N'
         )                                   AS ETC_CNT                /*3.기타*/
   ,a.CNTPS_NM                               AS CNTPS_NM               /*4.상담자*/ -- 확인필요
   ,a.RDTN_STR_DT                            AS RDTN_STR_DT            /*5.시작일자*/
   ,a.RDTN_END_DT                            AS RDTN_END_DT            /*6.종료일자*/
   ,a.SASS_MBR_RDTN_CTRA_CD                  AS SASS_MBR_RDTN_CTRA_CD  /*7.후원사업*/
   ,a.SPPT_AMT                               AS SPPT_AMT               /*8.후원금액*/
   ,b.USE_AMT                                AS USE_AMT                /*9.사용액*/
   ,b.INAM_DT                                AS INAM_DT                /*10.입금일*/
                                                                       /*11.내원형태*/ ------------------
   ,a.SASS_ORG_TP_CD                         AS SASS_ORG_TP_CD         /*12.후원단체명*/
   ,(SELECT e.DEPT_NM
       FROM PDEDBMSM e/*부서기본*/
      WHERE e.DEPT_CD = d.MED_DEPT_CD
      )                                      AS DEPT_NM                /*13.진료과*/
   ,a.BNFT_PRFS_NM                           AS BNFT_PRFS_NM           /*14.주치의/담당의*/ -- 확인필요

FROM ACPSMSMM a/*후원금납입기초*/
    ,SCBSMCMD b/*후원현황정보*/
    ,MOODIPCD d/*환자수진일별진단정보*/

WHERE a.PT_NO = b.PT_NO(+)
  AND ROWNUM < 10;

  ;
  -- 마지막에 크게 감쌀 거
 AND (  (:IN_SASS_ORG_TP_CD IS NULL AND :IN_SASS_ORG_TP_CD IS NULL)
       OR (:IN_PT_NO IS NOT NULL AND (  PT_NO = :IN_PT_NO -- 환자번호
                                   OR   SASS_ORG_TP_CD = :IN_SASS_ORG_TP_CD -- 기관
                                   OR   DEPT_NM = :IN_DEPT_NM -- 진료과
                                   OR ( a.SASS_MBR_REG_DT BETWEEN :IN_FROM_DT AND :IN_TO_DT ))   -- 조회날짜
                                   )
       );

       -------------------------------------------------------------------------------------------------------------------------------------------



SELECT /*+ */
   a.SASS_MBR_NM                             AS SASS_MBR_NM           /*1.성명*/
   ,a.SASS_MBR_NO                            AS SASS_MBR_NO           /*2.등록번호*/
              /*3.기타*/
   ,a.CNTPS_NM                               AS CNTPS_NM               /*4.상담자*/ -- 확인필요
   ,a.RDTN_STR_DT                            AS RDTN_STR_DT            /*5.시작일자*/
   ,a.RDTN_END_DT                            AS RDTN_END_DT            /*6.종료일자*/
   ,a.SASS_MBR_RDTN_CTRA_CD                  AS SASS_MBR_RDTN_CTRA_CD  /*7.후원사업*/
   ,a.SPPT_AMT                               AS SPPT_AMT               /*8.후원금액*/
   ,b.USE_AMT                                AS USE_AMT                /*9.사용액*/
   ,b.INAM_DT                                AS INAM_DT                /*10.입금일*/
                                                                       /*11.내원형태*/ ------------------
   ,a.SASS_ORG_TP_CD                         AS SASS_ORG_TP_CD         /*12.후원단체명*/
           /*13.진료과*/
   ,a.BNFT_PRFS_NM                           AS BNFT_PRFS_NM           /*14.주치의/담당의*/ -- 확인필요

FROM ACPSMSMM a/*후원금납입기초*/
    ,SCBSMCMD b/*후원현황정보*/


WHERE a.PT_NO = b.PT_NO(+)
  AND ROWNUM < 10;


SELECT * FROM ACPSMSMM WHERE ROWNUM < 10;
SELECT * FROM SCBSMCMD WHERE ROWNUM < 10;


       -------------------------------------------------------------------------------------------------------------------------------------------
;
SELECT *
  FROM EMBUMENT
 WHERE MENU_NM LIKE '%후원금%'
;

SELECT (c.PME_CLS_CD ||'  '|| d.CLDG_NM) AS ETC_CNT FROM
       SCBCMIWD c/*사업자초기면접정보*/
    ,MOODIPCD d/*환자수진일별진단정보*/
        WHERE c.PT_NO = d.PT_NO AND ROWNUM < 10;

 where
	nvl(mn_dz_yn,'N')    = 'Y'
	and nvl(b.DEL_YN,'N')      = 'N'
	and A.<<VOC_ID | CLDG_VOC_ID>>       = B.VOC_ID
	and rownum < 100
