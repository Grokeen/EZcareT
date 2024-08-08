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
            this.calFromTo.FromDate = System.DateTime.Now.AddDays(-6);
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
            // 승인 버튼
            if (sender.Equals(btnConfirm))
            {
                MsgBox.Display("모바일하이패스를 승인하시겠습니까?", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);


                // 모바일하이패스 ASIS
                //참고 : pkg_bil_ocals.pc_ap_HipssMobileAprvList
                //참고 : PROCEDURE pc_ap_HipssMobileAprv_Upd 
                //참고 : D:\AS-IS소스_20231226\WEB\BIL\ACC\CALS\OCALS

                // answp !!!! 여러 개를 체크해서 한 번에 처리하는게 가능한가?




                // 변경되는 부분
                model.HipassMobile_GrUPDATE.HPCD_CNCL_RSN_CD = SessionManager.UserInfo.STF_NO;/*최종변경하는직원번호*/




                UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "UpdOtptPtReservationRegistration_update", model.HipassMobile_GrUPDATE);


                
            }
            // 취소 버튼
            if (sender.Equals(btnCancle))
            {
                MsgBox.Display("모바일하이패스를 취소하시겠습니까?", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);
                MsgBox.Display("모바일하이패스를 취소하시겠습니까?", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);

                // 체크박스에 맞는 애들을 불러와야 하는데
                //model.HipassMobile_GrUPDATE.PT_NO = 
                //model.HipassMobile_GrUPDATE.APY_STR_DT =
                //model.HipassMobile_GrUPDATE.TKN_NO = 



                // 변경되는 부분
                model.HipassMobile_GrUPDATE.HPCD_CNCL_RSN_CD = "97516";/*최종변경하는직원번호*/
                model.HipassMobile_GrUPDATE.HPCD_CNCL_RSN_CD = "09";/* 취소사유(09 : 모바일원무과승인거절)*/
                model.HipassMobile_GrUPDATE.CNCL_DT = DateTime.Now.ToString("yyyy-MM-dd"); /* 취소날짜 */



                UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "UpdOtptPtReservationRegistration_update", model.HipassMobile_GrUPDATE);

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
            //if (sender.Equals(btnExcel))
            //{
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
            //}


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
