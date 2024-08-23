
using HIS.PA.AC.PE.PS.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using System;

namespace HIS.PA.AC.PE.PS.DAC
{
    /// <summary>
    /// name         : #논리DAC 클래스명
    /// desc         : #DAC클래스 개요
    /// author       : leegidong 
    /// create date  : 2016-03-21 오전 9:07:07
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class SelectSihsPtAskPaDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : leegidong 
        /// create date  : 2016-03-21 오전 9:07:07
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle; // #팀별 적절한 DBEnum으로 변경
        }

        /// <summary>
        /// name               :
        /// desc               : 
        /// author             : leegidong
        /// create date        : 2016-03-21
        /// update date        : 최종 수정일자, 수정자, 수정개요 
        /// 2024.07.02 김태훈 재원환자조회(안내) 조회 쿼리와 돌려쓰다보니 문제가 많아서 재원환자조회(원무)용으로 입원일자 기준 조회하는 방식으로 EQS 분리함 
        /// </summary>
        public HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> SelectSihsPtAskPa_WDDL(SelectSihsPtAskPa_IN inObj)
        {
            HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> result = (HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)this.DacAgent.Fill("HIS.PA.AC.PE.PS.SelectEmergencyPtAsk_WD_ADS", inObj, typeof(HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)) as HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>;
            return result;
        }

        /// <summary>
        /// name               : 
        /// desc               : 
        /// author             : leegidong
        /// create date        : 2016-03-18
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> SelectSihsPtAskPa_ERDL(SelectSihsPtAskPa_IN inObj)
        {
            HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> result = (HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)this.DacAgent.Fill("HIS.PA.AC.PE.PS.SelectEmergencyPatientAsk_ER", inObj, typeof(HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)) as HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>;
            return result;
        }
        //SelectSihsPtAskPa_OPDL
        /// <summary>
        /// name               : 
        /// desc               : 
        /// author             : leegidong
        /// create date        : 2016-03-18
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> SelectSihsPtAskPa_OPDL(SelectSihsPtAskPa_IN inObj)
        {
            HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> result = (HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)this.DacAgent.Fill("HIS.PA.AC.PE.PS.SelectSihsPtAskPa_OP", inObj, typeof(HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)) as HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>;
            return result;
        }
        //SelectSihsPtAskPa_IPDL
        /// <summary>
        /// name               : 
        /// desc               : 
        /// author             : leegidong
        /// create date        : 2016-03-18
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> SelectSihsPtAskPa_IPDL(SelectSihsPtAskPa_IN inObj)
        {
            HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT> result = (HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)this.DacAgent.Fill("HIS.PA.AC.PE.PS.SelectSihsPtAskPa_IP", inObj, typeof(HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>)) as HSFDTOCollectionBaseObject<SelectSihsPtAskPa_OUT>;
            return result;
        }
    }
}
