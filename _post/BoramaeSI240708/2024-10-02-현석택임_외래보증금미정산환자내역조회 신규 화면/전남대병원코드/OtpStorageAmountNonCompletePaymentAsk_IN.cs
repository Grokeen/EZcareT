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
    /// create date : 2021-09-21 오후 3:04:24
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class OtpStorageAmountNonCompletePaymentAsk_IN : HISDTOBase
    {
        /// <summary>
        /// name : IN_FROMDATE -- 조회(시작일자)
        /// </summary>
        [DataMember]
        public String IN_FROMDATE
        {
            get { return this.in_fromdate; }
            set { if (this.in_fromdate != value) { this.in_fromdate = value; this.OnPropertyChanged("IN_FROMDATE", value); } }
        }
        private String in_fromdate;

        /// <summary>
        /// name : IN_TODATE -- 조회(종료일자)
        /// </summary>
        [DataMember]
        public String IN_TODATE
        {
            get { return this.in_todate; }
            set { if (this.in_todate != value) { this.in_todate = value; this.OnPropertyChanged("IN_TODATE", value); } }
        }
        private String in_todate;


        /// <summary>
        /// name : IN_JOBTYPE -- 조회구분(전체='A' , 보증금='S', 환불금='R')
        /// </summary>
        [DataMember]
        public String IN_JOBTYPE
        {
            get { return this.in_jobtype; }
            set { if (this.in_jobtype != value) { this.in_jobtype = value; this.OnPropertyChanged("IN_JOBTYPE", value); } }
        }
        private String in_jobtype;



        /// <summary>
        /// name : IN_STF_NO -- 담당자ID 
        /// </summary>
        [DataMember]
        public String IN_STF_NO
        {
            get { return this.in_stf_no; }
            set { if (this.in_stf_no != value) { this.in_stf_no = value; this.OnPropertyChanged("IN_STF_NO", value); } }
        }
        private String in_stf_no;



        /// <summary>
        /// name : IN_UP_AMT -- 이상 기준금액  
        /// </summary>
        [DataMember]
        public String IN_UP_AMT
        {
            get { return this.in_up_amt; }
            set { if (this.in_up_amt != value) { this.in_up_amt = value; this.OnPropertyChanged("IN_UP_AMT", value); } }
        }
        private String in_up_amt;




        /// <summary>
        /// name : IN_FROM_AMT -- 시작기준금액 
        /// </summary>
        [DataMember]
        public String IN_FROM_AMT
        {
            get { return this.in_from_amt; }
            set { if (this.in_from_amt != value) { this.in_from_amt = value; this.OnPropertyChanged("IN_FROM_AMT", value); } }
        }
        private String in_from_amt;


        /// <summary>
        /// name : IN_TO_AMT -- 종료기준금액 
        /// </summary>
        [DataMember]
        public String IN_TO_AMT
        {
            get { return this.in_to_amt; }
            set { if (this.in_to_amt != value) { this.in_to_amt = value; this.OnPropertyChanged("IN_TO_AMT", value); } }
        }
        private String in_to_amt;



        /// <summary>
        /// name : IN_PACT_TP_CD -- 원무접수구분  
        /// </summary>
        [DataMember]
        public String IN_PACT_TP_CD
        {
            get { return this.in_pact_tp_cd; }
            set { if (this.in_pact_tp_cd != value) { this.in_pact_tp_cd = value; this.OnPropertyChanged("IN_PACT_TP_CD", value); } }
        }
        private String in_pact_tp_cd;


    }
}
