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
    public class SelSeriousIllnessApplicationFormEDIReg2_OUT : HISDTOBase
    {
        /// <summary>
        /// name : 환자번호
        /// </summary>  
        [DataMember]
        public string 등록번호
        {
            get { return this._등록번호; }
            set { if (this._등록번호 != value) { this._등록번호 = value; this.OnPropertyChanged("등록번호", value); } }
        }
        private string _등록번호;

        /// <summary>
        /// name : 환자명
        /// </summary>  
        [DataMember]
        public string 환자명
        {
            get { return this._환자명; }
            set { if (this._환자명 != value) { this._환자명 = value; this.OnPropertyChanged("환자명", value); } }
        }
        private string _환자명;

        /// <summary>
        /// name : 주민번호
        /// </summary>  
        [DataMember]
        public string 주민번호
        {
            get { return this._주민번호; }
            set { if (this._주민번호 != value) { this._주민번호 = value; this.OnPropertyChanged("주민번호", value); } }
        }
        private string _주민번호;

        /// <summary>
        /// name : 보험증번호
        /// </summary>  
        [DataMember]
        public string 보험증번호
        {
            get { return this._보험증번호; }
            set { if (this._보험증번호 != value) { this._보험증번호 = value; this.OnPropertyChanged("보험증번호", value); } }
        }
        private string _보험증번호;

        /// <summary>
        /// name : 중증번호
        /// </summary>  
        [DataMember]
        public string 중증번호
        {
            get { return this._중증번호; }
            set { if (this._중증번호 != value) { this._중증번호 = value; this.OnPropertyChanged("중증번호", value); } }
        }
        private string _중증번호;

        /// <summary>
        /// name : 적용개시일
        /// </summary>  
        [DataMember]
        public string 적용개시일
        {
            get { return this._적용개시일; }
            set { if (this._적용개시일 != value) { this._적용개시일 = value; this.OnPropertyChanged("적용개시일", value); } }
        }
        private string _적용개시일;

        /// <summary>
        /// name : 적용종료일
        /// </summary>  
        [DataMember]
        public string 적용종료일
        {
            get { return this._적용종료일; }
            set { if (this._적용종료일 != value) { this._적용종료일 = value; this.OnPropertyChanged("적용종료일", value); } }
        }
        private string _적용종료일;

        /// <summary>
        /// name : YN
        /// </summary>  
        [DataMember]
        public string YN
        {
            get { return this._yn; }
            set { if (this._yn != value) { this._yn = value; this.OnPropertyChanged("YN", value); } }
        }
        private string _yn;


        /// <summary>
        /// name : APLC_DT 
        /// </summary>  
        [DataMember]
        public string APLC_DT
        {
            get { return this.aplc_dt; }
            set { if (this.aplc_dt != value) { this.aplc_dt = value; this.OnPropertyChanged("APLC_DT", value); } }
        }
        private string aplc_dt;

        /// <summary>
        /// name : HMPS_POST_NO 
        /// </summary>  
        [DataMember]
        public string HMPS_POST_NO
        {
            get { return this.hmps_post_no; }
            set { if (this.hmps_post_no != value) { this.hmps_post_no = value; this.OnPropertyChanged("HMPS_POST_NO", value); } }
        }
        private string hmps_post_no;

        /// <summary>
        /// name : HMPS_POST_NO_SEQ 
        /// </summary>  
        [DataMember]
        public string HMPS_POST_NO_SEQ
        {
            get { return this.hmps_post_no_seq; }
            set { if (this.hmps_post_no_seq != value) { this.hmps_post_no_seq = value; this.OnPropertyChanged("HMPS_POST_NO_SEQ", value); } }
        }
        private string hmps_post_no_seq;

        /// <summary>
        /// name :  HM_DTL_ADDR   
        /// </summary>  
        [DataMember]
        public string HM_DTL_ADDR
        {
            get { return this.hm_dtl_addr; }
            set { if (this.hm_dtl_addr != value) { this.hm_dtl_addr = value; this.OnPropertyChanged("HM_DTL_ADDR", value); } }
        }
        private string hm_dtl_addr;


        /// <summary>
        /// name : MDRC_ID
        /// </summary>  
        [DataMember]
        public string MDRC_ID
        {
            get { return this.mdrc_id; }
            set { if (this.mdrc_id != value) { this.mdrc_id = value; this.OnPropertyChanged("MDRC_ID", value); } }
        }
        private string mdrc_id;

        /// <summary>
        /// name : EMPTY_YN
        /// </summary>  
        [DataMember]
        public int? EMPTY_YN
        {
            get { return this.empty_yn; }
            set { if (this.empty_yn != value) { this.empty_yn = value; this.OnPropertyChanged("EMPTY_YN", value); } }
        }
        private int? empty_yn;
        /// <summary>
        /// name : UPLOAD_YN
        /// </summary>  
        [DataMember]
        public int? UPLOAD_YN
        {
            get { return this.upload_yn; }
            set { if (this.upload_yn != value) { this.upload_yn = value; this.OnPropertyChanged("UPLOAD_YN", value); } }
        }
        private int? upload_yn;




        /// <summary>
        /// name : in_j3_gubn
        /// </summary>  
        [DataMember]
        public string IN_J3_GUBN
        {
            get { return this.in_j3_gubn; }
            set { if (this.in_j3_gubn != value) { this.in_j3_gubn = value; this.OnPropertyChanged("IN_J3_GUBN", value); } }
        }
        private string in_j3_gubn;

        /// <summary>
        /// name : IN_RTN_MSG
        /// </summary>  
        [DataMember]
        public string IN_RTN_MSG
        {
            get { return this.in_rtn_msg; }
            set { if (this.in_rtn_msg != value) { this.in_rtn_msg = value; this.OnPropertyChanged("IN_RTN_MSG", value); } }
        }
        private string in_rtn_msg;


        /// <summary>
        /// name : IN_RTNCODE
        /// </summary>  
        [DataMember]
        public string IN_RTNCODE
        {
            get { return this.in_rtncode; }
            set { if (this.in_rtncode != value) { this.in_rtncode = value; this.OnPropertyChanged("IN_RTNCODE", value); } }
        }
        private string in_rtncode;



        /// <summary>
        /// name : APLC_ICD10_DUP_SEQ_CD
        /// </summary>  
        [DataMember]
        public string APLC_ICD10_DUP_SEQ_CD
        {
            get { return this.aplc_icd10_dup_seq_cd; }
            set { if (this.aplc_icd10_dup_seq_cd != value) { this.aplc_icd10_dup_seq_cd = value; this.OnPropertyChanged("APLC_ICD10_DUP_SEQ_CD", value); } }
        }
        private string aplc_icd10_dup_seq_cd;

    }
}
