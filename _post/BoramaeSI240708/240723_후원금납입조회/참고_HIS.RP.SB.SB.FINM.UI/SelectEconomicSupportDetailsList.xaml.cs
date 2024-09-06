using HIS.UI.Base;
using HIS.UI.Controls;
using HIS.UI.Core;
using HIS.UI.Utility;
using HSF.Controls.WPF;
using HSF.TechSvc2010.Common;
using HIS.UI.Utility.Extension;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace HIS.RP.SB.SB.FINM.UI
{
    /// <summary>
    /// id           : #프로그램 ID
    /// name         : #화면 논리명
    /// clss         : #{메인|공통|팝업|일반용지|서식용지|바코드}
    /// desc         : #화면 클래스 개요
    /// author       : hwseong 
    /// create date  : 2024-07-18 오후 6:51:09
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class SelectEconomicSupportDetailsList : UserControlBase
    {
        #region [Constructor]

        /// <summary>
        /// name         : SelectEconomicSupportDetailsList 생성자
        /// desc         : SelectEconomicSupportDetailsList 생성자
        /// author       : hwseong 
        /// create date  : 2024-07-18 오후 6:51:09
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public SelectEconomicSupportDetailsList()
        {
            InitializeComponent();

            this.model = this.DataContext as SelectEconomicSupportDetailsListData;
        }

        #endregion //Constructor

        #region [Event Handlers]

        /// <summary>
        /// name         : UserControl Loaded 이벤트
        /// desc         : 화면 로드시 공통 데이터 및 컨트롤 초기화 함수를 호출함
        /// author       : hwseong 
        /// create date  : 2024-07-18 오후 6:51:09
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

        private void btnExcel_Click(object sender, RoutedEventArgs e)
        {
            if (this.model.Outobj.Count > 0)
            {
                string tmpTitle = cbxStaticsTp.SelectedText;
                string[] sParam = new string[1];
                //sParam[0] = "조회기준 : " + cbxDateTp.SelectedText;
                sParam[0] = "조회기간 : " + this.ucTerm.FromDateProperty.Value.ToShortDateString() + "~" + this.ucTerm.ToDateProperty.Value.ToShortDateString();

                if (this.cbxStaticsTp.SelectedIndex == 0)   //기간별
                {
                    this.dgrdMain.ToExcel(tmpTitle, tmpTitle, true, false, 3, 1, sParam);

                }
                else if (this.cbxStaticsTp.SelectedIndex == 1)  //후원사업별
                {
                    this.dgrdMain2.ToExcel(tmpTitle, tmpTitle, true, false, 3, 1, sParam);
                }
                else if (this.cbxStaticsTp.SelectedIndex == 2)  //진료과별
                {
                    this.dgrdMain3.ToExcel(tmpTitle, tmpTitle, true, false, 3, 1, sParam);
                }
                else
                {
                    MsgBox.Display("조회구분을 선택하세요.", MessageType.MSG_TYPE_ERROR, "", true, MessageBoxButton.OK);
                    return;
                }
            }
            else
            {
                MsgBox.Display("엑셀로 출력할 데이터가 없습니다.", MessageType.MSG_TYPE_ERROR, "", true, MessageBoxButton.OK);
                return;
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {
            SelectEconomicSupportList();
        }

        private void cbxStaticsTp_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            this.dgrdMain.FieldLayouts[0].SortedFields.Clear(); //Grid의 Sort 초기화
            this.dgrdMain2.FieldLayouts[0].SortedFields.Clear(); //Grid의 Sort 초기화
            this.dgrdMain3.FieldLayouts[0].SortedFields.Clear(); //Grid의 Sort 초기화
            this.model.Outobj.Clear();

            if (this.cbxStaticsTp.SelectedIndex == 0)   //기간별
            {
                this.dgrdMain.Visibility = Visibility.Visible;
                this.dgrdMain2.Visibility = Visibility.Collapsed;
                this.dgrdMain3.Visibility = Visibility.Collapsed;

            }
            else if (this.cbxStaticsTp.SelectedIndex == 1)  //후원사업별
            {
                this.dgrdMain.Visibility = Visibility.Collapsed;
                this.dgrdMain2.Visibility = Visibility.Visible;
                this.dgrdMain3.Visibility = Visibility.Collapsed;
            }
            else if (this.cbxStaticsTp.SelectedIndex == 2)  //진료과별
            {
                this.dgrdMain.Visibility = Visibility.Collapsed;
                this.dgrdMain2.Visibility = Visibility.Collapsed;
                this.dgrdMain3.Visibility = Visibility.Visible;
            }
            else
            {
                this.dgrdMain.Visibility = Visibility.Collapsed;
                this.dgrdMain2.Visibility = Visibility.Collapsed;
                this.dgrdMain3.Visibility = Visibility.Collapsed;
            }
        }
    }
}
