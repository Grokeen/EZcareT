
using HIS.PA.AC.PE.PS.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using HSF.TechSvc2010.Server.DAC;
using System;
using System.Data;

namespace HIS.PA.AC.PE.PS.DAC
{
    /// <summary>
    /// name         : #논리DAC 클래스명
    /// desc         : #DAC클래스 개요
    /// author       : leegidong 
    /// create date  : 2016-06-21 오후 1:14:17
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class HipassMobileApprovalMngDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : leegidong 
        /// create date  : 2016-06-21 오후 1:14:17
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle; // #팀별 적절한 DBEnum으로 변경
        }

        /// <summary>
        /// name         : #메소드 논리명
        /// desc         : #메소드 개요
        /// author       : leegidong 
        /// create date  : 2016-06-21 오전 11:09:06
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>      
        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> SelectHipassMobileApprovalMng_OUT(HipassMobileApprovalMng_IN temp)
        {


            return this.DacAgent.Fill("HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG", temp, typeof(HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>)) as HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>;
            // as연산자 : 타입을 반환 할 때, as 뒤에 형식으로 받겠다.
        }




    }
}
