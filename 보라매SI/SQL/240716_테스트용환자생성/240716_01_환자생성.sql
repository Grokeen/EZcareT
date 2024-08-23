DECLARE
    -------------------------
    -- 여러명 세팅시 아래 값 변경
    -------------------------
    V_LOOP_CNT                 NUMBER(3)           := 12 ;        --생성할 환자수

    -------------------------
    -- 세팅시 필요한 변수 선언
    -------------------------
    V_YYYY                     VARCHAR2(4)         :='';
    V_FAMILY_NM_CNT            NUMBER(3)           := 0;
    V_FAMILY_NM                VARCHAR2(5)         :='';

    ----------------------
    -- 환자정보 파라메터 세팅
    ----------------------
    IN_GUBN                    VARCHAR2(1)                            :='I'; -- 00. 구분('I'-INSERT ,'U'-UPDATE, 'S'-수탁)
    IN_HSP_TP_CD               VARCHAR2(1)                            :='1'; -- 02. 병원구분코드
    IN_PT_NO                   PCTPCPAM.PT_NO%TYPE                    :=NULL; -- 03. 환자번호
    IN_IMGN_PT_YN              PCTPCPAM.IMGN_PT_YN%TYPE               :='N'; -- 04. 가상환자여부
    IN_PT_RRN                  VARCHAR2(13)                           :=NULL; -- 05. 환자주민등록번호
    IN_PT_NM                   PCTPCPAM.PT_NM%TYPE                    :=NULL; -- 06. 환자명
    IN_SEX_TP_CD               PCTPCPAM.SEX_TP_CD%TYPE                :=NULL; -- 07. 성별구분코드
    IN_PT_BRDY_DT              PCTPCPAM.PT_BRDY_DT%TYPE               :=NULL; -- 08. 환자생일일자
    IN_LNCL_BRDY_DT            PCTPCPAM.LNCL_BRDY_DT%TYPE             :=NULL; -- 09음력생일일자
    IN_IMGN_PT_CTG_CD          PCTPCPAM.IMGN_PT_CTG_CD%TYPE           :=NULL; -- 10가상환자분류코드
    IN_PME_CLS_CD              PCTPCPAM.PME_CLS_CD%TYPE               :='BB'; -- 11환자급종유형코드
    IN_PSE_CLS_CD              PCTPCPAM.PSE_CLS_CD%TYPE               :='000'; -- 12환자보조급종유형코드
    IN_CORG_CD                 PCTPCPAM.CORG_CD%TYPE                  :=NULL; -- 13계약기관코드
    IN_ADS_NOTM                PCTPCPAM.ADS_NOTM%TYPE                 :=NULL; -- 14입원횟수
    IN_LST_HME_DT              PCTPCPAM.LST_HME_DT%TYPE               :=NULL; -- 15최종수진일자
    IN_ABOB_TP_CD              PCTPCPAM.ABOB_TP_CD%TYPE               :=NULL; -- 16ABO식혈액형구분코드
    IN_RHB_TP_CD               PCTPCPAM.RHB_TP_CD%TYPE                :=NULL; -- 17RH식혈액형구분코드
    IN_BBNK_BLTYP_KND_CD       PCTPCPAM.BBNK_BLTYP_KND_CD%TYPE        :=NULL; -- 18혈액은행혈액형종류코드
    IN_BLTYP_EXM_DT            PCTPCPAM.BLTYP_EXM_DT%TYPE             :=NULL; -- 19혈액형검사일자
    IN_PACT_TP_CD              PCTPCPAM.PACT_TP_CD%TYPE               :=NULL; -- 20원무접수구분코드
    IN_MRPMC_USE_IMPB_YN       PCTPCPAM.MRPMC_USE_IMPB_YN%TYPE        :=NULL; -- 21무인수납기사용불가여부
    IN_ENG_PT_NM               PCTPCPAM.ENG_PT_NM%TYPE                :=NULL; -- 22영문환자명
    IN_OOC_NTN_CD              PCTPCPAM.OOC_NTN_CD%TYPE               :='000'; -- 23본국국가코드
    IN_CTZN_REG_EXCP_YN        PCTPCPAM.CTZN_REG_EXCP_YN%TYPE         :='Y'; -- 24주민등록예외여부
    IN_DTH_DTM                 PCTPCPAM.DTH_DTM%TYPE                  :=NULL; -- 29사망일시
    IN_SNDP_PT_NM              PCTPCPAM.SNDP_PT_NM%TYPE               :=NULL; -- 30동명이인환자명
    IN_PSPT_NO                 PCTPCPAM.PSPT_NO%TYPE                  :=NULL; -- 31여권번호
    IN_PSPT_EXPR_DT            PCTPCPAM.PSPT_EXPR_DT%TYPE             :=NULL; -- 32여권만기일자
    IN_KKNF_USE_YN             PCTPCPAM.KKNF_USE_YN%TYPE              :=NULL; -- 34감마나이프사용여부
    IN_CHL_OTPT_TRK_YN         PCTPCPAM.CHL_OTPT_TRK_YN%TYPE          :=NULL; -- 35소아외래추적여부
    IN_SASS_MBR_CORG_REG_TP_CD PCTPCPAM.SASS_MBR_CORG_REG_TP_CD%TYPE  :=NULL; -- 36후원회회원계약기관등록구분코드
    IN_NTNL_ABNR_CFMT_YN       PCTPCPAM.NTNL_ABNR_CFMT_YN%TYPE        :=NULL; -- 37국적이상확인여부
    IN_BOBD_PT_NO              PCTPCPAM.BOBD_PT_NO%TYPE               :=NULL; -- 38합본이전환자번호
    IN_BIND_DTM                PCTPCPAM.BIND_DTM%TYPE                 :=NULL; -- 39합본일시
    IN_BIND_STF_NO             PCTPCPAM.BIND_STF_NO%TYPE              :=NULL; -- 40합본직원번호
    IN_HIS_STF_NO              PCTPCPAM.FSR_STF_NO%TYPE               :='C0ADM'; -- 41최초등록직원번호
    IN_HIS_PRGM_NM             PCTPCPAM.FSR_PRGM_NM%TYPE              :='GOLDEN-SDM'; -- 42최초등록프로그램명
    IN_HIS_IP_ADDR             PCTPCPAM.FSR_IP_ADDR%TYPE              :='1.1.1.1'; -- 43최초등록IP주소
    IN_EXPAT_YN                PCTPCPAM.EXPAT_YN%TYPE                 :=NULL; -- 44재외국민여부
    IN_HPCD_AUTO_SETL_YN       PCTPCPAM.HPCD_AUTO_SETL_YN%TYPE        :=NULL; -- 45하이패스카드자동결제여부
    IO_ERRYN                   VARCHAR2(1)                            :='N';
    IO_PT_NO                   PCTPCPAM.PT_NO%TYPE                    :=NULL;
    IO_ERRMSG                  VARCHAR2(4000)                         :='';

    ----------------------
    -- 연락처정보 파라메터 세팅
    ----------------------
    IN_PT_REL_TP_CD     PCTPCPTD.PT_REL_TP_CD%TYPE     := '0'; -- 02. 환자관계구분코드(203)
    IN_CTAD_TP_SEQ      PCTPCPTD.CTAD_TP_SEQ%TYPE      := 1; -- 04. 연락처구분순번(U,D는 필수입력,I는 NULL)
    IN_REG_DEPT_CD      PCTPCPTD.REG_DEPT_CD%TYPE      := NULL; -- 05. 등록부서코드
    IN_SCRN_PRNT_RNK    PCTPCPTD.SCRN_PRNT_RNK%TYPE    := 1; -- 06. 화면출력순위
    IN_PTCP_NM          PCTPCPTD.PTCP_NM%TYPE          := NULL; -- 07. 관계자명
    IN_ADDR_VER_CTRA_CD PCTPCPTD.ADDR_VER_CTRA_CD%TYPE := NULL; -- 08. 주소버전기준코드
    IN_POST_NO          PCTPCPTD.POST_NO%TYPE          := '07061'; -- 09. 우편번호
    IN_POST_NO_SEQ      PCTPCPTD.POST_NO_SEQ%TYPE      := 1; -- 10. 우편번호순번
    IN_BSC_ADDR         PCTPCPTD.BSC_ADDR%TYPE         := '서울특별시 동작구 보라매로5길 20'; -- 11. 기본주소
    IN_DTL_ADDR         PCTPCPTD.DTL_ADDR%TYPE         := '보라매병원'; -- 12. 상세주소
    IN_STTT_DONG_CD     PCTPCPTD.STTT_DONG_CD%TYPE     := NULL; -- 13. 법정동코드
    IN_MTN_YN           PCTPCPTD.MTN_YN%TYPE           := NULL; -- 14. 산여부
    IN_MAIN_LTNR        PCTPCPTD.MAIN_LTNR%TYPE        := NULL; -- 15. 지번본번
    IN_SUB_LTNR         PCTPCPTD.SUB_LTNR%TYPE         := NULL; -- 16. 지번부번
    IN_BLDG_MGMT_NO     PCTPCPTD.BLDG_MGMT_NO%TYPE     := NULL; -- 17. 건물관리번호
    IN_EMAL_ADDR        PCTPCPTD.EMAL_ADDR%TYPE        := NULL; -- 18. 이메일주소
    IN_ENG_ADDR         PCTPCPTD.ENG_ADDR%TYPE         := NULL; -- 19. 영문주소
    IN_TEL_NO           PCTPCPTD.TEL_NO%TYPE           := '01011111111'; -- 20. 전화번호
    IN_NEW_PT_REL_TP_CD PCTPCPTD.PT_REL_TP_CD%TYPE     := '0'; -- 21. 신 환자관계구분코드(203)
    IN_NEW_CTAD_TP_CD   PCTPCPTD.CTAD_TP_CD%TYPE       := NULL; -- 22. 신 연락처구분코드 ('23A')
    IN_NEW_CTAD_TP_SEQ  PCTPCPTD.CTAD_TP_SEQ%TYPE      := 1; -- 23. 신 연락처구분순번(U,D는 필수입력,I


    V_PCTPCPAM          PCTPCPAM%ROWTYPE;


    IN_INS_END_DT          ACPPRPID.INS_END_DT       %TYPE    := TO_DATE('99991231','YYYYMMDD');   -- 보험종료일자
    V_POB_NO               ACPPRPID.POB_NO           %TYPE    := '00000000';   -- 사업장번호
    IN_HLTH_INSC_NO        ACPPRPID.HLTH_INSC_NO     %TYPE    := '11111111111';   -- 건강보험증번호
    IN_MDC_PBDN_TP_CD      ACPPRPID.MDC_PBDN_TP_CD   %TYPE    := NULL;   -- 의료급여본인부담구분코드
    IN_DPFC_YN             ACPPRPID.DPFC_YN          %TYPE    := 'N';   -- 출국여부
    IN_DSPP_REG_DT         ACPPRPID.DSPP_REG_DT      %TYPE    := NULL;   -- 장애인등록일자
    IN_PCOR_INS_QF_TP_CD   ACPPRPID.PCOR_INS_QF_TP_CD%TYPE    := NULL;   -- 공단보험자격구분코드
    IN_TH1_CHC_RCORG_NO    ACPPRPID.TH1_CHC_RCORG_NO %TYPE    := NULL;   -- 1번째선택요양기관번호
    IN_TH2_CHC_RCORG_NO    ACPPRPID.TH2_CHC_RCORG_NO %TYPE    := NULL;   -- 2번째선택요양기관번호
    IN_TH3_CHC_RCORG_NO    ACPPRPID.TH3_CHC_RCORG_NO %TYPE    := NULL;   -- 3번째선택요양기관번호
    IN_TH4_CHC_RCORG_NO    ACPPRPID.TH4_CHC_RCORG_NO %TYPE    := NULL;   -- 4번째선택요양기관번호
    IN_TH1_CHC_RCORG_NM    ACPPRPID.TH1_CHC_RCORG_NM %TYPE    := NULL;   -- 1번째선택요양기관명
    IN_TH2_CHC_RCORG_NM    ACPPRPID.TH2_CHC_RCORG_NM %TYPE    := NULL;   -- 2번째선택요양기관명
    IN_TH3_CHC_RCORG_NM    ACPPRPID.TH3_CHC_RCORG_NM %TYPE    := NULL;   -- 3번째선택요양기관명
    IN_TH4_CHC_RCORG_NM    ACPPRPID.TH4_CHC_RCORG_NM %TYPE    := NULL;   -- 4번째선택요양기관명

BEGIN


    FOR REC IN(
              SELECT  ROWID
                    , PT_NM
                    , AGE
                    , SEX
                    , PME_CLS_CD
                    , PSE_CLS_CD
                FROM XBIL.TEMPPTRSV
               WHERE PT_NO IS NULL
    )LOOP
        IF NVL(REC.PT_NM,'*') = '*' OR NVL(REC.AGE,'*') = '*' OR NVL(REC.SEX,'*') = '*' OR NVL(REC.PME_CLS_CD,'*') = '*' OR  NVL(REC.PSE_CLS_CD,'*') = '*' THEN
            RAISE_APPLICATION_ERROR(-20003, '환자생성중 에러 : 필수값에  NULL이 있음.');
            ROLLBACK;
        END IF;

        ---------------------------------
        --LOOP 돌면서 초기화 해줘야 하는 값들
        ---------------------------------
        IN_PT_NO      := NULL;

        ----------------------------
        --랜덤으로 들어가야하는 값들 세팅
        ----------------------------

        IN_SEX_TP_CD  := TRIM(REC.SEX);
        V_YYYY        := TO_CHAR(TRUNC(SYSDATE)-(TO_NUMBER(REC.AGE)*365),'YYYY');
        IN_PT_RRN     := SUBSTR(TO_CHAR(V_YYYY), 3, 2) || '0101' || CASE WHEN IN_SEX_TP_CD = 'M' AND V_YYYY < 2000  THEN '1111111'
                                                                         WHEN IN_SEX_TP_CD = 'M' AND V_YYYY >= 2000 THEN '3333333'
                                                                         WHEN IN_SEX_TP_CD = 'F' AND V_YYYY < 2000  THEN '2222222'
                                                                         WHEN IN_SEX_TP_CD = 'F' AND V_YYYY >= 2000 THEN '4444444' ELSE '1111111' END;
        IN_PT_BRDY_DT := TO_DATE(TO_CHAR(V_YYYY) || '0101', 'YYYYMMDD' );
        IN_PT_NM      := REC.PT_NM;

        ------------------------
        -- 환자생성 프로시저 호출
        -----------------------
        BEGIN
            SELECT A.COMN_CD
              INTO IN_ABOB_TP_CD
              FROM ( SELECT *
                       FROM CCCCCSTE
                      WHERE COMN_GRP_CD= 'RP0002'
                      ORDER BY DBMS_RANDOM.RANDOM
                   ) A
             WHERE ROWNUM = 1;
        END;


        ------------------------
        -- 환자생성 프로시저 호출
        -----------------------
        BEGIN
            XBIL.PC_PCT_CREATE_PCTPCPAM ( IN_GUBN                    -- 00. 구분('I'-INSERT ,'U'-UPDATE, 'S'-수탁)
                                        , IN_HSP_TP_CD               -- 02. 병원구분코드
                                        , IN_PT_NO                   -- 03. 환자번호
                                        , IN_IMGN_PT_YN              -- 04. 가상환자여부
                                        , IN_PT_RRN                  -- 05. 환자주민등록번호
                                        , IN_PT_NM                   -- 06. 환자명
                                        , IN_SEX_TP_CD               -- 07. 성별구분코드
                                        , IN_PT_BRDY_DT              -- 08. 환자생일일자
                                        , IN_LNCL_BRDY_DT            -- 09음력생일일자
                                        , IN_IMGN_PT_CTG_CD          -- 10가상환자분류코드
                                        , IN_PME_CLS_CD              -- 11환자급종유형코드
                                        , IN_PSE_CLS_CD              -- 12환자보조급종유형코드
                                        , IN_CORG_CD                 -- 13계약기관코드
                                        , IN_ADS_NOTM                -- 14입원횟수
                                        , IN_LST_HME_DT              -- 15최종수진일자
                                        , IN_ABOB_TP_CD              -- 16ABO식혈액형구분코드
                                        , IN_RHB_TP_CD               -- 17RH식혈액형구분코드
                                        , IN_BBNK_BLTYP_KND_CD       -- 18혈액은행혈액형종류코드
                                        , IN_BLTYP_EXM_DT            -- 19혈액형검사일자
                                        , IN_PACT_TP_CD              -- 20원무접수구분코드
                                        , IN_MRPMC_USE_IMPB_YN       -- 21무인수납기사용불가여부
                                        , IN_ENG_PT_NM               -- 22영문환자명
                                        , IN_OOC_NTN_CD              -- 23본국국가코드
                                        , IN_CTZN_REG_EXCP_YN        -- 24주민등록예외여부
                                        , IN_DTH_DTM                 -- 29사망일시
                                        , IN_SNDP_PT_NM              -- 30동명이인환자명
                                        , IN_PSPT_NO                 -- 31여권번호
                                        , IN_PSPT_EXPR_DT            -- 32여권만기일자
                                        , IN_KKNF_USE_YN             -- 34감마나이프사용여부
                                        , IN_CHL_OTPT_TRK_YN         -- 35소아외래추적여부
                                        , IN_SASS_MBR_CORG_REG_TP_CD -- 36후원회회원계약기관등록구분코드
                                        , IN_NTNL_ABNR_CFMT_YN       -- 37국적이상확인여부
                                        , IN_BOBD_PT_NO              -- 38합본이전환자번호
                                        , IN_BIND_DTM                -- 39합본일시
                                        , IN_BIND_STF_NO             -- 40합본직원번호
                                        , IN_HIS_STF_NO              -- 41최초등록직원번호
                                        , IN_HIS_PRGM_NM             -- 42최초등록프로그램명
                                        , IN_HIS_IP_ADDR             -- 43최초등록IP주소
                                        , IN_EXPAT_YN                -- 44재외국민여부
                                        , IN_HPCD_AUTO_SETL_YN       -- 45하이패스카드자동결제여부
                                        , NULL                       -- 41. 주한미군ID
                                        , NULL                       -- 42. 외국인체류시작일자                 20240305 BRMH 성현석 추가
                                        , NULL                       -- 43. 외국인체류종료일자                 20240305 BRMH 성현석 추가
                                        , NULL                       -- 44. 외국인체류자격구분코드(PA21F)      20240305 BRMH 성현석 추가
                                        , NULL                       -- 45. 외국인비고                        20240305 BRMH 성현석 추가
                                        , NULL                       -- 46. 다시서기번호                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 47. 보건소관리번호                    20240305 BRMH 성현석 추가
                                        , NULL                       -- 48. 실제주민번호                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 49. 외국인상주구분코드(PA21G)          20240305 BRMH 성현석 추가
                                        , NULL                       -- 50. IN_DUMMY01                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 51. IN_DUMMY02                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 52. IN_DUMMY03                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 53. IN_DUMMY04                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 54. IN_DUMMY05                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 55. IN_DUMMY06                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 56. IN_DUMMY07                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 57. IN_DUMMY08                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 58. IN_DUMMY09                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 59. IN_DUMMY10                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 60. IN_DUMMY11                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 61. IN_DUMMY12                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 62. IN_DUMMY13                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 63. IN_DUMMY14                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 64. IN_DUMMY15                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 65. IN_DUMMY16                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 66. IN_DUMMY17                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 67. IN_DUMMY18                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 68. IN_DUMMY19                      20240305 BRMH 성현석 추가
                                        , NULL                       -- 69. IN_DUMMY20                      20240305 BRMH 성현석 추가
                                        , IO_ERRYN                   --
                                        , IO_PT_NO                   --
                                        , IO_ERRMSG                  --
                                        );
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, '환자생성 프로시저 호출 '||CHR(10)||TO_CHAR(SQLERRM));
        END;

        ----------
        -- 에러출력
        ----------
        IF IO_ERRYN = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20002, '환자생성 프로시저 호출 후 에러'||CHR(10)||IO_ERRMSG);
        END IF;

        -----------------------------
        -- 휴대전화번호생성 프로시저 호출
        -----------------------------
        BEGIN
            XBIL.PC_PCT_CREATE_PCTPCPTD_NEW ( IN_GUBN             => IN_GUBN               -- 00. 구분('I'-INSERT ,'U'-UPDATE, 'D'-UPDATE(사용일자종료처리))
                                             ,IN_PT_NO            => IO_PT_NO              -- 01. 환자번호
                                             ,IN_PT_REL_TP_CD     => IN_PT_REL_TP_CD       -- 02. 환자관계구분코드(203)
                                             ,IN_CTAD_TP_CD       => '01'                  -- 03. 연락처구분코드 ('23A')
                                             ,IN_CTAD_TP_SEQ      => IN_CTAD_TP_SEQ        -- 04. 연락처구분순번(U,D는 필수입력,I는 NULL)
                                             ,IN_REG_DEPT_CD      => IN_REG_DEPT_CD        -- 05. 등록부서코드
                                             ,IN_SCRN_PRNT_RNK    => IN_SCRN_PRNT_RNK      -- 06. 화면출력순위
                                             ,IN_PTCP_NM          => IN_PTCP_NM            -- 07. 관계자명
                                             ,IN_ADDR_VER_CTRA_CD => IN_ADDR_VER_CTRA_CD   -- 08. 주소버전기준코드
                                             ,IN_POST_NO          => NULL                  -- 09. 우편번호
                                             ,IN_POST_NO_SEQ      => NULL                  -- 10. 우편번호순번
                                             ,IN_BSC_ADDR         => NULL           -- 11. 기본주소
                                             ,IN_DTL_ADDR         => NULL           -- 12. 상세주소
                                             ,IN_STTT_DONG_CD     => NULL       -- 13. 법정동코드
                                             ,IN_MTN_YN           => NULL             -- 14. 산여부
                                             ,IN_MAIN_LTNR        => NULL          -- 15. 지번본번
                                             ,IN_SUB_LTNR         => NULL           -- 16. 지번부번
                                             ,IN_BLDG_MGMT_NO     => NULL       -- 17. 건물관리번호
                                             ,IN_EMAL_ADDR        => NULL          -- 18. 이메일주소
                                             ,IN_ENG_ADDR         => NULL           -- 19. 영문주소
                                             ,IN_TEL_NO           => IN_TEL_NO             -- 20. 전화번호
                                             ,IN_NEW_PT_REL_TP_CD => IN_NEW_PT_REL_TP_CD   -- 21. 신 환자관계구분코드(203)
                                             ,IN_NEW_CTAD_TP_CD   => '01'     -- 22. 신 연락처구분코드 ('23A')
                                             ,IN_NEW_CTAD_TP_SEQ  => IN_NEW_CTAD_TP_SEQ    -- 23. 신 연락처구분순번(U,D는 필수입력,I
                                             ,IN_LSH_STF_NO       => IN_HIS_STF_NO         -- 24. 최초등록직원번호, 최종변경직원번호
                                             ,IN_LSH_PRGM_NM      => IN_HIS_PRGM_NM        -- 25. 최초등록프로그램명, 최종변경프로그램명
                                             ,IN_LSH_IP_ADDR      => IN_HIS_IP_ADDR        -- 26. 최초등록IP주소, 최종변경IP주소
                                             ,IO_ERRYN            => IO_ERRYN              --
                                             ,IO_PT_NO            => IO_PT_NO              --
                                             ,IO_ERRMSG           => IO_ERRMSG             --
                                            );
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20003, '휴대전화번호생성 프로시저 호출 '||CHR(10)||TO_CHAR(SQLERRM));
        END;

        ----------
        -- 에러출력
        ----------
        IF IO_ERRYN = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20004, '휴대전화번호생성 프로시저 호출 후 에러'||CHR(10)||IO_ERRMSG);
        END IF;

        ------------------------
        -- 주소생성 프로시저 호출
        -----------------------
        BEGIN
            XBIL.PC_PCT_CREATE_PCTPCPTD_NEW ( IN_GUBN             => IN_GUBN               -- 00. 구분('I'-INSERT ,'U'-UPDATE, 'D'-UPDATE(사용일자종료처리))
                                             ,IN_PT_NO            => IO_PT_NO              -- 01. 환자번호
                                             ,IN_PT_REL_TP_CD     => IN_PT_REL_TP_CD       -- 02. 환자관계구분코드(203)
                                             ,IN_CTAD_TP_CD       => '51'         -- 03. 연락처구분코드 ('23A')
                                             ,IN_CTAD_TP_SEQ      => IN_CTAD_TP_SEQ        -- 04. 연락처구분순번(U,D는 필수입력,I는 NULL)
                                             ,IN_REG_DEPT_CD      => IN_REG_DEPT_CD        -- 05. 등록부서코드
                                             ,IN_SCRN_PRNT_RNK    => IN_SCRN_PRNT_RNK      -- 06. 화면출력순위
                                             ,IN_PTCP_NM          => IN_PTCP_NM            -- 07. 관계자명
                                             ,IN_ADDR_VER_CTRA_CD => IN_ADDR_VER_CTRA_CD   -- 08. 주소버전기준코드
                                             ,IN_POST_NO          => IN_POST_NO            -- 09. 우편번호
                                             ,IN_POST_NO_SEQ      => IN_POST_NO_SEQ        -- 10. 우편번호순번
                                             ,IN_BSC_ADDR         => IN_BSC_ADDR           -- 11. 기본주소
                                             ,IN_DTL_ADDR         => IN_DTL_ADDR           -- 12. 상세주소
                                             ,IN_STTT_DONG_CD     => IN_STTT_DONG_CD       -- 13. 법정동코드
                                             ,IN_MTN_YN           => IN_MTN_YN             -- 14. 산여부
                                             ,IN_MAIN_LTNR        => IN_MAIN_LTNR          -- 15. 지번본번
                                             ,IN_SUB_LTNR         => IN_SUB_LTNR           -- 16. 지번부번
                                             ,IN_BLDG_MGMT_NO     => IN_BLDG_MGMT_NO       -- 17. 건물관리번호
                                             ,IN_EMAL_ADDR        => IN_EMAL_ADDR          -- 18. 이메일주소
                                             ,IN_ENG_ADDR         => IN_ENG_ADDR           -- 19. 영문주소
                                             ,IN_TEL_NO           => NULL             -- 20. 전화번호
                                             ,IN_NEW_PT_REL_TP_CD => IN_NEW_PT_REL_TP_CD   -- 21. 신 환자관계구분코드(203)
                                             ,IN_NEW_CTAD_TP_CD   => '51'     -- 22. 신 연락처구분코드 ('23A')
                                             ,IN_NEW_CTAD_TP_SEQ  => IN_NEW_CTAD_TP_SEQ    -- 23. 신 연락처구분순번(U,D는 필수입력,I
                                             ,IN_LSH_STF_NO       => IN_HIS_STF_NO         -- 24. 최초등록직원번호, 최종변경직원번호
                                             ,IN_LSH_PRGM_NM      => IN_HIS_PRGM_NM        -- 25. 최초등록프로그램명, 최종변경프로그램명
                                             ,IN_LSH_IP_ADDR      => IN_HIS_IP_ADDR        -- 26. 최초등록IP주소, 최종변경IP주소
                                             ,IO_ERRYN            => IO_ERRYN              --
                                             ,IO_PT_NO            => IO_PT_NO              --
                                             ,IO_ERRMSG           => IO_ERRMSG             --
                                            );
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, '주소생성 프로시저 호출 '||CHR(10)||TO_CHAR(SQLERRM));
        END;
        ----------
        -- 에러출력
        ----------
        IF IO_ERRYN = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20006, '주소생성 프로시저 호출 후 에러'||CHR(10)||IO_ERRMSG);
        END IF;

        BEGIN
            UPDATE XBIL.TEMPPTRSV
               SET PT_NO = IO_PT_NO
             WHERE ROWID = REC.ROWID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, '주소생성 프로시저 호출 '||CHR(10)||TO_CHAR(SQLERRM));
        END;
        -----------------------------------
        -- 생성된 환자번호 조회
        -----------------------------------
        BEGIN
            SELECT *
              INTO V_PCTPCPAM
              FROM PCTPCPAM
             WHERE PT_NO = IO_PT_NO;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, '환자정보조회 오류 1'||CHR(10)||TO_CHAR(SQLERRM));
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, '환자정보조회 오류 2'||CHR(10)||TO_CHAR(SQLERRM));
        END;

        -----------------------------------
        -- 사업장번호 조회
        -----------------------------------
        IF REC.PME_CLS_CD != 'AA' THEN
        BEGIN
           SELECT POB_NO
             INTO V_POB_NO
             FROM (SELECT POB_NO
                     FROM ACPPRCOD
                    WHERE SUBSTR(REC.PME_CLS_CD,1,1)= POB_TP_CD
                    ORDER BY DBMS_RANDOM.RANDOM
                    )
            WHERE ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, '사업장정보조회 오류 1'||CHR(10)||TO_CHAR(SQLERRM));
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, '사업장정보조회 오류 2'||CHR(10)||TO_CHAR(SQLERRM));
        END;
        ELSE
           V_POB_NO := '';
        END IF;



        BEGIN
            INSERT INTO
              ACPPRPID ( PT_NO                   -- 환자번호
                       , PME_CLS_CD              -- 환자급종유형코드
                       , INS_APY_DT              -- 보험적용일자
                       , PSE_CLS_CD              -- 환자보조급종유형코드
                       , INS_END_DT              -- 보험종료일자
                       , POB_NO                  -- 사업장번호
                       , HLTH_INSC_NO            -- 건강보험증번호
                       , ISPS_NM                 -- 피보험자명
                       , ISPS_RRN                -- 피보험자주민등록번호
                       , PT_REL_TP_CD            -- 환자관계구분코드
                       , QF_ACQS_DT              -- 자격취득일자
                       , MDC_PBDN_TP_CD          -- 의료급여본인부담구분코드
                       , DPFC_YN                 -- 출국여부
                       , DSPP_REG_DT             -- 장애인등록일자
                       , PCOR_INS_QF_TP_CD       -- 공단보험자격구분코드
                       , TH1_CHC_RCORG_NO        -- 1번째선택요양기관번호
                       , TH2_CHC_RCORG_NO        -- 2번째선택요양기관번호
                       , TH3_CHC_RCORG_NO        -- 3번째선택요양기관번호
                       , TH4_CHC_RCORG_NO        -- 4번째선택요양기관번호
                       , TH1_CHC_RCORG_NM        -- 1번째선택요양기관명
                       , TH2_CHC_RCORG_NM        -- 2번째선택요양기관명
                       , TH3_CHC_RCORG_NM        -- 3번째선택요양기관명
                       , TH4_CHC_RCORG_NM        -- 4번째선택요양기관명
                       , BOBD_PT_NO              -- 합본이전환자번호
                       , BIND_DTM                -- 합본일시
                       , BIND_STF_NO             -- 합본직원번호
                       , FSR_STF_NO              -- 최초등록직원번호
                       , FSR_DTM                 -- 최초등록일시
                       , FSR_PRGM_NM             -- 최초등록프로그램명
                       , FSR_IP_ADDR             -- 최초등록IP주소
                       , LSH_STF_NO              -- 최종변경직원번호
                       , LSH_DTM                 -- 최종변경일시
                       , LSH_PRGM_NM             -- 최종변경프로그램명
                       , LSH_IP_ADDR             -- 최종변경IP주소
                       )
                  VALUES
                       ( IO_PT_NO                  -- 환자번호
                       , REC.PME_CLS_CD             -- 환자급종유형코드
                       , V_PCTPCPAM.PT_BRDY_DT      -- 보험적용일자
                       , REC.PSE_CLS_CD             -- 환자보조급종유형코드
                       , IN_INS_END_DT              -- 보험종료일자
                       , V_POB_NO                   -- 사업장번호
                       , IN_HLTH_INSC_NO            -- 건강보험증번호
                       , V_PCTPCPAM.PT_NM           -- 피보험자명
                       , V_PCTPCPAM.PT_RRN          -- 피보험자주민등록번호
                       , IN_PT_REL_TP_CD            -- 환자관계구분코드
                       , V_PCTPCPAM.PT_BRDY_DT      -- 자격취득일자
                       , IN_MDC_PBDN_TP_CD          -- 의료급여본인부담구분코드
                       , IN_DPFC_YN                 -- 출국여부
                       , IN_DSPP_REG_DT             -- 장애인등록일자
                       , IN_PCOR_INS_QF_TP_CD       -- 공단보험자격구분코드
                       , IN_TH1_CHC_RCORG_NO        -- 1번째선택요양기관번호
                       , IN_TH2_CHC_RCORG_NO        -- 2번째선택요양기관번호
                       , IN_TH3_CHC_RCORG_NO        -- 3번째선택요양기관번호
                       , IN_TH4_CHC_RCORG_NO        -- 4번째선택요양기관번호
                       , IN_TH1_CHC_RCORG_NM        -- 1번째선택요양기관명
                       , IN_TH2_CHC_RCORG_NM        -- 2번째선택요양기관명
                       , IN_TH3_CHC_RCORG_NM        -- 3번째선택요양기관명
                       , IN_TH4_CHC_RCORG_NM        -- 4번째선택요양기관명
                       , IN_BOBD_PT_NO              -- 합본이전환자번호
                       , IN_BIND_DTM                -- 합본일시
                       , IN_BIND_STF_NO             -- 합본직원번호
                       , IN_HIS_STF_NO              -- 최초등록직원번호
                       , SYSDATE                    -- 최초등록일시
                       , IN_HIS_PRGM_NM             -- 최초등록프로그램명
                       , IN_HIS_IP_ADDR             -- 최초등록IP주소
                       , IN_HIS_STF_NO              -- 최종변경직원번호
                       , SYSDATE                    -- 최종변경일시
                       , IN_HIS_PRGM_NM             -- 최종변경프로그램명
                       , IN_HIS_IP_ADDR             -- 최종변경IP주소
                      );
         EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, '보험정보 INSERT 오류 1'||CHR(10)||TO_CHAR(SQLERRM));
         END;

         BEGIN
            UPDATE XBIL.TEMPPTRSV
               SET POB_NO = V_POB_NO
             WHERE PT_NO  = IO_PT_NO;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20005, '사업장 UPDATE 오류 1'||CHR(10)||TO_CHAR(SQLERRM));
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, '사업장 UPDATE 오류 2'||CHR(10)||TO_CHAR(SQLERRM));
        END;
    END LOOP;
END;
