using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

using HIS.Core.Common;
using HSF.TechSvc2010.Common;

namespace HIS.PA.AC.PC.OP.DTO
{
    /// <summary>
    /// name        : #논리DTO 클래스명
    /// desc        : #DTO클래스 개요 
    /// author      : hjkim 
    /// create date : 2021-09-21 오후 3:04:33
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class OtpStorageAmountNonCompletePaymentAsk_OUT : HISDTOBase
    {
        /// <summary>
        /// name : 등록번호 
        /// </summary>
        [DataMember]
        public String PT_NO
        {
            get { return this.pt_no; }
            set { if (this.pt_no != value) { this.pt_no = value; this.OnPropertyChanged("PT_NO", value); } }
        }
        private String pt_no;



        /// <summary>
        /// name : 환자성명 
        /// </summary>
        [DataMember]
        public String PT_NM
        {
            get { return this.pt_nm; }
            set { if (this.pt_no != value) { this.pt_nm = value; this.OnPropertyChanged("PT_NM", value); } }
        }
        private String pt_nm;


        /// <summary>
        /// name : 진료일자 
        /// </summary>
        [DataMember]
        public String MED_DT
        {
            get { return this.med_dt; }
            set { if (this.med_dt != value) { this.med_dt = value; this.OnPropertyChanged("MED_DT", value); } }
        }
        private String med_dt;



        /// <summary>
        /// name : 진료과 
        /// </summary>
        [DataMember]
        public String MED_DEPT_CD
        {
            get { return this.med_dept_cd; }
            set { if (this.med_dept_cd != value) { this.med_dept_cd = value; this.OnPropertyChanged("MED_DEPT_CD", value); } }
        }
        private String med_dept_cd;



        /// <summary>
        /// name : 전화번호   
        /// </summary>
        [DataMember]
        public String TEL_NO
        {
            get { return this.tel_no; }
            set { if (this.tel_no != value) { this.tel_no = value; this.OnPropertyChanged("TEL_NO", value); } }
        }
        private String tel_no;




        /// <summary>
        /// name : 발생일   
        /// </summary>
        [DataMember]
        public String RPY_DT
        {
            get { return this.rpy_dt; }
            set { if (this.rpy_dt != value) { this.rpy_dt = value; this.OnPropertyChanged("RPY_DT", value); } }
        }
        private String rpy_dt;


        /// <summary>
        /// name : 보증금  
        /// </summary>
        [DataMember]
        public String RPY_AMT
        {
            get { return this.rpy_amt; }
            set { if (this.rpy_amt != value) { this.rpy_amt = value; this.OnPropertyChanged("RPY_AMT", value); } }
        }
        private String rpy_amt;

        /// <summary>
        /// name : 입력자   
        /// </summary>
        [DataMember]
        public String RPY_STF_NO
        {
            get { return this.rpy_stf_no; }
            set { if (this.rpy_stf_no != value) { this.rpy_stf_no = value; this.OnPropertyChanged("RPY_STF_NO", value); } }
        }
        private String rpy_stf_no;


        /// <summary>
        /// name : 입력사유    
        /// </summary>
        [DataMember]
        public String STRG_AMT_RMK
        {
            get { return this.strg_amt_rmk; }
            set { if (this.strg_amt_rmk != value) { this.strg_amt_rmk = value; this.OnPropertyChanged("STRG_AMT_RMK", value); } }
        }
        private String strg_amt_rmk;




        /// <summary>
        /// name : 최근예약일    
        /// </summary>
        [DataMember]
        public String RCN_RSV_DT
        {
            get { return this.rcn_rsv_dt; }
            set { if (this.rcn_rsv_dt != value) { this.rcn_rsv_dt = value; this.OnPropertyChanged("RCN_RSV_DT", value); } }
        }
        private String rcn_rsv_dt;


        /// <summary>
        /// name : 미수금액    
        /// </summary>
        [DataMember]
        public String UNCL_AMT
        {
            get { return this.uncl_amt; }
            set { if (this.uncl_amt != value) { this.uncl_amt = value; this.OnPropertyChanged("UNCL_AMT", value); } }
        }
        private String uncl_amt;



        /// <summary>
        /// name : 원무접수구분 
        /// </summary>
        [DataMember]
        public String PACT_TP_NM
        {
            get { return this.pact_tp_nm; }
            set { if (this.pact_tp_nm != value) { this.pact_tp_nm = value; this.OnPropertyChanged("PACT_TP_NM", value); } }
        }
        private String pact_tp_nm;

        private string pt_addr;
        /// <summary>
        /// name : 환자주소
        /// </summary>
        [DataMember]
        public string PT_ADDR
        {
            get { return this.pt_addr; }
            set { if (this.pt_addr != value) { this.pt_addr = value; OnPropertyChanged("PT_ADDR", value); } }
        }


    }
}
