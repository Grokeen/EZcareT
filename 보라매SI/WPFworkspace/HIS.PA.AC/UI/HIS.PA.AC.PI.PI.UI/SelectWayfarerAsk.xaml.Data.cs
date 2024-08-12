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

namespace HIS.PA.AC.PI.PI.UI
{
    /// <summary>
    /// name         : #SelectWayfarerAsk Data 클래스
    /// desc         : #SelectWayfarerAsk Data 클래스
    /// author       : EZCARE 
    /// create date  : 2024-08-11 오전 2:49:41
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class SelectWayfarerAskData : ViewModelBase
    {
        #region [Consts]

        private const string BIZ_CLASS = "";

        #endregion //Consts

        #region [Constructor]

        /// <summary>
        /// name         : SelectWayfarerAskData 생성자
        /// desc         : SelectWayfarerAskData 생성자
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:49:41
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public SelectWayfarerAskData()
        {
            if (LicenseManager.UsageMode == LicenseUsageMode.Designtime) return;
            this.Init();
        }

        #endregion //Constructor

        #region [Member Variables]

        #endregion //Member Variables

        #region [ Properties ]
        /*
        private HSFDTOCollectionBaseObject<string> dataList;
        /// <summary>
        /// desc         : #조회 데이터 리스트
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:49:41
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<string> DataList
        {
            get { return this.dataList; }
            set { if (this.dataList != value) { this.dataList = value; base.OnPropertyChanged("DataList", value); } }
        }
        */

        #endregion //Properties

        #region [Commands]

        /*
        private ICommand selectDataCommand;
        /// <summary>
        /// desc         : #데이터 조회 Command
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:49:41
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectDataCommand
        {
            get
            {
                if (selectDataCommand == null)
                    selectDataCommand = new RelayCommand(p => this.SelectData(p));
                return selectDataCommand;
            }
        }
        */

        #endregion //Commands

        #region [Methods]

        /// <summary>
        /// name         : ViewModel 초기화
        /// desc         : ViewModel을 초기화함
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:49:41
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void Init()
        {

        }

        /*
        /// <summary>
        /// name         : 데이터 조회
        /// desc         : 데이터를 조회함
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:49:41
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void SelectData(object p)
        {
            UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectData", null);
        }
        */

        #endregion //Methods
    }
}
