
using HIS.PA.AC.PE.PS.DAC;
using HIS.PA.AC.PE.PS.DTO;
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
    /// author       : leegidong 
    /// create date  : 2016-04-15 오후 1:14:52
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class AdsPtDischargeDayAskBL : BizBase//, IAdsPtDischargeDayAskBL
    {
        /// <summary>
        /// name               : 퇴원일 조회
        /// i/f inheritance yn : N
        /// logic              : 
        /// desc               : 
        /// author             : leegidong 
        /// create date        : 2016-05-04 오후 08:58:57
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>반환문자열</returns>
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<AdsPtDischargeDayAsk_OUT> AdsPtDischargeDayForBL(AdsPtDischargeDayAsk_IN inObj)
        {
            using (AdsPtDischargeDayAskDL com = new AdsPtDischargeDayAskDL())
            {
                return com.AdsPtDischargeDayForDL(inObj);
            }
        }

        /// <summary>
        /// name               : 퇴원예정일 조회
        /// i/f inheritance yn : N
        /// logic              : 
        /// desc               : 
        /// author             : leegidong 
        /// create date        : 2016-05-04 오후 08:58:57
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>반환문자열</returns>
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<AdsPtDischargeDayAsk_OUT> AdsPtDischargeExpectationDayForBL(AdsPtDischargeDayAsk_IN inObj)
        {
            using (AdsPtDischargeDayAskDL com = new AdsPtDischargeDayAskDL())
            {
                return com.AdsPtDischargeExpectationDayForDL(inObj);
            }
        }

        /// <summary>
        /// name               : 퇴원등록 입원내역 조회
        /// i/f inheritance yn : N
        /// logic              : 퇴원등록 입원내역 정보를 조회함.
        /// desc               : 퇴원등록 입원내역 정보를 조회함.
        /// author             : kimeunjung 
        /// create date        : 2012-09-24 오후 08:58:57
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>반환문자열</returns>
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<AdsPtDischargeDayAsk_OUT> AdsPtDischargeDayForInsBL(AdsPtDischargeDayAsk_IN inObj)
        {
            using (AdsPtDischargeDayAskDL com = new AdsPtDischargeDayAskDL())
            {
                return com.AdsPtDischargeDayForInsDL(inObj);
            }
        }

        /// <summary>
        /// name               : ER 당일 퇴원예정자 조회
        /// logic              : ER 당일 퇴원예정자 조회
        /// desc               : ER 당일 퇴원예정자 조회
        /// author             : 성현석 
        /// create date        : 2024-04-22 오후 08:58:57
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>반환문자열</returns>
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<AdsPtDischargeDayAsk_OUT> ErPtDischargeExpectationDayFor(AdsPtDischargeDayAsk_IN inObj)
        {
            using (AdsPtDischargeDayAskDL com = new AdsPtDischargeDayAskDL())
            {
                return com.ErPtDischargeExpectationDayFor(inObj);
            }
        }

        /// <summary>
        /// name               : 가퇴원환자 조회
        /// logic              : 가퇴원환자 조회
        /// desc               : 가퇴원환자 조회
        /// author             : 성현석 
        /// create date        : 2024-04-22 오후 08:58:57
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>반환문자열</returns>
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<AdsPtDischargeDayAsk_OUT> AdsPtTemporalDischargeDayFor(AdsPtDischargeDayAsk_IN inObj)
        {
            using (AdsPtDischargeDayAskDL com = new AdsPtDischargeDayAskDL())
            {
                return com.AdsPtTemporalDischargeDayFor(inObj);
            }
        }

        /// <summary>
        /// name               : 입원환자 퇴원일수 조회
        /// i/f inheritance yn : N
        /// logic              : 입원환자 퇴원일수 조회
        /// desc               : 입원환자 퇴원일수 조회
        /// author             : kimeunjung 
        /// create date        : 2012-09-24 오후 08:58:57
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>반환문자열</returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HIS.Core.Global.DTO.Result_OUT UpdateReComputeBL(AdsPtDischargeDayAsk_OUT inObj)
        {
            using (AdsPtDischargeDayAskDL com = new AdsPtDischargeDayAskDL())
            {
                return com.UpdateReComputeDL(inObj);
            }
        }

        
    }
}
