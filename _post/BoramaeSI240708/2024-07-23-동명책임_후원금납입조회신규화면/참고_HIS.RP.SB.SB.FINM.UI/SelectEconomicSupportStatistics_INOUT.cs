using HIS.Core.Common;
using System;
using System.Runtime.Serialization;

namespace HIS.RP.SB.SB.FINM.DTO
{
    /// <summary>
    /// name        : #논리DTO 클래스명
    /// desc        : #DTO클래스 개요 
    /// author      : hwseong 
    /// create date : 2024-07-17 오후 2:02:41
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class SelectEconomicSupportStatistics_INOUT : HISDTOBase
    {
        #region 조회조건 DTO
        private String in_stc_tp;   //통계구분

        /// <summary>
        /// name : 통계구분
        /// </summary>
        [DataMember]
        public String IN_STC_TP
        {
            get { return this.in_stc_tp; }
            set { if (this.in_stc_tp != value) { this.in_stc_tp = value; this.OnPropertyChanged("IN_STC_TP", value); } }
        }

        private String in_date_tp;                  //조회일자구분

        /// <summary>
        /// name : 조회일자구분
        /// </summary>
        [DataMember]
        public String IN_DATE_TP
        {
            get { return this.in_date_tp; }
            set { if (this.in_date_tp != value) { this.in_date_tp = value; this.OnPropertyChanged("IN_DATE_TP", value); } }
        }

        private String in_from_dt;

        /// <summary>
        /// name : 조회시작일
        /// </summary>
        [DataMember]
        public String IN_FROM_DT
        {
            get { return in_from_dt; }
            set { if (this.in_from_dt != value) { this.in_from_dt = value; this.OnPropertyChanged("IN_FROM_DT"); } }
        }

        private String in_to_dt;

        /// <summary>
        /// name : 조회종료일
        /// </summary>
        [DataMember]
        public String IN_TO_DT
        {
            get { return in_to_dt; }
            set { if (this.in_to_dt != value) { this.in_to_dt = value; this.OnPropertyChanged("IN_TO_DT"); } }
        }

        private String in_sppt_corg_cd;                  //기관분류

        /// <summary>
        /// name : 기관분류
        /// </summary>
        [DataMember]
        public String IN_SPPT_CORG_CD
        {
            get { return this.in_sppt_corg_cd; }
            set { if (this.in_sppt_corg_cd != value) { this.in_sppt_corg_cd = value; this.OnPropertyChanged("IN_SPPT_CORG_CD", value); } }
        }

        private String in_dept_cd;                  //진료과

        /// <summary>
        /// name : 진료과
        /// </summary>
        [DataMember]
        public String IN_DEPT_CD
        {
            get { return this.in_dept_cd; }
            set { if (this.in_dept_cd != value) { this.in_dept_cd = value; this.OnPropertyChanged("IN_DEPT_CD", value); } }
        }

        #endregion 조회조건 DTO

        #region 조회결과 DTO
        private string sppt_str_dt;
        /// <summary>
        /// name : 후원일자
        /// </summary>
        [DataMember]
        public string SPPT_STR_DT
        {
            get { return this.sppt_str_dt; }
            set { if (this.sppt_str_dt != value) { this.sppt_str_dt = value; OnPropertyChanged("SPPT_STR_DT", value); } }
        }

        private string sppt_corg_cd;
        /// <summary>
        /// name : 후원사업
        /// </summary>
        [DataMember]
        public string SPPT_CORG_CD
        {
            get { return this.sppt_corg_cd; }
            set { if (this.sppt_corg_cd != value) { this.sppt_corg_cd = value; OnPropertyChanged("SPPT_CORG_CD", value); } }
        }

        private string sppt_corg_cd_nm;
        /// <summary>
        /// name : 후원단체명
        /// </summary>
        [DataMember]
        public string SPPT_CORG_CD_NM
        {
            get { return this.sppt_corg_cd_nm; }
            set { if (this.sppt_corg_cd_nm != value) { this.sppt_corg_cd_nm = value; OnPropertyChanged("SPPT_CORG_CD_NM", value); } }
        }

        private string dept_cd;
        /// <summary>
        /// name : 진료과
        /// </summary>
        [DataMember]
        public string DEPT_CD
        {
            get { return this.dept_cd; }
            set { if (this.dept_cd != value) { this.dept_cd = value; OnPropertyChanged("DEPT_CD", value); } }
        }

        private string dept_cd2;
        /// <summary>
        /// name : 진료과2
        /// </summary>
        [DataMember]
        public string DEPT_CD2
        {
            get { return this.dept_cd2; }
            set { if (this.dept_cd2 != value) { this.dept_cd2 = value; OnPropertyChanged("DEPT_CD2", value); } }
        }

        private string dr;
        /// <summary>
        /// name : 지정의
        /// </summary>
        [DataMember]
        public string DR
        {
            get { return this.dr; }
            set { if (this.dr != value) { this.dr = value; OnPropertyChanged("DR", value); } }
        }

        private decimal? cnt;
        /// <summary>
        /// name : CASE
        /// </summary>
        [DataMember]
        public decimal? CASE
        {
            get { return this.cnt; }
            set { if (this.cnt != value) { this.cnt = value; OnPropertyChanged("CASE", value); this.OnPropertyChanged("CNT"); } }
        }

        private decimal? use_amt;
        /// <summary>
        /// name : 후원 금액
        /// </summary>
        [DataMember]
        public decimal? USE_AMT
        {
            get { return this.use_amt; }
            set { if (this.use_amt != value) { this.use_amt = value; OnPropertyChanged("USE_AMT", value); } }
        }

        /// <summary>
        /// name : 금액 (경제적지원실적)
        /// </summary>
        public decimal? AMT
        {
            get { return this.use_amt; }
            set { if (this.use_amt != value) { this.use_amt = value; OnPropertyChanged("AMT", value); this.OnPropertyChanged("USE_AMT");} }
        }

        private decimal? sppt_amt;
        /// <summary>
        /// name : 상한액
        /// </summary>
        [DataMember]
        public decimal? SPPT_AMT
        {
            get { return this.sppt_amt; }
            set { if (this.sppt_amt != value) { this.sppt_amt = value; OnPropertyChanged("SPPT_AMT", value); } }
        }

        private string sup_item_cd;
        /// <summary>
        /// name : 지원항목
        /// </summary>
        [DataMember]
        public string SUP_ITEM_CD
        {
            get { return this.sup_item_cd; }
            set { if (this.sup_item_cd != value) { this.sup_item_cd = value; OnPropertyChanged("SUP_ITEM_CD", value); } }
        }

        /// <summary>
        /// name : 후원 인원
        /// </summary>
        [DataMember]
        public decimal? CNT
        {
            get { return this.cnt; }
            set { if (this.cnt != value) { this.cnt = value; OnPropertyChanged("CNT", value); } }
        }

        private string gubun;
        /// <summary>
        /// name : GUBUN
        /// </summary>
        [DataMember]
        public string GUBUN
        {
            get { return this.gubun; }
            set { if (this.gubun != value) { this.gubun = value; OnPropertyChanged("GUBUN", value); } }
        }

        private decimal seq;
        /// <summary>
        /// name : SEQ
        /// </summary>
        [DataMember]
        public decimal SEQ
        {
            get { return this.seq; }
            set { if (this.seq != value) { this.seq = value; OnPropertyChanged("SEQ", value); } }
        }

        //내역조회 DTO 추가

        private string pt_no;
        /// <summary>
        /// name : 환자번호
        /// </summary>
        [DataMember]
        public string PT_NO
        {
            get { return this.pt_no; }
            set { if (this.pt_no != value) { this.pt_no = value; OnPropertyChanged("PT_NO", value); } }
        }

        private string pt_nm;
        /// <summary>
        /// name : 환자이름
        /// </summary>
        [DataMember]
        public string PT_NM
        {
            get { return this.pt_nm; }
            set { if (this.pt_nm != value) { this.pt_nm = value; OnPropertyChanged("PT_NM", value); } }
        }

        private string cldg_nm;
        /// <summary>
        /// name : 진단명
        /// </summary>
        [DataMember]
        public string CLDG_NM
        {
            get { return this.cldg_nm; }
            set { if (this.cldg_nm != value) { this.cldg_nm = value; OnPropertyChanged("CLDG_NM", value); } }
        }

        private string cnsl_stf_no;
        /// <summary>
        /// name : 상담자명
        /// </summary>
        [DataMember]
        public string CNSL_STF_NO
        {
            get { return this.cnsl_stf_no; }
            set { if (this.cnsl_stf_no != value) { this.cnsl_stf_no = value; OnPropertyChanged("CNSL_STF_NO", value); } }
        }

        private string rmk_cnte;
        /// <summary>
        /// name : 비고
        /// </summary>
        [DataMember]
        public string RMK_CNTE
        {
            get { return this.rmk_cnte; }
            set { if (this.rmk_cnte != value) { this.rmk_cnte = value; OnPropertyChanged("RMK_CNTE", value); } }
        }

        private string sppt_end_dt;
        /// <summary>
        /// name : 후원종료일자
        /// </summary>
        [DataMember]
        public string SPPT_END_DT
        {
            get { return this.sppt_end_dt; }
            set { if (this.sppt_end_dt != value) { this.sppt_end_dt = value; OnPropertyChanged("SPPT_END_DT", value); } }
        }

        private string sppt_dcsn_dt;
        /// <summary>
        /// name : 지원결정일
        /// </summary>
        [DataMember]
        public string SPPT_DCSN_DT
        {
            get { return this.sppt_dcsn_dt; }
            set { if (this.sppt_dcsn_dt != value) { this.sppt_dcsn_dt = value; OnPropertyChanged("SPPT_DCSN_DT", value); } }
        }

        private string sppt_aplc_dt;
        /// <summary>
        /// name : 지원일
        /// </summary>
        [DataMember]
        public string SPPT_APLC_DT
        {
            get { return this.sppt_aplc_dt; }
            set { if (this.sppt_aplc_dt != value) { this.sppt_aplc_dt = value; OnPropertyChanged("SPPT_APLC_DT", value); } }
        }
        #endregion
    }
}
