using HIS.Core.Global.DTO;
using HIS.UI.Base;
using HIS.UI.Core;
using HIS.UI.Core.Commands;
using HIS.UI.Utility;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows;
using System.Windows.Input;

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : #HipassMobileApprovalMng Data 클래스
    /// desc         : #HipassMobileApprovalMng Data 클래스
    /// author       : JaeGang 
    /// create date  : 2023-12-26 오전 9:17:34
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class HipassMobileApprovalMngData : ViewModelBase
    {
        #region [Consts]
        private const string BIZ_CLASS = "";
        #endregion //Consts


        #region [Constructor]
        /// <summary>
        /// Initializes a new <see cref="MedicalCareApprobationAsk"/>
        /// </summary>
        public HipassMobileApprovalMngData()
        {
            //생성자 함수
            this.Init();
        }
        #endregion //Constructor




        #region [Properties]

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


        private HSFDTOCollectionBaseObject<HipassMobileApprovalMng_IN> hipassMobileApprovalMng_INObj = new HSFDTOCollectionBaseObject<HipassMobileApprovalMng_IN>();

        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_IN> HipassMobileApprovalMng_INObj
        {
            get
            {
                return hipassMobileApprovalMng_INObj;
            }

            set
            {
                if (hipassMobileApprovalMng_INObj != value)
                {
                    hipassMobileApprovalMng_INObj = value;
                    this.OnPropertyChanged("HipassMobileApprovalMng_INObj", value);
                }
            }
        }



        private HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> hipassMobileApprovalMng_OUTObj = new HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>();

        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> HipassMobileApprovalMng_OUTObj
        {
            get
            {
                return hipassMobileApprovalMng_OUTObj;

            }

            set
            {
                if (hipassMobileApprovalMng_OUTObj != value)
                {
                    hipassMobileApprovalMng_OUTObj = value;
                    this.OnPropertyChanged("HipassMobileApprovalMng_OUTObj", value);
                }
            }
        }
        #endregion //Methods
    }


}

