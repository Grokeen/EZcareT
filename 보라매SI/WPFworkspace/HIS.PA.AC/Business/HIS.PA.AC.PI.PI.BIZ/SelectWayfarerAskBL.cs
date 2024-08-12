
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using System;
using System.Linq;

namespace HIS.PA.AC.PI.PI.BIZ
{
    /// <summary>
    /// name         : #논리BIZ 클래스명
    /// desc         : #BIZ클래스 개요	
    /// author       : EZCARE 
    /// create date  : 2024-08-11 오전 2:51:18
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class SelectWayfarerAskBL : BizBase//, ISelectWayfarerAskBL
    {
        #region 샘플 코드
        /* 
        /// <summary>
        /// name               : #메소드 논리명
        /// i/f inheritance yn : #인터페이스 상속여부 {Y|N} 
        /// logic              : #서비스 처리 로직
        /// desc               : #메소드 개요
        /// author             : EZCARE 
        /// create date        : 2024-08-11 오전 2:51:18
        /// update date        : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>       
        [HSFTransaction(HSFTransactionOption.Supported)]
        public CCCCCSTE_INOUT SelectCode(CCCCCSTE_INOUT code)
        {
            using (CodeDL com = new CodeDL())
            {
                return com.SelectCode(code);
            }
        }

        /// <summary>
        /// name               : #메소드 논리명
        /// i/f inheritance yn : #인터페이스 상속여부 {Y|N} 
        /// logic              : #서비스 처리 로직
        /// desc               : #메소드 개요
        /// author             : EZCARE 
        /// create date        : 2024-08-11 오전 2:51:18
        /// update date        : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>      
        [HSFTransaction(HSFTransactionOption.Required)]
        public Result_OUT SaveCode(CCCCCSTE_INOUT code)
        {

            using (CodeDL com = new CodeDL())
            {
                base.SetHISProperty(code);
                com.SaveCode(code);
            }
            return new Result_OUT() { IsSucess = true };
        }
        */
        #endregion 샘플 코드
    }
}
