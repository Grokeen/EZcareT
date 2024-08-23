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
    /// desc        : 행려환자내역조회 IN DTO
    /// author      : 김용록 
    /// create date : 2024-08-13 오후 7:24:16
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class SelectWayfarerAsk_IN : HISDTOBase
    {
        private string in_from_date;             /* 조회시작일자 */
        private string in_to_date;               /* 조회종료일자 */
        private string in_pt_no;                 /* 환자번호 */
        /// <summary>
        /// name : 조회시작일자
        /// </summary>
        [DataMember]
        public string IN_FROM_DATE
        {
            get { return in_from_date; }
            set { if (this.in_from_date != value) { this.in_from_date = value; this.OnPropertyChanged("IN_FROM_DATE"); } }
        }
        /// <summary>
        /// name : 조회종료일자
        /// </summary>
        [DataMember]
        public string IN_TO_DATE
        {
            get { return in_to_date; }
            set { if (this.in_to_date != value) { this.in_to_date = value; this.OnPropertyChanged("IN_TO_DATE"); } }
        }
        /// <summary>
        /// name : 환자번호
        /// </summary>
        [DataMember]
        public string IN_PT_NO
        {
            get { return in_pt_no; }
            set { if (this.in_pt_no != value) { this.in_pt_no = value; this.OnPropertyChanged("IN_PT_NO"); } }
        }





    }
}
