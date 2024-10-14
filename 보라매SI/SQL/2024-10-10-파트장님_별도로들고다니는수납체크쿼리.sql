/*
이지케어텍 보라매 박수현 파트장님, [2024-10-10 오전 9:07]
길어서 여러번 복사해야하긴 하지만... 데이터 만져주고 나서

이지케어텍 보라매 박수현 파트장님, [2024-10-10 오전 9:07]
IN_RCPDATE       DATE          := TO_DATE('20241010','YYYYMMDD');
    IN_PT_NO         VARCHAR2(8)   := '';  -- 작업하려는 환자번호 '88888888'

이지케어텍 보라매 박수현 파트장님, [2024-10-10 오전 9:07]
여기에 환자번호 넣으면 해당 환자만 체크합니다...      


*/





DECLARE

--    IN_RCPDATE       DATE          := TRUNC(SYSDATE);
    IN_HSP_TP_CD     VARCHAR2(2)   := '7';  -- 병원구분코드
    IN_RCPDATE       DATE          := TO_DATE('20241010','YYYYMMDD');
    IN_PT_NO         VARCHAR2(8)   := '';  -- 작업하려는 환자번호 '88888888'
    IN_EX_PT_NO1     VARCHAR2(8)   := '';  -- 제외하려는 환자번호1
    IN_EX_PT_NO2     VARCHAR2(8)   := '';  -- 제외하려는 환자번호2
    L_ERRYN          VARCHAR2(1)   := 'N';
    L_PT_NO          VARCHAR2(8)   := '';
    L_PATSECT        VARCHAR2(1)   := 'A';  -- A:전체, O:외래, I:입원
    L_JOBGUBN        VARCHAR2(100) := '';
    L_SUGACODE       VARCHAR2(20)  := '';

    L_CARDAMT        NUMBER(10)    := 0;
    L_CASHAMT        NUMBER(10)    := 0;
    WK_CASHAMT       NUMBER(10)    := 0;
    WK_CARDAMT       NUMBER(10)    := 0;

    L_RPY_PACT_ID    ACPPEOPD.RPY_PACT_ID %TYPE  := '';

