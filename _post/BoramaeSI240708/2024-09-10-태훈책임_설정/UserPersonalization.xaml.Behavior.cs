using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Data;
using System.Drawing.Printing;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

using HSF.TechSvc2010.Common;
using HSF.Controls.WPF;

using HIS.Core.Global.DTO;
using HIS.Core.Global.DTO.Individuality;

using HIS.UI.Base;
using HIS.UI.Controls;
using HIS.UI.Core;
using HIS.UI.Core.Individuality;
using HIS.UI.Utility;


using HIS.PA.AC.PE.AP.UI;


namespace HIS.PA.PZ.AC.UI
{
    /// <summary>
    /// name         : #UserPersonalization Behavior 클래스
    /// desc         : #UserPersonalization Behavior 클래스
    /// author       : songminsu 
    /// create date  : 2016-09-27 오후 5:10:20
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class UserPersonalization
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
        private UserPersonalizationData model = new UserPersonalizationData();
        private bool StartFlag = false;
        #endregion //Member Variables

        #region [Properties]

        #endregion //Properties

        #region [Event]



        #endregion //Event

        #region [컨트롤 초기화]

        /// <summary>
        /// name         : 컨트롤 초기화
        /// desc         : UI에서 사용할 컨트롤을 초기화 합니다.
        /// author       : 황인영 
        /// create date  : 2013-02-26 오후 3:08:17
        /// update date  : 2013-02-26 오후 3:08:17, 황인영, 수정내용
        /// </summary>
        private void ControlInit()
        {
            //2024.08.17 프린터 급지함 세팅 처리하려고 기존 쓰던 프린터 세팅정보 주석. 
            //2024.08.18 양면프린터, 응급실여부, 예약증 출력여부 등 안 쓰는 옵션 주석처리.
            //PrinterSettings Print = new PrinterSettings();
            //var list = PrinterSettings.InstalledPrinters;
            //((PrinterSettings.StringCollection)list).Add("");
            //CboPrint.ItemsSource = list;   
            //CboPrint2.ItemsSource = list;
            //CboPrint3.ItemsSource = list;
            //CboPrint4.ItemsSource = list;
            //CboPrint5.ItemsSource = list;
            //CboLabelPrint.ItemsSource = list;
            //CboPrcdPrint.ItemsSource = list;
            PrintDocument pd = new PrintDocument();
            PrinterSource ps;
            InstalledPrinter ip;
            //rdoScreen.SelectedIndex = 0;            
            
            //설치된 프린터 정보를 받아온다. 
            foreach(string printName in PrinterSettings.InstalledPrinters)
            {
                ip = new InstalledPrinter();
                ip.PRINT_NAME = printName;
                pd.PrinterSettings.PrinterName = ip.PRINT_NAME;

                foreach (PaperSource p in pd.PrinterSettings.PaperSources)
                {
                    ps = new PrinterSource();
                    ps.SOURCE_NAME = p.SourceName;
                    ps.RAWKIND = p.RawKind;
                    ip.Printer_Sources.Add(ps);
                }
                //CboPrint.Items.Add(ip);        //영수증 프린트
                CboPrint.Items.Add(ip);
                CboPrint2.Items.Add(ip);       //제증명
                //CboPrint3.Items.Add(ip);       //양면 -> 안 쓴다.
                //CboPrint4.Items.Add(ip);       //원외처방전 프린트
                CboPrint5.Items.Add(ip);       //예약증 -> 얘는 좀 더 두고보자.
                CboLabelPrint.Items.Add(ip);   //라벨프린트
                CboPrcdPrint.Items.Add(ip);    //진찰권프린트




            }          
            MonitorListInit();  // 2023-05-31 남동균 금액표시기 위치 설정 추가 202305-00388

            //if (SessionManager.UserInfo.AADP_CD != "EM")
            //{
            //    chkEmrm_yn.IsEnabled = false;
            //}

        }
        #endregion //컨트롤 초기화

