```sql
<sql id="HIS.PA.AC.PI.PI.SelectWayfarerQualificationApplication">
<!--
    Clss :  text
    Desc :  행려자격신청 조회
    Author : 김재강
    Create date : 2024-08-09
    Update date : 2024-08-09 
    as-is : pkg_bil_srimd.pc_ap_apreqvat_select
-->
SELECT  /*+ HIS.PA.AC.PI.PI.SelectWayfarerQualificationApplication */
        TO_CHAR(A.EMRM_ARVL_DTM,'YYYY-MM-DD HH24:MI') EMRM_ARVL_DTM          --01.진료의뢰일시
     ,  A.HLS_CTH_PATH_TP_CD                          HLS_CTH_PATH_TP_CD     --02.행려내원경로구분코드  (22B)
     ,  XCOM.FT_CCC_CODENAME('22B',A.HLS_CTH_PATH_TP_CD)   
                                                      HLS_CTH_PATH_TP_NM     --03.행려내원경로구분명
     ,  A.HLS_RFOR_NM                                 HLS_RFOR_NM            --04.행려의뢰기관이름
     ,  A.HLS_RFOR_DEPT_NM                            HLS_RFOR_DEPT_NM       --05.행려의뢰기관부서이름
     ,  A.INSU_ORGN_CD                                INSU_ORGN_CD           --06.보험자기관기호
     ,  XBIL.FT_AIM_POB_INF(A.INSU_ORGN_CD,'POB_NM')  INSU_ORGN_NM           --07.보험자기관명
     ,  A.HLS_MNG_NO                                  HLS_MNG_NO             --08.행려관리번호
     ,  A.HLS_RJT_RSN_TP_CD                           HLS_RJT_RSN_TP_CD      --09.행려불가사유구분코드
     ,  XCOM.FT_CCC_CODENAME('22C',A.HLS_RJT_RSN_TP_CD)
                                                      HLS_RJT_RSN_TP_NM      --10.행려불가사유구분명
     ,  A.HLS_RJT_RSN_CNTE                            HLS_RJT_RSN_CNTE       --11.행려불가사유항목
     ,  TO_CHAR(A.HLS_QF_APLC_DT,'YYYY-MM-DD')        HLS_QF_APLC_DT         --12.행려자격신청일
     ,  TO_CHAR(A.HLS_QF_RPY_DT,'YYYY-MM-DD')         HLS_QF_RPY_DT          --13.행려자격회신일
     ,  A.HLS_RMK1                                    HLS_RMK1               --14.비고
     ,  TO_CHAR(A.DTH_DTM,'YYYY-MM-DD')               DTH_DTM                --15.사망일시
     ,  TO_CHAR(A.HLS_FNRL_DT,'yyyy-mm-dd')           HLS_FNRL_DT            --16.행려발인일
     ,  A.HLS_NSHR_DYS                                HLS_NSHR_DYS           --17.행려안치일수
     ,  A.HLS_TH1_MCST_RSLT_CD                        HLS_TH1_MCST_RSLT_CD   --18.행려1차진료비처리결과코드    (22F)
     ,  A.HLS_TH1_MCST_RSLT_NM                        HLS_TH1_MCST_RSLT_NM   --19.행려1차진료비처리결과내용
     ,  TO_CHAR(A.LSH_DTM,'YYYY-MM-DD HH24:MI')       LSH_DTM                --20.최종변경일시
     ,  LSH_STF_NO                                    LSH_STF_NO             --21.최종변경직원번호
     ,  HLS_TH2_MCST_RSLT_CD                          HLS_TH2_MCST_RSLT_CD	 --22.행려2차진료비처리결과코드    (22E)
     ,  HLS_TH2_MCST_RSLT_NM                          HLS_TH2_MCST_RSLT_NM   --23.행려2차진료비처리결과내용
     ,  HLS_RFOR_TEL_NO                               HLS_RFOR_TEL_NO        --24.행려의뢰기관전화번호
     ,  HLS_MTRT_TP_CD                                HLS_MTRT_TP_CD         --25.행려진료결과구분코드
     ,  HLS_MTRT_NM                                   HLS_MTRT_NM            --26.행려진료결과내용
     ,  XCOM.FT_CCC_CODENAME('22D',A.HLS_MTRT_TP_CD)  HLS_MTRT_RMK           --27.행려진료결과구분명   
     ,  A.CHK_LNKG_YN                                 CHK_LNKG_YN            --28.체크리스트 
     ,  A.HLS_RMK2                                    HLS_RMK2               --29.비고2
     ,  A.HLS_RMK3                                    HLS_RMK3               --30.비고3       
     ,  XCOM.FT_CNL_SELSTFINFO('4',LSH_STF_NO,NULL)   LSH_STF_NM	     	 --31.최종변경직원명	 
  FROM  ACPPIHLD A         -- 행려자격신청서 
 WHERE  A.PT_NO          = :IN_PT_NO
 ORDER  BY A.EMRM_ARVL_DTM DESC
</sql>
```