BEGIN
    -- 11.외래수납 가로 체크
    -- 12.외래 계산금액과 수납금액 체크
    -- 13.외래 수납금액과 보증금 체크
    -- 14.외래 수납금액과 카드금액 체크
    -- 15.외래 수납금액과 현금영수증금액 체크
    -- 16.외래 보증금액과 카드금액 체크
    -- 17.외래 수납/예약(내일) BB 급종에 T(자보) 계약처 유무확인
    -- 18.외래 수납중 건증과로 조합부담액 발생 확인
    -- 19.외래수납 살아있는데 외래예약이 취소 된 내역  -- 전남대 추가

    -- 21.입원수납 가로 체크
    -- 22.입원 수납금액과 보증금 체크
    -- 23.입원 수납금액과 카드금액 체크
    -- 24.입원 수납금액과 현금영수증금액 체크
    -- 25.입원 보증금액과 카드금액 체크
    -- 26.외래정산금액 외래입원 정산체크

    -- 31.카드내역 '*' 확인, 카드번호 '+' 확인
    -- 32.수납자 id 누락 확인 체크
    -- 33.수납여부 'S 확인

    -- 41.전산취소 XXXX~ 로 마감집계
    -- 42.외래/응급 담당자마감 카드금액과 카드승인내역금액 차이남
    -- 43.외래/응급 담당자마감 카드금액과 수입현황 카드금액 차이남
    -- 44.입원 전산취소 XXXX~ 로 마감집계 잡혔음
    -- 45.입원 담당자마감 카드금액과 카드승인내역금액 차이남
    -- 46.입원 담당자마감 카드금액과 수입현황 카드금액 차이남
    -- 47.입원 담당자마감 현금금액과 수입현황 현금금액 차이남

    -- 51. 수익통계 가로체크 (외래/응급) -- 과거일자만
    -- 52. 수익통계 가로체크 (입원)      -- 과거일자만

    -- 61. org_seq 와 ordseqno 비교

    -- 43.46. 카드내역수정   2012.05.08  조흥카드(041) --> NH카드(042)로 변경함

    -- 62. 계약처미수입금 처리일별 금액확인 계약처구분이 '2' 인것만 우선한다.
    -- 777.선별급여대상(행위,치료재료,약제) 발생된경우 확인하기위함.

    -- 114.입원 수납 내역에 산재인데 다른 계약처 들어간것

    IF  L_PATSECT IN ('A','O') THEN

        -- 11.외래수납 가로 체크
        BEGIN
            SELECT A.PT_NO                              PT_NO
                 , '11.외래수납 가로체크'               JOBGUBN
                 , 'Y'                                  ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM ACPPEOPD A
             WHERE A.RPY_DT = IN_RCPDATE
               AND A.PT_NO  = NVL(IN_PT_NO,A.PT_NO)
               AND A.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
               AND (
                    NVL(A.MTCS_AMT,0) != NVL(A.INS_SUM_AMT,0)  + NVL(A.NINS_SUM_AMT,0) + NVL(A.CMED_SUM_AMT,0)
                OR  NVL(A.PBDN_AMT,0) != NVL(A.NINS_SUM_AMT,0) + NVL(A.CMED_SUM_AMT,0) + (NVL(A.INS_SUM_AMT,0) - NVL(A.UNN_BRDN_AMT,0))
                OR  NVL(A.RPY_AMT,0)  != NVL(A.PBDN_AMT,0) - (SELECT SUM(XBIL.FT_ACP_ACPPROOE_AMT( A.PACT_TP_CD  --IN_PACT_TP_CD   IN  VARCHAR2                   -- 02. 외래/입원 구분(I/O/E)
                                                                                                 , A.RPY_PACT_ID --IN_RPY_PACT_ID  IN  ACPPROOE.RPY_PACT_ID %TYPE -- 03. 수납원무접수ID
                                                                                                 , A.RPY_CLS_SEQ --IN_RPY_CLS_SEQ  IN  ACPPROOE.RPY_CLS_SEQ %TYPE -- 04. 수납유형순번
                                                                                                 , A.APY_STR_DT  --IN_APY_STR_DT   IN  ACPPROOE.APY_STR_DT  %TYPE -- 05. 적용시작일자
                                                                                                 , A.RPY_SEQ     --IN_RPY_SEQ      IN  ACPPROOE.RPY_SEQ     %TYPE -- 06. 수납순번
                                                                                                 , A.ORPY_CLS_CD --IN_ORPY_CLS_CD  IN  ACPPROOE.ORPY_CLS_CD %TYPE -- 07. 외래수납유형코드 , 전체 = NULL (IN_PACT_TP_CD == I 이면  NULL)
                                                                                                 , NULL          --IN_CORG_TP_CD   IN  ACPPROOE.CORG_TP_CD  %TYPE -- 08. 후불미수총금액='C' 감면총금액=  'D' 혈액총금액 = 'B' 전체금액 = NULL



                                                                                                 , NULL          --IN_CORG_CD      IN  ACPPROOE.CORG_CD     %TYPE -- 09. 계약기관코드     , 전체 = NULL
                                                                                                 ))
                                                                FROM DUAL
                                                             --) - NVL(A.MRPY_AMT,0) - NVL(A.PV_RPY_AMT,0) - NVL(A.W1_UNIT_COF_AMT,0) - NVL(A.UNCL_AMT,0)- NVL(A.HLU_DMD_AMT,0) - NVL(A.PNCK_SUP_CST_DMD_AMT,0) + NVL(A.VAT_AMT,0)
                                                             ) - NVL(A.MRPY_AMT,0) - NVL(A.PV_RPY_AMT,0) - NVL(A.W1_UNIT_COF_AMT,0) - NVL(A.UNCL_AMT,0) + NVL(A.VAT_AMT,0)
                   )
               AND ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'11.외래가로체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;

        -- 12.외래 계산금액과 수납금액 체크
        BEGIN
            SELECT XX.PT_NO
                 , XX.RPY_PACT_ID
                 , '12.외래 계산금액과 수납금액 체크'  GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_RPY_PACT_ID
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO                         PT_NO
                         , S.RPY_PACT_ID                   RPY_PACT_ID
                         , S.RPY_CLS_SEQ                   RPY_CLS_SEQ
                      FROM (
                            SELECT PT_NO                           PT_NO
                                 , SUM(MTCS_AMT)                   MTCS_AMT
                                 , '1'                             GUBN
                                 , RPY_PACT_ID                     RPY_PACT_ID
                                 , RPY_CLS_SEQ                     RPY_CLS_SEQ
                              FROM ACPPEOPD
                             WHERE RPY_DT  = IN_RCPDATE
                               AND PT_NO   = NVL(IN_PT_NO,PT_NO)
                             GROUP BY PT_NO
                                    , RPY_PACT_ID
                                    , RPY_CLS_SEQ
                            UNION ALL
                            SELECT PT_NO                           PT_NO
                                 , SUM(HSP_ADN_ICLS_AMT+CMED_AMT)  MTCS_AMT
                                 , '2'                             GUBN
                                 , RPY_PACT_ID                     RPY_PACT_ID
                                 , RPY_CLS_SEQ                     RPY_CLS_SEQ
                              FROM ACPPEOCE
                             WHERE RPY_DT  = IN_RCPDATE
                               AND PT_NO   = NVL(IN_PT_NO,PT_NO)
                             GROUP BY PT_NO
                                    , RPY_PACT_ID
                                    , RPY_CLS_SEQ
                           ) S
                     GROUP BY S.PT_NO
                            , S.RPY_PACT_ID
                            , S.RPY_CLS_SEQ
                     HAVING SUM(DECODE(S.GUBN,'1',S.MTCS_AMT
                                                 ,S.MTCS_AMT * -1 )) <> 0
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'12.외래 계산금액과 수납금액 체크 ERR:'||TO_CHAR(SQLCODE));
        END;



        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_RPY_PACT_ID || ' - ' || L_JOBGUBN);
        END IF;

        -- 13.외래 수납금액과 보증금 체크
        BEGIN
            SELECT XX.PT_NO
                , '13.외래 수납금액과 보증금 체크' GUBN
                , 'Y'                              ERRYN
             INTO L_PT_NO
                , L_JOBGUBN
                , L_ERRYN
             FROM (
                   SELECT S.PT_NO
                        , S.RPY_STF_NO
                        , SUM(DECODE(S.GUBN,'1',S.MTCS_AMT
                                               ,S.MTCS_AMT * -1 ))  AMT
                     FROM (
                           SELECT PT_NO                        PT_NO
                                , RPY_STF_NO                   RPY_STF_NO
                                , SUM(MRPY_AMT+PV_RPY_AMT)     MTCS_AMT
                                , '1'                          GUBN
                             FROM ACPPEOPD
                            WHERE RPY_DT      = IN_RCPDATE
                              AND PT_NO       = NVL(IN_PT_NO,PT_NO)
                              AND MEDR_STF_NO <> 'HHC01'  -- 가정간호 제외 (가정간호는 보증금테이블에서 안쓰고, 가정간호예치금에서 쓴다)
                            GROUP BY PT_NO
                                   , RPY_STF_NO
                            UNION ALL
                           SELECT PT_NO                        PT_NO
                                , PRO_WK_STF_NO                RPY_STF_NOID
                                , SUM(RPY_AMT)                 MTCS_AMT
                                , '2'                          GUBN
                             FROM ACPPEDPD
                            WHERE PRO_DT              = IN_RCPDATE
                              AND PT_NO               = NVL(IN_PT_NO,PT_NO)
                              AND GRTY_AMT_INPT_TP_CD LIKE '1%'
                              AND nvl(PSE_CLS_CD,'*')          NOT LIKE 'N%'
                            GROUP BY PT_NO
                                   , PRO_WK_STF_NO
                           ) S
                    GROUP BY S.PT_NO
                           , S.RPY_STF_NO
                   HAVING SUM(DECODE(S.GUBN,'1',S.MTCS_AMT
                                               ,S.MTCS_AMT * -1 )) <> 0
                   ) XX
             WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
               AND ROWNUM =1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                L_PT_NO   := '';
                L_JOBGUBN := '';
                L_ERRYN   := 'N';
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20500,'13.외래 수납금액과 보증금 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;


        -- 14.외래 수납금액과 카드금액 체크
        BEGIN
            SELECT XX.PT_NO
                 , '14.외래 수납금액과 카드금액 체크'  GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO                        PT_NO
                         , S.RCPID                        RCPID
                         , S.SETL_APBT_ID                 SETL_APBT_ID
                      FROM (
                            SELECT PT_NO
                                 , SUM(CARD_RPY_AMT-HLU_DMD_AMT-PNCK_SUP_CST_DMD_AMT)       TOTAMT
                                 , '1'                     GUBN
                                 , RPY_STF_NO              RCPID
                                 , SETL_APBT_ID            SETL_APBT_ID
                              FROM ACPPEOPD
                             WHERE RPY_DT     = IN_RCPDATE
                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                               AND APRV_TP_CD IN ('Y','P', 'H')
                             GROUP BY PT_NO
                                    , RPY_STF_NO
                                    , SETL_APBT_ID
                            UNION ALL
                            SELECT PT_NO
                                 , SUM(CARD_SETL_AMT)      TOTAMT
                                 , '2'                     GUBN
                                 , RPY_STF_NO              RCPID
                                 , SETL_APBT_ID            SETL_APBT_ID
                              FROM ACPPECPE
                             WHERE RPY_DT     = IN_RCPDATE
                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                               AND RPY_STF_NO NOT IN ('XXXXX')
                               AND RPY_CLS_CD = 'S'
                               AND PACT_TP_CD IN ('O','E')
                             GROUP BY PT_NO
                                    , RPY_STF_NO
                                    , SETL_APBT_ID
                           ) S
                     GROUP BY S.PT_NO
                            , S.RCPID
                            , S.SETL_APBT_ID
                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
                                                ,S.TOTAMT * -1 )) <> 0
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                L_PT_NO   := '';
                L_JOBGUBN := '';
                L_ERRYN   := 'N';
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20500,'14.외래 수납금액과 카드금액 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;


        -- 15.외래 수납금액과 현금영수증금액 체크
