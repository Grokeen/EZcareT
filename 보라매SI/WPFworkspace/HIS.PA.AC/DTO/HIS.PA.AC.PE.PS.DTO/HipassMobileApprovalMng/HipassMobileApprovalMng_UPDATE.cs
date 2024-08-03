using HIS.Core.Common;
using System;
using System.Runtime.Serialization;

namespace HIS.PA.AC.PE.PS.DTO
{
    /// <summary>
    /// name        : HipassMobileApprovalMng_UPDATE
    /// desc        : HipassMobileApprovalMng_UPDATE 
    /// author      : 김용록 
    /// create date : 2024-08-02 오후 5:21:59
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class HipassMobileApprovalMng_UPDATE : HISDTOBase
    {
        //참고 : pkg_bil_ocals.pc_ap_HipssMobileAprvList
        //참고 : PROCEDURE pc_ap_HipssMobileAprv_Upd 
        //참고 : D:\AS-IS소스_20231226\WEB\BIL\ACC\CALS\OCALS


        private String pt_no;       // 환자번호
        private String smss_psb_yn; // 승인여부(승인/취소)  
        private String apy_str_dt;  // 시작일자
        private String lsh_stf_no;  // 최종변경하는직원번호

        // 이 값,,,,어디서,,,
        private String pme_cls_cd;  // 하이패스 토큰(ASIS : in_token_no_skp : SKP 하이패스 토큰)

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
        /// name : 승인여부(승인/취소)  
        /// </summary>
        [DataMember]
        public string SMSS_PSB_YN
        {
            get { return smss_psb_yn; }
            set { if (this.smss_psb_yn != value) { this.smss_psb_yn = value; this.OnPropertyChanged("SMSS_PSB_YN"); } }
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
        /// name : 최종변경하는직원번호
        /// </summary>
        [DataMember]
        public string LSH_STF_NO
        {
            get { return lsh_stf_no; }
            set { if (this.lsh_stf_no != value) { this.lsh_stf_no = value; this.OnPropertyChanged("LSH_STF_NO"); } }
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


    }

}
