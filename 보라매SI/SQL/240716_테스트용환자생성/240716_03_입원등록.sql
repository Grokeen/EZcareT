DECLARE
   L_WD_DEPT_CD       ACPPERMM.WD_DEPT_CD%TYPE;
   L_PRM_NO           ACPPERMM.PRM_NO%TYPE;
   L_BED_NO           ACPPERMM.BED_NO%TYPE;
   L_PRM_GRD_CD       ACPPERMM.PRM_GRD_CD%TYPE;
   L_PRM_TP_CD        ACPPERMM.PRM_TP_CD%TYPE;


   V_ACPPRAAM         ACPPRAAM%ROWTYPE;
   V_ACPPRIRE         ACPPRIRE%ROWTYPE;
   V_ACPPRTSD         ACPPRTSD%ROWTYPE;
   V_ACPPRARD         ACPPRARD%ROWTYPE;

   --입원예약정보 존재여부 체크
   V_RARD_FOUND       VARCHAR2(1)  :='Y';
   --의사사번 존재여부 체크
   V_DR_YN            VARCHAR2(1)  :='N';
   L_PACT_ID          VARCHAR2(30) := NULL;
   ---------------
   --시스템관련 정보
   ---------------
   IN_HIS_STF_NO   PCTPCPAM.FSR_STF_NO%TYPE               :='C0ADM'; -- 41최초등록직원번호
   IN_HIS_PRGM_NM  PCTPCPAM.FSR_PRGM_NM%TYPE              :='GOLDEN-SDM'; -- 42최초등록프로그램명
   IN_HIS_IP_ADDR  PCTPCPAM.FSR_IP_ADDR%TYPE              :='1.1.1.1'; -- 43최초등록IP주소

   --식이발행코드
   V_ML_ORD_CD     ACPPRARD.ML_ORD_CD%TYPE;

   IO_ERRYN          VARCHAR2(1)   :='N';
   IO_ERRMSG         VARCHAR2(4000);