--        BEGIN
--            SELECT XX.PT_NO
--                 , '15.외래 수납금액과 현금영수증금액 체크'  GUBN
--                 , 'Y'                                       ERRYN
--              INTO L_PT_NO
--                 , L_JOBGUBN
--                 , L_ERRYN
--              FROM (
--                    SELECT S.PT_NO                        PT_NO
--                         , S.RCPID                        RCPID
--                         , S.SETL_APBT_ID                 SETL_APBT_ID
--                      FROM (
--                            SELECT PT_NO
--                                 , SUM(DECODE(APRV_TP_CD,'N',CASH_RPY_AMT
--                                                            ,CRCP_AMT))           TOTAMT
--                                 , '1'                     GUBN
--                                 , RPY_STF_NO              RCPID
--                                 , SETL_APBT_ID            SETL_APBT_ID
--                              FROM ACPPEOPD
--                             WHERE RPY_DT     = IN_RCPDATE
--                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
--                               AND APRV_TP_CD IN ('C','P','N')
--                               AND RPY_STF_NO NOT IN ('AUTO1','AUTO3')
--                             GROUP BY PT_NO
--                                    , RPY_STF_NO
--                                    , SETL_APBT_ID
--                            UNION ALL
--                            SELECT PT_NO
--                                 , SUM(CASH_SETL_AMT)      TOTAMT
--                                 , '2'                     GUBN
--                                 , RPY_STF_NO              RCPID
--                                 , SETL_APBT_ID            SETL_APBT_ID
--                              FROM ACPPECHE
--                             WHERE RPY_DT     = IN_RCPDATE
--                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
--                               AND RPY_STF_NO NOT IN ('XXXXX','AUTO1','AUTO3')
--                               AND RPY_CLS_CD = 'S'
--                               AND PACT_TP_CD IN ('O','E')
--                             GROUP BY PT_NO
--                                    , RPY_STF_NO
--                                    , SETL_APBT_ID
--                           ) S
--                     GROUP BY S.PT_NO
--                            , S.RCPID
--                            , S.SETL_APBT_ID
--                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
--                                                ,S.TOTAMT * -1 )) <> 0
--                    ) XX
--              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
--                AND ROWNUM =1 ;
--        EXCEPTION
--            WHEN NO_DATA_FOUND THEN
--                 L_PT_NO   := '';
--                 L_JOBGUBN := '';
--                 L_ERRYN   := 'N';
--            WHEN OTHERS THEN
--                 RAISE_APPLICATION_ERROR(-20500,'15.외래 수납금액과 현금영수증금액 체크 ERR:'||TO_CHAR(SQLCODE));
--        END;
--
--        IF  NVL(L_ERRYN,'N') = 'Y' THEN
--            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
--        END IF;


        -- 16.외래 보증금액과 카드금액 체크
        BEGIN
            SELECT XX.PT_NO
                 , '16.외래 보증금액과 카드금액 체크'  GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO                        PT_NO
                         , S.RCPID                        RCPID
                         , S.RCPSEQ2                      RCPSEQ2
                      FROM (
                            SELECT A.PT_NO                   PT_NO
                                 , SUM(A.RPY_AMT)            TOTAMT
                                 , '1'                       GUBN
                                 , A.RPY_STF_NO              RCPID
                                 , A.INAM_SEQ                RCPSEQ2
                              FROM ACPPEDPD A
                             WHERE A.RPY_DT              = IN_RCPDATE
                               AND A.PT_NO               = NVL(IN_PT_NO,A.PT_NO)
                               AND A.GRTY_AMT_INPT_TP_CD IN ('13','14')
                             GROUP BY A.PT_NO
                                    , A.RPY_STF_NO
                                    , A.INAM_SEQ
                            UNION ALL
                            SELECT A.PT_NO                   PT_NO
                                 , SUM(A.CARD_SETL_AMT)      TOTAMT
                                 , '2'                       GUBN
                                 , A.RPY_STF_NO              RCPID
                                 , A.RPY_SEQ                 RCPSEQ2
                              FROM ACPPECPE A
                             WHERE A.RPY_DT     = IN_RCPDATE
                               AND A.PT_NO      = NVL(IN_PT_NO,A.PT_NO)
                               AND A.RPY_STF_NO NOT IN ('XXXXX')
                               AND A.RPY_CLS_CD = 'B'
                               AND A.PACT_TP_CD IN ('O','E')
                               and a.FSR_PRGM_NM != 'OCS미수수납'
                             GROUP BY A.PT_NO
                                    , A.RPY_STF_NO
                                    , A.RPY_SEQ
                           ) S
                     GROUP BY S.PT_NO
                            , S.RCPID
                            , S.RCPSEQ2
                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
                                                ,S.TOTAMT * -1 )) <> 0
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'16.외래 보증금액과 카드금액 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;


        -- 17.외래 수납/예약(내일) BB 급종에 T(자보) 계약처 유무확인
        BEGIN
            SELECT XX.PT_NO
                 , '17.외래 수납/예약(내일) BB 급종에 T(자보) 계약처 유무확인'  GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT A.PT_NO                 PT_NO
                      FROM ACPPEOPD A
                     WHERE A.RPY_DT     = IN_RCPDATE
                       AND A.PT_NO      = NVL(IN_PT_NO,A.PT_NO)
                       AND A.PME_CLS_CD != 'TD'
                       AND A.CORG_CD    LIKE 'T%'
                       AND ROWNUM       = 1
                    UNION ALL
                    SELECT A.PT_NO                 PT_NO
                      FROM ACPPRODM A
                     WHERE A.MED_DT     = IN_RCPDATE
                       AND A.PT_NO      = NVL(IN_PT_NO,A.PT_NO)
                       AND A.PME_CLS_CD != 'TD'
                       AND A.CORG_CD    LIKE 'T%'
                       AND A.APCN_DTM   IS NULL
                       AND ROWNUM       = 1
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'17.외래 수납/예약(내일) BB 급종에 T(자보) 계약처 유무확인 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;

