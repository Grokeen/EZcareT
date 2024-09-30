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
using HIS.Core;
using HIS.Core.Extension;

using HIS.PA.AC.PE.SC.DTO;
using HIS.Core.Global.DTO;
using HIS.PA.CORE.UI.UTIL;
using HIS.PA.CORE.DTO;
using HIS.PA.AC.PE.SC.UI;
using Infragistics.Windows.Editors;
using HSF.Controls.WPF.Calendars;
using HSF.Controls.WPF.Enums;
using System.Collections.ObjectModel;
using HSF.Controls.WPF.Extension.CalendarEx;
using HSF.Controls.WPF.DataManager.Calendars;
using Infragistics.Controls.Editors;
using Infragistics.Collections;
using Infragistics;
using HIS.UI.Utility.Extension;
using HIS.Core.Global.DTO.CommonLogging;
using HIS.UI.CoreWork.Log;
using System.Globalization;
using Calendar = System.Globalization.Calendar;
using HIS.PA.AC.PE.SC.DTO.NotSeeingPatientsScheduleAsk;

namespace HIS.PA.AC.PE.SC.UI
{
    /// <summary>
    /// name         : 논리 UI Behavior 클래스 명
    /// desc         : WPF Page Item Itemplate입니다.
    /// author       : kimchihwan 
    /// create date  : 2012-06-07 오후 5:08:32
    /// update date  : 2012-06-07 오후 5:08:32 , kimchihwan , 수정개요
    /// </summary>
    public partial class MedDoctorScheduleRegistration
    {
        #region [Consts]
        private const string BIZ_CLASS = "";
        #endregion //Consts

        #region [Dependency Properties]

        #endregion //Dependency Properties

        #region [Member Variables]
        /// <summary>
        /// 프레젠테이션 모델(PM) 
        /// </summary>
        private MedDoctorScheduleRegistrationData model;
        private HContextMenu cm1 = new HContextMenu();
        private HContextMenu cm2 = new HContextMenu();
        private HContextMenu cmBatch1 = new HContextMenu();
        private HContextMenu cmBatch2 = new HContextMenu();
        private HContextMenu cmBatch3 = new HContextMenu();
        #endregion //Member Variables

        #region [Properties]
        bool[] pattern_week = new bool[7];
        String temp_medr_nm = String.Empty;
        String temp_asst_no = String.Empty;
        String temp_main_no = String.Empty;
        String temp_Medr_dp = String.Empty;
        String temp_depth = String.Empty;
        DateTime? temp_sfad_str_dtm = null;

        private List<int> selected_week_list = new List<int>();
        public String DR_STF_NO
        { get; set; }
        public String NSP_INDEX
        { get; set; }
        public String NSP_MED_DEPT_CD
        { get; set; }




        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Mon_AM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Mon_PM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Tue_AM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Tue_PM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Wed_AM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Wed_PM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Thu_AM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Thu_PM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Fri_AM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Fri_PM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Sat_AM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Sat_PM;
        // 20240311 김재강 : 일요일 선택가능하도록 변경함에 따른 코드 추가
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Sun_AM;
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Linq_Sun_PM;


        //비정규예약 탭 그리드 항목 선택시 데이터 임시보관할 변수
        MedDoctorScheduleRegistrationCostRegularReservation_INOUT temp;

        #endregion //Properties

        #region [컨트롤 초기화]

        /// <summary>
        /// name         : 컨트롤 초기화
        /// desc         : UI에서 사용할 컨트롤을 초기화 합니다.
        /// author       : kimchihwan 
        /// create date  : 2012-06-07 오후 5:08:32
        /// update date  : 2012-06-07 오후 5:08:32, kimchihwan, 수정내용
        /// </summary>
        private void ControlInit()
        {
            model.MedDoctorScheduleCriteriaRegistrationTreeInObj = new MedDoctorScheduleCriteriaRegistrationTree_IN();

            ucPACodeAsk.SelectedTextCodeFocus();

            Schd_Tree_Init();
            Doct_Tree_Init();
            Batch_Tree_Init();

            tabMain.SelectedIndex = 0;
            //tab_Change(tabMain.SelectedIndex);

            ftcal_Year.FromDate = DateTime.Now;
            ftcal_Year.ToDate = DateTime.Now.AddDays(365);

            ftcal_SFAD.FromDate = DateTime.Now;
            ftcal_SFAD.ToDate = DateTime.Now;

            ftcal_NSP_Prd.FromDate = DateTime.Now;
            ftcal_NSP_Prd.ToDate = DateTime.Now;

            //2024.05.03 신동명 공통코드 한번에 가져오도록 변경
            string[] groupCodes = { "223", "PA054", "PA043", "SDY" };
            var tmpCommonCodeList = CommonServiceAgent.SelectCodeByGroups(groupCodes);

            ComboBoxItemsProvider cobNSP_RSN_TP_CD = this.TryFindResource("NSP_RSN_TP_CD") as ComboBoxItemsProvider;
            cobNSP_RSN_TP_CD.DisplayMemberPath = "COMN_CD_NM_MIX";
            cobNSP_RSN_TP_CD.ValuePath = "COMN_CD";
            cobNSP_RSN_TP_CD.ItemsSource = tmpCommonCodeList.Filter(x => x.COMN_GRP_CD == "223");

            ComboBoxItemsProvider cobOI = this.TryFindResource("OI_CD") as ComboBoxItemsProvider;
            cobOI.DisplayMemberPath = "COMN_CD_NM";
            cobOI.ValuePath = "COMN_CD";
            cobNSP_RSN_TP_CD.ItemsSource = tmpCommonCodeList.Filter(x => x.COMN_GRP_CD == "PA054");

            ComboBoxItemsProvider cobAMPM_CD = this.TryFindResource("AMPM_CD") as ComboBoxItemsProvider;
            cobAMPM_CD.DisplayMemberPath = "COMN_CD_NM";
            cobAMPM_CD.ValuePath = "COMN_CD";
            cobNSP_RSN_TP_CD.ItemsSource = tmpCommonCodeList.Filter(x => x.COMN_GRP_CD == "PA043");

            ComboBoxItemsProvider cobMED_DOW_CD = this.TryFindResource("MED_DOW_KND_CD") as ComboBoxItemsProvider;
            cobMED_DOW_CD.DisplayMemberPath = "COMN_CD_NM";
            cobMED_DOW_CD.ValuePath = "COMN_CD";
            cobNSP_RSN_TP_CD.ItemsSource = tmpCommonCodeList.Filter(x => x.COMN_GRP_CD == "SDY");

            ComboBoxItemsProvider cobCRDOC_CD = this.TryFindResource("CRDOC_CD") as ComboBoxItemsProvider;
            cobCRDOC_CD.DisplayMemberPath = "COMN_CD_NM";
            cobCRDOC_CD.ValuePath = "COMN_CD";
            cobCRDOC_CD.ItemsSource = model.cxbCRDOCYN;

            dgrd_Schedule_AM.DataSource = model.MedDoctorScheduleCriteriaRegistrationInOutObj;
            dgrd_Schedule_PM.DataSource = model.MedDoctorScheduleCriteriaRegistrationInOutObj;
            rdo_NSP_Wrk_Seq.SelectedIndex = 2;

            //Grid 오른쪽 버튼 메뉴
            HMenuItem mi1 = new HMenuItem() { Header = "▶ Call 전송", Tag = "S" };
            mi1.Click += new RoutedEventHandler(mi_Click);
            cm1.Items.Add(mi1);

            HMenuItem mi2 = new HMenuItem() { Header = "▶ Call 취소", Tag = "C" };
            mi2.Click += new RoutedEventHandler(mi_Click);
            cm2.Items.Add(mi2);

            HMenuItem batch1 = new HMenuItem() { Header = "의사 추가", Tag = "MA" };
            batch1.Click += new RoutedEventHandler(mi_Click);
            cmBatch1.Items.Add(batch1);

            HMenuItem batch2 = new HMenuItem() { Header = "의사 추가", Tag = "MA" };
            batch2.Click += new RoutedEventHandler(mi_Click);
            cmBatch2.Items.Add(batch2);
            batch2 = new HMenuItem() { Header = "의사 삭제", Tag = "MD" };
            batch2.Click += new RoutedEventHandler(mi_Click);
            cmBatch2.Items.Add(batch2);
            batch2 = new HMenuItem() { Header = "진료과 추가", Tag = "AA" };
            batch2.Click += new RoutedEventHandler(mi_Click);
            cmBatch2.Items.Add(batch2);

            HMenuItem batch3 = new HMenuItem() { Header = "진료과 삭제", Tag = "AD" };
            batch3.Click += new RoutedEventHandler(mi_Click);
            cmBatch3.Items.Add(batch3);

            model.RsvRtcRsnList = new HSFDTOCollectionBaseObject<CommCdNmAsk_OUT>(UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.CORE.BIZ.CommCdNmAskBL", "SelectCommCdNmAsk", new CommCdNmAsk_IN() { IN_COMN_GRP_CD = "RtcRsn" }) as HSFDTOCollectionBaseObject<CommCdNmAsk_OUT>);

            this.cboNSP_RSN_CNTE.DisplayMemberPath = "COMN_CD_NM";
            this.cboNSP_RSN_CNTE.SelectedValuePath = "COMN_CD_NM";
            this.cboNSP_RSN_CNTE.ItemsSource = model.RsvRtcRsnList;



        }

        private void Schd_Tree_Init()
        {
            //일정등록탭 트리
            model.MedDoctorScheduleCriteriaRegistrationTreeInObj = new MedDoctorScheduleCriteriaRegistrationTree_IN();
            model.MedDoctorScheduleCriteriaRegistrationTreeInObj.CODE_DEPTH = "N";
            model.MedDoctorScheduleCriteriaRegistrationTreeOutObj = SetTreeViewList((HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleCriteriaRegistrationBL", "SelWholeMedicalTreatmentDepartmentDoctor", model.MedDoctorScheduleCriteriaRegistrationTreeInObj));
        }

        private void Doct_Tree_Init()
        {
            //나머지탭
            model.MedDoctorScheduleCriteriaRegistrationTreeInObj = new MedDoctorScheduleCriteriaRegistrationTree_IN();
            model.MedDoctorScheduleCriteriaRegistrationTree2OutObj = SetTreeViewList((HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelWholeMedicalTreatmentDepartmentDoctor2", model.MedDoctorScheduleCriteriaRegistrationTreeInObj));
        }

        private void Batch_Tree_Init()
        {
            model.MedDoctorScheduleCriteriaRegistrationTreeInObj = new MedDoctorScheduleCriteriaRegistrationTree_IN();
            model.MedDoctorScheduleCriteriaRegistrationTreeInObj.CODE_DEPTH = "N";
            //model.MedDoctorScheduleCriteriaRegistrationTree3OutObj = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Tree_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelWholeMedicalTreatmentDepartmentDoctor3", model.MedDoctorScheduleCriteriaRegistrationTreeInObj);
        }

        /// <summary>
        /// name         : TreeView 데이터 초기화
        /// desc         : 전체 진료과 및 진료의 조회
        /// author       : kimchihwan
        /// create date  : 2012-04-30 오후 5:29:13
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> SetTreeViewList(HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> TreeObj)
        {
            #region 2024.05.07 신동명 속도 이슈로 인해 코드 변경. TOBE
            HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> Depth01 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(TreeObj.Where(d => d.DEPTH == "1"));
            HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> Depth02 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(TreeObj.Where(d => d.DEPTH == "2"));
            HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> Depth03 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(TreeObj.Where(d => d.DEPTH == "3"));

            foreach (var depth01 in Depth01)
            {
                depth01.relations = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(Depth02.Where(d => depth01.MEDR_SID == d.MED_DEPT_CD));

                foreach (var depth02 in depth01.relations)
                {
                    depth02.relations = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(Depth03.Where(d => depth02.MEDR_SID == d.MED_DEPT_CD));
                }
            }

            return Depth01;
            #endregion
            #region 2024.05.07 신동명 속도 이슈로 인해 코드 변경. ASIS 
            //HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> Tree_Temp = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>();
            //HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> Tree_Temp1 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>();
            ////HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> Tree_Temp2 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>();
            ////HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> Tree_Temp3 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>();

            //Tree_Temp = TreeObj;

            //#region 트리에 담을 DTO 셋팅 -- DAC에서 FillTree를 사용하지 않고 Local에서 처리 ::: 대이터 량이 많으면 네트워크에서 부하가 생김.

            //if (Tree_Temp != null)
            //{
            //    #region DAC의 FillTree대신에 직접 Relation 맺기

            //    if (Tree_Temp.Any(o => o.DEPTH == "1"))
            //    {
            //        var roots_MEDR = Tree_Temp.Where(o => o.DEPTH == "1");

            //        //자식 요소 찾기
            //        roots_MEDR.ToList().ForEach(root =>
            //        {
            //            SetChildNodes(Tree_Temp, root);
            //        });
            //        Tree_Temp1 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(roots_MEDR);
            //    }
            //    else
            //        Tree_Temp1 = null;

            //    if (Tree_Temp.Any(o => o.DEPTH == "2"))
            //    {
            //        var roots_MTD = Tree_Temp.Where(o => o.DEPTH == "2");

            //        //자식 요소 찾기
            //        roots_MTD.ToList().ForEach(root =>
            //        {
            //            SetChildNodes(Tree_Temp, root);
            //        });

            //        //Tree_Temp2 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(roots_MTD);
            //    }
            //    //else
            //    //    Tree_Temp2 = null;

            //    if (Tree_Temp.Any(o => o.DEPTH == "3"))
            //    {
            //        var roots_ODRER = Tree_Temp.Where(o => o.DEPTH == "3");

            //        //자식 요소 찾기
            //        roots_ODRER.ToList().ForEach(root => { SetChildNodes(Tree_Temp, root); });
            //        //Tree_Temp3 = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(roots_ODRER);
            //    }
            //    //else
            //    //    Tree_Temp3 = null;

            //    #endregion
            //}
            //else
            //{
            //    //Tree_Temp1 = Tree_Temp2 = Tree_Temp3 = null;
            //    Tree_Temp1 = null;
            //}

            //return Tree_Temp1;
            //#endregion
            #endregion
        }

        void SetChildNodes(IEnumerable<MedDoctorScheduleCriteriaRegistrationTree_OUT> treeOrderSetList, MedDoctorScheduleCriteriaRegistrationTree_OUT parent)
        {
            //관계 셋팅
            parent.relations = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>(treeOrderSetList.Where(o => o.MED_DEPT_CD == parent.MEDR_SID).OrderBy(o => o.DEPTH));

            //자식 요소의 관계 셋팅
            parent.relations.ToList().ForEach(subChild =>
            {
                if (treeOrderSetList.Any(o => o.MEDR_SID == subChild.MED_DEPT_CD))
                {
                    SetChildNodes(treeOrderSetList, subChild);
                }
                else
                {
                    subChild.relations = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>();
                }
            }
            );
        }
        #endregion //컨트롤 초기화

        #region [데이타초기화(공통코드)]
        /// <summary>
        /// name         : xxx 데이터 초기화
        /// desc         : 화면 로드시 데이터를 초기화 합니다.
        /// author       : kimchihwan 
        /// create date  : 2012-06-07 오후 5:08:32
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void DataInit(int s)
        {
            //일정등록
            if (s.Equals(0) || s.Equals(99))
            {



                model.MedDoctorScheduleCriteriaRegistrationInObj = new MedDoctorScheduleCriteriaRegistration_IN();
                model.MedDoctorScheduleCriteriaRegistrationInOutObj = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>();
                model.ScheduleCodeOutObj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CODE_OUT>();

                dgrd_Schedule_AM.DataSource = null;
                dgrd_Schedule_PM.DataSource = null;


                ////CalYearCalendar PatternCollection 초기화가 안됨. 수동으로 개별 삭제.
                //if (model.PatternCollection != null && model.PatternCollection.Count > 0)
                ////if (calYear.SelectedDates.Count > 0)
                //{
                //    DateTime MinDate = model.PatternCollection[0].EventDate;
                //    DateTime MaxDate = MinDate;

                //    for (int i = 0; i < model.PatternCollection.Count(); i++)
                //    {
                //        if (MinDate >= model.PatternCollection[i].EventDate)
                //            MinDate = model.PatternCollection[i].EventDate;
                //        if (MaxDate <= model.PatternCollection[i].EventDate)
                //            MaxDate = model.PatternCollection[i].EventDate;
                //    }

                //    for (DateTime d = MinDate; d <= MaxDate; d = d.AddDays(1))
                //    {
                //        calYear.SelectedDates.Remove(new DateTime(d.Year, d.Month, d.Day));
                //        calYear.SelectedDates.Add(new DateTime(d.Year, d.Month, d.Day));
                //    }

                //    foreach (DateTime INFO in calYear.SelectedDates)
                //    {
                //        for (int i = 0; i < model.PatternCollection.Count(); i++)
                //        {
                //            if (INFO.Equals(model.PatternCollection[i].EventDate))
                //                model.PatternCollection.Remove(model.PatternCollection[i]);
                //        }
                //    }

                //    calYear.SelectedDate = DateTime.Now;

                //}

                //20170221 패턴초기화 수정 송민수
                if (calYear.SelectedDates.Count > 0)
                {
                    for (int i = calYear.SelectedDates.Count; i > 0; i--)
                    {
                        calYear.SelectedDates.RemoveAt(calYear.SelectedDates.Count - 1);
                    }
                }

                //공휴일정보초기화
                if (model.EventCollection != null)
                {
                    model.EventCollection.Clear();
                }

                exp_calYear.IsExpanded = true;
                //exp_calYear.IsExpanded = false;

                ftcal_Year.FromDate = DateTime.Now;
                ftcal_Year.ToDate = DateTime.Now.AddDays(365);

                model.PatternCollection = new CustomDateInfoCollection();

                ucPACodeAsk.Clear();

                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Add, btn_Delete, btn_Update);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Save, btn_Rcep);

                ControlHelper.SetEnableControl(true, btn_Save);
                ControlHelper.SetEnableControl(false, btn_Add, btn_Delete, btn_Rcep);

            }

            //휴진등록
            if (s.Equals(1) || s.Equals(99))
            {




                if (dtpck_Nsp_Wrk.SelectedDate.Equals(null))
                    dtpck_Nsp_Wrk.SelectedDate = DateTime.Now;
                if (dtpck_Nsp_Reg.SelectedDate.Equals(null))
                    dtpck_Nsp_Reg.SelectedDate = DateTime.Now;
                if (ftcal_NSP_Prd.FromDate.Equals(null))
                    ftcal_NSP_Prd.FromDate = DateTime.Now;
                if (ftcal_NSP_Prd.ToDate.Equals(null))
                    ftcal_NSP_Prd.ToDate = DateTime.Now;

                model.NspInOutObj = new MedDoctorScheduleRegistration_NSP_OUT();
                model.NspInObj = new MedDoctorScheduleRegistration_NSP_IN();
                model.NspOutObj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>();

                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Update);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Init, btn_CrDoc, btn_Add, btn_Delete, btn_Save, btn_Rcep, btn_Excel);

                ControlHelper.SetEnableControl(false, btn_Delete, btn_Rcep, btn_Excel, btn_CrDoc, ucPACodeAsk_NSP_Medr2, ucPACodeAsk_NSP_Rsn, ftcal_NSP_Prd, txtNsp_Remark);
                ControlHelper.SetEnableControl(true, rdo_NSP_OI);

                this.rdo_NSP_Medr.IsSelected = true;
                this.rdo_NSP_OI.SelectedIndex = 2;

                ucPACodeAsk_NSP_Medr1.SelectedTextCodeFocus();
                dtp_nsp_apy.SelectedDate = DateTime.Now;
                chxStrAmt.IsSelected = false;
                chxEndAmt.IsSelected = false;
                // 20231211 성현석 BRMH 보라매는 본원 하나만 존재하여 해당 세팅을 주석처리
                //rbtNspHspTp.SelectedIndex = 3;


            }

            //대진등록
            if (s.Equals(2) || s.Equals(99))
            {
                model.SFAD_IN = new MedDoctorScheduleRegistration_SFAD_INOUT();
                model.SFAD_OUT = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_SFAD_INOUT>();
                ControlHelper.SetEnableControl(false, ucPACodeAsk_SFAD_Medr2, btn_Add, btn_Delete, btn_Update, btn_Save);
                ControlHelper.SetEnableControl(true, btn_Init, btn_Close);
                ControlHelper.SetDisplayControl(true, ucPACodeAsk_SFAD_Medr2, btn_Add, btn_Delete, btn_Update, btn_Save, btn_Close);


                this.ucPACodeAsk_SFAD_Medr1.SelectedTextCodeFocus();
            }

            //콜전송내역
            if (s.Equals(3) || s.Equals(99))
            {
                ucPACodeAsk_CALL_Medr.Clear();
                model.CALL_IN = new MedDoctorScheduleRegistration_CALL_IN();
                model.CALL_OUT = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CALL_OUT>();

                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Add, btn_Delete, btn_Save, btn_Rcep, btn_Update);

                this.ftcal_CALL_NSP.FromDate = DateTime.Now;
                this.ftcal_CALL_NSP.ToDate = DateTime.Now;

                this.rbl_CALL.SelectedIndex = 0;
            }

            //비정규예약
            if (s.Equals(4) || s.Equals(99))
            {
                model.InCostRegularReservation = new MedDoctorScheduleRegistrationCostRegularReservation_INOUT();
                model.SelCostRegularReservation = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationCostRegularReservation_INOUT>();

                model.SelMedDoctorScheduleRegistrationSaveACDPCAPD = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT>();
                model.InMedDoctorScheduleRegistrationSaveACDPCAPD = new MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT();

                model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo = new MedDoctorScheduleRegistrationSaveACDPCAPDReqMemo_IN();

                MedDoctorScheduleRegistrationCostRegularReservation_INOUT temp = new MedDoctorScheduleRegistrationCostRegularReservation_INOUT();


                //비정규예약컨트롤초기화
                CostRegularReservationControlInit();
                btn_Update.IsEnabled = false;


            }



            ////다른화면에서 휴진등록 탭 호출 시 
            //if (!String.IsNullOrEmpty(NSP_INDEX))
            //{
            //    tabMain.SelectedIndex = Convert.ToInt16(NSP_INDEX);
            //}


            //if (!String.IsNullOrEmpty(DR_STF_NO))
            //{
            //    ucPACodeAsk_NSP_Medr1.SelectedTextCode = DR_STF_NO;
            //    ucPACodeAsk_NSP_Medr1.SelectedTextName3 = NSP_MED_DEPT_CD;
            //    ucPACodeAsk_NSP_Medr1.Search(1);
            //}


            ////다른화면에서 휴진등록 탭 호출 시 
            //if (!String.IsNullOrEmpty(DR_STF_NO))
            //{
            //    model.NspInObj.MEDR_STF_NO = DR_STF_NO;
            //}
            ////다른화면에서 휴진등록 탭 호출 시 
            //if (!String.IsNullOrEmpty(NSP_MED_DEPT_CD))
            //{
            //    ucPACodeAsk_NSP_Medr1.SelectedTextName3 = NSP_MED_DEPT_CD;
            //}


        }
        #endregion //데이타초기화(공통코드)

