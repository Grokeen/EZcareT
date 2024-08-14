using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;
using HIS.Core.Common;
using HSF.TechSvc2010.Common;

namespace HIS.PA.AC.PI.PI.DTO.SelectWayfarerAsk
{
    /// <summary>
    /// name        : 행려환자내역조회 
    /// desc        : 행려환자내역조회 OUT DTO
    /// author      : 김용록 
    /// create date : 2024-08-13 오후 7:24:16
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class SelectWayfarerAsk_OUT : HISDTOBase

    {

        private string emrm_arvl_dtm;             /* 1.의뢰일시 */
        private string pt_no;                     /* 2.환자번호 */
        private string pt_nm;                     /* 3.환자명 */
        private string pt_rrn;                    /* 4.주민번호 */
        private string pme_cls_cd;                /* 5.환자유형(입원/외래) */
        private string corg_nm;                   /* 6.계약처명_ */
        private string hls_cth_path_tp_cd;        /* 7.내원경로 (코드)*/
        private string hls_cth_path_tp_nm;        /* 7.내원경로 (명)*/
        private string hls_rfor_nm;               /* 8.의뢰처 */
        private string hls_rfor_dept_nm;          /* 9.부서명 */
        private string hls_mng_no;                /* 10.전산관리번호 */

        private string hls_qf_aplc_dt;            /* 11.신청일자_ */
        private string hls_qf_rpy_dt;             /* 12.회신일자 */
        private string insu_orgn_cd;              /* 13.보장기관 (코드) */
        private string hls_rjt_rsn_tp_cd;         /* 14.불가사유 (코드) */
        private string hls_rjt_rsn_tp_nm;         /* 14.불가사유 (명) */
        private string hls_th_mcst_rslt_nm;       /* 15.진료결과 */
        private string pt_chot_sts_cd;            /* 16.퇴실일자_ */
        private string ds_dtm;                    /* 17.퇴원일자 */
        private string room_dir;                  /* 18.병동병실 */
        private string hls_rmk1;                  /* 19.비고 */

        private string hls_rmk2;                  /* 20.비고2 */
        private string hls_rmk3;                  /* 21.비고3_ */
        private string chk_lnkg_yn;               /* 22.CHECK LIST */
        private decimal mtcs_amt;                 /* 23.진료비총액(입원/외래) */
        private decimal ins_sum_amt;              /* 24.급여금액(입원/외래) */
        private decimal nins_sum_amt;             /* 25.비급여금액_(입원/외래) */
        private decimal pbdn_hglm_ins_pt_brdn_amt;/* 26.환자부담총액단체부담금(입원/외래) */
        private decimal again_sss;                /* 27.단체감액(입원/외래) */
        private decimal uncl_amt;                 /* 28.미수납액(입원/외래) */
        private decimal rpy_amt;                  /* 29.수납금액_(입원/외래) */

        private string pbdn_hglm_ins_dmd_amt;     /* 30.청구여부(입원/외래)  */
        private string goo_bn;                    /* 31.입원/외래 구분 */
        private string fsr_dtm;                   /* 32.등록일시 */
        private string fsr_stf_nm;                /* 33.등록자 */
        /// <summary>
        /// name : 1.의뢰일시
        /// </summary>
        [DataMember]
        public string EMRM_ARVL_DTM
        {
            get { return emrm_arvl_dtm; }
            set { if (this.emrm_arvl_dtm != value) { this.emrm_arvl_dtm = value; this.OnPropertyChanged("EMRM_ARVL_DTM"); } }
        }
        /// <summary>
        /// name : 2.환자번호
        /// </summary>
        [DataMember]
        public string PT_NO
        {
            get { return pt_no; }
            set { if (this.pt_no != value) { this.pt_no = value; this.OnPropertyChanged("PT_NO"); } }
        }
        /// <summary>
        /// name : 3.환자명
        /// </summary>
        [DataMember]
        public string PT_NM
        {
            get { return pt_nm; }
            set { if (this.pt_nm != value) { this.pt_nm = value; this.OnPropertyChanged("PT_NM"); } }
        }
        /// <summary>
        /// name : 4.주민번호 
        /// </summary>
        [DataMember]
        public string PT_RRN
        {
            get { return pt_rrn; }
            set { if (this.pt_rrn != value) { this.pt_rrn = value; this.OnPropertyChanged("PT_RRN"); } }
        }
        /// <summary>
        /// name : 5.환자유형(입원/외래) 
        /// </summary>
        [DataMember]
        public string PME_CLS_CD
        {
            get { return pme_cls_cd; }
            set { if (this.pme_cls_cd != value) { this.pme_cls_cd = value; this.OnPropertyChanged("PME_CLS_CD"); } }
        }
        /// <summary>
        /// name : 6.계약처명_
        /// </summary>
        [DataMember]
        public string CORG_NM
        {
            get { return corg_nm; }
            set { if (this.corg_nm != value) { this.corg_nm = value; this.OnPropertyChanged("CORG_NM"); } }
        }
        /// <summary>
        /// name : 7.내원경로 (코드)
        /// </summary>
        [DataMember]
        public string HLS_CTH_PATH_TP_CD
        {
            get { return hls_cth_path_tp_cd; }
            set { if (this.hls_cth_path_tp_cd != value) { this.hls_cth_path_tp_cd = value; this.OnPropertyChanged("HLS_CTH_PATH_TP_CD"); } }
        }
        /// <summary>
        /// name : 7.내원경로 (명)
        /// </summary>
        [DataMember]
        public string HLS_CTH_PATH_TP_NM
        {
            get { return hls_cth_path_tp_nm; }
            set { if (this.hls_cth_path_tp_nm != value) { this.hls_cth_path_tp_nm = value; this.OnPropertyChanged("HLS_CTH_PATH_TP_NM"); } }
        }
        /// <summary>
        /// name : 8.의뢰처
        /// </summary>
        [DataMember]
        public string HLS_RFOR_NM
        {
            get { return hls_rfor_nm; }
            set { if (this.hls_rfor_nm != value) { this.hls_rfor_nm = value; this.OnPropertyChanged("HLS_RFOR_NM"); } }
        }
        /// <summary>
        /// name : 9.부서명
        /// </summary>
        [DataMember]
        public string HLS_RFOR_DEPT_NM
        {
            get { return hls_rfor_dept_nm; }
            set { if (this.hls_rfor_dept_nm != value) { this.hls_rfor_dept_nm = value; this.OnPropertyChanged("HLS_RFOR_DEPT_NM"); } }
        }
        /// <summary>
        /// name : 10.전산관리번호
        /// </summary>
        [DataMember]
        public string HLS_MNG_NO
        {
            get { return hls_mng_no; }
            set { if (this.hls_mng_no != value) { this.hls_mng_no = value; this.OnPropertyChanged("HLS_MNG_NO"); } }
        }
        /// <summary>
        /// name : 11.신청일자_
        /// </summary>
        [DataMember]
        public string HLS_QF_APLC_DT
        {
            get { return hls_qf_aplc_dt; }
            set { if (this.hls_qf_aplc_dt != value) { this.hls_qf_aplc_dt = value; this.OnPropertyChanged("HLS_QF_APLC_DT"); } }
        }
        /// <summary>
        /// name : 12.회신일자
        /// </summary>
        [DataMember]
        public string HLS_QF_RPY_DT
        {
            get { return hls_qf_rpy_dt; }
            set { if (this.hls_qf_rpy_dt != value) { this.hls_qf_rpy_dt = value; this.OnPropertyChanged("HLS_QF_RPY_DT"); } }
        }
        /// <summary>
        /// name : 13.보장기관 (코드)
        /// </summary>
        [DataMember]
        public string INSU_ORGN_CD
        {
            get { return insu_orgn_cd; }
            set { if (this.insu_orgn_cd != value) { this.insu_orgn_cd = value; this.OnPropertyChanged("INSU_ORGN_CD"); } }
        }
        /// <summary>
        /// name : 14.불가사유 (코드)
        /// </summary>
        [DataMember]
        public string HLS_RJT_RSN_TP_CD
        {
            get { return hls_rjt_rsn_tp_cd; }
            set { if (this.hls_rjt_rsn_tp_cd != value) { this.hls_rjt_rsn_tp_cd = value; this.OnPropertyChanged("HLS_RJT_RSN_TP_CD"); } }
        }
        /// <summary>
        /// name : 14.불가사유 (명)
        /// </summary>
        [DataMember]
        public string HLS_RJT_RSN_TP_NM
        {
            get { return hls_rjt_rsn_tp_nm; }
            set { if (this.hls_rjt_rsn_tp_nm != value) { this.hls_rjt_rsn_tp_nm = value; this.OnPropertyChanged("HLS_RJT_RSN_TP_NM"); } }
        }
        /// <summary>
        /// name : 15.진료결과 
        /// </summary>
        [DataMember]
        public string HLS_TH_MCST_RSLT_NM
        {
            get { return hls_th_mcst_rslt_nm; }
            set { if (this.hls_th_mcst_rslt_nm != value) { this.hls_th_mcst_rslt_nm = value; this.OnPropertyChanged("HLS_TH_MCST_RSLT_NM"); } }
        }
        /// <summary>
        /// name : 16.퇴실일자_ 
        /// </summary>
        [DataMember]
        public string PT_CHOT_STS_CD
        {
            get { return pt_chot_sts_cd; }
            set { if (this.pt_chot_sts_cd != value) { this.pt_chot_sts_cd = value; this.OnPropertyChanged("PT_CHOT_STS_CD"); } }
        }
        /// <summary>
        /// name : 17.퇴원일자 
        /// </summary>
        [DataMember]
        public string DS_DTM
        {
            get { return ds_dtm; }
            set { if (this.ds_dtm != value) { this.ds_dtm = value; this.OnPropertyChanged("DS_DTM"); } }
        }
        /// <summary>
        /// name : 18.병동병실
        /// </summary>
        [DataMember]
        public string ROOM_DIR
        {
            get { return room_dir; }
            set { if (this.room_dir != value) { this.room_dir = value; this.OnPropertyChanged("ROOM_DIR"); } }
        }
        /// <summary>
        /// name : 19.비고1
        /// </summary>
        [DataMember]
        public string HLS_RMK1
        {
            get { return hls_rmk1; }
            set { if (this.hls_rmk1 != value) { this.hls_rmk1 = value; this.OnPropertyChanged("HLS_RMK1"); } }
        }
        /// <summary>
        /// name : 20.비고2
        /// </summary>
        [DataMember]
        public string HLS_RMK2
        {
            get { return hls_rmk2; }
            set { if (this.hls_rmk2 != value) { this.hls_rmk2 = value; this.OnPropertyChanged("HLS_RMK2"); } }
        }
        /// <summary>
        /// name : 21.비고3_
        /// </summary>
        [DataMember]
        public string HLS_RMK3
        {
            get { return hls_rmk3; }
            set { if (this.hls_rmk3 != value) { this.hls_rmk3 = value; this.OnPropertyChanged("HLS_RMK3"); } }
        }
        /// <summary>
        /// name : 22.CHECK LIST
        /// </summary>
        [DataMember]
        public string CHK_LNKG_YN
        {
            get { return chk_lnkg_yn; }
            set { if (this.chk_lnkg_yn != value) { this.chk_lnkg_yn = value; this.OnPropertyChanged("CHK_LNKG_YN"); } }
        }
        /// <summary>
        /// name : 23.진료비총액(입원/외래)
        /// </summary>
        [DataMember]
        public decimal MTCS_AMT
        {
            get { return mtcs_amt; }
            set { if (this.mtcs_amt != value) { this.mtcs_amt = value; this.OnPropertyChanged("MTCS_AMT"); } }
        }
        /// <summary>
        /// name : 24.급여금액(입원/외래)
        /// </summary>
        [DataMember]
        public decimal INS_SUM_AMT
        {
            get { return ins_sum_amt; }
            set { if (this.ins_sum_amt != value) { this.ins_sum_amt = value; this.OnPropertyChanged("INS_SUM_AMT"); } }
        }
        /// <summary>
        /// name : 25.비급여금액_(입원/외래)
        /// </summary>
        [DataMember]
        public decimal NINS_SUM_AMT
        {
            get { return nins_sum_amt; }
            set { if (this.nins_sum_amt != value) { this.nins_sum_amt = value; this.OnPropertyChanged("NINS_SUM_AMT"); } }
        }
        /// <summary>
        /// name : 26.환자부담총액단체부담금(입원/외래)
        /// </summary>
        [DataMember]
        public decimal PBDN_HGLM_INS_PT_BRDN_AMT
        {
            get { return pbdn_hglm_ins_pt_brdn_amt; }
            set { if (this.pbdn_hglm_ins_pt_brdn_amt != value) { this.pbdn_hglm_ins_pt_brdn_amt = value; this.OnPropertyChanged("PBDN_HGLM_INS_PT_BRDN_AMT"); } }
        }
        /// <summary>
        /// name : 27.단체감액(입원/외래)
        /// </summary>
        [DataMember]
        public decimal AGAIN_SSS
        {
            get { return again_sss; }
            set { if (this.again_sss != value) { this.again_sss = value; this.OnPropertyChanged("AGAIN_SSS"); } }
        }
        /// <summary>
        /// name : 28.미수납액(입원/외래)
        /// </summary>
        [DataMember]
        public decimal UNCL_AMT
        {
            get { return uncl_amt; }
            set { if (this.uncl_amt != value) { this.uncl_amt = value; this.OnPropertyChanged("UNCL_AMT"); } }
        }
        /// <summary>
        /// name : 29.수납금액_(입원/외래)
        /// </summary>
        [DataMember]
        public decimal RPY_AMT
        {
            get { return rpy_amt; }
            set { if (this.rpy_amt != value) { this.rpy_amt = value; this.OnPropertyChanged("RPY_AMT"); } }
        }
        /// <summary>
        /// name : 30.청구여부(입원/외래)
        /// </summary>
        [DataMember]
        public string PBDN_HGLM_INS_DMD_AMT
        {
            get { return pbdn_hglm_ins_dmd_amt; }
            set { if (this.pbdn_hglm_ins_dmd_amt != value) { this.pbdn_hglm_ins_dmd_amt = value; this.OnPropertyChanged("PBDN_HGLM_INS_DMD_AMT"); } }
        }
        /// <summary>
        /// name : 31.입원/외래 구분 
        /// </summary>
        [DataMember]
        public string GOO_BN
        {
            get { return goo_bn; }
            set { if (this.goo_bn != value) { this.goo_bn = value; this.OnPropertyChanged("GOO_BN"); } }
        }
        /// <summary>
        /// name : 32.등록일시
        /// </summary>
        [DataMember]
        public string FSR_DTM
        {
            get { return fsr_dtm; }
            set { if (this.fsr_dtm != value) { this.fsr_dtm = value; this.OnPropertyChanged("FSR_DTM"); } }
        }
        /// <summary>
        /// name : 33.등록자
        /// </summary>
        [DataMember]
        public string FSR_STF_NM
        {
            get { return fsr_stf_nm; }
            set { if (this.fsr_stf_nm != value) { this.fsr_stf_nm = value; this.OnPropertyChanged("FSR_STF_NM"); } }
        }
    }
}
