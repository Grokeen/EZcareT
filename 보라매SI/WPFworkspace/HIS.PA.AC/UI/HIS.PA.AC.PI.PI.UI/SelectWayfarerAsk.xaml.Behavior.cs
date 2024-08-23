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
using HIS.PA.AC.PI.PI.DTO.SelectWayfarerAsk;
using HIS.Core.Global.DTO.CommonLogging;// 엑셀
using HIS.UI.CoreWork.Log;              // 엑셀
using HIS.UI.Utility.Extension;         // 엑셀

namespace HIS.PA.AC.PI.PI.UI
{
    /// <summary>
    /// name         : #SelectWayfarerAsk Behavior 클래스
    /// desc         : #SelectWayfarerAsk Behavior 클래스
    /// author       : JaeGang 
    /// create date  : 2024-08-08 오전 11:10:10
    /// update date  : 
    /// </summary>
    public partial class SelectWayfarerAsk
    {
        #region [Consts]
        /// <summary>
        /// Biz 클래스명
        /// </summary>
        private const string BIZ_CLASS = "HIS.PA.AC.PI.PI.BIZ.SelectWayfarerAskBL";
        #endregion //Consts



        #region [Dependency Properties]
        #endregion //Dependency Properties



        #region [Member Variables]
        /// <summary>
        /// 프레젠테이션 모델(PM) 
        /// </summary>
        private SelectWayfarerAskData model;
        #endregion //Member Variables



        #region [Properties]
        #endregion //Properties



        #region [컨트롤 초기화]
        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : 컨트롤 초기화
		/// desc         : UI에서 사용할 컨트롤을 초기화 함
		/// author       : JaeGang
		/// create date  : 2024-08-08 오전 11:10:10
		/// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void ControlInit()
        {
            // 테스트 환자번호 : 01626383 //-------------------------------------------------------------------------
            // 테스트 날짜 : -12년
            this.calFromTo.FromDate = System.DateTime.Now.AddYears(-12);
            this.calFromTo.ToDate = System.DateTime.Now;
        }
        #endregion //컨트롤 초기화

        #region [데이타초기화(공통코드)]
        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : 데이터 초기화
		/// desc         : 화면 로드시 데이터를 초기화 함
		/// author       : JaeGang 
		/// create date  : 2024-08-08 오전 11:10:10
		/// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void DataInit()
        {
            model.SelectWayfarerAsk_GrOUT = new HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT>();

            // TODO : 환자번호 초기화 필요
        }
        #endregion //데이타초기화(공통코드)

        #region [Methods]
        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : 데이터 조회
        /// desc         : 데이터를 조회함
        /// author       : JaeGang 
        /// create date  : 2024-08-08 오전 11:10:10
        /// update date  :  
        /// </summary>
        /// ---------------------------------------------------------------------
        private void SelectData()
        {
            if (String.IsNullOrEmpty(this.calFromTo.ToDate.ToString()) || String.IsNullOrEmpty(this.calFromTo.FromDate.ToString()))
            {
                MsgBox.Display("PAMCN_001774", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                this.calFromTo.IsFocusToDate = true;
                return;
            }
            model.SelectWayfarerAsk_GrIN.IN_PT_NO = ucPt_no.SelectedTextCode;
            model.SelectWayfarerAsk_GrIN.IN_FROM_DATE = (this.calFromTo.FromDate.ToString().Substring(0, 10).Replace("-", ""));
            model.SelectWayfarerAsk_GrIN.IN_TO_DATE = (this.calFromTo.ToDate.ToString().Substring(0, 10).Replace("-", ""));

            model.SelectWayfarerAsk_GrOUT = (HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectWayfarerAskBL_GrSelect", model.SelectWayfarerAsk_GrIN);

            if (model.SelectWayfarerAsk_GrOUT.Count == 0)
            {
                MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }
            else
            {
                MsgBox.Display("데이터가 조회되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }


        }


        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectWayfarerAsk
        /// desc         : 엑셀
        /// author       : 김용록 
        /// create date  : 2024-08-14 오전 11:10:10
        /// update date  :  
        /// </summary>
        /// ---------------------------------------------------------------------
        private void Excel()
        {
            if (model.SelectWayfarerAsk_GrOUT.Count < 1)
            {
                MsgBox.Display("PAMCN_000470", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                return;
            }
            else
            {
                var excelDownloadLog = new DownloadPrint_IN()
                {
                    MenuID = "AC_HIS.PA.AC.PI.PI.UI_/SelectWayfarerAsk.xaml",
                    MenuName = "행려환자내역조회(원무)",
                    Data = grdList,
                    ExportType = DownloadPrint_IN.DownloadPrintType.Excel
                };

                if (!LoggingReasonHelper.InsertDownloadPrintLog(excelDownloadLog))
                {
                    return;
                }
                else
                {
                    grdList.ToExcel("행려환자내역조회", "", true, false, 1, 1);
                }
            }
        }

        #endregion //Methods
    }
}
