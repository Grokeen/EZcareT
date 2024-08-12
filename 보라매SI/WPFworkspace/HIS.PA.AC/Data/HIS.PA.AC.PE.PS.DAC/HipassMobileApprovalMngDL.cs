
using HIS.PA.AC.PE.PS.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using System;

namespace HIS.PA.AC.PE.PS.DAC
{
    /// <summary>
    /// name         : HipassMobileApprovalMngDL
    /// desc         : 하이패스모바일 승인 조회
    /// author       : 김용록 
    /// create date  : 2024-07-21 오후 1:14:17
    /// update date  : 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class HipassMobileApprovalMngDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : 김용록 
        /// create date  : 2024-07-21 오후 1:14:17
        /// update date  : 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle; // #팀별 적절한 DBEnum으로 변경
        }

        /// <summary>
        /// name         : SelectHipassMobileApprovalMng_OUT
        /// desc         : SelectHipassMobileApprovalMng_OUT
        /// author       : 김용록 
        /// create date  : 2024-07-21 오전 11:09:06
        /// update date  :  
        /// </summary>      
        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> SelectHipassMobileApprovalMng_OUT(HipassMobileApprovalMng_IN tempYR)
        {
            return this.DacAgent.Fill("HIS.PA.AC.PE.PS.HipassMobileApprovalMng", tempYR, typeof(HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>)) as HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>;
        }

        public HipassMobileApprovalMng_UPDATE UpdateHipassMobileApprovalMng_UPDATE(HipassMobileApprovalMng_UPDATE tempGR) {

            try {
                return this.DacAgent.Fill("HIS.PA.AC.PE.PS.HipassMobileApprovalMngUpdate", tempGR, typeof(HipassMobileApprovalMng_UPDATE)) as HipassMobileApprovalMng_UPDATE;


            }
            catch (Exception e) {
                //UPDATE 시, 반환 값이 없어 0테이블 에러에 대한 예외처리
                
                return tempGR;
            }
        }


    }
}