--        -- 18.외래 수납중 건증과로 조합부담액 발생 확인
--        BEGIN
--            SELECT XX.PT_NO
--                 , '18.외래 수납 건증과로 조합부담액 발생 확인'  GUBN
--                 , 'Y'                                 ERRYN
--              INTO L_PT_NO
--                 , L_JOBGUBN
--                 , L_ERRYN
--              FROM (
--                    SELECT A.PT_NO                  PT_NO
--                      FROM ACPPEOPD A
--                     WHERE A.RPY_DT       = IN_RCPDATE
--                       AND A.PT_NO        = NVL(IN_PT_NO,A.PT_NO)
--                       AND A.MED_DEPT_CD  = 'HPC'
--                       AND A.UNN_BRDN_AMT <> 0
--                       AND ROWNUM         = 1
--                   ) XX
--             WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
--               AND ROWNUM =1 ;
--        EXCEPTION
--            WHEN NO_DATA_FOUND THEN
--                 L_PT_NO   := '';
--                 L_JOBGUBN := '';
--                 L_ERRYN   := 'N';
--            WHEN OTHERS THEN
--                 RAISE_APPLICATION_ERROR(-20500,'18.외래 수납 건증과로 조합부담액 발생 확인 ERR:'||TO_CHAR(SQLCODE));
--        END;
--
--        IF  NVL(L_ERRYN,'N') = 'Y' THEN
--            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
--        END IF;


        -- 19.외래수납 살아있는데 외래예약이 취소 된 내역
