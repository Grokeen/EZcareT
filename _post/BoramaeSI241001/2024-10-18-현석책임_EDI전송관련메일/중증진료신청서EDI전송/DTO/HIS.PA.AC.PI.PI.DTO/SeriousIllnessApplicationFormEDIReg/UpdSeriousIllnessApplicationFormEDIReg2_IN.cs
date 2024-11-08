using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

using HSF.TechSvc2010.Common;
using HIS.Core.Common;

namespace HIS.PA.AC.PI.PI.DTO
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
    public class UpdSeriousIllnessApplicationFormEDIReg2_IN : HISDTOBase
    {
        //base.HIS_STF_NO;
        //base.HIS_PRGM_ID;
        //base.HIS_PRGM_NM;
        //base.HIS_IP_ADDR;

        /// <summary>
        /// name : IN_DOCTOR_NOTE_ID
        /// </summary>  
        [DataMember]
        public string IN_DOCTOR_NOTE_ID
        {
            get { return this.in_doctor_note_id; }
            set { if (this.in_doctor_note_id != value) { this.in_doctor_note_id = value; this.OnPropertyChanged("IN_DOCTOR_NOTE_ID", value); } }
        }
        private string in_doctor_note_id;

        /// <summary>
        /// name : IN_REGISTNO
        /// </summary>  
        [DataMember]
        public string IN_REGISTNO
        {
            get { return this.in_registno; }
            set { if (this.in_registno != value) { this.in_registno = value; this.OnPropertyChanged("IN_REGISTNO", value); } }
        }
        private string in_registno;

        /// <summary>
        /// name : 합본직원번호  
        /// </summary>  
        [DataMember]
        public string IN_SRIL_APLC_SNBK_CD_CNTE
        {
            get { return this.in_sril_aplc_snbk_cd_cnte; }
            set { if (this.in_sril_aplc_snbk_cd_cnte != value) { this.in_sril_aplc_snbk_cd_cnte = value; this.OnPropertyChanged("IN_SRIL_APLC_SNBK_CD_CNTE", value); } }
        }
        private string in_sril_aplc_snbk_cd_cnte;

        /// <summary>
        /// name : 합본직원번호  
        /// </summary>  
        [DataMember]
        public string IN_SRIL_APLC_SNBK_MSG_CNTE
        {
            get { return this.in_sril_aplc_snbk_msg_cnte; }
            set { if (this.in_sril_aplc_snbk_msg_cnte != value) { this.in_sril_aplc_snbk_msg_cnte = value; this.OnPropertyChanged("IN_SRIL_APLC_SNBK_MSG_CNTE", value); } }
        }
        private string in_sril_aplc_snbk_msg_cnte;


        /// <summary>
        /// name :중증확인증신청구분코드
        /// </summary>  
        [DataMember]
        public string IN_SRIL_CDOC_APLC_TP_CD
        {
            get { return this.in_sril_cdoc_aplc_tp_cd; }
            set { if (this.in_sril_cdoc_aplc_tp_cd != value) { this.in_sril_cdoc_aplc_tp_cd = value; this.OnPropertyChanged("IN_SRIL_CDOC_APLC_TP_CD", value); } }
        }
        private string in_sril_cdoc_aplc_tp_cd;


        /// <summary>
        /// name : 중증확인번호
        /// </summary>  
        [DataMember]
        public string IN_SRIL_CFMT_NO
        {
            get { return this.in_sril_cfmt_no; }
            set { if (this.in_sril_cfmt_no != value) { this.in_sril_cfmt_no = value; this.OnPropertyChanged("IN_SRIL_CFMT_NO", value); } }
        }
        private string in_sril_cfmt_no;

        /// <summary>
        /// name : 적용종료일자 
        /// </summary>  
        [DataMember]
        public string IN_APY_END_DT
        {
            get { return this.in_apy_end_dt; }
            set { if (this.in_apy_end_dt != value) { this.in_apy_end_dt = value; this.OnPropertyChanged("IN_APY_END_DT", value); } }
        }
        private string in_apy_end_dt;

        /// <summary>
        /// name : 적용시작일자
        /// </summary>  
        [DataMember]
        public string IN_APY_STR_DT
        {
            get { return this.in_apy_str_dt; }
            set { if (this.in_apy_str_dt != value) { this.in_apy_str_dt = value; this.OnPropertyChanged("IN_APY_STR_DT", value); } }
        }
        private string in_apy_str_dt;


        /// <summary>
        /// name : 환자번호
        /// </summary>  
        [DataMember]
        public string IN_PT_NO
        {
            get { return this.in_pt_no; }
            set { if (this.in_pt_no != value) { this.in_pt_no = value; this.OnPropertyChanged("IN_PT_NO", value); } }
        }
        private string in_pt_no;
    }
}