BEGIN
    FOR REC IN(SELECT PT_NO                                         AS PT_NO
                    , DR_STF_NO                                     AS ADS_STF_NO
                    , XCOM.FT_CNL_SELSTFINFO('1',DR_STF_NO, '')     AS ADS_STF_SID
                    , MED_DEPT_CD                                   AS MED_DEPT_CD
                    , SEX                                           AS SEX_TP_CD
                    , MED_ADS_DT                                    AS ADS_DT
                    , WD_DEPT_CD                                    AS WD_DEPT_CD
                    , PME_CLS_CD                                    AS PME_CLS_CD
                    , PSE_CLS_CD                                    AS PSE_CLS_CD
                    , ADIS_EXIST_YN                                 AS ADIS_EXIST_YN
                    , DECODE(PSE_CLS_CD,'193','Y','N')              AS CANCER_YN
                 FROM TEMPPTRSV
                WHERE PACT_TP_CD = 'I'
                  AND RPY_PACT_ID IS NULL
        )
    LOOP
        /***********************************
        * 의사 사번 체크 존재여부 체크
        ************************************/
        BEGIN
            SELECT 'Y'
              INTO V_DR_YN
              FROM ACDPCDRD A
                 , CNLRRUSD B
             WHERE A.DR_STF_NO   = REC.ADS_STF_NO
               AND A.MED_DEPT_CD = REC.MED_DEPT_CD
               AND A.DR_SID      = B.SID
               AND A.DR_STF_NO   = B.STF_NO
               AND B.USE_GRP_CD  ='DO'
               AND NVL(B.RTRM_DT, TRUNC(SYSDATE)+1) > TRUNC(SYSDATE);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_DR_YN := 'N';
            WHEN OTHERS THEN
                V_DR_YN := 'N';
        END;

        IF V_DR_YN = 'N' THEN
            RAISE_APPLICATION_ERROR(-20001, '의사사번이 존재하지 않습니다.  DR_STF_NO : ' || REC.ADS_STF_NO );
            ROLLBACK;
        END IF;


       /***********************************
        * 입원 예약내역 존재여부 체크
        ***********************************/
        BEGIN
            SELECT *
              INTO V_ACPPRARD
              FROM ACPPRARD
             WHERE PT_NO       = REC.PT_NO
               AND ADS_EXPT_DT = REC.ADS_DT
               AND CNCL_DTM IS NULL;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_RARD_FOUND := 'N';
        END;

        /**********************************
        * 가용 가능 병실 체크
        ***********************************/
        BEGIN
            SELECT WD_DEPT_CD
                 , PRM_NO
                 , BED_NO
                 , PRM_GRD_CD
                 , PRM_TP_CD
              INTO L_WD_DEPT_CD
                 , L_PRM_NO
                 , L_BED_NO
                 , L_PRM_GRD_CD
                 , L_PRM_TP_CD
              FROM ACPPERMM
             WHERE SIHS_PT_CNT = 0
               AND APY_END_DT > SYSDATE
               AND WD_DEPT_CD  = REC.WD_DEPT_CD
               AND (SEX_TP_CD = REC.SEX_TP_CD OR SEX_TP_CD = 'U')
               AND ROWNUM= 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20001, '가용가능한 병실이 없습니다!  WD_DEPT_CD : ' || REC.WD_DEPT_CD);
                ROLLBACK;
        END;

        /**********************************
        * 식이구분 조회
        ***********************************/
        BEGIN
            SELECT DECODE(V_ACPPRARD.ML_ORD_CD,'9','','3')
              INTO V_ML_ORD_CD
              FROM DUAL;
        END;

        /********************************************************************************
        * 입원지시(입원예약정보)가 있고 입원예약정보 기준을 생성할 경우(ADIS_EXIST_YN ='Y')
        * V_ACPPRARD의 예약정보를 COPY하여 환자를 입원시킨다.
        *********************************************************************************
        * 입원지시(입원예약정보)가 없고 입원예약정보 기준으로 생성하지 않을 경우(ADIS_EXIST_YN ='N')
        * TEMPPTRSV의 정보들을 기준으로 하여 환자를 입원시킨다.
        *********************************************************************************/
        IF V_RARD_FOUND = 'Y' AND NVL(REC.ADIS_EXIST_YN,'*') ='Y' THEN
            BEGIN
                XBIL.PC_ACP_ACPPRAAM_INSERT ( '7'                                                                                                         --001.병원구분코드 (진료과 병원구분)
                                              , V_ACPPRARD.PT_NO                                                                                           --002.환자번호
                                              , V_ACPPRARD.ADS_EXPT_DT                                                                                     --003.입원일자
                                              , TO_DATE(TO_CHAR(V_ACPPRARD.ADS_EXPT_DT,'YYYYMMDD')||TO_CHAR(SYSDATE,'HH24MISS'),'YYYYMMDDHH24MISS')        --004.입원일시
                                              , V_ACPPRARD.MED_DEPT_CD                                                                                     --005.진료부서코드
                                              , L_WD_DEPT_CD                                                                                               --006.병동부서코드
                                              , L_PRM_NO                                                                                                   --007.병실번호
                                              , L_BED_NO                                                                                                   --008.병상번호
                                              , L_WD_DEPT_CD                                                                                               --009.현위치병동부서코드
                                              , L_PRM_NO                                                                                                   --010.현위치병실번호
                                              , L_BED_NO                                                                                                   --011.현위치병상번호
                                              , ''                                                                                                         --012.이중방병동부서코드
                                              , ''                                                                                                         --013.이중방병실번호
                                              , ''                                                                                                         --014.이중방병상번호
                                              ,L_PRM_GRD_CD                                                                                                --015.병실등급코드
                                              ,L_PRM_TP_CD                                                                                                 --016.병실구분코드
                                              ,''                                                                                                          --017.자격확인구분코드
                                              ,'1'                                                                                                         --018.입원경로구분코드
                                              ,''                                                                                                          --020.응급실도착일시
                                              ,''                                                                                                          --021.응급원무접수ID
                                              ,V_ACPPRARD.ADIS_MEDR_STF_NO                                                                                 --022.입원지시진료의직원번호 APIPLIST.INDDR /APIPRSVT.ORDDR
                                              ,V_ACPPRARD.ADIS_MEDR_SID                                                                                    --023.입원지시진료의직원식별ID
                                              ,''                                                                                                          --024.선택의직원번호 APIPLIST.SPCDR
                                              ,''                                                                                                          --025.선택의직원식별ID
                                              ,REC.ADS_STF_NO                                                                                              --026.비선택의직원번호 APIPLIST.SPCDR2
                                              ,REC.ADS_STF_SID                                                                                             --027.비선택의직원식별ID
                                              ,V_ACPPRARD.ICD10_CD                                                                                         --028.ICD10코드
                                              ,V_ACPPRARD.ML_ORD_CD                                                                                        --029.식사처방코드
                                              ,V_ML_ORD_CD                                                                                                 --030.끼니구분코드
                                              ,''                                                                                                          --031.엄마환자번호
                                              ,''                                                                                                          --032.보호자유무
                                              ,'3'                                                                                                         --033.예상재원일수
                                              ,''                                                                                                          --034.퇴원지시일시
                                              ,''                                                                                                          --035.퇴원예정일자
                                              ,''                                                                                                          --036.퇴원일시
                                              ,''                                                                                                          --037.환자퇴실상태코드
                                              ,''                                                                                                          --038.퇴원진료결과구분코드
                                              ,''                                                                                                          --039.퇴원약일수
                                              ,''                                                                                                          --040.퇴원지시확정여부
                                              ,''                                                                                                          --041.추가처방유무
                                              ,'N'                                                                                                         --042.사전심사구분코드
                                              ,''                                                                                                          --043.특이사항내용
                                              ,''                                                                                                          --044.비선택사유코드
                                              ,'3'                                                                                                         --045.도착경로구분코드
                                              ,''                                                                                                          --046.임상연구번호
                                              ,1                                                                                                           --047.수납순번
                                              ,''                                                                                                          --048.진료비계산일자
                                              ,'N'                                                                                                         --049.재난여부
                                              ,''                                                                                                          --050.사전심사심사직원번호
                                              ,''                                                                                                          --051.실제심사직원번호
                                              ,''                                                                                                          --052.중간청구일자
                                              ,''                                                                                                          --053.청구상태코드
                                              ,''                                                                                                          --054.퇴원수납상태코드
                                              ,NULL                                                                                                        --055.변경순번
                                              ,''                                                                                                          --056.사망일시
                                              ,''                                                                                                          --057.부진료부서코드
                                              ,''                                                                                                          --058.입원번호
                                              ,'N'                                                                                                         --059.출력구분여부
                                              ,NULL                                                                                                        --060.출력일시
                                              ,NULL                                                                                                        --061.출력직원번호
                                              ,NULL                                                                                                        --062.신생아명세서분리여부
                                              ,NULL                                                                                                        --063.일괄작업용순번
                                              ,'N'                                                                                                         --064.입원치환여부
                                              ,'N'                                                                                                         --065.입원이후치환여부
                                              ,''                                                                                                          --066.진료결과내용
                                              ,NULL                                                                                                        --067.가퇴원일시
                                              ,''                                                                                                          --068.당일퇴원취소입력직원번호
                                              ,'N'                                                                                                         --069.입원료50%미가산여부
                                              ,''                                                                                                          --070.접수취소일시
                                              ,''                                                                                                          --071.접수취소입력직원번호
                                              ,1                                                                                                           --072.수납유형순번
                                              ,REC.PME_CLS_CD                                                                                              --073.환자급종유형코드
                                              ,REC.PSE_CLS_CD                                                                                              --074.환자보조급종유형코드
                                              ,NULL                                                                                                        --075.계약기관순번
                                              ,''                                                                                                          --076.계약기관코드
                                              ,''                                                                                                          --077.숙박검진장소코드
                                              ,''                                                                                                          --078.임상학술연구여부
                                              ,''                                                                                                          --079.임상제1상여부
                                              ,''                                                                                                          --080.응급전문의직원번호
                                              ,''                                                                                                          --081.중증응급질환우선순위코드
                                              ,''                                                                                                          --082.중증응급질환등록일자
                                              ,''                                                                                                          --083.중증응급질환수정일자
                                              ,''                                                                                                         --084.중증응급질환작업직원번호
                                              ,''                                                                                                         --085.이전중증응급질환우선순위코드
                                              ,'N'                                                                                                        --086.DRG 적용여부
                                              ,REC.CANCER_YN                                                                                            --087.입원지시중증여부
                                              ,'N'                                                                                                        --088.입원지시희귀여부
                                              ,'N'                                                                                                        --089.입원지시결핵여부
                                              ,'03'                                                                                                       --090.입원예약구분코드
                                              ,IN_HIS_STF_NO                                                                                              --091.최종변경직원번호
                                              ,IN_HIS_PRGM_NM                                                                                             --092.최종변경프로그램명
                                              ,IN_HIS_IP_ADDR                                                                                             --093.최종변경IP주소
                                              ,'N'                                                                                                        --094.입원 비공개 사실여부
                                              ,''                                                                                                         --095.입원 비공개 사실여부 요청자
                                              ,''                                                                                                         --096.정신과가족관계증명서여부
                                              ,''                                                                                                         --097.정신과보호의무자1확인여부
                                              ,''                                                                                                         --098.정신과보호의무자2확인여부
                                              ,'N'                                                                                                        --099.가입원여부
                                              ,IO_ERRYN                                                                                                  --113.ERROR Y/N
                                              ,IO_ERRMSG                                                                                                 --114.MESSAGE
                                              ) ;
            END;
        ELSIF  V_RARD_FOUND = 'N' AND NVL(REC.ADIS_EXIST_YN,'*') = 'N' THEN
            BEGIN
                XBIL.PC_ACP_ACPPRAAM_INSERT ( '7'                                                                                                         --001.병원구분코드 (진료과 병원구분)
                                             , REC.PT_NO                                                                                           --002.환자번호
                                             , REC.ADS_DT                                                                                        --003.입원일자
                                             , TO_DATE(TO_CHAR(REC.ADS_DT,'YYYYMMDD')||TO_CHAR(SYSDATE,'HH24MISS'),'YYYYMMDDHH24MISS')        --004.입원일시
                                             , REC.MED_DEPT_CD                                                                                     --005.진료부서코드
                                             , L_WD_DEPT_CD                                                                                               --006.병동부서코드
                                             , L_PRM_NO                                                                                                   --007.병실번호
                                             , L_BED_NO                                                                                                   --008.병상번호
                                             , L_WD_DEPT_CD                                                                                               --009.현위치병동부서코드
                                             , L_PRM_NO                                                                                                   --010.현위치병실번호
                                             , L_BED_NO                                                                                                   --011.현위치병상번호
                                             , ''                                                                                                         --012.이중방병동부서코드
                                             , ''                                                                                                         --013.이중방병실번호
                                             , ''                                                                                                         --014.이중방병상번호
                                             , L_PRM_GRD_CD                                                                                                --015.병실등급코드
                                             , L_PRM_TP_CD                                                                                                 --016.병실구분코드
                                             ,''                                                                                                          --017.자격확인구분코드
                                             ,'1'                                                                                                         --018.입원경로구분코드
                                             ,''                                                                                                          --020.응급실도착일시
                                             ,''                                                                                                          --021.응급원무접수ID
                                             ,REC.ADS_STF_NO                                                                                              --022.입원지시진료의직원번호 APIPLIST.INDDR /APIPRSVT.ORDDR
                                             ,REC.ADS_STF_SID                                                                                             --023.입원지시진료의직원식별ID
                                             ,''                                                                                                          --024.선택의직원번호 APIPLIST.SPCDR
                                             ,''                                                                                                          --025.선택의직원식별ID
                                             ,REC.ADS_STF_NO                                                                                              --026.비선택의직원번호 APIPLIST.SPCDR2
                                             ,REC.ADS_STF_SID                                                                                             --027.비선택의직원식별ID
                                             ,''                                                                                                          --028.ICD10코드
                                             ,'D01ZZ0100'                                                                                                 --029.식사처방코드
                                             ,'1'                                                                                                         --030.끼니구분코드
                                             ,''                                                                                                          --031.엄마환자번호
                                             ,''                                                                                                          --032.보호자유무
                                             ,'3'                                                                                                         --033.예상재원일수
                                             ,''                                                                                                          --034.퇴원지시일시
                                             ,''                                                                                                          --035.퇴원예정일자
                                             ,''                                                                                                          --036.퇴원일시
                                             ,''                                                                                                          --037.환자퇴실상태코드
                                             ,''                                                                                                          --038.퇴원진료결과구분코드
                                             ,''                                                                                                          --039.퇴원약일수
                                             ,''                                                                                                          --040.퇴원지시확정여부
                                             ,''                                                                                                          --041.추가처방유무
                                             ,'N'                                                                                                         --042.사전심사구분코드
                                             ,''                                                                                                          --043.특이사항내용
                                             ,''                                                                                                          --044.비선택사유코드
                                             ,'3'                                                                                                         --045.도착경로구분코드
                                             ,''                                                                                                          --046.임상연구번호
                                             ,1                                                                                                           --047.수납순번
                                             ,''                                                                                                          --048.진료비계산일자
                                             ,'N'                                                                                                         --049.재난여부
                                             ,''                                                                                                          --050.사전심사심사직원번호
                                             ,''                                                                                                          --051.실제심사직원번호
                                             ,''                                                                                                          --052.중간청구일자
                                             ,''                                                                                                          --053.청구상태코드
                                             ,''                                                                                                          --054.퇴원수납상태코드
                                             ,NULL                                                                                                        --055.변경순번
                                             ,''                                                                                                          --056.사망일시
                                             ,''                                                                                                          --057.부진료부서코드
                                             ,''                                                                                                          --058.입원번호
                                             ,'N'                                                                                                         --059.출력구분여부
                                             ,NULL                                                                                                        --060.출력일시
                                             ,NULL                                                                                                        --061.출력직원번호
                                             ,NULL                                                                                                        --062.신생아명세서분리여부
                                             ,NULL                                                                                                        --063.일괄작업용순번
                                             ,'N'                                                                                                         --064.입원치환여부
                                             ,'N'                                                                                                         --065.입원이후치환여부
                                             ,''                                                                                                          --066.진료결과내용
                                             ,NULL                                                                                                        --067.가퇴원일시
                                             ,''                                                                                                          --068.당일퇴원취소입력직원번호
                                             ,'N'                                                                                                         --069.입원료50%미가산여부
                                             ,''                                                                                                          --070.접수취소일시
                                             ,''                                                                                                          --071.접수취소입력직원번호
                                             ,1                                                                                                           --072.수납유형순번
                                             ,REC.PME_CLS_CD                                                                                              --073.환자급종유형코드
                                             ,REC.PSE_CLS_CD                                                                                              --074.환자보조급종유형코드
                                             ,NULL                                                                                                        --075.계약기관순번
                                             ,''                                                                                                          --076.계약기관코드
                                             ,''                                                                                                          --077.숙박검진장소코드
                                             ,''                                                                                                          --078.임상학술연구여부
                                             ,''                                                                                                          --079.임상제1상여부
                                             ,''                                                                                                          --080.응급전문의직원번호
                                             ,''                                                                                                          --081.중증응급질환우선순위코드
                                             ,''                                                                                                          --082.중증응급질환등록일자
                                             ,''                                                                                                          --083.중증응급질환수정일자
                                             ,''                                                                                                         --084.중증응급질환작업직원번호
                                             ,''                                                                                                         --085.이전중증응급질환우선순위코드
                                             ,'N'                                                                                                        --086.DRG 적용여부
                                             ,REC.CANCER_YN                                                                                         --087.입원지시중증여부
                                             ,'N'                                                                                                        --088.입원지시희귀여부
                                             ,'N'                                                                                                        --089.입원지시결핵여부
                                             ,'03'                                                                                                       --090.입원예약구분코드
                                             ,IN_HIS_STF_NO                                                                                              --091.최종변경직원번호
                                             ,IN_HIS_PRGM_NM                                                                                             --092.최종변경프로그램명
                                             ,IN_HIS_IP_ADDR                                                                                             --093.최종변경IP주소
                                             ,'N'                                                                                                        --094.입원 비공개 사실여부
                                             ,''                                                                                                         --095.입원 비공개 사실여부 요청자
                                             ,''                                                                                                         --096.정신과가족관계증명서여부
                                             ,''                                                                                                         --097.정신과보호의무자1확인여부
                                             ,''                                                                                                         --098.정신과보호의무자2확인여부
                                             ,'N'                                                                                                        --099.가입원여부
                                             ,IO_ERRYN                                                                                                  --113.ERROR Y/N
                                             ,IO_ERRMSG                                                                                                 --114.MESSAGE
                                             ) ;

            END;
        ELSE
           IO_ERRYN :='Y';
           IO_ERRMSG :='데이터를 찾을 수가 없습니다. PT_NO : '||REC.PT_NO;
        END IF;
        IF NVL(IO_ERRYN ,'N') ='Y' THEN
             RAISE_APPLICATION_ERROR(-20001, '입원수진 생성중 에러 : PT_NO '||REC.PT_NO||' MSG : '|| IO_ERRMSG);
             ROLLBACK;
        END IF;

        /**********************************
        * 수진이 정상적으로 생성되었는지 체크
        ***********************************/
        BEGIN
            SELECT PACT_ID
              INTO L_PACT_ID
              FROM ACPPRAAM A
             WHERE 1=1
              AND A.PT_NO  = REC.PT_NO
              AND A.ADS_DT = REC.ADS_DT
              AND A.APCN_DTM IS NULL;
        EXCEPTION
           WHEN OTHERS THEN
               RAISE_APPLICATION_ERROR(-20001, '생성된 수진 조회 에러 PT_NO : '|| REC.PT_NO);
        END;

        /**********************************
        * 입원수진에 주치의 설정
        ***********************************/
        BEGIN
            UPDATE ACPPRAAM
               SET ANDR_SID      = REC.ADS_STF_SID
                 , ANDR_STF_NO   = REC.ADS_STF_NO
             WHERE PACT_ID       = L_PACT_ID
               AND APCN_DTM IS NULL;
        EXCEPTION
           WHEN OTHERS THEN
               RAISE_APPLICATION_ERROR(-20001, '주치의정보 등록중 에러 PT_NO : '|| REC.PT_NO);
        END;

         BEGIN
            UPDATE ACPPRTSD
               SET ANDR_SID      = REC.ADS_STF_SID
                 , ANDR_STF_NO   = REC.ADS_STF_NO
             WHERE RPY_PACT_ID   = L_PACT_ID
               AND APCN_DTM   IS NULL;
        EXCEPTION
           WHEN OTHERS THEN
               RAISE_APPLICATION_ERROR(-20001, '주치의정보 등록중 에러 PT_NO : '|| REC.PT_NO);
        END;

        /**********************************
        * TEMPPTRSV에 PACT_ID 저장
        ***********************************/
        BEGIN
          UPDATE XBIL.TEMPPTRSV
             SET RPY_PACT_ID   = L_PACT_ID
               , NEED_OTPT_RSV = ''
           WHERE PT_NO         = REC.PT_NO
             AND PACT_TP_CD    = 'I' ;
        END;
    END LOOP;
END;
