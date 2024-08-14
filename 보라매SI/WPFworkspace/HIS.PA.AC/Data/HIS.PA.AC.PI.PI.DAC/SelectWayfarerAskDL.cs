using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;

using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ORM;
using HSF.TechSvc2010.Server.ComBase;
using HIS.PA.AC.PI.PI.DTO;
using HIS.PA.AC.PI.PI.DTO.SelectWayfarerAsk;

namespace HIS.PA.AC.PI.PI.DAC
{
    /// <summary>
    /// name         : 행려환자내역조회
    /// desc         : 행려환자내역조회 DAC
    /// author       : 김용록 
    /// create date  : 2024-08-13 오후 7:57:47
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class SelectWayfarerAskDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : 김용록 
        /// create date  : 2024-08-13 오후 7:57:47
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle; // #팀별 적절한 DBEnum으로 변경 
        }

        /// <summary>
        /// name         : 행려환자내역조회
        /// desc         : 행려환자내역조회 Select
        /// author       : 김용록 
        /// create date  : 2024-08-13 오후 7:57:47
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>                
        public HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT> SelectWayfarerAsk_Select(SelectWayfarerAsk_IN tempYR)
        {
            return this.DacAgent.Fill("HIS.PA.AC.PI.PI.SelectWayfarerAsk", tempYR, typeof(HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT>)) as HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT>;
        }


    }
}
