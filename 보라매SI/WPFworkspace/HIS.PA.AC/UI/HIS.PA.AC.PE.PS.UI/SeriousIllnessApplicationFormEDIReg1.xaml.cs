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

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// id           : #프로그램 ID
    /// name         : #화면 논리명
    /// clss         : #{메인|공통|팝업|일반용지|서식용지|바코드}
    /// desc         : #화면 클래스 개요
    /// author       : EZCARE 
    /// create date  : 2024-10-18 오후 1:16:18
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class UIPAMVC1 : UserControlBase
    {
        #region [Constructor]

        /// <summary>
        /// name         : UIPAMVC1 생성자
        /// desc         : UIPAMVC1 생성자
        /// author       : EZCARE 
        /// create date  : 2024-10-18 오후 1:16:18
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public UIPAMVC1()
        {
            InitializeComponent();

            this.model = this.DataContext as UIPAMVC1Data;
        }

        #endregion //Constructor

        #region [Event Handlers]

        /// <summary>
        /// name         : UserControl Loaded 이벤트
        /// desc         : 화면 로드시 공통 데이터 및 컨트롤 초기화 함수를 호출함
        /// author       : EZCARE 
        /// create date  : 2024-10-18 오후 1:16:18
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OnLoaded(object sender, RoutedEventArgs e)
        {
            // 컨트롤 초기화
            ControlInit();

            // 데이터 초기화
            DataInit();
        }

        #endregion //Event Handlers
    }
}
