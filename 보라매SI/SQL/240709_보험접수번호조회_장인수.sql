-- <sql id="HIS.PA.AI.IC.AR.SelAcceptCardinalNumberAsk">
-- <!--
--     Clss : text
--     Desc : 접수번호조회 데이터조회
--     Author : 이지케어텍(주) 김세한
--     Create date : 2012-06-21
--     Update date : 2012-06-21 
-- -->

-- ❤️ 이게 if문이라고 했지
-- <IsNotEqual Prepend="" Property="IN_INS_KND_CD" CompareValue="6">


SELECT    /* HIS.PA.AI.IC.AR.SelAcceptCardinalNumberAsk */
          A.DMD_PACT_TP_CD                              DMD_PACT_TP_CD
      ,   A.MED_YM                                      MED_YM
      ,   A.DMD_TP_CD                                   DMD_TP_CD
      ,   A.INS_KND_CD                                  INS_KND_CD
      ,   A.HIRA_MTFL_CD                                HIRA_MTFL_CD
      ,   A.SHIP_SEQ                                    SHIP_SEQ
      ,   A.DMD_NO                                      DMD_NO
      ,   A.DMD_ACPT_NO                                 DMD_ACPT_NO
      
   FROM  AIMIPRQS A
         
  WHERE  1=1 
--   날짜 조회할 때, 시작 날짜 값이 있으면
  	-- <IsNotEmpty Property="IN_MED_YM"> 
	-- 	<IsNotNull Property="IN_MED_YM">
	-- 		<![CDATA[
			
	-- 		AND CASE WHEN :IN_SEARCH_TYPE = '2' THEN -- 청구일 기준 2011-06-29 박인선 배윤주샘요청에 신규추가 
    --                    TO_CHAR(A.DMD_ACPT_DT, 'YYYYMM')
    --              ELSE DECODE (LENGTH(A.DMD_NO), 8, '20'||SUBSTR(A.DMD_NO,1,4), SUBSTR(A.DMD_NO,1,6))  END  = :IN_MED_YM
			
	-- 		]]>
	-- 	</IsNotNull>
	--   </IsNotEmpty>
     
	
-- ':in' 이	바인딩 -> 값을 받아올 때 변수명		
-- 	 
    -- AND  NVL(A.DMD_PACT_TP_CD, '*') = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN
    --  DECODE(SUBSTR(:IN_DMD_PACT_TP_CD,1,1) , 'X', DMD_PACT_TP_CD, SUBSTR(:IN_DMD_PACT_TP_CD,1,1) )                                                                         
    --  ELSE DECODE(:IN_DMD_PACT_TP_CD , 'X', DMD_PACT_TP_CD, :IN_DMD_PACT_TP_CD ) END)
																			
    -- AND  A.INS_KND_CD           = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN '7' ELSE '4'  END )
	
    AND  A.SCRG_CLSN_YN           = 'Y'
	
    --   날짜 조회할 때, 끝나는 날짜 값이 있으면
	-- <IsNotEmpty Property="IN_DMD_ACPT_NO"> 
	-- 	<IsNotNull Property="IN_DMD_ACPT_NO">
	-- 		<![CDATA[
	-- 		AND A.DMD_ACPT_NO = :IN_DMD_ACPT_NO
	-- 		]]>
	-- 	</IsNotNull>
	--   </IsNotEmpty>
                           
  GROUP BY     A.DMD_PACT_TP_CD                       
           ,   A.MED_YM
           ,   A.DMD_TP_CD                      
           ,   A.INS_KND_CD                       
           ,   A.HIRA_MTFL_CD                      
           ,   A.SHIP_SEQ                     
           ,   A.DMD_NO                      
           ,   A.DMD_ACPT_NO 

-- ❤️ 여기까지 1 ------------------------------------------------------------------------------------------------


