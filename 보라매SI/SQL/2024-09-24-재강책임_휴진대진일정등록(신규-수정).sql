

-- (종일,오전,오후)/보충진료기간(From/To)/총보충시간/남은휴진시간/보충진료시사유





     
-----------------------------------------------------------------------------------------------------------------------    
     
FUNCTION FT_ACP_DELAY_REASON_YN (  IN_TYPE     		 IN VARCHAR2                  /* 신규/수정/삭제 구분 */
																	,IN_DR_SID	     IN ACDPCAPD.DR_SID%TYPE	    /* 의사직원식별ID */
																	,IN_MED_DEPT_CD  IN ACDPCAPD.MED_DEPT_CD%TYPE	/* 진료부서코드 */
																	,IN_APY_STR_DTM  IN ACDPCAPD.APY_STR_DTM%TYPE	/* 적용시작일시 */
																	,IN_DR_STF_NO 	 IN ACDPCAPD.DR_STF_NO%TYPE		/* 의사직원번호 */
																	,IN_APY_END_DTM  IN ACDPCAPD.APY_END_DTM%TYPE	/* 적용종료일시 */
																	,IN_TM_UNIT_CD	 IN ACDPCAPD.TM_UNIT_CD%TYPE	/* 시간단위코드 */
																	,IN_SUP_MEMO 		 IN ACDPCAPD.SUP_MEMO%TYPE		/* 보충메모 */
																	,HIS_STF_NO   	 IN ACDPCAPD.LSH_STF_NO%TYPE	/* 최종변경직원번호 */
																	,HIS_PRGM_NM     IN ACDPCAPD.LSH_PRGM_NM%TYPE	/* 최종변경프로그램명 */
																	,HIS_IP_ADDR     IN ACDPCAPD.LSH_IP_ADDR%TYPE	/* 최종변경IP주소 */
																	,IN_SPLM_MED_TM  IN ACDPCAPD.SPLM_MED_TM%TYPE	/* 보충진료시간 */
																	
																	,IN_OLD_APY_STR_DTM IN VARCHAR2  /* UPDATE 적용시작일시('YYYYMMDDHH24MI') */
																	,IN_OLD_APY_END_DTM IN VARCHAR2  /* UPDATE 적용종료일시('YYYYMMDDHH24MI') */
																	,IN_OLD_LSH_DTM     IN VARCHAR2  /* UPDATE 최초등록일시('YYYYMMDDHH24MI') */
                                 
                                )                               
                            
RETURN VARCHAR2 IS
/***********************************************************************************                                                                                                            
 *    서비스이름  : FT_ACP_DR_SCHEDULE_REG
 *    최초 작성일 : 2024-09-24
 *    최초 작성자 : 김용록
 *    DESCRIPTION : 
 ***********************************************************************************/         