--        BEGIN
--            SELECT XX.PT_NO
--                 , '19.외래수납 살아있는데 외래예약이 취소 된 내역'  GUBN
--                 , 'Y'                                 ERRYN
--              INTO L_PT_NO
--                 , L_JOBGUBN
--                 , L_ERRYN
--              FROM (
--                    select b.pt_no
--                      from (
--                            select a.pt_no
--                                 , a.rpy_pact_id
--                                 , sum(a.rpy_amt)
--                              from acppeopd a
--                             where a.hsp_tp_cd   = IN_HSP_TP_CD
--                               and a.rpy_dt      = IN_RCPDATE
--                               and a.rpy_stf_no != 'AUTO003'
--                               and a.cncl_dtm   is null
--                               and a.pt_no       = NVL(IN_PT_NO,A.PT_NO)
--                             group by a.pt_no
--                                    , a.rpy_pact_id
--                            having sum(a.rpy_amt) != 0
--                           ) b
--                     where exists (
--                                   select 'Y'
--                                     from acpprodm x
--                                    where x.rpy_pact_id = b.rpy_pact_id
--                                      and x.apcn_yn   = 'Y'
--                                  )
--                       and rownum = 1
--                   ) XX
--             WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
--               AND ROWNUM =1 ;
--        EXCEPTION
--            WHEN NO_DATA_FOUND THEN
--                 L_PT_NO   := '';
--                 L_JOBGUBN := '';
--                 L_ERRYN   := 'N';
--            WHEN OTHERS THEN
--                 RAISE_APPLICATION_ERROR(-20500,'19.외래수납 살아있는데 외래예약이 취소 된 내역 ERR:'||TO_CHAR(SQLCODE));
--        END;
--
--        IF  NVL(L_ERRYN,'N') = 'Y' THEN
--            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
--        END IF;




    END IF;


    IF L_PATSECT IN ('A','I') THEN


        -- 21.입원수납 가로 체크
        BEGIN
            SELECT A.PT_NO                              PT_NO
                 , '21.입원수납 가로체크'               JOBGUBN
                 , 'Y'                                  ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM ACPPEIPD A
             WHERE A.RPY_DT     = IN_RCPDATE
               AND A.PT_NO      = NVL(IN_PT_NO,A.PT_NO)
               AND A.RPY_STS_CD IN ('R','Y')
               AND (
                    A.MTCS_AMT != A.NINS_SUM_AMT + A.CMED_SUM_AMT + A.INS_SUM_AMT
                OR  A.PBDN_AMT != A.NINS_SUM_AMT + A.CMED_SUM_AMT + (A.INS_SUM_AMT - A.UNN_BRDN_AMT)
                OR  A.RPY_AMT  != A.PBDN_AMT - (
                                                SELECT SUM(XBIL.FT_ACP_ACPPROOE_AMT( 'I'           --IN_PACT_TP_CD   IN  VARCHAR2                   -- 02. 외래/입원 구분(I/O/E)
                                                                                   , A.RPY_PACT_ID --IN_RPY_PACT_ID  IN  ACPPROOE.RPY_PACT_ID %TYPE -- 03. 수납원무접수ID
                                                                                   , A.RPY_CLS_SEQ --IN_RPY_CLS_SEQ  IN  ACPPROOE.RPY_CLS_SEQ %TYPE -- 04. 수납유형순번
                                                                                   , A.APY_STR_DT  --IN_APY_STR_DT   IN  ACPPROOE.APY_STR_DT  %TYPE -- 05. 적용시작일자
                                                                                   , A.RPY_SEQ     --IN_RPY_SEQ      IN  ACPPROOE.RPY_SEQ     %TYPE -- 06. 수납순번
                                                                                   , NULL          --IN_ORPY_CLS_CD  IN  ACPPROOE.ORPY_CLS_CD %TYPE -- 07. 외래수납유형코드 , 전체 = NULL (IN_PACT_TP_CD == I 이면  NULL)
                                                                                   , NULL          --IN_CORG_TP_CD   IN  ACPPROOE.CORG_TP_CD  %TYPE -- 08. 후불미수총금액='C' 감면총금액=  'D' 혈액총금액 = 'B' 전체금액 = NULL
                                                                                   , NULL          --IN_CORG_CD      IN  ACPPROOE.CORG_CD     %TYPE -- 09. 계약기관코드     , 전체 = NULL
                                                                                   )
                                                          )
                                                  FROM DUAL
                                               ) - A.MRPY_AMT - A.PV_RPY_AMT - A.W1_UNIT_COF_AMT - A.UNCL_AMT + NVL(A.VAT_AMT,0)  -- 20110718 TAXSUMAMT 추가
                   )
               AND A.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
               AND ROWNUM = 1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'21.입원수납 가로 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;


        -- 22.입원 수납금액과 보증금 체크
        BEGIN
            SELECT XX.PT_NO
                 , '22.입원 수납금액과 보증금 체크'    GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO
                         , S.RCPID
                         , SUM(DECODE(S.GUBN,'1',S.TOTAMT
                                                ,S.TOTAMT * -1 ))  AMT
                      FROM (
                            SELECT PT_NO                  PT_NO
                                 , RPY_STF_NO             RCPID
                                 , SUM(MRPY_AMT)          TOTAMT
                                 , '1'                    GUBN
                              FROM ACPPEIPD
                             WHERE RPY_DT     = IN_RCPDATE
                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                               AND RPY_STS_CD = 'Y'
                             GROUP BY PT_NO
                                    , RPY_STF_NO
                            UNION ALL
                            SELECT PT_NO                  PT_NO
                                 , PRO_WK_STF_NO          RCPID
                                 , SUM(RPY_AMT)           TOTAMT
                                 , '2'                    GUBN
                              FROM ACPPEDPD
                             WHERE PRO_DT              = IN_RCPDATE
                               AND PT_NO               = NVL(IN_PT_NO,PT_NO)
                               AND GRTY_AMT_INPT_TP_CD LIKE '2%'
                             GROUP BY PT_NO
                                    , PRO_WK_STF_NO
                           ) S
                     GROUP BY S.PT_NO
                            , S.RCPID
                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
                                                ,S.TOTAMT * -1 )) <> 0
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                L_PT_NO   := '';
                L_JOBGUBN := '';
                L_ERRYN   := 'N';
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20500,'22.입원 수납금액과 보증금 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;


        -- 23.입원 수납금액과 카드금액 체크
        BEGIN
            SELECT XX.PT_NO
                 , '23.입원 수납금액과 카드금액 체크'  GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO                        PT_NO
                         , S.RCPID                        RCPID
                         , S.SETL_APBT_ID                 SETL_APBT_ID
                      FROM (
                            SELECT PT_NO
                                 , SUM(CARD_RPY_AMT)       TOTAMT
                                 , '1'                     GUBN
                                 , RPY_STF_NO              RCPID
                                 , SETL_APBT_ID            SETL_APBT_ID
                              FROM ACPPEIPD
                             WHERE RPY_DT     = IN_RCPDATE
                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                               AND APRV_TP_CD IN ('Y','P','H')
                               AND RPY_STS_CD = 'Y'
                             GROUP BY PT_NO
                                    , RPY_STF_NO
                                    , SETL_APBT_ID
                            UNION ALL
                            SELECT PT_NO
                                 , SUM(CARD_SETL_AMT)      TOTAMT
                                 , '2'                     GUBN
                                 , RPY_STF_NO              RCPID
                                 , SETL_APBT_ID            SETL_APBT_ID
                              FROM ACPPECPE
                             WHERE RPY_DT     = IN_RCPDATE
                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                               AND CNCL_DTM   IS NULL
                               AND RPY_CLS_CD = 'I'
                               AND PACT_TP_CD IN ('I')
                             GROUP BY PT_NO
                                    , RPY_STF_NO
                                    , SETL_APBT_ID
                           ) S
                     GROUP BY S.PT_NO
                            , S.RCPID
                            , S.SETL_APBT_ID
                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
                                                ,S.TOTAMT * -1 )) <> 0
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'23.입원 수납금액과 카드금액 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;
    

        -- 24.입원 수납금액과 현금영수증금액 체크
