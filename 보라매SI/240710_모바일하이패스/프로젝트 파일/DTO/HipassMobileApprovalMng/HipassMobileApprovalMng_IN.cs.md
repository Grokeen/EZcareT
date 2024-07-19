using HIS.Core.Common;
using System;
using System.Runtime.Serialization;

namespace HIS.PA.AC.PE.PS.DTO
{
    /// <summary>
    /// name        : #논리DTO 클래스명
    /// desc        : #DTO클래스 개요 
    /// author      : EZCARE 
    /// create date : 2024-07-10 오후 5:21:35
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class HipassMobileApprovalMng_IN : HISDTOBase
    {
        private String IN_FROM_DATE;         //시작일자
        private String IN_TO_DATE;           //종료일자
        private String IN_SMSS_PSB_YN;       //하이패스승인여부



        /// <summary>
        /// name : 시작일자
        /// </summary>
        [DataMember]
        public string in_from_date
        {
            get { return in_from_date; }
            set { if (this.in_from_date != value) { this.in_from_date = value; this.OnPropertyChanged("IN_FROM_DATE"); } }
        }


        /// <summary>
        /// name : 종료일자
        /// </summary>
        [DataMember]
        public string in_to_date
        {
            get { return in_to_date; }
            set { if (this.in_to_date != value) { this.in_to_date = value; this.OnPropertyChanged("IN_TO_DATE"); } }
        }


        /// <summary>
        /// name : 하이패스승인여부
        /// </summary>
        [DataMember]
        public string in_smss_psb_yn
        {
            get { return in_smss_psb_yn; }
            set { if (this.in_smss_psb_yn != value) { this.in_smss_psb_yn = value; this.OnPropertyChanged("IN_SMSS_PSB_YN"); } }
        }
    }
}