UNION ALL
SELECT  A.DMD_PACT_TP_CD                                       DMD_PACT_TP_CD
                  ,   A.MED_YM                                      MED_YM
                  ,   A.DMD_TP_CD                                      DMD_TP_CD
                  ,   A.INS_KND_CD                                       INS_KND_CD
                  ,   A.HIRA_MTFL_CD                                      HIRA_MTFL_CD
                  ,   A.SHIP_SEQ                                     SHIP_SEQ
                  ,   A.DMD_NO                                      DMD_NO
                  ,   A.DMD_ACPT_NO                                      DMD_ACPT_NO
                  
               FROM  AIMIPRQS A
			   WHERE 1=1
			   
		--  <IsNotEmpty Property="IN_MED_YM"> 
		-- 	<IsNotNull Property="IN_MED_YM">
		-- 		<![CDATA[
				
		-- 		AND  CASE WHEN :IN_SEARCH_TYPE = '2' THEN -- 청구일 기준 2011-06-29 박인선 배윤주샘요청에 신규추가 
        --                          TO_CHAR(A.DMD_ACPT_DT, 'YYYYMM')
        --                      ELSE DECODE (LENGTH(A.DMD_NO), 8, '20'||SUBSTR(A.DMD_NO,1,4), SUBSTR(A.DMD_NO,1,6))  END  = :IN_MED_YM
				
		-- 		]]>
		-- 	</IsNotNull>
		--   </IsNotEmpty>
							 
                AND  NVL(A.DMD_PACT_TP_CD, '*') = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN
                                                                                DECODE(SUBSTR(:IN_DMD_PACT_TP_CD,1,1) , 'X', DMD_PACT_TP_CD, SUBSTR(:IN_DMD_PACT_TP_CD,1,1) )                                                                         
                                                                            ELSE DECODE(:IN_DMD_PACT_TP_CD , 'X', DMD_PACT_TP_CD, :IN_DMD_PACT_TP_CD ) END)
                AND  A.INS_KND_CD           = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN '7' ELSE '5'  END )
                AND  A.SCRG_CLSN_YN           = 'Y'           
				
	--  <IsNotEmpty Property="IN_DMD_ACPT_NO"> 
	-- 	<IsNotNull Property="IN_DMD_ACPT_NO">
	-- 		<![CDATA[
	-- 		AND A.DMD_ACPT_NO = :IN_DMD_ACPT_NO
	-- 		]]>
	-- 	</IsNotNull>
	--   </IsNotEmpty>
				
              GROUP BY     A.DMD_PACT_TP_CD                       
                       ,   A.MED_YM
                       ,   A.DMD_TP_CD                      
                       ,   A.INS_KND_CD                       
                       ,   A.HIRA_MTFL_CD                      
                       ,   A.SHIP_SEQ                     
                       ,   A.DMD_NO                      
                       ,   A.DMD_ACPT_NO                      


-- ❤️ 여기까지 2 ------------------------------------------------------------------------------------------------




UNION ALL
SELECT  A.DMD_PACT_TP_CD                                       DMD_PACT_TP_CD
                  ,   A.MED_YM                                      MED_YM
                  ,   A.DMD_TP_CD                                      DMD_TP_CD
                  ,   A.INS_KND_CD                                       INS_KND_CD
                  ,   A.HIRA_MTFL_CD                                      HIRA_MTFL_CD
                  ,   A.SHIP_SEQ                                     SHIP_SEQ
                  ,   A.DMD_NO                                      DMD_NO
                  ,   A.DMD_ACPT_NO                                      DMD_ACPT_NO
                  
               FROM  AIMIPRQS A
			   WHERE 1=1
			   
		--  <IsNotEmpty Property="IN_MED_YM"> 
		-- 	<IsNotNull Property="IN_MED_YM">
		-- 		<![CDATA[
				
		-- 		AND  CASE WHEN :IN_SEARCH_TYPE = '2' THEN -- 청구일 기준 2011-06-29 박인선 배윤주샘요청에 신규추가 
        --                          TO_CHAR(A.DMD_ACPT_DT, 'YYYYMM')
        --                      ELSE DECODE (LENGTH(A.DMD_NO), 8, '20'||SUBSTR(A.DMD_NO,1,4), SUBSTR(A.DMD_NO,1,6))  END  = :IN_MED_YM
				
		-- 		]]>
		-- 	</IsNotNull>
		--   </IsNotEmpty>
							 
                AND  NVL(A.DMD_PACT_TP_CD, '*') = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN
                                                                                DECODE(SUBSTR(:IN_DMD_PACT_TP_CD,1,1) , 'X', DMD_PACT_TP_CD, SUBSTR(:IN_DMD_PACT_TP_CD,1,1) )                                                                         
                                                                            ELSE DECODE(:IN_DMD_PACT_TP_CD , 'X', DMD_PACT_TP_CD, :IN_DMD_PACT_TP_CD ) END)
                AND  A.INS_KND_CD           = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN '7' ELSE '6'  END )
                AND  A.SCRG_CLSN_YN           = 'Y'           
				
	--  <IsNotEmpty Property="IN_DMD_ACPT_NO"> 
	-- 	<IsNotNull Property="IN_DMD_ACPT_NO">
	-- 		<![CDATA[
	-- 		AND A.DMD_ACPT_NO = :IN_DMD_ACPT_NO
	-- 		]]>
	-- 	</IsNotNull>
	--   </IsNotEmpty>
				
              GROUP BY     A.DMD_PACT_TP_CD                       
                       ,   A.MED_YM
                       ,   A.DMD_TP_CD                      
                       ,   A.INS_KND_CD                       
                       ,   A.HIRA_MTFL_CD                      
                       ,   A.SHIP_SEQ                     
                       ,   A.DMD_NO                      
                       ,   A.DMD_ACPT_NO   





