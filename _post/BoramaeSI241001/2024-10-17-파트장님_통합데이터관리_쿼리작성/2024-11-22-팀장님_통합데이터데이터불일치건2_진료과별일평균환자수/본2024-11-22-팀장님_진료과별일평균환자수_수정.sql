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

-- 진료과별




SELECT
       CASE WHEN NVL(ASIS.DEPT_NM , TOBE.DEPT_NM ) = '합계' THEN '합계'
            ELSE NVL( ( XBIL.FC_GET_DEPT_NM(NVL(ASIS.DEPT_NM , TOBE.DEPT_NM ))) , NVL(ASIS.DEPT_NM , TOBE.DEPT_NM ))
        END                                       AS "진료과별"
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
       case grouping(DEPT_NM) when 0 then DEPT_NM
       when 1 then '합계'
       end                                              DEPT_NM

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
              DEPT_NM
            , MED_TYP
--            , CASE WHEN PATTYPE = 'BB'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END A
--            , CASE WHEN PATTYPE IN ('B1','B2','B6') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END B
--            , CASE WHEN PATTYPE IN ('E1','E2','E6') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END C
--            , CASE WHEN PATTYPE = 'AA'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END D
--            , CASE WHEN PATTYPE IN ('SA','SB','SP') THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END E
--            , CASE WHEN PATTYPE = 'TA'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END F
--            , CASE WHEN PATTYPE = 'E8'              THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END G
--            , CASE WHEN PATTYPE NOT IN ('B1','B2','B6','BB'
--                                       ,'E1','E2','E6','AA'
--                                       ,'SA','SB','SP','TA'
--                                       ,'E8')       THEN COUNT(DISTINCT PT_NO||MED_DEPT||PATTYPE) ELSE 0 END H



               , SUM(CASE WHEN PME_CLS_CD    = 'BB'
                           AND SUBSTR(PSE_CLS_CD,1,1) NOT IN ('C','E','F')
                           THEN 1
                           ELSE 0
                  END) A    --보험

               , SUM(CASE WHEN PME_CLS_CD    = 'BB' AND SUBSTR(PSE_CLS_CD,1,1) IN ('C','E','F')
                           THEN 1
                           ELSE 0
                  END) B    --차상위

               , SUM(CASE WHEN PME_CLS_CD    IN ('E1','E2','E6')  AND PSE_CLS_CD NOT IN ('A04','A05')
                           THEN 1
                           ELSE 0
                   END) C    --보호

                , SUM(CASE WHEN PME_CLS_CD    = 'AA'
                           THEN 1
                           ELSE 0
                   END) D    --일반

                , SUM(CASE WHEN PME_CLS_CD IN ('SA')
                           THEN 1
                           ELSE 0
                   END) E       --산재/공상

                , SUM(CASE WHEN PME_CLS_CD    = 'TD'
                           THEN 1
                           ELSE 0
                   END) F    --교통

                , SUM(CASE WHEN PME_CLS_CD    = 'E1' AND PSE_CLS_CD IN ('A04','A05')
                           THEN 1
                           ELSE 0
                    END) G    --행려

                , SUM(CASE WHEN PME_CLS_CD NOT IN ('B1','B2','B6','BB'
                                              ,'E1','E2','E6'
                                              ,'AA'
                                              ,'SA'
                                              ,'TD')
                           THEN 1
                           ELSE 0
                    END) H    --기타

         FROM (


              SELECT
                     A.PT_NO
                   , A.MED_DEPT_CD                                                AS    MED_DEPT
                   , A.PME_CLS_CD                                               --  AS    PATTYPE
                       , A.MED_DEPT_CD
                       , A.PSE_CLS_CD


                   , NVL( ( XBIL.FC_GET_DEPT_NM(A.MED_DEPT_CD)) , A.MED_DEPT_CD)  AS DEPT_NM
                   , A.FRVS_RMDE_TP_CD                                            AS MED_TYP
                FROM ACPPRODM A     /* 외래예약접수기본 테이블 */
               WHERE 1=1--A.MED_RSV_DTM   \
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
--                 AND A.FRVS_RMDE_TP_CD != '4'

                 ) A
        GROUP BY DEPT_NM
               , MED_TYP
               --, PATTYPE
       )
 GROUP BY rollup(DEPT_NM)
 order by DEPT_NM

) TOBE
FULL OUTER JOIN

