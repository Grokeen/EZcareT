CREATE OR REPLACE

/***********************************************************************************
 *    서비스이름  : FT_ACP_AMPM_TYPE
 *    최초 작성일 : 2024-05-21
 *    최초 작성자 : 김재강
 *    DESCRIPTION : 오전오후 구분 
 *                  오전 : 0830 ~ 1200  => 'AM'
 *                  오후 : 1300 ~ 1700  => 'PM'
 ***********************************************************************************/ 
FUNCTION FT_RSV_DTE_INFO ( IN_PT_NO       IN VARCHAR2
                         , IN_REQ_DTE     DATE
                         , IN_MED_DEPT    IN VARCHAR2
                         , IN_GBN         IN VARCHAR2 --EQ:동일진료과, EX:타과
                         )
RETURN VARCHAR2 IS
    V_RSV_DTE  DATE;
    V_RTN_VAL  VARCHAR2(50);
    
BEGIN
    IF  IN_GBN = 'EX' THEN
        SELECT MIN(X.MED_DT)
          INTO V_RSV_DTE

          FROM ACPPRODM X                                                           -- APOPRSVT -> ACPPRODM

         WHERE X.PT_NO      = IN_PT_NO
           AND X.MED_DT    = V_RSV_DTE
           AND REGEXP_REPLACE(X.MED_DEPT_CD , '^(PC)|^(BC)|^(RC)', '')                   -- MED_DEPT(진료과) -> MED_DEPT_CD(진료부서코드) 
            != REGEXP_REPLACE(IN_MED_DEPT, '^(PC)|^(BC)|^(RC)', '')
           AND X.APCN_DTM   IS NULL                                                      -- CNCL_DTE(취소일자) -> APCN_DTM(접수취소일시)
           AND NVL(X.MEF_RPY_CLS_CD,'N') != '1'                                          -- MEDRCP_YN(진찰료수납여부) -> MEF_RPY_CLS_CD(진찰료수납유형코드)
           AND NVL(X.OTPT_RSV_TP_CD, '1') IN ( 
                                         '0'       -- 건증
                                       , '1'       -- 창구
                                       , '2'       -- 진료과
                                       , '3'       -- 진료협력센터
                                       , '4'       -- 전화재진                                                        
                                       , '5'       -- 전화신환
                                       , '6'       -- 전화초진
                                       , '7'       -- 인터넷
                                       , 'C'       -- 의학연구
                                       , 'E'       -- 가정간호
                                       , 'G'       -- 휴일,일과후(진찰료50%)
                                       , 'H'       -- 보호자내원
                                       , 'J'       -- FAX예약
                                       )
           AND X.MED_DEPT_CD        IN ( 'TS'      -- 흉부외과                            -- MED_DEPT(진료과) -> MED_DEPT_CD(진료부서코드)
                                       , 'RCTS'    -- 흉부외과(폐센터)
                                       , 'PCTS'    -- 흉부외과(암센터)
                                       , 'GS'      -- 외과
                                       , 'PCGS'    -- 외과(암센터)
                                       , 'BCGS'    -- 외과(유방전문센터)
                                       , 'PCIMH'   -- 혈액종양내과(암센터)
                                       , 'PCCO'    -- 암센터외래
                                       , 'RC'      -- 폐센터
                                       , 'TR'      -- 방사선종양학과
                                       , 'IMG'     -- 소화기내과
                                       , 'IMH'     -- 혈액종양내과
                                       )

        ;

        SELECT RSV_INFO
          INTO V_RTN_VAL
          
          FROM (
                SELECT '(' || X.MED_DEPT_CD || ') ' || TO_CHAR(X.MED_RSV_DTM, 'YYYY-MM-DD HH24:MI')   RSV_INFO
                  FROM ACPPRODM X                                                           -- APOPRSVT -> ACPPRODM
                 WHERE X.PT_NO      = IN_PT_NO
                   AND X.MED_DT    = V_RSV_DTE
                   AND REGEXP_REPLACE(X.MED_DEPT_CD , '^(PC)|^(BC)|^(RC)', '')                   -- MED_DEPT(진료과) -> MED_DEPT_CD(진료부서코드) 
                    != REGEXP_REPLACE(IN_MED_DEPT, '^(PC)|^(BC)|^(RC)', '')
                   AND X.APCN_DTM   IS NULL                                                      -- CNCL_DTE(취소일자) -> APCN_DTM(접수취소일시)
                   AND NVL(X.MEF_RPY_CLS_CD,'N') != '1'                                          -- MEDRCP_YN(진찰료수납여부) -> MEF_RPY_CLS_CD(진찰료수납유형코드)
                   AND NVL(X.OTPT_RSV_TP_CD, '1') IN ( 
                                                 '0'       -- 건증
                                               , '1'       -- 창구
                                               , '2'       -- 진료과
                                               , '3'       -- 진료협력센터
                                               , '4'       -- 전화재진
                                               , '5'       -- 전화신환
                                               , '6'       -- 전화초진
                                               , '7'       -- 인터넷
                                               , 'C'       -- 의학연구
                                               , 'E'       -- 가정간호
                                               , 'G'       -- 휴일,일과후(진찰료50%)
                                               , 'H'       -- 보호자내원
                                               , 'J'       -- FAX예약
                                               )
                   AND X.MED_DEPT_CD        IN ( 'TS'      -- 흉부외과                            -- MED_DEPT(진료과) -> MED_DEPT_CD(진료부서코드)
                                               , 'RCTS'    -- 흉부외과(폐센터)
                                               , 'PCTS'    -- 흉부외과(암센터)
                                               , 'GS'      -- 외과
                                               , 'PCGS'    -- 외과(암센터)
                                               , 'BCGS'    -- 외과(유방전문센터)
                                               , 'PCIMH'   -- 혈액종양내과(암센터)
                                               , 'PCCO'    -- 암센터외래
                                               , 'RC'      -- 폐센터
                                               , 'TR'      -- 방사선종양학과
                                               , 'IMG'     -- 소화기내과
                                               , 'IMH'     -- 혈액종양내과
                                               )
                 ORDER BY
                       CASE WHEN REGEXP_REPLACE(X.MED_DEPT_CD , '^(PC)|^(BC)|^(RC)', '') = 'GS' THEN 1
                            WHEN REGEXP_REPLACE(X.MED_DEPT_CD , '^(PC)|^(BC)|^(RC)', '') = 'TS' THEN 2
                                                                                             ELSE 3
                       END
                     , X.MED_RSV_DTM                                                           -- MED_DTM(진료일시) -> MED_RSV_DTM(진료예약일시)
               )
         WHERE ROWNUM = 1      
        ;


    ELSE
         SELECT TO_CHAR(X.MED_RSV_DTM, 'YYYY-MM-DD HH24:MI')                                 -- MED_DTM(진료일시) -> MED_RSV_DTM(진료예약일시)
          INTO V_RTN_VAL
          FROM ACPPRODM X                                                           -- APOPRSVT -> ACPPRODM
         WHERE X.PT_NO      = IN_PT_NO
           AND X.MED_DT    > IN_REQ_DTE
           AND REGEXP_REPLACE(X.MED_DEPT_CD , '^(PC)|^(BC)|^(RC)', '')                   -- MED_DEPT(진료과) -> MED_DEPT_CD(진료부서코드)
             = REGEXP_REPLACE(IN_MED_DEPT, '^(PC)|^(BC)|^(RC)', '')
           AND X.APCN_DTM   IS NULL                                                      -- CNCL_DTE(취소일자) -> APCN_DTM(접수취소일시)
           AND NVL(X.MEF_RPY_CLS_CD,'N') != '1'                                          -- MEDRCP_YN(진찰료수납여부) -> MEF_RPY_CLS_CD(진찰료수납유형코드)
           AND NVL(X.OTPT_RSV_TP_CD  ,'1') IN (                                          -- RSV_TYP(예약구분) -> OTPT_RSV_TP_CD(외래예약구분코드) 
                                         '0'            -- 건증
                                       , '1'            -- 창구
                                       , '2'            -- 진료과
                                       , '3'            -- 진료협력센터
                                       , '4'            -- 전화재진
                                       , '5'            -- 전화신환
                                       , '6'            -- 전화초진
                                       , '7'            -- 인터넷
                                       , 'C'            -- 의학연구
                                       , 'E'            -- 가정간호
                                       , 'G'            -- 휴일,일과후(진찰료50%)
                                       , 'H'            -- 보호자내원
                                       , 'J'            -- FAX예약
                                       )
        ;
    END IF;

    
    RETURN(V_RTN_VAL);

EXCEPTION
    WHEN OTHERS THEN
        RETURN ('');
END FT_RSV_DTE_INFO;

/