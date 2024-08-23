using HIS.PA.AC.PE.PS.DTO;
using HIS.Core.Global.DTO.CommonLogging;// 엑셀
using HIS.UI.CoreWork.Log;              // 엑셀
using HIS.UI.Utility.Extension;         // 엑셀
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


using HIS.UI.Controls;
using HIS.UI.Utility;

using System.Diagnostics;

using HIS.UI.Controls.Extension;
using HIS.PA.CORE.UI.UTIL;



namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : HipassMobileApprovalMng Behavior
    /// desc         : HipassMobileApprovalMng Behavior 클래스
    /// author       : 김용록
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
        /// <summary>
        /// name         : 모바일하이패스
        /// desc         : 모바일하이패스 조회
        /// author       : 김용록
        /// create date  : 2024-07-10 오전 9:17:34
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
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

            
            model.HipassMobile_GrIN.IN_HPCD_CNCL_RSN_CD = (rbtFrvs.SelectedItem as RadioButtonListItem).Tag.ToString();
            
            
            model.HipassMobile_GrOUT = (HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "HipassMobileApprovalMng_GrDateAV", model.HipassMobile_GrIN);

            // RegisterShowBusyIndicator("처리 중입니다.");

            if (model.HipassMobile_GrOUT.Count == 0)
            {
                MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }
            else
            {
                MsgBox.Display("데이터가 조회되었습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }

        }
        

        /// <summary>
        /// name         : 모바일하이패스
        /// desc         : 모바일하이패스 UPDATE에 필요한 데이터 검증(예외 시, 동작)
        /// author       : 김용록
        /// create date  : 2024-07-10 오전 9:17:34
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void verificationValue (Exception e, HipassMobileApprovalMng_UPDATE sender)
        {
            String conmentError = String.Empty;
            conmentError += "현재 <";
            if (model.HipassMobile_GrUPDATE.HIS_IP_ADDR is null)
            {
                conmentError += "사용하는IP주소 ";
            }
            if (model.HipassMobile_GrUPDATE.HIS_PRGM_NM is null)
            {
                conmentError += "프로그램명 ";
            }
            if (model.HipassMobile_GrUPDATE.HIS_STF_NO is null)
            {
                conmentError += "직원번호 ";
            }
            if (sender.Equals(btnCancle)) { 
                if (model.HipassMobile_GrUPDATE.IN_HPCD_CNCL_RSN_CD is null)
                {
                    conmentError += "취소코드 ";
                }
                if (model.HipassMobile_GrUPDATE.IN_CNCL_DT is null)
                {
                    conmentError += "취소날짜 ";
                }
            }
            if (model.HipassMobile_GrUPDATE.IN_PT_NO is null)
            {
                conmentError += "환자번호 ";
            }
            if (model.HipassMobile_GrUPDATE.IN_APY_STR_DT is null)
            {
                conmentError += "하이패스시작일 ";
            }
            if (model.HipassMobile_GrUPDATE.IN_TKN_NO is null)
            {
                conmentError += "하이패스토큰번호 ";
            }

            conmentError +="등> 정보를 못찾고 있습니다. 잠시후 다시 시도해주세요. 같은 문제가 반복된다면 관리자에게 문의해주세요.";

            MsgBox.Display(conmentError+ Environment.NewLine + Environment.NewLine + e, MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
        }


        /// <summary>
        /// name         : 모바일하이패스
        /// desc         : 모바일하이패스 승인/취소 UPDATE
        /// author       : 김용록
        /// create date  : 2024-07-10 오전 9:17:34
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void GRbtn_Click(object sender)
        {     
            IList<HipassMobileApprovalMng_OUT> check_GrItems = grdList.SelectedItems.Cast<HipassMobileApprovalMng_OUT>().ToList();
            String verificationValueCh = String.Empty;
            if (check_GrItems.Count < 1)
            {
                MsgBox.Display("화면에서 체크하셨는지 확인 후, 다시 눌러주세요.", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }
            else {
                if (sender.Equals(btnCancle))
                {
                    MsgBox.Display("모바일하이패스를 취소하시겠습니까?", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);
                }
                else if (sender.Equals(btnConfirm))
                {
                    MsgBox.Display("모바일하이패스를 승인하시겠습니까?", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OKCancel);
                }
                foreach (HipassMobileApprovalMng_OUT item in check_GrItems)
                {
                    if (item.SMSS_PSB_YN != "Y" && sender.Equals(btnCancle))
                    {
                        MsgBox.Display(item.PT_NO + "(" + item.PT_NM + ") 는(은) 이미 취소되어 있어 변경할 수 없습니다. 다시 확인해주세요.", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                        verificationValueCh = "Stop";
                        break;
                    }
                    else if (item.SMSS_PSB_YN == "Y" && sender.Equals(btnConfirm))
                    {
                        MsgBox.Display(item.PT_NO + "(" + item.PT_NM + ") 는(은) 이미 승인되어 있어 변경할 수 없습니다. 다시 확인해주세요.", MessageType.MSG_TYPE_EXCLAMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                        verificationValueCh = "Stop";
                        break;
                    }
                    // 여러개를 한 번에 돌리면 오류 발생, 임시 예외처리, 없이는 마지막에 체크한 하나의 값 만 변경됩니다. (error : 0 테이블을 찾을 수 없습니다. -> update 시, 반환값이 없어서 발생)
                    try
                    {
                        model.HipassMobile_GrUPDATE.IN_PT_NO = item.PT_NO;
                        model.HipassMobile_GrUPDATE.IN_APY_STR_DT = item.APY_STR_DT;
                        model.HipassMobile_GrUPDATE.IN_TKN_NO = item.TKN_NO;
                        if (sender.Equals(btnCancle))
                        {
                            model.HipassMobile_GrUPDATE.IN_HPCD_CNCL_RSN_CD = "09";
                            model.HipassMobile_GrUPDATE.IN_CNCL_DT = DateTime.Now.ToString("yyyy-MM-dd");
                        }
                        UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "HipassMobileApprovalMng_UpdateYR", model.HipassMobile_GrUPDATE);
                    }
                    catch (Exception e)
                    {
                        verificationValue(e, model.HipassMobile_GrUPDATE);
                        verificationValueCh = "Stop";
                        break;
                    }
                }
                if (verificationValueCh == "Stop"){}
                else { HipassSearch(); }                   
            }
        }


        /// <summary>
        /// name         : 모바일하이패스
        /// desc         : Excel 변환/출력
        /// author       : 김용록
        /// create date  : 2024-08-14 오후 2:05:48
        /// update date  :  
        /// </summary>
        private void Excel()
        {

            string sExcelTitle = "모바일하이패스";
            if ((rbtFrvs.SelectedItem as RadioButtonListItem).Tag.ToString() == "A")
            {
                sExcelTitle += "조회";
            }
            else if ((rbtFrvs.SelectedItem as RadioButtonListItem).Tag.ToString() == "Y") {
                sExcelTitle += "승인조회";
            }
            else if ((rbtFrvs.SelectedItem as RadioButtonListItem).Tag.ToString() == "N")
            {
                sExcelTitle += "취소조회";
            }
            else if ((rbtFrvs.SelectedItem as RadioButtonListItem).Tag.ToString() == "U")
            {
                sExcelTitle += "미승인조회";
            }

            if (model.HipassMobile_GrOUT.Count < 1)
            {       
                MsgBox.Display("PAMCN_000470", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                return;
            } 
            else
            {                       
                var excelDownloadLog = new DownloadPrint_IN()
                {
                    MenuID = "AC_HIS.PA.AC.PE.PS.UI_/HipassMobileApprovalMng.xaml",
                    MenuName = "모바일하이패스조회(원무)",
                    Data = grdList,
                    ExportType = DownloadPrint_IN.DownloadPrintType.Excel
                };

                if (!LoggingReasonHelper.InsertDownloadPrintLog(excelDownloadLog))
                {
                    return;
                }
                else
                {
                    grdList.ToExcel(sExcelTitle, "", true, false, 1, 1);
                }
            }


        }



        /// <summary>
        /// name         : 모바일하이패스
        /// desc         : 데이터 초기화
        /// author       : 김용록 
        /// create date  : 2024-08-14 오전 10:42:13
        /// update date  : 
        /// </summary>
        private void DataInit()
        {
            model.HipassMobile_GrOUT = new HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>();
        }

        #endregion //Methods
    }
}
