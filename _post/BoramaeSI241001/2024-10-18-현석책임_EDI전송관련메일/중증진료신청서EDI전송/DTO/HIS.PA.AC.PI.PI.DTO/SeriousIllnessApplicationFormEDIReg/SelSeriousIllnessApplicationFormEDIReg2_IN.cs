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
    public class SelSeriousIllnessApplicationFormEDIReg2_IN : HISDTOBase
    {
        /// <summary>
        /// name : IN_RRN
        /// </summary>  
        [DataMember]
        public string IN_RRN
        {
            get { return this.in_rrn; }
            set { if (this.in_rrn != value) { this.in_rrn = value; this.OnPropertyChanged("IN_RRN", value); } }
        }
        private string in_rrn;

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
        /// name : IN_FROMDATE
        /// </summary>  
        [DataMember]
        public string IN_FROMDATE
        {
            get { return this.in_fromdate; }
            set { if (this.in_fromdate != value) { this.in_fromdate = value; this.OnPropertyChanged("IN_FROMDATE", value); } }
        }
        private string in_fromdate;
    }
}
