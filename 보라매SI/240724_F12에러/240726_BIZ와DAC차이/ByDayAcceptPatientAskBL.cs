
using HIS.PA.AC.PE.PS.DAC;
using HIS.PA.AC.PE.PS.DTO.ByDayAcceptPatientAsk;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using System;
using System.Linq;

namespace HIS.PA.AC.PE.PS.BIZ
{
    /// <summary>
    /// name         : #논리BIZ 클래스명
    /// desc         : #BIZ클래스 개요	
    /// author       : 김경민 
    /// create date  : 2015-12-07 오후 5:05:13
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class ByDayAcceptPatientAskBL : BizBase//, IByDayAcceptPatientAskBL
    {

        /// <summary>
        /// name               : 메소드 논리명
        /// i/f inheritance yn : 인터페이스 상속여부 {Y|N} 
        /// logic              : 서비스 처리 로직
        /// desc               : 메소드 개요
        /// author             : 김경민 
        /// create date        : 2015-12-07 오후 5:05:13
        /// update date        : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>       
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<ByDayAcceptPatientAsk_OUT> SelByDayAcceptPatientAsk(ByDayAcceptPatientAsk_IN obj)
        {
            using (ByDayAcceptPatientAskDL com = new ByDayAcceptPatientAskDL())
            {
                return com.SelByDayAcceptPatientAsk(obj);
            }
     
        }

        ///// <summary>
        ///// name               : 메소드 논리명
        ///// i/f inheritance yn : 인터페이스 상속여부 {Y|N} 
        ///// logic              : 서비스 처리 로직
        ///// desc               : 메소드 개요
        ///// author             : 김경민 
        ///// create date        : 2015-12-07 오후 5:05:13
        ///// update date        : 최종 수정 일자, 수정자, 수정개요 
        ///// </summary>      
        //[HSFTransaction(HSFTransactionOption.Required)]
        //public Result_OUT SaveCode(CCCCCSTE_INOUT obj)
        //{

        //    //using (CodeDL com = new CodeDL())
        //    //{
        //    //    base.SetHISProperty(obj);
        //    //    com.SaveCode(obj);
        //    //}
        //    //return new Result_OUT() { IsSucess = true };
        //    return null;
        //}

    }
}
