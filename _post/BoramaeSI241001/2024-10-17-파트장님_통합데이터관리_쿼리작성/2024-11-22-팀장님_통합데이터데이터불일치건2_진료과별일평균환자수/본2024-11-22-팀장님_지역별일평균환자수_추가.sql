
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

-- 지역별 실 외래환자수


    exec :IN_FR_DT := '20240801';
    exec :IN_TO_DT := '20240831';

SELECT
       case grouping(CSUBCD_NM) when 0 then CSUBCD_NM
       when 1 then '합계'
       end                                              "지역별"

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
              AAA.AREA_CD            AS CSUBCD_NM
            , AAA.MED_TYP
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
                 AA.PT_NO                               AS PT_NO
                ,AA.MED_DEPT                            AS MED_DEPT
                ,AA.PATTYPE                             AS PATTYPE
                ,AA.DEPT_NM                             AS DEPT_NM
                ,AA.MED_TYP                             AS MED_TYP
                ,AA.WK_NM                               AS WK_NM

, NVL((SELECT
       CASE SUBSTR(BSC_ADDR,0,3) WHEN '경기도' THEN '경기'
                                 WHEN '강원도' THEN '강원'
                                 WHEN '신림동' THEN '서울신림동'
                                 ELSE CASE SUBSTR(BSC_ADDR,0,4) WHEN '경상북도' THEN '경북'
                                                                WHEN '경상남도' THEN '경남'
                                                                WHEN '전라북도' THEN '전북'
                                                                WHEN '전라남도' THEN '전남'
                                                                WHEN '충청북도' THEN '충북'
                                                                WHEN '충청남도' THEN '충남'
                                                                ELSE CASE SUBSTR(BSC_ADDR,0,5) WHEN '인천광역시' THEN '인천시'
                                                                                               WHEN '대구광역시' THEN '대구시'
                                                                                               WHEN '대전광역시' THEN '대전시'
                                                                                               WHEN '광주광역시' THEN '광주시'
                                                                                               WHEN '울산광역시' THEN '울산시'
                                                                                               WHEN '부산광역시' THEN '부산시'
                                                                                               WHEN '서울특별시' THEN CASE SUBSTR( SUBSTR(BSC_ADDR,0,INSTR(BSC_ADDR, '구')) ,7 )
                                                                                                                                                                                WHEN '강남구'  THEN '서울강남구'
                                                                                                                                                                                WHEN '강서구'  THEN '서울강서구'
                                                                                                                                                                                WHEN '서초구'  THEN '서울서초구'
                                                                                                                                                                                WHEN '양천구'  THEN '서울양천구'
                                                                                                                                                                                --WHEN '구로구'  THEN '서울구로구'
                                                                                                                                                                                WHEN '영등포구' THEN '서울영등포구'
                                                                                                                                                                                WHEN '금천구'  THEN '서울금천구'
                                                                                                                                                                                WHEN '동작구'  THEN '서울동작구'
                                                                                                                                                                                WHEN '관악구'  THEN '서울관악구'
                                                                                                                                                                                WHEN '송파구'  THEN '서울송파구'
                                                                                                                                                                                WHEN '강동구'  THEN '서울강동구'
                                                                                                                                                                                WHEN '은평구'  THEN '서울은평구'
                                                                                                                                                                                WHEN '서대문구' THEN '서울서대문구'
                                                                                                                                                                                WHEN '마포구'  THEN '서울마포구'
                                                                                                                                                                                WHEN '종로구'  THEN '서울종로구'
                                                                                                                                                                                WHEN '중구'   THEN '서울중구'
                                                                                                                                                                                WHEN '용산구'  THEN '서울용산구'
                                                                                                                                                                                WHEN '성북구'  THEN '서울성북구'
                                                                                                                                                                                WHEN '강북구'  THEN '서울강북구'
                                                                                                                                                                                WHEN '도봉구'  THEN '서울도봉구'
                                                                                                                                                                                WHEN '노원구'  THEN '서울노원구'
                                                                                                                                                                                WHEN '중랑구'  THEN '서울중랑구'
                                                                                                                                                                                WHEN '동대문구' THEN '서울동대문구'
                                                                                                                                                                                WHEN '성동구'  THEN '서울성동구'
                                                                                                                                                                                WHEN '광진구'  THEN '서울광진구'
                                                                                                                                                                                ELSE CASE WHEN SUBSTR(BSC_ADDR,0,INSTR(BSC_ADDR, '구')+2) = '서울특별시 구로구' THEN '서울구로구'
                                                                                                                                                                                          ELSE '주소미상'||REPLACE(REPLACE( REPLACE( REPLACE(REPLACE(BSC_ADDR,' ',''),CHR(9),''),CHR(13),''),CHR(10),'' ),'-()','')
                                                                                                                                                                                      END
                                                                                                                   END

                                                                                               ELSE CASE SUBSTR(BSC_ADDR,0,7) WHEN '제주특별자치도' THEN '제주'
                                                                                                                              WHEN '강원특별자치도' THEN '강원'
                                                                                                                              WHEN '세종특별자치시' THEN '세종시'
                                                                                                                              WHEN '전북특별자치도' THEN '전북'
                                                                                                                              ELSE CASE SUBSTR(BSC_ADDR,0,2) WHEN '경기' THEN '경기'
                                                                                                                                                             WHEN '강원' THEN '강원'
                                                                                                                                                             WHEN '제주' THEN '제주'
                                                                                                                                                             WHEN '광주' THEN '광주시'
                                                                                                                                                             WHEN '대전' THEN '대전시'
                                                                                                                                                             WHEN '울산' THEN '울산시'
                                                                                                                                                             WHEN '부산' THEN '부산시'
                                                                                                                                                             WHEN '인천' THEN '인천시'
                                                                                                                                                             WHEN '대구' THEN '대구시'
                                                                                                                                                             WHEN '경북' THEN '경북'
                                                                                                                                                             WHEN '경남' THEN '경남'
                                                                                                                                                             WHEN '전북' THEN '전북'
                                                                                                                                                             WHEN '전남' THEN '전남'
                                                                                                                                                             WHEN '충북' THEN '충북'
                                                                                                                                                             WHEN '충남' THEN '충남'
                                                                                                                                                             WHEN '서울' THEN CASE WHEN SUBSTR(BSC_ADDR,0,INSTR(BSC_ADDR, '구')+2) = '서울 구로구' THEN '서울구로구'
                                                                                                                                                                                 ELSE '서울' || SUBSTR(BSC_ADDR,4, INSTR(BSC_ADDR, '구')-3)
                                                                                                                                                                             END


                                                                                                                                                             ELSE '주소미상'||REPLACE(REPLACE( REPLACE( REPLACE(REPLACE(BSC_ADDR,' ',''),CHR(9),''),CHR(13),''),CHR(10),'' ),'-()','')
                                                                                                                                    END
                                                                                               END
                                                                END
                                      END
END
FROM PCTPCPTD B
WHERE AA.PT_NO = B.PT_NO
  AND BSC_ADDR IS NOT NULL
  AND ROWNUM =1
) , '주소미상')                                                                    AS AREA_CD  -- 지역구분코드
            FROM (
              SELECT
                     A.PT_NO                                                      AS PT_NO
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
                 AND A.FRVS_RMDE_TP_CD != '4'     -- 초재진구분



                 ) AA
