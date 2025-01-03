﻿




## 진료과별 지역별 의사별/2010,11년 수납기준환자수

- pkg_mis_pts_pts_pts04.pc_sel_pts04_income001



```sql
 /**********************************************************************************
 *    서비스이름  : pc_sel_pts04_income001
 *    최초 작성일 : 2012.05.07
 *    최초 작성자 : ezCareTech 이상우
 *    Description : 진료과별 지역별 의사별/2010, 11년 수납기준환자수
 **********************************************************************************/
 procedure pc_sel_pts04_income001   (
  							          in_fr_dt                   in   varchar2
	                                , in_to_dt                   in   varchar2
	                                , in_gubun                   in   varchar2
	                                , out_cursor                 out  returncursor
	                                )
is
    wk_cursor returncursor;
    begin
        if  to_date(in_fr_dt) > to_date('20111231','yyyymmdd') or
            to_date(in_to_dt) > to_date('20111231','yyyymmdd') then
            raise_application_error(-20500,'조회기간 오류!(2010, 2011년도만 가능합니다.)' || chr(13) || 'err_cd = '|| sqlcode || chr(13) || ' ' || sqlerrm);
        end if;

        if  in_gubun = '1' then      /*진료과별*/
        begin
            open wk_cursor for


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


				SELECT DECODE(DEPT_NM, NULL, '합계', DEPT_NM)           "진료과"
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


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

				       SELECT
				              DEPT_NM
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


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


				              SELECT A.PT_NO
				                   , A.MED_DEPT
				                   , A.PATTYPE
				                   , B.DEPT_NM
				                   , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
				                FROM APOPRSVT A
				                   , CCDEPART B
				               WHERE A.MED_DTE   BETWEEN  TO_DATE(in_fr_dt,'yyyymmdd')
				                                     AND  TO_DATE(in_to_dt,'yyyymmdd') + .99999
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
                                    -- 인공신장실 IMN0으로 시작하는 의사 건수 포함시키기 위해서...
				                    and a.medrcp_yn = CASE WHEN TO_CHAR(MED_DTE,'YYYYMMDD') >= '20110701' AND SUBSTR(A.MEDDR_ID,1,3) = 'IMN' THEN A.MEDRCP_YN
                                                           ELSE 'Y'
                                                       END
				                    --------------------------------------------------------------------------
				                    AND B.DEPT_CD = A.MED_DEPT


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

				              UNION ALL


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

				              SELECT A.PT_NO
				                   , A.MED_DEPT
				                   , A.PATTYPE
				                   , B.DEPT_NM
				                   , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
				                FROM APEMGRCT A
				                   , CCDEPART B
				               WHERE A.ARV_DTM   BETWEEN  TO_DATE(in_fr_dt,'yyyymmdd')
				                                     AND  TO_DATE(in_to_dt,'yyyymmdd') + .99999
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
				                 AND B.DEPT_CD = A.MED_DEPT



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

				              ) A
				        GROUP BY DEPT_NM, MED_TYP, PATTYPE



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

				       )
				 GROUP BY ROLLUP(DEPT_NM);



                                                                                                                                                                                   
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
				 
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

        end;
        elsif in_gubun = '2' then   /*지역별*/
        begin
            open wk_cursor for



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          SELECT DECODE(BB.CSUBCD_NM, NULL, '주소미상', BB.CSUBCD_NM) CSUBCD_NM, PT_NO, MED_DEPT, PATTYPE, MED_TYP
                            FROM (


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                 SELECT
                                        A.PT_NO                 PT_NO
                                      , A.MED_DEPT              MED_DEPT
                                      , A.PATTYPE               PATTYPE
                                      , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
                                      , C.AREA_CD
                                   FROM APOPRSVT A
                                      , APPATBAT B
                                      , CCPOSTMT C
--                                      , CCCODEST D
                                  WHERE A.MED_DTE   BETWEEN  TO_DATE(IN_FR_DT,'YYYYMMDD')
                                                        AND  TO_DATE(IN_TO_DT,'YYYYMMDD') + .99999
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
                                    AND C.ZIP_NO(+)  = B.ZIP_NO
                                    AND C.ZIP_SEQ(+) = B.ZIP_SEQ



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                 ) AA
                               , CCCODEST BB
                           WHERE BB.CCD_TYP(+) = '260'
                             AND BB.C_CD(+) = AA.AREA_CD



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          UNION ALL


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          SELECT DECODE(BB.CSUBCD_NM, NULL, '주소미상', BB.CSUBCD_NM) CSUBCD_NM, PT_NO, MED_DEPT, PATTYPE, MED_TYP
                            FROM (


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                 SELECT
                                        A.PT_NO
                                      , A.MED_DEPT
                                      , A.PATTYPE
                                      , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
                                      , C.AREA_CD
                                   FROM APEMGRCT A
                                      , APPATBAT B
                                      , CCPOSTMT C
--                                      , CCCODEST D
                                  WHERE A.ARV_DTM   BETWEEN  TO_DATE(IN_FR_DT,'YYYYMMDD')
                                                        AND  TO_DATE(IN_TO_DT,'YYYYMMDD') + .99999
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
                                    AND C.ZIP_NO(+)  = B.ZIP_NO
                                    AND C.ZIP_SEQ(+) = B.ZIP_SEQ


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                  ) AA
                               , CCCODEST BB
                           WHERE BB.CCD_TYP(+) = '260'
                             AND BB.C_CD(+) = AA.AREA_CD


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

			              ) A
			        GROUP BY CSUBCD_NM, MED_TYP, PATTYPE


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

			       )
			 GROUP BY ROLLUP(CSUBCD_NM);



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

        end;
        elsif in_gubun = '3' then   /*의사별*/
        begin
            open wk_cursor for



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

				SELECT DECODE(WK_NM, NULL, '합계', WK_NM)               "의사명"
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


/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

				       SELECT
				              WK_NM
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
				         
				         

/* 1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     				         
				              SELECT
				                     WK_NM
				                   , A.PT_NO
				                   , A.MED_DEPT
				                   , A.PATTYPE
				                   , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
				                FROM APOPRSVT A
				                   , CCUSERMT B
				               WHERE A.MED_DTE   BETWEEN  TO_DATE(in_fr_dt,'yyyymmdd')
				                                     AND  TO_DATE(in_to_dt,'yyyymmdd') + .99999
				                 AND A.CNCL_DTE  IS NULL
				--                 AND A.MEDRCP_YN    IN ('Y','1')
				--                 AND CASE WHEN
				--                           ( ( SUBSTR(MED_DEPT,1,3) NOT IN ('HPC') AND NVL(SUBSTR(RSV_TYP,1,1),'1') NOT IN ('8','9','X') )
				--                           OR ( SUBSTR(MED_DEPT,1,3) IN ('HPC') AND RSV_TYP IN ('0') ) ) THEN 'Y'
				--                     END = 'Y'
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
				                 and a.medrcp_yn = CASE WHEN TO_CHAR(MED_DTE,'YYYYMMDD') >= '20110701' AND SUBSTR(A.MEDDR_ID,1,3) = 'IMN' THEN A.MEDRCP_YN
                                                           ELSE 'Y'
                                                       END
				                 --------------------------------------------------------------------------
				                 AND B.WK_ID = A.MEDDR_ID 
				                 
				                 
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     				                 
				              UNION ALL           
				              
				              
/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     				              
				              SELECT
				                     WK_NM
				                   , A.PT_NO
				                   , A.MED_DEPT
				                   , A.PATTYPE
				                   , DECODE(A.MED_TYP, '4', '1', A.MED_TYP)   MED_TYP
				                FROM APEMGRCT A
				                   , CCUSERMT B
				               WHERE A.ARV_DTM   BETWEEN  TO_DATE(in_fr_dt,'yyyymmdd')
				                                     AND  TO_DATE(in_to_dt,'yyyymmdd') + .99999
				                 AND A.CNCL_DTE IS NULL
				                 AND A.ADM_DTE IS NULL
				--                 AND NVL(SUBSTR(A.RSV_TYP,1,1),'1')   NOT IN ('8','9','X')
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
				                 AND B.WK_ID = A.MEDDR_ID 
				                 
				                 
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     				                 
				              ) A
				        GROUP BY WK_NM, MED_TYP, PATTYPE       
				        
				        
/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     				        
				       )
				 GROUP BY ROLLUP(WK_NM);
				 
				 
				 
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     				 
        end;
        end if;

        out_cursor := wk_cursor;

        exception
            when others then
                raise_application_error(-20500,'pc_sel_pts04_income001 오류!' || chr(13) || 'err_cd = '|| sqlcode || chr(13) || ' ' || sqlerrm);

end pc_sel_pts04_income001

```
