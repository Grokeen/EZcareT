using HIS.PA.AC.PI.PI.UI;
using HIS.PA.CORE.UI.UTIL;
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

namespace HIS.PA.AC.PC.OP.UI
{
    /// <summary>
    /// id           : #프로그램 ID
    /// name         : #화면 논리명
    /// clss         : #{메인|공통|팝업|일반용지|서식용지|바코드}
    /// desc         : #화면 클래스 개요
    /// author       : hjkim 
    /// create date  : 2021-09-21 오후 2:50:13
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class OtpStorageAmountNonCompletePaymentAsk : UserControlBase
    {
        #region [Constructor]

        /// <summary>
        /// name         : OtpStorageAmountNonCompletePaymentAsk 생성자
        /// desc         : OtpStorageAmountNonCompletePaymentAsk 생성자
        /// author       : hjkim 
        /// create date  : 2021-09-21 오후 2:50:13
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public OtpStorageAmountNonCompletePaymentAsk()
        {
            InitializeComponent();

            this.model = this.DataContext as OtpStorageAmountNonCompletePaymentAskData;
        }

        #endregion //Constructor

        #region [Event Handlers]

        /// <summary>
        /// name         : UserControl Loaded 이벤트
        /// desc         : 화면 로드시 공통 데이터 및 컨트롤 초기화 함수를 호출함
        /// author       : hjkim 
        /// create date  : 2021-09-21 오후 2:50:13
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



        /// <summary>
        /// name         : 조회 버튼 클릭
        /// desc         : 외래보증금미정산환자내역조회 
        ///  author      : 김형준
        /// create date  : 2021-09-21
        /// update date  : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {
            SelectData();
        }



        /// <summary>
        /// name         : 초기화 버튼 클릭
        /// desc         : 화면 초기화
        ///  author      : 김형준
        /// create date  : 2021-09-21
        /// update date  : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnInit_Click(object sender, RoutedEventArgs e)
        {
            ControlInit();
        }



        /// <summary>
        /// name         : 출력 버튼 클릭
        /// desc         : 레포트 출력 
        ///  author      : 김형준
        /// create date  : 2021-09-19
        /// update date  : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnPrint_Click(object sender, RoutedEventArgs e)
        {
            Print();
        }



        /// <summary>
        /// name         : 엑셀 버튼 클릭
        /// desc         : 엑셀 출력
        ///  author      : 김형준
        /// create date  : 2021-09-21
        /// update date  : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnExcel_Click(object sender, RoutedEventArgs e)
        {
            ExportToExcel();
        }


        /// <summary>
        /// name         : 닫기 버튼 클릭
        /// desc         : 클릭시 창을 닫음
        ///  author      : 김형준
        /// create date  : 2021-09-21
        /// update date  : 최종 수정일자 , 수정자, 수정개요  
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }


        private void ftcal_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.OriginalSource is HDateEditor)
            {
                HDateEditor obj = (HDateEditor)e.OriginalSource;

                if (obj.Name == "PART_DateEditorFrom" && e.Key == Key.Enter)
                {
                    ControlHelper.HDateEditorFocus(ControlHelper.FindChild<HDateEditor>(ftcal, "PART_DateEditorTo"));
                    e.Handled = true;
                }
                else if (obj.Name == "PART_DateEditorTo" && e.Key == Key.Enter) SelectData();
            }
        }

     
        private void rdoMB_Checked(object sender, RoutedEventArgs e)
        {
            if (this.rdoMore.IsChecked == true)
            {
                this.txtUpAmt.IsEnabled = true;
                this.txtUpAmt.Focus();
                this.txtFromAmt.IsEnabled = false;
                this.txtToAmt.IsEnabled = false;

            }
            else
            {
                this.txtUpAmt.IsEnabled = false;
                this.txtFromAmt.IsEnabled = true;
                this.txtToAmt.IsEnabled = true;
                this.txtFromAmt.Focus();
            }
        }

        private void chkMsg_Checked(object sender, RoutedEventArgs e)
        {
            this.SetMsg();
        }

        private void dgrdResult_RowDoubleClick(object sender, RoutedEventArgs e)
        {
            this.OpPopUp();
        }

        private void btnSMS_Click(object sender, RoutedEventArgs e)
        {
            this.SendSMS();
        }
    }
}
