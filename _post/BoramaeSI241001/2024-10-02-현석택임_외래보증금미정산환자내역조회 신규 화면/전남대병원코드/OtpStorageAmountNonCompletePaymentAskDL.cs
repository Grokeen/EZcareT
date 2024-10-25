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
using HIS.PA.AC.PC.OP.DTO;

namespace HIS.PA.AC.PC.OP.DAC
{
    /// <summary>
    /// name         : #논리DAC 클래스명
    /// desc         : #DAC클래스 개요
    /// author       : hjkim 
    /// create date  : 2021-09-21 오후 3:19:44
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class OtpStorageAmountNonCompletePaymentAskDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : hjkim 
        /// create date  : 2021-09-21 오후 3:19:44
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle;
        }




        /// <summary>
        /// name         : 외래보증금미정산환자내역조회  
        /// desc         : 외래 보증금 미정산환자내역조회 
        /// author       : 김형준
        /// create date  : 2021-09-21
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <param name="inObj"></param>
        /// <param name="strQuery"></param>
        /// <returns></returns>
        public HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT> SelOtpStorageAmountNonCompletePaymentAsk(OtpStorageAmountNonCompletePaymentAsk_IN inObj)
        {
            return this.DacAgent.Fill("HIS.PA.AC.PC.OP.SelOtpStorageAmountNonCompletePaymentAsk", inObj, typeof(HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT>)) as HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT>;
        }

    }
}