--        BEGIN
--            SELECT XX.PT_NO
--                 , '24.입원 수납금액과 현금영수증금액 체크'  GUBN
--                 , 'Y'                                       ERRYN
--              INTO L_PT_NO
--                 , L_JOBGUBN
--                 , L_ERRYN
--              FROM (
--                    SELECT S.PT_NO                        PT_NO
--                         , S.RCPID                        RCPID
--                         , S.SETL_APBT_ID                 SETL_APBT_ID
--                      FROM (
--                            SELECT PT_NO
--                                 , SUM(CRCP_AMT)           TOTAMT
--                                 , '1'                     GUBN
--                                 , RPY_STF_NO              RCPID
--                                 , SETL_APBT_ID            SETL_APBT_ID
--                              FROM ACPPEIPD
--                             WHERE RPY_DT     = IN_RCPDATE
--                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
--                               AND APRV_TP_CD IN ('C','P')
--                               AND RPY_STS_CD = 'Y'
--                             GROUP BY PT_NO
--                                    , RPY_STF_NO
--                                    , SETL_APBT_ID
--                            UNION ALL
--                            SELECT PT_NO
--                                 , SUM(CASH_SETL_AMT)      TOTAMT
--                                 , '2'                     GUBN
--                                 , RPY_STF_NO              RCPID
--                                 , SETL_APBT_ID            SETL_APBT_ID
--                              FROM ACPPECHE
--                             WHERE RPY_DT     = IN_RCPDATE
--                               AND PT_NO      = NVL(IN_PT_NO,PT_NO)
--                               AND CNCL_DTM   IS NULL
--                               AND RPY_CLS_CD = 'I'
--                               AND PACT_TP_CD IN ('I')
--                             GROUP BY PT_NO
--                                    , RPY_STF_NO
--                                    , SETL_APBT_ID
--                           ) S
--                     GROUP BY S.PT_NO
--                            , S.RCPID
--                            , S.SETL_APBT_ID
--                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
--                                                ,S.TOTAMT * -1 )) <> 0
--                    ) XX
--              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
--                AND ROWNUM =1 ;
--        EXCEPTION
--            WHEN NO_DATA_FOUND THEN
--                 L_PT_NO   := '';
--                 L_JOBGUBN := '';
--                 L_ERRYN   := 'N';
--            WHEN OTHERS THEN
--                 RAISE_APPLICATION_ERROR(-20500,'24.입원 수납금액과 현금영수증금액 체크 ERR:'||TO_CHAR(SQLCODE));
--        END;
--
--        IF  NVL(L_ERRYN,'N') = 'Y' THEN
--            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
--        END IF;


        -- 25.입원 보증금액과 카드금액 체크
        BEGIN
            SELECT XX.PT_NO
                 , '25.입원 보증금액과 카드금액 체크'  GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO                        PT_NO
                         , S.RCPID                        RCPID
                         , S.RCPSEQ2                      RCPSEQ2
                      FROM (
                            SELECT A.PT_NO                  PT_NO
                                 , SUM(A.RPY_AMT)           TOTAMT
                                 , '1'                      GUBN
                                 , A.RPY_STF_NO             RCPID
                                 , A.INAM_SEQ               RCPSEQ2
                              FROM ACPPEDPD A
                             WHERE A.RPY_DT              = IN_RCPDATE
                               AND A.PT_NO               = NVL(IN_PT_NO,A.PT_NO)
                               AND A.GRTY_AMT_INPT_TP_CD IN ('22','24','26')
                             GROUP BY A.PT_NO
                                    , A.RPY_STF_NO
                                    , A.INAM_SEQ
                            UNION ALL
                            SELECT A.PT_NO                  PT_NO
                                 , SUM(A.CARD_SETL_AMT)     TOTAMT
                                 , '2'                      GUBN
                                 , A.RPY_STF_NO             RCPID
                                 , A.RPY_SEQ                RCPSEQ2
                              FROM ACPPECPE A
                             WHERE A.RPY_DT     = IN_RCPDATE
                               AND A.PT_NO      = NVL(IN_PT_NO,A.PT_NO)
                               AND A.RPY_STF_NO NOT IN ('XXXXX')
                               AND A.RPY_CLS_CD = 'B'
                               AND A.PACT_TP_CD IN ('I')
                             GROUP BY A.PT_NO
                                    , A.RPY_STF_NO
                                    , A.RPY_SEQ
                           ) S
                     GROUP BY S.PT_NO
                            , S.RCPID
                            , S.RCPSEQ2
                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
                                                ,S.TOTAMT * -1 )) <> 0
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'25.입원 보증금액과 카드금액 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;


        -- 26.외래정산금액 외래입원 정산체크
        BEGIN
            SELECT XX.PT_NO
                 , '26.외래정산금액 외래입원 정산체크'  GUBN
                 , 'Y'                                  ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO                        PT_NO
                         , S.RCPID                        RCPID
                      FROM (
                            SELECT A.PT_NO                  PT_NO
                                 , SUM(A.RPY_AMT)           TOTAMT
                                 , '1'                      GUBN
                                 , A.RPY_STF_NO             RCPID
                              FROM ACPPEDPD A
                             WHERE A.RPY_DT              = IN_RCPDATE
                               AND A.PT_NO               = NVL(IN_PT_NO,A.PT_NO)
                               AND A.GRTY_AMT_INPT_TP_CD IN ('29')
                               AND A.RPY_STF_NO          IN ('AUTO1')
                               AND (SELECT SUM(AA.RPY_AMT)
                                      FROM ACPPEDPD AA
                                     WHERE AA.PT_NO      = A.PT_NO
                                       AND AA.RPY_STF_NO = A.RPY_STF_NO
                                       AND AA.RPY_DT     = A.RPY_DT ) != 0
                             GROUP BY A.PT_NO
                                    , A.RPY_STF_NO
                            UNION ALL
                            SELECT A.PT_NO                  PT_NO
                                 , SUM(A.RPY_AMT) * -1      TOTAMT
                                 , '2'                      GUBN
                                 , A.RPY_STF_NO             RCPID
                              FROM ACPPEOPD A
                             WHERE A.RPY_DT     = IN_RCPDATE
                               AND A.PT_NO      = NVL(IN_PT_NO,A.PT_NO)
                               AND A.RPY_STF_NO IN ('AUTO1')
                             GROUP BY A.PT_NO
                                    , A.RPY_STF_NO
                           ) S
                     GROUP BY S.PT_NO
                            , S.RCPID
                    HAVING SUM(DECODE(S.GUBN,'1',S.TOTAMT
                                                ,S.TOTAMT * -1 )) <> 0
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'26.외래정산금액 외래입원 정산체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;

    END IF;

    --31.카드내역 '*' 확인, 카드번호 '+' 확인
    BEGIN
        SELECT PT_NO
             , '31. 카드내역 */+ 확인'  GUBN
             , 'Y'                      ERRYN
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
          FROM ACPPECPE
         WHERE RPY_DT                = IN_RCPDATE
           AND PT_NO                 = NVL(IN_PT_NO,PT_NO)
           AND CNCL_DTM              IS NULL
