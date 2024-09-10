using HIS.Core.Global.DTO.Individuality;
using HIS.UI.Base;
using HIS.UI.Base.Interface;
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

namespace HIS.PA.PZ.AC.UI
{
    /// <summary>
    /// id           : #프로그램 ID
    /// name         : #화면 논리명
    /// clss         : #{메인|공통|팝업|일반용지|서식용지|바코드}
    /// desc         : #화면 클래스 개요
    /// author       : songminsu 
    /// create date  : 2016-09-27 오후 5:10:20
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class UserPersonalization : UserControlBase, IPrivateSettingView, IPrivateSettingValidation
    {
        #region [Constructor]

        /// <summary>
        /// Initializes a new <see cref="UserPersonalization"/>
        /// </summary>
        public UserPersonalization()
        {
            InitializeComponent();

            this.model = this.DataContext as UserPersonalizationData;
        }
        #endregion //Constructor

        #region [Event Handlers]

        /// <summary>
        /// name         : FrameworkElement가 생성되어 개체 트리에 추가되면 이 이벤트가 발생합니다.
        /// desc         : 화면 로드시 공통 데이터 및 컨트롤 초기화 함수를 호출 합니다.
        /// author       : 황인영 
        /// create date  : 2013-02-26 오후 3:08:17
        /// update date  : 2013-02-26 오후 3:08:17, 황인영, 수정내용
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OnLoaded(object sender, RoutedEventArgs e)
        {
            // 컨트롤 초기화
            ControlInit();

            // 이벤트 초기화
            //EventInit();

            // 데이터 초기화
            DataInit();

            StartFlag = true;
        }

        /// <summary>
        /// name         : 저장
        /// desc         : 상속 받은 IPrivateSettingView 인터페이스에 제공된 HaveToGatheringDTO 메소드를 사용하여 값을 지정 후 
        ///                BusinessType_PrivateSetting Type으로 Return
        /// author       : 황인영 
        /// create date  : 2013-02-28 오후 12:07:49
        /// update date  : 2013-02-28 오후 12:07:49, songilhyun, 수정내용
        /// </summary>
        /// <returns></returns>
        public Core.Global.DTO.Individuality.BusinessType_PrivateSetting HaveToGatheringDTO()
        {
            BusinessType_PrivateSetting changedDataList = new BusinessType_PrivateSetting();

            this.CheckChangedDataList();

            if (this.model.GLOBAL_ITEM_LIST.Count > 0)
            {
                changedDataList.GLOBAL_PRIVATE_SETTING = new PrivateSettingCollection(this.model.GLOBAL_ITEM_LIST);
                this.model.GLOBAL_ITEM_LIST.Clear();
            }

            return changedDataList;
        }

        /// <summary>
        /// name         : 
        /// desc         : 
        /// author       : 황인영 
        /// create date  : 2013-02-28 오후 12:07:49
        /// update date  : 2013-02-28 오후 12:07:49, songilhyun, 수정내용
        /// </summary>
        /// <returns></returns>
        public bool CheckValidation()
        {
            return true;
        }

        /// <summary>
        /// 영수증 프린터 콤보 변경 시 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboPrint_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboPrint");
        }

        /// <summary>
        /// 제증명 프린터 콤보 변경 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboPrint2_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboPrint2");
        }

        /// <summary>
        /// 양면프린터 콤보 변경 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboPrint3_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboPrint3");
        }

        private void rdoScreen_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (!StartFlag)
            {
                return;
            }
         
            RdoScreenSelectionChanged();
        }

        /// <summary>
        /// 원외처방전 프린터 콤보 변경 시 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboPrint4_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboPrint4");
        }

        /// <summary>
        /// 예약증 프린터 콤보 변경 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboPrint5_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboPrint5");
        }

        private void CboMonPos_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            MonitorPositionComboChange();
        }

        /// <summary>
        /// 라벨프린터 콤보 변경 시 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboLabelPrint_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboLabelPrint");
        }

        /// <summary>
        /// 진찰권 프린터 콤보 변경 시 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboPrcdPrint_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboPrcdPrint");
        }

        /// <summary>
        /// 원외처방전 급지함 콤보 선택 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboPresTray_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboPresTray");
        }


        /// <summary>
        /// 영수증 급지함 콤보 선택 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboBILLTray_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboBILLTray");
        }

        /// <summary>
        /// 제증명 급지함 콤보 선택 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CboREPOTray_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            PrintComboChange("CboREPOTray");
        }
        #endregion //Event Handlers

        //private void btnSave_Click(object sender, RoutedEventArgs e)
        //{
        //    HaveToGatheringDTO();
        //}
    }
}
