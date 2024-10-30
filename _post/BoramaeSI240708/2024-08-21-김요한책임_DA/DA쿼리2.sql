exec :in_acpt_no := '4127076';
exec :in_sr_num := '';
exec :in_pt_no := '';
exec :in_trt_fr_ym := '202301';
exec :in_trt_to_ym := '202301';
exec :in_trt_ty := 'A';
exec :in_dmd_cls := '';
exec :in_in_cls := 'Z';
exec :in_natcast_yn := 'Z';
exec :in_from_csin_date := '';
exec :in_to_csin_date := '';
exec :in_exact := 'A';
exec :in_instmk := '';
exec :in_from_acpt_date := '';
exec :in_to_acpt_date := '';
exec :in_from_ntc_date := '';
exec :in_to_ntc_date := '';
EXEC :in_pt_nm := '';


WITH
    acpt_no_mv
    AS
        ( /*+ HIS.PA.AI.IM.IR.SelectUncollectedInAmtDirectorInsMdcSalary*/
         SELECT A.DMD_ACPT_NO     AS acpt_no
              , A.INS_KND_CD      AS in_cls
              , A.DMD_ACPT_DT     AS acpt_dte
              , A.DMD_NO
           FROM AIMIPRQS a
          WHERE A.DMD_ACPT_NO = :in_acpt_no
                AND A.DMD_PACT_TP_CD IN ('I', 'O')
                AND A.MED_YM BETWEEN :in_trt_fr_ym AND :in_trt_to_yM
                AND A.DMD_PACT_TP_CD = DECODE ( :in_trt_ty,  'A', A.DMD_PACT_TP_CD,  '', A.DMD_PACT_TP_CD,  :in_trt_ty)
                AND A.DMD_TP_CD = NVL ( :in_dmd_cls, A.DMD_TP_CD)
                AND A.INS_KND_CD = DECODE ( :in_in_cls, 'Z', A.INS_KND_CD, :in_in_cls)
                AND A.HIRA_MTFL_CD = CASE WHEN :in_trt_cl IN ('ZZ', '00') THEN A.HIRA_MTFL_CD ELSE :in_trt_cl END
                AND NVL (A.MRT_YN, 'N') IN (CASE WHEN :in_natcast_yn = 'Z' THEN NVL (A.MRT_YN, 'N') ELSE :in_natcast_yn END
                                          , CASE WHEN :in_natcast_yn = 'D' THEN 'Y' ELSE :in_natcast_yn END
                                          , CASE WHEN :in_natcast_yn = 'D' THEN 'Q' ELSE :in_natcast_yn END
                                          , CASE WHEN :in_natcast_yn = 'N' THEN 'X' ELSE :in_natcast_yn END)
                AND NVL (A.MRT_YN, 'N') IN (CASE WHEN :in_trt_cl = '00' THEN 'X' ELSE NVL (A.MRT_YN, 'N') END, CASE WHEN :in_trt_cl = '00' THEN 'Y' ELSE NVL (A.MRT_YN, 'N') END)
                AND A.DMD_ACPT_NO IS NOT NULL
                AND NVL (A.MRT_YN, 'N') NOT IN ('H', 'F'))


        select   /*+ HIS.PA.AI.IM.IR.SelectUncollectedAutomobileInAmt */
                   A.DMD_ACPT_NO                      acpt_no              -- 접수번호
                 , A.DTST_SEQ                       lst_seq              -- 명일련번호
                 , ''                           sr_num              -- 심사차수
                 , ''                          pkg_no          -- 묶음번호
                 , ''                          dmd_no          -- 청구번호
                 , A.PT_NO                         pt_no              -- 환자번호
                   , A.PT_NM                         pt_nm              -- 환자명
                   , SUBSTR(A.RRN,0,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.RRN,800),7,7)          ssn          -- 주민등록번호  --M20130402  sjkang,  DB암호화
                   , TO_CHAR(TO_DATE(a.MED_YM, 'YYYYMM'), 'YYYY-MM')              trt_ym            -- 진료년월
                   , FT_AIM_CCCCCSTE_NM('PA054',a.DMD_PACT_TP_CD, 'N')         trt_ty            -- 진료형태
                   , FT_AIM_CCCCCSTE_NM('271',A.INS_KND_CD,'N')          in_cls              -- 보험구분
                   , FT_AIM_CCCCCSTE_NM('271',A.INS_KND_CD,'N')
                  ||  case when A.NATCASE_YN = 'D' then '(독유)'
                         when A.NATCASE_YN = 'Y' then '(독유)'
                         when A.NATCASE_YN = 'Q' then '(독유)'
                         when A.NATCASE_YN = 'H' then '(행려)'
                         else ''
                      end                          in_cls_nm           -- 보험자         10
                   , FT_AIM_CCCCCSTE_NM('258',A.HIRA_MTFL_CD, 'N')         trt_cl            -- 진료분야
                   , FT_AIM_CCCCCSTE_NM('282',a.DMD_TP_CD, 'N')          dmd_cls            -- 청구구분
                   , to_char(a.acpt_dte, 'YYYY-MM-DD')                acpt_dte        -- 청구일자 (청구일자를 보여달라)
                   , nvl((SELECT CORG_NM
                            FROM ACPPRCUM
                           WHERE TRAI_CMP_CD = A.TRAI_CMP_CD
                             AND TRUNC(SYSDATE) BETWEEN APY_STR_DT
                                                    AND APY_END_DT), '')  union_nm    -- 지급처
                   , (select  z.DEPT_NM
                       from PDEDBMSM  z
                      where  z.DEPT_CD    = a.MED_DEPT_CD)      med_dept           -- 진료과
                   , FT_AIM_CCCCCSTE_NM('356',A.PME_CLS_CD, 'N')         ptty_cd             -- 급종
                   , FT_AIM_CCCCCSTE_NM('357',A.PSE_CLS_CD, 'N')         type_cd            -- 보조
                   , F_D_NAME(A.SCRG_STF_NO)         sr_id            -- 심사자
                   , A.POB_NO                        instmk        -- 거래처코드
                     , A.HIRA_MTFL_CD                       trt_cl        -- 진료분야
                     , A.INS_KND_CD                        in_cls        -- 보험구분
                     , A.DMD_PACT_TP_CD                        trt_ty        -- 진료형태
                     --M20110905  sjkang,  자보 약가 상한차액 반영.
                     , decode(b.conf_check,'2', 0, nvl(A.SCRG_DPHDA_ICLS_MTCS_AMT, nvl(A.SCRG_MTCS_AMT, 0)) + nvl(a.spc_amt, 0))         sftmed_amt      -- 진료비총액
                   , decode(b.conf_check,'2', 0, nvl(A.SCRG_DPHDA_ICLS_MTCS_AMT, nvl(A.SCRG_MTCS_AMT, 0)) + nvl(a.spc_amt, 0))        sfowpy_amt      -- 보험청구액
                     , decode(b.conf_check,'2', 0, nvl(B.CUT_CCRC_AMT, 0) + nvl(B.CLS_PBDN_AMT, 0))        tycha_amt      -- 유형변경 보험청구액
                     , to_char(B.PAY_DT, 'YYYY-MM-DD')                 rcp_dte        -- 입금일자
                     , nvl(B.INAM_AMT, 0)                  csin_amt         -- 입금액
                     , case when nvl(b.conf_check,'1') = '1' then
                         nvl(to_char(B.NTC_DT, 'YYYY-MM-DD'), to_char(c.ntc_dte, 'YYYY-MM-DD'))
                       else null end                          agr_dte             -- 지급동의일자
                     , case when nvl(b.conf_check,'1') = '1' then
                         decode(nvl(B.CUT_AMT,0),0,nvl(c.conf_amt, 0),nvl(B.CUT_AMT,0))
                       else 0 end                                           agr_amt        -- 지급동의금액  30

                     , to_char(B.CHG_DT, 'YYYY-MM-DD')                    remo_dte            -- 변경일자
                     , nvl(B.CUT_CCRC_AMT, 0)                                  remoinp_amt         -- 보험청구
                     , nvl(B.CLS_PBDN_AMT, 0)                                    remoowp_amt         -- 본인부담
                     , case when nvl(b.conf_check,'1') = '1' then
                             to_char(B.SBST_DT, 'YYYY-MM-DD')  --, to_char(d.ntc_dte, 'YYYY-MM-DD'))
                           else
                               null
                           end                         giv_dte             -- 대체일자
                     , case when nvl(b.conf_check,'1') = '1' then
                         nvl(B.SBST_AMT,0)
                         else 0 end                           giv_amt        -- 대체금액
                     , case when nvl(b.conf_check,'1') = '2' then
                           nvl(B.INAM_AMT, 0) * (-1)                         -- (-)입금액
                       else
                            nvl(A.SCRG_DPHDA_ICLS_MTCS_AMT, nvl(A.SCRG_MTCS_AMT, 0)) + nvl(a.spc_amt, 0)    -- 보험청구액
                         - nvl(B.CUT_CCRC_AMT, 0) + nvl(B.CLS_PBDN_AMT, 0)            -- (-)유형변경 보험청구액
                         - nvl(B.INAM_AMT, 0)                         -- (-)입금액
                          - decode(nvl(B.CUT_AMT,0),0,nvl(c.conf_amt,0),nvl(B.CUT_AMT,0)) -- (-)지급동의금액
                          - nvl(B.SBST_AMT,0)                        -- (-)대체금액
                          - nvl(B.ADJ_AMT, 0)
                       end                                              misu_amt    -- 미수금
                     , B.RMK_CNTE                           rmk        -- 비고
                     , B.DTL_CNTE                         tong_gubun    -- 분쟁
                     , B.IHRT_NO                           go_num      -- 대체
                     , B.HIRA_REQ_CNTE                         sim_rmk      -- 기타
                     , nvl(b.rowid, '')                                  rowids          -- 로우아이디
                     , A.DMD_TP_CD                              --청구구분
                     , A.SHIP_SEQ                              --발송순번
                     , A.EPT_DMD_SEQ                              --청구순번
                     , nvl(B.ADJ_AMT, 0)     CUT_AMT2                  --자체조정금액     --2011-03-16 추가
                     , B.dmd_id
                     ,a.DMD_PACT_TP_CD as TRT_TY_1
                     ,a.DMD_TP_CD as DMD_CLS_1
                     ,a.INS_KND_CD as IN_CLS_1
                     ,a.HIRA_MTFL_CD as TRT_CL_1
