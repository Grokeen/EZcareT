using HIS.Core.Global.DTO.CommonLogging;
using HIS.PA.AC.PC.OP.DTO;
using HIS.PA.AC.PI.PI.UI;
using HIS.PA.CORE.DTO;
using HIS.PA.CORE.UI.UTIL;
using HIS.UI.Base;
using HIS.UI.Controls;
using HIS.UI.Controls.Extension;
using HIS.UI.Core;
using HIS.UI.Utility;
using HIS.UI.Utility.Extension;
using HSF.Controls.WPF;
using HSF.TechSvc2010.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.CompilerServices;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace HIS.PA.AC.PC.OP.UI
{
    /// <summary>
    /// name         : #OtpStorageAmountNonCompletePaymentAsk Behavior 클래스
    /// desc         : #OtpStorageAmountNonCompletePaymentAsk Behavior 클래스
    /// author       : hjkim 
    /// create date  : 2021-09-21 오후 2:50:13
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class OtpStorageAmountNonCompletePaymentAsk
    {
        #region [Consts]
        /// <summary>
        /// Biz 클래스명
        /// </summary>
        private const string BIZ_CLASS = "";
        #endregion //Consts

        #region [Dependency Properties]

        #endregion //Dependency Properties

        #region [Member Variables]

        /// <summary>
        /// 프레젠테이션 모델(PM) 
        /// </summary>
        private OtpStorageAmountNonCompletePaymentAskData model;

        #endregion //Member Variables

        #region [Properties]

        #endregion //Properties

        #region [컨트롤 초기화]

        /// <summary>
        /// name         : 컨트롤 초기화
		/// desc         : UI에서 사용할 컨트롤을 초기화 함
		/// author       : hjkim
		/// create date  : 2021-09-21 오후 2:50:13
		/// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void ControlInit()
        {
            model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_FROMDATE = HIS.UI.Core.CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMdd");
            model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_TODATE = HIS.UI.Core.CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMdd");

            model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_UP_AMT = "10000";

            model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_FROM_AMT = "0";
            model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_TO_AMT = "999999999";

            this.rdoMore.IsChecked = true;


            this.chkMedDt.IsChecked = true;
            this.chkMedDept.IsChecked = true;
            this.chkName.IsChecked = true;


            this.txtMsg1.Text = "○○○님 ○○월○○일 ○○○과 ";
            this.txtMsg2.Text = "환불이 있으니 연락부탁드립니다. -전남대학교병원-";
            this.txtNumber.Text = "062-220-";

            model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.Clear();

            ControlHelper.HFromToCalendarFocus(ftcal);

        }
        #endregion //컨트롤 초기화

        #region [데이타초기화(공통코드)]

        /// <summary>
        /// name         : 데이터 초기화
		/// desc         : 화면 로드시 데이터를 초기화 함
		/// author       : hjkim 
		/// create date  : 2021-09-21 오후 2:50:13
		/// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void DataInit()
        {
        }
        #endregion //데이타초기화(공통코드)

        #region [Methods]

        /// <summary>
        /// name         : 데이터 조회
        /// desc         : 데이터를 조회함
        /// author       : hjkim 
        /// create date  : 2021-09-21 오후 2:50:13
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void SelectData()
        {

            string sAmtSteGubn = ""; // 기준금액 이상or사이 
            if (this.rdoMore.IsChecked == true)
            {
                sAmtSteGubn = "U";
            }
            else if (this.rdoBetween.IsChecked == true) 
            {
                sAmtSteGubn = "B";
            }

            model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_JOBTYPE = sAmtSteGubn;
            model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_PACT_TP_CD = ((FrameworkElement)rblPactTpCd.SelectedItem).Tag.ToString();

            model.OtpStorageAmountNonCompletePaymentAsk_OUTObj = UIMiddlewareAgent.InvokeBizService(this, "HIS.PA.AC.PC.OP.BIZ.OtpStorageAmountNonCompletePaymentAskBL", "SelOtpStorageAmountNonCompletePaymentAsk", model.OtpStorageAmountNonCompletePaymentAsk_INObj) as HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT>;
            if (model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.Count == 0) MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
        }





        /// <summary>
        /// name         : 엑셀 출력
        /// desc         : 엑셀 출력
        /// author       : hjkim 
        /// create date  : 2021-09-19 오후 2:49:53
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void ExportToExcel()
        {
            if (dgrdResult.Items.Count == 0)
            {
                MsgBox.Display("엑셀 처리할 데이터가 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                return;
            }

            string pt_no = string.Format("{0}외 {1}명", model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.FirstOrDefault().PT_NO, model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.Count - 1);
            string column_nm = string.Join("/", dgrdResult.Columns.Select(x => x.Header.ToString()));
            string pt_nm = string.Format("{0}외 {1}명", model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.FirstOrDefault().PT_NM, model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.Count - 1);
            if (DataExportManager.ExcelExportConfirm(true, EAM_INFO.ASSEMBLY_NAME + EAM_INFO.APP_URL, pt_nm, dgrdResult.Items.Count, pt_no, column_nm))
            {
                dgrdResult.ToExcel("외래보증금미정산환자내역조회", "", true, false, 3, 3);
            }
   

            LoggingServiceAgent.DownloadPrint(new DownloadPrint_IN
            {
                EmployeeID = SessionManager.UserInfo.HIS_STF_NO,
                ClientIP = SessionManager.UserInfo.HIS_IP_ADDR,
                MenuID = SessionManager.UserInfo.HIS_PRGM_ID,
                PrintTime = System.DateTime.Now,
                Contents = "ToExcel "
            });
        }



        /// <summary>
        /// name         : 레포트 출력
        /// desc         : 레포트 출력
        /// author       : hjkim 
        /// create date  : 2021-09-19 오후 2:49:53
        /// update date  : 최종 수정 일자, 수정자, 수정개요  
        /// </summary>
        private void Print()
        {
            if (model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.Count > 0)
            {
                RexViewerPopUp RexportPopUp = new RexViewerPopUp();
                RexConnectionMEMO RexportConnMemo = new RexConnectionMEMO
                {
                    NameSpace = Common.REX_NAMESPACE,
                    ColDelim = Common.REX_COLDELIM,
                    RowDelim = Common.REX_ROWDELIM
                };

                RexportPopUp.Viewer.IsOpenPopup = true;
                RexportPopUp.Viewer.DocumentPath = StringHelper.GetNamespaceDirectory(this.GetType()) + "PrintOtpStorageAmountNonCompletePaymentAsk.reb";
                RexportPopUp.Viewer.InsertPrintLog(true, EAM_INFO.ASSEMBLY_NAME + EAM_INFO.APP_URL, model.OtpStorageAmountNonCompletePaymentAsk_OUTObj.Count);
                RexportPopUp.Viewer.AddParameter("period", DateTime.ParseExact(model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_FROMDATE, "yyyyMMdd", null).ToString("yyyy-MM-dd") + " ~ " + DateTime.ParseExact(model.OtpStorageAmountNonCompletePaymentAsk_INObj.IN_TODATE, "yyyyMMdd", null).ToString("yyyy-MM-dd"));

                RexportConnMemo.SetData(MakeRexFormat(12)
                                              , model.OtpStorageAmountNonCompletePaymentAsk_OUTObj
                                              , "PT_NO", "PT_NM", "MED_DT", "MED_DEPT_CD", "TEL_NO", "RPY_DT", "RPY_AMT", "RPY_STF_NO", "STRG_AMT_RMK", "RCN_RSV_DT", "UNCL_AMT", "PACT_TP_NM");

                if (RexportConnMemo.Data.Substring(RexportConnMemo.Data.Length - Common.REX_ROWDELIM.Length) == Common.REX_ROWDELIM)
                {
                    RexportConnMemo.Data = RexportConnMemo.Data.Substring(0, RexportConnMemo.Data.Length - Common.REX_ROWDELIM.Length);
                }

                RexportPopUp.Viewer.Connection = RexportConnMemo;
                RexportPopUp.ShowDialog();
                RexportPopUp.Close();


            }
            else
            {
                MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }
        }


        private string MakeRexFormat(int cnt)
        {
            string[] result = new string[cnt];
            for (int i = 0; i < cnt; i++)
            {
                result[i] = "{" + i.ToString() + "}";
            }

            return String.Join(Common.REX_COLDELIM, result);
        }



        private void OpPopUp()
        {
            UserControlBase userControlBase = this.OnLoadMenuAfterFindingDuplicationMenu("AC_CALS_OCALS_ReservationAmountReceivePaymentManagement");
            if (userControlBase != null)
            {
                //(userControlBase as dynamic).InModel.PT_NO = model.MngDischargeAmountOpPopUp_In.IN_PATNO; ;
                (((userControlBase as HIS.PA.AC.PC.OP.UI.ReservationAmountReceivePaymentManagement)).FindName("uc_txtPtNo") as HIS.PA.CORE.UI.PACodeAsk).SelectedTextCode = (dgrdResult.SelectedItem as OtpStorageAmountNonCompletePaymentAsk_OUT).PT_NO;
                //(userControlBase as dynamic).ucPt_no.SelectedTextCode = model.MngDischargeAmountOpPopUp_In.IN_PATNO; ;
            }


            //PopUpBase pop = base.OnLoadPopupMenu("AC_CALS_OCALS_ReservationAmountReceivePaymentManagement");
            //pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            //pop.Owner = Window.GetWindow(this);
            //pop.Show();
            //(pop.MainMenuInfo.INSTANCE_OF_MENU as dynamic).Uc_txtPtNo.SelectedTextCode = model.OtpStorageAmountNonCompletePaymentAsk_OUTObj[dgrdResult.ActiveRecordIndex].PT_NO;


        }

        private void SetMsg()
        {
            String strName = string.Empty;
            String strMedDt = string.Empty;
            String strDept = string.Empty;

            if (this.chkName.IsChecked == true)
            {
                strName = "○○○님";
            }
            else if (this.chkName.IsChecked == false)
            {
                strName = string.Empty;
            }

            if (this.chkMedDt.IsChecked == true)
            {
                strMedDt = " ○○월○○일";
            }
            else if (this.chkMedDt.IsChecked == false)
            {
                strMedDt = string.Empty;
            }

            if (this.chkMedDept.IsChecked == true)
            {
                strDept = " ○○○과";
            }
            else if (this.chkMedDept.IsChecked == false)
            {
                strDept = string.Empty;
            }

            this.txtMsg1.Text = strName + strMedDt + strDept;
        }



        private void SendSMS()
        {
            int iSuccessCnt = 0;
            string sSmsMsg;
            string sName;
            string sDate;
            string sDeptCd;
            var saveList = new HSFDTOCollectionBaseObject<OtpStorageAmountNonCompletePaymentAsk_OUT>();

            foreach (OtpStorageAmountNonCompletePaymentAsk_OUT item in dgrdResult.SelectedItems)
            {
                saveList.Add(new OtpStorageAmountNonCompletePaymentAsk_OUT
                {
                    PT_NM = item.PT_NM,
                    PT_NO = item.PT_NO,
                    MED_DT = item.MED_DT,
                    MED_DEPT_CD = item.MED_DEPT_CD,
                    TEL_NO = item.TEL_NO
                });
            }

            if (saveList.Count == 0)
            {
                MsgBox.Display("전송 대상자가 없습니다", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                return;
            }
            else
            {
                for (int i = 0; i < saveList.Count; i++)
                {

                    string smstemp = "";

                    sName = saveList[i].PT_NM + "님";
                    sDate = saveList[i].MED_DT.Replace("-","").Substring(4,2) +"월" + saveList[i].MED_DT.Replace("-","").Substring(6, 2) + "일";
                    sDeptCd = saveList[i].MED_DEPT_CD;

                    if (this.chkName.IsChecked == false)
                    {
                        sName = string.Empty;
                    }

                    if (this.chkMedDt.IsChecked == false)
                    {
                        sDate = string.Empty; 
                    }

                    if (this.chkMedDept.IsChecked == false)
                    {
                        sDeptCd = string.Empty; 
                    }

                    sSmsMsg = sName + " " + sDate + " " +  sDeptCd + " "  + txtMsg2.Text;

                    if (!String.IsNullOrEmpty(saveList[i].TEL_NO))
                    {
                        CommonServiceAgent.SendSMS(saveList[i].PT_NO
                                                         , DateTime.Now
                                                         , "보관금환불"
                                                         , sSmsMsg
                                                         //, txtNumber.Text.Replace("-", "")
                                                         , "224"
                                                         , saveList[i].TEL_NO
                                                         , smstemp
                                                         , SessionManager.UserInfo.HIS_STF_NO
                                                         , "보관금미정산환자내역조회"
                                                         );
                        iSuccessCnt = iSuccessCnt + 1;
                    }


                }
                if (iSuccessCnt == 0)
                {
                    MsgBox.Display("전송 요청 성공건이 없습니다.", MessageType.MSG_TYPE_INFORMATION, "", true, MessageBoxButton.OK, -1, ButtonFocusType.OK, null);
                    return;
                }
                MsgBox.Display(iSuccessCnt.ToString() + "건이 전송되었습니다", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
                return;

            }

        }


        #endregion //Methods
    }
}
