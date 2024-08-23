DECLARE
   -----------------
   -- 기준이 되는 수진
   -----------------
   IN_PACT_ID     ACPPRODM.PACT_ID%TYPE := NULL;
   IN_HSP_TP_CD   ACPPRODM.HSP_TP_CD%TYPE := '7';

   ------------
   --진료의 관련
   ------------
   IN_MEDR_STF_NO   ACPPRODM.MEDR_STF_NO%TYPE := NULL;
   IN_MEDR_SID      ACPPRODM.MEDR_SID%TYPE    := NULL;

   --------------
   -- 진료부서 관련
   --------------
   IN_MED_DEPT      ACPPRODM.MED_DEPT_CD%TYPE := NULL;

   ---------------
   --시스템관련 정보
   ---------------
    IN_HIS_STF_NO   PCTPCPAM.FSR_STF_NO%TYPE               :='C0ADM'; -- 41최초등록직원번호
    IN_HIS_PRGM_NM  PCTPCPAM.FSR_PRGM_NM%TYPE              :='GOLDEN-SDM'; -- 42최초등록프로그램명
    IN_HIS_IP_ADDR  PCTPCPAM.FSR_IP_ADDR%TYPE              :='1.1.1.1'; -- 43최초등록IP주소

   ----------
   -- 진료시간
   ----------
   V_MED_RSV_DTM      DATE;

   ROW_ACPPRODM       ACPPRODM%ROWTYPE;
   ROW_ACPPRORE       ACPPRORE%ROWTYPE;

   L_PACT_ID         VARCHAR2(30) := NULL;

   V_IORD_CD         VARCHAR2(2);