        #region [데이타초기화(공통코드)]

        /// <summary>
        /// name         : 데이터 초기화
        /// desc         : 화면 로드시 데이터를 초기화 합니다.
        /// author       : 황인영 
        /// create date  : 2013-02-26 오후 3:08:17
        /// update date  : 최종 수정일자 , 황인영, 수정개요
        /// </summary>
        private void DataInit()
        {
            CodeBindManager.BaseCodeBind(cboFileGB, CommonServiceAgent.SelectCodeByGroup("380", CodeUseYN.Use), "COMN_CD_NM", "COMN_CD", "", "");
            CodeBindManager.BaseCodeBind(cboIsurTp, CommonServiceAgent.SelectCodeByGroup("271", CodeUseYN.Use), "COMN_CD_NM", "COMN_CD", "", "");
            CodeBindManager.BaseCodeBind(cboDmdTp, CommonServiceAgent.SelectCodeByGroup("282", CodeUseYN.Use), "COMN_CD_NM", "COMN_CD", "", "");
            CodeBindManager.BaseCodeBind(cboMedFld, CommonServiceAgent.SelectCodeByGroup("258", CodeUseYN.Use), "COMN_CD_NM", "COMN_CD", "", "");

            model.AMT_MRK_MCHN_SCRN_TP = this.CheckNullByIndividualityWizardGlobal("AC", "PA001");
            model.MCST_RPY_ACAL_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA002") == "Y" ? true : false;
            model.BLNG_MTD_LIST_MRK_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA003") == "Y" ? true : false;
            model.RCP_PRNT_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA004") == "Y" ? true : false;
            model.RSV_PRNT_STU_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA005") == "Y" ? true : false;
            model.TEL_RSV_CLOS_CFMT_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA006") == "Y" ? true : false;
            //model.TEL_RSV_CLOS_CFMT_YN = true ;
            model.PRINT_INFO = this.CheckNullByIndividualityWizardGlobal("AC", "PA007");




            model.KNLG_SEQ_PV = this.CheckNullByIndividualityWizardGlobal("AC", "PA008");
            model.CTFS_CONR_PRTR = this.CheckNullByIndividualityWizardGlobal("AC", "PA009");
            model.PRCD_ISSU_PV = this.CheckNullByIndividualityWizardGlobal("AC", "PA010") == null ? "" : this.CheckNullByIndividualityWizardGlobal("AC", "PA010");
            model.LCD_AMT_MRK_PV_GUID_WDNG = this.CheckNullByIndividualityWizardGlobal("AC", "PA011");
            model.USR_HSP_TP = this.CheckNullByIndividualityWizardGlobal("AC", "PA012");
            model.OTPT_RPY_ASK_PRD = this.CheckNullByIndividualityWizardGlobal("AC", "PA014");
            model.RPY_HH_BSC = this.CheckNullByIndividualityWizardGlobal("AC", "PA015");
            model.FAX_PORT = this.CheckNullByIndividualityWizardGlobal("AC", "PA016");
            model.ADS_REG_PCOR_AUTO_INSP_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA017") == "Y" ? true : false;
            model.FILE_TP = this.CheckNullByIndividualityWizardGlobal("AC", "PA018");
            model.DMD_TP = this.CheckNullByIndividualityWizardGlobal("AC", "PA019");
            model.SHIP_SEQ = this.CheckNullByIndividualityWizardGlobal("AC", "PA020");
            model.ISUR_TP = this.CheckNullByIndividualityWizardGlobal("AC", "PA021");
            model.MED_YY_MM = this.CheckNullByIndividualityWizardGlobal("AC", "PA022");
            model.MED_FLD = this.CheckNullByIndividualityWizardGlobal("AC", "PA023");
            model.TGT_PT_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA013") == "Y" ? true : false;

            model.PRINT_INFO2 = this.CheckNullByIndividualityWizardGlobal("AC", "PA024");

            MsgBox.Display(model.PRINT_INFO2 + "ss", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);

            model.LABEL_PRT = this.CheckNullByIndividualityWizardGlobal("AC", "PA025") == null ? "" : this.CheckNullByIndividualityWizardGlobal("AC", "PA025");

            model.EMRM_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA026") == "Y" ? true : false;
            model.TEL_RSV_INSP_LIST_CFMT_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA027") == "Y" ? true : false;


            model.PRINT_INFO3 = this.CheckNullByIndividualityWizardGlobal("AC", "PA028");
            model.PRINT_INFO4 = this.CheckNullByIndividualityWizardGlobal("AC", "PA029");


            model.HSOT_ORD_PRTR_STU_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA030") == "Y" ? true : false;
            model.AMT_MRK_MCHN_SCRN_PSTN = this.CheckNullByIndividualityWizardGlobal("AC", "PA031");    // 2023-05-31 남동균 금액표시기 위치 설정 추가 202305-00388



            model.PRES_TRAY_NUM = Convert.ToInt16(this.CheckNullByIndividualityWizardGlobal("AC", "PA033"));   //2024.08.17 원외처방전 출력 시 트레이 지정 추가 김태훈
            model.BILL_TRAY_NUM = Convert.ToInt16(this.CheckNullByIndividualityWizardGlobal("AC", "PA034"));   //2024.08.18 영수증 출력 시 트레이 지정 추가 김태훈
            model.REPO_TRAY_NUM = Convert.ToInt16(this.CheckNullByIndividualityWizardGlobal("AC", "PA035"));   //2024.08.18 제증명 출력 시 트레이 지정 추가 김태훈

            //환자모니터 세팅값 보여주기
            foreach (string mon in CboMonPos.Items)
            {
                if(mon == model.AMT_MRK_MCHN_SCRN_PSTN)
                {
                    CboMonPos.SelectedValue = model.AMT_MRK_MCHN_SCRN_PSTN;
                }
            }

            //프린터 지정값 보여주기
            foreach (string Printer in PrinterSettings.InstalledPrinters)
            {
                //영수증 프린터
                if (Printer == model.PRINT_INFO)
                {
                    foreach(InstalledPrinter ip in CboPrint.Items)
                    {
                        if (ip.PRINT_NAME == Printer) 
                        {
                            CboPrint.SelectedItem = ip;
                        }
                    }
                }
                
                //제증명프린터
                if (Printer == model.CTFS_CONR_PRTR)
                {                    
                    foreach (InstalledPrinter ip in CboPrint2.Items)
                    {
                        if (ip.PRINT_NAME == Printer)
                        {
                            CboPrint2.SelectedItem = ip;
                        }
                    }
                }

                //양면프린터 -> 안 써서 막음.
                //if (Printer == model.PRINT_INFO2)
                //{
                //    //CboPrint3.SelectedValue = Printer;
                //    foreach (InstalledPrinter ip in CboPrint3.Items)
                //    {
                //        if (ip.PRINT_NAME == Printer)
                //        {
                //            CboPrint3.SelectedItem = ip;
                //        }
                //        else
                //        {
                //            continue;
                //        }
                //    }
                //}

                //원외처방전 프린터
                if (Printer == model.PRINT_INFO3)
                {
                    //CboPrint4.SelectedValue = Printer;   //원외처방전 프린터
                    foreach (InstalledPrinter ip in CboPrint4.Items)
                    {
                        if (ip.PRINT_NAME == Printer)
                        {
                            CboPrint4.SelectedItem = ip;
                        }
                    }
                }

                //예약증 프린터 -> 이 친구는 좀 더 고민.
                if (Printer == model.PRINT_INFO4)
                {
                    //CboPrint5.SelectedValue = Printer;
                    foreach (InstalledPrinter ip in CboPrint5.Items)
                    {
                        if (ip.PRINT_NAME == Printer)
                        {
                            CboPrint5.SelectedItem = ip;
                        }
                    }
                }

                //라벨프린터
                if (Printer == model.LABEL_PRT)
                {
                    //CboLabelPrint.SelectedValue = Printer;
                    foreach (InstalledPrinter ip in CboLabelPrint.Items)
                    {
                        if (ip.PRINT_NAME == Printer)
                        {
                            CboLabelPrint.SelectedItem = ip;
                        }
                    }
                }

                //진찰권 프린터 -> 이 친구도 일종의 프린터..
                if (Printer == model.PRCD_ISSU_PV)
                {
                    //2024.06.19 진찰권프린터 설정 변경 - 다른 출력물처럼 프린터 지정으로 바꿈.
                    //CboPrcdPrint.SelectedValue = Printer;
                    foreach (InstalledPrinter ip in CboPrcdPrint.Items)
                    {
                        if (ip.PRINT_NAME == Printer)
                        {
                            CboPrcdPrint.SelectedItem = ip;
                        }
                    }
                }
            }

            foreach(PrinterSource item in CboPresTray.Items)
            {
                if (Convert.ToInt16(item.RAWKIND) == model.PRES_TRAY_NUM)
                {                 
                    CboPresTray.SelectedItem = item;
                }
            }

            foreach(PrinterSource item in CboBILLTray.Items)
            {
                if (Convert.ToInt16(item.RAWKIND) == model.BILL_TRAY_NUM)
                {
                    CboBILLTray.SelectedItem = item;
                }
            }

            foreach (PrinterSource item in CboREPOTray.Items)
            {
                if (Convert.ToInt16(item.RAWKIND) == model.REPO_TRAY_NUM)
                {
                    CboREPOTray.SelectedItem = item;
                }
            }

            //model.FAX_PORT = Convert.ToInt16(this.CheckNullByIndividualityWizardGlobal("AC", "PA080"));

            //model.SIXMONTH_YN = this.CheckNullByIndividualityWizardGlobal("AC", "PA090") == "Y" ? true : false;
        }








