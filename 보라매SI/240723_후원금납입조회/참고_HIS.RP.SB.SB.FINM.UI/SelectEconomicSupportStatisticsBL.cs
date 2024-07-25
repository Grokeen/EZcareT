
using HIS.Core.Global.DTO;
using HIS.RP.SB.SB.FINM.DAC;
using HIS.RP.SB.SB.FINM.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using System;
using System.Linq;

namespace HIS.RP.SB.SB.FINM.BIZ
{
    /// <summary>
    /// name         : #논리BIZ 클래스명
    /// desc         : #BIZ클래스 개요	
    /// author       : hwseong 
    /// create date  : 2024-07-17 오후 6:00:02
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class SelectEconomicSupportStatisticsBL : BizBase//, ISelectEconomicSupportStatisticsBL
    {
        /// <summary>
        /// name               : 경제적 지원 통계 조회
        /// i/f inheritance yn : Y 
        /// logic              : 경제적 지원 통계 조회
        /// desc               : 경제적 지원 통계 조회
        /// author             : 성혜원
        /// create date        : 2024-07-17
        /// update date        : 2024-07-17, 성혜원, 최초작성 
        /// </summary>
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> SelectEconomicSupportStatistics(SelectEconomicSupportStatistics_INOUT inobj)
        {
            using (SelectEconomicSupportStatisticsDL com = new SelectEconomicSupportStatisticsDL())
            {
                return com.SelectEconomicSupportStatistics(inobj);
            }
        }

        /// <summary>
        /// name               : 경제적 지원 내역 조회
        /// i/f inheritance yn : Y 
        /// logic              : 경제적 지원 내역 조회
        /// desc               : 경제적 지원 내역 조회
        /// author             : 성혜원
        /// create date        : 2024-07-17
        /// update date        : 2024-07-17, 성혜원, 최초작성 
        /// </summary>
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> SelectEconomicSupportDetailsList(SelectEconomicSupportStatistics_INOUT inobj)
        {
            using (SelectEconomicSupportStatisticsDL com = new SelectEconomicSupportStatisticsDL())
            {
                return com.SelectEconomicSupportDetailsList(inobj);
            }
        }
    }
}
