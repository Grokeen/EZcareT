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
        private String IN_FROM_DATE;     //시작일자
        private String IN_TO_DATE;       //종료일자


        /// <summary>
        /// name : 신청일자
        /// </summary>
        [DataMember]
        public string in_from_date
        {
            get { return in_from_date; }
            set { if (this.in_from_date != value) { this.in_from_date = value; this.OnPropertyChanged("IN_FROM_DATE"); } }
        }


        /// <summary>
        /// name : 환자번호
        /// </summary>
        [DataMember]
        public string in_to_date
        {
            get { return in_to_date; }
            set { if (this.in_to_date != value) { this.in_to_date = value; this.OnPropertyChanged("IN_TO_DATE"); } }
        }



    }
}
