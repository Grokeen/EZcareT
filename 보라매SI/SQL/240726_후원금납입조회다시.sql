EXEC :IN_PT_NO :=''--A.환자번호
EXEC :IN_FROM_DT :='2024-01-01';--A-1.FROM일자
EXEC :IN_TO_DT :='2024-12-12';--A-2.TO일자

EXEC :IN_SASS_ORG_TP_CD := ''; --B.기관분류
EXEC :IN_DEPT_NM := '';--C.진료과
/*------------------------------------------------------------------*/
/*  환자별              기관분류별                 진료과별 */
    /*1.성명*/         /*7.후원사업*/            /*13.진료과*/
    /*2.등록번호*/      /*12.후원단체명*/         /*14.주치의/담당의*/
    /*3.기타*/         /*2.등록번호*/            /*2.등록번호*/
    /*4.상담자*/       /*1.성명*/                /*1.성명*/
    /*5.시작일자*/      /*5.시작일자*/            /*7.후원사업*/
    /*6.종료일자*/      /*6.종료일자*/            /*12.후원단체명*/
    /*7.후원사업*/      /*8.후원금액*/            /*5.시작일자*/
    /*8.후원금액*/      /*9.사용액*/              /*6.종료일자*/
    /*9.사용액*/        /*13.진료과*/             /*8.후원금액*/
    /*10.입금일*/       /*14.주치의/담당의*/       /*9.사용액*/
    /*11.내원형태*/      /*4.상담자*/             /*4.상담자*/
                       /*10.입금일*/             /*10.입금일*/
/*------------------------------------------------------------------*/
SELECT /*+ */
    c.PT_NM                                  AS PT_NM                 /*1.성명*/
   ,a.PT_NO                                  AS PT_NO                 /*2.등록번호*/

   ,(SELECT
        d.ICD10_CD ||'  '|| d.CLDG_NM
     FROM MOODIPAM d    /*테이블명 : 환자진단기본*/
     WHERE -- d.PT_NO = :IN_PT_NO
       --AND
       d.PT_NO = e.PT_NO
       AND d.DGNS_ID = e.DGNS_ID
       AND NVL(d.TDY_DGNS_DEL_YN,'N')='N'
       AND NVL(e.MAIN_SKNS_YN,'N')='Y'
       AND ROWNUM = 1
     )                                       AS ETC_CNT                /*3.기타*/ -- IN환자번호
   ,b.CNSL_RER_PSN_NM                        AS CNTPS_NM               /*4.상담자*/
   ,a.SPPT_STR_DT                            AS SPPT_STR_DT            /*5.시작일자*/
   ,a.SPPT_END_DT                            AS SPPT_END_DT            /*6.종료일자*/
   ,a.SPPT_CORG_CD                           AS SPPT_CORG_CD           /*7.후원사업코드*/
   ,a.SPPT_AMT                               AS SPPT_AMT               /*8.후원금액*/
   ,a.USE_AMT                                AS USE_AMT                /*9.사용액*/
   ,a.INAM_DT                                AS INAM_DT                /*10.입금일*/
   ,e.RMK_CNTE                               AS RMK_CNTE               /*11.내원형태*/
   ,f.COMN_GRP_CD_NM                         AS COMN_GRP_CD_NM         /*12.후원단체명*/

   ,(SELECT
        g.DEPT_NM
     FROM PDEDBMSM g    /*테이블명 : 부서기본(진료과)*/
     WHERE b.MED_DEPT_CD = g.DEPT_CD
     )                                       AS DEPT_NM                /*13.진료과*/
   ,b.ANDR_STF_NO||'/'||b.ASD_STF_NO         AS BNFT_PRFS_NM           /*14.주치의/담당의*/

FROM SCBSMCMD a         /*테이블명 : 후원현황정보*/

    LEFT JOIN SCBCMIWD b/*테이블명 : 사회사업초기면접정보*/
        ON  a.PT_NO = b.PT_NO
        AND a.FTFT_DT = b.FTFT_DT
        AND a.SPPT_CRCCM_SEQ = b.FTFT_SEQ

    LEFT JOIN PCTPCPAM c/*테이블명 : 환자기본정보*/
        ON a.PT_NO = c.PT_NO

    LEFT JOIN MOODIPCD e/*테이블명 : 환자수진일별진단정보*/
        ON a.PT_NO = e.PT_NO

    LEFT JOIN CCCCCLTC f/*테이블명 : 그룹공통코드(소분류)*/
        ON  a.SPPT_CORG_CD = f.COMN_GRP_CD

WHERE
--조건 1_환자별후원금조회

--조건 2_진료과별후원금조회
f.NEXTG_FMR_COMN_GRP_CD = 'SW24'

--조건 3_후원기관별후원금조회

AND ROWNUM < 10;




