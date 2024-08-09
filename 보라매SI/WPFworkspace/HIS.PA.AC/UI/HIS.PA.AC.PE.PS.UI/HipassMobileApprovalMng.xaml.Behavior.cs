using HIS.PA.AC.PE.PS.DTO;
using HIS.UI.Base;
using HIS.UI.Core;
using HSF.TechSvc2010.Common;
using System;
using System.Linq;
using System.Windows;


using HIS.UI.Core.Individuality;

using System.Collections.Generic;
using System.ComponentModel;
using System.Text;

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

using HIS.UI.Utility.Extension;


using HIS.UI.Controls;
using HIS.UI.Utility;

using System.Diagnostics;

using HIS.UI.Controls.Extension;
using HIS.PA.CORE.UI.UTIL;



namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : HipassMobileApprovalMng Behavior 클래스
    /// desc         : HipassMobileApprovalMng Behavior 클래스
    /// author       : 김영럭 
    /// create date  : 2024-07-10 오전 9:17:34
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class HipassMobileApprovalMng
    {
        #region [Consts]

        private const string BIZ_CLASS = "HIS.PA.AC.PE.PS.BIZ.HipassMobileApprovalMngBL";


        private void ControlInit()
        {
            // 화면 실행 시, 조회기간 초기화
            this.calFromTo.FromDate = System.DateTime.Now.AddDays(-14);
            this.calFromTo.ToDate = System.DateTime.Now;
        }
        #endregion //Consts


        #region [Dependency Properties]
        private HipassMobileApprovalMngData model;
        DateTime nowDate = DateTime.Now;
        #endregion //Dependency Properties


        #region [Member Variables]
        #endregion


        #region [Methods]
        private void HipassSearch()
        {
            // 조회기간을 입력하십시오.
            if (String.IsNullOrEmpty(this.calFromTo.ToDate.ToString()) || String.IsNullOrEmpty(this.calFromTo.FromDate.ToString()))
            {
                MsgBox.Display("PAMCN_001774", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                this.calFromTo.IsFocusToDate = true;
                return;
            }


            model.HipassMobile_GrIN.IN_FROM_DATE = (this.calFromTo.FromDate.ToString().Substring(0, 10).Replace("-", ""));
            model.HipassMobile_GrIN.IN_TO_DATE = (this.calFromTo.ToDate.ToString().Substring(0, 10).Replace("-", ""));



            try
            {
                // Radio 승인. 취소, 미승인 선택 없이 NULL 값을 보내면 = '전체조회'
                model.HipassMobile_GrIN.IN_HPCD_CNCL_RSN_CD = (rbtFrvs.SelectedItem as RadioButtonListItem).Tag.ToString();


            }
            catch (Exception e) {
                // 전체 조회
                model.HipassMobile_GrIN.IN_HPCD_CNCL_RSN_CD = "A";
            }

            model.HipassMobile_GrOUT = (HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "HipassMobileApprovalMng_GrDateAV", model.HipassMobile_GrIN);

            // RegisterShowBusyIndicator("처리 중입니다.");


            if (model.HipassMobile_GrOUT.Count == 0)
            {
                MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }
            else {
                MsgBox.Display("데이터가 조회되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }

        }




        private void GRbtn_Click(object sender)
        {
            /* --------------------------------------------------------------- */
               // 승인/취소 버튼
            if (sender.Equals(btnCancle) || sender.Equals(btnConfirm))
            {
                IList<HipassMobileApprovalMng_OUT> check_GrItems = grdList.SelectedItems.Cast<HipassMobileApprovalMng_OUT>().ToList();

                if (sender.Equals(btnCancle)) {
                    MsgBox.Display("모바일하이패스를 취소하시겠습니까?", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);
                } else if (sender.Equals(btnConfirm)) {
                    MsgBox.Display("모바일하이패스를 승인하시겠습니까?", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);
                }

                foreach (HipassMobileApprovalMng_OUT item in check_GrItems) {
                    // 여러개를 한 번에 돌리면 안돼서 임시 예외처리, 없이는 하나 값 만 변경됩니다. (error : 0 테이블을 찾을 수 없습니다.)
                    try
                    {

                        model.HipassMobile_GrUPDATE.IN_PT_NO = item.PT_NO;
                        model.HipassMobile_GrUPDATE.IN_APY_STR_DT = item.APY_STR_DT;
                        model.HipassMobile_GrUPDATE.IN_TKN_NO = item.TKN_NO;
                        model.HipassMobile_GrUPDATE.IN_LSH_STF_NO = SessionManager.UserInfo.STF_NO;/*최종변경하는직원번호*/
                        //model.HipassMobile_GrUPDATE.IN_LSH_STF_NO = "EZTST";
                        if (sender.Equals(btnCancle))
                        {
                            model.HipassMobile_GrUPDATE.IN_HPCD_CNCL_RSN_CD = "09";
                            model.HipassMobile_GrUPDATE.IN_CNCL_DT = DateTime.Now.ToString("yyyy-MM-dd");
                        }

                        UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "HipassMobileApprovalMng_UpdateYR", model.HipassMobile_GrUPDATE);
                    } catch(Exception e) { 
                
                    }

                }

                
                HipassSearch();
            }



            /* --------------------------------------------------------------- */
            // 알림톡 버튼
            if (sender.Equals(btnAlarm))
            {

            }


            /* --------------------------------------------------------------- */
            // 초기화 버튼
            if (sender.Equals(btnFormat))
            {

            }


            /* --------------------------------------------------------------- */
            // 엑셀 버튼
            if (sender.Equals(btnExcel))
            {
            //    //this.dgrdMain.ToExcel("과별예약현황", "", true, false, 1, 1);
            //    #region 다운로드/출력 로그 설정                
            //    var excelDownloadLog = new DownloadPrint_IN()
            //    {
            //        MenuID = "AC_HIS.PA.AC.PE.PS.UI_/MedicalTreDeptClassByOutPatientResvPatientCntAsk",
            //        MenuName = "모바일하이패스",
            //        Data = dgrdMain,
            //        ExportType = DownloadPrint_IN.DownloadPrintType.Excel
            //    };

            //    if (!LoggingReasonHelper.InsertDownloadPrintLog(excelDownloadLog))
            //    {
            //        return;
            //    }
            //    else
            //    {
            //        this.dgrdMain.ToExcel("과별예약현황", "", true, false, 1, 1);
            //    }
            //    #endregion
            }


            /* --------------------------------------------------------------- */
            //닫기 버튼
            if (sender.Equals(btnClose))
            {
                this.Close();
            }

        }



        #endregion //Methods
    }
}