(
SELECT DECODE(DEPT_NM, NULL, '합계', DEPT_NM)          DEPT_NM
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
              DEPT_NM
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
              SELECT A.PT_NO
                   , A.MED_DEPT
                   , A.PATTYPE
                   ,A.MED_DEPT AS DEPT_NM -- B.DEPT_NM
                   , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
                FROM ASIS_HBIL.APOPRSVT A
                --   , CCDEPART B
               WHERE A.MED_DTE < '20240907'
                 AND A.MED_DTE   BETWEEN  TO_DATE(:in_fr_dt,'yyyy-mm-dd')
                                     AND  TO_DATE(:in_to_dt,'yyyy-mm-dd') + .99999
                 AND A.CNCL_DTE  IS NULL
--                 AND A.MEDRCP_YN    IN ('Y','1')
--                 AND CASE WHEN
--                            ( ( SUBSTR(A.MED_DEPT,1,3) NOT IN ('HPC') AND NVL(SUBSTR(A.RSV_TYP,1,1),'1') NOT IN ('8','9','X') )
--                            OR ( SUBSTR(A.MED_DEPT,1,3) IN ('HPC') AND A.RSV_TYP IN ('0') ) ) THEN 'Y'
--                      END = 'Y'
	                --------------------------------------------------------------------------
	                -- 2010.10.01 이강준 2010년10월1일부터는 'C'(주로 임상임) 포함한다.
	                --------------------------------------------------------------------------
	                --기존 logic
	                --and nvl(substr(c.rsv_typ,1,1),'1') not in ('8','9','C')
	                -- 2011-01-25 권욱주 : rsv_typ = 9 는 내시경 처방 전까지는 임시 예약 이후 -> 9로  update 됨
	                --------------------------------------------------------------------------
	                and case when to_char(MED_DTE,'yyyymmdd') >= '20101001' and to_char(MED_DTE,'yyyymmdd') < '20110301'
	                													and nvl(substr(a.rsv_typ,1,1),'1')  not in ('8','9','X')	  then 'Y'
	                         when to_char(MED_DTE,'yyyymmdd')  < '20101001'
	                         										and nvl(substr(a.rsv_typ,1,1),'1')  not in ('8','9','C','X')  then 'Y'
	                  --------------------------------------------------------------------------
	                  -- 2011.02.25 최선만 2011년 3월 1일부터는 HPC(종검)일경우 예약구분이 0 인것만을 인원수에 포함한다.
	                  --------------------------------------------------------------------------
	                         when to_char(MED_DTE,'yyyymmdd') >= '20110301' and to_char(MED_DTE,'yyyymmdd') < '20110701'
	                         	 and ( ( substr(a.med_dept,1,3) not in ('HPC') and nvl(substr(a.rsv_typ,1,1),'1') not in ('8','9','X') )
	                         	      or ( substr(a.med_dept,1,3) in ('HPC') and a.rsv_typ in ('0') ) )  						  then 'Y'
	                  --------------------------------------------------------------------------
	                  -- 2011.06.15 최선만 인공신장실의 경우 무료예약접수분도 인원수에 포함한다.
	                  --------------------------------------------------------------------------
	                         when to_char(MED_DTE,'yyyymmdd') >= '20110701'
	                         	 and ( ( substr(a.med_dept,1,3) not in ('HPC') and nvl(substr(a.rsv_typ,1,1),'1') not in ('8','9','X') )
	                         	      or ( substr(a.med_dept,1,3) in ('HPC') and a.rsv_typ in ('0') )
	                         	      or (substr(a.meddr_id,1,3) in ('IMN') and a.rsv_typ in ('9') ) )		  then 'Y'
	                         else 'N'
	                    end  = 'Y'
--                       --------------------------------------------------------------------------
--                       -- 2011.12.26 이상우 : 2012.01.01 부터 경영통계 환자수 기준 변경으로 수정 medrcp_yn = 'Y' 조건 추가
--                       --------------------------------------------------------------------------
--                    and a.medrcp_yn = case when to_char(MED_DTE,'YYYYMMDD') >= '20120101' then 'Y' else medrcp_yn end
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
                 --   AND B.DEPT_CD = A.MED_DEPT
              UNION ALL
              SELECT A.PT_NO
                   , A.MED_DEPT
                   , A.PATTYPE
                   ,A.MED_DEPT AS DEPT_NM -- B.DEPT_NM
                   , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
                FROM ASIS_HBIL.APEMGRCT A
             --      , CCDEPART B
               WHERE  A.ARV_DTM < '20240907'
                 AND A.ARV_DTM   BETWEEN  TO_DATE(:in_fr_dt,'yyyy-mm-dd')
                                     AND  TO_DATE(:in_to_dt,'yyyy-mm-dd') + .99999
                 AND A.CNCL_DTE  IS NULL
                 AND A.ADM_DTE IS NULL
                 --------------------------------------------------------------------------
                 -- 2010.10.01 이강준 2010년10월1일부터는 'C'(주로 임상임) 포함한다.
                 --------------------------------------------------------------------------
                 --기존 logic
                 --and nvl(substr(c.rsv_typ,1,1),'1')   not in ('8','9','C')
                 -- 2011-01-25 권욱주 : rsv_typ = 9 는 내시경 처방 전까지는 임시 예약 이후 -> 9로  update 됨
                 --------------------------------------------------------------------------
                 and case when to_char(ARV_DTM,'yyyymmdd') >= '20101001' and nvl(substr(a.rsv_typ,1,1),'1')  not in ('8','9','X')      then 'Y'
                          when to_char(ARV_DTM,'yyyymmdd')  < '20101001' and nvl(substr(a.rsv_typ,1,1),'1')  not in ('8','9','C','X')  then 'Y'
                          else 'N'
                      end  = 'Y'
                 --------------------------------------------------------------------------
             --    AND B.DEPT_CD = A.MED_DEPT
              ) A
        GROUP BY DEPT_NM, MED_TYP, PATTYPE
       )
 GROUP BY ROLLUP(DEPT_NM)

 ) ASIS

ON ASIS.DEPT_NM = TOBE.DEPT_NM
 ORDER BY CASE WHEN NVL(ASIS.DEPT_NM , TOBE.DEPT_NM ) = '합계'
                    THEN 1
                    ELSE 0
           END
