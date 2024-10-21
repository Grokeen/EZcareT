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
    public class UpdSeriousIllnessApplicationFormEDIReg2_OUT : HISDTOBase
    {
        /// <summary>
        /// name : COUNT
        /// </summary>  
        [DataMember]
        public int? COUNT
        {
            get { return this.count; }
            set { if (this.count != value) { this.count = value; this.OnPropertyChanged("COUNT", value); } }
        }
        private int? count;
    }
}
