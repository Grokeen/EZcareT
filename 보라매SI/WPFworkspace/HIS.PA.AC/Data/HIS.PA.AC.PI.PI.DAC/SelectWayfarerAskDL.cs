
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using System;

namespace HIS.PA.AC.PI.PI.DAC
{
    /// <summary>
    /// name         : #논리DAC 클래스명
    /// desc         : #DAC클래스 개요
    /// author       : EZCARE 
    /// create date  : 2024-08-11 오전 2:50:45
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class SelectWayfarerAskDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:50:45
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.Oracle; // #팀별 적절한 DBEnum으로 변경
        }

        #region 샘플 코드
        /* 
        /// <summary>
        /// name         : #메소드 논리명
        /// desc         : #메소드 개요
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:50:45
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>                
        public void SaveCode(CCCCCSTE_INOUT code)
        {
            this.DacAgent.ExecuteNonQuery("SaveCode", code);
        }

        /// <summary>
        /// name         : #메소드 논리명
        /// desc         : #메소드 개요
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:50:45
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>      
        public CCCCCSTE_INOUT SelectCode(CCCCCSTE_INOUT code)
        {
            var result = this.DacAgent.Fill("SelectCode", code, typeof(CCCCCSTE_INOUT)) as CCCCCSTE_INOUT;
            return result;
        }
        */
        #endregion 샘플 코드
    }
}
