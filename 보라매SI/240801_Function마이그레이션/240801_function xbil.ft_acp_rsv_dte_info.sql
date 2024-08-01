CREATE OR REPLACE
FUNCTION FT_ACP_RSV_DTE_INFO   ( IN_MED_TM      IN      DATE      -- 01. 진료일시   
                                )                               
                            
RETURN VARCHAR2 IS
/***********************************************************************************
 *    서비스이름  : FT_ACP_AMPM_TYPE
 *    최초 작성일 : 2024-05-21
 *    최초 작성자 : 김재강
 *    DESCRIPTION : 오전오후 구분 
 *                  오전 : 0830 ~ 1200  => 'AM'
 *                  오후 : 1300 ~ 1700  => 'PM'
 ***********************************************************************************/ 
 AMPM_TYPE VARCHAR2(2);          -- 오전오후 구분 
 
BEGIN 
    BEGIN 
        SELECT /*+ XBIL.FT_ACP_AMPM_TYPE_S01*/
               AMPM
          INTO AMPM_TYPE
          FROM (
                SELECT CASE WHEN TO_CHAR(IN_MED_TM,'HH24MI') BETWEEN '0830'
                                               AND '1159'   
                            THEN 'AM'
                            WHEN TO_CHAR(IN_MED_TM,'HH24MI') BETWEEN '1200'
                                               AND '1700'   
                            THEN 'PM'
                            ELSE ''
                            END        AS  AMPM
                  FROM DUAL
                 );
    EXCEPTION
    WHEN  OTHERS THEN 
      AMPM_TYPE := '';
    END;
    
    RETURN  AMPM_TYPE;                           
    
END FT_ACP_RSV_DTE_INFO;

/