BEGIN
    /* 신규 */ 
    IF IN_TYPE = '1' THEN       
        BEGIN
            INSERT INTO ACDPCAPD (
                DR_SID	      /* 의사직원식별ID */
                ,MED_DEPT_CD	/* 진료부서코드 */
                ,APY_STR_DTM	/* 적용시작일시 */
                ,DR_STF_NO	  /* 의사직원번호 */
                ,APY_END_DTM	/* 적용종료일시 */
                ,TM_UNIT_CD	  /* 시간단위코드 */
                ,SUP_MEMO	    /* 보충메모 */
                ,FSR_STF_NO	  /* 최초등록직원번호 */
                ,FSR_DTM	    /* 최초등록일시 */
                ,FSR_PRGM_NM	/* 최초등록프로그램명 */
                ,FSR_IP_ADDR	/* 최초등록IP주소 */
                ,LSH_STF_NO	  /* 최종변경직원번호 */
                ,LSH_DTM	    /* 최종변경일시 */
                ,LSH_PRGM_NM	/* 최종변경프로그램명 */
                ,LSH_IP_ADDR	/* 최종변경IP주소 */
                ,SPLM_MED_TM)	/* 보충진료시간 */
            values (
                IN_DR_SID	      /* 의사직원식별ID */
                ,IN_MED_DEPT_CD /* 진료부서코드 */
                ,IN_APY_STR_DTM /* 적용시작일시 */
                ,IN_DR_STF_NO	  /* 의사직원번호 */
                ,IN_APY_END_DTM /* 적용종료일시 */
                ,IN_TM_UNIT_CD	/* 시간단위코드 */
                ,IN_SUP_MEMO	  /* 보충메모 */
                ,HIS_STF_NO   	/* 최초등록직원번호 */
                ,SYSDATE  	    /* 최초등록일시 */
                ,HIS_PRGM_NM    /* 최초등록프로그램명 */
                ,HIS_IP_ADDR    /* 최초등록IP주소 */
                ,HIS_STF_NO   	/* 최종변경직원번호 */
                ,SYSDATE  	    /* 최종변경일시 */
                ,HIS_PRGM_NM    /* 최종변경프로그램명 */
                ,HIS_IP_ADDR    /* 최종변경IP주소 */
                ,IN_SPLM_MED_TM ) /* 보충진료시간 */
            ;         
         EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 BEGIN
                    
                 END; 
                 
        END;               

    /* 수정 */
    ELSIF IN_TYPE = '2' THEN
        BEGIN
            UPDATE ACDPCSPD
               SET TM_UNIT_CD = IN_TM_UNIT_CD                               /* 시간단위코드(AM/PM왜 필요한 거지?)*/ 
                   ,APY_STR_DTM = IN_APY_STR_DTM                            /* 적용시작일시 */
                   ,APY_END_DTM = IN_APY_END_DTM                            /* 적용종료일시 */
                   ,SPLM_MED_TM = IN_SPLM_MED_TM                            /* 보충진료시간 */
                   ,SUP_MEMO = IN_SUP_MEMO                                  /* 보중메모(보충진료사유) */
                  
                   ,LSH_STF_NO  = HIS_STF_NO                                /* 최종변경하는직원번호 */
                   ,LSH_DTM     = SYSDATE                                   /* 최종변경하는일시 */
                   ,LSH_PRGM_NM = HIS_PRGM_NM                               /* 최종변경하는프로그램명 */
                   ,LSH_IP_ADDR = HIS_IP_ADDR                               /* 최종변경하는IP */
             WHERE DR_STF_NO = IN_DR_STF_NO
               AND TO_CHAR(APY_STR_DTM,'YYYYMMDDHH24MI') = IN_OLD_APY_STR_DTM
               AND TO_CHAR(APY_END_DTM,'YYYYMMDDHH24MI') = IN_OLD_APY_END_DTM 
               AND TO_CHAR(FSR_DTM,'YYYYMMDDHH24MI') = IN_OLD_LSH_DTM

        END;  
                      
    /* 삭제 */
    ELSIF IN_TYPE = '3' THEN    
        BEGIN         
            UPDATE ACDPCSPD
               SET CNCL_DT = SYSDATE                                        /* 취소일자 */
                   ,CNCL_STF_NO = HIS_STF_NO                                /* 취소직원번호 */     
                   ,LSH_STF_NO  = HIS_STF_NO                                /* 최종변경하는직원번호 */
                   ,LSH_DTM     = SYSDATE                                   /* 최종변경하는일시 */
                   ,LSH_PRGM_NM = HIS_PRGM_NM                               /* 최종변경하는프로그램명 */
                   ,LSH_IP_ADDR = HIS_IP_ADDR                               /* 최종변경하는IP */
             where DR_STF_NO = IN_DR_STF_NO
               AND TO_CHAR(APY_STR_DTM,'YYYYMMDDHH24MI') = IN_OLD_APY_STR_DTM
               AND TO_CHAR(APY_END_DTM,'YYYYMMDDHH24MI') = IN_OLD_APY_END_DTM 
               AND TO_CHAR(FSR_DTM,'YYYYMMDDHH24MI') = IN_OLD_LSH_DTM

        END;  
                        
    END IF;

               
END FT_ACP_DR_SCHEDULE_REG;