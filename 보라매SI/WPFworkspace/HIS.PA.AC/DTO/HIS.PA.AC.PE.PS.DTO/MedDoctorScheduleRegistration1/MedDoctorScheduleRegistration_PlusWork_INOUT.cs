using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

using HSF.TechSvc2010.Common;
using HIS.Core.Common;

//namespace HIS.PA.AC.PE.SC.DTO
namespace HIS.PA.AC.PE.PS.DTO
{

    /// ---------------------------------------------------------------------
    /// <summary>
    /// name        : 논리 DTO 클래스 명 
    /// desc        : DTO 클래스 개요 
    /// author      : 김용록 
    /// create date : 2024-09-25 
    /// update date : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    /// ---------------------------------------------------------------------
    [Serializable]
    [DataContract]
    public class MedDoctorScheduleRegistration_PlusWork_INOUT : HISDTOBase
    {

        private string in_dr_stf_no;      // IN_직원번호
        private string in_checked_all;    // IN_전체조회
        private string dr_sid;            // 1.구분 
        private string dept_nm;           // 2.진료과 
        private string stf_nm;            // 3.진료의사 
        private string apy_str_dtm;       // 4.보충진료시작일시 
        private string old_apy_str_dtm;   // 4-0.보충진료시작일시(update)
        private string apy_end_dtm;       // 5.보충진료종료일시 
        private string old_apy_end_dtm;   // 5-0.보충진료종료일시(update)
        private string splm_med_tm;       // 6.보충분(테이블)
        private string splm_med_tm2;      // 6-0.보충분(end-str)
        private string splm_med_hh;       // 6-1.보충시간(테이블) 
        private string splm_med_hh2;      // 6-2.보충시간(end-str) 
        private string sup_memo;          // 7.기타 
        private string fsr_dtm;           // 8.최초등록일시 
        private string fsr_stf_no;        // 9.최초등록자 
        private string lsh_dtm;           // 10.수정일자 
        private string lsh_stf_no;        // 11.수정자
        private string sum_splm_med_tm;   // 12.남은휴진분
        private string sum_splm_med_tm2;  // 12-0.남은휴진시간
        private string cncl_dt;           // 13.취소날짜
        private string tm_unit_cd;        // 14.오전오후구분


        /// <summary>
        /// name : IN_직원번호
        /// </summary>
        [DataMember]
        public string IN_DR_STF_NO
        {
            get { return this.in_dr_stf_no; }
            set { if (this.in_dr_stf_no != value) { this.in_dr_stf_no = value; OnPropertyChanged("IN_DR_STF_NO", value); } }
        }

        /// <summary>
        /// name : IN_전체조회
        /// </summary>
        [DataMember]
        public string IN_CHECKED_ALL
        {
            get { return this.in_checked_all; }
            set { if (this.in_checked_all != value) { this.in_checked_all = value; OnPropertyChanged("IN_CHECKED_ALL", value); } }
        }

        /// <summary>
        /// name : 1.구분
        /// </summary>
        [DataMember]
        public string DR_SID
        {
            get { return this.dr_sid; }
            set { if (this.dr_sid != value) { this.dr_sid = value; OnPropertyChanged("DR_SID", value); } }
        }

        /// <summary>
        /// name : 2.진료과 
        /// </summary>
        [DataMember]
        public string DEPT_NM
        {
            get { return this.dept_nm; }
            set { if (this.dept_nm != value) { this.dept_nm = value; OnPropertyChanged("DEPT_NM", value); } }
        }

        /// <summary>
        /// name : 3.진료의사 
        /// </summary>
        [DataMember]
        public string STF_NM
        {
            get { return this.stf_nm; }
            set { if (this.stf_nm != value) { this.stf_nm = value; OnPropertyChanged("STF_NM", value); } }
        }

        /// <summary>
        /// name : 4.보충진료시작일시 
        /// </summary>
        [DataMember]
        public string APY_STR_DTM
        {
            get { return this.apy_str_dtm; }
            set { if (this.apy_str_dtm != value) { this.apy_str_dtm = value; OnPropertyChanged("APY_STR_DTM", value); } }
        }

        /// <summary>
        /// name : 4-0.보충진료시작일시(update)
        /// </summary>
        [DataMember]
        public string OLD_APY_STR_DTM
        {
            get { return this.old_apy_str_dtm; }
            set { if (this.old_apy_str_dtm != value) { this.old_apy_str_dtm = value; OnPropertyChanged("OLD_APY_STR_DTM", value); } }
        }

        /// <summary>
        /// name : 5.보충진료종료일시 
        /// </summary>
        [DataMember]
        public string APY_END_DTM
        {
            get { return this.apy_end_dtm; }
            set { if (this.apy_end_dtm != value) { this.apy_end_dtm = value; OnPropertyChanged("APY_END_DTM", value); } }
        }

