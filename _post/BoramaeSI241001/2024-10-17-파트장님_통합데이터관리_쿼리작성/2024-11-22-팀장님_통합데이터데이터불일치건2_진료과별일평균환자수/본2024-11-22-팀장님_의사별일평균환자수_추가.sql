
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
*/

-- 의사별 실 외래환자수



SELECT
       case grouping(WK_NM) when 0 then XBIL.FT_STF_INF(WK_NM, 'STF_NM')
       when 1 then '합계'
       end                                              "의사별"

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
              WK_NM
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
              SELECT
                     A.PT_NO
                   , A.MED_DEPT_CD                                                AS MED_DEPT
                   , A.PME_CLS_CD                                                 AS PATTYPE
                   , NVL( ( XBIL.FC_GET_DEPT_NM(A.MED_DEPT_CD)) , A.MED_DEPT_CD)  AS DEPT_NM
                   , A.FRVS_RMDE_TP_CD                                            AS MED_TYP
                   , A.MEDR_STF_NO                                                AS WK_NM
                FROM ACPPRODM A  /* 외래예약접수기본 테이블 */
               WHERE --A.MED_RSV_DTM   \
                     A.MED_DT BETWEEN  TO_DATE(:IN_FR_DT , 'YYYYMMDD')
                                  AND  TO_DATE(:IN_TO_DT , 'YYYYMMDD') + .99999
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
--                 AND A.FRVS_RMDE_TP_CD != '4'
                 ) A
        GROUP BY WK_NM, MED_TYP, PATTYPE
       )
 GROUP BY rollup(WK_NM)
 order by WK_NM