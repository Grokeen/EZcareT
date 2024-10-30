EXEC :IN_FYYYYMM := '2024';
EXEC :IN_LOOK := '1';
EXEC :IN_REP_TYP := '1';
EXEC :IN_LOOK_TYP :='2';




/** *                      1.IN_FYYYYMM     =>시작일자 =   YYYY.년 ,  YYYYMM.년월  , YYYYMMDD.년월일   ,  YYYYMMDD.년월일
    *                      2.IN_TYYYYMM     =>종료일자 =   NULL    ,  NULL        , NULL             ,  YYYYMMDD.년월일
    *
    *                      3.IN_LOOK        =>열람구분 =   1.연보,  2.월보 , 3.일보 , 4.기간
    *                      4.IN_REP_TYP     =>퇴원구분 =   1. 입원환자(실입원)
    *                                                    2. 입원환자(실입원)과별배분
    *                                                    3. 퇴원환자(실퇴원)
    *                                                    4. 퇴원환자(실퇴원)과별배분
    *                                                    5. 재원환자(연입원)
    *                                                    6. 총재원수(연퇴원)
    *                                                    (X)  7 퇴원평균재원일
    *                                                    (X)  8 퇴원평균재원일 = 과별배분
    *                      5.IN_AGE_TYP     =>나이구분 = 1.65세이상 , 2.65세미만 ,3.전체
    *                      6.(X)       IN_LOOK_TYP    =>제외병동 = 1.포함,2.미포함  ER99,OR99,OGOB,NB
**/

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



	    	        SELECT
	                   CASE WHEN GROUPING(AREA_CD) = 0 THEN
	                             NVL((SELECT COMN_CD_NM
	                                    FROM CCCCCSTE
                                     WHERE COMN_GRP_CD = '260'
                                       AND COMN_CD = AREA_CD),AREA_CD)



	                        ELSE '합계'
	                   END                                                          "지역"
	                  ---------------------------------------------------------------------------
	                  -- 재원연입원실환자수
	                  ---------------------------------------------------------------------------
	                  ,sum(jae_hapgae  )                                            jae_hapgae
	                  ,sum(jae_bohum   )                                            jae_bohum
	                  ,sum(jae_boho    )                                            jae_boho
	                  ,0                                                            adm_boho2
	                  ,sum(jae_hangyer )                                            jae_hangyer
	                  ,sum(jae_sanjae  )                                            jae_sanjae
	                  ,0                                                            jae_sanjae2
	                  ,sum(jae_general )                                            jae_general
	                  ,sum(jae_traffic )                                            jae_traffic
	                  ,sum(jae_gita    )                                            jae_gita
	              FROM
	                  (




/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/




	                   select
	                          wk_key                                                       area_cd
	                         ---------------------------------------------------------------------------
	                         -- 재원연입원실환자수
	                         ---------------------------------------------------------------------------
	                         ,sum(jespcrsv_cnt)                                            jae_hapgae
	                         ,sum(
	                              case when pattype in ('B1','B2','B6','BB') then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_bohum
	                         ,sum(
	                              case when pattype in ('E1','E2','E6')      then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_boho
	                         ,sum(
	                              case when pattype in ('E8')                then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_hangyer
	                         ,sum(
	                              case when pattype in ('SA','SB','SP')      then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_sanjae
	                         ,sum(
	                              case when pattype in ('AA')                then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_general
	                         ,sum(
	                              case when pattype in ('TA')                then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_traffic
	                         ,sum(
	                              case when pattype in ( 'B1','B2','B6','BB'
	                                                    ,'E1','E2','E6'
	                                                    ,'E8'
	                                                    ,'SA','SB','SP'
	                                                    ,'AA'
	                                                    ,'TA'
	                                                   )                     then 0
	                                   else jespcrsv_cnt
	                              end
	                             )                                                         jae_gita
	                         ---------------------------------------------------------------------------
	                         ,'1'                                                          gubun

                     FROM APSTATMT2
                    WHERE MED_DTE IN
                                      (

/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                       SELECT  END_DTE
                                         FROM
                                             (



/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                              SELECT
                                                     DISTINCT
                                                     CASE WHEN :IN_LOOK IN ('1','2') THEN
                                                               CASE WHEN LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                         LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                                    ELSE
                                                                         TRUNC(SYSDATE) -1
                                                               END
                                                         ELSE
                                                               TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                     END       END_DTE
                                                    ,ROW_NUMBER() OVER(PARTITION BY ROWNUM ORDER BY ROWNUM) RANK
                                                FROM DICT
                                               WHERE ROWNUM <= 12

/* 1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                             )
                                        WHERE END_DTE BETWEEN CASE :IN_LOOK
                                                                   WHEN '1' THEN
                                                                        CASE WHEN TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD') < TRUNC(SYSDATE)-1  THEN
                                                                                  TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD')
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '2' THEN
                                                                        CASE WHEN TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD') < TRUNC(SYSDATE)-1  THEN
                                                                                  TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '3' THEN
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                   ELSE
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                              END
                                                          AND
                                                              CASE :IN_LOOK
                                                                   WHEN '1' THEN
                                                                        CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                  LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD'))
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '2' THEN
                                                                        CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                  LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD'))
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '3' THEN
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                   ELSE
                                                                        TO_DATE(:IN_TYYYYMM ,'YYYYMMDD')
                                                              END

/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                             )
	                      AND DTL_TYP = 'M03'
	                      AND PATSITE = 'I'
	                      AND AGE_TYP = '1'
	                    GROUP BY
	                             WK_KEY
	                  )
	             GROUP BY
	                      ROLLUP(AREA_CD)
	             HAVING  SUM(JAE_HAPGAE) != 0
	             ORDER BY
	                      AREA_CD







/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



;