--           AND (LENGTH(CARD_APBT_NO) < 5 OR CARD_NO LIKE '+%')
           AND LENGTH(CARD_APBT_NO) < 5
           AND ROWNUM =1  ;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             L_PT_NO   := '';
             L_JOBGUBN := '';
             L_ERRYN   := 'N';
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'31.카드내역 */+ 확인 ERR:'||TO_CHAR(SQLCODE));
    END;

    IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
    END IF;


    -- 32.수납자 ID 누락 확인 체크
    BEGIN
        SELECT XX.PT_NO
             , XX.GUBN   GUBN
             , 'Y'       ERRYN
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
          FROM (
                SELECT PT_NO
                     , 'ACPPEOCE'     GUBN
                  FROM ACPPEOCE
                 WHERE RPY_DT     = IN_RCPDATE
                   AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                   AND RPY_STF_NO IS NULL
                UNION ALL
                SELECT PT_NO
                     , 'ACPPEOPD'     GUBN
                  FROM ACPPEOPD
                 WHERE RPY_DT     = IN_RCPDATE
                   AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                   AND RPY_STF_NO IS NULL
                UNION ALL
                SELECT PT_NO
                     , 'ACPPEIPD'     GUBN
                  FROM ACPPEIPD
                 WHERE RPY_DT     = IN_RCPDATE
                   AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                   AND RPY_STF_NO IS NULL
                UNION ALL
                SELECT PT_NO
                     , 'ACPPEDPD RCP' GUBN
                  FROM ACPPEDPD
                 WHERE RPY_DT     = IN_RCPDATE
                   AND PT_NO      = NVL(IN_PT_NO,PT_NO)
                   AND RPY_STF_NO IS NULL
                UNION ALL
                SELECT PT_NO
                     , 'ACPPEDPD PRO' GUBN
                  FROM ACPPEDPD
                 WHERE PRO_DT        = IN_RCPDATE
                   AND PT_NO         = NVL(IN_PT_NO,PT_NO)
                   AND PRO_WK_STF_NO IS NULL
                ) XX
         WHERE  ROWNUM =1  ;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             L_PT_NO   := '';
             L_JOBGUBN := '';
             L_ERRYN   := 'N';
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'32.수납자 ID 누락 확인 ERR:'||TO_CHAR(SQLCODE));
    END;

    IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| '수납자 ID 누락 '||L_JOBGUBN);
    END IF;

-- 입원 퇴원했는데 유형상세 종료일자 안박힌 것.
    BEGIN
        SELECT A.PT_NO
             , '퇴원환자_유형상세 종료일 확인'  GUBN
             , 'Y'                      ERRYN
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
      FROM ACPPRAAM A --입원접수기본
         , ACPPRIRE B --입원환자유형상세
     WHERE A.DS_DTM BETWEEN TRUNC(SYSDATE)-30 AND SYSDATE + .99999
       AND B.PT_NO = A.PT_NO
       AND B.RPY_PACT_ID = A.PACT_ID
       AND B.APY_STR_DT = (SELECT MAX(APY_STR_DT) FROM ACPPRIRE C WHERE C.PT_NO = A.PT_NO AND C.RPY_PACT_ID = A.PACT_ID )
       AND B.APY_END_DT != A.DS_EXPT_DT
       AND B.MAIN_SUB_YN = 'Y'
       AND A.PT_NO NOT IN (IN_EX_PT_NO1, IN_EX_PT_NO2)
    -- AND A.WD_DEPT_CD = 'ANPAC'
     ;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             L_PT_NO   := '';
             L_JOBGUBN := '';
             L_ERRYN   := 'N';
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'퇴원환자_유형상세 종료일 확인  ERR:'||TO_CHAR(SQLCODE));
    END;

    IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
    END IF;

    -- 입원 퇴원했는데 전과전동 종료일자 안박힌 것.
    BEGIN
        SELECT A.PT_NO
             , '퇴원환자_전과전동 종료일 확인'  GUBN
             , 'Y'                      ERRYN
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
      FROM ACPPRAAM A --입원접수기본
         , ACPPRTSD B
     WHERE A.DS_DTM BETWEEN TRUNC(SYSDATE)-30 AND SYSDATE + .99999
       AND B.PT_NO = A.PT_NO
       AND B.RPY_PACT_ID = A.PACT_ID
       AND B.APY_STR_DT = (SELECT MAX(APY_STR_DT) FROM ACPPRTSD C WHERE C.PT_NO = A.PT_NO AND C.RPY_PACT_ID = A.PACT_ID )
       AND B.APY_END_DT != A.DS_EXPT_DT
       AND A.PT_NO NOT IN (IN_EX_PT_NO1, IN_EX_PT_NO2)
    -- AND A.WD_DEPT_CD = 'ANPAC'
     ;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             L_PT_NO   := '';
             L_JOBGUBN := '';
             L_ERRYN   := 'N';
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'퇴원환자_전과전동 종료일 확인  ERR:'||TO_CHAR(SQLCODE));
    END;


    IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
    END IF;

--    BEGIN
--        SELECT A.PT_NO
--             , '111.입원접수 취소체크' GUBN
--             , 'Y' ERRYN
--          INTO L_PT_NO
--             , L_JOBGUBN
--             , L_ERRYN
--          FROM ACPPRAAM A --입원접수기본
--         WHERE APCN_YN = 'Y'
--           AND APCN_DTM IS NULL;
--    EXCEPTION
--        WHEN NO_DATA_FOUND THEN
--            L_PT_NO := '';
--            L_JOBGUBN := '';
--            L_ERRYN := 'N';
--        WHEN OTHERS THEN
--            RAISE_APPLICATION_ERROR(-20500,'111.입원접수 취소체크 ERR:'||TO_CHAR(SQLCODE));
--    END;
--
--    IF NVL(L_ERRYN,'N') = 'Y' THEN
--        RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
--    END IF;

-- 112.중간금 외래구분에 AER 과 체크
    BEGIN
        SELECT A.PT_NO
             , '112.외래예약금 진료과AER체크' GUBN
             , 'Y' ERRYN
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
          FROM (
                SELECT *
                  FROM ACPPEDPD
                 WHERE RPY_DT = IN_RCPDATE
                   AND GRTY_AMT_INPT_TP_CD IN ('11', '14')
                   AND MED_DEPT_CD = 'ER'

                 UNION ALL

                SELECT *
                  FROM ACPPEDPD
                 WHERE RPY_DT = IN_RCPDATE
                   AND GRTY_AMT_INPT_TP_CD IN ('12', '13')
                   AND MED_DEPT_CD != 'ER'
                ) A
         WHERE ROWNUM = 1;
     EXCEPTION
         WHEN NO_DATA_FOUND THEN
             L_PT_NO := '';
             L_JOBGUBN := '';
             L_ERRYN := 'N';
         WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'112.외래예약금 진료과AER체크 ERR:'||TO_CHAR(SQLCODE));
     END;

     IF NVL(L_ERRYN,'N') = 'Y' THEN
         RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
     END IF;