        private String CheckNullByIndividualityWizardGlobal(String main, String itemCd)
        {
            if (IndividualityWizard.PRIVATE_SETTING != null)
            {
                if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[main] != null)
                {
                    if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[main].GLOBAL_PRIVATE_SETTING[itemCd] != null)
                    {
                        return IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[main].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault().ITEM_CHR_VAL;
                    }
                }
            }
            return null;
        }

        #endregion //데이타초기화(공통코드)











        #region [Methods]

        public void CheckChangedDataList()
        {
            this.ChangedDataInGlobal();
        }









        private void ChangedDataInGlobal()
        {
            //this.CheckChangedData(this.FONT_SIZE, "TA", INDIVIDUALITY_TA_CODE.TA901.ToString());
            //this.CheckChangedData(model.PRINT_INFO, "AC", "PA000");
            this.CheckChangedData(model.AMT_MRK_MCHN_SCRN_TP, "AC", "PA001");
            this.CheckChangedData(model.MCST_RPY_ACAL_YN == true ? "Y" : "N", "AC", "PA002");
            this.CheckChangedData(model.BLNG_MTD_LIST_MRK_YN == true ? "Y" : "N", "AC", "PA003");
            this.CheckChangedData(model.RCP_PRNT_YN == true ? "Y" : "N", "AC", "PA004");
            this.CheckChangedData(model.RSV_PRNT_STU_YN == true ? "Y" : "N", "AC", "PA005");
            this.CheckChangedData(model.TEL_RSV_CLOS_CFMT_YN == true ? "Y" : "N", "AC", "PA006");
            this.CheckChangedData(model.PRINT_INFO, "AC", "PA007");
            this.CheckChangedData(model.KNLG_SEQ_PV, "AC", "PA008");
            this.CheckChangedData(model.CTFS_CONR_PRTR, "AC", "PA009");
            this.CheckChangedData(model.PRCD_ISSU_PV, "AC", "PA010");
            //this.CheckChangedData(model.LCD_AMT_MRK_PV_GUID_WDNG, "AC", "PA011");
            this.CheckChangedData(model.USR_HSP_TP, "AC", "PA012");
            this.CheckChangedData(model.OTPT_RPY_ASK_PRD, "AC", "PA014");
            this.CheckChangedData(model.RPY_HH_BSC, "AC", "PA015");
            this.CheckChangedData(model.FAX_PORT, "AC", "PA016");
            this.CheckChangedData(model.ADS_REG_PCOR_AUTO_INSP_YN == true ? "Y" : "N", "AC", "PA017");
            this.CheckChangedData(model.FILE_TP, "AC", "PA018");
            this.CheckChangedData(model.DMD_TP, "AC", "PA019");
            this.CheckChangedData(model.SHIP_SEQ, "AC", "PA020");
            this.CheckChangedData(model.ISUR_TP, "AC", "PA021");
            this.CheckChangedData(model.MED_YY_MM, "AC", "PA022");
            this.CheckChangedData(model.MED_FLD, "AC", "PA023");
            this.CheckChangedData(model.TGT_PT_YN == true ? "Y" : "N", "AC", "PA013");
            this.CheckChangedData(model.PRINT_INFO2, "AC", "PA024");
            this.CheckChangedData(model.LABEL_PRT, "AC", "PA025");
            this.CheckChangedData(model.EMRM_YN == true ? "Y" : "N", "AC", "PA026");
            this.CheckChangedData(model.TEL_RSV_INSP_LIST_CFMT_YN == true ? "Y" : "N", "AC", "PA027");
            this.CheckChangedData(model.PRINT_INFO3, "AC", "PA028");   //원외처방전 프린터
            this.CheckChangedData(model.PRINT_INFO4, "AC", "PA029");
            this.CheckChangedData(model.HSOT_ORD_PRTR_STU_YN == true ? "Y" : "N", "AC", "PA030");    //원외처방전 출력여부
            this.CheckChangedData(model.AMT_MRK_MCHN_SCRN_PSTN, "AC", "PA031");    // 2023-05-31 남동균 금액표시기 위치 설정 추가 202305-00388
            this.CheckChangedData(model.PRES_TRAY_NUM, "AC", "PA033");   //2024.08.17 원외처방전 급지함 지정 추가 김태훈
            this.CheckChangedData(model.BILL_TRAY_NUM, "AC", "PA034");   //2024.08.18 영수증 급지함 지정 추가 김태훈
            this.CheckChangedData(model.REPO_TRAY_NUM, "AC", "PA035");   //2024.08.18 제증명 급지함 지정 추가 김태훈


            //this.CheckChangedData(model.BILL_AUTO_YN == true ? "Y" : "N", "AC", "PA011");
            //this.CheckChangedData(model.DRUG_AUTO_YN == true ? "Y" : "N", "AC", "PA012");
            //this.CheckChangedData(model.BIND_BILL_YN == true ? "Y" : "N", "AC", "PA013");
            //this.CheckChangedData(model.SIGNPAD_USE_YN == true ? "Y" : "N", "AC", "PA030");
            //this.CheckChangedData(model.MONITOR_USE_YN == true ? "Y" : "N", "AC", "PA040");
            //this.CheckChangedData(model.TODAY_SUJIN_YN == true ? "Y" : "N", "AC", "PA050");
            //this.CheckChangedData(model.TODAY_SUNAP_YN == true ? "Y" : "N", "AC", "PA060");
            ////this.CheckChangedData(model.COLOR_DIS_YN == true ? "Y" : "N", "AC", "PA070");
            //this.CheckChangedData(model.ALARM_MINUTE, "AC", "PA080");

            //this.CheckChangedData(model.SIXMONTH_YN == true ? "Y" : "N", "AC", "PA090");//2013.07.19 추가
        }






        // 김용록 데이터 세팅하던 이 부분은 잘 봐야할 거 같은데
        private void CheckChangedData(Object value, String mainCd, String itemCd)
        {

            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd] == null)
            {
                PrivateSetting_DTO dto = new PrivateSetting_DTO();
                dto.MSCR_TP_CD = mainCd;
                dto.ITEM_CD = itemCd;
                dto.ITEM_CHR_VAL = value != null ? value.ToString() : null;
                dto.ITEM_CHR_VAL_SEQ = 1;
                model.GLOBAL_ITEM_LIST.Add(dto);
                return;
            }

            if (value is Double)
            {
                Double temp = (Double)value;

                if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault().ITEM_CHR_VAL != null
                    && Double.Parse(IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault().ITEM_CHR_VAL) != temp)
                {
                    IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault().ITEM_CHR_VAL = temp.ToString("R");
                    model.GLOBAL_ITEM_LIST.Add(IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault());
                }
            }
            else //if (value is String)
            {
                if (value != null && value.ToString() != IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault().ITEM_CHR_VAL)
                {
                    IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault().ITEM_CHR_VAL = value.ToString();
                    model.GLOBAL_ITEM_LIST.Add(IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault());
                }
            }
        }









        /// <summary>
        /// 프린터 콤보 선택 시 model에 바인딩되는 프린터 이름 변경.
        /// </summary>
        /// <param name="StrName"></param>
        private void PrintComboChange(string StrName)
        {
            if (StrName == "CboPrint")   //영수증 프린터
            {
                if (this.CboPrint.SelectedItem != null)
                {
                    CboBILLTray.SelectedItem = null;
                    CboBILLTray.Items.Clear();
                    InstalledPrinter ip = (InstalledPrinter)CboPrint.SelectedItem;
                    foreach (PrinterSource ps in ip.Printer_Sources)
                    {
                        CboBILLTray.Items.Add(ps);
                    }
                    model.PRINT_INFO = ((InstalledPrinter)this.CboPrint.SelectedItem).PRINT_NAME;//this.CboPrint.SelectedValue.ToString();
                    model.BILL_TRAY_NUM = 0;
                }
            }
            else if (StrName == "CboPrint2")   //제증명프린터
            {
                if (this.CboPrint2.SelectedItem != null)
                {
                    CboREPOTray.SelectedItem = null;
                    CboREPOTray.Items.Clear();
                    InstalledPrinter ip = (InstalledPrinter)CboPrint2.SelectedItem;
                    foreach (PrinterSource ps in ip.Printer_Sources)
                    {
                        CboREPOTray.Items.Add(ps);
                    }

                    model.CTFS_CONR_PRTR = ((InstalledPrinter)this.CboPrint2.SelectedItem).PRINT_NAME;//this.CboPrint2.SelectedValue.ToString();
                    model.REPO_TRAY_NUM = 0;
                }
            }
            //else if (StrName == "CboPrint3")   //양면프린터
            //{
            //    if (this.CboPrint3.SelectedItem != null)
            //    {
            //        model.PRINT_INFO2 = ((InstalledPrinter)this.CboPrint3.SelectedItem).PRINT_NAME;//this.CboPrint3.SelectedValue.ToString();
            //    }
            //}
            else if (StrName == "CboPrint4")   //처방전프린터
            {
                if (this.CboPrint4.SelectedItem != null)
                {
                    //우선 처방전 프린터만, 급지함 지정해서 출력 가능하게 처리하자. 
                    CboPresTray.SelectedItem = null;
                    CboPresTray.Items.Clear();
                    InstalledPrinter ip = (InstalledPrinter)CboPrint4.SelectedItem;
                    foreach(PrinterSource ps in ip.Printer_Sources)
                    {
                        CboPresTray.Items.Add(ps);
                    }

                    model.PRINT_INFO3 = ((InstalledPrinter)this.CboPrint4.SelectedItem).PRINT_NAME;
                    model.PRES_TRAY_NUM = 0;
                }
            }
            else if (StrName == "CboPrint5")   //예약증프린터
            {
                if (this.CboPrint5.SelectedItem != null)
                {
                    model.PRINT_INFO4 = ((InstalledPrinter)this.CboPrint5.SelectedItem).PRINT_NAME;//this.CboPrint5.SelectedValue.ToString();
                }
            }
            else if (StrName == "CboLabelPrint")   //라벨프린터
            {
                if (this.CboLabelPrint.SelectedItem != null)
                {
                    model.LABEL_PRT = ((InstalledPrinter)this.CboLabelPrint.SelectedItem).PRINT_NAME;//this.CboLabelPrint.SelectedValue.ToString();
                }
            }            
            else if (StrName == "CboPrcdPrint")   //진찰권 프린터 - 2024.06.19 보라매 진찰권 프린터 세팅 라디오에서 프린터 콤보로 변경 김태훈
            {
                if (this.CboPrcdPrint.SelectedItem != null)
                {
                    model.PRCD_ISSU_PV = ((InstalledPrinter)CboPrcdPrint.SelectedItem).PRINT_NAME;//this.CboPrcdPrint.SelectedValue.ToString();
                }
            }
            else if (StrName == "CboPresTray")   //원외처방전 트레이
            {
                if (this.CboPresTray.SelectedItem != null)
                {
                    PrinterSource ps = (PrinterSource)CboPresTray.SelectedItem;
                    model.PRES_TRAY_NUM = Convert.ToInt16(ps.RAWKIND);
                }
            }
            else if (StrName == "CboBILLTray")   //영수증 트레이
            {
                if (this.CboBILLTray.SelectedItem != null)
                {
                    PrinterSource ps = (PrinterSource)CboBILLTray.SelectedItem;
                    model.BILL_TRAY_NUM = Convert.ToInt16(ps.RAWKIND);
                }
            }
            else if (StrName == "CboREPOTray")   //제증명 트레이
            {
                if (this.CboREPOTray.SelectedItem != null)
                {
                    PrinterSource ps = (PrinterSource)CboREPOTray.SelectedItem;
                    model.REPO_TRAY_NUM = Convert.ToInt16(ps.RAWKIND);
                }
            }
        }















        /// <summary>
        /// 환자모니터 표출 위치 라디오버튼 선택
        /// </summary>
        private void RdoScreenSelectionChanged()
        {
            if (this.model.AMT_MRK_MCHN_SCRN_TP == "1" || this.model.AMT_MRK_MCHN_SCRN_TP == "2")
            {
                List<PAGuideDisplay> paguidedisplay = null;

                for (int i = 0; i < Application.Current.Windows.Count; i++)
                {
                    paguidedisplay = Application.Current.Windows[i].GetChilds<HIS.PA.AC.PE.AP.UI.PAGuideDisplay>() as List<PAGuideDisplay>;

                    if (paguidedisplay.Count > 0)
                    {

                        Dispatcher.BeginInvoke(new Action(delegate
                        {
                            paguidedisplay[0].ImgChage(model.LCD_AMT_MRK_PV_GUID_WDNG, null);
                        }));
                        break;
                    }
                }
            }
        }










        private void MonitorListInit()
        {
            // 2023-05-31 남동균 금액표시기 위치 설정 추가 202305-00388
            System.Windows.Forms.Screen[] Screens = System.Windows.Forms.Screen.AllScreens;

            CboMonPos.Items.Clear();

            for (int i = 1; i < Screens.Count()+1; i++)
            {
                //CboMonPos.Items.Add(Screens[i].DeviceName);
                CboMonPos.Items.Add("모니터"+ i.ToString());
            }           
                //CboMonPos.ItemsSource = Screens;
        }












        private void MonitorPositionComboChange()
        {
            // 2023-05-31 남동균 금액표시기 위치 설정 추가 202305-00388
            if (this.CboMonPos.SelectedValue != null)
            {
                model.AMT_MRK_MCHN_SCRN_PSTN = this.CboMonPos.SelectedValue.ToString();
            }
        }
        #endregion //Methods
    }
}
