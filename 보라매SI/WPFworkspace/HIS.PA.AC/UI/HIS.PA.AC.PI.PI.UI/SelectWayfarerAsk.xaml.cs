using HIS.UI.Base;
using HIS.UI.Controls;
using HIS.UI.Core;
using HIS.UI.Utility;
using HSF.Controls.WPF;
using HSF.TechSvc2010.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace HIS.PA.AC.PI.PI.UI
{
    /// <summary>
    /// id           : SelectWayfarerAsk
    /// name         : 행려환자내역조회
    /// clss         : 
    /// desc         : 
    /// author       : JaeGang 
    /// create date  : 2024-08-08 오전 11:10:10
    /// update date  :  
    /// </summary>
    public partial class SelectWayfarerAsk : UserControlBase
    {
        #region [Constructor]
        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectWayfarerAsk 생성자
        /// desc         : SelectWayfarerAsk 생성자
        /// author       : JaeGang 
        /// create date  : 2024-08-08 오전 11:10:10
        /// update date  :  
        /// </summary>
        /// ---------------------------------------------------------------------
        public SelectWayfarerAsk()
        {
            InitializeComponent();
            this.model = this.DataContext as SelectWayfarerAskData;
        }

        #endregion //Constructor



        #region [Event Handlers]
        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : UserControl Loaded 이벤트
        /// desc         : 화면 로드시 공통 데이터 및 컨트롤 초기화 함수를 호출함
        /// author       : JaeGang 
        /// create date  : 2024-08-08 오전 11:10:10
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void OnLoaded(object sender, RoutedEventArgs e)
        {
            ControlInit();
            DataInit();
        }

        #endregion //Event Handlers

        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectWayfarerAsk
        /// desc         : 행려환자내역조회 조회 버튼
        /// author       : 김용록 
        /// create date  : 2024-08-14 오후 15:10:10
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void btn_Search(object sender, RoutedEventArgs e)
        {
            this.SelectData();
        }
        private void dgrdGroupList_RowDoubleClick(object sender, RoutedEventArgs e)
        { }
        private void grdList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        { }
        private void ucPt_no_OnSelectCodeChange()
        { }


        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectWayfarerAsk
        /// desc         : 행려환자내역조회 닫기 버튼
        /// author       : 김용록 
        /// create date  : 2024-08-14 오후 15:10:10
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void btn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectWayfarerAsk 
        /// desc         : 행려환자내역조회 엑셀 버튼
        /// author       : 김용록 
        /// create date  : 2024-08-14 오후 15:10:10
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void btn_Excel(object sender, RoutedEventArgs e)
        {
            this.Excel();
        }

        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectWayfarerAsk
        /// desc         : 행려환자내역조회 초기화 버튼
        /// author       : 김용록 
        /// create date  : 2024-08-14 오후 15:10:10
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void btn_Fomat(object sender, RoutedEventArgs e)
        {
            MsgBox.Display("화면을 초기화 하시겠습니까?", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);
            OnLoaded(sender, e);

            ControlInit();
            DataInit();

        }


    }
}