BEGIN
    BEGIN
        SELECT PACT_ID
          INTO IN_PACT_ID
          FROM ACPPRODM
         WHERE MED_DT > TRUNC(SYSDATE) - 365
           AND OTPT_RSV_TP_CD = '1'
           AND MEF_RPY_CLS_CD ='N'
           AND MED_YN ='N'
           AND APCN_DTM IS NULL
           AND CORG_CD  IS NULL
           AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'ACPPRODM PACT_ID 조회중 오류 1'||CHR(10)||TO_CHAR(SQLERRM));
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'ACPPRODM PACT_ID 조회중 오류 2'||CHR(10)||TO_CHAR(SQLERRM));

    END;

    FOR REC IN (SELECT A.*
                     , B.MED_DEPT_CD                                 AS MED_DEPT_CD
                     , B.FRVS_RMDE_TP_CD                             AS FRVS_RMDE_TP_CD
                     , B.MED_ADS_DT                                  AS MED_DT
                     , B.DR_STF_NO                                   AS MEDR_STF_NO
                     , XCOM.FT_CNL_SELSTFINFO('1',B.DR_STF_NO, '')   AS MEDR_SID
                     , B.PME_CLS_CD                                  AS P_PME_CLS_CD
                  FROM PCTPCPAM A
                     , XBIL.TEMPPTRSV B
                 WHERE A.PT_NO  = B.PT_NO
                   AND (   (B.PACT_TP_CD ='O')
                        OR (B.PACT_TP_CD ='I' AND NVL(B.NEED_OTPT_RSV,'N') ='Y')
                        )
                   AND B.RPY_PACT_ID IS NULL
     )
     LOOP

        BEGIN
            SELECT *
              INTO ROW_ACPPRODM
              FROM ACPPRODM A
             WHERE 1=1
               AND PACT_ID = IN_PACT_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, TO_CHAR('에러 01 : ') || sqlerrm);
        END;

        BEGIN
            SELECT '89'
              INTO V_IORD_CD
              FROM DUAL
             WHERE REC.P_PME_CLS_CD = 'DD3'  ;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_IORD_CD :='';
        END;
        --------------
        --PACT_ID 생성
        --------------
        L_PACT_ID  := XBIL.FT_PCT_PACTID;

        --------------------------
        --PACT_ID 관련 변수 바꿔치기
        --------------------------
        V_MED_RSV_DTM := TRUNC(REC.MED_DT)  + ((1/24) * 17);

        ROW_ACPPRODM.PACT_ID         :=  L_PACT_ID;
        ROW_ACPPRODM.RPY_PACT_ID     :=  L_PACT_ID;
        ROW_ACPPRODM.FST_PACT_ID     :=  L_PACT_ID;

        ROW_ACPPRODM.MED_DEPT_CD     := REC.MED_DEPT_CD;
        ROW_ACPPRODM.MEDR_SID        := REC.MEDR_SID;
        ROW_ACPPRODM.MEDR_STF_NO     := REC.MEDR_STF_NO;
        ROW_ACPPRODM.RSV_APLC_DT     := TRUNC(SYSDATE);

        ROW_ACPPRODM.PT_NO           :=  REC.PT_NO;
        ROW_ACPPRODM.FRVS_RMDE_TP_CD :=  REC.FRVS_RMDE_TP_CD;
        ROW_ACPPRODM.MED_DT          :=  REC.MED_DT;
        ROW_ACPPRODM.MED_RSV_DTM     :=  V_MED_RSV_DTM ;

        ROW_ACPPRODM.FSR_STF_NO      :=  IN_HIS_STF_NO;
        ROW_ACPPRODM.FSR_DTM         :=  SYSDATE;
        ROW_ACPPRODM.FSR_PRGM_NM     :=  IN_HIS_PRGM_NM;
        ROW_ACPPRODM.FSR_IP_ADDR     :=  IN_HIS_IP_ADDR;
        ROW_ACPPRODM.LSH_STF_NO      :=  IN_HIS_STF_NO;
        ROW_ACPPRODM.LSH_DTM         :=  SYSDATE;
        ROW_ACPPRODM.LSH_PRGM_NM     :=  IN_HIS_PRGM_NM;
        ROW_ACPPRODM.LSH_IP_ADDR     :=  IN_HIS_IP_ADDR;
        ROW_ACPPRODM.PME_CLS_CD      :=  REC.P_PME_CLS_CD;
        ROW_ACPPRODM.IORD_RSN_CD     :=  V_IORD_CD;
        BEGIN
            INSERT INTO ACPPRODM VALUES ROW_ACPPRODM;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20002, '중복에러 02');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20003, '에러 03'||'~~'||to_char(sqlerrm));
        END;

        BEGIN
            SELECT  A.*
              INTO  ROW_ACPPRORE
              FROM  ACPPRORE A
             WHERE  1=1
               AND RPY_PACT_ID =IN_PACT_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20003, '에러 04'||'~~'||to_char(sqlerrm));
        END;

        ROW_ACPPRORE.RPY_PACT_ID            :=  L_PACT_ID;
        ROW_ACPPRORE.APY_STR_DT             :=  REC.MED_DT       ;
        ROW_ACPPRORE.APY_END_DT             :=  REC.MED_DT       ;
        ROW_ACPPRORE.PT_NO                  :=  REC.PT_NO        ;
        ROW_ACPPRORE.FSR_STF_NO             :=  IN_HIS_STF_NO;
        ROW_ACPPRORE.FSR_DTM                :=  SYSDATE;
        ROW_ACPPRORE.FSR_PRGM_NM            :=  IN_HIS_PRGM_NM;
        ROW_ACPPRORE.FSR_IP_ADDR            :=  IN_HIS_IP_ADDR;
        ROW_ACPPRORE.LSH_STF_NO             :=  IN_HIS_STF_NO;
        ROW_ACPPRORE.LSH_DTM                :=  SYSDATE;
        ROW_ACPPRORE.LSH_PRGM_NM            :=  IN_HIS_PRGM_NM;
        ROW_ACPPRORE.LSH_IP_ADDR            :=  IN_HIS_IP_ADDR;
        ROW_ACPPRORE.PME_CLS_CD             :=  REC.P_PME_CLS_CD;
        BEGIN
            INSERT INTO ACPPRORE VALUES ROW_ACPPRORE;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20004, '중복에러02');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, '에러03'||'~~'||to_char(sqlerrm));
        END;

        BEGIN
          UPDATE XBIL.TEMPPTRSV
             SET RPY_PACT_ID   = ''
               , NEED_OTPT_RSV = DECODE(PACT_TP_CD,'I','N','')
           WHERE PT_NO         = REC.PT_NO
             AND (  (PACT_TP_CD    = 'I' AND NEED_OTPT_RSV ='Y'));
        END;

        BEGIN
          UPDATE XBIL.TEMPPTRSV
             SET RPY_PACT_ID   = L_PACT_ID
           WHERE PT_NO         = REC.PT_NO
             AND PACT_TP_CD    = 'O';
        END;
    END LOOP;
END;
