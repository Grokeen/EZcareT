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
    public class SelSeriousIllnessApplicationFormEDIReg1_OUT : HISDTOBase
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
        /// name : PATNAME
        /// </summary>  
        [DataMember]
        public string PATNAME
        {
            get { return this.patname; }
            set { if (this.patname != value) { this.patname = value; this.OnPropertyChanged("PATNAME", value); } }
        }
        private string patname;


        /// <summary>
        /// name : PATNAME
        /// </summary>  
        [DataMember]
        public string LICENCNO
        {
            get { return this.licencno; }
            set { if (this.licencno != value) { this.licencno = value; this.OnPropertyChanged("LICENCNO", value); } }
        }
        private string licencno;


        /// <summary>
        /// name : REQNAME
        /// </summary>  
        [DataMember]
        public string REQNAME
        {
            get { return this.reqname; }
            set { if (this.reqname != value) { this.reqname = value; this.OnPropertyChanged("REQNAME", value); } }
        }
        private string reqname;

        /// <summary>
        /// name : REQNAME
        /// </summary>  
        [DataMember]
        public string REQDATE
        {
            get { return this.reqdate; }
            set { if (this.reqdate != value) { this.reqdate = value; this.OnPropertyChanged("REQDATE", value); } }
        }
        private string reqdate;

        /// <summary>
        /// name : SENDYN
        /// </summary>  
        [DataMember]
        public string SENDYN
        {
            get { return this.sendyn; }
            set { if (this.sendyn != value) { this.sendyn = value; this.OnPropertyChanged("SENDYN", value); } }
        }
        private string sendyn;


        /// <summary>
        /// name : AIDYN
        /// </summary>  
        [DataMember]
        public string AIDYN
        {
            get { return this.aidyn; }
            set { if (this.aidyn != value) { this.aidyn = value; this.OnPropertyChanged("AIDYN", value); } }
        }
        private string aidyn;

        /// <summary>
        /// name : FILETEXT
        /// </summary>  
        [DataMember]
        public string FILETEXT
        {
            get { return this.filetext; }
            set { if (this.filetext != value) { this.filetext = value; this.OnPropertyChanged("FILETEXT", value); } }
        }
        private string filetext;

        /// <summary>
        /// name : DOCTOR_NOTE_ID
        /// </summary>  
        [DataMember]
        public decimal? DOCTOR_NOTE_ID
        {
            get { return this.doctor_note_id; }
            set { if (this.doctor_note_id != value) { this.doctor_note_id = value; this.OnPropertyChanged("DOCTOR_NOTE_ID", value); } }
        }
        private decimal? doctor_note_id;


        /// <summary>
        /// name : REQTYPE
        /// </summary>  
        [DataMember]
        public string REQTYPE
        {
            get { return this.reqtype; }
            set { if (this.reqtype != value) { this.reqtype = value; this.OnPropertyChanged("REQTYPE", value); } }
        }
        private string reqtype;
        /// <summary>
        /// name : UPDATE_YN
        /// </summary>  
        [DataMember]
        public int? UPDATE_YN
        {
            get { return this.update_yn; }
            set { if (this.update_yn != value) { this.update_yn = value; this.OnPropertyChanged("UPDATE_YN", value); } }
        }
        private int? update_yn;
    }
}
