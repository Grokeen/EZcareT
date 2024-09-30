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

using HSF.Controls.WPF;
using HSF.TechSvc2010.Common;

using HIS.UI.Base;
using HIS.UI.Core;
using HIS.UI.Controls;
using HIS.UI.Utility;
using HIS.PA.AC.PE.SC.DTO;
using HIS.Core.Global.DTO;
using HIS.PA.CORE.UI.UTIL;

namespace HIS.PA.AC.PE.SC.UI
{
    /// <summary>
    /// id           : UI-PA-AC-PR-037
    /// name         : 의사일정등록
    /// clss         : 팝업
    /// desc         : 의사의 일정, 휴진, 대진등을 등록하고 관리한다.
    /// author       : kimchihwan
    /// create date  : 2012-06-07 오후 5:08:32
    /// update date  : 2012-06-07 오후 5:08:32, kimchihwan, 수정내용
    /// </summary>
    public partial class MedDoctorScheduleRegistration : UserControlBase
    {
        #region [Constructor]

        /// <summary>
        /// Initializes a new <see cref="MedDoctorScheduleRegistration"/>
        /// </summary>
        public MedDoctorScheduleRegistration()
        {
            InitializeComponent();

            this.model = this.DataContext as MedDoctorScheduleRegistrationData;
        }

        /// <summary>
        /// Initializes a new <see cref="OtptPtReservationRegistration"/>
        /// </summary>
        public MedDoctorScheduleRegistration(string NSP_INDEX, String DR_STF_NO, String NSP_MED_DEPT_CD)
        {
            InitializeComponent();

            this.model = this.DataContext as MedDoctorScheduleRegistrationData;

            if (NSP_INDEX == null)
                return;

            // 컨트롤 초기화
            //ControlInit();

            //다른화면에서 휴진등록 탭 호출 시 
            if (!String.IsNullOrEmpty(NSP_INDEX))
            {

                this.NSP_INDEX = NSP_INDEX;
                //tabMain.SelectedIndex = Convert.ToInt16(NSP_INDEX);
            }


            if (!String.IsNullOrEmpty(DR_STF_NO))
            {

                this.DR_STF_NO = DR_STF_NO;
                //ucPACodeAsk_NSP_Medr1.SelectedTextCode = DR_STF_NO;
                this.NSP_MED_DEPT_CD = NSP_MED_DEPT_CD;
                //ucPACodeAsk_NSP_Medr1.SelectedTextName3 = NSP_MED_DEPT_CD;
                //ucPACodeAsk_NSP_Medr1.Search(1);
            }
        }

        #endregion //Constructor

        #region [Event Handlers]

        /// <summary>
        /// name         : FrameworkElement가 생성되어 개체 트리에 추가되면 이 이벤트가 발생합니다.
        /// desc         : 화면 로드시 공통 데이터 및 컨트롤 초기화 함수를 호출 합니다.
        /// author       : kimchihwan 
        /// create date  : 2012-06-07 오후 5:08:32
        /// update date  : 2012-06-07 오후 5:08:32, kimchihwan, 수정내용
        /// </summary>
        private void OnLoaded(object sender, RoutedEventArgs e)
        {
            // 컨트롤 초기화
            ControlInit();

            // 데이터 초기화
            DataInit(99);

            DataInit(tabMain.SelectedIndex);

            tab_Change(tabMain.SelectedIndex);


            //다른화면에서 팝업으로 호출시(의사번호 던지면됨)
            if (!String.IsNullOrEmpty(NSP_INDEX))
            {

                //this.NSP_INDEX = NSP_INDEX;
                tabMain.SelectedIndex = Convert.ToInt16(NSP_INDEX);
            }
            if (!String.IsNullOrEmpty(DR_STF_NO))
            {
                if (NSP_INDEX.Equals("0"))//의사일정등록
                {
                    ucPACodeAsk.PassingReference = this.NSP_MED_DEPT_CD;
                    ucPACodeAsk.SelectedTextCode = this.DR_STF_NO;
                }
                else if (NSP_INDEX.Equals("1"))//의사휴진등록
                {
                    ucPACodeAsk_NSP_Medr1.PassingReference = this.NSP_MED_DEPT_CD;
                    ucPACodeAsk_NSP_Medr1.SelectedTextCode = this.DR_STF_NO;
                }
                else if (NSP_INDEX.Equals("2"))//의사대진등록
                {
                    ucPACodeAsk_SFAD_Medr1.PassingReference = this.NSP_MED_DEPT_CD;
                    ucPACodeAsk_SFAD_Medr1.SelectedTextCode = this.DR_STF_NO;
                }
                //else if (NSP_INDEX.Equals(1))//의사비정규환자등록
                //{
                //    ucPACodeAsk_NSP_Medr1.SelectedTextCode = this.DR_STF_NO;
                //}
            }

            //            dgrd_NSP.MouseLeftButtonDown +=new MouseButtonEventHandler(dgrd_NSP_MouseLeftButtonDown);
        }

