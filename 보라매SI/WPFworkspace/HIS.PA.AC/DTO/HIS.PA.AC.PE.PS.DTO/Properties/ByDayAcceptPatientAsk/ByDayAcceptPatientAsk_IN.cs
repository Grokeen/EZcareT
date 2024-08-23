using HIS.Core.Common;
using System;
using System.Runtime.Serialization;

namespace HIS.PA.AC.PE.PS.DTO.ByDayAcceptPatientAsk
{
    /// <summary>
    /// name        : #논리DTO 클래스명
    /// desc        : #DTO클래스 개요 
    /// author      : 김경민 
    /// create date : 2015-12-07 오후 5:02:26
    /// update date : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class ByDayAcceptPatientAsk_IN : HISDTOBase
    {

        private string in_editdate;
        private string in_editid;
        private string in_hsp_tp_cd;


        /// <summary>
        /// name : 코드명
        /// </summary>
        [DataMember]
        public string IN_EDITDATE
        {
            get { return in_editdate; }
            set { if (this.in_editdate != value) { this.in_editdate = value; this.OnPropertyChanged("IN_EDITDATE"); } }
        }

        /// <summary>
        /// name : 코드명
        /// </summary>
        [DataMember]
        public string IN_EDITID
        {
            get { return in_editid; }
            set { if (this.in_editid != value) { this.in_editid = value; this.OnPropertyChanged("IN_EDITID"); } }
        }

        /// <summary>
        /// name : 코드명
        /// </summary>
        [DataMember]
        public string IN_HSP_TP_CD
        {
            get { return in_hsp_tp_cd; }
            set { if (this.in_hsp_tp_cd != value) { this.in_hsp_tp_cd = value; this.OnPropertyChanged("IN_HSP_TP_CD "); } }
        }

    }
}