--                 ,CCCCCPOD C
--                 ,CCCCCP2D C

              WHERE 1=1

                 ) AAA
--                ,CCCCCSTE D
--            WHERE(   D.COMN_GRP_CD(+) = 'ASIS260'
--                  OR D.COMN_GRP_CD(+) = '260')
--              AND D.COMN_CD(+) = AAA.AREA_CD

        GROUP BY
                 AAA.AREA_CD
               , AAA.MED_TYP
               , AAA.PATTYPE
       )
 GROUP BY rollup(CSUBCD_NM)
 order by CSUBCD_NM



;
SELECT
CASE SUBSTR(BSC_ADDR,0,3) WHEN '경기도'  THEN '경기'
                                 WHEN '강원도'  THEN '강원'
                                 ELSE CASE SUBSTR(BSC_ADDR,0,4) WHEN '경상북도' THEN '경북'
                                                                WHEN '경상남도' THEN '경남'
                                                                WHEN '전라북도' THEN '전북'
                                                                WHEN '전라남도' THEN '전남'
                                                                WHEN '충청북도' THEN '충북'
                                                                WHEN '충청남도' THEN '충남'
                                                                ELSE CASE SUBSTR(BSC_ADDR,0,5) WHEN '인천광역시' THEN '인천시'
                                                                                               WHEN '대구광역시' THEN '대구시'
                                                                                               WHEN '대전광역시' THEN '대전시'
                                                                                               WHEN '광주광역시' THEN '광주시'
                                                                                               WHEN '울산광역시' THEN '울산시'
                                                                                               WHEN '부산광역시' THEN '부산시'
                                                                                               WHEN '서울특별시' THEN CASE SUBSTR( SUBSTR(BSC_ADDR,0,INSTR(BSC_ADDR, '구')) ,7 ) WHEN '강남구'  THEN '서울강남구'
                                                                                                                                                                                WHEN '강서구'  THEN '서울강서구'
                                                                                                                                                                                WHEN '서초구'  THEN '서울서초구'
                                                                                                                                                                                WHEN '양천구'  THEN '서울양천구'
                                                                                                                                                                                WHEN '구로구'  THEN '서울구로구'
                                                                                                                                                                                WHEN '영등포구'THEN '서울영등포구'
                                                                                                                                                                                WHEN '금천구'  THEN '서울금천구'
                                                                                                                                                                                WHEN '동작구'  THEN '서울동작구'
                                                                                                                                                                                WHEN '관악구'  THEN '서울관악구'
                                                                                                                                                                                WHEN '송파구'  THEN '서울송파구'
                                                                                                                                                                                WHEN '강동구'  THEN '서울강동구'
                                                                                                                                                                                WHEN '은평구'  THEN '서울은평구'
                                                                                                                                                                                WHEN '서대문구'THEN '서울서대문구'
                                                                                                                                                                                WHEN '마포구'  THEN '서울마포구'
                                                                                                                                                                                WHEN '종로구'  THEN '서울종로구'
                                                                                                                                                                                WHEN '중구'    THEN '서울중구'
                                                                                                                                                                                WHEN '용산구'  THEN '서울용산구'
                                                                                                                                                                                WHEN '성북구'  THEN '서울성북구'
                                                                                                                                                                                WHEN '강북구'  THEN '서울강북구'
                                                                                                                                                                                WHEN '도봉구'  THEN '서울도봉구'
                                                                                                                                                                                WHEN '노원구'  THEN '서울노원구'
                                                                                                                                                                                WHEN '중량구'  THEN '서울중량구'
                                                                                                                                                                                WHEN '동대문구'THEN '서울동대문구'
                                                                                                                                                                                WHEN '성동구'  THEN '서울성동구'
                                                                                                                                                                                WHEN '광진구'  THEN '서울광진구'
                                                                                                                                                                                ELSE '주소미상, '||BSC_ADDR
                                                                                                                      END

                                                                                               ELSE CASE SUBSTR(BSC_ADDR,0,7) WHEN '제주특별자치도' THEN '제주'
                                                                                                                              ELSE '주소미상, '||BSC_ADDR
                                                                                               END
                                                                END
                                      END
END AS ADDRESS
       --, A.*
FROM PCTPCPTD A
WHERE 1=1
--  AND A.post_no = '08781'
  AND BSC_ADDR LIKE '%서울%'  ;
-- 서울특별시
-- 부산광역시
