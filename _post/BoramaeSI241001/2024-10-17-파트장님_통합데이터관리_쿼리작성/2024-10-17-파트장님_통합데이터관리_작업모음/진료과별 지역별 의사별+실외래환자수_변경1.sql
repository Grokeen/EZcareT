--외래예약접수, CCDEPART
EXEC :IN_FR_DT := '20240801';
EXEC :IN_TO_DT := '20240831';









SELECT DEPT_NM                                          "부서명"

     , SUM(A)                                           "합계 보험"
     , SUM(B)                                           "합계 차상위"
     , SUM(C)                                           "합계 보호"
     , SUM(D)                                           "합계 일반"
     , SUM(E)                                           "합계 산재/공상"
     , SUM(F)                                           "합계 교통"
     , SUM(G)                                           "합계 행려"
     , SUM(H)                                           "합계 기타"
     ,'  ###   '                                        "  ###   "
     , SUM(CASE WHEN MED_TYP = '3' THEN A ELSE 0 END)   "신환 보험"
     , SUM(CASE WHEN MED_TYP = '3' THEN B ELSE 0 END)   "신환 차상위"
     , SUM(CASE WHEN MED_TYP = '3' THEN C ELSE 0 END)   "신환 보호"
     , SUM(CASE WHEN MED_TYP = '3' THEN D ELSE 0 END)   "신환 일반"
     , SUM(CASE WHEN MED_TYP = '3' THEN E ELSE 0 END)   "신환 산재/공상"
     , SUM(CASE WHEN MED_TYP = '3' THEN F ELSE 0 END)   "신환 교통"
     , SUM(CASE WHEN MED_TYP = '3' THEN G ELSE 0 END)   "신환 행려"
     , SUM(CASE WHEN MED_TYP = '3' THEN H ELSE 0 END)   "신환 기타"
     ,'   ###   '                                       "   ###   "
     , SUM(CASE WHEN MED_TYP = '1' THEN A ELSE 0 END)   "초진 보험"
     , SUM(CASE WHEN MED_TYP = '1' THEN B ELSE 0 END)   "초진 차상위"
     , SUM(CASE WHEN MED_TYP = '1' THEN C ELSE 0 END)   "초진 보호"
     , SUM(CASE WHEN MED_TYP = '1' THEN D ELSE 0 END)   "초진 일반"
     , SUM(CASE WHEN MED_TYP = '1' THEN E ELSE 0 END)   "초진 산재/공상"
     , SUM(CASE WHEN MED_TYP = '1' THEN F ELSE 0 END)   "초진 교통"
     , SUM(CASE WHEN MED_TYP = '1' THEN G ELSE 0 END)   "초진 행려"
     , SUM(CASE WHEN MED_TYP = '1' THEN H ELSE 0 END)   "초진 기타"
     ,'   ###  '                                        "   ###  "
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
                   , A.MED_DEPT_CD     AS    MED_DEPT
                   , A.PME_CLS_CD      AS    PATTYPE
                   , NVL( ( XBIL.FC_GET_DEPT_NM(A.MED_DEPT_CD)) , A.MED_DEPT_CD)  AS DEPT_NM
                   , A.FRVS_RMDE_TP_CD    AS MED_TYP
                FROM ACPPRODM A
               WHERE A.MED_RSV_DTM   BETWEEN  TO_DATE(:IN_FR_DT , 'YYYYMMDD')
                                         AND  TO_DATE(:IN_TO_DT ,'YYYYMMDD') + .99999
                 AND A.APCN_DTM  IS NULL
                 AND A.MED_YN    = 'Y'
                 AND NVL(SUBSTR(A.OTPT_RSV_TP_CD,1,1),'1')   NOT IN ('8','9','C','X')
                 AND A.FRVS_RMDE_TP_CD != '4'



                 ) A
        GROUP BY DEPT_NM, MED_TYP, PATTYPE



       )
 GROUP BY DEPT_NM
