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
    /// desc        : 휴진대진일자조회 update / insert 용
    /// author      : 김용록 
    /// create date : 2024-09-25 
    /// update date : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    /// ---------------------------------------------------------------------
    [Serializable]
    [DataContract]
    public class MedDoctorScheduleRegistration_PlusWork_UPDATE : HISDTOBase
    {

        private string in_type;           /* 신규/수정/삭제 구분 */
        private string in_dr_sid;         /* 의사직원식별ID */
        private string in_med_dept_cd;    /* 진료부서코드 */
        private string in_apy_str_dtm;    /* 적용시작일시 */
        private string in_dr_stf_no;      /* 의사직원번호 */
        private string in_apy_end_dtm;    /* 적용종료일시 */
        private string in_tm_unit_cd;     /* 시간단위코드 */
        private string in_sup_memo;       /* 보충메모 */
        private string in_splm_med_tm;    /* 보충진료시간 */
        private string in_old_apy_str_dtm;/* UPDATE 적용시작일시('YYYYMMDDHH24MI') */
        private string in_old_apy_end_dtm;/* UPDATE 적용종료일시('YYYYMMDDHH24MI') */
        private string in_old_lsh_dtm;    /* UPDATE 최초등록일시('YYYYMMDDHH24MI') */

        /// <summary>
        /// name : 신규/수정/삭제 구분
        /// </summary>
        [DataMember]
        public string IN_TYPE
        {
            get { return this.in_type; }
            set { if (this.in_type != value) { this.in_type = value; OnPropertyChanged("IN_TYPE", value); } }
        }

        /// <summary>
        /// name : 의사직원식별ID 
        /// </summary>
        [DataMember]
        public string IN_DR_SID
        {
            get { return this.in_dr_sid; }
            set { if (this.in_dr_sid != value) { this.in_dr_sid = value; OnPropertyChanged("IN_DR_SID", value); } }
        }

        /// <summary>
        /// name : 진료부서코드
        /// </summary>
        [DataMember]
        public string IN_MED_DEPT_CD
        {
            get { return this.in_med_dept_cd; }
            set { if (this.in_med_dept_cd != value) { this.in_med_dept_cd = value; OnPropertyChanged("IN_MED_DEPT_CD", value); } }
        }

        /// <summary>
        /// name : 적용시작일시
        /// </summary>
        [DataMember]
        public string IN_APY_STR_DTM
        {
            get { return this.in_apy_str_dtm; }
            set { if (this.in_apy_str_dtm != value) { this.in_apy_str_dtm = value; OnPropertyChanged("IN_APY_STR_DTM", value); } }
        }

        /// <summary>
        /// name : 의사직원번호
        /// </summary>
        [DataMember]
        public string IN_DR_STF_NO
        {
            get { return this.in_dr_stf_no; }
            set { if (this.in_dr_stf_no != value) { this.in_dr_stf_no = value; OnPropertyChanged("IN_DR_STF_NO", value); } }
        }

        /// <summary>
        /// name : 적용종료일시
        /// </summary>
        [DataMember]
        public string IN_APY_END_DTM
        {
            get { return this.in_apy_end_dtm; }
            set { if (this.in_apy_end_dtm != value) { this.in_apy_end_dtm = value; OnPropertyChanged("IN_APY_END_DTM", value); } }
        }

        /// <summary>
        /// name : 시간단위코드
        /// </summary>
        [DataMember]
        public string IN_TM_UNIT_CD
        {
            get { return this.in_tm_unit_cd; }
            set { if (this.in_tm_unit_cd != value) { this.in_tm_unit_cd = value; OnPropertyChanged("IN_TM_UNIT_CD", value); } }
        }

        /// <summary>
        /// name : 보충메모
        /// </summary>
        [DataMember]
        public string IN_SUP_MEMO
        {
            get { return this.in_sup_memo; }
            set { if (this.in_sup_memo != value) { this.in_sup_memo = value; OnPropertyChanged("IN_SUP_MEMO", value); } }
        }

        /// <summary>
        /// name : 보충진료시간
        /// </summary>
        [DataMember]
        public string IN_SPLM_MED_TM
        {
            get { return this.in_splm_med_tm; }
            set { if (this.in_splm_med_tm != value) { this.in_splm_med_tm = value; OnPropertyChanged("IN_SPLM_MED_TM", value); } }
        }

        /// <summary>
        /// name : UPDATE 적용시작일시('YYYYMMDDHH24MI')
        /// </summary>
        [DataMember]
        public string IN_OLD_APY_STR_DTM
        {
            get { return this.in_old_apy_str_dtm; }
            set { if (this.in_old_apy_str_dtm != value) { this.in_old_apy_str_dtm = value; OnPropertyChanged("IN_OLD_APY_STR_DTM", value); } }
        }

        /// <summary>
        /// name : UPDATE 적용종료일시('YYYYMMDDHH24MI') 
        /// </summary>
        [DataMember]
        public string IN_OLD_APY_END_DTM
        {
            get { return this.in_old_apy_end_dtm; }
            set { if (this.in_old_apy_end_dtm != value) { this.in_old_apy_end_dtm = value; OnPropertyChanged("IN_OLD_APY_END_DTM", value); } }
        }

        /// <summary>
        /// name : UPDATE 최초등록일시('YYYYMMDDHH24MI')
        /// </summary>
        [DataMember]
        public string IN_OLD_LSH_DTM
        {
            get { return this.in_old_lsh_dtm; }
            set { if (this.in_old_lsh_dtm != value) { this.in_old_lsh_dtm = value; OnPropertyChanged("IN_OLD_LSH_DTM", value); } }
        }
    }
}