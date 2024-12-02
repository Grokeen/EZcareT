
/*
ASIS 화면명 : 진료과별 지역별 의사별 실 외래환자수

통합데이터 요구사항 :
    - 완료 ▶ 진료과별/지역별/의사별 구분값 선택 가능하도록 수정 필요(EMR화면 첨부)
    - 완료 ▶ 상단 부서명→진료과명으로 수정 필요
    - 완료 ▶ 하단 합계란 필요
    - 완료 ▶ 현재 조회시 ### 칼럼도 함께 확인되고 있음

ASIS 화면 : MIS/PTS/PTS/PTS/READFOREIGNSEL.ASPX

ASIS 쿼리 :
    pkg_bil_aid999.pcb_aireqdzt_inptyp_s03    / 진료과별 외래실환자수
    pkg_bil_aid999.pcb_aireqdzt_inptyp_s04    / 지역별 외래실환자수
    pkg_bil_aid999.pcb_aireqdzt_inptyp_s05    / 의사별 외래실환자수

TEST :
    exec :IN_FR_DT := '20240801';
    exec :IN_TO_DT := '20240831';

참고 :
    ASIS에는 지역별 코드가 존재하지만, TOBE에 없어, 우편번호 앞자리로 지역 구분하는 펑션 만들어 놨습니다.
        - XBIL.FC_ACP_GET_POST_AREA_NM( 'POST' , A.PT_NO )
            - POST : 우편번호로 지역 구분
            - ASIS : ASIS방식 적용 -> 상당히 오래 걸림
*/

-- 지역별 실 외래환자수


SELECT
       NVL(ASIS.AREA_NM , TOBE.AREA_NM )          AS "지역별"
     , NVL(ASIS.A1 ,0) + NVL(TOBE.A1 ,0)          AS "합계 보험"
     , NVL(ASIS.A2 ,0) + NVL(TOBE.A2 ,0)          AS "합계 차상위"
     , NVL(ASIS.A3 ,0) + NVL(TOBE.A3 ,0)          AS "합계 보호"
     , NVL(ASIS.A4 ,0) + NVL(TOBE.A4 ,0)          AS "합계 일반"
     , NVL(ASIS.A5 ,0) + NVL(TOBE.A5 ,0)          AS "합계 산재/공상"
     , NVL(ASIS.A6 ,0) + NVL(TOBE.A6 ,0)          AS "합계 교통"
     , NVL(ASIS.A7 ,0) + NVL(TOBE.A7 ,0)          AS "합계 행려"
     , NVL(ASIS.A8 ,0) + NVL(TOBE.A8 ,0)          AS "합계 기타"
     , NVL(ASIS.A9 ,0) + NVL(TOBE.A9 ,0)          AS "신환 보험"
     , NVL(ASIS.A10,0) + NVL(TOBE.A10,0)          AS "신환 차상위"
     , NVL(ASIS.A11,0) + NVL(TOBE.A11,0)          AS "신환 보호"
     , NVL(ASIS.A12,0) + NVL(TOBE.A12,0)          AS "신환 일반"
     , NVL(ASIS.A13,0) + NVL(TOBE.A13,0)          AS "신환 산재/공상"
     , NVL(ASIS.A14,0) + NVL(TOBE.A14,0)          AS "신환 교통"
     , NVL(ASIS.A15,0) + NVL(TOBE.A15,0)          AS "신환 행려"
     , NVL(ASIS.A16,0) + NVL(TOBE.A16,0)          AS "신환 기타"
     , NVL(ASIS.A17,0) + NVL(TOBE.A17,0)          AS "초진 보험"
     , NVL(ASIS.A18,0) + NVL(TOBE.A18,0)          AS "초진 차상위"
     , NVL(ASIS.A19,0) + NVL(TOBE.A19,0)          AS "초진 보호"
     , NVL(ASIS.A20,0) + NVL(TOBE.A20,0)          AS "초진 일반"
     , NVL(ASIS.A21,0) + NVL(TOBE.A21,0)          AS "초진 산재/공상"
     , NVL(ASIS.A22,0) + NVL(TOBE.A22,0)          AS "초진 교통"
     , NVL(ASIS.A23,0) + NVL(TOBE.A23,0)          AS "초진 행려"
     , NVL(ASIS.A24,0) + NVL(TOBE.A24,0)          AS "초진 기타"
     , NVL(ASIS.A25,0) + NVL(TOBE.A25,0)          AS "재진 보험"
     , NVL(ASIS.A26,0) + NVL(TOBE.A26,0)          AS "재진 차상위"
     , NVL(ASIS.A27,0) + NVL(TOBE.A27,0)          AS "재진 보호"
     , NVL(ASIS.A28,0) + NVL(TOBE.A28,0)          AS "재진 일반"
     , NVL(ASIS.A29,0) + NVL(TOBE.A29,0)          AS "재진 산재/공상"
     , NVL(ASIS.A30,0) + NVL(TOBE.A30,0)          AS "재진 교통"
     , NVL(ASIS.A31,0) + NVL(TOBE.A31,0)          AS "재진 행려"
     , NVL(ASIS.A32,0) + NVL(TOBE.A32,0)          AS "재진 기타"

