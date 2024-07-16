using HIS.Core.Common;
using System;
using System.Runtime.Serialization;

namespace HIS.PA.AC.PE.PS.DTO
{
    /// <summary>
    /// name        : #논리DTO 클래스명
    /// desc        : #DTO클래스 개요 
    /// author      : EZCARE 
    /// create date : 2024-07-10 오후 5:21:59
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class HipassMobileApprovalMng_OUT : HISDTOBase
    {
        private String aplc_dt;     //신청일자
        private String pt_no;       //환자번호
        private String pt_nm;       // 환자명 
        private String apct_rrn;    // 주민번호 
        private String smss_psb_yn; // 승인여부???? 
        private String pme_cls_cd;  // 환자급종 
        private String apy_str_dt;  // 시작일자 
        private String apy_end_dt;  // 종료일자 
        private String card_cmp_nm; // 카드 회사 
        private String apct_nm;     // 카드 명의자 
        private String card_no;     // 카드번호 


        /// <summary>
        /// name : 신청일자
        /// </summary>
        [DataMember]
        public string APLC_DT
        {
            get { return aplc_dt; }
            set { if (this.aplc_dt != value) { this.aplc_dt = value; this.OnPropertyChanged("APLC_DT"); } }
        }


        /// <summary>
        /// name : 환자번호
        /// </summary>
        [DataMember]
        public string PT_NO
        {
            get { return pt_no; }
            set { if (this.pt_no != value) { this.pt_no = value; this.OnPropertyChanged("PT_NO"); } }
        }


        /// <summary>
        /// name : 환자명
        /// </summary>
        [DataMember]
        public string PT_NM
        {
            get { return pt_nm; }
            set { if (this.pt_nm != value) { this.pt_nm = value; this.OnPropertyChanged("PT_NM"); } }
        }


        /// <summary>
        /// name : 주민번호
        /// </summary>
        [DataMember]
        public string APCT_RRN
        {
            get { return apct_rrn; }
            set { if (this.apct_rrn != value) { this.apct_rrn = value; this.OnPropertyChanged("APCT_RRN"); } }
        }


        /// <summary>
        /// name : 승인여부????
        /// </summary>
        [DataMember]
        public string SMSS_PSB_YN
        {
            get { return smss_psb_yn; }
            set { if (this.smss_psb_yn != value) { this.smss_psb_yn = value; this.OnPropertyChanged("SMSS_PSB_YN"); } }
        }



        /// <summary>
        /// name : 환자급종
        /// </summary>
        [DataMember]
        public string PME_CLS_CD
        {
            get { return pme_cls_cd; }
            set { if (this.pme_cls_cd != value) { this.pme_cls_cd = value; this.OnPropertyChanged("PME_CLS_CD"); } }
        }


        /// <summary>
        /// name : 시작일자
        /// </summary>
        [DataMember]
        public string APY_STR_DT
        {
            get { return apy_str_dt; }
            set { if (this.apy_str_dt != value) { this.apy_str_dt = value; this.OnPropertyChanged("APY_STR_DT"); } }
        }


        /// <summary>
        /// name : 종료일자
        /// </summary>
        [DataMember]
        public string APY_END_DT
        {
            get { return apy_end_dt; }
            set { if (this.apy_end_dt != value) { this.apy_end_dt = value; this.OnPropertyChanged("APY_END_DT"); } }
        }


        /// <summary>
        /// name : 카드 회사
        /// </summary>
        [DataMember]
        public string CARD_CMP_NM
        {
            get { return card_cmp_nm; }
            set { if (this.card_cmp_nm != value) { this.card_cmp_nm = value; this.OnPropertyChanged("CARD_CMP_NM"); } }
        }

        /// <summary>
        /// name : 카드 명의자
        /// </summary>
        [DataMember]
        public string APCT_NM
        {
            get { return apct_nm; }
            set { if (this.apct_nm != value) { this.apct_nm = value; this.OnPropertyChanged("APCT_NM"); } }
        }


        /// <summary>
        /// name : 카드번호
        /// </summary>
        [DataMember]
        public string CARD_NO
        {
            get { return card_no; }
            set { if (this.card_no != value) { this.card_no = value; this.OnPropertyChanged("CARD_NO"); } }
        }


    }

}