        /// <summary>
        /// name : 5-0.보충진료종료일시(update)
        /// </summary>
        [DataMember]
        public string OLD_APY_END_DTM
        {
            get { return this.old_apy_end_dtm; }
            set { if (this.old_apy_end_dtm != value) { this.old_apy_end_dtm = value; OnPropertyChanged("OLD_APY_END_DTM", value); } }
        }

        /// <summary>
        /// name : 6.보충분(테이블)
        /// </summary>
        [DataMember]
        public string SPLM_MED_TM
        {
            get { return this.splm_med_tm; }
            set { if (this.splm_med_tm != value) { this.splm_med_tm = value; OnPropertyChanged("SPLM_MED_TM", value); } }
        }

        /// <summary>
        /// name : 6-0.보충분(end-str)
        /// </summary>
        [DataMember]
        public string SPLM_MED_TM2
        {
            get { return this.splm_med_tm2; }
            set { if (this.splm_med_tm2 != value) { this.splm_med_tm2 = value; OnPropertyChanged("SPLM_MED_TM2", value); } }
        }

        /// <summary>
        /// name : 6-1.보충시간(테이블) 
        /// </summary>
        [DataMember]
        public string SPLM_MED_HH
        {
            get { return this.splm_med_hh; }
            set { if (this.splm_med_hh != value) { this.splm_med_hh = value; OnPropertyChanged("SPLM_MED_HH", value); } }
        }

        /// <summary>
        /// name : 6-2.보충시간(end-str) 
        /// </summary>
        [DataMember]
        public string SPLM_MED_HH2
        {
            get { return this.splm_med_hh2; }
            set { if (this.splm_med_hh2 != value) { this.splm_med_hh2 = value; OnPropertyChanged("SPLM_MED_HH2", value); } }
        }

        /// <summary>
        /// name : 7.기타 
        /// </summary>
        [DataMember]
        public string SUP_MEMO
        {
            get { return this.sup_memo; }
            set { if (this.sup_memo != value) { this.sup_memo = value; OnPropertyChanged("SUP_MEMO", value); } }
        }

        /// <summary>
        /// name : 8.최초등록일시 
        /// </summary>
        [DataMember]
        public string FSR_DTM
        {
            get { return this.fsr_dtm; }
            set { if (this.fsr_dtm != value) { this.fsr_dtm = value; this.OnPropertyChanged("FSR_DTM", value); } }
        }

        /// <summary>
        /// name : 9.최초등록자 
        /// </summary>
        [DataMember]
        public string FSR_STF_NO
        {
            get { return this.fsr_stf_no; }
            set { if (this.fsr_stf_no != value) { this.fsr_stf_no = value; this.OnPropertyChanged("FSR_STF_NO", value); } }
        }

        /// <summary>
        /// name : 10.수정일자 
        /// </summary>
        [DataMember]
        public string LSH_DTM
        {
            get { return this.lsh_dtm; }
            set { if (this.lsh_dtm != value) { this.lsh_dtm = value; this.OnPropertyChanged("LSH_DTM", value); } }
        }

        /// <summary>
        /// name : 11.수정자
        /// </summary>
        [DataMember]
        public string LSH_STF_NO
        {
            get { return this.lsh_stf_no; }
            set { if (this.lsh_stf_no != value) { this.lsh_stf_no = value; this.OnPropertyChanged("LSH_STF_NO", value); } }
        }

        /// <summary>
        /// name : 12.남은휴진분
        /// </summary>
        [DataMember]
        public string SUM_SPLM_MED_TM
        {
            get { return this.sum_splm_med_tm; }
            set { if (this.sum_splm_med_tm != value) { this.sum_splm_med_tm = value; this.OnPropertyChanged("SUM_SPLM_MED_TM", value); } }
        }

        /// <summary>
        /// name : 12-0.남은휴진시간
        /// </summary>
        [DataMember]
        public string SUM_SPLM_MED_TM2
        {
            get { return this.sum_splm_med_tm2; }
            set { if (this.sum_splm_med_tm2 != value) { this.sum_splm_med_tm2 = value; this.OnPropertyChanged("SUM_SPLM_MED_TM2", value); } }
        }

        /// <summary>
        /// name : 13.취소날짜
        /// </summary>
        [DataMember]
        public string CNCL_DT
        {
            get { return this.cncl_dt; }
            set { if (this.cncl_dt != value) { this.cncl_dt = value; this.OnPropertyChanged("CNCL_DT", value); } }
        }

        /// <summary>
        /// name : 14.오전오후구분
        /// </summary>
        [DataMember]
        public string TM_UNIT_CD
        {
            get { return this.tm_unit_cd; }
            set { if (this.tm_unit_cd != value) { this.tm_unit_cd = value; OnPropertyChanged("TM_UNIT_CD", value); } }
        }
    }
}