-- 113.입원 계산 내역에 급종이 L(수탁)인것
    BEGIN
       SELECT XX.PT_NO
                , '48. 입원 계산 내역에 급종이 L(수탁)인것' GUBN
                , 'Y'                              ERRYN
             INTO L_PT_NO
                , L_JOBGUBN
                , L_ERRYN
             FROM (
                   SELECT S.PT_NO
                        , S.SUMPRICE
                     FROM (
                           SELECT PT_NO
                                , (HSP_ADN_ICLS_AMT + CMED_AMT) SUMPRICE
                             FROM ACPPEICE
                            WHERE PT_NO  = NVL(IN_PT_NO,PT_NO)
                              AND CALC_DT = IN_RCPDATE
                              and cncl_dtm is null
                              AND SUBSTR(PME_CLS_CD,1,1) = 'L'
                          ) S
                    GROUP BY S.PT_NO, S.SUMPRICE
                   HAVING S.SUMPRICE <> 0
                  ) XX
             WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
               AND ROWNUM =1;
     EXCEPTION
         WHEN NO_DATA_FOUND THEN
             L_PT_NO := '';
             L_JOBGUBN := '';
             L_ERRYN := 'N';
         WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'48. 입원 계산 내역에 급종이 L(수탁)인것 ERR:'||TO_CHAR(SQLCODE));
     END;

     IF NVL(L_ERRYN,'N') = 'Y' THEN
         RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
     END IF;


    -- 114.입원 수납 내역에 산재인데 다른 계약처 들어간것
    BEGIN
        select a.pt_no                                               pt_no
             , '114.입원 수납 내역에 산재인데 다른 계약처 들어간것'  GUBN
             , 'Y'                                                   erryn
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
          from acppeipd a
             , acpprioe b
         where a.rpy_dt      = IN_RCPDATE
           and a.pme_cls_cd  = 'SA'
           and a.rpy_pact_id = b.rpy_pact_id
           and a.rpy_cls_seq = b.rpy_cls_seq
           and a.apy_str_dt  = b.apy_str_dt
           and a.rpy_seq     = b.rpy_seq
           and b.corg_cd     not in ('IA01')
           and rownum        = 1
        ;
     EXCEPTION
         WHEN NO_DATA_FOUND THEN
             L_PT_NO := '';
             L_JOBGUBN := '';
             L_ERRYN := 'N';
         WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'114.입원 수납 내역에 산재인데 다른 계약처 들어간것 ERR:'||TO_CHAR(SQLCODE));
     END;

     IF NVL(L_ERRYN,'N') = 'Y' THEN
         RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
     END IF;





-- 116.입원에 수탁계약처 'D008' 있는 내역
    BEGIN
        SELECT XX.PT_NO
             , '116.입원에 수탁계약처 ''D008'' 있는 내역 ' || tab   GUBN
             , 'Y'                              ERRYN
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
          FROM (
                select pt_no
                     , 'ACPPRAAM'  tab
                  from acppraam
                 where ads_dt    = IN_RCPDATE
                   and ads_dt    >= to_date('20220729','yyyymmdd')
                   and corg_cd   = 'D008'
                   and rownum    = 1
                union all
                select pt_no
                     , 'ACPPRIRE'  tab
                  from acpprire
                 where apy_str_dt = IN_RCPDATE
                   and apy_str_dt >= to_date('20220729','yyyymmdd')
                   and corg_cd    = 'D008'
                   and rownum     = 1
               ) XX
         WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
           AND ROWNUM =1;
     EXCEPTION
         WHEN NO_DATA_FOUND THEN
             L_PT_NO := '';
             L_JOBGUBN := '';
             L_ERRYN := 'N';
         WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'116.입원에 수탁계약처 ''D008'' 있는 내역 ERR: ' || TO_CHAR(SQLCODE));
     END;

     IF NVL(L_ERRYN,'N') = 'Y' THEN
         RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
     END IF;



    -- 입원 퇴원했는데 전과전동 종료일자 안박힌 것.
    BEGIN
        SELECT A.PT_NO
             , '자보/산재 계약처 오적용'  GUBN
             , 'Y'                        ERRYN
          INTO L_PT_NO
             , L_JOBGUBN
             , L_ERRYN
          FROM ACPPEOPD A
         WHERE A.RPY_DT = in_rcpdate
           AND (
                   (PME_CLS_CD != 'TD' AND SUBSTR(CORG_CD, 1, 1) = 'T')
                OR
                   (SUBSTR(PME_CLS_CD, 1, 1) != 'S' AND SUBSTR(CORG_CD, 1, 1) = 'S')
               )
     ;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             L_PT_NO   := '';
             L_JOBGUBN := '';
             L_ERRYN   := 'N';
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20500,'자보/산재 계약처 오적용 :'||TO_CHAR(SQLCODE));
    END;

    IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
    END IF;


    -- 114.자동미수 중간금 사용 체크
        BEGIN
            SELECT XX.PT_NO
                 , '114.자동미수 중간금 사용 체크'  GUBN
                 , 'Y'                                 ERRYN
              INTO L_PT_NO
                 , L_JOBGUBN
                 , L_ERRYN
              FROM (
                    SELECT S.PT_NO                        PT_NO
                         , S.RPY_STF_NO                   RCPID
                         , S.RPY_SEQ                      RCPSEQ2
                      FROM (
                             SELECT A.PT_NO
                                  , A.RPY_STF_NO
                                  , A.RPY_SEQ
                               FROM ACPPEOPD A
                              WHERE A.RPY_DT           = IN_RCPDATE
                                AND A.PT_NO            = NVL(IN_PT_NO,A.PT_NO)
                                AND A.RPY_STF_NO       LIKE 'AUTO%'
                                AND (A.MRPY_AMT + A.PV_RPY_AMT) != 0

                           ) S
                     GROUP BY S.PT_NO
                            , S.RPY_STF_NO
                            , S.RPY_SEQ
                    ) XX
              WHERE XX.PT_NO  NOT IN ( NVL(IN_EX_PT_NO1,'*'), NVL(IN_EX_PT_NO2,'*') )
                AND ROWNUM =1 ;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 L_PT_NO   := '';
                 L_JOBGUBN := '';
                 L_ERRYN   := 'N';
            WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20500,'114.자동미수 중간금 사용 체크 ERR:'||TO_CHAR(SQLCODE));
        END;

        IF  NVL(L_ERRYN,'N') = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20501,'ERR: '|| L_PT_NO ||' - '|| L_JOBGUBN);
        END IF;

end;







