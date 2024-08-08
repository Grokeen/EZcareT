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


        // 변경되는 값
        private String lsh_stf_no;       // 최종변경하는직원번호
        private String hpcd_cncl_rsn_cd; // 취소코드
        private String cncl_dt;          // 취소날짜 


        // 조회하는 값
        private String pt_no;           // 환자번호
        private String apy_str_dt;      // 시작일자
        private String tkn_no;          // 하이패스토큰번호


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
        /// name : 취소코드 
        /// </summary>
        [DataMember]
        public string HPCD_CNCL_RSN_CD
        {
            get { return hpcd_cncl_rsn_cd; }
            set { if (this.hpcd_cncl_rsn_cd != value) { this.hpcd_cncl_rsn_cd = value; this.OnPropertyChanged("HPCD_CNCL_RSN_CD"); } }
        }

        /// <summary>
        /// name : 취소날짜  
        /// </summary>
        [DataMember]
        public string CNCL_DT
        {
            get { return cncl_dt; }
            set { if (this.cncl_dt != value) { this.cncl_dt = value; this.OnPropertyChanged("CNCL_DT"); } }
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
        /// name : 시작일자
        /// </summary>
        [DataMember]
        public string APY_STR_DT
        {
            get { return apy_str_dt; }
            set { if (this.apy_str_dt != value) { this.apy_str_dt = value; this.OnPropertyChanged("APY_STR_DT"); } }
        }

        /// <summary>
        /// name : 하이패스토큰번호
        /// </summary>
        [DataMember]
        public string TKN_NO
        {
            get { return tkn_no; }
            set { if (this.tkn_no != value) { this.tkn_no = value; this.OnPropertyChanged("TKN_NO"); } }
        }





    }

}