        //void dgrd_NSP_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        //{

        //    //if (ControlHelper.GetRoutedEventArgsToRow(e) != null)
        //    //{
        //    //    if (!ControlHelper.GetRoutedEventArgsToRow(e).IsSelected)
        //    //    {

        //    //        MedDoctorScheduleRegistration_NSP_OUT temp = ControlHelper.GetRoutedEventArgsToRow(e).Item as MedDoctorScheduleRegistration_NSP_OUT;

        //    //        model.NspInOutObj.MEDR_STF_NO = temp.MEDR_STF_NO;
        //    //        //NSP_TEMP.MEDR_STF_NO;
        //    //        model.NspInOutObj.MEDR_SID = temp.MEDR_SID;
        //    //        model.NspInOutObj.APY_STR_DT = temp.APY_STR_DT;
        //    //        model.NspInOutObj.APY_END_DT = temp.APY_END_DT;
        //    //        model.NspInOutObj.NSP_RSN_TP_CD = temp.NSP_RSN_TP_CD;
        //    //        model.NspInOutObj.LSH_STF_NO = temp.LSH_STF_NO;
        //    //        model.NspInOutObj.LSH_DTM = temp.LSH_DTM;
        //    //        model.NspInOutObj.NSP_MEMO = temp.NSP_MEMO;
        //    //        model.NspInOutObj.MCSD_RSLT_CD = temp.MCSD_RSLT_CD;
        //    //        if (temp.PACT_TP_CD.Equals("O"))
        //    //            rdo_NSP_OI.SelectedIndex = 0;
        //    //        else if (temp.PACT_TP_CD.Equals("I"))
        //    //            rdo_NSP_OI.SelectedIndex = 1;
        //    //        model.NspInOutObj.PACT_TP_CD = temp.PACT_TP_CD;

        //    //        this.chk_Visible(((HDataGrid)sender).Name.ToString());
        //    //    }
        //    //}

        //}

        #endregion //Event Handlers

        private void HTreeView_NodeDoubleClick(object sender, NodeInfo e)
        {
            this.Control_NodeDoubleClick(sender, e);
        }

        private void HComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            this.Control_SelectionChanged(sender);
        }

        private void HButton_Click(object sender, RoutedEventArgs e)
        {
            this.btn_Click(sender);
        }

        private void HFromToCalendar_KeyDown(object sender, KeyEventArgs e)
        {
            this.Control_KeyDown(sender, e);
        }

        private void tabMain_TabChanged(object sender, SelectionChangedEventArgs e)
        {
            this.tab_Change(tabMain.SelectedIndex);

            if (tabMain.SelectedIndex == 0)
            {
                //ucPACodeAsk.SelectedTextCodeFocus();
                this.tabMain.Dispatcher.BeginInvoke(System.Windows.Threading.DispatcherPriority.Background, new Action(() => ucPACodeAsk.SelectedTextCodeFocus()));

            }
            else if (tabMain.SelectedIndex == 1)
            {
                //ucPACodeAsk_NSP_Medr1.SelectedTextCodeFocus();
                this.tabMain.Dispatcher.BeginInvoke(System.Windows.Threading.DispatcherPriority.Background, new Action(() => ucPACodeAsk_NSP_Medr1.SelectedTextCodeFocus()));
            }
            else if (tabMain.SelectedIndex == 2)
            {
                //ucPACodeAsk_SFAD_Medr1.SelectedTextCodeFocus();
                this.tabMain.Dispatcher.BeginInvoke(System.Windows.Threading.DispatcherPriority.Background, new Action(() => ucPACodeAsk_SFAD_Medr1.SelectedTextCodeFocus()));
            }
            else if (tabMain.SelectedIndex == 4)
            {
                //pacaCrrMeddr.SelectedTextCodeFocus();
                this.tabMain.Dispatcher.BeginInvoke(System.Windows.Threading.DispatcherPriority.Background, new Action(() => pacaCrrMeddr.SelectedTextCodeFocus()));
            }
        }

        private void HTreeView_OnSelectChange(object sender)
        {
            this.Control_OnSelectChange(sender);
        }

