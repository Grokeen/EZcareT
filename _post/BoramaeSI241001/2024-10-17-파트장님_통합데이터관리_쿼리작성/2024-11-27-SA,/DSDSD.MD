SELECT PT_NO                                      PT_NO
      ,ADDR_TP_NM                                 ADDR_TP_NM
      ,COUNT(*) OVER (PARTITION BY PT_NO)         CNT

FROM (

     SELECT
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
          END  AS ADDR_TP_NM
     
         ,B.*
     FROM PCTPCPTD B
     WHERE B.PT_NO = :IN_PT_NO
       AND BSC_ADDR IS NOT NULL
     
     
     /* 2015년 1월 1일 이후 기준 */
     UNION
     SELECT
           CASE WHEN TO_NUMBER(SUBSTR(POST_NO,0,2))BETWEEN 1  AND 9  THEN CASE WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 010 AND 012 THEN '서울강북구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 013 AND 015 THEN '서울도봉구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 016 AND 019 THEN '서울노원구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 020 AND 023 THEN '서울중랑구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 024 AND 026 THEN '서울동대문구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 027 AND 029 THEN '서울성북구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 030 AND 032 THEN '서울종로구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 033 AND 035 THEN '서울은평구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 036 AND 038 THEN '서울서대문구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 039 AND 042 THEN '서울마포구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 043 AND 044 THEN '서울용산구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 045 AND 046 THEN '서울중구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 047 AND 048 THEN '서울성동구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 049 AND 051 THEN '서울광진구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 052 AND 054 THEN '서울강동구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 055 AND 059 THEN '서울송파구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 060 AND 064 THEN '서울강남구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 065 AND 068 THEN '서울서초구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 069 AND 071 THEN '서울동작구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 072 AND 074 THEN '서울영등포구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 075 AND 078 THEN '서울강서구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 079 AND 081 THEN '서울양천구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 082 AND 084 THEN '서울구로구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 085 AND 086 THEN '서울금천구'
                                                                               WHEN TO_NUMBER(SUBSTR(POST_NO,0,3)) BETWEEN 087 AND 088 THEN '서울관악구'
                                                                               ELSE '주소미상'
                                                                           END
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 10 AND 20 THEN '경기'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 21 AND 23 THEN '인천시'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 24 AND 26 THEN '강원'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 27 AND 29 THEN '충북'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 30              THEN '세종시'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 31 AND 33 THEN '충남'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 34 AND 35 THEN '대전'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 36 AND 40 THEN '경북'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 41 AND 43 THEN '대구'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 44 AND 45 THEN '울산시'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 46 AND 49 THEN '부산시'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 50 AND 53 THEN '경남'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 54 AND 56 THEN '전북'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 57 AND 60 THEN '전남'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 61 AND 62 THEN '광주시'
               WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 63              THEN '제주'
               ELSE '주소미상'
          END  AS ADDR_TP_NM
              ,B.*
     FROM PCTPCPTD B
     WHERE B.PT_NO = :IN_PT_NO
       AND POST_NO IS NOT NULL
     --  AND FSR_DTM >= '2015-01-01'
     
     
     
     
     /* 2014년 12월 31일까지 기준 -> 2015년 8월 이후, 전국 신우편번호 시행, 기존 우편번호 폐지 */
     --UNION
     --SELECT
     --      CASE WHEN TO_NUMBER(SUBSTR(POST_NO,0,2))BETWEEN 10 AND 15 THEN '서울'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 41 AND 48 THEN '경기'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 40              THEN '인천시'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 20 AND 26 THEN '강원'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 36 AND 39 THEN '충북'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 31 AND 35 THEN '충남'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 30              THEN '대전'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 71 AND 79 THEN '경북'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 70              THEN '대구'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 68              THEN '울산시'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 60 AND 61 THEN '부산시'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 62 AND 67 THEN '경남'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 56 AND 59 THEN '전북'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) BETWEEN 51 AND 55 THEN '전남'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 50              THEN '광주시'
     --          WHEN TO_NUMBER(SUBSTR(POST_NO,0,2)) = 69              THEN '제주'
     --          ELSE '주소미상'
     --     END  AS ADDR_TP_NM
     --         ,B.*
     --FROM PCTPCPTD B
     --WHERE B.PT_NO = :IN_PT_NO
     --  AND POST_NO IS NOT NULL
     --  AND FSR_DTM < '2015-01-01'

)
WHERE 1=1
  AND ROWNUM =1