--                     , c.ntc_dte
                     , NVL (C.ntc_dte, I.ntc_dte)     as ntc_dte
                     , CASE WHEN c.ss_med_amt IS NULL THEN DECODE (k.ss_ss_amt, 0, 0, DECODE (NVL (c.ss_med_amt, 0), 0, a.SCRG_MTCS_AMT, c.ss_med_amt)) ELSE DECODE (k.ss_ss_amt, 0, 0, NVL (c.ss_med_amt, 0)) END                                          ss_med_amt
                     , CASE WHEN c.ss_owpy_amt IS NULL THEN DECODE (k.ss_ss_amt, 0, 0, DECODE (NVL (c.ss_owpy_amt, 0), 0, a.SCRG_PBDN_AMT, c.ss_owpy_amt)) ELSE DECODE (k.ss_ss_amt, 0, 0, NVL (c.ss_owpy_amt, 0)) END                                      ss_owpy_amt
--                     , c.ss_inp_amt
--                     , c.ss_ss_amt
                     ,CASE
                              WHEN c.ss_inp_amt IS NULL THEN DECODE (k.ss_ss_amt, 0, 0, DECODE (NVL (c.ss_inp_amt, 0) + NVL (c.ss_sel_bak_req_amt, 0), 0, a.SCRG_ABDN_AMT + NVL (a.SCRG_SEPAD_DMD_AMT, 0), c.ss_inp_amt + NVL (c.ss_sel_bak_req_amt, 0)))
                              ELSE DECODE (k.ss_ss_amt, 0, 0, NVL (c.ss_inp_amt, 0) + NVL (c.ss_sel_bak_req_amt, 0))
                          END                                                                                                                                                                                                                                  ss_inp_amt

                        , CASE WHEN c.ss_ss_amt IS NULL THEN DECODE (k.ss_ss_amt, 0, 0, DECODE (NVL (c.ss_ss_amt, 0), 0, a.SCRG_ABDN_AMT + NVL (a.SCRG_SEPAD_DMD_AMT, 0), c.ss_ss_amt)) ELSE DECODE (k.ss_ss_amt, 0, 0, NVL (c.ss_ss_amt, 0)) END              ss_ss_amt

            from (select a1.*
                     , a1.DMD_ACPT_DT as  acpt_dte
                     , 0  spc_amt    --선택진료비
                    From AIMIPBAM a1
                   Where :in_acpt_no is null
                     and A1.MED_YM  <= to_date('20130601', 'yyyymmdd')
                     and A1.DMD_WK_STS_CD in ('1','S')
                     and nvl(A1.PT_NO, '*')   = nvl(nvl(:in_pt_no, A1.PT_NO), '*')
                     and A1.DMD_PACT_TP_CD  = decode(:in_trt_ty, 'A', A1.DMD_PACT_TP_CD, '', A1.DMD_PACT_TP_CD, :in_trt_ty)
                     and A1.MED_YM  between to_date(:in_trt_fr_ym, 'YYYYMM') and to_date(:in_trt_to_ym, 'YYYYMM')
                     and A1.DMD_TP_CD = nvl(:in_dmd_cls, A1.DMD_TP_CD)
                     and A1.INS_KND_CD  = '6'
                     and nvl(A1.TRAI_CMP_CD, '*') = nvl(:in_instmk, nvl(A1.TRAI_CMP_CD, '*'))
                     and :in_pt_nm is null
                   union all
                  select     a1.*
                            ,A2.DMD_ACPT_DT as acpt_dte
                            ,0  spc_amt
                    from     AIMIPRQS   a2
                            ,AIMIPBAM   a1
                   where    A2.DMD_PACT_TP_CD   =   decode(:in_trt_ty, 'A', A2.DMD_PACT_TP_CD, '', A2.DMD_PACT_TP_CD, :in_trt_ty)
                     and    to_date(A2.MED_YM,'yyyymm')   between to_date(:in_trt_fr_ym, 'YYYYMM') and to_date(:in_trt_to_ym, 'YYYYMM')
                     and    A2.DMD_TP_CD  =   nvl(:in_dmd_cls, A1.DMD_TP_CD)
                     and    to_date(A2.MED_YM,'yyyymm')   >=  to_date('20130701', 'yyyymmdd')
                     and    A2.DMD_ACPT_NO  =   nvl(:in_acpt_no, A2.DMD_ACPT_NO)
                     and    A2.INS_KND_CD   =   '6'
                     and    A2.DMD_ACPT_NO  is  not null
                     and    A2.SCRG_CLSN_YN    in  ('S', 'Y')
                     and    A1.DMD_ACPT_NO  =   A2.DMD_ACPT_NO
                     and    A1.TRAI_CMP_CD   =   case when A2.TRAI_CMP_CD = '00' then A1.TRAI_CMP_CD else A2.TRAI_CMP_CD end
                     and    nvl(A1.TRAI_CMP_CD, '*') = nvl(:in_instmk, nvl(A1.TRAI_CMP_CD, '*'))
                     and    nvl(A1.PT_NO, '*')   = nvl(nvl(:in_pt_no, A1.PT_NO), '*')
                     and    nvl(a1.DMD_WK_STS_CD, 'N') <>  '3'
                     and    :in_pt_nm is null
                     and    not exists (
                                select 'Exists'
                                  from AIMIPROD a
                                 where A.DMD_ACPT_NO = A1.DMD_ACPT_NO
                                   and A.DTST_SEQ = A1.DTST_SEQ )
                   --M20150102  sjkang, 속도문제로 수정함.
                     union  all
                    select  /*+ index (p1 appatbat_si06)
                                index (a1 aireqbat_si01)
                                pkg_bil_aid711.pc_sel_aireqbat_k26
                             */
                             a1.*
                          ,a1.DMD_ACPT_DT as  acpt_dte
                          ,0  spc_amt    --선택진료비
                      from   PCTPCPAM   p1
                            ,AIMIPBAM   a1
                     where  :in_pt_nm    is  not null
                       and  P1.PT_NM    =   :in_pt_nm
                       and  A1.PT_NO    =   P1.PT_NO
                       and  to_date(A1.MED_YM,'yyyymm')   between to_date(:in_trt_fr_ym, 'YYYYMM')
                                                              and case
                                                             when to_date(:in_trt_to_ym, 'YYYYMM') > to_date('201306', 'YYYYMM')
                                                             then to_date('201306', 'YYYYMM')
                                                             else to_date(:in_trt_to_ym, 'YYYYMM')


                                                         end
                       and  A1.DMD_PACT_TP_CD   =   decode(:in_trt_ty, 'A', A1.DMD_PACT_TP_CD, '', A1.DMD_PACT_TP_CD, :in_trt_ty)
                       and  A1.DMD_WK_STS_CD in ('1','S')
                       and  A1.DMD_TP_CD  =   nvl(:in_dmd_cls, A1.DMD_TP_CD)
                       and  A1.INS_KND_CD  =   '6'
                       and  nvl(A1.TRAI_CMP_CD, '*') = nvl(:in_instmk, nvl(A1.TRAI_CMP_CD, '*'))

                     union  all
                    select  /*+ index (p1 appatbat_si06)
                                index (a1 aireqbat_si01)
                                pkg_bil_aid711.pc_sel_aireqbat_k26
                             */
                             a1.*
                          ,A2.DMD_ACPT_DT as  acpt_dte
                          ,0          spc_amt    --선택진료비
                      from   PCTPCPAM   p1
                            ,AIMIPBAM   a1
                            ,AIMIPRQS   a2
                     where  :in_pt_nm    is  not null
                       and  P1.PT_NM    =   :in_pt_nm
                       and  A1.PT_NO    =   P1.PT_NO
                       and  to_date(A1.MED_YM,'yyyymm')   between case
                                                    when to_date(:in_trt_fr_ym, 'YYYYMM') < to_date('201307', 'YYYYMM')
                                                    then to_date('201307', 'YYYYMM')
                                                    else to_date(:in_trt_fr_ym, 'YYYYMM')
                                                end
                                            and to_date(:in_trt_to_ym, 'YYYYMM')
                       and  A1.DMD_PACT_TP_CD   =   decode(:in_trt_ty, 'A', A1.DMD_PACT_TP_CD, '', A1.DMD_PACT_TP_CD, :in_trt_ty)
                       and  A1.DMD_WK_STS_CD in ('1','S')
                       and  A1.DMD_TP_CD  =   nvl(:in_dmd_cls, A1.DMD_TP_CD)
                       and  A1.INS_KND_CD  =   '6'
                       and  A1.DMD_ACPT_NO  is  not null
                       and  nvl(A1.TRAI_CMP_CD, '*') = nvl(:in_instmk, nvl(A1.TRAI_CMP_CD, '*'))
                       and  A2.DMD_ACPT_NO  =   A1.DMD_ACPT_NO
                       and  A1.TRAI_CMP_CD = case when A2.TRAI_CMP_CD = '00' then A1.TRAI_CMP_CD else A2.TRAI_CMP_CD end
                       and  A2.MED_YM   =   A1.MED_YM
                     and    not exists (
                                select 'Exists'
                                  from AIMIPROD a
                                 where A.DMD_ACPT_NO = A1.DMD_ACPT_NO
                                   and A.DTST_SEQ = A1.DTST_SEQ )

                 ) a
                ,
                 (
                    SELECT CASE
                               WHEN LAG(Z.MED_YM || Z.DMD_PACT_TP_CD || Z.DMD_TP_CD || Z.SHIP_SEQ || Z.INS_KND_CD || Z.HIRA_MTFL_CD || Z.PT_NO || Z.EPT_DMD_SEQ)
                                    OVER (ORDER BY Z.MED_YM, Z.DMD_PACT_TP_CD, Z.DMD_TP_CD, Z.SHIP_SEQ, Z.INS_KND_CD, Z.HIRA_MTFL_CD, Z.PT_NO, Z.EPT_DMD_SEQ, Z.PAY_DT, Z.OCUR_SEQ)
                                    = (Z.MED_YM || Z.DMD_PACT_TP_CD || Z.DMD_TP_CD || Z.SHIP_SEQ || Z.INS_KND_CD || Z.HIRA_MTFL_CD || Z.PT_NO || Z.EPT_DMD_SEQ)
                               THEN '2'
                               ELSE '1'
                           END AS conf_check,
                           Z.RowID,
                           Z.*
                    FROM   AIMIPUTD Z
                    WHERE  Z.INAM_TGT_TP_CD = '01'
                      AND  (Z.PAY_DT IS NOT NULL
                            OR Z.NTC_DT IS NOT NULL
                            OR Z.CUT_CCRC_AMT IS NOT NULL
                            OR Z.SBST_DT IS NOT NULL
                            OR Z.CHG_DT IS NOT NULL)
                      AND  (NVL(Z.INAM_AMT, 0) + NVL(Z.CUT_AMT, 0) + NVL(Z.CUT_CCRC_AMT, 0) + NVL(Z.CLS_PBDN_AMT, 0) + NVL(Z.SBST_AMT, 0) + NVL(Z.ADJ_AMT, 0)) != 0
                    ORDER BY Z.MED_YM, Z.DMD_PACT_TP_CD, Z.DMD_TP_CD, Z.SHIP_SEQ, Z.INS_KND_CD, Z.PT_NO, Z.EPT_DMD_SEQ, Z.PAY_DT, Z.OCUR_SEQ


                  ) b                            -- 03 : 자보(cccodest.ccd_typ = '34T')
                ,(
--                2014년도 이후의 데이터가 없어서 주석처리함.
--                    select   max(nvl(ntc_dte, trunc(inst_dtm))) ntc_dte
--                            ,sum(nvl(conf_amt, 0))              conf_amt
--                            ,trt_ty
--                            ,trt_ym
--                            ,dmd_cls
--                            ,in_cls
--                            ,snd_seq
--                            ,pt_no
--                            ,dmd_seq
--                            ,trt_cl
--                      from   aitadiss
--                     where  trt_ym  between to_date(:in_trt_fr_ym, 'YYYYMM')
--                                        and to_date(:in_trt_to_ym, 'YYYYMM')
--                       and  trt_ym  <   to_date('20130701', 'yyyymmdd')
--                       and  lcd     <>  '14'  --M20110905  sjkang,  항코드 14는 전체 계로 쓰인다.
--                     group  by   trt_ty
--                                ,trt_ym
--                                ,dmd_cls
--                                ,in_cls
--                                ,snd_seq
--                                ,pt_no
--                                ,dmd_seq
--                                ,trt_cl
--                    having  sum(nvl(conf_amt, 0))   !=  0
--                     union  all
                    select   min((select min(D.NTC_DTE) from AIN0201T d where D.SR_NUM = A.SR_NUM)) ntc_dte
                            ,sum(nvl(A.RQ_ALL_TOTMY, 0)
                                -nvl(A.SS_ALL_TOTMY , 0)) conf_amt
                            ,B.DMD_PACT_TP_CD as trt_ty
                            ,B.MED_YM as trt_ym
                            ,B.DMD_TP_CD as dmd_cls
                            ,B.INS_KND_CD as in_cls
                            ,B.SHIP_SEQ as snd_seq
                            ,B.PT_NO
                            ,A.SR_NUM
                            ,B.EPT_DMD_SEQ as dmd_seq
                            ,B.HIRA_MTFL_CD as trt_cl


                            ,sum(a.ss_totmy) as ss_med_amt
                            ,sum(a.ss_owpymy) as ss_owpy_amt
                            ,sum(a.ss_inpmy) as ss_inp_amt
                            ,sum(a.tr_pymny) as ss_ss_amt
                          ,SUM (NVL (a.SS_INSBAK_OWPYMY, 0))         ss_sel_bak_req_amt
                      from   AIN0202T   a
                            ,AIMIPBAM   b
                            ,AIMIPRQS   c
                     where  B.DMD_ACPT_NO   =   A.ACPTNO
                       and  B.DTST_SEQ   =   A.LST_SEQ
                       and  C.DMD_ACPT_NO   =   B.DMD_ACPT_NO
                       --반송건 제외
                       and not exists (select 'Exists'
                                         from AIN0203T x
                                        where X.SR_NUM   = A.SR_NUM
                                          and X.ACPTNO  = B.DMD_ACPT_NO
                                          and X.LST_SEQ  = B.DTST_SEQ
                                          and X.PKG_NO   = A.PKG_NO
                                          and X.ADJ_RSN || X.RDJ_DETAIL_RSN in (select comn_cd from cccccste
                                                                             where comn_grp_cd = '494'
                                                                               and nvl(use_yn, 'Y') = 'Y'
                                                                               and comn_cd not like '8%'
                                                                               )
                                       )
                       --보류건 제외
                       and not exists (select 'Exists'
                                         from AIN0203T    x
                                        where X.SR_NUM    =   A.SR_NUM
                                          and X.ACPTNO   =   B.DMD_ACPT_NO
                                          and X.LST_SEQ   =   B.DTST_SEQ
                                          and X.PKG_NO    =   A.PKG_NO
                                          and X.ADJ_RSN   like    '8%'
                                       )
                     group  by   B.DMD_PACT_TP_CD
                                ,B.MED_YM
                                ,B.DMD_TP_CD
                                ,B.INS_KND_CD
                                ,B.HIRA_MTFL_CD
                                ,B.SHIP_SEQ
                                ,B.PT_NO
                                ,B.EPT_DMD_SEQ
                                ,A.SR_NUM


                 ) c
                ,(SELECT acpt_no
                       , sr_num
                       , dmd_no
                       , pkg_no
                       , ntc_dte
                    FROM (  SELECT B1.ACPTNO                                                          AS acpt_no
                                 , B1.SR_NUM
                                 , B1.DMD_NO
                                 , B1.PKG_NO
                                 , B1.NTC_DTE
                                 , ROW_NUMBER () OVER (PARTITION BY B1.ACPTNO ORDER BY B1.SR_NUM)     snum
                              FROM AIN0201T b1
                             WHERE b1.ACPTNO IN (SELECT acpt_no
                                                   FROM acpt_no_mv
                                                  WHERE in_cls = '6')
                               AND b1.DMD_NO IN (SELECT dmd_no
                                                  FROM acpt_no_mv
                                                 WHERE in_cls = '6')
                          GROUP BY B1.ACPTNO
                                 , B1.SR_NUM
                                 , B1.DMD_NO
                                 , B1.PKG_NO
                                 , B1.NTC_DTE) a
                   WHERE snum = 1
                  UNION ALL
                  SELECT B1.ACPTNO     AS acpt_no
                       , B1.SR_NUM
                       , B1.DMD_NO
                       , B1.PKG_NO
                       , b1.ntc_dte
                    FROM AIN0201T b1, AIN0202T b2
                   WHERE b1.ACPTNO IN (SELECT acpt_no
                                         FROM acpt_no_mv
                                        WHERE in_cls = '6')
                         AND b1.DMD_NO IN (SELECT dmd_no
                                            FROM acpt_no_mv
                                           WHERE in_cls = '6')
                         AND B1.ACPTNO = B2.ACPTNO(+)
                         AND B2.SR_NUM IS NULL) I

                  ,(SELECT acpt_no
                       , lst_seq
                       , ss_ss_amt
                       , CASE
                             WHEN EXISTS
                                      (SELECT 'Exists'
                                         FROM ain0203t
                                        WHERE ACPTNO = k1.acpt_no
                                          AND DMD_NO = k1.dmd_no
                                          AND lst_seq = k1.lst_seq
                                          AND adj_rsn LIKE 'T%')
                             THEN
                                 'Y'
                             ELSE
                                 'N'
                         END    T_ADJ_YN
                       , DMD_NO
                    FROM (  SELECT B1.ACPTNO AS acpt_no
                                 , B1.LST_SEQ
                                 , SUM (B1.TR_PYMNY) AS ss_ss_amt
                                 , B1.DMD_NO
                              FROM AIn0202T b1
                             WHERE b1.ACPTNO IN (SELECT acpt_no
                                                   FROM acpt_no_mv
                                                  WHERE in_cls = '6')
                               AND b1.DMD_NO IN (SELECT dmd_no
                                                  FROM acpt_no_mv
                                                 WHERE in_cls = '6')
                          GROUP BY B1.ACPTNO, B1.LST_SEQ,b1.DMD_NO) k1
                   WHERE ss_ss_amt = 0) k


            Where
                A.PT_NO     = B.PT_NO(+)
             and  A.DMD_PACT_TP_CD     = B.DMD_PACT_TP_CD(+)
           and  A.MED_YM    = B.MED_YM(+)
           and  A.DMD_TP_CD   = B.DMD_TP_CD(+)
           and  A.INS_KND_CD    = B.INS_KND_CD(+)
           and  A.HIRA_MTFL_CD    = B.HIRA_MTFL_CD(+)
           and  A.SHIP_SEQ   = B.SHIP_SEQ(+)
           and  A.EPT_DMD_SEQ   = B.EPT_DMD_SEQ(+)
       and  A.PT_NO     = c.pt_no(+)
             and  A.DMD_PACT_TP_CD     = c.trt_ty(+)
           and  A.MED_YM    = c.trt_ym(+)
           and  A.DMD_TP_CD   = c.dmd_cls(+)
           and  A.INS_KND_CD    = c.in_cls(+)
           and  A.HIRA_MTFL_CD    = c.trt_cl(+)
           and  A.SHIP_SEQ   = c.snd_seq(+)
           and  A.EPT_DMD_SEQ   = c.dmd_seq(+)
           AND a.DMD_ACPT_NO = I.acpt_no(+)
           AND a.DMD_NO = I.dmd_no(+)
             AND NVL (c.sr_num, NVL (I.sr_num, '**')) = NVL ( :IN_SR_NUM, NVL (c.sr_num, NVL (I.sr_num, '**')))
           AND a.DMD_ACPT_NO = k.acpt_no(+)
            AND a.DTST_SEQ = k.lst_seq(+)
             and  nvl(B.PAY_DT, '20000101') between nvl(:in_from_csin_date, '20000101') and nvl(:in_to_csin_date, '21001231')     -- 입금일자
            order by A.MED_YM, A.DMD_PACT_TP_CD, A.DMD_TP_CD, A.SHIP_SEQ, A.INS_KND_CD, A.PT_NO, A.EPT_DMD_SEQ, to_char(B.PAY_DT, 'YYYY-MM-DD'), B.OCUR_SEQ
