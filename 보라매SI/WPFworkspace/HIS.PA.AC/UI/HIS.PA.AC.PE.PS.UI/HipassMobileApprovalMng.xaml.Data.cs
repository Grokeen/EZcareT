using HIS.Core.Global.DTO;
using HIS.PA.AC.PE.PS.DTO;
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

        private HipassMobileApprovalMng_IN hipassMobile_GrIN = new HipassMobileApprovalMng_IN();
        private HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> hipassMobile_GrOUT = new HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>();

        /// <summary>
        /// desc         : IN DTO Property
        /// author       : leegidong 
        /// create Date  : 2016-07-05 오전 9:57:31
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        public HipassMobileApprovalMng_IN HipassMobile_GrIN
        {
            get { return this.hipassMobile_GrIN; }
            set
            {
                if (this.hipassMobile_GrIN != value)
                {
                    this.hipassMobile_GrIN = value;
                    this.OnPropertyChanged("HipassMobile_GrIN");
                }
            }
        }
        /// <summary>
        /// desc         : IN DTO Property
        /// author       : leegidong 
        /// create Date  : 2016-07-05 오전 9:57:31
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> HipassMobile_GrOUT
        {
            get
            {
                return hipassMobile_GrOUT;
            }
            set
            {
                if (hipassMobile_GrOUT != value)
                {
                    hipassMobile_GrOUT = value;
                    this.OnPropertyChanged("HipassMobile_GrOUT", value);
                }
            }
        }

    }
}