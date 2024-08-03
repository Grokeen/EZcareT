using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data;
using HIS.PA.CORE.DTO;
using HSF.Controls.WPF;
using HSF.Controls.WPF.Tab;
using HSF.TechSvc2010.Common;

using HIS.UI.Base;
using HIS.UI.Core;
using HIS.UI.Controls;
using HIS.UI.Utility;



namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// id           : #프로그램 ID
    /// name         : #화면 논리명
    /// clss         : #{메인|공통|팝업|일반용지|서식용지|바코드}
    /// desc         : #화면 클래스 개요
    /// author       : JaeGang 
    /// create date  : 2023-12-26 오전 9:17:34
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class HipassMobileApprovalMng : UserControlBase
    {
        #region [Consts]
        #endregion //Consts

        #region [Dependency Properties]
        #endregion //Dependency Properties

        #region [Member Variables]
        #endregion //Member Variables

        #region [Properties]
        #endregion //Properties


        #region [Constructor]
        /// <summary>
        /// name         : HipassMobileApprovalMng 생성자
        /// desc         : HipassMobileApprovalMng 생성자
        /// author       : 김용록 
        /// create date  : 2024-07-10 오전 9:17:34
        /// update date  :  
        /// </summary>
        public HipassMobileApprovalMng()
        {
            InitializeComponent();

            this.model = this.DataContext as HipassMobileApprovalMngData;
        }
        #endregion //Constructor







        #region [Event Handlers]
        /// <summary>
        /// name         : FrameworkElement가 생성되어 개체 트리에 추가되면 이 이벤트가 발생합니다.
        /// desc         : 화면 로드시 공통 데이터 및 컨트롤 초기화 함수를 호출 합니다.
        /// author       : parkkwan 
        /// create date  : 2012-03-14 오후 3:14:17
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OnLoaded(object sender, RoutedEventArgs e)
        {
            //// 날짜 세팅
            ControlInit();

            //// 데이터 초기화
            //DataInit();
        }
        #endregion


        /* --------------------------------------------------------------- */
        /// <summary>
        /// name         : 하이패스 모바일 승인여부 조회 버튼
        /// author       : 김용록
        /// create date  : 2024-07-17
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MobileHipassSearch(object sender, RoutedEventArgs e)
        {
            HipassSearch();
        }


        /* --------------------------------------------------------------- */
        /// <summary>
        /// name         : 기타 버튼(승인+취소+알림톡+초기화+엑셀+닫기) 
        /// author       : 김용록
        /// create date  : 2024-07-17
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MobileHipassEtcBtn(object sender, RoutedEventArgs e)
        {
            this.GRbtn_Click(sender);

        }


    }
}
