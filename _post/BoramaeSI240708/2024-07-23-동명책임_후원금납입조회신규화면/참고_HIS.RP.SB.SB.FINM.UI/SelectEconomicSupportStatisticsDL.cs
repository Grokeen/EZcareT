
using HIS.Core.Global.DTO;
using HIS.RP.SB.SB.FINM.DTO;
using HSF.COM.Core;
using HIS.Core.Extension;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using HSF.TechSvc2010.Server.DAC;
using System;
using System.Data;

namespace HIS.RP.SB.SB.FINM.DAC
{
    /// <summary>
    /// name         : #논리DAC 클래스명
    /// desc         : #DAC클래스 개요
    /// author       : hwseong 
    /// create date  : 2024-07-17 오후 6:00:22
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class SelectEconomicSupportStatisticsDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : hwseong 
        /// create date  : 2024-07-17 오후 6:00:22
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.MSSOracle; // #팀별 적절한 DBEnum으로 변경
        }

        /// <summary>
        /// name         : 경제적 지원 통계 조회
        /// author       : hwseong
        /// create date  : 2024-07-17
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> SelectEconomicSupportStatistics(SelectEconomicSupportStatistics_INOUT inObj)
        {
            HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> result = (HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT>)DacAgent.Fill(
                "HIS.RP.SB.SB.FINM.SelectEconomicSupportStatistics.SelectEconomicSupportStatistics"
                , inObj
                , typeof(HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT>), CommandType.StoredProcedure, QueryType.QueryStore);
            return result;
        }

        /// <summary>
        /// name         : 경제적 지원 내역 조회
        /// author       : hwseong
        /// create date  : 2024-07-17
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> SelectEconomicSupportDetailsList(SelectEconomicSupportStatistics_INOUT inObj)
        {
            HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> result = (HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT>)DacAgent.Fill(
                "HIS.RP.SB.SB.FINM.SelectEconomicSupportStatistics.SelectEconomicSupportDetailsList"
                , inObj
                , typeof(HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT>), CommandType.StoredProcedure, QueryType.QueryStore);
            return result;
        }
    }
}
