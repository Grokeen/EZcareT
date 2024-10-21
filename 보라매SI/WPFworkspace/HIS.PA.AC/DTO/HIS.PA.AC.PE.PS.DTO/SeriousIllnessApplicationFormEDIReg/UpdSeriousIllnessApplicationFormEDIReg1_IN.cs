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
    public class UpdSeriousIllnessApplicationFormEDIReg1_IN : HISDTOBase
    {
        private string in_fromdate; // 시작일자
        private string in_todate;   // 종료일자        

        /// <summary>
        /// name : 시작일자
        /// </summary>
        [DataMember]
        public string IN_FROMDATE
        {
            get { return this.in_fromdate; }
            set { if (this.in_fromdate != value) { this.in_fromdate = value; base.OnPropertyChanged("IN_FROMDATE", value); } }
        }

        /// <summary>
        /// name : 종료일자
        /// </summary>
        [DataMember]
        public string IN_TODATE
        {
            get { return this.in_todate; }
            set { if (this.in_todate != value) { this.in_todate = value; base.OnPropertyChanged("IN_TODATE", value); } }
        }
        /// <summary>
        /// name : IN_PT_NO
        /// </summary>  
        [DataMember]
        public string IN_PT_NO
        {
            get { return this.in_pt_no; }
            set { if (this.in_pt_no != value) { this.in_pt_no = value; this.OnPropertyChanged("IN_PT_NO", value); } }
        }
        private string in_pt_no;

        /// <summary>
        /// name : IN_REQTYPE
        /// </summary>  
        [DataMember]
        public string IN_REQTYPE
        {
            get { return this.in_reqtype; }
            set { if (this.in_reqtype != value) { this.in_reqtype = value; this.OnPropertyChanged("IN_REQTYPE", value); } }
        }
        private string in_reqtype;

        /// <summary>
        /// name : IN_AIDYN
        /// </summary>  
        [DataMember]
        public string IN_AIDYN
        {
            get { return this.in_aidyn; }
            set { if (this.in_aidyn != value) { this.in_aidyn = value; this.OnPropertyChanged("IN_AIDYN", value); } }
        }
        private string in_aidyn;

        /// <summary>
        /// name : IN_DOCTOR_NOTE_ID
        /// </summary>  
        [DataMember]
        public decimal? IN_DOCTOR_NOTE_ID
        {
            get { return this.in_doctor_note_id; }
            set { if (this.in_doctor_note_id != value) { this.in_doctor_note_id = value; this.OnPropertyChanged("IN_DOCTOR_NOTE_ID", value); } }
        }
        private decimal? in_doctor_note_id;

        /// <summary>
        /// name : IN_SRIL_CDOC
        /// </summary>  
        [DataMember]
        public string IN_SRIL_CDOC
        {
            get { return this.in_sril_cdoc; }
            set { if (this.in_sril_cdoc != value) { this.in_sril_cdoc = value; this.OnPropertyChanged("IN_SRIL_CDOC", value); } }
        }
        private string in_sril_cdoc;
    }
}
