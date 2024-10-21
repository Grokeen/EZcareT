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
    public class SelSeriousIllnessApplicationFormEDIReg3_OUT : HISDTOBase
    {
        /// <summary>
        /// name : PT_NO
        /// </summary>  
        [DataMember]
        public string PT_NO
        {
            get { return this.pt_no; }
            set { if (this.pt_no != value) { this.pt_no = value; this.OnPropertyChanged("PT_NO", value); } }
        }
        private string pt_no;

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
        /// name : APLC_DT
        /// </summary>  
        [DataMember]
        public string HMPS_POST_NO
        {
            get { return this.hmps_post_no; }
            set { if (this.hmps_post_no != value) { this.hmps_post_no = value; this.OnPropertyChanged("HMPS_POST_NO", value); } }
        }
        private string hmps_post_no;

        /// <summary>
        /// name : APLC_DT
        /// </summary>  
        [DataMember]
        public decimal? HMPS_POST_NO_SEQ
        {
            get { return this.hmps_post_no_seq; }
            set { if (this.hmps_post_no_seq != value) { this.hmps_post_no_seq = value; this.OnPropertyChanged("HMPS_POST_NO_SEQ", value); } }
        }
        private decimal? hmps_post_no_seq;

        /// <summary>
        /// name : APLC_DT
        /// </summary>  
        [DataMember]
        public string HM_DTL_ADDR
        {
            get { return this.hm_dtl_addr; }
            set { if (this.hm_dtl_addr != value) { this.hm_dtl_addr = value; this.OnPropertyChanged("HM_DTL_ADDR", value); } }
        }
        private string hm_dtl_addr;

        /// <summary>
        /// name : APLC_DT
        /// </summary>  
        [DataMember]
        public string YN
        {
            get { return this.yn; }
            set { if (this.yn != value) { this.yn = value; this.OnPropertyChanged("YN", value); } }
        }
        private string yn;

        /// <summary>
        /// name : APLC_DT
        /// </summary>  
        [DataMember]
        public decimal? MDRC_ID
        {
            get { return this.mdrc_id; }
            set { if (this.mdrc_id != value) { this.mdrc_id = value; this.OnPropertyChanged("MDRC_ID", value); } }
        }
        private decimal? mdrc_id;



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

    }



}
