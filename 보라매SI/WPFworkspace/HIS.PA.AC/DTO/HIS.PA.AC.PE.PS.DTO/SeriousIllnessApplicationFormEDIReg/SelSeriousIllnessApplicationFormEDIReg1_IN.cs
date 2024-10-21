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
    public class SelSeriousIllnessApplicationFormEDIReg1_IN : HISDTOBase
    {
        private string in_fromdate; // 시작일자
        private string in_todate;   // 종료일자
        private string in_pt_no;     // 환자번호

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
        /// name : IN_SIGNYN
        /// </summary>  
        [DataMember]
        public string IN_SIGNYN
        {
            get { return this.in_signyn; }
            set { if (this.in_signyn != value) { this.in_signyn = value; this.OnPropertyChanged("IN_SIGNYN", value); } }
        }
        private string in_signyn;

        /// <summary>
        /// name : EDI전송여부
        /// </summary>  
        [DataMember]
        public string SENDFG
        {
            get { return this.sendfg; }
            set { if (this.sendfg != value) { this.sendfg = value; this.OnPropertyChanged("SENDFG", value); } }
        }
        private string sendfg;

        /// <summary>
        /// name : 조회시작일자
        /// </summary>  
        [DataMember]
        public string FROMDATE
        {
            get { return this.fromdate; }
            set { if (this.fromdate != value) { this.fromdate = value; this.OnPropertyChanged("FROMDATE", value); } }
        }
        private string fromdate;

        /// <summary>
        /// name : 조회종료일자
        /// </summary>  
        [DataMember]
        public string TODATE
        {
            get { return this.todate; }
            set { if (this.todate != value) { this.todate = value; this.OnPropertyChanged("TODATE", value); } }
        }
        private string todate;

        /// <summary>
        /// name : 환자번호
        /// </summary>
        [DataMember]
        public string IN_PT_NO
        {
            get { return this.in_pt_no; }
            set { if (this.in_pt_no != value) { this.in_pt_no = value; base.OnPropertyChanged("IN_PT_NO", value); } }
        }
    }
}
