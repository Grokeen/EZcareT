using HIS.Core.Global.DTO;
using HIS.PA.AC.PC.OP.DTO;
using HIS.PA.CORE.UI.UTIL;
using HIS.UI.Base;
using HIS.UI.Core;
using HIS.UI.Core.Commands;
using HIS.UI.Utility;
using HSF.TechSvc2010.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows;
using System.Windows.Input;

namespace HIS.PA.AC.PC.OP.UI
{
    /// <summary>
    /// name         : #OtpStorageAmountNonCompletePaymentAsk Data 클래스
    /// desc         : #OtpStorageAmountNonCompletePaymentAsk Data 클래스
    /// author       : hjkim 
    /// create date  : 2021-09-21 오후 2:50:13
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class OtpStorageAmountNonCompletePaymentAskData : ViewModelBase
    {
        #region [Consts]
        private const string BIZ_CLASS = "";
        #endregion //Consts


        #region [Constructor]
        /// <summary>
        /// Initializes a new <see cref="OtpStorageAmountNonCompletePaymentAsk"/>
        /// </summary>
        public OtpStorageAmountNonCompletePaymentAskData()
        {
            this.Init();
        }
        #endregion //Constructor

        #region [Member Variables]
        #endregion //Member Variables

        #region [View Properties]
        #endregion //View  Properties


        #region [Model Properties]



        /// <summary>
        /// desc         : 외래 보증금 미정산환자내역조회 IN DTO Property 
        /// author       : 김형준 
        /// create Date  : 2021-09-21
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private OtpStorageAmountNonCompletePaymentAsk_IN otpStorageAmountNonCompletePaymentAsk_INObj = new OtpStorageAmountNonCompletePaymentAsk_IN();
        public OtpStorageAmountNonCompletePaymentAsk_IN OtpStorageAmountNonCompletePaymentAsk_INObj
        {
            get
            {
                return otpStorageAmountNonCompletePaymentAsk_INObj;

            }

            set
            {
                if (otpStorageAmountNonCompletePaymentAsk_INObj != value)
                {
                    otpStorageAmountNonCompletePaymentAsk_INObj = value;
                    this.OnPropertyChanged("OtpStorageAmountNonCompletePaymentAsk_INObj", value);
                }
            }
        }



        /// <summary>
        /// desc         : 외래보증금내역조회 OUT DTO Property 
        /// author       : 김형준 
        /// create Date  : 2021-09-19
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT> otpStorageAmountNonCompletePaymentAsk_OUTObj = new HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT>();
        public HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT> OtpStorageAmountNonCompletePaymentAsk_OUTObj
        {
            get
            {
                return otpStorageAmountNonCompletePaymentAsk_OUTObj;

            }

            set
            {
                if (otpStorageAmountNonCompletePaymentAsk_OUTObj != value)
                {
                    otpStorageAmountNonCompletePaymentAsk_OUTObj = value;
                    this.OnPropertyChanged("OtpStorageAmountNonCompletePaymentAsk_OUTObj", value);
                }
            }
        }


        #endregion //Model Properties


        #region [Methods]
        /// <summary>
        /// name         : ViewModel 초기화 함수
        /// desc         : ViewModel 을 초기화 함수 입니다.
        /// author       : kimeunjung 
        /// create date  : 2012-04-26 09:46:07
        /// update date  : 2012-04-26 09:46:07, kimeunjung, 수정개요
        /// </summary>
        private void Init()
        {
        }
        #endregion //Methods
    }
}
