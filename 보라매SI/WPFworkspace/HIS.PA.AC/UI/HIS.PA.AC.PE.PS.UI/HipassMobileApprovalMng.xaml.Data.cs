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
    /// author       : 김용록 
    /// create date  : 2024-07-17 오전 9:17:34
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
        /// author       : 김용록 
        /// create date  : 2024-07-17 09:46:07
        /// update date  : 
        /// </summary>
        private void Init()
        {
        }

        private HipassMobileApprovalMng_IN hipassMobile_GrIN = new HipassMobileApprovalMng_IN();

        private HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> hipassMobile_GrOUT = new HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>();

        private HipassMobileApprovalMng_UPDATE hipassMobile_GrUPDATE = new HipassMobileApprovalMng_UPDATE();



        /// <summary>
        /// desc         : HipassMobileApprovalMng_IN DTO Property
        /// author       : 김용록 
        /// create Date  : 2024-07-17 오전 9:57:31
        /// update date  : 
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
        /// desc         : HipassMobileApprovalMng_OUT DTO Property
        /// author       : 김용록 
        /// create Date  : 2024-07-17 오전 9:57:31
        /// update date  : 
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
        /// <summary>
        /// desc         : HipassMobileApprovalMng_UPDATE DTO Property
        /// author       : 김용록 
        /// create Date  : 2024-07-17 오전 9:57:31
        /// update date  : 
        public HipassMobileApprovalMng_UPDATE HipassMobile_GrUPDATE
        {
            get
            {
                return hipassMobile_GrUPDATE;
            }
            set
            {
                if (hipassMobile_GrUPDATE != value)
                {
                    hipassMobile_GrUPDATE = value;
                    this.OnPropertyChanged("HipassMobile_GrUPDATE", value);
                }
            }
        }


    }
}