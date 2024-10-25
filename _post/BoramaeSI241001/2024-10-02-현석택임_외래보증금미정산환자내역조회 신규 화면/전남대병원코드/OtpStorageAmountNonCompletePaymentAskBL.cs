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
using HIS.Core.BIZ;

using HIS.PA.AC.PC.OP.DTO;
using HIS.PA.AC.PC.OP.DAC;

namespace HIS.PA.AC.PC.OP.BIZ
{
    /// <summary>
    /// name         : #논리BIZ 클래스명
    /// desc         : #BIZ클래스 개요	
    /// author       : hjkim 
    /// create date  : 2021-09-21 오후 3:28:32
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class OtpStorageAmountNonCompletePaymentAskBL : BizBase//, IOtpStorageAmountNonCompletePaymentAskBL
    {
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT> SelOtpStorageAmountNonCompletePaymentAsk(OtpStorageAmountNonCompletePaymentAsk_IN inObj)
        {
            using (OtpStorageAmountNonCompletePaymentAskDL com = new OtpStorageAmountNonCompletePaymentAskDL())
            {
                return com.SelOtpStorageAmountNonCompletePaymentAsk(inObj);
            }
        }
    }
}
