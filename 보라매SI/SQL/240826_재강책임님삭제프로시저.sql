PROCEDURE      PC_ACP_RSV_ONESTOP_MEDICAL_REFER(       

                                            IN_JOBTYPE          IN        VARCHAR2   --작업구분(I,U,D)
                                          , IN_PT_NO            IN        VARCHAR2   --환자번호
                                          , IN_REG_DT           IN        DATE   --등록일자
                                          , IN_REG_SEQ          IN        NUMBER   --등록순번(취소시 수정시 사용) 
                                          , IN_RFFM_TP_CD       IN        VARCHAR2   --의뢰서구분코드 (1:성폭행,2:가정폭력)
                                          , IN_PT_RRN           IN        VARCHAR2   --환자주민등록번호
                                          , IN_BSC_ADDR         IN        VARCHAR2   --기본주소
                                          , IN_TEL_NO           IN        VARCHAR2   --보호자명
                                          , IN_MTEL_NO          IN        VARCHAR2   --환자관계구분코드
                                          , IN_PACT_TP_CD       IN        VARCHAR2   --원무접수구분코드
                                          , IN_EMRG_KIT_USE_YN  IN        VARCHAR2   --응급키트사용여부
                                          , IN_MED_DEPT_CD      IN        VARCHAR2   --진료과코드
                                          , IN_MEDR_STF_NO      IN        VARCHAR2   --진료의직원번호
                                          , IN_PME_CLS_CD       IN        VARCHAR2   --환자급종유형코드
                                          , IN_PSE_CLS_CD       IN        VARCHAR2   --환자보조유형코드
                                          , IN_MED_DTM          IN        VARCHAR2   --진료일시
                                          , IN_RMK_CNTE         IN        VARCHAR2   --비고내용
                                          , IN_FRVS_CMED_YN     IN        VARCHAR2   --초진선택여부
                                          , IN_RMDE_CMED_YN     IN        VARCHAR2   --재진선택여부
                                          , IN_EXM_CMED_YN      IN        VARCHAR2   --검사선택여부
                                          , IN_DGNS_CMED_YN     IN        VARCHAR2   --진단선택여부
                                          , IN_HIS_STF_NO       IN        VARCHAR2
                                          , IN_HIS_PRGM_NM      IN        VARCHAR2
                                          , IN_HIS_IP_ADDR      IN        VARCHAR2
                                          , IO_ERRYN            IN   OUT  VARCHAR2
                                          , IO_ERRMSG           IN   OUT  VARCHAR2
                                          )
IS  
/***********************************************************************************
 *    서비스이름  : PC_ACP_RSV_ONESTOP_MEDICAL_REFER
 *    최초 작성일 : 2024.08.16
 *    최초 작성자 : 김재강 
 *    DESCRIPTION :  원스톱(남부해바라기/경찰트라우마) 진료의뢰서 등록 및 외래/응급 예약
 ***********************************************************************************/  
    V_HSP_TP_CD        PDEDBMSM.HSP_TP_CD%TYPE;
    V_CORG_CD          ACPPRCUM.CORG_CD%TYPE;
    V_REG_SEQ          ACPPROSD.REG_SEQ%TYPE;
    V_PT_RRN           PCTPCPAM.PT_RRN%TYPE;
    V_FRVS_RMDE_TP     ACPPRODM.FRVS_RMDE_TP_CD%TYPE;
    
    
    V_PME_CLS_CD2      ACPPRPID.PME_CLS_CD%TYPE;  -- 환자기본 보험유형
    V_POB_NO           ACPPRPID.POB_NO%TYPE;
    V_PT_BRDY_DT       VARCHAR2(10);
    
    IO_EXAMYN          VARCHAR2(1);
    IO_RCPAMT          NUMBER;
    IO_FOCUS           VARCHAR2(1);
    IO_RCPSEQ          NUMBER;
    
    V_RSV_DTM          DATE := TO_DATE(REPLACE(REPLACE(REPLACE(IN_MED_DTM,'-',''),':',''),' ',''),'YYYYMMDDHH24MI');    --2024-08-17 17:00과 같은 형식을 202408171700으로 만들어서 날짜로 형변환
    
    V_OLD_PACT_ID      ACPPRODM.PACT_ID%TYPE;  -- 기예약건이 있는지 체크한다.(있으면 외래,응급 예약을 하지 않는다.)
    V_OLD_RPY_CLS_SEQ  ACPPRORE.RPY_CLS_SEQ%TYPE;
    IO_PACT_ID         ACPPRODM.PACT_ID%TYPE; 
    
    V_RSV_TYPE         VARCHAR2(7) :='INSERT';
    
    V_NGT_ADN_TYP      VARCHAR2(1);
    V_HLDY_YN          VARCHAR2(1);     
    
    V_FRVS_RMDE_TP_NM  VARCHAR2(10); 
    
    V_SYSDATE          DATE;    
    V_TEMP             VARCHAR2(10);   
    V_CHECK            VARCHAR2(1);  -- 등록 중복여부 체크
