using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

using HSF.TechSvc2010.Common;
using HIS.Core.Common;

namespace HIS.PA.AC.PE.PS.DTO
{
    /// <summary>
    /// name        : ANewPatientRegACPPIMRD_INOUT
    /// desc        : 진료의뢰내역정보
    /// author      : SeoSeokMin 
    /// create date : 2012-04-03 
    /// update date : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class InsSeriousIllnessApplicationFormEDIReg_IN : HISDTOBase
    {
        /// <summary>
        /// name : 환자번호
        /// </summary>  
        [DataMember]
        public string IN_PT_NO
        {
            get { return this.in_pt_no; }
            set { if (this.in_pt_no != value) { this.in_pt_no = value; this.OnPropertyChanged("IN_PT_NO", value); } }
        }
        private string in_pt_no;

        /// <summary>
        /// name : 산정특례종류코드 
        /// </summary>  
        [DataMember]
        public string IN_CFSC_KND_CD
        {
            get { return this.in_cfsc_knd_cd; }
            set { if (this.in_cfsc_knd_cd != value) { this.in_cfsc_knd_cd = value; this.OnPropertyChanged("IN_CFSC_KND_CD", value); } }
        }
        private string in_cfsc_knd_cd;

        /// <summary>
        /// name :중증확인증신청구분코드
        /// </summary>  
        [DataMember]
        public string IN_SRIL_CDOC_APLC_TP_CD
        {
            get { return this.in_sril_cdoc_aplc_tp_cd; }
            set { if (this.in_sril_cdoc_aplc_tp_cd != value) { this.in_sril_cdoc_aplc_tp_cd = value; this.OnPropertyChanged("IN_SRIL_CDOC_APLC_TP_CD", value); } }
        }
        private string in_sril_cdoc_aplc_tp_cd;

        /// <summary>
        /// name : 적용시작일자
        /// </summary>  
        [DataMember]
        public string IN_APY_STR_DT
        {
            get { return this.in_apy_str_dt; }
            set { if (this.in_apy_str_dt != value) { this.in_apy_str_dt = value; this.OnPropertyChanged("IN_APY_STR_DT", value); } }
        }
        private string in_apy_str_dt;

        /// <summary>
        /// name : 중증확인번호
        /// </summary>  
        [DataMember]
        public string IN_SRIL_CFMT_NO
        {
            get { return this.in_sril_cfmt_no; }
            set { if (this.in_sril_cfmt_no != value) { this.in_sril_cfmt_no = value; this.OnPropertyChanged("IN_SRIL_CFMT_NO", value); } }
        }
        private string in_sril_cfmt_no;

        /// <summary>
        /// name : 건강보험증번호 
        /// </summary>  
        [DataMember]
        public string IN_HLTH_INSC_NO
        {
            get { return this.in_hlth_insc_no; }
            set { if (this.in_hlth_insc_no != value) { this.in_hlth_insc_no = value; this.OnPropertyChanged("IN_HLTH_INSC_NO", value); } }
        }
        private string in_hlth_insc_no;

        /// <summary>
        /// name : 등록증수령우편번호 
        /// </summary>  
        [DataMember]
        public string IN_REGB_RECV_POST_NO
        {
            get { return this.in_regb_recv_post_no; }
            set { if (this.in_regb_recv_post_no != value) { this.in_regb_recv_post_no = value; this.OnPropertyChanged("IN_REGB_RECV_POST_NO", value); } }
        }
        private string in_regb_recv_post_no;

        /// <summary>
        /// name : 적용종료일자 
        /// </summary>  
        [DataMember]
        public string IN_APY_END_DT
        {
            get { return this.in_apy_end_dt; }
            set { if (this.in_apy_end_dt != value) { this.in_apy_end_dt = value; this.OnPropertyChanged("IN_APY_END_DT", value); } }
        }
        private string in_apy_end_dt;

        /// <summary>
        /// name : 중증신청일자
        /// </summary>  
        [DataMember]
        public string IN_SRIL_APLC_DT
        {
            get { return this.in_sril_aplc_dt; }
            set { if (this.in_sril_aplc_dt != value) { this.in_sril_aplc_dt = value; this.OnPropertyChanged("IN_SRIL_APLC_DT", value); } }
        }
        private string in_sril_aplc_dt;

        /// <summary>
        /// name : 등록증수령우편번호순번 
        /// </summary>  
        [DataMember]
        public string IN_REGB_RECV_POST_NO_SEQ
        {
            get { return this.in_regb_recv_post_no_seq; }
            set { if (this.in_regb_recv_post_no_seq != value) { this.in_regb_recv_post_no_seq = value; this.OnPropertyChanged("IN_REGB_RECV_POST_NO_SEQ", value); } }
        }
        private string in_regb_recv_post_no_seq;
        /// <summary>
        /// name : 등록증수령주소
        /// </summary>  
        [DataMember]
        public string IN_REGB_RECV_ADDR
        {
            get { return this.in_regb_recv_addr; }
            set { if (this.in_regb_recv_addr != value) { this.in_regb_recv_addr = value; this.OnPropertyChanged("IN_REGB_RECV_ADDR", value); } }
        }
        private string in_regb_recv_addr;
        /// <summary>
        /// name :   발행일자 
        /// </summary>  
        [DataMember]
        public string IN_PBL_DT
        {
            get { return this.in_pbl_dt; }
            set { if (this.in_pbl_dt != value) { this.in_pbl_dt = value; this.OnPropertyChanged("IN_PBL_DT", value); } }
        }
        private string in_pbl_dt;
        /// <summary>
        /// name : 발행지사명
        /// </summary>  
        [DataMember]
        public string IN_PBL_BROF_NM
        {
            get { return this.in_pbl_brof_nm; }
            set { if (this.in_pbl_brof_nm != value) { this.in_pbl_brof_nm = value; this.OnPropertyChanged("IN_PBL_BROF_NM", value); } }
        }
        private string in_pbl_brof_nm;
        /// <summary>
        /// name : 발행지사전화번호                  
        /// </summary>  
        [DataMember]
        public string IN_PBL_BROF_TEL_NO
        {
            get { return this.in_pbl_brof_tel_no; }
            set { if (this.in_pbl_brof_tel_no != value) { this.in_pbl_brof_tel_no = value; this.OnPropertyChanged("IN_PBL_BROF_TEL_NO", value); } }
        }
        private string in_pbl_brof_tel_no;
        /// <summary>
        /// name : 타병원발행여부                          
        /// </summary>  
        [DataMember]
        public string IN_OTHSP_PBL_YN
        {
            get { return this.in_othsp_pbl_yn; }
            set { if (this.in_othsp_pbl_yn != value) { this.in_othsp_pbl_yn = value; this.OnPropertyChanged("IN_OTHSP_PBL_YN", value); } }
        }
        private string in_othsp_pbl_yn;
        /// <summary>
        /// name : 의료급여발급번호            
        /// </summary>  
        [DataMember]
        public string IN_MDC_ISSU_NO
        {
            get { return this.in_mdc_issu_no; }
            set { if (this.in_mdc_issu_no != value) { this.in_mdc_issu_no = value; this.OnPropertyChanged("IN_MDC_ISSU_NO", value); } }
        }
        private string in_mdc_issu_no;
        /// <summary>
        /// name : 진료기록ID                  
        /// </summary>  
        [DataMember]
        public string IN_MDRC_ID
        {
            get { return this.in_mdrc_id; }
            set { if (this.in_mdrc_id != value) { this.in_mdrc_id = value; this.OnPropertyChanged("IN_MDRC_ID", value); } }
        }
        private string in_mdrc_id;

        /// <summary>
        /// name : ICD10코드                   
        /// </summary>  
        [DataMember]
        public string IN_ICD10_CD
        {
            get { return this.in_icd10_cd; }
            set { if (this.in_icd10_cd != value) { this.in_icd10_cd = value; this.OnPropertyChanged("IN_ICD10_CD", value); } }
        }
        private string in_icd10_cd;
        /// <summary>
        /// name : 화상연장여부                
        /// </summary>  
        [DataMember]
        public string IN_SCLD_ETSN_YN
        {
            get { return this.in_scld_etsn_yn; }
            set { if (this.in_scld_etsn_yn != value) { this.in_scld_etsn_yn = value; this.OnPropertyChanged("IN_SCLD_ETSN_YN", value); } }
        }
        private string in_scld_etsn_yn;
        /// <summary>
        /// name : 화상연장작성일시            
        /// </summary>  
        [DataMember]
        public string IN_SCLD_ETSN_WRT_DTM
        {
            get { return this.in_scld_etsn_wrt_dtm; }
            set { if (this.in_scld_etsn_wrt_dtm != value) { this.in_scld_etsn_wrt_dtm = value; this.OnPropertyChanged("IN_SCLD_ETSN_WRT_DTM", value); } }
        }
        private string in_scld_etsn_wrt_dtm;
        /// <summary>
        /// name : 화상연장작성직원번호        
        /// </summary>  
        [DataMember]
        public string IN_SCLD_ETSN_WRT_STF_NO
        {
            get { return this.in_scld_etsn_wrt_stf_no; }
            set { if (this.in_scld_etsn_wrt_stf_no != value) { this.in_scld_etsn_wrt_stf_no = value; this.OnPropertyChanged("IN_SCLD_ETSN_WRT_STF_NO", value); } }
        }
        private string in_scld_etsn_wrt_stf_no;
        /// <summary>
        /// name : 화상연장신청서ID  
        /// </summary>  
        [DataMember]
        public string IN_SCLD_ETSN_APFR_ID
        {
            get { return this.in_scld_etsn_apfr_id; }
            set { if (this.in_scld_etsn_apfr_id != value) { this.in_scld_etsn_apfr_id = value; this.OnPropertyChanged("IN_SCLD_ETSN_APFR_ID", value); } }
        }
        private string in_scld_etsn_apfr_id;
        /// <summary>
        /// name : 합본이전환자번호            
        /// </summary>  
        [DataMember]
        public string IN_BOBD_PT_NO
        {
            get { return this.in_bobd_pt_no; }
            set { if (this.in_bobd_pt_no != value) { this.in_bobd_pt_no = value; this.OnPropertyChanged("IN_BOBD_PT_NO", value); } }
        }
        private string in_bobd_pt_no;

        /// <summary>
        /// name :합본일시  
        /// </summary>  
        [DataMember]
        public string IN_BIND_DTM
        {
            get { return this.in_bind_dtm; }
            set { if (this.in_bind_dtm != value) { this.in_bind_dtm = value; this.OnPropertyChanged("IN_BIND_DTM", value); } }
        }
        private string in_bind_dtm;

        /// <summary>
        /// name : 합본직원번호  
        /// </summary>  
        [DataMember]
        public string IN_BIND_STF_NO
        {
            get { return this.in_bind_stf_no; }
            set { if (this.in_bind_stf_no != value) { this.in_bind_stf_no = value; this.OnPropertyChanged("IN_BIND_STF_NO", value); } }
        }
        private string in_bind_stf_no;
        ///// <summary>
        ///// name : 합본직원번호  
        ///// </summary>  
        //[DataMember]
        //public string IN_FSR_DTM
        //{
        //    get { return this.in_fsr_dtm; }
        //    set { if (this.in_fsr_dtm != value) { this.in_fsr_dtm = value; this.OnPropertyChanged("IN_FSR_DTM", value); } }
        //}  private string in_fsr_dtm; 


        /// <summary>
        /// name : 합본직원번호  
        /// </summary>  
        [DataMember]
        public string IN_SRIL_APLC_SNBK_CD_CNTE
        {
            get { return this.in_sril_aplc_snbk_cd_cnte; }
            set { if (this.in_sril_aplc_snbk_cd_cnte != value) { this.in_sril_aplc_snbk_cd_cnte = value; this.OnPropertyChanged("IN_SRIL_APLC_SNBK_CD_CNTE", value); } }
        }
        private string in_sril_aplc_snbk_cd_cnte;

        /// <summary>
        /// name : 합본직원번호  
        /// </summary>  
        [DataMember]
        public string IN_SRIL_APLC_SNBK_MSG_CNTE
        {
            get { return this.in_sril_aplc_snbk_msg_cnte; }
            set { if (this.in_sril_aplc_snbk_msg_cnte != value) { this.in_sril_aplc_snbk_msg_cnte = value; this.OnPropertyChanged("IN_SRIL_APLC_SNBK_MSG_CNTE", value); } }
        }
        private string in_sril_aplc_snbk_msg_cnte;


        /// <summary>
        /// name : 상병중복연번  
        /// </summary>  
        [DataMember]
        public string APLC_ICD10_DUP_SEQ_CD
        {
            get { return this.aplc_icd10_dup_seq_cd; }
            set { if (this.aplc_icd10_dup_seq_cd != value) { this.aplc_icd10_dup_seq_cd = value; this.OnPropertyChanged("APLC_ICD10_DUP_SEQ_CD", value); } }
        }
        private string aplc_icd10_dup_seq_cd;




        /// <summary>
        /// name : 재등록여부  
        /// </summary>  
        [DataMember]
        public string IN_RRNS_OBST_RREG_YN
        {
            get { return this.in_rrns_obst_rreg_yn; }
            set { if (this.in_rrns_obst_rreg_yn != value) { this.in_rrns_obst_rreg_yn = value; this.OnPropertyChanged("IN_RRNS_OBST_RREG_YN", value); } }
        }

        private String in_rrns_obst_rreg_yn;//재등록여부


        /// <summary>
        /// name : 중복암여부
        /// </summary>  
        [DataMember]
        public string IN_DUP_CNCR_YN
        {
            get { return this.in_dup_cncr_yn; }
            set { if (this.in_dup_cncr_yn != value) { this.in_dup_cncr_yn = value; this.OnPropertyChanged("IN_DUP_CNCR_YN", value); } }
        }
        private String in_dup_cncr_yn;//중복암여부



    }
}