FROM

(
SELECT
       case grouping(AREA_CD) when 0 then AREA_CD
       when 1 then '합계'
       end                                              AREA_NM --"지역별"

     , SUM(A)                                           A1-- "합계 보험"
     , SUM(B)                                           A2-- "합계 차상위"
     , SUM(C)                                           A3-- "합계 보호"
     , SUM(D)                                           A4-- "합계 일반"
     , SUM(E)                                           A5-- "합계 산재/공상"
     , SUM(F)                                           A6-- "합계 교통"
     , SUM(G)                                           A7-- "합계 행려"
     , SUM(H)                                           A8-- "합계 기타"
     , SUM(CASE WHEN MED_TYP = '3' THEN A ELSE 0 END)   A9-- "신환 보험"
     , SUM(CASE WHEN MED_TYP = '3' THEN B ELSE 0 END)   A10-- "신환 차상위"
     , SUM(CASE WHEN MED_TYP = '3' THEN C ELSE 0 END)   A11-- "신환 보호"
     , SUM(CASE WHEN MED_TYP = '3' THEN D ELSE 0 END)   A12-- "신환 일반"
     , SUM(CASE WHEN MED_TYP = '3' THEN E ELSE 0 END)   A13-- "신환 산재/공상"
     , SUM(CASE WHEN MED_TYP = '3' THEN F ELSE 0 END)   A14-- "신환 교통"
     , SUM(CASE WHEN MED_TYP = '3' THEN G ELSE 0 END)   A15-- "신환 행려"
     , SUM(CASE WHEN MED_TYP = '3' THEN H ELSE 0 END)   A16-- "신환 기타"
     , SUM(CASE WHEN MED_TYP = '1' THEN A ELSE 0 END)   A17-- "초진 보험"
     , SUM(CASE WHEN MED_TYP = '1' THEN B ELSE 0 END)   A18-- "초진 차상위"
     , SUM(CASE WHEN MED_TYP = '1' THEN C ELSE 0 END)   A19-- "초진 보호"
     , SUM(CASE WHEN MED_TYP = '1' THEN D ELSE 0 END)   A20-- "초진 일반"
     , SUM(CASE WHEN MED_TYP = '1' THEN E ELSE 0 END)   A21-- "초진 산재/공상"
     , SUM(CASE WHEN MED_TYP = '1' THEN F ELSE 0 END)   A22-- "초진 교통"
     , SUM(CASE WHEN MED_TYP = '1' THEN G ELSE 0 END)   A23-- "초진 행려"
     , SUM(CASE WHEN MED_TYP = '1' THEN H ELSE 0 END)   A24-- "초진 기타"
     , SUM(CASE WHEN MED_TYP = '2' THEN A ELSE 0 END)   A25-- "재진 보험"
     , SUM(CASE WHEN MED_TYP = '2' THEN B ELSE 0 END)   A26-- "재진 차상위"
     , SUM(CASE WHEN MED_TYP = '2' THEN C ELSE 0 END)   A27-- "재진 보호"
     , SUM(CASE WHEN MED_TYP = '2' THEN D ELSE 0 END)   A28-- "재진 일반"
     , SUM(CASE WHEN MED_TYP = '2' THEN E ELSE 0 END)   A29-- "재진 산재/공상"
     , SUM(CASE WHEN MED_TYP = '2' THEN F ELSE 0 END)   A30-- "재진 교통"
     , SUM(CASE WHEN MED_TYP = '2' THEN G ELSE 0 END)   A31-- "재진 행려"
     , SUM(CASE WHEN MED_TYP = '2' THEN H ELSE 0 END)   A32-- "재진 기타"

  FROM (

          SELECT
              AREA_CD           -- AS CSUBCD_NM
            , MED_TYP
--            , CASE WHEN PATTYPE = 'BB'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END A
--            , CASE WHEN PATTYPE IN ('B1','B2','B6') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END B  -- 차상위
--            , CASE WHEN PATTYPE IN ('E1','E2','E6') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END C
--            , CASE WHEN PATTYPE = 'AA'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END D
--            , CASE WHEN PATTYPE IN ('SA','SB','SP') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END E
--            , CASE WHEN PATTYPE = 'TA'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END F
--            , CASE WHEN PATTYPE = 'E8'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END G
--            , CASE WHEN PATTYPE NOT IN ('B1','B2','B6','BB'
--                                       ,'E1','E2','E6','AA'
--                                       ,'SA','SB','SP','TA'
--                                       ,'E8')       THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END H


               , CASE WHEN PME_CLS_CD    = 'BB'
                           AND SUBSTR(PSE_CLS_CD,1,1) NOT IN ('C','E','F')
                           THEN COUNT(DISTINCT PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE 0
                  END A    --보험

               , CASE WHEN PME_CLS_CD    = 'BB' AND SUBSTR(PSE_CLS_CD,1,1) IN ('C','E','F')
                           THEN COUNT(DISTINCT PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE SUM(0)
                  END B    --차상위

               , CASE WHEN PME_CLS_CD    IN ('E1','E2','E6')  AND PSE_CLS_CD NOT IN ('A04','A05')
                           THEN COUNT(DISTINCT  PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE SUM(0)
                   END C    --보호

                , CASE WHEN PME_CLS_CD    = 'AA'
                           THEN COUNT(DISTINCT  PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE SUM(0)
                   END D    --일반

                , CASE WHEN PME_CLS_CD IN ('SA')
                           THEN COUNT(DISTINCT  PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE SUM(0)
                   END E       --산재/공상

                , CASE WHEN PME_CLS_CD    = 'TD'
                           THEN COUNT(DISTINCT  PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE SUM(0)
                   END F    --교통

                , CASE WHEN PME_CLS_CD    = 'E1' AND PSE_CLS_CD IN ('A04','A05')
                           THEN COUNT(DISTINCT PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE SUM(0)
                    END G    --행려

                , CASE WHEN PME_CLS_CD NOT IN ('B1','B2','B6','BB'
                                              ,'E1','E2','E6'
                                              ,'AA'
                                              ,'SA'
                                              ,'TD')
                           THEN COUNT(DISTINCT PT_NO||MED_DEPT_CD||PME_CLS_CD)
                           ELSE SUM(0)
                    END H    --기타
         FROM (



              SELECT
                     A.PT_NO                                                      AS PT_NO
                   , A.MED_DEPT_CD                                                AS MED_DEPT
                   , A.PME_CLS_CD                                                 --AS PATTYPE
                   , A.PSE_CLS_CD
                   , NVL( ( XBIL.FC_GET_DEPT_NM(A.MED_DEPT_CD)) , A.MED_DEPT_CD)  AS DEPT_NM
                   , A.FRVS_RMDE_TP_CD                                            AS MED_TYP
                   , A.MEDR_STF_NO                                                AS WK_NM
                   , CASE WHEN XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO) = '주소미상E' THEN '주소미상'
                          ELSE NVL(XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO),'주소미상')
                      END                                                         AS AREA_CD  -- 지역구분코드
                   , MED_DEPT_CD
                FROM ACPPRODM A  /* 외래예약접수기본 테이블 */

               WHERE 1=1 --A.MED_RSV_DTM
                 AND A.MED_DT > '20240906'
                 AND A.MED_DT BETWEEN  TO_DATE(:IN_FR_DT , 'YYYY-MM-DD')
                                  AND  TO_DATE(:IN_TO_DT , 'YYYY-MM-DD') + .99999
                 AND A.APCN_DTM  IS NULL-- 취소여부
                 AND A.MED_YN    = 'Y'  -- 진료여부
                 AND NVL(SUBSTR(A.OTPT_RSV_TP_CD,1,1),'1')   NOT IN ('8','9','C','X')
                --AND A.OTPT_RSV_TP_CD   NOT IN ('8','9','C','X')
                 --  8 : 2차진료
                 --  9 : 기타(연속오더)
                 --       00  : 무료수진
                 --       000 : NULL (기능검사 등)
                 --  C : 임상접수
                 --  X : 코로나-전화상담처방
--                  OR (    A.OTPT_RSV_TP_CD = '9'
--                      AND A.OTPT_RSV_DTL_TP_CD NOT IN ('00',NULL))
                 AND A.FRVS_RMDE_TP_CD != '4'     -- 초재진구분


                 ) AAA

        GROUP BY
                 AREA_CD
               , MED_TYP
               --, AAA.PATTYPE
               , PME_CLS_CD
               ,PSE_CLS_CD


       )
 GROUP BY rollup(AREA_CD)
 order by AREA_CD

)  TOBE
FULL OUTER JOIN  
(




SELECT DECODE(CSUBCD_NM, NULL, '합계', CSUBCD_NM)         AREA_NM
     , SUM(A)                                           A1-- "합계 보험"
     , SUM(B)                                           A2-- "합계 차상위"
     , SUM(C)                                           A3-- "합계 보호"
     , SUM(D)                                           A4-- "합계 일반"
     , SUM(E)                                           A5-- "합계 산재/공상"
     , SUM(F)                                           A6-- "합계 교통"
     , SUM(G)                                           A7-- "합계 행려"
     , SUM(H)                                           A8-- "합계 기타"
     , SUM(CASE WHEN MED_TYP = '3' THEN A ELSE 0 END)   A9-- "신환 보험"
     , SUM(CASE WHEN MED_TYP = '3' THEN B ELSE 0 END)   A10-- "신환 차상위"
     , SUM(CASE WHEN MED_TYP = '3' THEN C ELSE 0 END)   A11-- "신환 보호"
     , SUM(CASE WHEN MED_TYP = '3' THEN D ELSE 0 END)   A12-- "신환 일반"
     , SUM(CASE WHEN MED_TYP = '3' THEN E ELSE 0 END)   A13-- "신환 산재/공상"
     , SUM(CASE WHEN MED_TYP = '3' THEN F ELSE 0 END)   A14-- "신환 교통"
     , SUM(CASE WHEN MED_TYP = '3' THEN G ELSE 0 END)   A15-- "신환 행려"
     , SUM(CASE WHEN MED_TYP = '3' THEN H ELSE 0 END)   A16-- "신환 기타"
     , SUM(CASE WHEN MED_TYP = '1' THEN A ELSE 0 END)   A17-- "초진 보험"
     , SUM(CASE WHEN MED_TYP = '1' THEN B ELSE 0 END)   A18-- "초진 차상위"
     , SUM(CASE WHEN MED_TYP = '1' THEN C ELSE 0 END)   A19-- "초진 보호"
     , SUM(CASE WHEN MED_TYP = '1' THEN D ELSE 0 END)   A20-- "초진 일반"
     , SUM(CASE WHEN MED_TYP = '1' THEN E ELSE 0 END)   A21-- "초진 산재/공상"
     , SUM(CASE WHEN MED_TYP = '1' THEN F ELSE 0 END)   A22-- "초진 교통"
     , SUM(CASE WHEN MED_TYP = '1' THEN G ELSE 0 END)   A23-- "초진 행려"
     , SUM(CASE WHEN MED_TYP = '1' THEN H ELSE 0 END)   A24-- "초진 기타"
     , SUM(CASE WHEN MED_TYP = '2' THEN A ELSE 0 END)   A25-- "재진 보험"
     , SUM(CASE WHEN MED_TYP = '2' THEN B ELSE 0 END)   A26-- "재진 차상위"
     , SUM(CASE WHEN MED_TYP = '2' THEN C ELSE 0 END)   A27-- "재진 보호"
     , SUM(CASE WHEN MED_TYP = '2' THEN D ELSE 0 END)   A28-- "재진 일반"
     , SUM(CASE WHEN MED_TYP = '2' THEN E ELSE 0 END)   A29-- "재진 산재/공상"
     , SUM(CASE WHEN MED_TYP = '2' THEN F ELSE 0 END)   A30-- "재진 교통"
     , SUM(CASE WHEN MED_TYP = '2' THEN G ELSE 0 END)   A31-- "재진 행려"
     , SUM(CASE WHEN MED_TYP = '2' THEN H ELSE 0 END)   A32-- "재진 기타"
  FROM (
       SELECT
              CSUBCD_NM
            , MED_TYP
            , CASE WHEN PATTYPE = 'BB'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END A
            , CASE WHEN PATTYPE IN ('B1','B2','B6') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END B
            , CASE WHEN PATTYPE IN ('E1','E2','E6') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END C
            , CASE WHEN PATTYPE = 'AA'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END D
            , CASE WHEN PATTYPE IN ('SA','SB','SP') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END E
            , CASE WHEN PATTYPE = 'TA'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END F
            , CASE WHEN PATTYPE = 'E8'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END G
            , CASE WHEN PATTYPE NOT IN ('B1','B2','B6','BB'
                                       ,'E1','E2','E6','AA'
                                       ,'SA','SB','SP','TA'
                                       ,'E8')       THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END H
         FROM (
           --   SELECT DECODE(BB.CSUBCD_NM, NULL, '주소미상', BB.CSUBCD_NM) CSUBCD_NM, PT_NO, MED_DEPT, PATTYPE, MED_TYP
           --     FROM (
                     SELECT
                            A.PT_NO                 PT_NO
                          , A.MED_DEPT              MED_DEPT
                          , A.PATTYPE               PATTYPE
                          , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
--                          , C.AREA_CD
                       --   , nvl(DECODE(B.BUILDING_NO,NULL,NVL(C.AREA_CD, '*'), PKG_BIL_TOEMR_FUNCTION.FT_NEWZIPCDSEL(B.BUILDING_NO,'4')),'*') AREA_CD
                       , CASE WHEN XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO) = '주소미상E' THEN '주소미상'
                          ELSE NVL(XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO),'주소미상')
                      END                                                         AS CSUBCD_NM
                       FROM asis_hbil.APOPRSVT A
                          , asis_hbil.APPATBAT B
                     --     , CCPOSTMT C
--                                      , CCCODEST D
                      WHERE 1=1
                        AND A.MED_DTE  < '20240907'
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
--                 and a.medrcp_yn = case when to_char(MED_DTE,'YYYYMMDD') >= '20120101' then 'Y' else medrcp_yn end
                    --------------------------------------------------------------------------
                    -- 2011.12.26 이상우 : 2012.01.01 부터 경영통계 환자수 기준 변경으로 수정 medrcp_yn = 'Y' 조건 추가
                    -- 2012.03.28 이상우 : 인공투석실 환자수 카운트시 진찰료 수납이 'Y'가 아닌대상을 환자수로 넣기 위해 2012.04.01 부터 조건 변경
                    --------------------------------------------------------------------------
	                    and a.medrcp_yn = case when to_char(MED_DTE,'YYYYMMDD') < '20120101' then a.medrcp_yn
	                                           when to_char(MED_DTE,'YYYYMMDD') >= '20120101' and to_char(MED_DTE,'YYYYMMDD') < '20120401' then 'Y'
	                                           when to_char(MED_DTE,'YYYYMMDD') >= '20120401' and substr(a.meddr_id,1,3) != 'IMN' then 'Y'
	                                           else a.medrcp_yn
	                                       end
                    --------------------------------------------------------------------------
                        AND B.PT_NO = A.PT_NO
                    --    AND C.ZIP_NO(+)  = B.ZIP_NO
                    --    AND C.ZIP_SEQ(+) = B.ZIP_SEQ
                    -- ) AA
            --       , asis_hbil.CCCODEST BB
             --  WHERE BB.CCD_TYP(+) = '260'
            --     AND BB.C_CD(+) = AA.AREA_CD
              UNION ALL
           --   SELECT DECODE(BB.CSUBCD_NM, NULL, '주소미상', BB.CSUBCD_NM) CSUBCD_NM, PT_NO, MED_DEPT, PATTYPE, MED_TYP
          --      FROM (
                     SELECT
                            A.PT_NO
                          , A.MED_DEPT
                          , A.PATTYPE
                          , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
                             , CASE WHEN XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO) = '주소미상E' THEN '주소미상'
                          ELSE NVL(XBIL.FC_ACP_GET_POST_AREA_NM('POST',A.PT_NO),'주소미상')
                      END                                                         AS CSUBCD_NM
--                          , C.AREA_CD
                       --   , nvl(DECODE(B.BUILDING_NO,NULL,NVL(C.AREA_CD, '*'), PKG_BIL_TOEMR_FUNCTION.FT_NEWZIPCDSEL(B.BUILDING_NO,'4')),'*') AREA_CD
                       FROM asis_hbil.APEMGRCT A
                          , asis_hbil.APPATBAT B
                       --   , asis_hbil.CCPOSTMT C
--                                      , CCCODEST D

                      WHERE 1=1
                        AND A.ARV_DTM  < '20240907'
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
                        --AND C.ZIP_NO(+)  = B.ZIP_NO
                        --AND C.ZIP_SEQ(+) = B.ZIP_SEQ
                   --   ) AA
                  -- , asis_hbil.CCCODEST BB
               --WHERE BB.CCD_TYP(+) = '260'
               --  AND BB.C_CD(+) = AA.AREA_CD
              ) A
        GROUP BY CSUBCD_NM, MED_TYP, PATTYPE
       )
 GROUP BY ROLLUP(CSUBCD_NM)

 ) ASIS


ON ASIS.AREA_NM = TOBE.AREA_NM
 ORDER BY CASE WHEN NVL(ASIS.AREA_NM , TOBE.AREA_NM ) = '합계'
                    THEN 1
                    ELSE 0
           END
