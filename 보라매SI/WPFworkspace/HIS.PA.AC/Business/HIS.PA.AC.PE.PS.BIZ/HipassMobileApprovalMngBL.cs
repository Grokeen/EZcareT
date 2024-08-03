using System;
using System.Linq;

using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ORM;
using HSF.TechSvc2010.Server.ComBase;
using HIS.PA.AC.PE.PS.DTO;
using HIS.PA.AC.PE.PS.DAC;
using HIS.Core;

namespace HIS.PA.AC.PE.PS.BIZ
{
    /// <summary>
    /// name         : HipassMobileApprovalMngBL
    /// desc         : 모바일하이패스 승인 조회
    /// author       : 김용록 
    /// create date  : 2024-07-21
    /// update date  : 
    /// </summary>
    public class HipassMobileApprovalMngBL : BizBase//, IHavingAMedicalExaminationHistoryBL
    {



        /// <summary>
        /// name         : HipassMobileApprovalMngBL
        /// desc         : 모바일하이패스 승인 조회
        /// author       : 김용록 
        /// create date  : 2024-07-21
        /// update date  : 
        /// </summary>
        
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> HipassMobileApprovalMng_GrDateAV(HipassMobileApprovalMng_IN tempYR)
        {
            using (HipassMobileApprovalMngDL YrDate_Average = new HipassMobileApprovalMngDL())
            {
                return YrDate_Average.SelectHipassMobileApprovalMng_OUT(tempYR);
            }
        }


        /// <summary>
        /// name         : HipassMobileApprovalMngBL
        /// desc         : 모바일하이패스 승인/취소 
        /// author       : 김용록 
        /// create date  : 2024-08-02
        /// update date  : 
        /// </summary>
        
        [HSFTransaction(HSFTransactionOption.Required)]
        public void UpdOtptPtReservationRegistration_update(HipassMobileApprovalMng_UPDATE tempGR)
        {
            using (HipassMobileApprovalMngDL GrDate_Average = new HipassMobileApprovalMngDL())
            {
                GrDate_Average.UpdateHipassMobileApprovalMng_UPDATE(tempGR);

            }
        }
    }
}
