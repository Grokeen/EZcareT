

        private string in_stf_no;         // 직원번호
        private string dr_sid;            // 1.구분 
        private string dept_nm;           // 2.진료과 
        private string stf_nm;            // 3.진료의사 
        private string apy_str_dtm;       // 4.보충진료시작일시 
        private string old_apy_str_dtm;   // 4-0.보충진료시작일시(update)
        private string apy_emd_dtm;       // 5.보충진료종료일시 
        private string old_apy_emd_dtm;   // 5-0.보충진료종료일시(update)
        private string splm_med_tm;       // 6.보충분(테이블)
        private string splm_med_tm2;      // 6-0.보충분(end-str)
        private string splm_med_hh;       // 6-1.보충시간(테이블) 
        private string splm_med_hh2;      // 6-2.보충시간(end-str) 
        private string sup_memo;          // 7.기타 
        private string fsr_dtm;           // 8.최초등록일시 
        private string fsr_stf_no;        // 9.최초등록자 
        private string lsh_dtm;           // 10.수정일자 
        private string lsh_stf_no;        // 11.수정자
        private string sum_splm_med_tm;   // 12.남은휴진분
        private string sum_splm_med_tm2;  // 12-0.남은휴진시간



private string in_type;/* 신규/수정/삭제 구분 */
private string in_dr_sid;/* 의사직원식별ID */
private string in_med_dept_cd;/* 진료부서코드 */
private string in_apy_str_dtm;/* 적용시작일시 */
private string in_dr_stf_no;/* 의사직원번호 */
private string in_apy_end_dtm;/* 적용종료일시 */
private string in_tm_unit_cd;/* 시간단위코드 */
private string in_sup_memo;/* 보충메모 */
private string in_splm_med_tm;/* 보충진료시간 */
private string in_old_apy_str_dtm;/* UPDATE 적용시작일시('YYYYMMDDHH24MI') */
private string in_old_apy_end_dtm;/* UPDATE 적용종료일시('YYYYMMDDHH24MI') */
private string in_old_lsh_dtm;/* UPDATE 최초등록일시('YYYYMMDDHH24MI') */







```sql
<sql id="HIS.PA.AC.PE.SC.SelectDoctorPlusWork">
<!--
    Clss :  text
    Desc : 보충진료등록 조회
    Author : 김용록
    Create date : 2024-09-25
    Update date : 2024-09-25 
    as-is : pkg_bil_schdr
-->
/*+ HIS.PA.AC.PE.SC.SelectDoctorPlusWork */
UPDATE ACPETHCD 
   SET   LSH_STF_NO = :HIS_STF_NO                                                  /* 최종변경하는직원번호 */
       , LSH_DTM  = SYSDATE                                                        /* 최종변경하는일시 */
       , LSH_PRGM_NM = :HIS_PRGM_NM                                                /* 최종변경하는프로그램명 */
       , LSH_IP_ADDR = :HIS_IP_ADDR                                                /* 최종변경하는IP주소 */
       , HPCD_CNCL_RSN_CD = NVL(:IN_HPCD_CNCL_RSN_CD,NULL)                         /* 취소코드 */
       , CNCL_DT = DECODE(:IN_CNCL_DT,NULL,NULL,TO_DATE(:IN_CNCL_DT,'YYYY-MM-DD')) /* 취소날짜 */
   WHERE  PT_NO = :IN_PT_NO                                                        /* 환자번호 */
     AND APY_STR_DT = TO_DATE(:IN_APY_STR_DT,'YYYY-MM-DD')                         /* 시작일자 */
     AND TKN_NO = :IN_TKN_NO                                                       /* 하이패스토큰번호 */


</sql>
```