        private void calYear_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            this.Control_SelectedDateChanged(sender, e);
        }

        private void RadioButtonListItem_Selected(object sender, RoutedEventArgs e)
        {
            this.rdo_Selected(sender, e);
        }

        private void HDataGrid_RecordActivated(object sender, Infragistics.Windows.DataPresenter.Events.RecordActivatedEventArgs e)
        {
            //this.dgrd_RecordActivated(sender, e);
        }

        //private void PACodeAsk_OnSelectMEDDR()
        //{
        //    this.Control_OnSelectChange(ucPACodeAsk);
        //}

        private void ucPACodeAsk_NSP_Medr1_OnSelectChange(CORE.DTO.SelectPatientInfo_OUT dto)
        {
            this.Control_OnSelectChange(ucPACodeAsk_NSP_Medr1);
        }

        private void ucPACodeAsk_NSP_Medr2_OnSelectChange(CORE.DTO.SelectPatientInfo_OUT dto)
        {
            this.Control_OnSelectChange(ucPACodeAsk_NSP_Medr2);
        }

        private void ucPACodeAsk_NSP_Rsn_OnSelectChange(CORE.DTO.SelectPatientInfo_OUT dto)
        {
            this.Control_OnSelectChange(ucPACodeAsk_NSP_Rsn);
        }

        private void ucPACodeAsk_SFAD_Medr1_OnSelectChange(CORE.DTO.SelectPatientInfo_OUT dto)
        {
            this.Control_OnSelectChange(ucPACodeAsk_SFAD_Medr1);
        }

        private void HDatePicker_SelectedDateChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            //this.dtpck_SelectedDateChanged(sender);
        }

        private void HDatePicker_KeyDown(object sender, KeyEventArgs e)
        {
            this.Control_KeyDown(sender, e);
        }

        private void HDataGrid_MouseRightButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.Control_MouseRightButtonDown(sender, e);
        }

        private void HDataGrid_CellDoubleClick(object sender, HSF.Controls.WPF.EventArgs.DoubleClickCellEventArgs e)
        {
            this.dgrd_CellDoubleClick(sender, e);
        }

        private void calYear_DisplayChanged(object sender, SelectionChangedEventArgs e)
        {
            this.Control_DisplayChanged(sender, e);
        }

        private void HCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            this.Control_Checked(sender);
        }

        private void HTreeView_MouseRightButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.Control_MouseRightButtonDown(sender, e);
        }

        private void ucPACodeAsk_NSP_Medr2_OnCodeLoaded(CORE.UI.PACodeAskData model)
        {
            if (model.SelectMCCodeAskOutObj2.Count == 0)
                ucPACodeAsk_NSP_Medr2.IsPopupOpen = false;
        }

        private void PACodeAsk_OnCodeLoaded(CORE.UI.PACodeAskData model)
        {
            if (model.SelectMCCodeAskOutObj2.Count == 0)
                ucPACodeAsk_NSP_Rsn.IsPopupOpen = false;
        }

        private void HDataGrid_CellActivated(object sender, Infragistics.Windows.DataPresenter.Events.CellActivatedEventArgs e)
        {
            this.Control_CellActivated(sender, e);
        }

        private void ucPACodeAsk_OnSelectCodeChange()
        {
            if (ucPACodeAsk.SelectedTextCode.Length == 5)
            {
                this.Control_OnSelectChange(ucPACodeAsk);
            }
        }

        private void dgrd5_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {

            dgrd5_MouseDoubleClickControl();
        }

        private void HDataGridEx_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            this.dgrd_SelectionChanged(sender, e);
        }

        private void AllLink_Click(object sender, RoutedEventArgs e)
        {
            AllLink(sender);
        }

        private void dtp_nsp_apy_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter || e.Key == Key.Return)
            {
                ftcal_NSP_Prd.Focus();
            }
        }

        private void ucPACodeAsk_SFAD_Rsn_OnSelectCodeChange()
        {
            NspResChk();
        }

        private void btnUpdNspRsnTpCd_Click(object sender, RoutedEventArgs e)
        {
            HReceiptPopOpen();
        }

        private void btnUpdNspRsnTpCd_POP_Click(object sender, RoutedEventArgs e)
        {
            HReceiptPopSave();
        }

        private void ucNSP_RSN_STF_NO_KeyDown(object sender, KeyEventArgs e)
        {

        }

        private void cboNSP_RSN_CNTE_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            this.Control_SelectionChanged2(sender);
        }

        private void chk_Button(object sender, RoutedEventArgs e)
        {

        }
    }
}