BEGIN                                                                           
    IF IN_JOBTYPE != 'U' THEN
        V_SYSDATE := TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD');
    ELSE       
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        V_SYSDATE := IN_REG_DT; 
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

    END IF;
    
    IF NVL(IN_MED_DEPT_CD,'*') IN ('ER','OGO2') AND (IN_PME_CLS_CD IS NULL OR IN_PSE_CLS_CD IS NULL OR IN_MEDR_STF_NO IS NULL) THEN
         IO_ERRYN  := 'Y';
         IO_ERRMSG := 'ERRCODE:-20002'                 || '¶' ||
                      'SOURCE: PC_ACP_RSV_ONESTOP_MEDICAL_REFER' || '¶' ||
                      'SQLTYPE: SELECT'                || '¶' ||
                      'MSGTEXT: ER/OGO2 과는 예약정보가 필요합니다. 추가정보를 입력해주세요.'          || '¶' ||
                      'SQLCODE:' || SQLCODE            || '¶' ||
                      'SQLERRM:' || SQLERRM            || '¶' ||
                      'CAPTIONTEXT: 안내'                || '¶' ||
                      'MSGTYPE: MSG_TYPE_ERROR'        || '¶' ||
                      'MODALYN: Y'                     || '¶' ||
                      'MSGBOXBUTTON: OK'               || '¶' ||
                      'TIMESPAN: -1'                   || '¶' ||
                      'BUTTONFOCUSTYPE: OK';
         RETURN;
    END IF;  

    
    BEGIN
       SELECT HSP_TP_CD
         INTO V_HSP_TP_CD
         FROM PDEDBMSM
        WHERE DEPT_CD = IN_MED_DEPT_CD;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            IO_ERRYN  := 'Y';
            IO_ERRMSG := 'ERRCODE:-20002'                 || '¶' ||
                         'SOURCE: PC_ACP_RSV_ONESTOP_MEDICAL_REFER' || '¶' ||
                         'SQLTYPE: SELECT'                || '¶' ||
                         'MSGTEXT: 병원구분 조회시 에러'          || '¶' ||
                         'SQLCODE:' || SQLCODE            || '¶' ||
                         'SQLERRM:' || SQLERRM            || '¶' ||
                         'CAPTIONTEXT: 안내'                || '¶' ||
                         'MSGTYPE: MSG_TYPE_ERROR'        || '¶' ||
                         'MODALYN: Y'                     || '¶' ||
                         'MSGBOXBUTTON: OK'               || '¶' ||
                         'TIMESPAN: -1'                   || '¶' ||
                         'BUTTONFOCUSTYPE: OK';
            RETURN;
    END;               
    
                             
        BEGIN
            SELECT PME_CLS_CD
                 , TO_CHAR(PT_BRDY_DT,'YYYYMMDD')
              INTO V_TEMP
                 , V_PT_BRDY_DT
              FROM PCTPCPAM
             WHERE PT_NO = IN_PT_NO;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_TEMP := '';
        END;
    
    -- 삽입/수정 시에는 기존 신청서 중에 같은 날, 진료과, 접수구문 신청서가 있는지 조회
    -- 삽입시는 시퀀스를 새로 딴다
    -- 삭제,수정시에는 입력으로 들어온 시퀀스를 사용한다.    
    IF IN_JOBTYPE = 'I' THEN                                             
        
        BEGIN
            SELECT 'Y'
              INTO V_CHECK
              FROM ACPPROSD
             WHERE REG_DT          BETWEEN TRUNC(V_SYSDATE)
                                       AND TRUNC(V_SYSDATE) + 0.99999
               AND PT_NO           = IN_PT_NO
               AND PETRA.PLS_DECRYPT_B64_ID(PT_RRN , 800)   = REPLACE(IN_PT_RRN,'-','')
               AND PACT_TP_CD         = IN_PACT_TP_CD
               AND MED_DEPT_CD        = IN_MED_DEPT_CD
               AND CNCL_DT        IS NULL               --2010-11-08 권욱주 추가
               ;                       
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    V_CHECK := 'N';
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20500,'PC_AP_APONESTT_CREATE: 진료의뢰서 중복 체크중 에러가 발생하였습니다. ' || CHR(13) || SQLCODE || CHR(13) || SQLERRM);
            END;       
            
            IF V_CHECK = 'Y' THEN
                RAISE_APPLICATION_ERROR(-20999,'동일한 날짜에 동일한 진료과, 타입의 의뢰서 존재 합니다.|▒|');
                RETURN;
            END IF;
        BEGIN
           SELECT NVL(MAX(REG_SEQ),0)+1
             INTO V_REG_SEQ
             FROM ACPPROSD
            WHERE HSP_TP_CD = V_HSP_TP_CD
              AND PT_NO     = IN_PT_NO
              AND REG_DT    BETWEEN TRUNC(V_SYSDATE) 
                                AND TRUNC(V_SYSDATE) + 0.99999;
        END;
        
             
        
        -- 사업장정보 및 환자기본의 보험정보 조회
        IF V_TEMP != 'AA' THEN
            BEGIN
                SELECT B.PME_CLS_CD
                     , A.POB_NO
                  INTO V_PME_CLS_CD2
                     , V_POB_NO
                  FROM ACPPRPID A
                     , PCTPCPAM B
                 WHERE A.PT_NO = IN_PT_NO
                   AND A.PT_NO = B.PT_NO
                   AND A.PME_CLS_CD = B.PME_CLS_CD
                   AND TRUNC(SYSDATE) BETWEEN A.INS_APY_DT
                                          AND A.INS_END_DT;          
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    IO_ERRYN  := 'Y';
                    IO_ERRMSG := 'ERRCODE:-20002'                 || '¶' ||
                                 'SOURCE: PC_ACP_RSV_ONESTOP_MEDICAL_REFER' || '¶' ||
                                 'SQLTYPE: SELECT'                || '¶' ||
                                 'MSGTEXT: 환자자격 조회시 에러'          || '¶' ||
                                 'SQLCODE:' || SQLCODE            || '¶' ||
                                 'SQLERRM:' || SQLERRM            || '¶' ||
                                 'CAPTIONTEXT: 안내'                || '¶' ||
                                 'MSGTYPE: MSG_TYPE_ERROR'        || '¶' ||
                                 'MODALYN: Y'                     || '¶' ||
                                 'MSGBOXBUTTON: OK'               || '¶' ||
                                 'TIMESPAN: -1'                   || '¶' ||
                                 'BUTTONFOCUSTYPE: OK';
                    RETURN;
            END;
        END IF;        
        -- 신초재여부 판단
        BEGIN
            SELECT /* XBIL.PKG_ACP_MOB_PT.PC_ACP_GET_RESERVATION_DATE_01 */
                   SUBSTRB( XBIL.FT_ACP_FRVS_RMDE_TP(   ''  -- IN_JOBTYPE 01.작업구분
                                                      , ''  -- IN_OLD_MED_DEPT_CD 02.이전진료과
                                                      , IN_MED_DEPT_CD    -- IN_MED_DEPT_CD  03.진료과
                                                      , IN_PT_NO -- IN_PT_NO 04.환자번호
                                                      , ''           -- IN_FSTDATE 
                                                      , IN_MEDR_STF_NO  -- IN_MEDR_STF_NO 
                                                      , IN_HIS_STF_NO-- APP11로 고정                                                  
                                                    ), 1, 4)
              INTO V_FRVS_RMDE_TP_NM
              FROM DUAL;
        END;     
        
        
        
        IF   V_FRVS_RMDE_TP_NM = '재진'  THEN
             V_FRVS_RMDE_TP  := '2';
        ELSIF V_FRVS_RMDE_TP_NM = '초진' THEN
             V_FRVS_RMDE_TP  := '1';
        ELSIF V_FRVS_RMDE_TP_NM = '재초' THEN
             V_FRVS_RMDE_TP  := '4';
        ELSE
             V_FRVS_RMDE_TP  := '3';
        END IF;
        
        -- 기예약건이 있는지 확인.
        IF IN_MED_DEPT_CD = 'ER' THEN
            BEGIN
                SELECT PACT_ID
                     , A.RPY_CLS_SEQ
                  INTO V_OLD_PACT_ID
                     , V_OLD_RPY_CLS_SEQ
                  FROM ACPPRETM  A /*응급접수기본*/
                     , ACPPRORE  B /*환자유형정보*/
                 WHERE A.PT_NO = IN_PT_NO
                   AND A.PACT_ID = B.RPY_PACT_ID
                   AND TRUNC(A.EMRM_ARVL_DTM) = TRUNC(V_RSV_DTM)
                   AND A.MED_DEPT_CD = IN_MED_DEPT_CD
                   AND A.APCN_DTM IS NULL
                   AND ROWNUM  = 1;
            EXCEPTION 
                WHEN NO_DATA_FOUND THEN
                    V_OLD_PACT_ID     :=''; 
                    V_OLD_RPY_CLS_SEQ :='';                    
            END;
            
            
            -- 야간/공휴가산 체크
            BEGIN
                SELECT SUBSTR(A.OUTPUT,1,1)
                     , SUBSTR(A.OUTPUT,2,1)
                  INTO V_NGT_ADN_TYP
                     , V_HLDY_YN
                  FROM (SELECT FT_ACP_NIGHTTYPE(TRUNC(V_RSV_DTM)
                                              , TO_CHAR(V_RSV_DTM,'HI24MI')
                                              )  AS OUTPUT
                         FROM DUAL
                        )A
                        ;                              
            END;
        ELSIF IN_MED_DEPT_CD = 'OGO2' THEN
            BEGIN
                SELECT PACT_ID
                     , A.RPY_CLS_SEQ
                  INTO V_OLD_PACT_ID
                     , V_OLD_RPY_CLS_SEQ
                  FROM ACPPRODM  A /*외래접수기본*/
                     , ACPPRORE  B /*환자유형정보*/
                 WHERE A.PT_NO = IN_PT_NO
                   AND A.PACT_ID = B.RPY_PACT_ID
                   AND A.MED_DT = TRUNC(V_RSV_DTM)
                   AND A.MED_DEPT_CD = IN_MED_DEPT_CD
                   AND A.APCN_DTM IS NULL
                   AND ROWNUM  = 1;
            EXCEPTION 
                WHEN NO_DATA_FOUND THEN
                    V_OLD_PACT_ID     :=''; 
                    V_OLD_RPY_CLS_SEQ :='';                    
            END;
        END IF;
    ELSIF IN_JOBTYPE IN ('U','D') THEN   
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        V_REG_SEQ := IN_REG_SEQ; 
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
    END IF;
    
    
    --IN_RFFM_TP_CD = 1 : 성폭력, 2 : 가정폭력
    IF NVL(IN_RFFM_TP_CD,'*') = '1' THEN
        V_CORG_CD := 'H011';
    ELSIF  NVL(IN_RFFM_TP_CD,'*') = '2' THEN
        V_CORG_CD := 'H018';
    END IF;
    
    
    IF IN_JOBTYPE IN ('I', 'U') THEN
        BEGIN
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
            MERGE INTO ACPPROSD
            
	               USING DUAL                                                                
	                  ON (    HSP_TP_CD	= V_HSP_TP_CD
                       AND PT_NO	    = IN_PT_NO	   
                       AND REG_DT	    BETWEEN TRUNC(V_SYSDATE)
                                            AND TRUNC(V_SYSDATE) + 0.99999 -- 등록일자 
                       AND REG_SEQ	  = V_REG_SEQ	           -- 등록번호
                     )              
                     
                     
	                WHEN MATCHED THEN                                                        
	              UPDATE SET RFFM_TP_CD       =  IN_RFFM_TP_CD     
                        , PT_RRN           =  PETRA.PLS_ENCRYPT_B64_ID( IN_PT_RRN , 800) 
                        , BSC_ADDR         =  IN_BSC_ADDR      
                        , TEL_NO           =  IN_TEL_NO         
                        , MTEL_NO          =  IN_MTEL_NO        
                        , PACT_TP_CD       =  IN_PACT_TP_CD     
                        , EMRG_KIT_USE_YN  =  IN_EMRG_KIT_USE_YN
                        , MED_DEPT_CD      =  IN_MED_DEPT_CD    
                        , MEDR_STF_NO      =  IN_MEDR_STF_NO    
                        , PME_CLS_CD       =  IN_PME_CLS_CD                
                        , PSE_CLS_CD       =  IN_PSE_CLS_CD     
                        , MED_DTM          =  V_RSV_DTM        
                        , FRVS_RMDE_TP_CD  =  V_FRVS_RMDE_TP
                        , RMK_CNTE         =  IN_RMK_CNTE       
                        , FRVS_CMED_YN     =  IN_FRVS_CMED_YN   
                        , RMDE_CMED_YN     =  IN_RMDE_CMED_YN   
                        , EXM_CMED_YN      =  IN_EXM_CMED_YN    
                        , DGNS_CMED_YN     =  IN_DGNS_CMED_YN           
                        , LSH_STF_NO       =  IN_HIS_STF_NO 
                        , LSH_PRGM_NM      =  IN_HIS_PRGM_NM
                        , LSH_DTM          =  SYSDATE    
                        , LSH_IP_ADDR      =  IN_HIS_IP_ADDR        
                        
                        
	                WHEN NOT MATCHED  THEN          
	              INSERT ( HSP_TP_CD	
                      , PT_NO	    
                      , REG_DT	   
                      , REG_SEQ	  
                      , RFFM_TP_CD      
                      , PT_RRN         
                      , BSC_ADDR        
                      , TEL_NO          
                      , MTEL_NO         
                      , PACT_TP_CD      
                      , EMRG_KIT_USE_YN 
                      , MED_DEPT_CD     
                      , MEDR_STF_NO     
                      , PME_CLS_CD      
                      , PSE_CLS_CD       
                      , MED_DTM         
                      , FRVS_RMDE_TP_CD 
                      , RMK_CNTE        
                      , FRVS_CMED_YN    
                      , RMDE_CMED_YN    
                      , EXM_CMED_YN     
                      , DGNS_CMED_YN  
                      , FSR_STF_NO
                      , FSR_DTM	
                      , FSR_PRGM_NM
                      , FSR_IP_ADDR
                      , LSH_STF_NO
                      , LSH_PRGM_NM
                      , LSH_DTM
                      , LSH_IP_ADDR 
	                     )
	               VALUES ( V_HSP_TP_CD	
                       , IN_PT_NO	    
                       , TO_DATE(TO_CHAR(V_SYSDATE,'YYYYMMDD'),'YYYYMMDD')
                       , V_REG_SEQ	  
                       , IN_RFFM_TP_CD      
                       , PETRA.PLS_ENCRYPT_B64_ID( IN_PT_RRN , 800)          
                       , IN_BSC_ADDR        
                       , IN_TEL_NO          
                       , IN_MTEL_NO         
                       , IN_PACT_TP_CD      
                       , IN_EMRG_KIT_USE_YN 
                       , IN_MED_DEPT_CD     
                       , IN_MEDR_STF_NO     
                       , IN_PME_CLS_CD      
                       , IN_PSE_CLS_CD      
                       , V_RSV_DTM         
                       , V_FRVS_RMDE_TP 
                       , IN_RMK_CNTE        
                       , IN_FRVS_CMED_YN    
                       , IN_RMDE_CMED_YN    
                       , IN_EXM_CMED_YN     
                       , IN_DGNS_CMED_YN   
                       , IN_HIS_STF_NO
                       , SYSDATE	
                       , IN_HIS_PRGM_NM
                       , IN_HIS_IP_ADDR
                       , IN_HIS_STF_NO
                       , IN_HIS_PRGM_NM
                       , SYSDATE
                       , IN_HIS_IP_ADDR 
	                     );           
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

        EXCEPTION
            WHEN OTHERS THEN
                IO_ERRYN  := 'Y';
                IO_ERRMSG := 'ERRCODE:-20002'                    || '¶' ||
                             'SOURCE: PC_ACP_RSV_ONESTOP_MEDICAL_REFER' || '¶' ||
                             'SQLTYPE: INSERT'                   || '¶' ||
                             'MSGTEXT: 진료의뢰서 등록시 에러'||SQLCODE  || '¶' ||
                             'SQLCODE:' || SQLCODE               || '¶' ||
                             'SQLERRM:' || SQLERRM               || '¶' ||
                             'CAPTIONTEXT: 안내'                   || '¶' ||
                             'MSGTYPE: MSG_TYPE_ERROR'           || '¶' ||
                             'MODALYN: Y'                        || '¶' ||
                             'MSGBOXBUTTON: OK'                  || '¶' ||
                             'TIMESPAN: -1'                      || '¶' ||
                             'BUTTONFOCUSTYPE: OK';
                RETURN; 
        END;       
    ELSIF IN_JOBTYPE  = 'D' THEN      
            BEGIN  

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */

             UPDATE ACPPROSD
               SET CNCL_DT          = V_SYSDATE          
                 , CNCL_STF_NO      = IN_HIS_STF_NO      
                 , LSH_STF_NO       = IN_HIS_STF_NO 
                 , LSH_PRGM_NM      = IN_HIS_PRGM_NM
                 , LSH_DTM          = SYSDATE    
                 , LSH_IP_ADDR      = IN_HIS_IP_ADDR    
             WHERE HSP_TP_CD	= V_HSP_TP_CD
               AND PT_NO	    = IN_PT_NO	   
               AND REG_DT	   BETWEEN TRUNC(V_SYSDATE)
                                   AND TRUNC(V_SYSDATE) + 0.99999	  
               AND REG_SEQ	  = V_REG_SEQ;	  
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */ 
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        
        EXCEPTION
            WHEN OTHERS THEN
                IO_ERRYN  := 'Y';
                IO_ERRMSG := 'ERRCODE:-20002'                    || '¶' ||
                             'SOURCE: PC_ACP_RSV_ONESTOP_MEDICAL_REFER' || '¶' ||
                             'SQLTYPE: DELETE'                   || '¶' ||
                             'MSGTEXT: 진료의뢰서 삭제시 에러'||SQLCODE  || '¶' ||
                             'SQLCODE:' || SQLCODE               || '¶' ||
                             'SQLERRM:' || SQLERRM               || '¶' ||
                             'CAPTIONTEXT: 안내'                   || '¶' ||
                             'MSGTYPE: MSG_TYPE_ERROR'           || '¶' ||
                             'MODALYN: Y'                        || '¶' ||
                             'MSGBOXBUTTON: OK'                  || '¶' ||
                             'TIMESPAN: -1'                      || '¶' ||
                             'BUTTONFOCUSTYPE: OK';
            RETURN; 
        END;
    END IF;
    
    
    IF V_OLD_PACT_ID IS NULL AND IN_JOBTYPE != 'D' THEN 
             V_RSV_TYPE :='UPDATE';
    ELSIF IN_JOBTYPE = 'D' THEN
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
         V_RSV_TYPE :='CANCLE';
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
    ELSE 
         V_RSV_TYPE :='INSERT';
    END IF;
    
    --ER이면 응급으로 자동등록되고 OG02면 외래로 잡힌다.
    IF IN_JOBTYPE != 'D' AND IN_MED_DEPT_CD IN ('OGO2','ER')THEN 
        BEGIN
            -- 진료 예약
            XBIL.PC_ACP_COMMON_RSV_ACPPRODM ( V_RSV_TYPE                 -- IN_JOBTYPE              IN     VARCHAR2                             -- 00 작업구분   INSERT,UPDATE,CANCLE,TYPEADD
                                            , 'J'                        -- IN_NEW_JOBTYPE          IN     VARCHAR2                             -- 01 작업구분
                                            , V_HSP_TP_CD                -- IN_HSP_TP_CD            IN     ACPPRODM.HSP_TP_CD%TYPE              -- 02 병원구분코드        
                                            , IN_PT_NO                   -- IN_NEW_PT_NO            IN     ACPPRODM.PT_NO%TYPE                  -- 03 환자번호            
                                            , V_PT_BRDY_DT               -- IN_NEW_BIRTHDAY         IN     VARCHAR2                             -- 04 생년월일
                                            , IN_PME_CLS_CD              -- IN_NEW_PME_CLS_CD       IN     ACPPRODM.PME_CLS_CD%TYPE             -- 05 환자급종유형코드    
                                            , V_PME_CLS_CD2              -- IN_NEW_PME_CLS_CD2      IN     ACPPRODM.PME_CLS_CD%TYPE             -- 06 급여종별(보험내역의)
                                            , IN_PSE_CLS_CD              -- IN_NEW_PSE_CLS_CD       IN     ACPPRODM.PSE_CLS_CD%TYPE             -- 07 유형보조
                                            , V_POB_NO                   -- IN_NEW_POB_NO           IN     ACPPEOCE.POB_NO%TYPE                 -- 08 조합기호         
                                            , 'O'                        -- IN_NEW_PACT_TP_CD       IN     ACPPEOCE.PACT_TP_CD%TYPE             -- 09 환자구분          
                                            , V_CORG_CD                  -- IN_NEW_CORG_CD          IN     ACPPRODM.CORG_CD%TYPE                -- 10 계약기관코드        
                                            , ''                         -- IN_RPY_PACT_ID          IN     ACPPRORE.RPY_PACT_ID%TYPE            -- 11 원무접수ID       
                                            , ''                         -- IN_PACT_ID              IN     ACPPRODM.PACT_ID%TYPE                -- 12 원무접수ID     
                                            , 1                          -- IN_RPY_CLS_SEQ          IN     ACPPRORE.RPY_CLS_SEQ%TYPE            -- 13 수납유형순번   
                                            , TO_CHAR(V_RSV_DTM,'YYYYMMDD') -- IN_NEW_MED_DT           IN     VARCHAR2                             -- 14 NEW 진료정보 진료일자(YYYYMMDD)
                                            , IN_MED_DEPT_CD                  -- IN_NEW_MED_DEPT_CD      IN     ACPPRODM.MED_DEPT_CD%TYPE            -- 15 진료과
                                            , XCOM.FT_CNL_SELSTFINFO('1',IN_MEDR_STF_NO, V_RSV_DTM) -- IN_NEW_MEDR_SID         IN     ACPPRODM.MEDR_SID%TYPE                -- 16 진료의사
                                            , TO_CHAR(V_RSV_DTM,'HH24MI')           -- IN_NEW_MED_TM           IN     VARCHAR2                             -- 17 진료시간(HH24MI)
                                            , 'N'                        -- IN_NEW_MEF_RPY_CLS_CD   IN     ACPPRODM.MEF_RPY_CLS_CD%TYPE         -- 18 수납구분
                                            , ''                         -- IN_NEW_MDRF_RCORG_NO    IN     ACPPRORE.MDRF_RCORG_NO%TYPE          -- 19 진료의뢰요양기관번호
                                            , '1' --창구                  -- IN_NEW_OTPT_RSV_TP_CD   IN     ACPPRODM.OTPT_RSV_TP_CD%TYPE        -- 20 외래예약구분코드
                                            , ''                         -- IN_RSV_ACPT_TP_CD       IN     ACPPRODM.OTPT_RSV_DTL_TP_CD%TYPE     -- 21 접수구분(일반:01, 건증:02, 수탁:03, 직원검진:04, 헌혈:05, 임상연구(의학연구):06)
                                            , 'N'                        -- IN_NEW_CMED_YN          IN     ACPPRODM.CMED_YN%TYPE                -- 22 지정구분
                                            , V_FRVS_RMDE_TP             -- IN_NEW_FRVS_RMDE_TP_CD  IN     ACPPRODM.FRVS_RMDE_TP_CD%TYPE        -- 23 초재진
                                            , 1                          -- IN_NEW_RPY_SEQ          IN     ACPPRODM.RPY_SEQ%TYPE                -- 24 수납순번
                                            , TO_CHAR(V_RSV_DTM,'YYYYMMDDHH24MI')                  -- IN_NEW_EMRM_ARVL_DTM    IN     VARCHAR2                             -- 25 도착일시
                                            , V_NGT_ADN_TYP              -- IN_NEW_NGT_ADN_TP_CD    IN     ACPPRETM.NGT_ADN_TP_CD%TYPE          -- 26 야간구분
                                            , V_HLDY_YN                  -- IN_NEW_HLDY_YN          IN     ACPPRETM.HLDY_YN%TYPE                -- 27 공휴구분
                                            , TO_CHAR(SYSDATE,'YYYYMMDD')    -- IN_NEW_RSV_APLC_DT      IN     VARCHAR2                             -- 28 신청일자
                                            , IN_HIS_STF_NO                   -- IN_NEW_EDITID           IN     ACPPEOPD.RPY_STF_NO%TYPE             -- 29 수납자
                                            , V_OLD_PACT_ID              -- IN_OLD_RPY_PACT_ID      IN     ACPPRORE.RPY_PACT_ID%TYPE            -- 30 OLD 진료정보 원무접수ID
                                            , V_OLD_RPY_CLS_SEQ          -- IN_OLD_RPY_CLS_SEQ      IN     ACPPRORE.RPY_CLS_SEQ%TYPE            -- 31 OLD 수납유형순번   
                                            , ''                         -- IN_CLNL_RSCH_NO         IN     ACPPRODM.CLNL_RSCH_NO%TYPE           -- 32 임상번호                   
                                            , 'N'                        -- IN_ODRER_YN             IN     ACPPRODM.ODRER_YN%TYPE               -- 33 CONSULT
                                            , ''                         -- IN_TELGUBN              IN     VARCHAR2                             -- 34 전화예약구분('TEL')
                                            , ''                         -- IN_NEW_EXINFTYP         IN     ACPPIEXD.IORD_RSN_CD%TYPE            -- 35 의약환자구분
                                            , ''                         -- IN_OLD_EXINFTYP         IN     ACPPIEXD.IORD_RSN_CD%TYPE            -- 36 의약환자구분
                                            , ''                         -- IN_REFUNDCD             IN     ACPPEOPD.RFND_RSN_CD%TYPE            -- 37 환불사유코드
                                            , ''                         -- IN_REFUNDNM             IN     ACPPEOPD.RBTR_NM%TYPE                -- 38 환불자 성명 
                                            , ''                         -- IN_REFUNDRL             IN     VARCHAR2                             -- 39 환불자 관계 
                                            , ''                         -- IN_REFUNDHP             IN     ACPPEOPD.RBTR_TEL_NO%TYPE            -- 40 환불자 전화 
                                            , ''                         -- IN_REFUNDGUBN           IN     ACPPEOPD.RFND_PATH_TP_CD%TYPE        -- 41 환불구분 
                                            , ''                         -- IN_REFUNDBKCD           IN     ACPPEOPD.BNK_CTG_CD%TYPE             -- 42 은행명   
                                            , ''                         -- IN_REFUNDACC            IN     ACPPEOPD.ACNT_NO%TYPE                -- 43 계좌번호 
                                            , IO_EXAMYN                  -- IO_EXAMYN               IN OUT VARCHAR2                             -- 44 검사예약존재여부
                                            , IO_RCPAMT                  -- IO_RCPAMT               IN OUT VARCHAR2                             -- 45 수납금액
                                            , IO_FOCUS                   -- IO_FOCUS                IN OUT VARCHAR2                             -- 46 화면FOCUS
                                            , IO_RCPSEQ                  -- IO_RCPSEQ               IN OUT VARCHAR2                             -- 47 수납순번
                                            , ''                         -- IN_RSVRMK_TYP           IN     ACPPRODM.TEL_RSV_RSN_CD%TYPE         -- 48 전화예약사유코드 20090819 추가
                                            , ''                         -- IN_RSV_RMK              IN     ACPPRODM.TEL_RSV_RSN_RMK%TYPE        -- 49 전화예약사유비고 20090819 추가
                                            , ''                         -- IN_REFUNDSIGNSTR        IN     VARCHAR2                             -- 50 환불용 싸인 STRING값 2010.07.22 강동혁
                                            , ''                         -- IN_FRNR_OTPT_RSV_TP_CD  IN     ACPPRODM.FRNR_OTPT_RSV_TP_CD%TYPE    -- 51
                                            , ''                         -- IN_PA_RMK_CNTE          IN     ACPPRODM.PA_RMK_CNTE%TYPE            -- 52 원무비고내용 
                                            , ''                         -- IN_SNR_RMK_CNTE         IN     ACPPRODM.SNR_RMK_CNTE%TYPE           -- 53 진료협력메모  
                                            , ''                         -- IN_CLNL_ADMC_RSCH_YN    IN     ACPPRODM.CLNL_ADMC_RSCH_YN%TYPE      -- 55
                                            , ''                         -- IN_HMPG_CTR_TP_CD       IN     ACPPRODM.HMPG_CTR_TP_CD%TYPE         -- 56 홈페이지센터구분코드 
                                            , ''                         -- IN_EMRG_CDSYM_CD        IN     ACPPRETM.EMRG_CDSYM_CD%TYPE          -- 57 응급주증상코드
                                            , ''                         -- IN_EMRG_CDSYM_DTL_CNTE  IN     ACPPRETM.EMRG_CDSYM_DTL_CNTE %TYPE   -- 58 응급주증상상세내용
                                            , IN_HIS_PRGM_NM             -- IN_FSR_PRGM_NM          IN     ACPPRODM.FSR_PRGM_NM%TYPE            -- 59.최초등록프로그램명
                                            , IN_HIS_IP_ADDR             -- IN_FSR_IP_ADDR          IN     ACPPRODM.FSR_IP_ADDR%TYPE            -- 60.최초등록IP주소   
                                            , ''                         -- IN_MDRF_RCORG_NO        IN     ACPPRETM.MDRF_RCORG_NO%TYPE          -- 61.타요양병원기관기호(김민지)
                                            , V_PT_RRN                   -- IN_SUJINJAJUMINNO       IN     VARCHAR2
                                            , ''                         -- IN_SUJINJAJUMINNM       IN     VARCHAR2 
                                            , '11100249'                 -- IN_YKIHO                IN     VARCHAR2   -- 의료급여 기관번호
                                            , ''                         -- IN_DIAGTYPE             IN     VARCHAR2 
                                            , ''                         -- IN_PAYDDCNT             IN     VARCHAR2 
                                            , ''                         -- IN_TUYAKDDCNT           IN     VARCHAR2 
                                            , ''                         -- IN_SELFPARTBRDNAMT      IN     VARCHAR2 
                                            , ''                         -- IN_CFHCDMDAMT           IN     VARCHAR2 
                                            , ''                         -- IN_ADMINBRDNAMT         IN     VARCHAR2 
                                            , ''                         -- IN_MAINSICKSYM          IN     VARCHAR2 
                                            , TO_CHAR(V_RSV_DTM,'YYYYMMDD')    -- IN_DIAGDT               IN     VARCHAR2 
                                            , ''                         -- IN_PIADMIN              IN     VARCHAR2 
                                            , ''                         -- IN_PRSCGNOADMIN         IN     VARCHAR2 
                                            , ''                         -- IN_SBRDNTYPE            IN     VARCHAR2 
                                            , ''                         -- IN_OTHERREQUESTYN       IN     VARCHAR2 
                                            , ''                         -- IN_CFHCCFRNO            IN     VARCHAR2 
                                            , ''                         -- IN_CFHCCFRNOERR         IN     VARCHAR2 
                                            , ''                         -- IN_ADMTYPE              IN     VARCHAR2 
                                            , ''                         -- IN_CFHCREM              IN     VARCHAR2 
                                            , ''                         -- IN_CNCLTYPE             IN     VARCHAR2 
                                            , ''                         -- IN_MESSAGECODE          IN     VARCHAR2 
                                            , ''                         -- IN_MESSAGE              IN     VARCHAR2 
                                            , 'M5'                       -- IN_MSGTYPE              IN     VARCHAR2 
                                            , ''                         -- IN_LOGINID              IN     VARCHAR2 
                                            , ''                         -- IN_PASSWORD             IN     VARCHAR2 
                                            , ''                         -- IN_SENDDATE             IN     VARCHAR2 
                                            , IN_HIS_STF_NO || ' ' || IN_HIS_IP_ADDR   -- IN_CLIENTINFO           IN     VARCHAR2 
                                            , ''                         -- IN_OPERATORJUMINNO      IN     VARCHAR2 
                                            , ''                         -- IN_DIAGITEM             IN     VARCHAR2 
                                            , ''                         -- IN_DISREGPRSON1         IN     VARCHAR2 
                                            , ''                         -- IN_DISREGPRSON2         IN     VARCHAR2 
                                            , ''                         -- IN_DISREGPRSON3         IN     VARCHAR2 
                                            , ''                         -- IN_DISREGPRSON4         IN     VARCHAR2 
                                            , ''                         -- IN_PREGSUMAMT           IN     VARCHAR2 
                                            , ''                         -- IN_PREGDMNDAMT          IN     VARCHAR2  
                                            , ''                         -- IN_PREGREMAMT           IN     VARCHAR2  
                                            , 'NO'                       -- IN_VAT_TYPE             IN     VARCHAR2  
                                            , ''                         -- IN_NEW_SYMPTOM          IN     VARCHAR2  
                                            , ''                         -- IN_NEW_SYMPTOM_MEMO     IN     VARCHAR2
                                            , ''                         -- IN_IHS_RSV_TP_CNTE      IN     VARCHAR2 
                                            , ''                         -- IN_PSE_CLS_DTL_CD       IN     VARCHAR2  
                                            , ''                         -- IN_PSE_CLS_DTL_ETC_CNTE IN     VARCHAR2 
                                            , 'PAC'                      -- IN_SCHTINPUT            IN     VARCHAR2
                                            , ''                         -- IN_DUMMY1               IN     VARCHAR2
                                            , ''                         -- IN_DUMMY2               IN     VARCHAR2
                                            , ''                         -- IN_DUMMY3               IN     VARCHAR2
                                            , ''                         -- IN_DUMMY4               IN     VARCHAR2
                                            , ''                         -- IN_DUMMY5               IN     VARCHAR2 
                                            , ''                         -- IN_DUMMY5               IN     VARCHAR2
                                            , IO_PACT_ID                 -- IO_PACT_ID              IN OUT VARCHAR2       -- 2018.09.11 추가
                                            , IO_ERRYN                   -- IO_ERRYN                IN OUT VARCHAR2       -- 53 ERROR YN
                                            , IO_ERRMSG                  -- IO_ERRMSG               IN OUT VARCHAR2       -- 54 MESSAGE
                                           );
        END;
    END IF;
END PC_ACP_RSV_ONESTOP_MEDICAL_REFER;