-- ❤️ 여기까지 3 ------------------------------------------------------------------------------------------------



UNION ALL

SELECT  A.DMD_PACT_TP_CD                                       DMD_PACT_TP_CD
                  ,   A.MED_YM                                      MED_YM
                  ,   A.DMD_TP_CD                                      DMD_TP_CD
                  ,   A.INS_KND_CD                                       INS_KND_CD
                  ,   A.HIRA_MTFL_CD                                      HIRA_MTFL_CD
                  ,   A.SHIP_SEQ                                     SHIP_SEQ
                  ,   A.DMD_NO                                      DMD_NO
                  ,   A.DMD_ACPT_NO                                      DMD_ACPT_NO
                  
               FROM  AIMIPRQS A			   
			   WHERE 1=1
			   
    --   <IsNotEmpty Property="IN_MED_YM"> 
	-- 	<IsNotNull Property="IN_MED_YM">
	-- 		<![CDATA[
				
	-- 			AND  CASE WHEN :IN_SEARCH_TYPE = '2' THEN -- 청구일 기준 2011-06-29 박인선 배윤주샘요청에 신규추가 
    --                              TO_CHAR(A.DMD_ACPT_DT, 'YYYYMM')
    --                          ELSE DECODE (LENGTH(A.DMD_NO), 8, '20'||SUBSTR(A.DMD_NO,1,4), SUBSTR(A.DMD_NO,1,6))  END  = :IN_MED_YM				
			
	-- 		]]>
	-- 	</IsNotNull>
	--   </IsNotEmpty>
							 
                AND  NVL(A.DMD_PACT_TP_CD, '*') = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN
                                                                                DECODE(SUBSTR(:IN_DMD_PACT_TP_CD,1,1) , 'X', DMD_PACT_TP_CD, SUBSTR(:IN_DMD_PACT_TP_CD,1,1) )                                                                         
                                                                            ELSE DECODE(:IN_DMD_PACT_TP_CD , 'X', DMD_PACT_TP_CD, :IN_DMD_PACT_TP_CD ) END)
                AND  A.INS_KND_CD           = (CASE WHEN LENGTH(:IN_DMD_PACT_TP_CD)=2 THEN '7' ELSE '7'  END )
                AND  A.SCRG_CLSN_YN           = 'Y'            
				
	--   <IsNotEmpty Property="IN_DMD_ACPT_NO"> 
	-- 	<IsNotNull Property="IN_DMD_ACPT_NO">
	-- 		<![CDATA[
	-- 		AND A.DMD_ACPT_NO = :IN_DMD_ACPT_NO
	-- 		]]>
	-- 	</IsNotNull>
	--   </IsNotEmpty>
				
              GROUP BY     A.DMD_PACT_TP_CD                       
                       ,   A.MED_YM 
                       ,   A.DMD_TP_CD                      
                       ,   A.INS_KND_CD                       
                       ,   A.HIRA_MTFL_CD                      
                       ,   A.SHIP_SEQ                     
                       ,   A.DMD_NO                      
                       ,   A.DMD_ACPT_NO                      
                       
			ORDER  BY     DMD_NO





</IsNotEqual>

 </sql>