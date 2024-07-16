using HIS.UI.Base;
using System;
using System.Linq;
using System.Windows;

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
        /// <summary>
        /// Biz HipassMobileApprovalMngBL
        /// </summary>
        //private const string BIZ_CLASS = "HIS.PA.AC.PE.PS.BIZ.HipassMobileApprovalMngBL";
        #endregion //Consts






        #region [Dependency Properties]
        #endregion //Dependency Properties




        #region [Member Variables]
        /// <summary>
        /// 프레젠테이션 모델(PM) 
        /// </summary>


        //private HipassMobileApprovalMngData model = new HipassMobileApprovalMngData();

        #endregion //Member Variables




        #region [Properties]

        #endregion //Properties




        #region [Constructor]
        /// <summary>
        /// name         : HipassMobileApprovalMng 생성자
        /// desc         : HipassMobileApprovalMng 생성자
        /// author       : JaeGang 
        /// create date  : 2023-12-26 오전 9:17:34
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
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
            //// 컨트롤 초기화
            //ControlInit();

            //// 데이터 초기화
            //DataInit();
        }
        #endregion




        #region [조회 버튼]
        private void MobileHipassSearch_way1(object sender, KeyEventArgs e)
        {

            InitializeComponent();

            this.model = this.DataContext as MedicalCareApprobationAskData;
        }



        public void MobileHipassSearch_way2(object sender, KeyEventArgs e)
        {

            this.HipassWay2(sender, e);
        }
        #endregion //Event Handlers
    }
}
