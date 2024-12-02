 EXEC :IN_FR_DT := '20110801';
EXEC :IN_TO_DT := '20110831';


/*
지역별 2010,2011년 수납기준환자수





*/

   SELECT DECODE(CSUBCD_NM, NULL, '합계', CSUBCD_NM)         "지역명"
        , SUM(A)                                           "합계 보험"
        , SUM(B)                                           "합계 차상위"
        , SUM(C)                                           "합계 보호"
        , SUM(D)                                           "합계 일반"
        , SUM(E)                                           "합계 산재/공상"
        , SUM(F)                                           "합계 교통"
        , SUM(G)                                           "합계 행려"
        , SUM(H)                                           "합계 기타"
        , SUM(CASE WHEN MED_TYP = '3' THEN A ELSE 0 END)   "신환 보험"
        , SUM(CASE WHEN MED_TYP = '3' THEN B ELSE 0 END)   "신환 차상위"
        , SUM(CASE WHEN MED_TYP = '3' THEN C ELSE 0 END)   "신환 보호"
        , SUM(CASE WHEN MED_TYP = '3' THEN D ELSE 0 END)   "신환 일반"
        , SUM(CASE WHEN MED_TYP = '3' THEN E ELSE 0 END)   "신환 산재/공상"
        , SUM(CASE WHEN MED_TYP = '3' THEN F ELSE 0 END)   "신환 교통"
        , SUM(CASE WHEN MED_TYP = '3' THEN G ELSE 0 END)   "신환 행려"
        , SUM(CASE WHEN MED_TYP = '3' THEN H ELSE 0 END)   "신환 기타"
        , SUM(CASE WHEN MED_TYP = '1' THEN A ELSE 0 END)   "초진 보험"
        , SUM(CASE WHEN MED_TYP = '1' THEN B ELSE 0 END)   "초진 차상위"
        , SUM(CASE WHEN MED_TYP = '1' THEN C ELSE 0 END)   "초진 보호"
        , SUM(CASE WHEN MED_TYP = '1' THEN D ELSE 0 END)   "초진 일반"
        , SUM(CASE WHEN MED_TYP = '1' THEN E ELSE 0 END)   "초진 산재/공상"
        , SUM(CASE WHEN MED_TYP = '1' THEN F ELSE 0 END)   "초진 교통"
        , SUM(CASE WHEN MED_TYP = '1' THEN G ELSE 0 END)   "초진 행려"
        , SUM(CASE WHEN MED_TYP = '1' THEN H ELSE 0 END)   "초진 기타"
        , SUM(CASE WHEN MED_TYP = '2' THEN A ELSE 0 END)   "재진 보험"
        , SUM(CASE WHEN MED_TYP = '2' THEN B ELSE 0 END)   "재진 차상위"
        , SUM(CASE WHEN MED_TYP = '2' THEN C ELSE 0 END)   "재진 보호"
        , SUM(CASE WHEN MED_TYP = '2' THEN D ELSE 0 END)   "재진 일반"
        , SUM(CASE WHEN MED_TYP = '2' THEN E ELSE 0 END)   "재진 산재/공상"
        , SUM(CASE WHEN MED_TYP = '2' THEN F ELSE 0 END)   "재진 교통"
        , SUM(CASE WHEN MED_TYP = '2' THEN G ELSE 0 END)   "재진 행려"
        , SUM(CASE WHEN MED_TYP = '2' THEN H ELSE 0 END)   "재진 기타"
     FROM (



/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

          SELECT
                 CSUBCD_NM
               , MED_TYP
                        , SUM(CASE WHEN PATTYPE = 'BB'              THEN 1 ELSE 0 END) A
                        , SUM(CASE WHEN PATTYPE IN ('B1','B2','B6') THEN 1 ELSE 0 END) B
                        , SUM(CASE WHEN PATTYPE IN ('E1','E2','E6') THEN 1 ELSE 0 END) C
                        , SUM(CASE WHEN PATTYPE = 'AA'              THEN 1 ELSE 0 END) D
                        , SUM(CASE WHEN PATTYPE IN ('SA','SB','SP') THEN 1 ELSE 0 END) E
                        , SUM(CASE WHEN PATTYPE = 'TA'              THEN 1 ELSE 0 END) F
                        , SUM(CASE WHEN PATTYPE = 'E8'              THEN 1 ELSE 0 END) G
                        , SUM(CASE WHEN PATTYPE NOT IN ('B1','B2','B6','BB'
                                                   ,'E1','E2','E6','AA'
                                                   ,'SA','SB','SP','TA'
                                                   ,'E8')       THEN 1 ELSE 0 END) H
            FROM (


/* ㄴ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          SELECT DECODE(BB.COMN_CD_NM, NULL, '주소미상', BB.COMN_CD_NM) AS CSUBCD_NM
                               , PT_NO                                              AS PT_NO
                               , MED_DEPT                                           AS MED_DEPT
                               , PATTYPE                                            AS PATTYPE
                               , MED_TYP                                            AS MED_TYP
                            FROM (


/* ㄱ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      -- 여기가 문제다 문제야

                      -- 2024-11-21 김용록 : 중복 제거
                        select PT_NO
                               ,MED_DEPT
                               ,PATTYPE
                               ,DEPT_NM
                               ,MED_TYP
                               ,AREA_CD
--                               ,POST_NO_SEQ
--                               ,post_no

                        from (

                                 SELECT A.PT_NO                                                 as PT_NO
                                  , A.MED_DEPT_CD                                               AS MED_DEPT
                                  , A.PME_CLS_CD                                                AS PATTYPE
                                  , NVL( ( XBIL.FC_GET_DEPT_NM(A.MED_DEPT_CD)) , A.MED_DEPT_CD) AS DEPT_NM
                                  , DECODE(A.FRVS_RMDE_TP_CD, '4', '1', A.FRVS_RMDE_TP_CD)      AS MED_TYP              /* 초재진 구분*/
                                  , C.LCL_TP_CD
--                                  ,C.COMN_CD
                                                                                                AS AREA_CD

                                  ,B.POST_NO_SEQ
                                  ,B.post_no

                               FROM ACPPRODM A
                                  , PCTPCPTD B
--                                  , CCCCCSTE C
                                      , CCCCCPOD C /*우편번호정보 테이블 */
--                                      , CCCCCPMD D /*도로명주소지번주소매칭정보 테이블 */
                              WHERE A.MED_DT   BETWEEN  TO_DATE(:IN_FR_DT ,'YYYYMMDD')
                                                   AND  TO_DATE(:IN_TO_DT ,'YYYYMMDD') + .99999
                                AND A.APCN_DTM  IS NULL     /* 취소일자 */
                   --                 AND A.MEDRCP_YN    IN ('Y','1')
                   --                 AND CASE WHEN
                   --                          ( ( SUBSTR(MED_DEPT,1,3) NOT IN ('HPC') AND NVL(SUBSTR(RSV_TYP,1,1),'1') NOT IN ('8','9','X') )
                   --                          OR ( SUBSTR(MED_DEPT,1,3) IN ('HPC') AND RSV_TYP IN ('0') ) ) THEN 'Y'
                   --                    END = 'Y'
                                    --------------------------------------------------------------------------
                                    -- 2010.10.01 이강준 2010년10월1일부터는 'C'(주로 임상임) 포함한다.
                                    --------------------------------------------------------------------------
                                    --기존 logic
                                    --and nvl(substr(c.rsv_typ,1,1),'1') not in ('8','9','C')
                                    -- 2011-01-25 권욱주 : rsv_typ = 9 는 내시경 처방 전까지는 임시 예약 이후 -> 9로  update 됨
                                    --------------------------------------------------------------------------
                                         AND CASE                      WHEN TO_CHAR(A.MED_DT,'YYYYMMDD') >= '20101001'
                                                                        AND TO_CHAR(A.MED_DT,'YYYYMMDD') < '20110301'
                                                                        AND NVL(SUBSTR(A.OTPT_RSV_TP_CD,1,1),'1')  NOT IN ('8','9','X')
                                                                            THEN 'Y'

                                                                       WHEN TO_CHAR(A.MED_DT,'YYYYMMDD')  < '20101001'
                                                                        AND NVL(SUBSTR(A.OTPT_RSV_TP_CD,1,1),'1')  NOT IN ('8','9','C','X')
                                                                            THEN 'Y'
                       --------------------------------------------------------------------------
                       -- 2011.02.25 최선만 2011년 3월 1일부터는 HPC(종검)일경우 예약구분이 0 인것만을 인원수에 포함한다.
                       --------------------------------------------------------------------------
                                                                       WHEN TO_CHAR(A.MED_DT,'YYYYMMDD') >= '20110301'
                                                                        AND TO_CHAR(A.MED_DT,'YYYYMMDD') < '20110701'
                                                                        AND ( ( SUBSTR(A.MED_DEPT_CD,1,3) NOT IN ('HPC')
                                                                        AND NVL(SUBSTR(A.OTPT_RSV_TP_CD,1,1),'1') NOT IN ('8','9','X') )
                                                                         OR ( SUBSTR(A.MED_DEPT_CD,1,3) IN ('HPC')
                                                                        AND A.OTPT_RSV_TP_CD IN ('0') ) )
                                                                            THEN 'Y'

                       --------------------------------------------------------------------------
                       -- 2011.06.15 최선만 인공신장실의 경우 무료예약접수분도 인원수에 포함한다.
                       --------------------------------------------------------------------------
                                                                       WHEN TO_CHAR(A.MED_DT,'YYYYMMDD') >= '20110701'
                                                                        AND ( ( SUBSTR(A.MED_DEPT_CD,1,3) NOT IN ('HPC') AND NVL(SUBSTR(  A.OTPT_RSV_TP_CD,1,1),'1') NOT IN ('8','9','X') )
                                                                         OR ( SUBSTR(A.MED_DEPT_CD,1,3) IN ('HPC') AND A.OTPT_RSV_TP_CD IN ('0') )
                                                                         OR (SUBSTR(A.MEDR_SID,1,3) IN ('IMN') AND A.OTPT_RSV_TP_CD IN ('9') ) )
                                                                            THEN 'Y'
                                                                            ELSE 'N'
                                               END  = 'Y'
                                    -- 인공신장실 IMN0으로 시작하는 의사 건수 포함시키기 위해서...
                        AND A.MEF_RPY_CLS_CD = CASE WHEN TO_CHAR(A.MED_DT,'YYYYMMDD') >= '20110701' AND SUBSTR(A.MEDR_SID,1,3) = 'IMN' THEN A.MEF_RPY_CLS_CD
                                                           ELSE 'Y'
                                                       END
                                    --------------------------------------------------------------------------
                                    AND B.PT_NO = A.PT_NO
                                   AND C.post_no(+) = B.post_no
                                         -- 2024-11-21 김용록 : 이 부분 확인 필요
--                                      AND C.POST_NO_SEQ(+) = B.POST_NO_SEQ




                              -- 2024-11-21 김용록 : 중복 제거
                             )

--                               WHERE AREA_CD IS NOT NULL

                               group by      PT_NO
                                         ,MED_DEPT
                                         ,PATTYPE
                                         ,DEPT_NM
                                         ,MED_TYP
                                         ,AREA_CD
--                                         ,POST_NO_SEQ
--                                         ,post_no




/* ㄱ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                 ) AA
                               ,  CCCCCSTE BB
                           WHERE (BB.COMN_GRP_CD(+) = 'ASIS260'
                                  OR BB.COMN_GRP_CD(+) = '260')
                             AND BB.COMN_CD(+) = AA.AREA_CD

--;;;;
--SELECT *
-- FROM CCCCCSTE
-- WHERE COMN_GRP_CD = 'ASIS260' ;
-- SELECT
--
-- ;


/* ㄴ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          UNION ALL

/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

--select * from CCCCCSTE where COMN_GRP_CD = '260'



                          SELECT
                               DECODE(BB.COMN_CD_NM, NULL, '주소미상', BB.COMN_CD_NM) AS CSUBCD_NM
                              ,PT_NO                                              AS PT_NO
                              ,MED_DEPT                                           AS MED_DEPT
                              ,PATTYPE                                            AS PATTYPE
                              ,MED_TYP                                            AS MED_TYP
--                               ,POST_NO_SEQ
--                               ,post_no
                            FROM (


/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                  SELECT
                                        A.PT_NO                                                  AS PT_NO
                                  , A.MED_DEPT_CD                                                AS MED_DEPT
                                  , A.PME_CLS_CD                                                 AS PATTYPE
                                  , DECODE(A.FRVS_RMDE_TP_CD, '4', '1', A.FRVS_RMDE_TP_CD)        AS MED_TYP         /* 초재진 구분*/
                                      , C.LCL_TP_CD                                              AS AREA_CD

                                       ,B.POST_NO_SEQ
                                  ,B.post_no
                                   FROM ACPPRETM A
                                      , PCTPCPTD B
                                      , CCCCCPOD C
                                   WHERE A.EMRM_ARVL_DTM   BETWEEN  TO_DATE(:IN_FR_DT ,'YYYYMMDD')
                                                           AND  TO_DATE(:IN_TO_DT ,'YYYYMMDD') + .99999
                                 AND A.APCN_DTM  IS NULL  /* 접수취소 */
                                 AND A.ADS_DT    IS NULL
                     --------------------------------------------------------------------------
                     -- 2010.10.01 이강준 2010년10월1일부터는 'C'(주로 임상임) 포함한다.
                     --------------------------------------------------------------------------
                     --기존 LOGIC
                     --AND NVL(SUBSTR(C.RSV_TYP,1,1),'1')   NOT IN ('8','9','C')
                     -- 2011-01-25 권욱주 : RSV_TYP = 9 는 내시경 처방 전까지는 임시 예약 이후 -> 9로  UPDATE 됨
                     --------------------------------------------------------------------------
                                AND CASE WHEN TO_CHAR(EMRM_ARVL_DTM,'YYYYMMDD') >= '20101001' AND NVL(SUBSTR(A.OTPT_RSV_TP_CD,1,1),'1')  NOT IN ('8','9','X')      THEN 'Y'
                                         WHEN TO_CHAR(EMRM_ARVL_DTM,'YYYYMMDD')  < '20101001' AND NVL(SUBSTR(A.CTH_ITHD_NRS_STF_NO,1,1),'1')  NOT IN ('8','9','C','X')  THEN 'Y'
                                         ELSE 'N'
                                     END  = 'Y'
                                    --------------------------------------------------------------------------
                                    AND B.PT_NO = A.PT_NO
                                    AND C.POST_NO(+) = B.POST_NO

                                    -- 2024-11-21 김용록 : 이 부분 확인 필요
--                                    AND C.POST_NO_SEQ(+) = B.POST_NO_SEQ



--                                 ;
----SELECT * FROM PCTPCPTD WHERE ROWNUM < 10;
----select ZIP_NO,ZIP_SEQ  from CCPOSTMT where rownum<10;
----select post_no,POST_NO_SEQ,LCL_TP_CD  from CCCCCPOD where rownum<10;
--SELECT post_no , POST_NO_SEQ FROM  CCCCCPOD;
--SELECT post_no , POST_NO_SEQ FROM PCTPCPTD;
--                                  ;
/* 1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                  )


                                    AA
                               , CCCCCSTE BB
                           WHERE (BB.COMN_GRP_CD(+) = 'ASIS260'
                                  OR BB.COMN_GRP_CD(+) = '260')
                             AND BB.COMN_CD(+) = AA.AREA_CD

/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                 ) A
           GROUP BY CSUBCD_NM, MED_TYP, PATTYPE


/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

          )
    GROUP BY ROLLUP(CSUBCD_NM)


                                ;
    EXEC :IN_FR_DT := '20110801';
           EXEC :IN_TO_DT := '20110831';

/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*
  제목  : 진료과별 지역별 의사별/2010, 11년 수납기준환자수
            - 지역별 2010, 11년 수납기준환자수

  기능  : 2010,2011 만 조회 가능합니다.
           ASIS -> TOBE 컨버전 없이 들고왔습니다.

  ASIS : pkg_bil_aid999.pc_sel_pts04_income001

  TEST : EXEC :IN_FR_DT := '20110801';
           EXEC :IN_TO_DT := '20110831';

  특이사항 : TOBE에는 지역구분 코드가 없어, 우편번호 앞자리 3개로 구분하는 FUNCTION 만들었습니다.
            - XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO)
*/
/* ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT DECODE(CSUBCD_NM, NULL, '합계', CSUBCD_NM)       "지역명"
			     , SUM(A)                                           "합계 보험"
			     , SUM(B)                                           "합계 차상위"
			     , SUM(C)                                           "합계 보호"
			     , SUM(D)                                           "합계 일반"
			     , SUM(E)                                           "합계 산재/공상"
			     , SUM(F)                                           "합계 교통"
			     , SUM(G)                                           "합계 행려"
			     , SUM(H)                                           "합계 기타"
			     , SUM(CASE WHEN MED_TYP = '3' THEN A ELSE 0 END)   "신환 보험"
			     , SUM(CASE WHEN MED_TYP = '3' THEN B ELSE 0 END)   "신환 차상위"
			     , SUM(CASE WHEN MED_TYP = '3' THEN C ELSE 0 END)   "신환 보호"
			     , SUM(CASE WHEN MED_TYP = '3' THEN D ELSE 0 END)   "신환 일반"
			     , SUM(CASE WHEN MED_TYP = '3' THEN E ELSE 0 END)   "신환 산재/공상"
			     , SUM(CASE WHEN MED_TYP = '3' THEN F ELSE 0 END)   "신환 교통"
			     , SUM(CASE WHEN MED_TYP = '3' THEN G ELSE 0 END)   "신환 행려"
			     , SUM(CASE WHEN MED_TYP = '3' THEN H ELSE 0 END)   "신환 기타"
			     , SUM(CASE WHEN MED_TYP = '1' THEN A ELSE 0 END)   "초진 보험"
			     , SUM(CASE WHEN MED_TYP = '1' THEN B ELSE 0 END)   "초진 차상위"
			     , SUM(CASE WHEN MED_TYP = '1' THEN C ELSE 0 END)   "초진 보호"
			     , SUM(CASE WHEN MED_TYP = '1' THEN D ELSE 0 END)   "초진 일반"
			     , SUM(CASE WHEN MED_TYP = '1' THEN E ELSE 0 END)   "초진 산재/공상"
			     , SUM(CASE WHEN MED_TYP = '1' THEN F ELSE 0 END)   "초진 교통"
			     , SUM(CASE WHEN MED_TYP = '1' THEN G ELSE 0 END)   "초진 행려"
			     , SUM(CASE WHEN MED_TYP = '1' THEN H ELSE 0 END)   "초진 기타"
			     , SUM(CASE WHEN MED_TYP = '2' THEN A ELSE 0 END)   "재진 보험"
			     , SUM(CASE WHEN MED_TYP = '2' THEN B ELSE 0 END)   "재진 차상위"
			     , SUM(CASE WHEN MED_TYP = '2' THEN C ELSE 0 END)   "재진 보호"
			     , SUM(CASE WHEN MED_TYP = '2' THEN D ELSE 0 END)   "재진 일반"
			     , SUM(CASE WHEN MED_TYP = '2' THEN E ELSE 0 END)   "재진 산재/공상"
			     , SUM(CASE WHEN MED_TYP = '2' THEN F ELSE 0 END)   "재진 교통"
			     , SUM(CASE WHEN MED_TYP = '2' THEN G ELSE 0 END)   "재진 행려"
			     , SUM(CASE WHEN MED_TYP = '2' THEN H ELSE 0 END)   "재진 기타"
			  FROM (
			       SELECT
			              CSUBCD_NM
			            , MED_TYP
                        , SUM(CASE WHEN PATTYPE = 'BB'              THEN 1 ELSE 0 END) A
                        , SUM(CASE WHEN PATTYPE IN ('B1','B2','B6') THEN 1 ELSE 0 END) B
                        , SUM(CASE WHEN PATTYPE IN ('E1','E2','E6') THEN 1 ELSE 0 END) C
                        , SUM(CASE WHEN PATTYPE = 'AA'              THEN 1 ELSE 0 END) D
                        , SUM(CASE WHEN PATTYPE IN ('SA','SB','SP') THEN 1 ELSE 0 END) E
                        , SUM(CASE WHEN PATTYPE = 'TA'              THEN 1 ELSE 0 END) F
                        , SUM(CASE WHEN PATTYPE = 'E8'              THEN 1 ELSE 0 END) G
                        , SUM(CASE WHEN PATTYPE NOT IN ('B1','B2','B6','BB'
                                                   ,'E1','E2','E6','AA'
                                                   ,'SA','SB','SP','TA'
                                                   ,'E8')       THEN 1 ELSE 0 END) H
			         FROM (
                    --      SELECT DECODE(BB.CSUBCD_NM, NULL, '주소미상', BB.CSUBCD_NM) CSUBCD_NM, PT_NO, MED_DEPT, PATTYPE, MED_TYP
                     --       FROM (

                                 SELECT
                                        A.PT_NO                 PT_NO
                                      , A.MED_DEPT              MED_DEPT
                                      , A.PATTYPE               PATTYPE
                                      , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
                                      , CASE WHEN XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO) = '주소미상E' THEN '주소미상'
                                             ELSE NVL(XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO),'주소미상')
                                         END                                                                 AS CSUBCD_NM
                                   FROM ASIS_HBIL.APOPRSVT A
                                      , ASIS_HBIL.APPATBAT B
                                     -- , CCPOSTMT C
--                                      , CCCODEST D
                                  WHERE A.MED_DTE > '20101231'
				                            AND A.MED_DTE < '20120101'
				                            AND A.MED_DTE   BETWEEN  TO_DATE(:IN_FR_DT,'YYYY-MM-DD')
                                                        AND  TO_DATE(:IN_TO_DT,'YYYY-MM-DD') + .99999
                                    AND A.CNCL_DTE  IS NULL
                   --                 AND A.MEDRCP_YN    IN ('Y','1')
                   --                 AND CASE WHEN
                   --                          ( ( SUBSTR(MED_DEPT,1,3) NOT IN ('HPC') AND NVL(SUBSTR(RSV_TYP,1,1),'1') NOT IN ('8','9','X') )
                   --                          OR ( SUBSTR(MED_DEPT,1,3) IN ('HPC') AND RSV_TYP IN ('0') ) ) THEN 'Y'
                   --                    END = 'Y'
                                    --------------------------------------------------------------------------
                                    -- 2010.10.01 이강준 2010년10월1일부터는 'C'(주로 임상임) 포함한다.
                                    --------------------------------------------------------------------------
                                    --기존 logic
                                    --and nvl(substr(c.rsv_typ,1,1),'1') not in ('8','9','C')
                                    -- 2011-01-25 권욱주 : rsv_typ = 9 는 내시경 처방 전까지는 임시 예약 이후 -> 9로  update 됨
                                    --------------------------------------------------------------------------
                                    AND CASE WHEN TO_CHAR(MED_DTE,'yyyymmdd') >= '20101001' AND TO_CHAR(MED_DTE,'yyyymmdd') < '20110301'
                                                                                        AND NVL(SUBSTR(A.RSV_TYP,1,1),'1')  NOT IN ('8','9','X')      THEN 'Y'
                                             WHEN TO_CHAR(MED_DTE,'yyyymmdd')  < '20101001'
                                                                                     AND NVL(SUBSTR(A.RSV_TYP,1,1),'1')  NOT IN ('8','9','C','X')  THEN 'Y'
                                    --------------------------------------------------------------------------
                                    -- 2011.02.25 최선만 2011년 3월 1일부터는 HPC(종검)일경우 예약구분이 0 인것만을 인원수에 포함한다.
                                    --------------------------------------------------------------------------
                                             WHEN TO_CHAR(MED_DTE,'yyyymmdd') >= '20110301' AND TO_CHAR(MED_DTE,'yyyymmdd') < '20110701'
                                                   AND ( ( SUBSTR(A.MED_DEPT,1,3) NOT IN ('HPC') AND NVL(SUBSTR(A.RSV_TYP,1,1),'1') NOT IN ('8','9','X') )
                                                        OR ( SUBSTR(A.MED_DEPT,1,3) IN ('HPC') AND A.RSV_TYP IN ('0') ) )                            THEN 'Y'
                                    --------------------------------------------------------------------------
                                    -- 2011.06.15 최선만 인공신장실의 경우 무료예약접수분도 인원수에 포함한다.
                                    --------------------------------------------------------------------------
                                             WHEN TO_CHAR(MED_DTE,'yyyymmdd') >= '20110701'
                                                   AND ( ( SUBSTR(A.MED_DEPT,1,3) NOT IN ('HPC') AND NVL(SUBSTR(A.RSV_TYP,1,1),'1') NOT IN ('8','9','X') )
                                                        OR ( SUBSTR(A.MED_DEPT,1,3) IN ('HPC') AND A.RSV_TYP IN ('0') )
                                                        OR (SUBSTR(A.MEDDR_ID,1,3) IN ('IMN') AND A.RSV_TYP IN ('9') ) )          THEN 'Y'
                                              ELSE 'N'
                                         END  = 'Y'
                                    AND A.MEDRCP_YN = CASE WHEN TO_CHAR(MED_DTE,'YYYYMMDD') >= '20110701' AND SUBSTR(A.MEDDR_ID,1,3) = 'IMN' THEN A.MEDRCP_YN
                                                                  ELSE 'Y'
                                                              END
                                    --------------------------------------------------------------------------
                                    AND B.PT_NO = A.PT_NO
                                    --AND C.ZIP_NO(+)  = B.ZIP_NO
                                    --AND C.ZIP_SEQ(+) = B.ZIP_SEQ
                         --        ) AA
                               --, CCCODEST BB
                         --  WHERE BB.CCD_TYP(+) = '260'
                        --     AND BB.C_CD(+) = AA.AREA_CD
                          UNION ALL
                        --  SELECT DECODE(BB.CSUBCD_NM, NULL, '주소미상', BB.CSUBCD_NM) CSUBCD_NM, PT_NO, MED_DEPT, PATTYPE, MED_TYP
                       --     FROM (
                                 SELECT
                                        A.PT_NO
                                      , A.MED_DEPT
                                      , A.PATTYPE
                                      , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
                                      , CASE WHEN XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO) = '주소미상E' THEN '주소미상'
                                             ELSE NVL(XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO),'주소미상')
                                         END                                                                 AS CSUBCD_NM
                                   FROM ASIS_HBIL.APEMGRCT A
                                      , ASIS_HBIL.APPATBAT B
                                     -- , CCPOSTMT C
--                                      , CCCODEST D
                                  WHERE A.ARV_DTM > '20101231'
				                            AND A.ARV_DTM < '20120101'
				                            AND A.ARV_DTM   BETWEEN  TO_DATE(:IN_FR_DT,'YYYY-MM-DD')
                                                        AND  TO_DATE(:IN_TO_DT,'YYYY-MM-DD') + .99999
                                    AND A.CNCL_DTE  IS NULL
                                    AND A.ADM_DTE IS NULL
                   --                 AND NVL(SUBSTR(A.RSV_TYP,1,1),'1')   NOT IN ('8','9','X')
                                    --------------------------------------------------------------------------
                                    -- 2010.10.01 이강준 2010년10월1일부터는 'C'(주로 임상임) 포함한다.
                                    --------------------------------------------------------------------------
                                    --기존 logic
                                    --and nvl(substr(c.rsv_typ,1,1),'1')   not in ('8','9','C')
                                    -- 2011-01-25 권욱주 : rsv_typ = 9 는 내시경 처방 전까지는 임시 예약 이후 -> 9로  update 됨
                                    --------------------------------------------------------------------------
                                    AND CASE WHEN TO_CHAR(ARV_DTM,'yyyymmdd') >= '20101001' AND NVL(SUBSTR(A.RSV_TYP,1,1),'1')  NOT IN ('8','9','X')      THEN 'Y'
                                             WHEN TO_CHAR(ARV_DTM,'yyyymmdd')  < '20101001' AND NVL(SUBSTR(A.RSV_TYP,1,1),'1')  NOT IN ('8','9','C','X')  THEN 'Y'
                                             ELSE 'N'
                                         END  = 'Y'
                                    --------------------------------------------------------------------------
                                    AND B.PT_NO = A.PT_NO
                                  --  AND C.ZIP_NO(+)  = B.ZIP_NO
                                 --   AND C.ZIP_SEQ(+) = B.ZIP_SEQ
                         --         ) AA
                         --     -- , CCCODEST BB
                         --  WHERE BB.CCD_TYP(+) = '260'
                         --    AND BB.C_CD(+) = AA.AREA_CD


			              ) A
			        GROUP BY CSUBCD_NM, MED_TYP, PATTYPE
			       )
			 GROUP BY ROLLUP(CSUBCD_NM);
