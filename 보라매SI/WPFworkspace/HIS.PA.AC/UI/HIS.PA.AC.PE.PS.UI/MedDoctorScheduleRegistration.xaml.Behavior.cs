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

using HIS.PA.AC.PE.PS.DTO;
//using HIS.PA.AC.PE.SC.DTO;
using HIS.Core.Global.DTO;
using HIS.PA.CORE.UI.UTIL;
using HIS.PA.CORE.DTO;
//using HIS.PA.AC.PE.SC.UI;
//using Infragistics.Windows.Editors;
using HSF.Controls.WPF.Calendars;
using HSF.Controls.WPF.Enums;
using System.Collections.ObjectModel;
//using HSF.Controls.WPF.Extension.CalendarEx;
using HSF.Controls.WPF.DataManager.Calendars;
//using Infragistics.Controls.Editors;
using Infragistics.Collections;
using Infragistics;
using HIS.UI.Utility.Extension;
using HIS.Core.Global.DTO.CommonLogging;
using HIS.UI.CoreWork.Log;
using System.Globalization;
using Calendar = System.Globalization.Calendar;
//using HIS.PA.AC.PE.SC.DTO.NotSeeingPatientsScheduleAsk;



using System.Text.RegularExpressions;

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : MedDoctorScheduleRegistration Behavior 클래스
    /// desc         : MedDoctorScheduleRegistration Behavior 클래스
    /// author       : EZCARE 
    /// create date  : 2024-10-01 오전 11:28:32
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class MedDoctorScheduleRegistration
    {
        #region [Consts]

        #endregion //Consts

        private MedDoctorScheduleRegistrationData model;

        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectPlusWork
        /// desc         : 조회
        /// author       : 김용록
        /// create date  : 2024-09-25
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void SelectPlusWork()
        {
            if (String.IsNullOrEmpty(SelectedTextCode.Text))
            { // 진짜 진료의 정보 // ucPACodeAsk_PLUS_Medr1.SelectedTextCode
                MsgBox.Display("직원번호를 확인해주세요.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                return;
            }

            string BIZ_addr = "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL";
            model.SelectDrPlusWork_OUT = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>();
            model.SelectDrPlusWork_IN = new MedDoctorScheduleRegistration_PlusWork_INOUT();

            model.SelectDrPlusWork_IN.IN_DR_STF_NO = SelectedTextCode.Text;
            //진짜 진료의 정보
            //model.SelectDrPlusWork_IN.IN_DR_STF_NO = ucPACodeAsk_PLUS_Medr1.SelectedTextCode;

            model.SelectDrPlusWork_IN.IN_CHECKED_ALL = check_All.IsChecked == true ? "ALL" : null;

            model.SelectDrPlusWork_OUT = UIMiddlewareAgent.InvokeBizService(this, BIZ_addr, "SelectDoctorPlusWorkBIZ", model.SelectDrPlusWork_IN) as HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>;



            if (model.SelectDrPlusWork_OUT.Count < 1) MsgBox.Display("조회된 정보가 없습니다.", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            else
            {
                
                //model.SelectDrPlusWork_OUT
                MsgBox.Display("조회되었습니다.", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);

            }

        }

        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : ModifyPlusWork
        /// desc         : 보충진료등록 신규/수정/삭제
        /// author       : 김용록
        /// create date  : 2024-10-01
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void ModifyPlusWork(object sender, string yrin_type) 
        {
            List<MedDoctorScheduleRegistration_PlusWork_INOUT> Modify_GRdata = yrdList.SelectedItems.Cast<MedDoctorScheduleRegistration_PlusWork_INOUT>().ToList();
            string BIZ_addr = "HIS.PA.AC.PE.SC.BIZ.MedDoctorScheduleRegistrationBL";

            model.UpdateDrPlusWork.IN_TYPE = yrin_type; /* 신규/수정/삭제 구분 */
            //model.UpdateDrPlusWork.IN_DR_STF_NO = ucPACodeAsk_PLUS_Medr1.SelectedTextCode;          /* 의사직원번호 */
            //model.UpdateDrPlusWork.IN_DR_SID = ucPACodeAsk_PLUS_Medr1.SelectedTextName1;         /* 의사직원식별ID */
            //model.UpdateDrPlusWork.IN_MED_DEPT_CD = ucPACodeAsk_PLUS_Medr1.SelectedTextName3;         /* 진료부서코드 */
            model.UpdateDrPlusWork.IN_APY_STR_DTM = model.UpdateDrPlusWork.IN_OLD_LSH_DTM = string.Format("{0:yyyyMMddHHmm}", this.PlusWorkCal.FromDate);  /* 적용시작일시(*NOT NULL) */
            model.UpdateDrPlusWork.IN_APY_END_DTM = model.UpdateDrPlusWork.IN_OLD_LSH_DTM = string.Format("{0:yyyyMMddHHmm}", this.PlusWorkCal.ToDate);    /* 적용종료일시(*NOT NULL) */

            /* 오전/오후 구분 */
            if (tm_unit_cd1.IsChecked == true) model.UpdateDrPlusWork.IN_TM_UNIT_CD = "AP";
            else if (am_unit_cd2.IsChecked == true) model.UpdateDrPlusWork.IN_TM_UNIT_CD = "AM";
            else if (pm_unit_cd3.IsChecked == true) model.UpdateDrPlusWork.IN_TM_UNIT_CD = "PM";

            model.UpdateDrPlusWork.IN_SPLM_MED_TM = gr_splm_med_tm.Text;     /* 총보충시간 */
            model.UpdateDrPlusWork.IN_SUP_MEMO = gr_sup_memo.Text;           /* 보충메모 */

            /* 수정/삭제 묶음 처리 */
            if ((yrin_type == "2" || yrin_type == "3") && Modify_GRdata.Count > 1)
            {
                foreach (MedDoctorScheduleRegistration_PlusWork_INOUT Item in Modify_GRdata)
                {
                    model.UpdateDrPlusWork = new MedDoctorScheduleRegistration_PlusWork_UPDATE();

                    try
                    {
                        model.UpdateDrPlusWork.IN_TYPE = yrin_type; /* 신규/수정/삭제 구분 */
                        //model.UpdateDrPlusWork.IN_DR_STF_NO = ucPACodeAsk_PLUS_Medr1.SelectedTextCode;          /* 의사직원번호 */

                        // 확인 필요 string 으로 가져올 때 형식 'YYYY-MM-DD AM HH12:MI'
                        model.UpdateDrPlusWork.IN_APY_STR_DTM = model.UpdateDrPlusWork.IN_OLD_LSH_DTM = string.Format("{0:yyyyMMddHHmm}", Item.APY_STR_DTM);    /* 적용시작일시(*NOT NULL) */
                        model.UpdateDrPlusWork.IN_APY_END_DTM = model.UpdateDrPlusWork.IN_OLD_LSH_DTM = string.Format("{0:yyyyMMddHHmm}", Item.APY_END_DTM);    /* 적용종료일시(*NOT NULL) */

                        model.UpdateDrPlusWork.IN_TM_UNIT_CD = Item.TM_UNIT_CD;          /* 오전/오후 구분 */
                        model.UpdateDrPlusWork.IN_SPLM_MED_TM = Item.SPLM_MED_TM;        /* 보충시간 */
                        model.UpdateDrPlusWork.IN_SUP_MEMO = Item.SUP_MEMO;              /* 보충메모 */  
                        model.UpdateDrPlusWork.IN_OLD_APY_STR_DTM = Item.OLD_APY_STR_DTM;
                        model.UpdateDrPlusWork.IN_OLD_APY_END_DTM = Item.OLD_APY_END_DTM;

                        // 확인 필요 string 으로 가져올 때 형식 'YYYY-MM-DD AM HH12:MI'
                        model.UpdateDrPlusWork.IN_OLD_LSH_DTM = string.Format("{0:yyyyMMddHHmm}", Item.LSH_DTM);

                        UIMiddlewareAgent.InvokeBizService(this, BIZ_addr, "InsertDoctorPlusWorkBIZ", model.UpdateDrPlusWork);
                    }
                    catch (Exception e)
                    {
                        MsgBox.Display(e + "업데이트 중 에러가 발생했습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                        break;
                    }

                }
            }
            else 
            {
                UIMiddlewareAgent.InvokeBizService(this, BIZ_addr, "InsertDoctorPlusWorkBIZ", model.UpdateDrPlusWork);
            }


            SelectPlusWork();

            string messagetype = sender.Equals(btn_Update) ? "수정" : sender.Equals(btn_Delete) ? "삭제" : "저장";
            MsgBox.Display(messagetype+"되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);

            
        }
    

        private void btn_Click(object sender)
        {
            //엑셀
            if (sender.Equals(btn_Excel))
            {
                //보충등록(2024-10-01 김용록 : 보충진료등록 추가)
                if (tabMain.SelectedIndex.Equals(3))
                {
                    if (model.SelectDrPlusWork_OUT.Count < 1)
                    {
                        MsgBox.Display("PAMCN_000470", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                        return;
                    }
                    else
                    {
                        var excelDownloadLog = new DownloadPrint_IN()
                        {
                            MenuID = "AC_HIS.PA.AC.PE.SC.UI_/MedDoctorScheduleRegistration.xaml",
                            MenuName = "의사진료일정등록(보충진료등록)(원무)",
                            Data = yrdList,
                            ExportType = DownloadPrint_IN.DownloadPrintType.Excel
                        };

                        if (!LoggingReasonHelper.InsertDownloadPrintLog(excelDownloadLog))
                        {
                            return;
                        }
                        else
                        {
                            yrdList.ToExcel("의사진료일정등록", (System.DateTime.Now).ToString("yyyymmdd") + "_보충진료등록", true, false, 1, 1, false, false);
                        }
                    }

                }
            }


            //수정
            if (sender.Equals(btn_Update))
            {
                //보충등록(2024-10-01 김용록 : 보충진료등록 추가)
                if (tabMain.SelectedIndex.Equals(3))
                {
                    ModifyPlusWork(sender, "2");
                }
            }
            //삭제
            if (sender.Equals(btn_Delete))
            {
                //보충등록(2024-10-01 김용록 : 보충진료등록 추가)
                if (tabMain.SelectedIndex.Equals(3))
                {
                    ModifyPlusWork(sender, "3");
                }
            }
            //저장
            if (sender.Equals(btn_Save))
            {
                //보충등록(2024-09-25 김용록 : 보충진료등록 추가)
                if (tabMain.SelectedIndex.Equals(3))
                {
                    ModifyPlusWork(sender, "1");

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



        }


    }
}
