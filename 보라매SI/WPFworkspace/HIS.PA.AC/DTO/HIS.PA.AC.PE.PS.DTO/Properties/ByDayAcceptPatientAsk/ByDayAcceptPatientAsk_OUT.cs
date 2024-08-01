using HIS.Core.Common;
using System;
using System.Runtime.Serialization;

namespace HIS.PA.AC.PE.PS.DTO.ByDayAcceptPatientAsk
{
    /// <summary>
    /// name        : #논리DTO 클래스명
    /// desc        : #DTO클래스 개요 
    /// author      : 김경민 
    /// create date : 2015-12-07 오후 5:02:36
    /// update date : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class ByDayAcceptPatientAsk_OUT : HISDTOBase
    {

        private string pt_no;
        private string pt_nm;
        private string med_dept_cd;
        private string meddr;
        private string med_dt;
        private string pregubn;
        private string mef_rpy_cls_cd;
        private string lsh_dtm;
        private string hsp_tp_cd;
        private string stf_nm;


        /// <summary>
        /// name : PT_NO
        /// </summary>
        [DataMember]
        public string PT_NO
        {
            get { return pt_no; }
            set { if (this.pt_no != value) { this.pt_no = value; this.OnPropertyChanged("PT_NO"); } }
        }

        /// <summary>
        /// name : PT_NM
        /// </summary>
        [DataMember]
        public string PT_NM
        {
            get { return pt_nm; }
            set { if (this.pt_nm != value) { this.pt_nm = value; this.OnPropertyChanged("PT_NM"); } }
        }

        /// <summary>
        /// name : MED_DEPT_CD
        /// </summary>
        [DataMember]
        public string MED_DEPT_CD
        {
            get { return med_dept_cd; }
            set { if (this.med_dept_cd != value) { this.med_dept_cd = value; this.OnPropertyChanged("MED_DEPT_CD"); } }
        }

        /// <summary>
        /// name : MEDDR
        /// </summary>
        [DataMember]
        public string MEDDR
        {
            get { return meddr; }
            set { if (this.meddr != value) { this.meddr = value; this.OnPropertyChanged("MEDDR"); } }
        }

        /// <summary>
        /// name : MED_DT
        /// </summary>
        [DataMember]
        public string MED_DT
        {
            get { return med_dt; }
            set { if (this.med_dt != value) { this.med_dt = value; this.OnPropertyChanged("MED_DT"); } }
        }


        /// <summary>
        /// name : PREGUBN
        /// </summary>
        [DataMember]
        public string PREGUBN
        {
            get { return pregubn; }
            set { if (this.pregubn != value) { this.pregubn = value; this.OnPropertyChanged("PREGUBN"); } }
        }

        /// <summary>
        /// name : MEF_RPY_CLS_CD
        /// </summary>
        [DataMember]
        public string MEF_RPY_CLS_CD
        {
            get { return mef_rpy_cls_cd; }
            set { if (this.mef_rpy_cls_cd != value) { this.mef_rpy_cls_cd = value; this.OnPropertyChanged("MEF_RPY_CLS_CD"); } }
        }


        /// <summary>
        /// name : LSH_DTM
        /// </summary>
        [DataMember]
        public string LSH_DTM
        {
            get { return lsh_dtm; }
            set { if (this.lsh_dtm != value) { this.lsh_dtm = value; this.OnPropertyChanged("LSH_DTM"); } }
        }

        /// <summary>
        /// name : HSP_TP_CD
        /// </summary>
        [DataMember]
        public string HSP_TP_CD
        {
            get { return hsp_tp_cd; }
            set { if (this.hsp_tp_cd != value) { this.hsp_tp_cd = value; this.OnPropertyChanged("HSP_TP_CD"); } }
        }


        /// <summary>
        /// name : STF_NM
        /// </summary>
        [DataMember]
        public string STF_NM
        {
            get { return stf_nm; }
            set { if (this.stf_nm != value) { this.stf_nm = value; this.OnPropertyChanged("STF_NM"); } }
        }



    }
}
