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
    /// author       : JaeGang 
    /// create date  : 2023-12-26 오전 9:17:34
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class HipassMobileApprovalMng
    {
        #region [Consts]

        private const string BIZ_CLASS = "HIS.PA.AC.PE.PS.BIZ.HipassMobileApprovalMngBL";


        private void ControlInit()
        {

            this.calFromTo.FromDate = CommonServiceAgent.SelectSysDate();
            this.calFromTo.ToDate = CommonServiceAgent.SelectSysDate();
        }
        #endregion //Consts


            #region [Dependency Properties]
            #endregion //Dependency Properties
        private HipassMobileApprovalMngData model;
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

            // IN 리스트에 넣은 값을 담아 보내서 OUT 리스트에 담는다.
            model.HipassMobile_GrOUT = (HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "HipassMobileApprovalMng_GrDateAV", model.HipassMobile_GrIN);

            //RegisterShowBusyIndicator("처리 중입니다.");

            // 데이터 없을 시
            if (model.HipassMobile_GrOUT.Count == 0)
            {
                MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                return;
            }

        }

        private void GRbtn_Click(object sender)
        {
            /* --------------------------------------------------------------- */
            // 조회 버튼
            if (sender.Equals(btnSearch))
            {
                HipassSearch();
            }



            /* --------------------------------------------------------------- */
            //승인 상태 체크박스
            //if (sender.Equals(CheckBoxConfirm_YN))
            //{

            //}



            /* --------------------------------------------------------------- */
            // 승인 버튼
            if (sender.Equals(btnConfirm))
            {

            }


            /* --------------------------------------------------------------- */
            // 취소 버튼
            if (sender.Equals(btnCancle))
            {

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
