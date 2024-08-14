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

using HIS.Core;
using HIS.PA.AC.PI.PI.DTO;
using HIS.PA.AC.PI.PI.DAC;
using HIS.PA.AC.PI.PI.DTO.SelectWayfarerAsk;

namespace HIS.PA.AC.PI.PI.BIZ
{
    /// <summary>
    /// name         : SelectWayfarerAskBL
    /// desc         : 행려환자내역조회
    /// author       : 감용록 
    /// create date  : 2024-08-13 오후 7:58:25
    /// update date  :  
    /// </summary>
    public class SelectWayfarerAskBL : BizBase//, ISelectWayfarerAskBL
    {
        /// <summary>
        /// name         : SelectWayfarerAskBL_GrSelect
        /// desc         : 행려환자내역조회
        /// author       : 김용록 
        /// create date  : 2024-08-13
        /// update date  : 
        /// </summary>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT> SelectWayfarerAskBL_GrSelect(SelectWayfarerAsk_IN tempYR)
        {
            using (SelectWayfarerAskDL YrDate_Average = new SelectWayfarerAskDL())
            {
                return YrDate_Average.SelectWayfarerAsk_Select(tempYR);
            }
        }
    }
}