        #region [Methods]
        /// <summary>
        /// name         : btn_Click
        /// desc         : 각 HButton ButtonTyped="None" Event처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void btn_Click(object sender)
        {
            var inModel = new SelMedScheduleAsk_IN();
            //Int32 result_99 = 0;
            //닫기
            if (sender.Equals(btn_Close))
                this.Close();

            //초기화
            if (sender.Equals(btn_Init))
                this.DataInit(tabMain.SelectedIndex);

            //세션체크버튼
            if (sender.Equals(btnSessionchk))
            {
                PopUpBase pop = new PopUpBase();
                //일정등록
                if (tabMain.SelectedIndex.Equals(0))
                {
                    if (ucPACodeAsk.SelectedTextCode.Length == 5)
                        pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect", ucPACodeAsk.SelectedTextCode, ftcal_Year.FromDate, ftcal_Year.ToDate, ucPACodeAsk.SelectedTextName3);
                    else
                        pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect");
                }
                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                {
                    if (ucPACodeAsk_NSP_Medr1.SelectedTextCode.Length == 5)
                        pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect", ucPACodeAsk_NSP_Medr1.SelectedTextCode, model.NspInOutObj.APY_STR_DT == null ? DateTime.Now : model.NspInOutObj.APY_STR_DT, model.NspInOutObj.APY_END_DT == null ? DateTime.Now : model.NspInOutObj.APY_END_DT, ucPACodeAsk_NSP_Medr1.SelectedTextName3);
                    else
                        pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect");
                }

                //대진등록
                if (tabMain.SelectedIndex.Equals(2))
                {
                    if (ucPACodeAsk_SFAD_Medr1.SelectedTextCode.Length == 5)
                        pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect", ucPACodeAsk_SFAD_Medr1.SelectedTextCode, model.SFAD_IN.SFAD_STR_DTM == null ? DateTime.Now : model.SFAD_IN.SFAD_STR_DTM, model.SFAD_IN.SFAD_END_DTM == null ? DateTime.Now : model.SFAD_IN.SFAD_END_DTM, ucPACodeAsk_SFAD_Medr1.SelectedTextName3);
                    else
                        pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect");
                }
                pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                pop.ShowDialog();
                pop.Owner = Application.Current.MainWindow;
                pop.ShowInTaskbar = false;
            }


            //협조전여부
            if (sender.Equals(btn_CrDoc))
            {
                if (MsgBox.Display("등록하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES).Equals(MessageBoxResult.Yes))
                {



                    if (rdo_NSP_OI.SelectedIndex.Equals(0))
                        model.NspInOutObj.PACT_TP_CD = "O";
                    else if (rdo_NSP_OI.SelectedIndex.Equals(1))
                        model.NspInOutObj.PACT_TP_CD = "I";
                    else if (rdo_NSP_OI.SelectedIndex.Equals(2))
                    {
                        MsgBox.Display("외래/입원 상태로 수정할 수 없습니다. 해당 진료유형을 선택해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }

                    foreach (var item in model.NspOutObj)
                    {
                        if (item.BASE_STATE.Equals(DataRowState.Modified))
                        {
                            model.CRDOC_TEMP.Add(new MedDoctorScheduleRegistration_NSP_OUT()
                            {
                                CRDOC_YN = item.CRDOC_YN,
                                MEDR_SID = item.MEDR_SID,
                                MED_DEPT_CD = item.MED_DEPT_CD,
                                APY_STR_DT = item.APY_STR_DT,
                                APY_END_DT = item.APY_END_DT,
                                PACT_TP_CD = item.PACT_TP_CD
                            }
                            );
                        }
                    }
                    HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

                    for (int i = 0; i < model.CRDOC_TEMP.Count; i++)
                    {
                        io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateDoctorNotSeeingPtsCooperationDocumentYesOrNoModification", model.CRDOC_TEMP[i]) as HIS.Core.Global.DTO.Result_OUT;
                    }

                    if (io_result.IsSucess != true)
                    {
                        MsgBox.Display("저장에 실패 하였습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }
                    else
                    {
                        MsgBox.Display("정상적으로 저장되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.btn_Click(btn_NSP_Search);
                    }
                }
            }

            //엑셀
            if (sender.Equals(btn_Excel))
            {
                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                {
                    // dgrd_NSP.ToExcel("휴진등록 내역", "", true, false, 2, 2);
                    #region 다운로드/출력 로그 설정                
                    var excelDownloadLog = new DownloadPrint_IN()
                    {
                        MenuID = "AC_HIS.PA.AC.PE.SC.UI_/MedDoctorScheduleRegistration",
                        MenuName = "의사진료일정등록",
                        Data = dgrd_NSP,
                        ExportType = DownloadPrint_IN.DownloadPrintType.Excel
                    };

                    if (!LoggingReasonHelper.InsertDownloadPrintLog(excelDownloadLog))
                    {
                        return;
                    }
                    else
                    {
                        dgrd_NSP.ToExcel("휴진등록 내역", "", true, false, 2, 2);
                    }
                    #endregion
                }


            }

            //추가
            if (sender.Equals(btn_Add))
            {
                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                {
                    //등록일
                    if (rdo_NSP_Wrk_Seq.SelectedIndex.Equals(0))
                    {
                        model.NspInOutObj = new MedDoctorScheduleRegistration_NSP_OUT();

                        ControlHelper.SetEnableControl(true, ucPACodeAsk_NSP_Medr2);

                        rdo_NSP_Wrk_Seq.SelectedIndex = 0;

                        ucPACodeAsk_NSP_Medr2.SelectedTextCodeFocus();
                    }

                    //휴진일
                    if (rdo_NSP_Wrk_Seq.SelectedIndex.Equals(1))
                    {
                        model.NspInOutObj = new MedDoctorScheduleRegistration_NSP_OUT();

                        ControlHelper.SetEnableControl(true, ucPACodeAsk_NSP_Medr2);

                        rdo_NSP_Wrk_Seq.SelectedIndex = 0;

                        ucPACodeAsk_NSP_Medr2.SelectedTextCodeFocus();
                    }

                    //의사
                    if (rdo_NSP_Wrk_Seq.SelectedIndex.Equals(2))
                    {
                        model.NspInOutObj = new MedDoctorScheduleRegistration_NSP_OUT();

                        ucPACodeAsk_NSP_Medr2.SelectedTextCode = ucPACodeAsk_NSP_Medr1.SelectedTextCode;
                        ucPACodeAsk_NSP_Medr2.CodeDataSearch();

                        ucPACodeAsk_NSP_Rsn.SelectedTextCodeFocus();
                    }

                    //추가 시 기본값으로 외래/입원, 당일지정료발생체크해제, 보충여부 체크해제
                    rdo_NSP_OI.SelectedIndex = 2;
                    chxStrAmt.IsSelected = false;
                    chxSplm.IsChecked = false;
                    chxEndAmt.IsSelected = false;
                    dtp_nsp_apy.SelectedDate = DateTime.Now;
                    chk_Visible("btn_Add");
                }

                //대진등록
                if (tabMain.SelectedIndex.Equals(2))
                {
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Save);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Update);
                    ControlHelper.SetEnableControl(true, btn_Save, ftcal_SFAD, ucPACodeAsk_SFAD_Rsn, ucPACodeAsk_SFAD_Medr2);
                    ControlHelper.SetEnableControl(false, btn_Update, btn_Delete, btn_Add);
                    this.ftcal_SFAD.FromDate = DateTime.Now;
                    this.ftcal_SFAD.ToDate = DateTime.Now;
                    this.ucPACodeAsk_SFAD_Rsn.Clear();

                    this.ucPACodeAsk_SFAD_Medr2.SelectedTextCodeFocus();

                    ftcal_SFAD.IsFocusFromDate = true;
                }
            }

            //수정
            if (sender.Equals(btn_Update))
            {
                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                    this.CRUD_NSP(sender);

                //대진등록
                if (tabMain.SelectedIndex.Equals(2))
                {
                    HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

                    //의사 확인
                    if (String.IsNullOrEmpty(model.SFAD_IN.MEDR_SID))
                    {
                        MsgBox.Display("의사를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ucPACodeAsk_SFAD_Medr1.SelectedTextCodeFocus();
                        return;
                    }

                    if (temp_sfad_str_dtm.Value.ToShortDateString() != model.SFAD_IN.SFAD_STR_DTM.Value.ToShortDateString())
                    {
                        MsgBox.Display("개시일은 수정이 불가능합니다. 삭제후 재입력 하세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        model.SFAD_IN.SFAD_STR_DTM = temp_sfad_str_dtm;
                        this.ftcal_SFAD.IsFocusFromDate = true;
                        return;
                    }

                    if (model.SFAD_IN.SFAD_STR_DTM < DateTime.Now)
                    {
                        MsgBox.Display("대진기간 시작일은 현재시각보다 이후만 수정가능합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ftcal_SFAD.IsFocusFromDate = true;
                        return;
                    }

                    if (model.SFAD_IN.SFAD_END_DTM < DateTime.Now)
                    {
                        MsgBox.Display("대진기간 종료일은 현재시각보다 이후만 수정가능합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ftcal_SFAD.IsFocusToDate = true;
                        return;
                    }

                    //대진 중복기간 확인
                    if (model.SFAD_OUT.Count() > 0)
                    {
                        DateTime str_tm = (DateTime)model.SFAD_IN.SFAD_STR_DTM;
                        DateTime end_tm = (DateTime)model.SFAD_IN.SFAD_END_DTM;

                        for (int i = 0; i < model.SFAD_OUT.Count(); i++)
                        {
                            if (((model.SFAD_OUT[i].SFAD_STR_DTM >= str_tm && model.SFAD_OUT[i].SFAD_STR_DTM <= end_tm) ||
                                    (model.SFAD_OUT[i].SFAD_END_DTM >= str_tm && model.SFAD_OUT[i].SFAD_END_DTM <= end_tm)) && i != dgrd_SFAD.SelectedIndex)
                            {
                                MsgBox.Display("중복된 기간이 있습니다. 대진기간을 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                                return;
                            }

                        }
                    }

                    //예약제한코드 개편 남동균 DK20201101
                    if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "10" &&                                                                                 //10코드면
                        (string.IsNullOrEmpty(txtNSP_RSN_CNTE.Text.Replace(" ", "")) || string.IsNullOrEmpty(ucNSP_RSN_STF_NO.SelectedTextName1)))   //필수입력
                    {
                        MsgBox.Display("변경사유 '10'입력시 요청자와 사유입력은 필수입니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        HReceiptPop.IsOpen = true;
                        return;
                    }

                    if (MsgBox.Display("수정하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES) == MessageBoxResult.Yes)
                    {
                        io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateSubstitutionForAnotherDoctorScheduleDeletion", model.SFAD_IN) as HIS.Core.Global.DTO.Result_OUT;
                    }




                    //2020-11-16 남동균 사유 "99. 진료의요청"으로 변경되었을때 이력 쌓자 DK20201101   이거 좀 보류...99이면서 06인 케이스가 되어버림...
                    //if (io_result.IsSucess == true && ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "99")
                    //{
                    //    inModel.IN_MEDR_STF_NO = ucPACodeAsk_SFAD_Medr1.SelectedTextCode;
                    //    inModel.IN_NSP_RSN_TP_CD = ucPACodeAsk_SFAD_Rsn.SelectedTextCode;
                    //    inModel.IN_WK_CHG_TP_CD = "U";
                    //    inModel.IN_MED_DEPT_CD = ucPACodeAsk_SFAD_Medr1.SelectedTextName3;
                    //    inModel.IN_MEDR_SID = model.SFAD_IN.MEDR_SID;
                    //    inModel.IN_MED_DTM = model.SFAD_IN.SFAD_STR_DTM.ToString();
                    //    inModel.IN_MED_DTM_TO = model.SFAD_IN.SFAD_END_DTM.ToString();
                    //    inModel.IN_MED_DTM_TO = inModel.IN_MED_DTM;

                    //    result_99 = (Int32)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.DoctorMedScheduleNursingModificationBL", "InsMedicalTreatmentNotSeeingPatientsCodeInputReason_FRTO2", inModel);
                    //}

                    if (io_result.IsSucess == true)
                    {
                        MsgBox.Display("수정되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.btn_Click(btn_SFAD_Search);
                    }
                }

                //비정규예약
                if (tabMain.SelectedIndex.Equals(4))
                {

                    //조회했던 값과 현재 값이 다르면 Insert/Update 메소드를 탄다.

                    if (temp != null)
                    {

                        //강남센터
                        if (!txtNedAm1.Text.Equals(temp.AM_1.ToString()) || !txtNedPm1.Text.Equals(temp.PM_1.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "1", "*", txtNedAm1.Text, txtNedPm1.Text);
                        }
                        //진료협력
                        if (!txtNedAm2.Text.Equals(temp.AM_2.ToString()) || !txtNedPm2.Text.Equals(temp.PM_2.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "2", "*", txtNedAm2.Text, txtNedPm2.Text);
                        }

                        // 2019.03.06 외래 진료예약 개선 방안 - (퇴원환자에 대한 추가 로직 삭제)
                        //퇴원환자
                        //if (!txtNedAm3.Text.Equals(temp.AM_3.ToString()) || !txtNedPm3.Text.Equals(temp.PM_3.ToString()))
                        //{
                        //    SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "3", "*", txtNedAm3.Text, txtNedPm3.Text);
                        //}

                        //타과의뢰
                        if (!txtNedAm4.Text.Equals(temp.AM_4.ToString()) || !txtNedPm4.Text.Equals(temp.PM_4.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "4", "*", txtNedAm4.Text, txtNedPm4.Text);
                        }


                        //진료과 정규예약 시작---------------------
                        if (!txtNedAm52.Text.Equals(temp.AM_5_MON.ToString()) || !txtNedPm52.Text.Equals(temp.PM_5_MON.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "5", "2", txtNedAm52.Text, txtNedPm52.Text);
                        }
                        if (!txtNedAm53.Text.Equals(temp.AM_5_TUE.ToString()) || !txtNedPm53.Text.Equals(temp.PM_5_TUE.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "5", "3", txtNedAm53.Text, txtNedPm53.Text);
                        }
                        if (!txtNedAm54.Text.Equals(temp.AM_5_WED.ToString()) || !txtNedPm54.Text.Equals(temp.PM_5_WED.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "5", "4", txtNedAm54.Text, txtNedPm54.Text);
                        }
                        if (!txtNedAm55.Text.Equals(temp.AM_5_THR.ToString()) || !txtNedPm55.Text.Equals(temp.PM_5_THR.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "5", "5", txtNedAm55.Text, txtNedPm55.Text);
                        }
                        if (!txtNedAm56.Text.Equals(temp.AM_5_FRI.ToString()) || !txtNedPm56.Text.Equals(temp.PM_5_FRI.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "5", "6", txtNedAm56.Text, txtNedPm56.Text);
                        }
                        if (!txtNedAm57.Text.Equals(temp.AM_5_SAT.ToString()) || !txtNedPm57.Text.Equals(temp.PM_5_SAT.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "5", "7", txtNedAm57.Text, txtNedPm57.Text);
                        }
                        //진료과 정규예약 끝---------------------



                        //한타임당 절대인원수 시작-----------------------
                        if (!txtNedAm62.Text.Equals(temp.AM_6_MON.ToString()) || !txtNedPm62.Text.Equals(temp.PM_6_MON.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "6", "2", txtNedAm62.Text, txtNedPm62.Text);
                        }
                        if (!txtNedAm63.Text.Equals(temp.AM_6_TUE.ToString()) || !txtNedPm63.Text.Equals(temp.PM_6_TUE.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "6", "3", txtNedAm63.Text, txtNedPm63.Text);
                        }
                        if (!txtNedAm64.Text.Equals(temp.AM_6_WED.ToString()) || !txtNedPm64.Text.Equals(temp.PM_6_WED.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "6", "4", txtNedAm54.Text, txtNedPm64.Text);
                        }
                        if (!txtNedAm65.Text.Equals(temp.AM_6_THR.ToString()) || !txtNedPm65.Text.Equals(temp.PM_6_THR.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "6", "5", txtNedAm65.Text, txtNedPm65.Text);
                        }
                        if (!txtNedAm66.Text.Equals(temp.AM_6_FRI.ToString()) || !txtNedPm66.Text.Equals(temp.PM_6_FRI.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "6", "6", txtNedAm66.Text, txtNedPm66.Text);
                        }
                        if (!txtNedAm67.Text.Equals(temp.AM_6_SAT.ToString()) || !txtNedPm67.Text.Equals(temp.PM_6_SAT.ToString()))
                        {
                            SaveACDPCAPD(pacaCrrMeddr.SelectedTextName3, pacaCrrMeddr.SelectedTextName2Hidden, pacaCrrMeddr.SelectedTextCode, "6", "7", txtNedAm67.Text, txtNedPm67.Text);
                        }
                        //한타임당 절대인원수 끝-----------------------




                        /*교수별 요구사항 메모----------------------
                        //if (temp.RSV_ATNT_CNTE == null)
                        //{
                        //    model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_DR_SID = pacaCrrMeddr.SelectedTextName2Hidden;
                        //    model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_DR_STF_NO = pacaCrrMeddr.SelectedTextCode;
                        //    model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_MED_DEPT_CD = pacaCrrMeddr.SelectedTextName3;
                        //    model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_RSV_ATNT_CNTE = txtReqMemo.Text;


                        //    UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo", model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo);
                        //    this.btn_Click(btnCrrSearch);
                        //}
                        //else
                        //{
                        //    if (!txtReqMemo.Text.Equals(temp.RSV_ATNT_CNTE.ToString()))
                        //    {
                        
                        model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_DR_SID = pacaCrrMeddr.SelectedTextName2Hidden;
                        model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_DR_STF_NO = pacaCrrMeddr.SelectedTextCode;
                        model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_MED_DEPT_CD = pacaCrrMeddr.SelectedTextName3;
                        model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo.IN_RSV_ATNT_CNTE = txtReqMemo.Text;

   
                        HIS.Core.Global.DTO.Result_OUT io_result = ((HIS.Core.Global.DTO.Result_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo", model.InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo));

                        MsgBox.Display("PAMCN_000568", MessageType.MSG_TYPE_INFORMATION); // [수정 되었습니다.]
                        교수별 요구사항 메모 수정안되게 20160316 */

                        this.btn_Click(btnCrrSearch);


                        //    }
                        //}
                        //교수별 요구사항 메모----------------------
                    }
                }

            }

            //삭제
            if (sender.Equals(btn_Delete))
            {
                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                    this.CRUD_NSP(sender);

                //대진등록
                if (tabMain.SelectedIndex.Equals(2))
                {
                    //HIS.PA.AC.PE.SC.DelSubstitutionForAnotherDoctorScheduleDeletion
                    HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

                    //의사 확인
                    if (String.IsNullOrEmpty(model.SFAD_IN.MEDR_SID))
                    {
                        MsgBox.Display("의사를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ucPACodeAsk_SFAD_Medr1.SelectedTextCodeFocus();
                        return;
                    }

                    //대진기간 확인
                    if (String.IsNullOrEmpty(model.SFAD_IN.SFAD_STR_DTM.ToString()) || String.IsNullOrEmpty(model.SFAD_IN.SFAD_END_DTM.ToString()))
                    {
                        MsgBox.Display("대진기간을 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ftcal_SFAD.IsFocusFromDate = true;
                        return;
                    }

                    //대진기간 및 시간 유효성 확인
                    if (model.SFAD_IN.SFAD_STR_DTM >= model.SFAD_IN.SFAD_END_DTM)
                    {
                        MsgBox.Display("대진기간 오류입니다. 기간을 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ftcal_SFAD.IsFocusFromDate = true;
                        return;
                    }

                    if (this.ftcal_SFAD.FromDate <= DateTime.Now || this.ftcal_SFAD.ToDate <= DateTime.Now)
                    {
                        MsgBox.Display("현재시간 이후의 대진기간만 삭제가능합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }

                    Boolean result = false;
                    if (MsgBox.Display("삭제하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES) == MessageBoxResult.Yes)
                    {
                        //io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "DeleteSubstitutionForAnotherDoctorScheduleDeletion", model.SFAD_IN) as HIS.Core.Global.DTO.Result_OUT;
                        result = (Boolean)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "DeleteSubstitutionForAnotherDoctorScheduleDeletion", model.SFAD_IN);
                    }

                    if (result)
                    {
                        MsgBox.Display("삭제되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.btn_Click(btn_SFAD_Search);
                        ControlHelper.SetDisplayControl(true, btn_Add, btn_Delete, btn_Update, btn_Save);
                        ControlHelper.SetEnableControl(true, btn_Save);
                        ControlHelper.SetEnableControl(false, btn_Add, btn_Delete, btn_Update);

                    }
                    else
                    {
                        MsgBox.Display("삭제실패 : 정보를 확인하세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    }
                }
            }

            //저장
            if (sender.Equals(btn_Save))
            {
                //일정등록
                if (tabMain.SelectedIndex.Equals(0))
                {
                    if (!model.PatternCollection.Count().Equals(0))
                    {
                        HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

                        model.Schedule_IN = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Schedule_IN>();
                        DateTime MinDate = model.PatternCollection[0].EventDate;// new DateTime(9999, 12, 31);
                        DateTime MaxDate = MinDate;// new DateTime(1111, 01, 01);

                        for (int i = 0; i < model.PatternCollection.Count(); i++)
                        {
                            model.Schedule_IN.Add(new MedDoctorScheduleRegistration_Schedule_IN());
                            model.Schedule_IN[i].MEDR_SID = ucPACodeAsk.SelectedTextName2Hidden;                    //진료의직원식별ID
                            model.Schedule_IN[i].MEDR_STF_NO = ucPACodeAsk.SelectedTextCode;                        //진료의직원번호
                            model.Schedule_IN[i].MED_DEPT_CD = ucPACodeAsk.SelectedTextName3;                       //진료부서코드
                            model.Schedule_IN[i].MED_DTM = model.PatternCollection[i].EventDate;                    //진료일자
                            model.Schedule_IN[i].MEDS_BSC_CD = model.ScheduleCodeOutObj[int.Parse(model.PatternCollection[i].PatternType.ToString())].MEDS_BSC_CD;   //진료일정기본코드
                            model.Schedule_IN[i].MED_CLS_CD = String.Empty;                                         //진료유형코드

                            if (MinDate >= model.PatternCollection[i].EventDate)
                                MinDate = model.PatternCollection[i].EventDate;
                            if (MaxDate <= model.PatternCollection[i].EventDate)
                                MaxDate = model.PatternCollection[i].EventDate;
                        }

                        if (MinDate.DayOfWeek == DayOfWeek.Tuesday)
                            MinDate = MinDate.AddDays(-1);
                        else if (MinDate.DayOfWeek == DayOfWeek.Wednesday)
                            MinDate = MinDate.AddDays(-2);
                        else if (MinDate.DayOfWeek == DayOfWeek.Thursday)
                            MinDate = MinDate.AddDays(-3);
                        else if (MinDate.DayOfWeek == DayOfWeek.Friday)
                            MinDate = MinDate.AddDays(-4);
                        else if (MinDate.DayOfWeek == DayOfWeek.Saturday)
                            MinDate = MinDate.AddDays(-5);

                        if (MaxDate.DayOfWeek == DayOfWeek.Monday)
                            MaxDate = MaxDate.AddDays(5);
                        else if (MaxDate.DayOfWeek == DayOfWeek.Tuesday)
                            MaxDate = MaxDate.AddDays(4);
                        else if (MaxDate.DayOfWeek == DayOfWeek.Wednesday)
                            MaxDate = MaxDate.AddDays(3);
                        else if (MaxDate.DayOfWeek == DayOfWeek.Thursday)
                            MaxDate = MaxDate.AddDays(2);
                        else if (MaxDate.DayOfWeek == DayOfWeek.Friday)
                            MaxDate = MaxDate.AddDays(1);

                        model.Schedule_IN[0].MINDATE = MinDate;                                                     //적용시작일자
                        model.Schedule_IN[0].MAXDATE = MaxDate;                                                     //적용종료일자



                        if (MsgBox.Display("[" + MinDate.ToShortDateString() + " ~ " + MaxDate.ToShortDateString() + "] 기간의 일정을 등록하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES) != MessageBoxResult.Yes)
                        {
                            return;
                        }

                        string AmYnDef = "";
                        string PmYnDef = "";
                        // 20240311 김재강 : 일요일 선택가능하도록 변경함에 따른 코드 추가
                        if (Linq_Mon_AM.Count > 0 || Linq_Tue_AM.Count > 0 || Linq_Wed_AM.Count > 0 || Linq_Thu_AM.Count > 0 || Linq_Fri_AM.Count > 0 || Linq_Sat_AM.Count > 0 || Linq_Sun_AM.Count > 0)
                        {
                            AmYnDef = "Y";
                        }
                        if (Linq_Mon_PM.Count > 0 || Linq_Tue_PM.Count > 0 || Linq_Wed_PM.Count > 0 || Linq_Thu_PM.Count > 0 || Linq_Fri_PM.Count > 0 || Linq_Sat_PM.Count > 0 || Linq_Sun_PM.Count > 0)
                        {
                            PmYnDef = "Y";
                        }



                        ////차세대 기간동안만 권한체크
                        //if (((MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //   || (MinDate <= Convert.ToDateTime("2016-12-01") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //   || (MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-11-21")))
                        //   || (MinDate >= Convert.ToDateTime("2016-11-21") && (MaxDate <= Convert.ToDateTime("2016-12-01")))
                        //   )
                        //&&
                        //((SessionManager.UserInfo.STF_NO == "C9217")
                        // || (SessionManager.UserInfo.STF_NO == "HISPA")
                        // || (SessionManager.UserInfo.STF_NO == "W0143")
                        // || (SessionManager.UserInfo.STF_NO == "11267")  //성형외과외래 김진경
                        // || (SessionManager.UserInfo.STF_NO == "11422")))//암센터 종양내과센터 이성은
                        //{

                        //PopUpBase pop = base.OnLoadPopupMenu("AS_PATM_OPRSV_EachMonthMedReservationCrccmAsk", this.model.SelTimeZoneClassfiedByReservationInObj);
                        var pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInformPopup", MinDate, MaxDate, AmYnDef, PmYnDef);
                        dynamic SessionInforModel = ((pop.GetContent()) as UserControlBase).DataContext;

                        pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                        pop.ShowInTaskbar = false;
                        pop.Owner = Application.Current.MainWindow;
                        pop.ShowDialog();
                        pop.Close();


                        var YN = SessionInforModel.YN;
                        var AmYn = SessionInforModel.AmSessionYn;
                        var PmYn = SessionInforModel.PmSessionYn;
                        var FromDate = SessionInforModel.FromDate;
                        var ToDate = SessionInforModel.ToDate;



                        //확인을 눌렀을 시
                        if (YN == "Y")
                        {
                            model.InSessionInform = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Session_IN>();

                            for (int i = 0; i < model.PatternCollection.Count(); i++)
                            {
                                model.InSessionInform.Add(new MedDoctorScheduleRegistration_Session_IN());
                                model.InSessionInform[i].MEDR_SID = ucPACodeAsk.SelectedTextName2Hidden;                    //진료의직원식별ID
                                model.InSessionInform[i].MEDR_STF_NO = ucPACodeAsk.SelectedTextCode;                        //진료의직원번호
                                model.InSessionInform[i].MED_DEPT_CD = ucPACodeAsk.SelectedTextName3;                       //진료부서코드
                                model.InSessionInform[i].MED_DTM = model.PatternCollection[i].EventDate;                    //진료일자
                                model.InSessionInform[i].MEDS_BSC_CD = model.ScheduleCodeOutObj[int.Parse(model.PatternCollection[i].PatternType.ToString())].MEDS_BSC_CD;   //진료일정기본코드
                                                                                                                                                                             //model.InSessionInform[i].SESSIONGUBN = SessionInforModel.SessionGubn;                                         //세션구분
                                model.InSessionInform[i].AMYN = AmYn;                                         //오전세션여부
                                model.InSessionInform[i].PMYN = PmYn;                                         //오후세션여부


                            }
                            io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertSessionInform", model.InSessionInform) as HIS.Core.Global.DTO.Result_OUT;
                            MsgBox.Display("세션정보가 등록되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);

                        }
                        else
                        {
                            MsgBox.Display("이후에 세션정보를 직접 입력해주셔야합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        }
                        //}
                        //else if (((MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //    || (MinDate <= Convert.ToDateTime("2016-12-01") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //    || (MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-11-21")))
                        //    || (MinDate >= Convert.ToDateTime("2016-11-21") && (MaxDate <= Convert.ToDateTime("2016-12-01")))
                        //    )
                        // &&
                        // !((SessionManager.UserInfo.STF_NO == "C9217")
                        // || (SessionManager.UserInfo.STF_NO == "HISPA")
                        // || (SessionManager.UserInfo.STF_NO == "W0143")
                        // || (SessionManager.UserInfo.STF_NO == "11267")//성형외과외래 김진경
                        // || (SessionManager.UserInfo.STF_NO == "11422")))//암센터 종양내과센터 이성은
                        //{

                        //}
                        //else
                        //{

                        //    //PopUpBase pop = base.OnLoadPopupMenu("AS_PATM_OPRSV_EachMonthMedReservationCrccmAsk", this.model.SelTimeZoneClassfiedByReservationInObj);
                        //    var pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInformPopup", MinDate, MaxDate, AmYnDef, PmYnDef);
                        //    dynamic SessionInforModel = ((pop.GetContent()) as UserControlBase).DataContext;

                        //    pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                        //    pop.ShowInTaskbar = false;
                        //    pop.Owner = Application.Current.MainWindow;
                        //    pop.ShowDialog();
                        //    pop.Close();


                        //    var YN = SessionInforModel.YN;
                        //    var AmYn = SessionInforModel.AmSessionYn;
                        //    var PmYn = SessionInforModel.PmSessionYn;
                        //    var FromDate = SessionInforModel.FromDate;
                        //    var ToDate = SessionInforModel.ToDate;



                        //    //확인을 눌렀을 시
                        //    if (YN == "Y")
                        //    {
                        //        model.InSessionInform = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Session_IN>();

                        //        for (int i = 0; i < model.PatternCollection.Count(); i++)
                        //        {
                        //            model.InSessionInform.Add(new MedDoctorScheduleRegistration_Session_IN());
                        //            model.InSessionInform[i].MEDR_SID = ucPACodeAsk.SelectedTextName2Hidden;                    //진료의직원식별ID
                        //            model.InSessionInform[i].MEDR_STF_NO = ucPACodeAsk.SelectedTextCode;                        //진료의직원번호
                        //            model.InSessionInform[i].MED_DEPT_CD = ucPACodeAsk.SelectedTextName3;                       //진료부서코드
                        //            model.InSessionInform[i].MED_DTM = model.PatternCollection[i].EventDate;                    //진료일자
                        //            model.InSessionInform[i].MEDS_BSC_CD = model.ScheduleCodeOutObj[int.Parse(model.PatternCollection[i].PatternType.ToString())].MEDS_BSC_CD;   //진료일정기본코드
                        //                                                                                                                                                         //model.InSessionInform[i].SESSIONGUBN = SessionInforModel.SessionGubn;                                         //세션구분
                        //            model.InSessionInform[i].AMYN = AmYn;                                         //오전세션여부
                        //            model.InSessionInform[i].PMYN = PmYn;                                         //오후세션여부


                        //        }
                        //        io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertSessionInform", model.InSessionInform) as HIS.Core.Global.DTO.Result_OUT;
                        //        MsgBox.Display("세션정보가 등록되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);

                        //    }
                        //    else
                        //    {
                        //        MsgBox.Display("이후에 세션정보를 직접 입력해주셔야합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        //    }
                        //}




                        ////2016.06.09 HIS 차세대 오픈 기간 권한 있는 사람은 기준등록에있는 시케줄 대로 데이터 업데이트 및 인설트 가능
                        //if (((MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //    || (MinDate <= Convert.ToDateTime("2016-12-01") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //    || (MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-11-21")))
                        //    || (MinDate >= Convert.ToDateTime("2016-11-21") && (MaxDate <= Convert.ToDateTime("2016-12-01")))
                        //    )
                        // &&
                        // ((SessionManager.UserInfo.STF_NO == "C9217") 
                        // || (SessionManager.UserInfo.STF_NO == "HISPA") 
                        // || (SessionManager.UserInfo.STF_NO == "W0143") 
                        // || (SessionManager.UserInfo.STF_NO == "11267")//성형외과외래 김진경
                        // || (SessionManager.UserInfo.STF_NO == "11422")))//암센터 종양내과센터 이성은
                        //{
                        //    io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertDoctorMedScheduleHIS", model.Schedule_IN) as HIS.Core.Global.DTO.Result_OUT;
                        //    MsgBox.Display("진료일정이 등록되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);

                        //}
                        //else if (((MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //    || (MinDate <= Convert.ToDateTime("2016-12-01") && (MaxDate >= Convert.ToDateTime("2016-12-01")))
                        //    || (MinDate <= Convert.ToDateTime("2016-11-21") && (MaxDate >= Convert.ToDateTime("2016-11-21")))
                        //    || (MinDate >= Convert.ToDateTime("2016-11-21") && (MaxDate <= Convert.ToDateTime("2016-12-01")))
                        //    )
                        // &&
                        // !((SessionManager.UserInfo.STF_NO == "C9217")
                        // || (SessionManager.UserInfo.STF_NO == "HISPA")
                        // || (SessionManager.UserInfo.STF_NO == "W0143")
                        // || (SessionManager.UserInfo.STF_NO == "11267")//성형외과외래 김진경
                        // || (SessionManager.UserInfo.STF_NO == "11422")))//암센터 종양내과센터 이성은
                        //{
                        //    MsgBox.Display("HIS 2016-11-18 ~ 2016-12-01 기간 데이터 수정 권한 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        //}
                        //else
                        //{
                        io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertDoctorMedSchedule", model.Schedule_IN) as HIS.Core.Global.DTO.Result_OUT;
                        //    MsgBox.Display("진료일정이 등록되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        //}

                        MsgBox.Display("진료일정이 등록되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);


                    }
                    else
                    {
                        MsgBox.Display("등록할 내역이 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    }
                }
                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                    this.CRUD_NSP(sender);

                //대진등록
                if (tabMain.SelectedIndex.Equals(2))
                {
                    HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

                    model.SFAD_IN.SFAD_MEDR_SID = ucPACodeAsk_SFAD_Medr2.SelectedTextName2Hidden;
                    model.SFAD_IN.SFAD_MED_DEPT_CD = ucPACodeAsk_SFAD_Medr2.SelectedTextName3;
                    model.SFAD_IN.SFAD_MEDR_STF_NO = ucPACodeAsk_SFAD_Medr2.SelectedTextCode;
                    model.SFAD_IN.SFAD_STR_DTM = ftcal_SFAD.FromDate;
                    model.SFAD_IN.SFAD_END_DTM = ftcal_SFAD.ToDate;
                    model.SFAD_IN.SFAD_RSN_TP_CD = ucPACodeAsk_SFAD_Rsn.SelectedTextCode;

                    //의사 확인
                    if (String.IsNullOrEmpty(model.SFAD_IN.MEDR_SID))
                    {
                        MsgBox.Display("조회 후 신규등록이 가능합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }

                    //대진의사 확인
                    if (String.IsNullOrEmpty(model.SFAD_IN.SFAD_MEDR_SID))
                    {
                        MsgBox.Display("등록할 대진의사를 조회해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }

                    //대진기간 확인
                    if (String.IsNullOrEmpty(model.SFAD_IN.SFAD_STR_DTM.ToString()) || String.IsNullOrEmpty(model.SFAD_IN.SFAD_END_DTM.ToString()))
                    {
                        MsgBox.Display("대진기간을 입력해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ftcal_SFAD.IsFocusFromDate = true;
                        return;
                    }

                    //대진기간 및 시간 유효성 확인
                    if (model.SFAD_IN.SFAD_STR_DTM >= model.SFAD_IN.SFAD_END_DTM)
                    {
                        MsgBox.Display("대진기간입력 오류입니다. 기간을 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        this.ftcal_SFAD.IsFocusFromDate = true;
                        return;
                    }


                    //대진사유 확인
                    if (String.IsNullOrEmpty(model.SFAD_IN.SFAD_RSN_TP_CD))
                    {
                        MsgBox.Display("대진사유를 조회해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }

                    if (MsgBox.Display("대진등록 하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES) == MessageBoxResult.Yes)
                    {
                        //대진 중복기간 확인
                        if (model.SFAD_OUT.Count() > 0)
                        {
                            DateTime str_tm = (DateTime)model.SFAD_IN.SFAD_STR_DTM;
                            DateTime end_tm = (DateTime)model.SFAD_IN.SFAD_END_DTM;

                            for (int i = 0; i < model.SFAD_OUT.Count(); i++)
                            {
                                if (((model.SFAD_OUT[i].SFAD_STR_DTM >= str_tm && model.SFAD_OUT[i].SFAD_STR_DTM <= end_tm) ||
                                    (model.SFAD_OUT[i].SFAD_END_DTM >= str_tm && model.SFAD_OUT[i].SFAD_END_DTM <= end_tm)))
                                {
                                    MsgBox.Display("중복된 기간이 있습니다. 대진기간을 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                                    return;
                                }
                            }
                        }

                        if (String.IsNullOrEmpty(model.SFAD_IN.SFAD_MEDR_SID))
                        {
                            MsgBox.Display("대진의사를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                            this.ucPACodeAsk_SFAD_Medr2.SelectedTextCodeFocus();
                            return;
                        }

                        if (String.IsNullOrEmpty(model.SFAD_IN.SFAD_STR_DTM.ToString()) || String.IsNullOrEmpty(model.SFAD_IN.SFAD_END_DTM.ToString()))
                        {
                            MsgBox.Display("대진기간을 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                            this.ftcal_SFAD.IsFocusFromDate = true;
                            return;
                        }

                        if (String.IsNullOrEmpty(model.SFAD_IN.SFAD_RSN_TP_CD))
                        {
                            MsgBox.Display("대진사유를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                            this.ucPACodeAsk_SFAD_Rsn.SelectedTextCodeFocus();
                            return;
                        }

                        //현재날짜이후만 등록 수정 가능
                        if (ftcal_SFAD.FromDate < DateTime.Now.AddDays(-1))
                        {
                            MsgBox.Display("대진은 현재 날짜 이후로만 등록 가능합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                            this.ftcal_SFAD.IsFocusFromDate = true;
                            return;
                        }

                        //예약제한코드 개편 남동균 DK20201101
                        if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "10" &&                                                                                 //10코드면
                            (string.IsNullOrEmpty(txtNSP_RSN_CNTE.Text.Replace(" ", "")) || string.IsNullOrEmpty(ucNSP_RSN_STF_NO.SelectedTextName1)))   //필수입력
                        {
                            MsgBox.Display("변경사유 '10'입력시 요청자와 사유입력은 필수입니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                            HReceiptPop.IsOpen = true;
                            return;
                        }



                        io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertSubstitutionForAnotherDoctorScheduleRegistration", model.SFAD_IN) as HIS.Core.Global.DTO.Result_OUT;


                        ////2020-11-16 남동균 사유 "99. 진료의요청"으로 변경되었을때 이력 쌓자 DK20201101
                        //if (io_result.IsSucess == true && ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "99")
                        //{
                        //    inModel.IN_MED_DTM_TO = inModel.IN_MED_DTM;
                        //    result_99 = (Int32)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.DoctorMedScheduleNursingModificationBL", "InsMedicalTreatmentNotSeeingPatientsCodeInputReason_FRTO2", inModel);
                        //}


                        //2020-11-16 남동균 사유 "99. 진료의요청"으로 변경되었을때 이력 쌓자 DK20201101   이거 좀 보류...99이면서 06인 케이스가 되어버림...
                        //if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "99")
                        //{
                        //    inModel.IN_MEDR_STF_NO = ucPACodeAsk_SFAD_Medr1.SelectedTextCode;
                        //    inModel.IN_NSP_RSN_TP_CD = ucPACodeAsk_SFAD_Rsn.SelectedTextCode;
                        //    inModel.IN_WK_CHG_TP_CD = "U";
                        //    inModel.IN_MED_DEPT_CD = ucPACodeAsk_SFAD_Medr1.SelectedTextName3;
                        //    inModel.IN_MEDR_SID = model.SFAD_IN.MEDR_SID;
                        //    inModel.IN_MED_DTM = model.SFAD_IN.SFAD_STR_DTM.Value.Year.ToString() + model.SFAD_IN.SFAD_STR_DTM.Value.Month.ToString().PadLeft(2, '0') + model.SFAD_IN.SFAD_STR_DTM.Value.Day.ToString().PadLeft(2, '0') + model.SFAD_IN.SFAD_STR_DTM.Value.Hour.ToString().PadLeft(2, '0') + model.SFAD_IN.SFAD_STR_DTM.Value.Minute.ToString().PadLeft(2, '0');
                        //    inModel.IN_MED_DTM_TO = model.SFAD_IN.SFAD_END_DTM.Value.Year.ToString() + model.SFAD_IN.SFAD_END_DTM.Value.Month.ToString().PadLeft(2, '0') + model.SFAD_IN.SFAD_END_DTM.Value.Day.ToString().PadLeft(2, '0') + model.SFAD_IN.SFAD_END_DTM.Value.Hour.ToString().PadLeft(2, '0') + model.SFAD_IN.SFAD_END_DTM.Value.Minute.ToString().PadLeft(2, '0');

                        //    result_99 = (Int32)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.DoctorMedScheduleNursingModificationBL", "InsMedicalTreatmentNotSeeingPatientsCodeInputReason_FRTO2", inModel);
                        //}

                        MsgBox.Display("대진일정이 등록되었습니다.  \n\n ※ 세션을 수정 또는 삭제하셔야 합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        btn_Click(btn_SFAD_Search);

                        //var pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect", model.SFAD_IN.MEDR_STF_NO, model.SFAD_IN.SFAD_STR_DTM, model.SFAD_IN.SFAD_END_DTM, model.SFAD_IN.MED_DEPT_CD);

                        //pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                        //pop.ShowInTaskbar = false;
                        //pop.Owner = Application.Current.MainWindow;
                        //pop.ShowDialog();
                        //pop.Close();

                    }
                }
            }

            //예약현황
            if (sender.Equals(btn_Rcep))
            {
                //일정등록
                if (tabMain.SelectedIndex.Equals(0))
                {
                    if (String.IsNullOrEmpty(ucPACodeAsk.SelectedTextName2Hidden))
                    {
                        MsgBox.Display("일정조회할 의사를 선택해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }

                    this.model.SelTimeZoneClassfiedByReservationInObj.PT_NO = String.Empty;
                    this.model.SelTimeZoneClassfiedByReservationInObj.MED_DEPT_CD = ucPACodeAsk.SelectedTextName3;
                    this.model.SelTimeZoneClassfiedByReservationInObj.MED_DOW_KND_CD = "";
                    this.model.SelTimeZoneClassfiedByReservationInObj.MED_DTM = calYear.SelectedDate != null ? calYear.SelectedDate.Value.ToShortDateString().Replace("-", "") : CommonServiceAgent.SelectSysDate().ToShortDateString().Replace("-", "");
                    this.model.SelTimeZoneClassfiedByReservationInObj.MEDDATE = (calYear.SelectedDate != null ? calYear.SelectedDate.Value.ToShortDateString() : CommonServiceAgent.SelectSysDate().ToShortDateString()).Replace("-", "");
                    this.model.SelTimeZoneClassfiedByReservationInObj.MEDR_SID = ucPACodeAsk.SelectedTextName2Hidden;
                    ;
                    this.model.SelTimeZoneClassfiedByReservationInObj.MEDTIME = CommonServiceAgent.SelectSysDateTime().ToShortTimeString();
                }

                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                {
                    if (dgrd_NSP.ActiveRecordIndex < 0)
                    {
                        MsgBox.Display("일정조회할 내역을 선택해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }
                    this.model.SelTimeZoneClassfiedByReservationInObj.PT_NO = String.Empty;
                    this.model.SelTimeZoneClassfiedByReservationInObj.MED_DEPT_CD = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MED_DEPT_CD;
                    this.model.SelTimeZoneClassfiedByReservationInObj.MED_DOW_KND_CD = "";
                    this.model.SelTimeZoneClassfiedByReservationInObj.MED_DTM = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_STR_DT.ToString().Replace("-", "").Substring(0, 8);
                    this.model.SelTimeZoneClassfiedByReservationInObj.MEDDATE = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_STR_DT.ToString().Substring(0, 10).Replace("-", "");
                    this.model.SelTimeZoneClassfiedByReservationInObj.MEDR_SID = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MEDR_SID;
                    this.model.SelTimeZoneClassfiedByReservationInObj.MEDTIME = CommonServiceAgent.SelectSysDateTime().ToShortTimeString().Substring(0, 3);
                }
                //PopUpBase pop = base.OnLoadPopupMenu("AS_PATM_OPRSV_EachMonthMedReservationCrccmAsk", this.model.SelTimeZoneClassfiedByReservationInObj);
                PopUpBase pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.AP.UI_/EachMonthMedReservationCrccmAsk", this.model.SelTimeZoneClassfiedByReservationInObj);

                pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                pop.ShowDialog();
                pop.Owner = Application.Current.MainWindow;
                pop.ShowInTaskbar = false;
            }

            //달력 주단위 선택
            if (sender.Equals(btn_Year_Search))
                Control_SelectionChanged(cbx_Year_Pattern);

            //=============================================
            // 일정등록 탭                          Start
            //=============================================

            if (sender.Equals(btn_Pattern_S))
            {
                if (calYear.SelectedDates.Count().Equals(0))
                {
                    MsgBox.Display("패턴을 등록할 날짜를 선택해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    return;
                }

                Schedule_Pattern("S");
            }

            if (sender.Equals(btn_Pattern_D))
            {
                if (calYear.SelectedDates.Count().Equals(0))
                {
                    MsgBox.Display("패턴을 삭제할 날짜를 선택해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    return;
                }

                Schedule_Pattern("D");
            }

            //=============================================
            // 일정등록 탭                          End
            //=============================================

            //=============================================
            // 휴진등록 탭                          Start
            //=============================================

            // 휴진내역 조회
            if (sender.Equals(btn_NSP_Search))
            {
                if (rdo_NSP_Wrk_Seq.SelectedIndex == 2 && String.IsNullOrEmpty(model.NspInObj.MEDR_STF_NO))
                {
                    MsgBox.Display("조회할 의사를 선택해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    ucPACodeAsk_NSP_Medr1.SelectedTextCodeFocus();
                    return;
                }

                model.NspInObj.PACT_TP_CD = String.Empty;
                model.NspInObj.WK_DTM = dtpck_Nsp_Wrk.SelectedDate.Value.ToShortDateString().Replace("-", "");
                model.NspInObj.BATCH_STAT = chk_NSP_Batch.IsCheckedValue == null ? "N" : chk_NSP_Batch.IsCheckedValue;

                //2023.12.15 BRMH 성현석 병원구분 세션에서 받아오는 걸 넣어주도록 변경
                //if (rdo_NSP_DT.IsSelected == true)
                //{
                //    switch (rbtNspHspTp.SelectedIndex)
                //    {
                //        case 0:
                //            model.NspInObj.IN_HSP_TP_CD = "1";
                //            break;
                //        case 1:
                //            model.NspInObj.IN_HSP_TP_CD = "2";
                //            break;
                //        case 2:
                //            model.NspInObj.IN_HSP_TP_CD = "G";
                //            break;
                //        default:
                //            model.NspInObj.IN_HSP_TP_CD = "";
                //            break;
                //    }
                //}
                //else
                //{
                //    model.NspInObj.IN_HSP_TP_CD = "";
                //}
                model.NspInObj.IN_HSP_TP_CD = "";
                model.NspOutObj = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelectDoctorBusinessTripSchedule", model.NspInObj);


                //당일지정료발생시, Y 체크 넣기
                for (int i = 0; i < model.NspOutObj.Count; i++)
                {
                    //시작일
                    if ((!String.IsNullOrEmpty(model.NspOutObj[i].NSP_STR_DT_CMED_AMT_OCUR_YN)) && model.NspOutObj[i].NSP_STR_DT_CMED_AMT_OCUR_YN.Equals("Y"))
                    {
                        model.NspOutObj[i].APY_DT = "Y " + model.NspOutObj[i].APY_DT;
                    }
                    //종료일
                    if ((!String.IsNullOrEmpty(model.NspOutObj[i].NSP_END_DT_CMED_AMT_OCUR_YN)) && model.NspOutObj[i].NSP_END_DT_CMED_AMT_OCUR_YN.Equals("Y"))
                    {
                        model.NspOutObj[i].APY_DT = model.NspOutObj[i].APY_DT + " Y";
                    }
                }

                if (model.NspOutObj.Count > 0)
                {
                    //스크롤가장밑으로 20160316
                    //dgrd_NSP.BringLastRecordIntoView(true);
                    //dgrd_NSP.SetActiveCell(model.NspOutObj.Count-1, 0, false);
                }


                if (rdo_NSP_Wrk_Seq.SelectedIndex.Equals(0))
                {
                    ucPACodeAsk_NSP_Medr2.SelectedTextCodeFocus();
                }
                else if (rdo_NSP_Wrk_Seq.SelectedIndex.Equals(2))
                {
                    ucPACodeAsk_NSP_Medr2.PassingReference = ucPACodeAsk_NSP_Medr1.SelectedTextName3;
                    ucPACodeAsk_NSP_Medr2.SelectedTextCode = ucPACodeAsk_NSP_Medr1.SelectedTextCode;
                    ucPACodeAsk_NSP_Rsn.SelectedTextCodeFocus();
                }
            }

            //=============================================
            // 휴진등록 탭                           End
            //=============================================

            //=============================================
            // 대진등록 탭                           START
            //=============================================

            if (sender.Equals(btn_SFAD_Search))
            {
                //의사 확인
                if (String.IsNullOrEmpty(model.SFAD_IN.MEDR_SID))
                {
                    MsgBox.Display("의사조회 후 신규등록이 가능합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ucPACodeAsk_SFAD_Medr1.SelectedTextCodeFocus();

                    return;
                }

                model.SFAD_OUT = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_SFAD_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelectSubstitutionForAnotherDoctorScheduleAsk", model.SFAD_IN);

                if (model.SFAD_OUT.Count == 0)
                {
                    MsgBox.Display("조회된 내용이 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    ucPACodeAsk_SFAD_Medr2.SelectedTextCodeFocus();

                }
                else
                {
                    ucPACodeAsk_SFAD_Medr2.PassingReference = ucPACodeAsk_SFAD_Medr1.SelectedTextName3;
                    //ucPACodeAsk_SFAD_Medr2.SelectedTextCode = ucPACodeAsk_SFAD_Medr1.SelectedTextCode;

                    if (model.SFAD_OUT.Count > 0)
                    {
                        //스크롤가장밑으로 20170220
                        dgrd_SFAD.ScrollIntoView(dgrd_SFAD.Items[dgrd_SFAD.Items.Count - 1]);
                        //dgrd_NSP.SetActiveCell(model.NspOutObj.Count-1, 0, false);
                    }
                }
                ControlHelper.SetEnableControl(true, ucPACodeAsk_SFAD_Medr2);



                ControlHelper.SetEnableControl(true, btn_Save);
            }

            //=============================================
            // 대진등록 탭                           End
            //=============================================

            //=============================================
            // 콜전송내역 탭                         START
            //=============================================
            if (sender.Equals(btn_CALL_Search))
            {
                //콜전송여부
                if (rbl_CALL.SelectedIndex.Equals(0))
                    model.CALL_IN.CALL_YN = String.Empty;
                if (rbl_CALL.SelectedIndex.Equals(1))
                    model.CALL_IN.CALL_YN = "Y";
                if (rbl_CALL.SelectedIndex.Equals(2))
                    model.CALL_IN.CALL_YN = "N";

                model.CALL_OUT = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CALL_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelectOtptNotSeeingPtsRegistrationCallCenterSendParticularsAsk", model.CALL_IN);

                if (model.CALL_OUT.Count().Equals(0))
                    MsgBox.Display("조회된 내역이 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
            }
            //=============================================
            // 콜전송내역 탭                         End
            //=============================================


            //=============================================
            // 비정규예약 탭                         START
            //=============================================

            if (sender.Equals(btnCrrSearch))
            {
                model.InCostRegularReservation.IN_DR_SID = pacaCrrMeddr.SelectedTextName2Hidden; //SID 정확해지면 다시 테스트해야함.
                //model.InCostRegularReservation.IN_DR_SID = "1025860";


                model.InCostRegularReservation.IN_MED_DEPT_CD = pacaCrrMeddr.SelectedTextName3;
                //model.InCostRegularReservation.IN_MED_DEPT_CD = "OL";

                model.SelCostRegularReservation = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationCostRegularReservation_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelectMedDoctorScheduleRegistrationCostRegularReservation", model.InCostRegularReservation);

                if (model.SelCostRegularReservation.Count > 0)
                {
                    temp = model.SelCostRegularReservation[0];

                    txtNedAm1.Text = model.SelCostRegularReservation[0].AM_1.ToString();
                    txtNedAm1.IsEnabled = true;
                    txtNedAm2.Text = model.SelCostRegularReservation[0].AM_2.ToString();
                    txtNedAm2.IsEnabled = true;

                    // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 퇴원환자에 대한 추가 로직 삭제
                    //txtNedAm3.Text = model.SelCostRegularReservation[0].AM_3.ToString();
                    //txtNedAm3.IsEnabled = true;

                    txtNedAm4.Text = model.SelCostRegularReservation[0].AM_4.ToString();
                    txtNedAm4.IsEnabled = true;
                    txtNedAm52.Text = model.SelCostRegularReservation[0].AM_5_MON.ToString();
                    txtNedAm52.IsEnabled = true;
                    txtNedAm53.Text = model.SelCostRegularReservation[0].AM_5_TUE.ToString();
                    txtNedAm53.IsEnabled = true;
                    txtNedAm54.Text = model.SelCostRegularReservation[0].AM_5_WED.ToString();
                    txtNedAm54.IsEnabled = true;
                    txtNedAm55.Text = model.SelCostRegularReservation[0].AM_5_THR.ToString();
                    txtNedAm55.IsEnabled = true;
                    txtNedAm56.Text = model.SelCostRegularReservation[0].AM_5_FRI.ToString();
                    txtNedAm56.IsEnabled = true;
                    txtNedAm57.Text = model.SelCostRegularReservation[0].AM_5_SAT.ToString();
                    txtNedAm57.IsEnabled = true;

                    txtNedPm1.Text = model.SelCostRegularReservation[0].PM_1.ToString();
                    txtNedPm1.IsEnabled = true;
                    txtNedPm2.Text = model.SelCostRegularReservation[0].PM_2.ToString();
                    txtNedPm2.IsEnabled = true;

                    // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 퇴원환자에 대한 추가 로직 삭제
                    //txtNedPm3.Text = model.SelCostRegularReservation[0].PM_3.ToString();
                    //txtNedPm3.IsEnabled = true;

                    txtNedPm4.Text = model.SelCostRegularReservation[0].PM_4.ToString();
                    txtNedPm4.IsEnabled = true;
                    txtNedPm52.Text = model.SelCostRegularReservation[0].PM_5_MON.ToString();
                    txtNedPm52.IsEnabled = true;
                    txtNedPm53.Text = model.SelCostRegularReservation[0].PM_5_TUE.ToString();
                    txtNedPm53.IsEnabled = true;
                    txtNedPm54.Text = model.SelCostRegularReservation[0].PM_5_WED.ToString();
                    txtNedPm54.IsEnabled = true;
                    txtNedPm55.Text = model.SelCostRegularReservation[0].PM_5_THR.ToString();
                    txtNedPm55.IsEnabled = true;
                    txtNedPm56.Text = model.SelCostRegularReservation[0].PM_5_FRI.ToString();
                    txtNedPm56.IsEnabled = true;
                    txtNedPm57.Text = model.SelCostRegularReservation[0].PM_5_SAT.ToString();
                    txtNedPm57.IsEnabled = true;

                    txtNedAm62.Text = model.SelCostRegularReservation[0].AM_6_MON.ToString();
                    txtNedAm62.IsEnabled = true;
                    txtNedAm63.Text = model.SelCostRegularReservation[0].AM_6_TUE.ToString();
                    txtNedAm63.IsEnabled = true;
                    txtNedAm64.Text = model.SelCostRegularReservation[0].AM_6_WED.ToString();
                    txtNedAm64.IsEnabled = true;
                    txtNedAm65.Text = model.SelCostRegularReservation[0].AM_6_THR.ToString();
                    txtNedAm65.IsEnabled = true;
                    txtNedAm66.Text = model.SelCostRegularReservation[0].AM_6_FRI.ToString();
                    txtNedAm66.IsEnabled = true;
                    txtNedAm67.Text = model.SelCostRegularReservation[0].AM_6_SAT.ToString();
                    txtNedAm67.IsEnabled = true;

                    txtNedPm62.Text = model.SelCostRegularReservation[0].PM_6_MON.ToString();
                    txtNedPm62.IsEnabled = true;
                    txtNedPm63.Text = model.SelCostRegularReservation[0].PM_6_TUE.ToString();
                    txtNedPm63.IsEnabled = true;
                    txtNedPm64.Text = model.SelCostRegularReservation[0].PM_6_WED.ToString();
                    txtNedPm64.IsEnabled = true;
                    txtNedPm65.Text = model.SelCostRegularReservation[0].PM_6_THR.ToString();
                    txtNedPm65.IsEnabled = true;
                    txtNedPm66.Text = model.SelCostRegularReservation[0].PM_6_FRI.ToString();
                    txtNedPm66.IsEnabled = true;
                    txtNedPm67.Text = model.SelCostRegularReservation[0].PM_6_SAT.ToString();
                    txtNedPm67.IsEnabled = true;

                    if (model.SelCostRegularReservation[0].RSV_ATNT_CNTE != null)
                    {
                        txtReqMemo.Text = model.SelCostRegularReservation[0].RSV_ATNT_CNTE.ToString();

                    }
                    else
                    {
                        txtReqMemo.Text = "";
                    }
                    //txtReqMemo.IsEnabled = true;

                    btn_Update.IsEnabled = true;

                }

            }

            //=============================================
            // 비정규예약 탭                         End
            //=============================================



        }

        /// <summary>
        /// name         : CRUD_NSP
        /// desc         : 휴진등록 저장, 수정, 삭제
        /// author       : kimchihwan 
        /// create date  : 2012-10-12
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void CRUD_NSP(object sender)
        {
            IEnumerable<MedDoctorScheduleRegistration_Tree_OUT> Linq_Temp = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Tree_OUT>();
            MedDoctorScheduleRegistration_NSP_OUT NSP_InObj = new MedDoctorScheduleRegistration_NSP_OUT();

            if (this.chk_NSP_Batch.IsChecked == true)
            {
                int m_cnt = model.MedDoctorScheduleCriteriaRegistrationTree3OutObj.Count();
                int[] a_cnt = new int[m_cnt];
                String chk_stf_no = String.Empty;

                for (int i = 0; i < m_cnt; i++)
                    a_cnt[i] = model.MedDoctorScheduleCriteriaRegistrationTree3OutObj[i].relations.Count();

                for (int i = 0; i < m_cnt; i++)
                {
                    for (int j = 0; j < a_cnt[i]; j++)
                    {
                        if (model.NspInObj.MEDR_STF_NO == model.MedDoctorScheduleCriteriaRegistrationTree3OutObj[i].relations[j].MAIN_STF_NO.Substring(0, 5))
                        {
                            chk_stf_no = model.MedDoctorScheduleCriteriaRegistrationTree3OutObj[i].relations[j].ASST_STF_NO;
                            Linq_Temp = model.MedDoctorScheduleCriteriaRegistrationTree3OutObj[i].relations.Where(w => w.ASST_STF_NO.Equals(chk_stf_no));
                        }
                    }
                }
            }

            HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Tree_OUT> BATCH_Temp = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Tree_OUT>(Linq_Temp);

            //int cnt = this.chk_NSP_Batch.IsChecked == true ? BATCH_Temp.Count() : 1;
            String sMode = String.Empty;
            HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

            //for (int i = 0; i < cnt; i++)
            //{
            if (sender.Equals(btn_Save) || sender.Equals(btn_Update))
            {



                ////일괄휴진여부
                //if (this.chk_NSP_Batch.IsCheckedValue.Equals("Y"))
                //{
                //    //의사코드 체크
                //    if (String.IsNullOrEmpty(BATCH_Temp[i].MAIN_STF_NO))
                //    {
                //        MsgBox.Display("일괄휴진 의사를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //        return;
                //    }
                //}
                //else
                //{
                //의사코드 체크
                if (String.IsNullOrEmpty(model.NspInOutObj.MEDR_SID))
                {
                    MsgBox.Display("진료의사를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ucPACodeAsk_NSP_Medr2.SelectedTextCodeFocus();
                    return;
                }
                //}

                if (sender.Equals(btn_Update))
                {
                    model.NspInOutObj.SMODE = "U";
                    sMode = "수정";
                }
                else
                {
                    model.NspInOutObj.SMODE = "I";
                    sMode = "저장";
                }

                //FromToCalendar 바인딩 버그 직접 데이터 가지고 옴.
                String str_tmp = StringHelper.HDateEditorForToText("1", ftcal_NSP_Prd);
                String end_tmp = StringHelper.HDateEditorForToText("2", ftcal_NSP_Prd);
                if (str_tmp == "" || end_tmp == "")
                {
                    MsgBox.Display("PAMVB_000168", MessageType.MSG_TYPE_INFORMATION, VariableMessages: new string[] { "입력 데이터를 확인하세요" }); // [{0}]
                    return;
                }

                model.NspInOutObj.APY_STR_DT = new DateTime(int.Parse(str_tmp.Substring(0, 4)), int.Parse(str_tmp.Substring(5, 2)), int.Parse(str_tmp.Substring(8, 2)));
                model.NspInOutObj.APY_END_DT = new DateTime(int.Parse(end_tmp.Substring(0, 4)), int.Parse(end_tmp.Substring(5, 2)), int.Parse(end_tmp.Substring(8, 2)));


                ////휴진신청일자 체크  //2016-06-03 휴진스케줄등록 시 휴진신청일자를 과거로 설정할 수 있도록 수정
                //if (dtp_nsp_apy.SelectedDate < DateTime.Now.AddDays(-1))
                //{
                //    MsgBox.Display("PAMVB_000168", MessageType.MSG_TYPE_INFORMATION, VariableMessages: new string[] { "휴진신청일자는 현재보다 과거일 수 없습니다." }); // [{0}]
                //    return;
                //}


                //휴진기간 체크
                //2013.07.22 / 기간을1 -30일로 변경요청(윤성민) / 김치환
                if (String.IsNullOrEmpty(model.NspInOutObj.APY_STR_DT.ToString()) || String.IsNullOrEmpty(model.NspInOutObj.APY_END_DT.ToString()))
                {
                    MsgBox.Display("휴진기간을 입력하세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ftcal_NSP_Prd.IsFocusFromDate = true;
                    return;
                }
                //else if (this.ftcal_NSP_Prd.FromDate < DateTime.Now.AddDays(-180))
                //{
                //    MsgBox.Display("OCS:<안내> 지정범위를 확인하십시오!", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //    this.ftcal_NSP_Prd.IsFocusFromDate = true;
                //    return;
                //}
                //else if (((DateTime)this.ftcal_NSP_Prd.FromDate).AddDays(1) < DateTime.Now) //현재시간보다 과거면 등록불가
                //{
                //    MsgBox.Display("<안내> 지정범위를 확인하십시오!", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //    this.ftcal_NSP_Prd.IsFocusFromDate = true;
                //    return;
                //}

                if (String.IsNullOrEmpty(this.ftcal_NSP_Prd.ToDate.ToString()))
                {
                    MsgBox.Display("조회기간을 입력하세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ftcal_NSP_Prd.IsFocusToDate = true;
                    return;
                }
                else if (this.ftcal_NSP_Prd.ToDate < DateTime.Now.AddDays(-180))
                {
                    MsgBox.Display("<안내> 지정범위를 확인하십시오!", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ftcal_NSP_Prd.IsFocusFromDate = true;
                    return;
                }


                //휴진사유 체크
                if (String.IsNullOrEmpty(model.NspInOutObj.NSP_RSN_TP_CD))
                {
                    MsgBox.Display("휴진사유를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ucPACodeAsk_NSP_Medr2.SelectedTextCodeFocus();
                    return;
                }
                //if (model.NspInOutObj.NSP_RSN_TP_CD.Equals("10") || model.NspInOutObj.NSP_RSN_TP_CD.Equals("11") || model.NspInOutObj.NSP_RSN_TP_CD.Equals("12"))
                //{
                //    MsgBox.Display("휴진등록시는 사용할 수 없는 코드입니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //    this.ucPACodeAsk_NSP_Medr2.SelectedTextCodeFocus();
                //    return;
                //}

                else if (model.NspInOutObj.NSP_RSN_TP_CD.Equals("07") /*|| model.NspInOutObj.NSP_RSN_TP_CD.Equals("10") || model.NspInOutObj.NSP_RSN_TP_CD.Equals("90")*/)
                {
                    MsgBox.Display("휴진등록시는 사용할 수 없는 코드입니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ucPACodeAsk_NSP_Rsn.SelectedTextCodeFocus();
                    return;
                }


                if (ftcal_NSP_Prd.FromDate == ftcal_NSP_Prd.ToDate)
                {
                    if ((chxStrAmt.IsSelected == true && chxEndAmt.IsSelected == false) || (chxStrAmt.IsSelected == false && chxEndAmt.IsSelected == true))
                    {
                        MsgBox.Display("PAMVB_000168", MessageType.MSG_TYPE_INFORMATION, VariableMessages: new string[] { "휴진시작일과 휴진종료일이 같은 날인 경우에는 당일지정료 발생여부가 시작일과 종료일이 같아야 합니다." }); // [{0}]
                        return;
                    }
                }

                //휴진사유 체크
                if (!String.IsNullOrEmpty(this.ucPACodeAsk_NSP_Rsn.SelectedTextCode) && String.IsNullOrEmpty(this.ucPACodeAsk_NSP_Rsn.SelectedTextName1))
                {
                    MsgBox.Display("휴진사유를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ucPACodeAsk_NSP_Rsn.SelectedTextCodeFocus();
                    return;
                }



            }
            else if (sender.Equals(btn_Delete))
            {
                //휴진기간 체크
                //2013.07.22 / 기간을1 -30일로 변경요청(윤성민) / 김치환
                if (String.IsNullOrEmpty(model.NspInOutObj.APY_STR_DT.ToString()) || String.IsNullOrEmpty(model.NspInOutObj.APY_END_DT.ToString()))
                {
                    MsgBox.Display("삭제할 휴진기간을 입력하세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    this.ftcal_NSP_Prd.IsFocusFromDate = true;
                    return;
                }
                //else if (this.ftcal_NSP_Prd.FromDate < DateTime.Now.AddDays(-180))
                //{
                //    MsgBox.Display("OCS:<안내> 지정범위를 확인하십시오!", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //    this.ftcal_NSP_Prd.IsFocusFromDate = true;
                //    return;
                //}
                //else if (this.ftcal_NSP_Prd.FromDate < DateTime.Now.AddDays(-1)) //현재시간보다 과거면 등록불가
                //{
                //    MsgBox.Display("<안내> 현재보다 과거인 날짜의 휴진일정은 삭제할 수 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //    this.ftcal_NSP_Prd.IsFocusFromDate = true;
                //    return;
                //}

                model.NspInOutObj.SMODE = "D";
                sMode = "삭제";
            }

            if (rdo_NSP_OI.SelectedIndex.Equals(0))
                model.NspInOutObj.PACT_TP_CD = "O";
            else if (rdo_NSP_OI.SelectedIndex.Equals(1))
                model.NspInOutObj.PACT_TP_CD = "I";
            else if (rdo_NSP_OI.SelectedIndex.Equals(2))
                model.NspInOutObj.PACT_TP_CD = "OI";
            else
            {
                MsgBox.Display("등록할 진료유형을 선택하세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                return;
            }

            //if (this.chk_NSP_Batch.IsChecked == false && i == 0)
            //{
            //    if (MsgBox.Display(sMode + "하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES).Equals(MessageBoxResult.No))
            //        return;
            //}

            //if (this.chk_NSP_Batch.IsCheckedValue.Equals("Y"))
            //{
            //    NSP_InObj.MED_DEPT_CD = BATCH_Temp[i].MEDR_DP;
            //    NSP_InObj.MEDR_STF_NO = BATCH_Temp[i].MAIN_STF_NO.Substring(0, 5);
            //    NSP_InObj.MEDR_SID = BATCH_Temp[i].MAIN_STF_NO.Substring(6, 7);
            //}
            //else
            //{
            NSP_InObj.MED_DEPT_CD = this.ucPACodeAsk_NSP_Medr1.SelectedTextName3;//model.NspInOutObj.MED_DEPT_CD; 
            NSP_InObj.MEDR_STF_NO = model.NspInOutObj.MEDR_STF_NO;
            NSP_InObj.MEDR_SID = model.NspInOutObj.MEDR_SID;
            //}
            NSP_InObj.MEDR_STF_NM = model.NspInOutObj.MEDR_STF_NM;
            NSP_InObj.APY_STR_DT = model.NspInOutObj.APY_STR_DT;
            NSP_InObj.APY_END_DT = model.NspInOutObj.APY_END_DT;
            NSP_InObj.OLD_APY_STR_DT = model.NspInOutObj.OLD_APY_STR_DT;
            NSP_InObj.OLD_APY_END_DT = model.NspInOutObj.OLD_APY_END_DT;
            NSP_InObj.APY_DT = model.NspInOutObj.APY_DT;
            NSP_InObj.NSP_RSN_TP_CD = model.NspInOutObj.NSP_RSN_TP_CD;
            NSP_InObj.NSP_RSN_TP_NM = model.NspInOutObj.NSP_RSN_TP_NM;
            NSP_InObj.LSH_STF_NO = model.NspInOutObj.LSH_STF_NO;
            NSP_InObj.LSH_DTM = model.NspInOutObj.LSH_DTM;
            NSP_InObj.NSP_MEMO = model.NspInOutObj.NSP_MEMO;
            NSP_InObj.MCSD_DTM = model.NspInOutObj.MCSD_DTM;
            NSP_InObj.MCSD_RSLT_CD = model.NspInOutObj.MCSD_RSLT_CD;
            NSP_InObj.CRDOC_YN = model.NspInOutObj.CRDOC_YN;
            NSP_InObj.SMODE = model.NspInOutObj.SMODE;
            NSP_InObj.NSP_APLC_DT = model.NspInOutObj.NSP_APLC_DT;
            NSP_InObj.OLD_TM_UNIT_CD = model.NspInOutObj.TM_UNIT_CD;

            //당일지정료발생여부
            if (chxStrAmt.IsSelected == true)
            {
                NSP_InObj.NSP_STR_DT_CMED_AMT_OCUR_YN = "Y";
            }
            else
            {
                NSP_InObj.NSP_STR_DT_CMED_AMT_OCUR_YN = "N";
            }
            if (chxEndAmt.IsSelected == true)
            {
                NSP_InObj.NSP_END_DT_CMED_AMT_OCUR_YN = "Y";
            }
            else
            {
                NSP_InObj.NSP_END_DT_CMED_AMT_OCUR_YN = "N";
            }
            //보충여부
            if (chxSplm.IsChecked == true)
            {
                NSP_InObj.SPLM_YN = "Y";
            }
            else
            {
                NSP_InObj.SPLM_YN = "N";
            }

            // 2024.07.15 김재강 : 오전오후 구분추가
            if (cbx_AM.IsSelected == true) NSP_InObj.TM_UNIT_CD = "AM";
            if (cbx_PM.IsSelected == true) NSP_InObj.TM_UNIT_CD = "PM";
            if ((cbx_AM.IsSelected == true && cbx_PM.IsSelected == true) || (cbx_AM.IsSelected == false && cbx_PM.IsSelected == false)) NSP_InObj.TM_UNIT_CD = "A";

            // 20240503 김재강 : 보라매병원 김현주 팀장 요청으로 항상 외래/입원 동시에 삭제되도록 변경 + PC_ACP_ACDPCBAD_CHECK 592줄 주석
            model.NspInOutObj.PACT_TP_CD = "OI";
            // 외래/입원 선택 시 두번 처리되도록
            for (int x = 0; x < model.NspInOutObj.PACT_TP_CD.Length; x++)
            {
                NSP_InObj.PACT_TP_CD = model.NspInOutObj.PACT_TP_CD.Substring(model.NspInOutObj.PACT_TP_CD.Length - 1 - x, 1);
                //io_result = 
                UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "CheckNotSeeingPatientsScheduleManagement", NSP_InObj);
            }
            //}


            //if (sender.Equals(btn_Save))
            //{
            //    if (this.ftcal_NSP_Prd.FromDate <= DateTime.Now.AddDays(30))
            //        MsgBox.Display("30일 이전 등록입니다", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
            //}

            MsgBox.Display("휴진일정이 " + sMode + "되었습니다. \n\n ※ 세션을 수정 또는 삭제하셔야 합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);

            //var pop = base.OnLoadPopupMenu("AC_HIS.PA.AC.PE.SC.UI_/SessionInspect", NSP_InObj.MEDR_STF_NO, NSP_InObj.APY_STR_DT, NSP_InObj.APY_END_DT, NSP_InObj.MED_DEPT_CD);

            //pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            //pop.ShowInTaskbar = false;
            //pop.Owner = Application.Current.MainWindow;
            //pop.ShowDialog();

            this.btn_Click(btn_NSP_Search);
            //pop.Close();


        }

        /// <summary>
        /// name         : tab_Change
        /// desc         : Tab변경 시 화면 구성 변경
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void tab_Change(int p)
        {
            //년단위 칼렌더 접기
            exp_calYear.IsExpanded = false;
            exp_calYear.IsEnabled = false;

            //일정등록
            if (p.Equals(0))
            {
                exp_calYear.IsExpanded = true;
                exp_calYear.IsEnabled = true;

                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Add, btn_Update, btn_Delete, tvMedTree2, tvMedTree3, btn_Excel, btn_CrDoc);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Save, tvMedTree, btn_Rcep, tvMedTree);
                //((HTextBox)ucPACodeAsk.FindName("txtCode")).Focus();
            }

            //휴진등록
            if (p.Equals(1))
            {

                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Update, tvMedTree);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Add, btn_Delete, btn_Save, btn_Excel, btn_CrDoc, btn_Rcep, tvMedTree2, tvMedTree3, btnSessionchk);
                ControlHelper.SetEnableControl(true, btn_Save, btn_Add);

                if (chk_NSP_Batch.IsChecked == true)
                {
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, tvMedTree, tvMedTree2);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, tvMedTree3);
                }
                else
                {
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, tvMedTree2);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, tvMedTree, tvMedTree3);
                }
                //((HTextBox)ucPACodeAsk_NSP_Medr1.FindName("txtCode")).Focus();
            }

            //대진등록
            if (p.Equals(2))
            {
                ControlHelper.SetEnableControl(false, btn_Add, btn_Delete, btn_Update, btn_Save);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Add, btn_Delete, btn_Update, btn_Save, tvMedTree2, btnSessionchk);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_CrDoc, btn_Rcep, btn_Excel, tvMedTree, tvMedTree3);
                //((HTextBox)ucPACodeAsk_SFAD_Medr1.FindName("txtCode")).Focus();
            }

            ////콜전송내역
            //if (p.Equals(3))
            //{
            //    ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Add, btn_Delete, btn_Save, btn_Rcep, btn_Update, btn_Excel, btn_CrDoc, tvMedTree, tvMedTree3);
            //    ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, tvMedTree2, btnSessionchk);
            //}
            //비정규예약
            if (p.Equals(4))
            {
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Add, btn_Delete, btn_Save, btn_Rcep, btn_Excel, btn_CrDoc, tvMedTree, tvMedTree3, btnSessionchk);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Update, tvMedTree2);

                btn_Update.IsEnabled = false;
                //((HTextBox)pacaCrrMeddr.FindName("txtCode")).Focus();
            }
        }

        /// <summary>
        /// name         : Control_NodeDoubleClick
        /// desc         : 각 Treeview 선택 처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_NodeDoubleClick(object sender, NodeInfo e)
        {
            //일정등록
            if (sender.Equals(tvMedTree))
            {
                tvMedTree.SelectedText = model.MedDoctorScheduleCriteriaRegistrationTreeOutObj[1].MED_DEPT_NM;

                if ((e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).DEPTH.Equals("2"))
                {
                    ucPACodeAsk.PassingReference = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MED_DEPT_CD;
                    //ucPACodeAsk.TxtCodeControl().Text = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Substring(0, 7);
                    String Temp = ((MedDoctorScheduleCriteriaRegistrationTree_OUT)e.Item).MEDR_SID.Substring(0, 7).Trim();
                    ucPACodeAsk.SelectedTextCode = Temp;

                    //this.Control_OnSelectChange(ucPACodeAsk);
                }
            }

            //휴진등록, 대진등록, 비정규예약
            if (sender.Equals(tvMedTree2))
            {
                if ((e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).DEPTH.Equals("3"))
                {
                    if (tabMain.SelectedIndex.Equals(1))
                    {
                        DataInit(1);

                        ucPACodeAsk_NSP_Medr1.PassingReference = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[1];
                        ucPACodeAsk_NSP_Medr2.PassingReference = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[1];
                        ucPACodeAsk_NSP_Medr1.SelectedTextCode = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[0];
                        ucPACodeAsk_NSP_Medr2.SelectedTextCode = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[0];
                        ucPACodeAsk_NSP_Medr1.CodeDataSearch();
                        ucPACodeAsk_NSP_Medr2.CodeDataSearch();

                        chk_Visible(((HTreeView)sender).Name.ToString());

                        this.btn_Click(btn_NSP_Search);
                    }
                    if (tabMain.SelectedIndex.Equals(2))
                    {
                        ucPACodeAsk_SFAD_Medr1.PassingReference = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[1];
                        ucPACodeAsk_SFAD_Medr1.SelectedTextCode = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[0];
                        ucPACodeAsk_SFAD_Medr1.CodeDataSearch();
                    }
                    if (tabMain.SelectedIndex.Equals(3))
                    {
                        ucPACodeAsk_CALL_Medr.PassingReference = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[1];
                        ucPACodeAsk_CALL_Medr.SelectedTextCode = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[0];
                        ucPACodeAsk_CALL_Medr.CodeDataSearch();

                        this.btn_Click(btn_CALL_Search);
                    }
                    if (tabMain.SelectedIndex.Equals(4))
                    {
                        pacaCrrMeddr.PassingReference = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[1];
                        pacaCrrMeddr.SelectedTextCode = (e.Item as MedDoctorScheduleCriteriaRegistrationTree_OUT).MEDR_SID.Split('ㅹ')[0];
                        pacaCrrMeddr.CodeDataSearch();

                        this.btn_Click(btnCrrSearch);
                    }
                }
            }

            //일괄휴진등록
            if (sender.Equals(tvMedTree3))
            {
                if ((e.Item as MedDoctorScheduleRegistration_Tree_OUT).DEPTH.Equals("2"))
                {
                    ucPACodeAsk_NSP_Medr1.PassingReference = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MEDR_DP;
                    ucPACodeAsk_NSP_Medr2.PassingReference = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MEDR_DP;
                    ucPACodeAsk_NSP_Medr1.SelectedTextCode = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MAIN_STF_NO.Substring(0, 5);
                    ucPACodeAsk_NSP_Medr2.SelectedTextCode = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MAIN_STF_NO.Substring(0, 5);
                }
                else
                {
                    ucPACodeAsk_NSP_Medr1.PassingReference = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MEDR_DP;
                    ucPACodeAsk_NSP_Medr2.PassingReference = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MEDR_DP;
                    ucPACodeAsk_NSP_Medr1.SelectedTextCode = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MAIN_STF_NO;
                    ucPACodeAsk_NSP_Medr2.SelectedTextCode = (e.Item as MedDoctorScheduleRegistration_Tree_OUT).MAIN_STF_NO;
                }

                ucPACodeAsk_NSP_Medr1.CodeDataSearch();
                ucPACodeAsk_NSP_Medr2.CodeDataSearch();

                chk_Visible("tvMedTree2");

                this.btn_Click(btn_NSP_Search);
            }


        }

        /// <summary>
        /// name         : Control_SelectionChanged
        /// desc         : 각 SelectionChanged 이벤트 처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_SelectionChanged(object sender)
        {
            if (!ControlHelper.FindChild<XamCalendar>((HCalendarYear)calYear, "PART_SecondCal").CurrentMode.Equals(CalendarZoomMode.Days))
                ControlHelper.FindChild<XamCalendar>((HCalendarYear)calYear, "PART_SecondCal").CurrentMode = CalendarZoomMode.Days;

            //기간변 주단위 선택
            if (sender.Equals(cbx_Year_Pattern))
            {
                DateTime str_dtm = ftcal_Year.FromDate.Value;
                DateTime end_dtm = ftcal_Year.ToDate.Value;
                DateTime str_dtmTemp = ftcal_Year.FromDate.Value;
                DateTime end_dtmTemp = ftcal_Year.ToDate.Value;

                //20240315 김재강 주차 계산에 필요한 변수 선언
                //DateTime firstDayOfMonth;
                //int WeekNum;
                //int FirSun;

                if (!calYear.SelectedDates.Count().Equals(0) && !((HComboBox)sender).SelectedIndex.Equals(0))
                {
                    str_dtm = calYear.SelectedDates.First();
                    end_dtm = calYear.SelectedDates.Last();

                    for (DateTime d = str_dtm; d <= end_dtm; d = d.AddDays(1))
                    {
                        if (!calYear.SelectedDates.Count().Equals(0))
                            calYear.SelectedDates.RemoveAt(0);
                    }
                }
                str_dtm = str_dtmTemp;
                end_dtm = end_dtmTemp;
                //격주
                if (((HComboBox)sender).SelectedIndex.Equals(1))
                {
                    // 20240314 김재강 주차 선택할 수 있도록 코드 추가 : 격주 선택하면 1~6주차 까지 전체 선택되고, 주차 선택 비활성화 처리
                    chk1.IsChecked = true;
                    chk2.IsChecked = true;
                    chk3.IsChecked = true;
                    chk4.IsChecked = true;
                    chk5.IsChecked = true;
                    chk6.IsChecked = true;
                    chk1.IsEnabled = false;
                    chk2.IsEnabled = false;
                    chk3.IsEnabled = false;
                    chk4.IsEnabled = false;
                    chk5.IsEnabled = false;
                    chk6.IsEnabled = false;

                    int temp_day = 0;
                    bool year_chk = false;
                    //해당년 1월 1일의 요일
                    DayOfWeek day = new DateTime(ftcal_Year.FromDate.Value.Year, 01, 01).DayOfWeek;

                    if (day.Equals(DayOfWeek.Monday))
                        temp_day = 0;
                    if (day.Equals(DayOfWeek.Tuesday))
                        temp_day = 1;
                    if (day.Equals(DayOfWeek.Wednesday))
                        temp_day = 2;
                    if (day.Equals(DayOfWeek.Thursday))
                        temp_day = 3;
                    if (day.Equals(DayOfWeek.Friday))
                        temp_day = 4;
                    if (day.Equals(DayOfWeek.Saturday))
                        temp_day = 5;
                    if (day.Equals(DayOfWeek.Sunday))
                        temp_day = 6;

                    CultureInfo cultureInfo = CultureInfo.CurrentCulture;
                    CalendarWeekRule weekRule = cultureInfo.DateTimeFormat.CalendarWeekRule;
                    DayOfWeek firstDayOfWeek = cultureInfo.DateTimeFormat.FirstDayOfWeek;

                    //2024.04.29 성현석, 격주 기준이 년의 주차를 % 2로 하여 계산하기 때문에, 예시로 1주차 ~ 5주차까지의 일정을 생성하려고 하면, 2, 4주차 일정이 생성됨
                    //그래서 end_week_add_inf으로 주차가 1주차부터 시작이면 주차 +1을 해줌으로, if ((end_week + 1)%2 == 0) 이 기준을 맞춤. 
                    //결론은 1,3,5 주차의 격주 생성이 가능하도록 하는 목적임.
                    int end_week_add_inf = cultureInfo.Calendar.GetWeekOfYear(str_dtm, weekRule, firstDayOfWeek) % 2 == 0 ? 1 : 0;
                    for (DateTime d = str_dtm; d <= end_dtm; d = d.AddDays(1))
                    {

                        //2024.04.29 성현석 왠지모르지만, 특정 월에 데이터를 보면
                        //1주차가 비어있는데(왜 비어있는지는 모르겠고) 해당 비어있는 기간도 주차로 인정해버리는 걸로 보여짐.
                        //ex) 9월 1일이 2주차로 캘린더에 보여지고, 실제론 1주차이지만, 2주차로 인식하여 일정을 깔아버림.

                        DateTime fstDayOfMonth = d;

                        //int fst_week = cultureInfo.Calendar.GetWeekOfYear(new DateTime(d.Year, d.Month, 1), weekRule, firstDayOfWeek);
                        int end_week = cultureInfo.Calendar.GetWeekOfYear(d, weekRule, firstDayOfWeek) + end_week_add_inf;
                        if ((end_week + 1) % 2 == 0)
                            calYear.SelectedDates.Add(new DateTime(d.Year, d.Month, d.Day));

                        //if (!str_dtm.Year.Equals(d.Year) && year_chk.Equals(false))
                        //{
                        //    temp_day += new DateTime(str_dtm.Year, 12, 31).DayOfYear;
                        //    year_chk = true;
                        //}
                        //if ((Math.Floor((decimal)(d.DayOfYear + temp_day) / 7) % 2).Equals((Math.Floor((decimal)(ftcal_Year.FromDate.Value.DayOfYear + temp_day) / 7) % 2)))
                        //    calYear.SelectedDates.Add(new DateTime(d.Year, d.Month, d.Day));
                    }
                }
                //모든주
                else if (((HComboBox)sender).SelectedIndex.Equals(2))
                {
                    // 20240314 김재강 주차 선택할 수 있도록 코드 추가 : 모든 주 선택하면 1~6주차까지 선택되도록
                    chk1.IsEnabled = true;
                    chk2.IsEnabled = true;
                    chk3.IsEnabled = true;
                    chk4.IsEnabled = true;
                    chk5.IsEnabled = true;
                    chk6.IsEnabled = true;

                    selected_week_list.Clear();
                    if (chk1.IsChecked == true) selected_week_list.Add(1);
                    if (chk2.IsChecked == true) selected_week_list.Add(2);
                    if (chk3.IsChecked == true) selected_week_list.Add(3);
                    if (chk4.IsChecked == true) selected_week_list.Add(4);
                    if (chk5.IsChecked == true) selected_week_list.Add(5);
                    if (chk6.IsChecked == true) selected_week_list.Add(6);

                    for (DateTime d = str_dtm; d <= end_dtm; d = d.AddDays(1))
                    {

                        // 몇주차인지 계산 => WeekNum에 저장
                        //firstDayOfMonth = new DateTime(d.Year, d.Month, 1);      // d가 속한 달의 1일 계산
                        //FirSun = (7 - (int)firstDayOfMonth.DayOfWeek) % 7 + 1;  // 해당 달의 첫번째 일요일
                        //if (d.Day % 7 >= FirSun) WeekNum = d.Day / 7 + 2;
                        //else WeekNum = d.Day / 7 + 1;

                        //2024.04.29 성현석 왠지모르지만, 특정 월에 데이터를 보면
                        //1주차가 비어있는데(왜 비어있는지는 모르겠고) 해당 비어있는 기간도 주차로 인정해버리는 걸로 보여짐.
                        //ex) 9월 1일이 2주차로 캘린더에 보여지고, 실제론 1주차이지만, 2주차로 인식하여 일정을 깔아버림.
                        CultureInfo cultureInfo = CultureInfo.CurrentCulture;
                        DateTime fstDayOfMonth = d;
                        CalendarWeekRule weekRule = cultureInfo.DateTimeFormat.CalendarWeekRule;
                        DayOfWeek firstDayOfWeek = cultureInfo.DateTimeFormat.FirstDayOfWeek;
                        int fst_week = cultureInfo.Calendar.GetWeekOfYear(new DateTime(d.Year, d.Month, 1), weekRule, firstDayOfWeek);
                        int end_week = cultureInfo.Calendar.GetWeekOfYear(d, weekRule, firstDayOfWeek);
                        // 체크한 주차에 포함되어 있으면 달력에 값 추가
                        if (selected_week_list.Contains((end_week - fst_week) + 1))
                            calYear.SelectedDates.Add(new DateTime(d.Year, d.Month, d.Day));

                    }
                }
                // 20240315 김재강 기존에 선택했던 날짜가 유지되도록 변경
                //ftcal_Year.FromDate = calYear.SelectedDates.First();
                //ftcal_Year.ToDate = calYear.SelectedDates.Last();
                ftcal_Year.FromDate = str_dtmTemp;
                ftcal_Year.ToDate = end_dtmTemp;
            }
            //달력에 일정패턴 지정
            if (sender.Equals(cbx_Schd_Code))
            {
                if (!cbx_Schd_Code.SelectedIndex.Equals(-1))
                {
                    model.MedDoctorScheduleCriteriaRegistrationInObj.MED_DEPT_CD = ucPACodeAsk.SelectedTextName3;
                    model.MedDoctorScheduleCriteriaRegistrationInObj.MEDR_SID = ucPACodeAsk.SelectedTextName2Hidden;//SID세팅되면다시열어야함20160229송민수
                                                                                                                    //model.MedDoctorScheduleCriteriaRegistrationInObj.MEDR_SID = ucPACodeAsk.SelectedTextCode;
                    model.MedDoctorScheduleCriteriaRegistrationInObj.MEDS_BSC_CD = model.ScheduleCodeOutObj[cbx_Schd_Code.SelectedIndex].MEDS_BSC_CD;

                    model.Scheduel_TEMP = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleCriteriaRegistrationBL", "SelectMedReservationCriteria", model.MedDoctorScheduleCriteriaRegistrationInObj) as HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>;

                    model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex] = model.Scheduel_TEMP;

                    if (!model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Count().Equals(0))
                    {
                        //요일별 Data 분리
                        Linq_Mon_AM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("2") && j.TM_UNIT_CD.Equals("AM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Mon_PM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("2") && j.TM_UNIT_CD.Equals("PM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Tue_AM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("3") && j.TM_UNIT_CD.Equals("AM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Tue_PM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("3") && j.TM_UNIT_CD.Equals("PM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Wed_AM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("4") && j.TM_UNIT_CD.Equals("AM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Wed_PM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("4") && j.TM_UNIT_CD.Equals("PM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Thu_AM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("5") && j.TM_UNIT_CD.Equals("AM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Thu_PM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("5") && j.TM_UNIT_CD.Equals("PM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Fri_AM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("6") && j.TM_UNIT_CD.Equals("AM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Fri_PM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("6") && j.TM_UNIT_CD.Equals("PM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Sat_AM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("7") && j.TM_UNIT_CD.Equals("AM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Sat_PM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("7") && j.TM_UNIT_CD.Equals("PM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        // 20240311 김재강 : 일요일 선택가능하도록 변경함에 따른 코드 추가
                        Linq_Sun_AM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("1") && j.TM_UNIT_CD.Equals("AM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));
                        Linq_Sun_PM = model.Scheduel_LIST[cbx_Schd_Code.SelectedIndex].Filter(j => j.MED_DOW_KND_CD.Equals("1") && j.TM_UNIT_CD.Equals("PM") && j.MEDS_BSC_CD.Equals(((HIS.PA.AC.PE.SC.DTO.MedDoctorScheduleRegistration_CODE_OUT)(cbx_Schd_Code.SelectedItem)).MEDS_BSC_CD));

                        if (!Linq_Mon_AM.Count().Equals(0) || !Linq_Mon_PM.Count().Equals(0))
                            pattern_week[0] = true;
                        else
                            pattern_week[0] = false;
                        if (!Linq_Tue_AM.Count().Equals(0) || !Linq_Tue_PM.Count().Equals(0))
                            pattern_week[1] = true;
                        else
                            pattern_week[1] = false;
                        if (!Linq_Wed_AM.Count().Equals(0) || !Linq_Wed_PM.Count().Equals(0))
                            pattern_week[2] = true;
                        else
                            pattern_week[2] = false;
                        if (!Linq_Thu_AM.Count().Equals(0) || !Linq_Thu_PM.Count().Equals(0))
                            pattern_week[3] = true;
                        else
                            pattern_week[3] = false;
                        if (!Linq_Fri_AM.Count().Equals(0) || !Linq_Fri_PM.Count().Equals(0))
                            pattern_week[4] = true;
                        else
                            pattern_week[4] = false;
                        if (!Linq_Sat_AM.Count().Equals(0) || !Linq_Sat_PM.Count().Equals(0))
                            pattern_week[5] = true;
                        else
                            pattern_week[5] = false;
                        // 20240311 김재강 : 일요일 선택가능하도록 변경함에 따른 코드 추가
                        if (!Linq_Sun_AM.Count().Equals(0) || !Linq_Sun_PM.Count().Equals(0))
                            pattern_week[6] = true;
                        else
                            pattern_week[6] = false;

                        //if (!Linq_Mon_AM.Count().Equals(0) || !Linq_Mon_PM.Count().Equals(0))
                        //{
                        if (Linq_Mon_AM.Count() > 0)
                        {
                            Linq_Mon_AM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Mon_AM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Mon_AM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Mon_AM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Mon_AM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Mon_AM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Mon_AM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Mon_AM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)

                            });
                        }

                        if (Linq_Mon_PM.Count() > 0)
                        {
                            Linq_Mon_PM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Mon_PM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Mon_PM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Mon_PM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Mon_PM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Mon_PM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Mon_PM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Mon_PM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }

                        //    dgrd_Schedule_AM.DataSource = Linq_Mon_AM;
                        //    dgrd_Schedule_PM.DataSource = Linq_Mon_PM;
                        //}
                        //else if (!Linq_Tue_AM.Count().Equals(0) || !Linq_Tue_PM.Count().Equals(0))
                        //{
                        if (Linq_Tue_AM.Count() > 0)
                        {
                            Linq_Tue_AM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Tue_AM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Tue_AM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Tue_AM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Tue_AM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Tue_AM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Tue_AM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Tue_AM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }

                        if (Linq_Tue_PM.Count() > 0)
                        {
                            Linq_Tue_PM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Tue_PM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Tue_PM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Tue_PM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Tue_PM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Tue_PM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Tue_PM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Tue_PM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }
                        //    dgrd_Schedule_AM.DataSource = Linq_Tue_AM;
                        //    dgrd_Schedule_PM.DataSource = Linq_Tue_PM;
                        //}
                        //else if (!Linq_Wed_AM.Count().Equals(0) || !Linq_Wed_PM.Count().Equals(0))
                        //{
                        if (Linq_Wed_AM.Count() > 0)
                        {
                            Linq_Wed_AM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Wed_AM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Wed_AM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Wed_AM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Wed_AM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Wed_AM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Wed_AM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Wed_AM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }

                        if (Linq_Wed_PM.Count() > 0)
                        {
                            Linq_Wed_PM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Wed_PM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Wed_PM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Wed_PM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Wed_PM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Wed_PM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Wed_PM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Wed_PM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }
                        //    dgrd_Schedule_AM.DataSource = Linq_Wed_AM;
                        //    dgrd_Schedule_PM.DataSource = Linq_Wed_PM;
                        //}
                        //else if (!Linq_Thu_AM.Count().Equals(0) || !Linq_Thu_PM.Count().Equals(0))
                        //{
                        if (Linq_Thu_AM.Count() > 0)
                        {
                            Linq_Thu_AM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Thu_AM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Thu_AM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Thu_AM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Thu_AM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Thu_AM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Thu_AM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Thu_AM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }

                        if (Linq_Thu_PM.Count() > 0)
                        {
                            Linq_Thu_PM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Thu_PM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Thu_PM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Thu_PM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Thu_PM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Thu_PM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Thu_PM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Thu_PM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }
                        //    dgrd_Schedule_AM.DataSource = Linq_Thu_AM;
                        //    dgrd_Schedule_PM.DataSource = Linq_Thu_PM;
                        //}
                        //else if (!Linq_Fri_AM.Count().Equals(0) || !Linq_Fri_PM.Count().Equals(0))
                        //{
                        if (Linq_Fri_AM.Count() > 0)
                        {
                            Linq_Fri_AM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Fri_AM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Fri_AM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Fri_AM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Fri_AM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Fri_AM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Fri_AM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Fri_AM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }

                        if (Linq_Fri_PM.Count() > 0)
                        {
                            Linq_Fri_PM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Fri_PM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Fri_PM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Fri_PM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Fri_PM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Fri_PM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Fri_PM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Fri_PM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)

                            });
                        }
                        //    dgrd_Schedule_AM.DataSource = Linq_Fri_AM;
                        //    dgrd_Schedule_PM.DataSource = Linq_Fri_PM;
                        //}
                        //else
                        //{
                        if (Linq_Sat_AM.Count() > 0)
                        {
                            Linq_Sat_AM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Sat_AM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Sat_AM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Sat_AM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Sat_AM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Sat_AM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Sat_AM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Sat_AM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }

                        if (Linq_Sat_PM.Count() > 0)
                        {
                            Linq_Sat_PM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Sat_PM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Sat_PM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Sat_PM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Sat_PM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Sat_PM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Sat_PM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Sat_PM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }

                        // 20240311 김재강 : 일요일 선택가능하도록 변경함에 따른 코드 추가
                        if (Linq_Sun_AM.Count() > 0)
                        {
                            Linq_Sun_AM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Sun_AM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Sun_AM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Sun_AM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Sun_AM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Sun_AM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Sun_AM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Sun_AM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }
                        if (Linq_Sun_PM.Count() > 0)
                        {
                            Linq_Sun_PM.Add(new MedDoctorScheduleCriteriaRegistration_INOUT()
                            {
                                TM_UNIT_CD = "합계",
                                RSV_WHL_FXNO_CNT = Linq_Sun_PM.Sum(x => x.RSV_WHL_FXNO_CNT),
                                RSV_FRVS_FXNO_CNT = Linq_Sun_PM.Sum(x => x.RSV_FRVS_FXNO_CNT),
                                RSV_RMDE_FXNO_CNT = Linq_Sun_PM.Sum(x => x.RSV_RMDE_FXNO_CNT),
                                RSV_NEWP_FXNO_CNT = Linq_Sun_PM.Sum(x => x.RSV_NEWP_FXNO_CNT),
                                RSV_ABNO_FXNO_CNT = Linq_Sun_PM.Sum(x => x.RSV_ABNO_FXNO_CNT),
                                // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 예약퇴원초진정원환자수 예약퇴원재진정원환자수 추가
                                RSV_DS_FRVS_FXNO_PT_CNT = Linq_Sun_PM.Sum(x => x.RSV_DS_FRVS_FXNO_PT_CNT),
                                RSV_DS_RMDE_FXNO_PT_CNT = Linq_Sun_PM.Sum(x => x.RSV_DS_RMDE_FXNO_PT_CNT)
                            });
                        }
                    }
                }
            }
        }

        /// <summary>
        /// name         : Control_KeyDown
        /// desc         : 각 KeyDown 이벤트 처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_KeyDown(object sender, KeyEventArgs e)
        {
            //FromToCalendar Focus이동
            if (((System.Windows.DependencyObject)(sender)).DependencyObjectType.Name.Equals("HFromToCalendar"))
            {
                if (e.OriginalSource is HDateEditor)
                {
                    HDateEditor obj = (HDateEditor)e.OriginalSource;

                    if (obj.Name.Equals("PART_DateEditorFrom") && (e.Key.Equals(Key.Enter)))
                    {
                        ControlHelper.HDateEditorFocus(ControlHelper.FindChild<HDateEditor>((HFromToCalendar)sender, "PART_DateEditorTo"));
                        e.Handled = true;
                    }

                    if (e.Key.Equals(Key.F8))
                        ((HFromToCalendar)sender).IsOpen = true;
                }
            }

            //휴진등록
            if (sender.Equals(dtpck_Nsp_Wrk))
            {
                if (e.Key.Equals(Key.Return))
                    this.btn_Click(btn_NSP_Search);
            }
        }

        /// <summary>
        /// name         : Control_OnSelectChange
        /// desc         : 각 OnSelectChange 이벤트 처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_OnSelectChange(object sender)

        {
            //=========================================
            //일정등록 시작
            //=========================================
            //일정등록 의사선택시 일정코드 조회
            if (sender.Equals(ucPACodeAsk))
            {
                //ucPACodeAsk.Search(1);
                if (!String.IsNullOrEmpty(ucPACodeAsk.SelectedTextCode))
                {
                    model.ScheduleCodeInObj.MEDR_SID = ucPACodeAsk.SelectedTextName2Hidden; //SID세팅되면 사용.
                                                                                            //model.ScheduleCodeInObj.MEDR_SID = ucPACodeAsk.SelectedTextCode; // STFNO
                    model.ScheduleCodeInObj.MED_DEPT_CD = ucPACodeAsk.SelectedTextName3;

                    model.ScheduleCodeOutObj = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CODE_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelectDoctorMedScheduleCodeAsk", model.ScheduleCodeInObj);

                    this.cbx_Schd_Code.DisplayMemberPath = "MEDS_BSC_CD_NM";
                    this.cbx_Schd_Code.SelectedValuePath = "MEDS_BSC_CD";
                    this.cbx_Schd_Code.ItemsSource = model.ScheduleCodeOutObj;

                    if (model.ScheduleCodeOutObj.Count().Equals(0))
                    {
                        MsgBox.Display(ucPACodeAsk.SelectedTextName1 + "의 일정 코드가 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        return;
                    }
                    else
                    {
                        model.CheckChanged = null;
                        exp_calYear.IsExpanded = true;
                        //기존 패턴 삭제
                        if (calYear.PatternDayInfoCollection != null && calYear.PatternDayInfoCollection.Count() > 0)
                        {
                            int cnt = calYear.PatternDayInfoCollection.Count();

                            for (int i = 0; i < cnt; i++)
                                calYear.PatternDayInfoCollection.Remove(calYear.PatternDayInfoCollection[0]);
                            model.PatternCollection = new CustomDateInfoCollection();
                        }

                        //패턴별 일정 표시 위한 할당.
                        for (int i = 0; i < model.ScheduleCodeOutObj.Count(); i++)
                            model.Scheduel_LIST.Add(model.Scheduel_TEMP);

                    }

                    //의사별 클리닉정보
                    set_Clinic();

                    //달력 공휴일&휴진 표기
                    HoliDays_Setting();

                    calYear.SelectedDate = CommonServiceAgent.SelectSysDate();

                    if (tabMain.SelectedIndex.Equals(0))
                        btn_Rcep.IsEnabled = true;
                }
                else
                {
                    if (tabMain.SelectedIndex.Equals(0))
                        btn_Rcep.IsEnabled = false;
                }
            }
            //=========================================
            //일정등록 끝
            //=========================================
            //=========================================
            //휴진등록 시작
            //=========================================
            if (sender.Equals(ucPACodeAsk_NSP_Medr1))
            {
                if (!String.IsNullOrEmpty(ucPACodeAsk_NSP_Medr1.SelectedTextCode))
                    this.btn_Click(btn_NSP_Search);
            }

            if (sender.Equals(ucPACodeAsk_NSP_Medr2))
            {
                if (!String.IsNullOrEmpty(ucPACodeAsk_NSP_Medr2.SelectedTextCode))
                {
                    ucPACodeAsk_NSP_Rsn.IsEnabled = true;
                    ucPACodeAsk_NSP_Rsn.SelectedTextCodeFocus();
                }
            }

            if (sender.Equals(ucPACodeAsk_NSP_Rsn))
            {
                if (String.IsNullOrEmpty(ucPACodeAsk_NSP_Rsn.SelectedTextName1))
                {
                    MsgBox.Display("휴진사유 정보를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    ucPACodeAsk_NSP_Rsn.Clear();
                    ucPACodeAsk_NSP_Rsn.SelectedTextCodeFocus();
                    return;
                }

                if (ucPACodeAsk_NSP_Rsn.SelectedTextCode == "10")   //이화면 10 쓰면 안대!! DK20201101
                {
                    MsgBox.Display("휴진사유 정보를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                    ucPACodeAsk_NSP_Rsn.Clear();
                    ucPACodeAsk_NSP_Rsn.SelectedTextCodeFocus();
                    return;
                }

                if (!String.IsNullOrEmpty(ucPACodeAsk_NSP_Rsn.SelectedTextCode))
                {
                    dtp_nsp_apy.IsEnabled = true;
                    dtp_nsp_apy.Focus();
                    //ftcal_NSP_Prd.IsEnabled = true;
                    //ftcal_NSP_Prd.IsFocusFromDate = true;
                }
            }
            //=========================================
            //휴진등록 끝
            //=========================================

            //=========================================
            //대진등록 시작
            //=========================================
            if (sender.Equals(ucPACodeAsk_SFAD_Medr1))
            {
                if (!String.IsNullOrEmpty(ucPACodeAsk_SFAD_Medr1.SelectedTextCode))
                    this.btn_Click(btn_SFAD_Search);
            }
            //=========================================
            //대진등록 끝
            //=========================================
        }

        /// <summary>
        /// name         : set_Clinic
        /// desc         : 의사의 클리닉 정보 조회
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void set_Clinic()
        {
            model.MedDoctorScheduleCriteriaRegistrationInObj.MEDR_SID = ucPACodeAsk.SelectedTextName2Hidden;
            model.SelDoctorAClinicInformationOutObj = (HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleCriteriaRegistrationBL", "SelDoctorAClinicInformation", model.MedDoctorScheduleCriteriaRegistrationInObj);

            ComboBoxItemsProvider cobACNT_TP_CD = this.TryFindResource("CLINIC_CD") as ComboBoxItemsProvider;
            cobACNT_TP_CD.DisplayMemberPath = "CLNC_CD_NM";
            cobACNT_TP_CD.ValuePath = "CLNC_TP_CD";
            cobACNT_TP_CD.ItemsSource = model.SelDoctorAClinicInformationOutObj;
        }

        /// <summary>
        /// name         : rdo_Selected
        /// desc         : 라디오 버튼 Selected 이벤트 처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void rdo_Selected(object sender, RoutedEventArgs e)
        {
            //=========================================
            //휴진등록 시작
            //=========================================
            if (sender.Equals(rdo_NSP_Wrk))
            {
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, dtpck_Nsp_Wrk);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, ucPACodeAsk_NSP_Medr1, stpNspHsptp);
                ControlHelper.SetEnableControl(true, ucPACodeAsk_NSP_Medr2, ucPACodeAsk_NSP_Rsn, txtNsp_Remark, ftcal_NSP_Prd);

                model.NspOutObj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>();
                model.NspInOutObj = new MedDoctorScheduleRegistration_NSP_OUT();

                //txtb_NSP_Wrk.Text = "등록일";
            }

            if (sender.Equals(rdo_NSP_DT))
            {
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, dtpck_Nsp_Wrk, stpNspHsptp);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, ucPACodeAsk_NSP_Medr1);
                ControlHelper.SetEnableControl(true, ucPACodeAsk_NSP_Medr2, ucPACodeAsk_NSP_Rsn, txtNsp_Remark, ftcal_NSP_Prd);

                model.NspOutObj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>();
                model.NspInOutObj = new MedDoctorScheduleRegistration_NSP_OUT();

                //txtb_NSP_Wrk.Text = "휴진일";
            }

            if (sender.Equals(rdo_NSP_Medr))
            {
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, dtpck_Nsp_Wrk, stpNspHsptp);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, ucPACodeAsk_NSP_Medr1);
                ControlHelper.SetEnableControl(false, ucPACodeAsk_NSP_Medr2);
                ControlHelper.SetEnableControl(true, ucPACodeAsk_NSP_Rsn, txtNsp_Remark, ftcal_NSP_Prd);

                model.NspOutObj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>();
                model.NspInOutObj = new MedDoctorScheduleRegistration_NSP_OUT();
            }

            //=========================================
            //휴진등록 끝
            //=========================================
        }

        /// <summary>
        /// name         : Control_CellActivated
        /// desc         : 그리드 CellActivated 이벤트 처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_CellActivated(object sender, Infragistics.Windows.DataPresenter.Events.CellActivatedEventArgs e)
        {
            if (sender.Equals(dgrd_NSP))
            {
                MedDoctorScheduleRegistration_NSP_OUT NSP_TEMP = dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT;
                ucPACodeAsk_NSP_Medr2.PassingReference = NSP_TEMP.MED_DEPT_CD;
                ucPACodeAsk_NSP_Medr2.SelectedTextCode = NSP_TEMP.MEDR_STF_NO;
                //                model.NspInOutObj.MEDR_STF_NO = NSP_TEMP.MEDR_STF_NO;
                //                model.NspInOutObj.MEDR_SID = NSP_TEMP.MEDR_SID;
                model.NspInOutObj.APY_STR_DT = NSP_TEMP.APY_STR_DT;
                model.NspInOutObj.APY_END_DT = NSP_TEMP.APY_END_DT;
                model.NspInOutObj.OLD_APY_STR_DT = NSP_TEMP.OLD_APY_STR_DT;
                model.NspInOutObj.OLD_APY_END_DT = NSP_TEMP.OLD_APY_END_DT;
                model.NspInOutObj.NSP_RSN_TP_CD = NSP_TEMP.NSP_RSN_TP_CD;
                model.NspInOutObj.LSH_STF_NO = NSP_TEMP.LSH_STF_NO;
                model.NspInOutObj.LSH_DTM = NSP_TEMP.LSH_DTM;
                model.NspInOutObj.NSP_MEMO = NSP_TEMP.NSP_MEMO;
                model.NspInOutObj.MCSD_RSLT_CD = NSP_TEMP.MCSD_RSLT_CD;

                model.NspInOutObj.MED_DEPT_CD = NSP_TEMP.MED_DEPT_CD;
                model.NspInOutObj.SPLM_YN = NSP_TEMP.SPLM_YN;
                model.NspInOutObj.NSP_APLC_DT = NSP_TEMP.NSP_APLC_DT;
                model.NspInOutObj.NSP_STR_DT_CMED_AMT_OCUR_YN = NSP_TEMP.NSP_STR_DT_CMED_AMT_OCUR_YN;
                model.NspInOutObj.NSP_END_DT_CMED_AMT_OCUR_YN = NSP_TEMP.NSP_END_DT_CMED_AMT_OCUR_YN;
                model.NspInOutObj.TM_UNIT_CD = NSP_TEMP.TM_UNIT_CD;
                model.NspInOutObj.OLD_TM_UNIT_CD = NSP_TEMP.TM_UNIT_CD;

                if (NSP_TEMP.PACT_TP_CD.Equals("O"))
                    rdo_NSP_OI.SelectedIndex = 0;
                else if (NSP_TEMP.PACT_TP_CD.Equals("I"))
                    rdo_NSP_OI.SelectedIndex = 1;
                model.NspInOutObj.PACT_TP_CD = NSP_TEMP.PACT_TP_CD;

                // 2024.07.16 김재강 추가
                if (NSP_TEMP.TM_UNIT_CD == "오전" || NSP_TEMP.TM_UNIT_CD == "종일") cbx_AM.IsSelected = true;
                else cbx_AM.IsSelected = false;
                if (NSP_TEMP.TM_UNIT_CD == "오후" || NSP_TEMP.TM_UNIT_CD == "종일") cbx_PM.IsSelected = true;
                else cbx_PM.IsSelected = false;

                if (model.NspInOutObj.SPLM_YN != null && model.NspInOutObj.SPLM_YN.Equals("Y"))
                {
                    chxSplm.IsChecked = true;
                }
                else
                {
                    chxSplm.IsChecked = false;
                }

                model.NspInOutObj.NSP_APLC_DT = NSP_TEMP.NSP_APLC_DT;

                if (model.NspInOutObj.NSP_STR_DT_CMED_AMT_OCUR_YN != null && model.NspInOutObj.NSP_STR_DT_CMED_AMT_OCUR_YN.Equals("Y"))
                {
                    chxStrAmt.IsSelected = true;
                }
                else
                {
                    chxStrAmt.IsSelected = false;
                }
                if (model.NspInOutObj.NSP_END_DT_CMED_AMT_OCUR_YN != null && model.NspInOutObj.NSP_END_DT_CMED_AMT_OCUR_YN.Equals("Y"))
                {
                    chxEndAmt.IsSelected = true;
                }
                else
                {
                    chxEndAmt.IsSelected = false;
                }

                this.chk_Visible(((HDataGrid)sender).Name.ToString());
            }
        }

        /// <summary>
        /// name         : dgrd_RecordActivated
        /// desc         : 그리드 RecordActivated 이벤트 처리
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void dgrd_RecordActivated(object sender, Infragistics.Windows.DataPresenter.Events.RecordActivatedEventArgs e)
        {
            //=========================================
            //휴진등록 시작
            //=========================================
            if (sender.Equals(dgrd_NSP))
            {
                MedDoctorScheduleRegistration_NSP_OUT NSP_TEMP = dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT;
                model.NspInOutObj.MEDR_STF_NO = NSP_TEMP.MEDR_STF_NO;
                //NSP_TEMP.MEDR_STF_NO;
                model.NspInOutObj.MEDR_SID = NSP_TEMP.MEDR_SID;
                model.NspInOutObj.APY_STR_DT = NSP_TEMP.APY_STR_DT;
                model.NspInOutObj.APY_END_DT = NSP_TEMP.APY_END_DT;
                model.NspInOutObj.NSP_RSN_TP_CD = NSP_TEMP.NSP_RSN_TP_CD;
                model.NspInOutObj.LSH_STF_NO = NSP_TEMP.LSH_STF_NO;
                model.NspInOutObj.LSH_DTM = NSP_TEMP.LSH_DTM;
                model.NspInOutObj.NSP_MEMO = NSP_TEMP.NSP_MEMO;
                model.NspInOutObj.MCSD_RSLT_CD = NSP_TEMP.MCSD_RSLT_CD;
                if (NSP_TEMP.PACT_TP_CD.Equals("O"))
                    rdo_NSP_OI.SelectedIndex = 0;
                else if (NSP_TEMP.PACT_TP_CD.Equals("I"))
                    rdo_NSP_OI.SelectedIndex = 1;
                model.NspInOutObj.PACT_TP_CD = NSP_TEMP.PACT_TP_CD;

                this.chk_Visible(((HDataGrid)sender).Name.ToString());
            }
            //=========================================
            //휴진등록 끝
            //=========================================

            //=========================================
            //대진일정 시작
            //=========================================
            if (sender.Equals(dgrd_SFAD))
            {
                //if (model.sfad_out.count > 0) 오류
                //{
                //    controlhelper.setdisplaycontrol(system.windows.visibility.visible, btn_update);
                //    controlhelper.setdisplaycontrol(system.windows.visibility.collapsed, btn_save);
                //    controlhelper.setenablecontrol(true, btn_update, btn_delete, btn_add);
                //    controlhelper.setenablecontrol(false, btn_save, ucpacodeask_sfad_medr2);

                //    model.sfad_in.sfad_medr_stf_no = (dgrd_sfad.activedataitem as meddoctorscheduleregistration_sfad_inout).sfad_medr_stf_no;
                //    model.sfad_in.sfad_str_dtm = (dgrd_sfad.activedataitem as meddoctorscheduleregistration_sfad_inout).sfad_str_dtm;
                //    model.sfad_in.sfad_end_dtm = (dgrd_sfad.activedataitem as meddoctorscheduleregistration_sfad_inout).sfad_end_dtm;
                //    model.sfad_in.sfad_rsn_tp_cd = (dgrd_sfad.activedataitem as meddoctorscheduleregistration_sfad_inout).sfad_rsn_tp_cd;

                //    temp_sfad_str_dtm = (dgrd_sfad.activedataitem as meddoctorscheduleregistration_sfad_inout).sfad_str_dtm;
                //}
            }
            //=========================================
            //대진일정 끝
            //=========================================
        }
        /// <summary>
        /// name         : dgrd_SelectionChanged
        /// desc         : 그리드SelectionChanged 이벤트 처리
        /// author       : 송민수
        /// create date  : 2016-03-09
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void dgrd_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //=========================================
            //대진일정 시작
            //=========================================
            if (sender.Equals(dgrd_SFAD))
            {
                if (model.SFAD_OUT.Count > 0)
                {
                    if (dgrd_SFAD.SelectedItem != null)
                    {
                        ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Update);
                        ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Save);
                        ControlHelper.SetEnableControl(true, btn_Update, btn_Delete, btn_Add);
                        ControlHelper.SetEnableControl(false, btn_Save, ucPACodeAsk_SFAD_Medr2);

                        model.SFAD_IN.SFAD_MEDR_STF_NO = (dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).SFAD_MEDR_STF_NO;
                        model.SFAD_IN.SFAD_STR_DTM = (dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).SFAD_STR_DTM;
                        model.SFAD_IN.SFAD_END_DTM = (dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).SFAD_END_DTM;
                        model.SFAD_IN.SFAD_RSN_TP_CD = (dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).SFAD_RSN_TP_CD;

                        temp_sfad_str_dtm = (dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).SFAD_STR_DTM;

                        //DK20201101
                        model.SFAD_IN.NSP_RSN_REQ_STF_NO = (dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).NSP_RSN_REQ_STF_NO;
                        model.SFAD_IN.NSP_RSN_CNTE = (dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).NSP_RSN_CNTE;
                    }
                }

                if (dgrd_SFAD.SelectedItem != null)
                    if (string.IsNullOrEmpty((dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).NSP_RSN_CNTE))
                    {
                        cboNSP_RSN_CNTE.SelectedIndex = 0;
                    }
                    else
                    {
                        cboNSP_RSN_CNTE.SelectedValue = "";
                    }
            }
            //=========================================
            //대진일정 끝
            //=========================================
        }


        /// <summary>
        /// name         : chk_Visible
        /// desc         : 각 Visible 속성관련 지정
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void chk_Visible(String s)
        {
            //=========================================
            //화면초기 시작
            //=========================================
            if (s.Equals("Init"))
            {
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Add, btn_Delete, btn_Update, btn_Rcep);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Save);
                ControlHelper.SetEnableControl(true, btn_Rcep);
                this.btn_Rcep.IsEnabled = true;

                if (tabMain.SelectedIndex.Equals(1))
                {
                    ControlHelper.SetEnableControl(false, ucPACodeAsk_NSP_Medr2, ucPACodeAsk_NSP_Rsn, ftcal_NSP_Prd, txtNsp_Remark, btn_Delete, btn_Update);
                    ControlHelper.SetEnableControl(true, btn_Add, rdo_NSP_OI);
                }
            }
            //=========================================
            //화면초기 끝
            //=========================================

            //=========================================
            //휴진일정 시작
            //=========================================
            if (s.Equals("dgrd_NSP"))
            {
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Update);
                ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Save);

                ControlHelper.SetEnableControl(false, btn_Delete, btn_Update);
                ControlHelper.SetEnableControl(true, btn_Init, btn_CrDoc, btn_Add, btn_Rcep, btn_Excel);

                if (model.NspInOutObj.APY_STR_DT <= DateTime.Now.AddDays(-180))
                {
                    ControlHelper.SetEnableControl(false, btn_Delete, btn_Update, ucPACodeAsk_NSP_Medr2, ucPACodeAsk_NSP_Rsn, ftcal_NSP_Prd, rdo_NSP_OI, txtNsp_Remark);
                    ControlHelper.SetEnableControl(true, btn_Init, btn_CrDoc, btn_Add, btn_Rcep, btn_Excel);
                }
                else
                {
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Save);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Update);

                    ControlHelper.SetEnableControl(true, btn_Add, btn_Delete, btn_Update, btn_Rcep, ftcal_NSP_Prd, ucPACodeAsk_NSP_Rsn, rdo_NSP_OI, txtNsp_Remark);
                }
            }
            //=========================================
            //휴진일정 끝
            //=========================================

            //=========================================
            //TreeView 시작
            //=========================================
            if (s.Equals("tvMedTree2"))
            {
                if (tabMain.SelectedIndex.Equals(1))
                {
                    ControlHelper.SetEnableControl(true, btn_Save, btn_Add, ucPACodeAsk_NSP_Rsn, ftcal_NSP_Prd, rdo_NSP_OI, txtNsp_Remark);
                    ControlHelper.SetEnableControl(false, btn_Delete, btn_Rcep, ucPACodeAsk_NSP_Medr2);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Save);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Update);
                }
            }
            //=========================================
            //TreeView 끝
            //=========================================

            //=========================================
            //추가버튼 별 시작
            //=========================================
            if (s.Equals("btn_Add"))
            {
                //휴진등록
                if (tabMain.SelectedIndex.Equals(1))
                {
                    if (rdo_NSP_Wrk_Seq.SelectedIndex.Equals(0) || rdo_NSP_Wrk_Seq.SelectedIndex.Equals(1))
                        this.ucPACodeAsk_NSP_Medr2.IsEnabled = true;
                    else if (rdo_NSP_Wrk_Seq.SelectedIndex.Equals(2))
                        this.ucPACodeAsk_NSP_Medr2.IsEnabled = false;

                    ControlHelper.SetEnableControl(true, ucPACodeAsk_NSP_Rsn, ftcal_NSP_Prd, rdo_NSP_OI, txtNsp_Remark, btn_Init, btn_CrDoc, btn_Save, btn_Add);
                    ControlHelper.SetEnableControl(false, btn_Delete, btn_Rcep, btn_Excel);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Visible, btn_Save);
                    ControlHelper.SetDisplayControl(System.Windows.Visibility.Collapsed, btn_Update);
                }
            }
            //=========================================
            //추가버튼 별 끝
            //=========================================
        }

        /// <summary>
        /// name         : dtpck_SelectedDateChanged
        /// desc         : 각 SelectedDateChanged 속성관련 지정
        /// author       : kimchihwan
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        //private void dtpck_SelectedDateChanged(object sender)
        //{
        //    //if (sender.Equals(dtpck_Nsp_Wrk))
        //    //    this.btn_Click(btn_NSP_Search);
        //}

        /// <summary>
        /// name         : mi_Click
        /// desc         : 오른쪽 메뉴 선택시 처리 Event
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 2024-08-16 김재강 : 콜전송, 취소 수정
        /// </summary>
        private void mi_Click(object sender, RoutedEventArgs e)
        {
            //Call 전송
            if ((e.OriginalSource as HMenuItem).Tag.Equals("S"))
            {

                CallSend_IN CallSendInobj = new CallSend_IN();

                //if (Convert.ToDateTime((dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_STR_DT).AddDays(1) < (DateTime)CommonServiceAgent.SelectSysDateTime())
                //{
                //    MsgBox.Display("이전 날짜에 대한 Call전송은 불가합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //    return;
                //}

                if (MsgBox.Display("Call전송 하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES) == MessageBoxResult.Yes)
                {
                    CallSendInobj.IN_APY_STR_DT = ((DateTime)(dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_STR_DT).ToString("yyyyMMdd");
                    CallSendInobj.IN_APY_END_DT = ((DateTime)(dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_END_DT).ToString("yyyyMMdd");
                    CallSendInobj.IN_MEDR_STF_NO = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MEDR_STF_NO;
                    CallSendInobj.IN_MED_DEPT_CD = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MED_DEPT_CD;

                    decimal result = (decimal)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.NotSeeingPatientsScheduleAskBL", "CallSend", CallSendInobj);

                    MsgBox.Display("전송되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);

                    model.NspOutObj = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelectDoctorBusinessTripSchedule", model.NspInObj);

                }

                // 서울대 로직 주석

                //if (rs.Equals(MessageBoxResult.Yes))
                //{
                //    HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

                //    if (chk_NSP_Batch.IsChecked == true)
                //    {
                //        for (int i = 0; i < model.NspOutObj.Count(); i++)
                //        {
                //            if (model.NspOutObj[i].ISCHECKED == true && model.NspOutObj[i].PACT_TP_CD == "O" && String.IsNullOrEmpty(model.NspOutObj[i].MCSD_DTM.ToString()))
                //                io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateDoctorBusinessTripCallSend", model.NspOutObj[i]) as HIS.Core.Global.DTO.Result_OUT;
                //        }
                //    }
                //    else if (chk_NSP_Batch.IsChecked == false && (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).PACT_TP_CD == "O" && String.IsNullOrEmpty((dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MCSD_DTM.ToString()))
                //    {
                //        io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateDoctorBusinessTripCallSend", (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT)) as HIS.Core.Global.DTO.Result_OUT;

                //        //if (io_result.IsSucess == true)
                //        //    io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertDoctorBusinessTripCallSend", (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT)) as HIS.Core.Global.DTO.Result_OUT;
                //    }


                //    if (io_result.IsSucess.Equals(false))
                //    {
                //        MsgBox.Display("저장에 실패 하였습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //        return;
                //    }
                //    else
                //    {
                //        MsgBox.Display("정상적으로 저장되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //        this.btn_Click(btn_NSP_Search);
                //    }
                //}
            }

            //변경 취소
            if ((e.OriginalSource as HMenuItem).Tag.Equals("C"))
            {
                CallSend_IN CallSendInobj = new CallSend_IN();

                //if (Convert.ToDateTime((dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_STR_DT).AddDays(1) < (DateTime)CommonServiceAgent.SelectSysDateTime())
                //{
                //    MsgBox.Display("이전 날짜에 대한 Call취소는 불가합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //    return;
                //}

                if (MsgBox.Display("Call취소 하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES) == MessageBoxResult.Yes)
                {
                    CallSendInobj.IN_APY_STR_DT = ((DateTime)(dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_STR_DT).ToString("yyyyMMdd");
                    CallSendInobj.IN_APY_END_DT = ((DateTime)(dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).APY_END_DT).ToString("yyyyMMdd");
                    CallSendInobj.IN_MEDR_STF_NO = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MEDR_STF_NO;
                    CallSendInobj.IN_MED_DEPT_CD = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MED_DEPT_CD;

                    decimal result = (decimal)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.NotSeeingPatientsScheduleAskBL", "CallCancel", CallSendInobj);

                    MsgBox.Display("취소되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);

                    model.NspOutObj = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelectDoctorBusinessTripSchedule", model.NspInObj);

                }

                // 서울대 로직 주석
                //MessageBoxResult rs = MsgBox.Display("진료변경 취소하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES);

                //if (rs.Equals(MessageBoxResult.Yes))
                //{
                //    HIS.Core.Global.DTO.Result_OUT io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateCallCenterMedicalTreatmentChangeCompletionProcess", model.NspInOutObj) as HIS.Core.Global.DTO.Result_OUT;

                //    if (io_result.IsSucess.Equals(false))
                //    {
                //        MsgBox.Display("저장에 실패 하였습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //        return;
                //    }
                //    else
                //    {
                //        MsgBox.Display("정상적으로 저장되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                //        this.btn_Click(btn_NSP_Search);
                //    }
                //}
            }

            //일괄휴진의사관리
            //MA : MAIN_STF_NO 추가, AA : ASST_STF_NO 추가
            if ((e.OriginalSource as HMenuItem).Tag.Equals("MA") || (e.OriginalSource as HMenuItem).Tag.Equals("AA"))
            {
                PopUpBase pop = base.OnLoadPopupMenu("AC_PTRS_SCHDR_AttendingPhysicianAsk");
                pop.Width = 700;
                pop.Height = 500;
                pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;

                pop.ShowDialog();

                if ((pop.MainMenuInfo.INSTANCE_OF_MENU as dynamic).model.PhysicianSelect2 != null)
                {
                    String DR_STF_NO = (pop.MainMenuInfo.INSTANCE_OF_MENU as dynamic).model.PhysicianSelect2.DR_STF_NO;
                    String DR_STF_NM = (pop.MainMenuInfo.INSTANCE_OF_MENU as dynamic).model.PhysicianSelect2.NM;
                    String MED_DEPT_CD = (pop.MainMenuInfo.INSTANCE_OF_MENU as dynamic).model.PhysicianSelect2.MEDDEPT;

                    MessageBoxResult mr = new MessageBoxResult();

                    HIS.Core.Global.DTO.Result_OUT io_result = new Result_OUT();

                    if ((e.OriginalSource as HMenuItem).Tag.Equals("MA"))
                    {
                        mr = MsgBox.Display("[" + MED_DEPT_CD + "] " + DR_STF_NM + "의사를 Main으로 등록하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES);

                        if (mr.Equals(MessageBoxResult.Yes))
                        {
                            model.BatchNSPInOutObj.MAIN_STF_NO = DR_STF_NO;
                            model.BatchNSPInOutObj.ASST_STF_NO = DR_STF_NO;
                            model.BatchNSPInOutObj.MEDR_DP = MED_DEPT_CD;
                        }
                    }
                    if ((e.OriginalSource as HMenuItem).Tag.Equals("AA"))
                    {
                        mr = MsgBox.Display("[" + MED_DEPT_CD + "] " + DR_STF_NM + "를 추가하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES);

                        if (mr.Equals(MessageBoxResult.Yes))
                        {
                            model.BatchNSPInOutObj.MAIN_STF_NO = temp_main_no;
                            model.BatchNSPInOutObj.ASST_STF_NO = DR_STF_NO;
                            model.BatchNSPInOutObj.MEDR_DP = MED_DEPT_CD;
                        }
                    }

                    if (mr.Equals(MessageBoxResult.Yes))
                        io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertBatchNotSeeingPtsRepresentationCode", model.BatchNSPInOutObj) as HIS.Core.Global.DTO.Result_OUT;

                    if (io_result.IsSucess == true)
                    {
                        MsgBox.Display("정상적으로 처리되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        Batch_Tree_Init();
                    }
                    else
                        MsgBox.Display("오류가 발생하였습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                }
            }

            //MD : MAIN_STF_NO 삭제, AD : ASST_STF_NO 삭제
            if ((e.OriginalSource as HMenuItem).Tag.Equals("MD") || (e.OriginalSource as HMenuItem).Tag.Equals("AD"))
            {
                HIS.Core.Global.DTO.Result_OUT io_result;

                if (MsgBox.Display(temp_medr_nm + "의사를 삭제하시겠습니까?", MessageType.MSG_TYPE_QUESTION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.YesNo, buttonFocusType: ButtonFocusType.YES) == MessageBoxResult.Yes)
                {
                    if ((e.OriginalSource as HMenuItem).Tag.Equals("MD"))
                    {
                        model.BatchNSPInOutObj.MAIN_STF_NO = temp_main_no;
                        model.BatchNSPInOutObj.ASST_STF_NO = temp_main_no;
                        model.BatchNSPInOutObj.MEDR_DP = temp_Medr_dp;
                        model.BatchNSPInOutObj.DEPTH = temp_depth;
                    }

                    if ((e.OriginalSource as HMenuItem).Tag.Equals("AD"))
                    {
                        model.BatchNSPInOutObj.MAIN_STF_NO = temp_asst_no;
                        model.BatchNSPInOutObj.ASST_STF_NO = temp_main_no.Substring(0, 5);
                        model.BatchNSPInOutObj.MEDR_DP = temp_Medr_dp;
                        model.BatchNSPInOutObj.DEPTH = temp_depth;
                    }

                    io_result = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "DeleteBatchNotSeeingPtsRepresentationCode", model.BatchNSPInOutObj) as HIS.Core.Global.DTO.Result_OUT;

                    if (io_result.IsSucess == true)
                    {
                        MsgBox.Display("정상적으로 처리되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                        Batch_Tree_Init();
                    }
                    else
                        MsgBox.Display("오류가 발생하였습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                }
            }
        }

        /// <summary>
        /// name         : Control_MouseRightButtonDown
        /// desc         : MouseRightButtonDown 처리 Event
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_MouseRightButtonDown(object sender, MouseButtonEventArgs e)
        {
            //휴진등록
            if (sender.Equals(dgrd_NSP) && !model.NspOutObj.Count().Equals(0))
            {
                UIElement element = ControlHelper.GetElementDataGridOnMouseDown(((HDataGrid)sender), e);

                if (element != null)
                {
                    ((HDataGrid)sender).ActiveRecord = ((HDataGrid)sender).Records[((Infragistics.Windows.DataPresenter.DataItemPresenter)(element)).Record.Index];
                    if (StringHelper.Equals((dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).PACT_TP_CD, "O"))
                    {
                        if (String.IsNullOrEmpty((dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MCSD_DTM.ToString()))
                            cm1.IsOpen = true;
                        else if (!StringHelper.Equals((dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).MCSD_RSLT_CD, "C"))
                            cm2.IsOpen = true;
                    }
                }
                else
                    return;
            }

            //트리뷰
            if (sender.Equals(tvMedTree3))
            {
                HTreeViewItem tem = ControlHelper.GetTreeViewItem(sender as HTreeView, e);

                temp_medr_nm = String.Empty;
                temp_asst_no = String.Empty;
                temp_main_no = String.Empty;
                temp_Medr_dp = String.Empty;
                temp_depth = String.Empty;

                if (tem == null)
                    cmBatch1.IsOpen = true;
                else
                {
                    tem.IsSelected = true;
                    MedDoctorScheduleRegistration_Tree_OUT tempValue = ((System.Windows.Controls.TreeView)(sender)).SelectedValue as MedDoctorScheduleRegistration_Tree_OUT;

                    temp_medr_nm = tempValue.MEDR_NM;
                    temp_asst_no = tempValue.ASST_STF_NO;
                    temp_main_no = tempValue.MAIN_STF_NO;
                    temp_Medr_dp = tempValue.MEDR_DP;
                    temp_depth = tempValue.DEPTH;

                    if (StringHelper.Equals(tempValue.DEPTH, "1"))
                        cmBatch2.IsOpen = true;
                    if (StringHelper.Equals(tempValue.DEPTH, "2"))
                        cmBatch3.IsOpen = true;
                }
            }
        }

        /// <summary>
        /// name         : dgrd_CellDoubleClick
        /// desc         : 그리드 CellDoubleClick 처리 Event
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void dgrd_CellDoubleClick(object sender, HSF.Controls.WPF.EventArgs.DoubleClickCellEventArgs e)
        {
            // 20240226 김재강 그리드 더블클릭 예외처리
            try
            {
                if (sender.Equals(dgrd_NSP))
                {
                    if (e.Cell.Field.Name.Equals("CRDOC_YN"))
                    {
                        if (String.IsNullOrEmpty((dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).CRDOC_YN))
                            (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).CRDOC_YN = "Y";
                        else
                            (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).CRDOC_YN = String.Empty;

                        model.NspInOutObj.CRDOC_YN = (dgrd_NSP.ActiveDataItem as MedDoctorScheduleRegistration_NSP_OUT).CRDOC_YN;
                    }
                }
            }
            catch { return; }
        }

        /// <summary>
        /// name         : Control_DisplayChanged
        /// desc         : 일정등록 년단위 달력 기간 변동에 따른 처리
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_DisplayChanged(object sender, SelectionChangedEventArgs e)
        {
            if (sender.Equals(calYear))
            {
                HoliDays_Setting();
            }
        }

        /// <summary>
        /// name         : HoliDays_Setting
        /// desc         : 휴일 및 공휴일 정보 지정
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void HoliDays_Setting()
        {
            //기존 휴일&공휴일 정보 삭제
            if (calYear.EventDayInfoCollection != null && calYear.EventDayInfoCollection.Count() > 0)
            {
                int cnt = calYear.EventDayInfoCollection.Count();

                for (int i = 0; i < cnt; i++)
                    calYear.EventDayInfoCollection.Remove(calYear.EventDayInfoCollection[0]);
                model.EventCollection = new CustomDateInfoCollection();
            }

            //휴일&공휴일 정보
            if (calYear.ReferenceDate.Equals(null))
            {
                model.ScheduleCodeInObj.MED_DTM = DateTime.Now.ToShortDateString().Replace("-", "");
                model.ScheduleCodeInObj.MED_TO_DTM = DateTime.Now.AddDays(365).ToShortDateString().Replace("-", "");
            }
            else
            {
                model.ScheduleCodeInObj.MED_DTM = calYear.ReferenceDate.Value.ToShortDateString().Replace("-", "");
                model.ScheduleCodeInObj.MED_TO_DTM = calYear.ReferenceDate.Value.AddDays(365).ToShortDateString().Replace("-", "");
            }
            model.ScheduleCodeInObj.MED_DEPT_CD = model.MedDoctorScheduleCriteriaRegistrationInObj.MED_DEPT_CD;

            HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Holi_OUT> HOLIDAY = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Holi_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelEachMonthHolSchedule", model.ScheduleCodeInObj);

            model.EventCollection = new CustomDateInfoCollection();
            model.EventCollection.Clear();

            foreach (var INFO in HOLIDAY)
            {
                model.EventCollection.Add(new CustomDateInfo(INFO.MED_DT, INFO.HOLDY_NSPDT_INFO));
            }

        }

        /// <summary>
        /// name         : Control_SelectedDateChanged
        /// desc         : SelectedDateChanged 처리 Event
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            if (sender.Equals(calYear) && !calYear.SelectedDate.Equals(null))
            {
                //int Pattern_Type = 0;
                bool temp_YN = false;
                //String day_Type = String.Empty;
                int am_cnt = 0;
                int pm_cnt = 0;

                if (calYear.SelectedDates.Count > 0)
                {
                    ftcal_Year.FromDate = calYear.SelectedDates[0];
                    ftcal_Year.ToDate = calYear.SelectedDates[calYear.SelectedDates.Count - 1];
                }


                for (int i = 0; i < model.PatternCollection.Count(); i++)
                {
                    if (model.PatternCollection[i].EventDate.Equals(calYear.SelectedDate))
                    {
                        temp_YN = true;
                        //Pattern_Type = int.Parse(model.PatternCollection[i].PatternType.ToString());
                    }
                }

                //if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Monday))    day_Type = "2";
                //if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Tuesday))   day_Type = "3";
                //if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Wednesday)) day_Type = "4";
                //if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Thursday))  day_Type = "5";
                //if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Friday))    day_Type = "6";
                //if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Saturday))  day_Type = "7";

                if (temp_YN.Equals(true))
                {
                    if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Monday))
                    {
                        dgrd_Schedule_AM.DataSource = Linq_Mon_AM;
                        dgrd_Schedule_PM.DataSource = Linq_Mon_PM;

                        am_cnt = Linq_Mon_AM.Count();
                        pm_cnt = Linq_Mon_PM.Count();
                    }
                    else if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Tuesday))
                    {
                        dgrd_Schedule_AM.DataSource = Linq_Tue_AM;
                        dgrd_Schedule_PM.DataSource = Linq_Tue_PM;

                        am_cnt = Linq_Tue_AM.Count();
                        pm_cnt = Linq_Tue_PM.Count();
                    }
                    else if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Wednesday))
                    {
                        dgrd_Schedule_AM.DataSource = Linq_Wed_AM;
                        dgrd_Schedule_PM.DataSource = Linq_Wed_PM;

                        am_cnt = Linq_Wed_AM.Count();
                        pm_cnt = Linq_Wed_PM.Count();
                    }
                    else if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Thursday))
                    {
                        dgrd_Schedule_AM.DataSource = Linq_Thu_AM;
                        dgrd_Schedule_PM.DataSource = Linq_Thu_PM;

                        am_cnt = Linq_Thu_AM.Count();
                        pm_cnt = Linq_Thu_PM.Count();
                    }
                    else if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Friday))
                    {
                        dgrd_Schedule_AM.DataSource = Linq_Fri_AM;
                        dgrd_Schedule_PM.DataSource = Linq_Fri_PM;

                        am_cnt = Linq_Fri_AM.Count();
                        pm_cnt = Linq_Fri_PM.Count();
                    }
                    // 20240311 김재강 : 일요일 선택가능하도록 변경함에 따른 코드 추가
                    else if (calYear.SelectedDate.Value.DayOfWeek.Equals(DayOfWeek.Sunday))
                    {
                        dgrd_Schedule_AM.DataSource = Linq_Sun_AM;
                        dgrd_Schedule_PM.DataSource = Linq_Sun_PM;

                        am_cnt = Linq_Sun_AM.Count();
                        pm_cnt = Linq_Sun_PM.Count();
                    }
                    else
                    {
                        dgrd_Schedule_AM.DataSource = Linq_Sat_AM;
                        dgrd_Schedule_PM.DataSource = Linq_Sat_PM;

                        am_cnt = Linq_Sat_AM.Count();
                        pm_cnt = Linq_Sat_PM.Count();
                    }
                    //dgrd_Schedule_AM.DataSource = model.Scheduel_LIST[Pattern_Type].Where(j => j.MED_DOW_KND_CD.Equals(day_Type) && j.TM_UNIT_CD.Equals("AM"));
                    //dgrd_Schedule_PM.DataSource = model.Scheduel_LIST[Pattern_Type].Where(j => j.MED_DOW_KND_CD.Equals(day_Type) && j.TM_UNIT_CD.Equals("PM"));
                    if (am_cnt > 0)
                        this.dgrd_Schedule_AM.ViewableRecords[am_cnt - 1].FixedLocation = Infragistics.Windows.DataPresenter.FixedRecordLocation.FixedToBottom;
                    if (pm_cnt > 0)
                        this.dgrd_Schedule_PM.ViewableRecords[pm_cnt - 1].FixedLocation = Infragistics.Windows.DataPresenter.FixedRecordLocation.FixedToBottom;




                }
                else
                {
                    dgrd_Schedule_AM.DataSource = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>();
                    dgrd_Schedule_PM.DataSource = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>();
                }
            }
        }

        /// <summary>
        /// name         : Schedule_Pattern
        /// desc         : 의사일정 pattern 적용
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Schedule_Pattern(String s)
        {
            //패턴 적용
            if (s.Equals("S"))
            {
                foreach (DateTime INFO in calYear.SelectedDates)
                {
                    if (INFO.DayOfWeek.Equals(DayOfWeek.Monday) && pattern_week[0].Equals(true) ||
                        INFO.DayOfWeek.Equals(DayOfWeek.Tuesday) && pattern_week[1].Equals(true) ||
                        INFO.DayOfWeek.Equals(DayOfWeek.Wednesday) && pattern_week[2].Equals(true) ||
                        INFO.DayOfWeek.Equals(DayOfWeek.Thursday) && pattern_week[3].Equals(true) ||
                        INFO.DayOfWeek.Equals(DayOfWeek.Friday) && pattern_week[4].Equals(true) ||
                        INFO.DayOfWeek.Equals(DayOfWeek.Saturday) && pattern_week[5].Equals(true) ||
                        // 20240311 김재강 : 일요일 선택가능하도록 변경함에 따른 코드 추가
                        INFO.DayOfWeek.Equals(DayOfWeek.Sunday) && pattern_week[6].Equals(true))

                    {
                        for (int i = 0; i < model.PatternCollection.Count(); i++)
                        {
                            if (model.PatternCollection[i].EventDate.Equals(INFO))
                                model.PatternCollection.RemoveAt(i);
                        }

                        model.PatternCollection.Add(new CustomDateInfo(INFO, cbx_Schd_Code.SelectedText, cbx_Schd_Code.SelectedIndex));
                    }
                }
            }

            //패턴 삭제
            if (s.Equals("D"))
            {
                foreach (DateTime INFO in calYear.SelectedDates)
                {
                    for (int i = 0; i < model.PatternCollection.Count(); i++)
                    {
                        if (INFO.Equals(model.PatternCollection[i].EventDate))
                            model.PatternCollection.Remove(model.PatternCollection[i]);
                    }
                }
            }
        }

        /// <summary>
        /// name         : Control_Checked
        /// desc         : Checked 처리 Event
        /// author       : kimchihwan 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_Checked(object sender)
        {
            if (sender.Equals(chk_NSP_Batch))
            {
                DataInit(1);
                ucPACodeAsk_NSP_Medr1.PassingReference = String.Empty;

                if (chk_NSP_Batch.IsChecked == true)
                {
                    this.tvMedTree2.Visibility = System.Windows.Visibility.Collapsed;
                    this.tvMedTree3.Visibility = System.Windows.Visibility.Visible;
                }
                else
                {
                    this.tvMedTree2.Visibility = System.Windows.Visibility.Visible;
                    this.tvMedTree3.Visibility = System.Windows.Visibility.Collapsed;
                }
            }
        }
        /// <summary>
        /// name         : 비정규예약 컨트롤초기화
        /// desc         : 컨트롤초기화
        /// author       : 송민수 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void CostRegularReservationControlInit()
        {
            pacaCrrMeddr.SelectedTextCode = null;

            txtNedAm1.Text = "0";
            txtNedAm1.IsEnabled = false;
            txtNedAm2.Text = "0";
            txtNedAm2.IsEnabled = false;
            // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 퇴원환자에 대한 추가 로직 삭제
            //txtNedAm3.Text = "0";
            //txtNedAm3.IsEnabled = false;
            txtNedAm4.Text = "0";
            txtNedAm4.IsEnabled = false;
            txtNedAm52.Text = "0";
            txtNedAm52.IsEnabled = false;
            txtNedAm53.Text = "0";
            txtNedAm53.IsEnabled = false;
            txtNedAm54.Text = "0";
            txtNedAm54.IsEnabled = false;
            txtNedAm55.Text = "0";
            txtNedAm55.IsEnabled = false;
            txtNedAm56.Text = "0";
            txtNedAm56.IsEnabled = false;
            txtNedAm57.Text = "0";
            txtNedAm57.IsEnabled = false;

            txtNedPm1.Text = "0";
            txtNedPm1.IsEnabled = false;
            txtNedPm2.Text = "0";
            txtNedPm2.IsEnabled = false;
            // 2019.03.06 퇴원환자 외래 진료예약 개선 방안 - 퇴원환자에 대한 추가 로직 삭제
            //txtNedPm3.Text = "0";
            //txtNedPm3.IsEnabled = false;
            txtNedPm4.Text = "0";
            txtNedPm4.IsEnabled = false;
            txtNedPm52.Text = "0";
            txtNedPm52.IsEnabled = false;
            txtNedPm53.Text = "0";
            txtNedPm53.IsEnabled = false;
            txtNedPm54.Text = "0";
            txtNedPm54.IsEnabled = false;
            txtNedPm55.Text = "0";
            txtNedPm55.IsEnabled = false;
            txtNedPm56.Text = "0";
            txtNedPm56.IsEnabled = false;
            txtNedPm57.Text = "0";
            txtNedPm57.IsEnabled = false;

            txtNedAm62.Text = "0";
            txtNedAm62.IsEnabled = false;
            txtNedAm63.Text = "0";
            txtNedAm63.IsEnabled = false;
            txtNedAm64.Text = "0";
            txtNedAm64.IsEnabled = false;
            txtNedAm65.Text = "0";
            txtNedAm65.IsEnabled = false;
            txtNedAm66.Text = "0";
            txtNedAm66.IsEnabled = false;
            txtNedAm67.Text = "0";
            txtNedAm67.IsEnabled = false;

            txtNedPm62.Text = "0";
            txtNedPm62.IsEnabled = false;
            txtNedPm63.Text = "0";
            txtNedPm63.IsEnabled = false;
            txtNedPm64.Text = "0";
            txtNedPm64.IsEnabled = false;
            txtNedPm65.Text = "0";
            txtNedPm65.IsEnabled = false;
            txtNedPm66.Text = "0";
            txtNedPm66.IsEnabled = false;
            txtNedPm67.Text = "0";
            txtNedPm67.IsEnabled = false;

            txtReqMemo.Text = "";
            txtReqMemo.IsEnabled = false;
        }

        /// <summary>
        /// name         : 비정규예약 데이터그리드 더블클릭이벤트
        /// desc         : 텍스트박스에 값채우기.
        /// author       : 송민수 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void dgrd5_MouseDoubleClickControl()
        {

            //if (dgrd5.SelectedItem != null)
            //{

            //    temp = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem);

            //    txtNedAm1.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_1.ToString();
            //    txtNedAm1.IsEnabled = true;
            //    txtNedAm2.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_2.ToString();
            //    txtNedAm2.IsEnabled = true;
            //    txtNedAm3.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_3.ToString();
            //    txtNedAm3.IsEnabled = true;
            //    txtNedAm4.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_4.ToString();
            //    txtNedAm4.IsEnabled = true;
            //    txtNedAm52.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_5_MON.ToString();
            //    txtNedAm52.IsEnabled = true;
            //    txtNedAm53.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_5_TUE.ToString();
            //    txtNedAm53.IsEnabled = true;
            //    txtNedAm54.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_5_WED.ToString();
            //    txtNedAm54.IsEnabled = true;
            //    txtNedAm55.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_5_THR.ToString();
            //    txtNedAm55.IsEnabled = true;
            //    txtNedAm56.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_5_FRI.ToString();
            //    txtNedAm56.IsEnabled = true;
            //    txtNedAm57.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_5_SAT.ToString();
            //    txtNedAm57.IsEnabled = true;

            //    txtNedPm1.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_1.ToString();
            //    txtNedPm1.IsEnabled = true;
            //    txtNedPm2.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_2.ToString();
            //    txtNedPm2.IsEnabled = true;
            //    txtNedPm3.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_3.ToString();
            //    txtNedPm3.IsEnabled = true;
            //    txtNedPm4.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_4.ToString();
            //    txtNedPm4.IsEnabled = true;
            //    txtNedPm52.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_5_MON.ToString();
            //    txtNedPm52.IsEnabled = true;
            //    txtNedPm53.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_5_TUE.ToString();
            //    txtNedPm53.IsEnabled = true;
            //    txtNedPm54.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_5_WED.ToString();
            //    txtNedPm54.IsEnabled = true;
            //    txtNedPm55.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_5_THR.ToString();
            //    txtNedPm55.IsEnabled = true;
            //    txtNedPm56.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_5_FRI.ToString();
            //    txtNedPm56.IsEnabled = true;
            //    txtNedPm57.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_5_SAT.ToString();
            //    txtNedPm57.IsEnabled = true;

            //    txtNedAm62.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_6_MON.ToString();
            //    txtNedAm62.IsEnabled = true;
            //    txtNedAm63.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_6_TUE.ToString();
            //    txtNedAm63.IsEnabled = true;
            //    txtNedAm64.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_6_WED.ToString();
            //    txtNedAm64.IsEnabled = true;
            //    txtNedAm65.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_6_THR.ToString();
            //    txtNedAm65.IsEnabled = true;
            //    txtNedAm66.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_6_FRI.ToString();
            //    txtNedAm66.IsEnabled = true;
            //    txtNedAm67.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).AM_6_SAT.ToString();
            //    txtNedAm67.IsEnabled = true;

            //    txtNedPm62.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_6_MON.ToString();
            //    txtNedPm62.IsEnabled = true;
            //    txtNedPm63.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_6_TUE.ToString();
            //    txtNedPm63.IsEnabled = true;
            //    txtNedPm64.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_6_WED.ToString();
            //    txtNedPm64.IsEnabled = true;
            //    txtNedPm65.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_6_THR.ToString();
            //    txtNedPm65.IsEnabled = true;
            //    txtNedPm66.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_6_FRI.ToString();
            //    txtNedPm66.IsEnabled = true;
            //    txtNedPm67.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).PM_6_SAT.ToString();
            //    txtNedPm67.IsEnabled = true;

            //    if (((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).RSV_ATNT_CNTE != null)
            //    {
            //        txtReqMemo.Text = ((MedDoctorScheduleRegistrationCostRegularReservation_INOUT)dgrd5.SelectedItem).RSV_ATNT_CNTE.ToString();

            //    }
            //    //txtReqMemo.IsEnabled = true;

            //    btn_Update.IsEnabled = true;


            //}

        }


        /// <summary>
        /// name         : 비정규예약 등록/수정 메소드
        /// desc         : 비정규예약 등록/수정.
        /// author       : 송민수 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void SaveACDPCAPD(String Meddept, String Medr_SID, String Meddr, String JobType, String Yoil, String AmCnt, String PmCnt)
        {
            model.InMedDoctorScheduleRegistrationSaveACDPCAPD.IN_MED_DEPT_CD = Meddept;
            model.InMedDoctorScheduleRegistrationSaveACDPCAPD.IN_MEDR_SID = Medr_SID;
            model.InMedDoctorScheduleRegistrationSaveACDPCAPD.IN_MEDR_STF_NO = Meddr;
            model.InMedDoctorScheduleRegistrationSaveACDPCAPD.IN_ADD_OTPT_RSV_TP_CD = JobType;
            model.InMedDoctorScheduleRegistrationSaveACDPCAPD.IN_MED_DOW_KND_CD = Yoil;
            model.InMedDoctorScheduleRegistrationSaveACDPCAPD.IN_AM_RSVP_PT_CNT = AmCnt;
            model.InMedDoctorScheduleRegistrationSaveACDPCAPD.IN_PM_RSVP_PT_CNT = PmCnt;

            model.SelMedDoctorScheduleRegistrationSaveACDPCAPD = (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "SelMedDoctorScheduleRegistrationSaveACDPCAPD", model.InMedDoctorScheduleRegistrationSaveACDPCAPD);

            //Insert
            if (model.SelMedDoctorScheduleRegistrationSaveACDPCAPD.Count == 0)
            {
                UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "InsertMedDoctorScheduleRegistrationSaveACDPCAPD", model.InMedDoctorScheduleRegistrationSaveACDPCAPD);

                //this.btn_Click(btnCrrSearch);
            }
            //Update
            else if (model.SelMedDoctorScheduleRegistrationSaveACDPCAPD.Count > 0)
            {
                UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL", "UpdateMedDoctorScheduleRegistrationSaveACDPCAPD", model.InMedDoctorScheduleRegistrationSaveACDPCAPD);
                //this.btn_Click(btnCrrSearch);

            }


        }

        /// <summary>
        /// name         : 링크모음 클릭
        /// desc         : 링크모음 클릭.
        /// author       : 송민수 
        /// create date  : 2012-09-14
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void AllLink(object sender)
        {

            string medr_stf_no = "";
            string med_dept_cd = "";
            string uri = "";

            PopUpBase pop = new PopUpBase();
            //일정등록
            if (tabMain.SelectedIndex.Equals(0))
            {
                medr_stf_no = ucPACodeAsk.SelectedTextCode;
                med_dept_cd = ucPACodeAsk.SelectedTextName3;

            }
            //휴진등록
            else if (tabMain.SelectedIndex.Equals(1))
            {
                medr_stf_no = ucPACodeAsk_NSP_Medr1.SelectedTextCode;
                med_dept_cd = ucPACodeAsk_NSP_Medr1.SelectedTextName3;
            }

            //대진등록
            else if (tabMain.SelectedIndex.Equals(2))
            {
                medr_stf_no = ucPACodeAsk_SFAD_Medr1.SelectedTextCode;
                med_dept_cd = ucPACodeAsk_SFAD_Medr1.SelectedTextName3;

            }
            //기타환자수등록
            else if (tabMain.SelectedIndex.Equals(3))
            {
                medr_stf_no = pacaCrrMeddr.SelectedTextCode;
                med_dept_cd = pacaCrrMeddr.SelectedTextName3;

            }

            if ((sender as HButton).Name == "btnScr") //기준등록
                uri = "AC_HIS.PA.AC.PE.SC.UI_/MedDoctorScheduleCriteriaRegistration";
            else if ((sender as HButton).Name == "btnSbm") //일괄작업
                uri = "AC_HIS.PA.AC.PE.SC.UI_/DoctorMedScheduleBatchMng";
            else if ((sender as HButton).Name == "btnSnm") //일정수정
                uri = "AC_HIS.PA.AC.PE.SC.UI_/DoctorMedScheduleNursingModification";
            else if ((sender as HButton).Name == "btnCall") //휴진일정조회
                uri = "AC_HIS.PA.AC.PE.SC.UI_/NotSeeingPatientsScheduleAsk.xaml";


            if (medr_stf_no.Length == 5 && !((sender as HButton).Name == "btnCall"))
                pop = base.OnLoadPopupMenu(uri, medr_stf_no, med_dept_cd);
            else
                pop = base.OnLoadPopupMenu(uri);

            pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            pop.Show();
            pop.Owner = Application.Current.MainWindow;
            pop.ShowInTaskbar = false;
        }

        /// <summary>
        /// name         : NspResChk
        /// desc         : 변경사유 99번시 권한체크
        /// author       : namdongkyun
        /// create date  : 2020-10-05 오후 5:29:13
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void NspResChk()
        {
            //원무사용자 외래예약권한 분류 조회
            model.SelectAcppricmInOutObj = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PE.SC.BIZ.DoctorMedScheduleNursingModificationBL", "SelAcppricmCheck", model.SelectAcppricmInOutObj) as CCCCCSTE_INOUT;


            if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "10" && model.SelectAcppricmInOutObj.DTRL2_NM != "A")
            {
                MsgBox.Display("권한이 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                ucPACodeAsk_SFAD_Rsn.SelectedTextCode = "";
                return;
            }


            if (tabMain.SelectedIndex.Equals(2))    //대진
            {
                //2020-11-10 남동균 예약제한코드개편건 추가반영 DK20201101
                if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "99")
                {
                    btnUpdNspRsnTpCd.Visibility = Visibility.Visible;
                }
                else if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "")
                {
                    btnUpdNspRsnTpCd.Visibility = Visibility.Collapsed;
                }
                else
                {
                    btnUpdNspRsnTpCd.Visibility = Visibility.Collapsed;
                    HReceiptPop.IsOpen = false;
                }
            }
            else if (tabMain.SelectedIndex.Equals(1))   //휴진
            {
                //2020-11-10 남동균 예약제한코드개편건 추가반영 DK20201101
                if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "99")
                {
                    btnUpdNspRsnTpCd.Visibility = Visibility.Visible;
                }
                else if (ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "")
                {
                    btnUpdNspRsnTpCd.Visibility = Visibility.Collapsed;
                }
                else
                {
                    btnUpdNspRsnTpCd.Visibility = Visibility.Collapsed;
                    HReceiptPop.IsOpen = false;
                }
            }
        }

        /// <summary>
        /// name         : 진료의요청사유 저장팝업닫기
        /// desc         : 진료의요청사유 저장팝업닫기
        /// author       : namdongkyun 
        /// create date  : 2020-08-25 10:23:12
        /// update date  : 2020-08-25 10:23:12, kimeunjung, 수정개요
        /// </summary>

        private void HReceiptPopClose()
        {
            HReceiptPop.IsOpen = false;
        }

        /// <summary>
        /// name         : 진료의요청사유 저장팝업열기
        /// desc         : 진료의요청사유 저장팝업열기
        /// author       : namdongkyun 
        /// create date  : 2020-08-25 10:23:12
        /// update date  : 2020-08-25 10:23:12, kimeunjung, 수정개요
        /// </summary>

        private void HReceiptPopOpen()
        {
            HReceiptPop.IsOpen = true;
            this.ucNSP_RSN_STF_NO.SelectedTextCodeFocus();
            this.ucNSP_RSN_STF_NO.SelectedTextCodeSelectAll();
        }

        /// <summary>
        /// name         : 진료의요청사유 저장
        /// desc         : 진료의요청사유 저장
        /// author       : namdongkyun 
        /// create date  : 2020-09-14 10:23:12
        /// update date  : 2020-09-14 10:23:12, kimeunjung, 수정개요
        /// </summary>

        private void HReceiptPopSave()
        {
            if (model.SelectAcppricmInOutObj.DTRL2_NM != "A" && ucPACodeAsk_SFAD_Rsn.SelectedTextCode == "10")
            {
                MsgBox.Display("권한이 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                ucPACodeAsk_SFAD_Rsn.SelectedTextCode = "";
                HReceiptPop.IsOpen = false;
                cboNSP_RSN_CNTE.SelectedIndex = 0;
                return;
            }
            var inModel = new SelMedScheduleAsk_IN();


            //if (model.SFAD_OUT.Count.Equals(0))
            //{
            //    MsgBox.Display("PAMVB_000168", MessageType.MSG_TYPE_INFORMATION, VariableMessages: new string[] { "조회된 데이터가 없습니다." }); // [{0}]
            //    return;
            //}

            if (string.IsNullOrEmpty(txtNSP_RSN_CNTE.Text) && !string.IsNullOrEmpty(ucNSP_RSN_STF_NO.SelectedTextCode))
            {
                MsgBox.Display("대진사유내용은 필수입니다", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNSP_RSN_CNTE.Text))
            {
                MsgBox.Display("휴진사유내용은 필수입니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                return;
            }

            if (Encoding.Default.GetBytes(txtNSP_RSN_CNTE.Text.Replace(" ", "")).Length < 3)
            {
                MsgBox.Display("휴진 사유 내용은 3바이트 이상 입력해야합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                return;
            }

            if (string.IsNullOrEmpty(ucNSP_RSN_STF_NO.SelectedTextName1) && !string.IsNullOrEmpty(txtNSP_RSN_CNTE.Text))
            {
                MsgBox.Display("대진사유요청 직원번호는 필수입니다", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                return;
            }

            if (string.IsNullOrEmpty(ucNSP_RSN_STF_NO.SelectedTextCode) && string.IsNullOrEmpty(txtNSP_RSN_CNTE.Text))
            {
                ucPACodeAsk_SFAD_Rsn.SelectedTextCode = "";
            }

            HReceiptPop.IsOpen = false;

        }

        /// <summary>
        /// name         : Control_SelectionChanged
        /// desc         : 각 SelectionChanged 이벤트 처리
        /// author       : namdongkyun
        /// create date  : 2021-08-02
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void Control_SelectionChanged2(object sender)
        {
            if (((HComboBox)sender).SelectedText == "기타") //기타
            {
                txtNSP_RSN_CNTE.IsEnabled = true;
                txtNSP_RSN_CNTE.Focus();

                txtNSP_RSN_CNTE.Text = "";
                //txtNSP_RSN_CNTE.SelectAll();
                //if (string.IsNullOrEmpty((dgrd_SFAD.SelectedItem as MedDoctorScheduleRegistration_SFAD_INOUT).NSP_RSN_CNTE))
                //    txtNSP_RSN_CNTE.Text = "";
            }
            else
            {
                txtNSP_RSN_CNTE.IsEnabled = false;
                txtNSP_RSN_CNTE.Text = ((HComboBox)sender).SelectedText;
            }
        }


        #endregion //Methods
    }
}