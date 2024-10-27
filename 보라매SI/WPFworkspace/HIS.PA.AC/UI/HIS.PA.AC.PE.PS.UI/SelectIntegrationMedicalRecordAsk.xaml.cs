using System;
using System.Collections;
using System.Windows;
using System.Windows.Controls;
using HIS.UI.Base;
using HIS.UI.Controls.Behaviors;
using HIS.UI.Core;
using System.Windows.Threading;
using HSF.Controls.WPF;
using HSF.Report.Extention;
using HIS.MC.DR.RM.NC.UI.Common;
using System.Diagnostics;
using HIS.MC.DR.RM.RS.UI;
using HSF.Report.Core.Document;
using HIS.MC.CI.Core.UI.Common;
using HIS.MC.CI.Core.DTO;
using HSF.TechSvc2010.Common;
using HIS.MC.DR.RM.RV.DTO;

namespace HIS.MC.DR.RM.RV.UI
{
    /// <summary>
    /// id           : 
    /// name         : 의무기록뷰어
    /// clss         : 메인
    /// desc         : 환자에게 작성된 기록을 비롯하여, 관련 모든 기록들을 조회하는 기능을 제공함.
    /// author       : 강성희
    /// create date  : 2016-05-03 오후 7:43:49
	/// update date  : 2016-05-03 오후 7:43:49
    /// </summary>
    public partial class SelectIntegrationMedicalRecordAsk : UserControlBase
    {
        #region [Constructor]                

        /// <summary>
        /// Initializes a new <see cref="SelectIntegrationMedicalRecordAsk"/>
        /// </summary>
        public SelectIntegrationMedicalRecordAsk()
        {
            InitializeComponent();

            SessionManager.ChangedGlobalPatientInfo += new Action(SessionManager_ChangedGlobalPatientInfo);

            webBrowserElectronicConsent = new WebBrowser();
            this.layoutElectronicConsent.Children.Add(webBrowserElectronicConsent);

            this.model = this.DataContext as SelectIntegrationMedicalRecordAskData;
        }

        public SelectIntegrationMedicalRecordAsk(bool isFromWeb)
        {
            InitializeComponent();

            if (!isFromWeb)
            {
                SessionManager.ChangedGlobalPatientInfo += new Action(SessionManager_ChangedGlobalPatientInfo);

                webBrowserElectronicConsent = new WebBrowser();
                this.layoutElectronicConsent.Children.Add(webBrowserElectronicConsent);
            }

            this.model = this.DataContext as SelectIntegrationMedicalRecordAskData;
        }

        /// <summary>
        /// name         : 세션정보를 사용하지 않고 외부에서 환자정보를 입력받아 정보를 설정하는 생성자
        /// desc         : 세션정보를 사용하지 않고 환자번호를 입력받아 정보를 설정하는 생성자 입니다.
        /// author       : 강성희
        /// create date  : 2016-05-12
        /// update date  : 최종 수정일자, 최종 수정자, 수정개요
        /// </summary>
        /// <param name="type">구분</param>
        /// <param name="parameter">파라미터</param>
        public SelectIntegrationMedicalRecordAsk(String sParameter)
            : this()
        {
            ((ViewModelBase)this.DataContext).SetQueryString(HSF.Controls.WPF.Utility.ParseQueryString(sParameter));
        }

        #endregion //Constructor

        #region HwndHost 에서 상속된 객체를 사용하는 화면에 대한 코드 개선안
        /// <summary>
        /// HwndHost 에서 상속된 객체를 사용하는 화면에 대한 코드 개선안
        ///(적용대상 : WebBrowser, PACS 모듈 외 Win32 객체)
        /// </summary>
        private WebBrowser webBrowserElectronicConsent;

        protected override void OnClosed()
        {
            if (webBrowserElectronicConsent != null)
            {
                webBrowserElectronicConsent.Dispose();
                this.layoutElectronicConsent.Children.Remove(webBrowserElectronicConsent);
                webBrowserElectronicConsent = null;
            }
        }

        public void OpenWebBrowser(string source, string targetName, byte[] postData, string additionalHeader)
        {
            webBrowserElectronicConsent = new WebBrowser();

            webBrowserElectronicConsent.ObjectForScripting = new CanScriptingObject(this, "WebProperty");
            webBrowserElectronicConsent.Navigate(source, targetName, postData, additionalHeader);
            this.layoutElectronicConsent.Children.Add(webBrowserElectronicConsent);
        }

        #endregion

        #region 전자동의서 출력시 리턴 메세지를 받을 Property
        private String webProperty; //전자동의서 출력시 리턴 메시지를 받을 Property

        /// <summary>
        /// 웹 프로퍼티
        /// </summary>
        public String WebProperty
        {
            get { return webProperty; }
            set
            {
                this.webProperty = value;

                //웹을 닫는 경우 창을 닫는다.
                if (value != null && value.Equals("CLOSE"))
                {
                    this.Close();
                }
                else
                {
                    if (value != null)
                    {
                        String[] splitValue = value.Split('^');

                        if (splitValue[0] == "GetPrintingLog")
                        {
                            this.GetPrintingLog(WebProperty);
                        }
                        else
                        {
                            new ElectronicConsentFormControlEvent().GetReturnMessage(WebProperty, this.webBrowserElectronicConsent, this);
                        }
                    }
                }
            }
        }
        #endregion

        #region : Dispose

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this); // 이 코드를 넣습니다.
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                #region : 개체 별 메모리 해제
                // 이 부분에 각 메모리 해제 코드를 넣습니다. #1.3 부록 참조
                this.CommandBindings.Clear();
                SessionManager.ChangedGlobalPatientInfo -= SessionManager_ChangedGlobalPatientInfo;

                #endregion
            }
        }

        //파괴자(종료자)
        ~SelectIntegrationMedicalRecordAsk()
        {
            Dispose(false);
        }

        #endregion

        #region [Event Handlers]

        #region : SessionManager_ChangedGlobalPatientInfo - 환자선택이 변경될 경우 발생합니다.
        /// <summary>
        /// 환자정보 변경
        /// </summary>
        void SessionManager_ChangedGlobalPatientInfo()
        {
            //model.Load();
            if (string.IsNullOrEmpty(model.CALLER))
                this.RegisterSingleJob("조회 중입니다...", null, CallbackLoad);

        }

        void CallbackLoad()
        {
            Dispatcher.BeginInvoke(System.Windows.Threading.DispatcherPriority.Normal
                            , new Action(delegate () { model.Load(); })
                            );

        }

        /// <summary>
        /// 타메인 화면에서 환자변경할때, 환자선택 사유창 떠야하는 경우 호출하는 메서드. 2021.05.12 추가
        /// </summary>
        public void ChangePatientInfo(String sCaller, String sPt_no, String sChg_Yn)
        {
            if (!string.IsNullOrEmpty(sPt_no) && sChg_Yn == "Y")
            {
                model.CALLER = sCaller;
                model.PT_NO = sPt_no;
                txtPT_NO.Text = sPt_no;
                model.CHGYN = sChg_Yn;

                this.RegisterSingleJob("조회 중입니다...", null, CallbackLoad);
            }
        }

        /*
        /// <summary>
        /// 환자정보 변경
        /// </summary>
        public void ChangePatientInfo(String sCaller, String sPt_no)
        {
            model.CALLER = sCaller;
            model.PT_NO = sPt_no;

            if (!string.IsNullOrEmpty(model.PT_NO)) // 2013-08-23 김정훈 : 환자정보가 없는 경우 갱신하지 않음(PACS)
                this.RegisterSingleJob("조회 중입니다...", null, CallbackLoad);
        }

        /// <summary>
        /// WEB으로 접근하는 XBAP에서 RELOAD가 필요한 경우 실행되는 메서드
        /// </summary>
        public override void OnReLoadedCompleted(string args)
        {
            //args : CALLER^환자번호
            //ex> PACS^88888888
            string[] arrParam = args.Split('^');
            ChangePatientInfo(arrParam[0], arrParam[1]);
        }
        */
        #endregion

        /// <summary>
        /// flowDocumentViewer의 뷰모드 변경 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void flowDocViewer_ViewModeChanged(object sender, RoutedEventArgs e)
        {
            model.ChangeViewMode();
        }

        /// <summary>
        /// FlowDocumentViewerd의 마우스 클릭 이벤트
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void flowDocViewer_PreviewMouseLeftButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            System.Windows.Documents.Paragraph paragraph = e.OriginalSource as System.Windows.Documents.Paragraph;
            System.Windows.Documents.Run run = e.OriginalSource as System.Windows.Documents.Run;
            System.Windows.Documents.FlowDocument flowDocument = e.OriginalSource as System.Windows.Documents.FlowDocument;

            Image newImage = e.OriginalSource as Image;

            //블락지정 버그로, 로직 수정 2021.05.12
            //string stSoure = "";
            //if (e.OriginalSource != null)
            //{
            //    stSoure = e.OriginalSource.ToString();
            //}

            //권한이 있는경우만 블락지정 가능하도록 수정
            if (!this.model.RecordCopyEnabled)
            {

                //블락지정 버그로, 로직 수정 2021.05.12
                //if ((!String.IsNullOrEmpty(stSoure) && stSoure.IndexOf("Documents") > 0) || newImage != null)
                //{
                //    e.Handled = true;
                //}
                //else
                //{
                //    e.Handled = false;
                //}

                // 원 로직 주석처리
                if (paragraph != null || run != null || flowDocument != null || newImage != null)
                    e.Handled = true;
                //.ReleaseMouseCapture(); 
                else
                    e.Handled = false;
            }

            if (newImage != null)
            {
                if (e.OriginalSource is InlineTableCellImage)
                {
                    OpenImageView((e.OriginalSource as InlineTableCellImage).OriginalUriSource.ToString());
                }
                else
                {
                    if (newImage.Tag != null)
                    {
                        OpenImageView(newImage.Tag.ToString());
                    }
                }

            }
        }

        #region HISMessage처리샘플 받는 쪽
        public override void OnReceiveHISMessage(Hashtable message)
        {
            foreach (DictionaryEntry entry in message)
            {
                if (string.Equals(entry.Key, this.EAM_INFO.MENU_CD) || string.Equals(entry.Key, "*"))
                {
                    HISMessageAgent agent = entry.Value as HISMessageAgent;
                    if (agent != null)
                    {
                        agent.Invoke(this);
                        agent.Invoke(this.model);
                    }
                }
            }
        }
        #endregion  HISMessage처리샘플 받는 쪽

        // FLOWDOCUMENT를 HTML로 변환합니다.
        private void HButton_Click(object sender, RoutedEventArgs e)
        {
            System.IO.File.WriteAllText(@"D:\html.html", HtmlConverter.ConvertFlowDocuToHtml(this.flowDocViewer.Document));
            System.IO.File.WriteAllText(@"D:\flowdoc.txt", System.Windows.Markup.XamlWriter.Save(this.flowDocViewer.Document));
        }

        // Garbage Collection을 수행합니다.
        private void GC_Click(object sender, RoutedEventArgs e)
        {
            GC.Collect(GC.MaxGeneration);
            GC.SuppressFinalize(this);
            GC.Collect(GC.MaxGeneration);

        }

        private void OpenImageView(String url)
        {
            if (String.IsNullOrEmpty(url))
                return;

            SelectImageViewPopup popupContent = HIS.MC.Core.Common.Controls.Util.GetUserControl("SelectImageViewPopup") as SelectImageViewPopup;

            if (popupContent == null)
            {
                // this 의 최 상위 Window 추출
                //Window win = Window.GetWindow(this);
                string assmebly = "HIS.MC.DR.RM.RS.UI";
                string path = "SelectImageViewPopup.xaml";
                PopUpBase pop = new PopUpBase(assmebly, path);

                //{#} 추후 메인타일의 위치에 따라 팝업 위치조정필요
                pop.Top = (SystemParameters.WorkArea.Height - pop.Height) / 2 + SystemParameters.WorkArea.Top + 20;//창 중앙에 위치
                pop.Left = (SystemParameters.WorkArea.Width - pop.Width) / 2 + SystemParameters.WorkArea.Left;//창 중앙에 위치
                pop.Width = (pop.Content as UserControlBase).DesignWidth;// 띄울 창 폭 사이즈에 맞게
                pop.Height = (pop.Content as UserControlBase).DesignHeight;//띄울 창 높이 사이즈에 맞게

                // 진료기록 작성창 팝업
                pop.Show();

                // 팝업의 부모를 this 의 Window 로 설정
                //pop.Owner = win;
                pop.ShowInTaskbar = false;

                popupContent = pop.Content as SelectImageViewPopup;
                popupContent.LoadImageInPanel(url);
                popupContent.ImgPrtVisible(this.model.PrintingAskChecked);
            }
            else
            {
                //기존에 열려있는 팝업은 닫고..새로 오픈한다...
                popupContent.PopClose();

                // this 의 최 상위 Window 추출
                //Window win = Window.GetWindow(this);
                string assmebly = "HIS.MC.DR.RM.RS.UI";
                string path = "SelectImageViewPopup.xaml";
                PopUpBase pop = new PopUpBase(assmebly, path);

                pop.Top = (SystemParameters.WorkArea.Height - pop.Height) / 2 + SystemParameters.WorkArea.Top + 20;//창 중앙에 위치
                pop.Left = (SystemParameters.WorkArea.Width - pop.Width) / 2 + SystemParameters.WorkArea.Left;//창 중앙에 위치
                pop.Width = (pop.Content as UserControlBase).DesignWidth;// 띄울 창 폭 사이즈에 맞게
                pop.Height = (pop.Content as UserControlBase).DesignHeight;//띄울 창 높이 사이즈에 맞게
                                                                           // 진료기록 작성창 팝업
                pop.Show();
                // 팝업의 부모를 this 의 Window 로 설정
                //pop.Owner = win;
                pop.ShowInTaskbar = false;

                popupContent = pop.Content as SelectImageViewPopup;
                popupContent.LoadImageInPanel(url);
                popupContent.ImgPrtVisible(this.model.PrintingAskChecked);
            }
        }
        #endregion //Event Handlers      

        private void flowDocViewer_PreviewMouseRightButtonUp(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            MsgBox.Display("마우스 오른쪽 버튼은 사용할 수 없습니다.", MessageType.MSG_TYPE_INFORMATION, TimeSpan: 800);

            e.Handled = true;
        }

        /// <summary>
        /// 출력Log
        /// </summary>
        private void GetPrintingLog(String msg)
        {
            String getData = String.Empty;
            String[] splitMsg = msg.Split('^');

            //받아온 메세지 길이가 1보다 큰 경우에만 추가 작업을 한다.
            if (splitMsg.Length > 1)
            {
                //인덱스 1부터 끝까지의 데이터를 전부 담아놓는다.
                for (int i = 1; i < splitMsg.Length; i++)
                {
                    //값이 비어있지 않은 경우에 구분자 설정
                    if (!String.IsNullOrEmpty(getData))
                    {
                        getData += "^"; //구분자를 재설정한다.
                    }
                    getData += splitMsg[i]; //받아온 이벤트에서 넘겨주는 문자열 데이터
                }
            }

            #region 출력로그

            HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT> printLogList = new HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT>();

            string[] arrPrintLog = getData.Split('^');

            foreach (RecordList_INOUT item in this.model.PrntLog_DTO)
            {
                PrintingLogInformation_INOUT inPrintingLogInfo = new PrintingLogInformation_INOUT();

                inPrintingLogInfo.PRNT_STF_NO = SessionManager.UserInfo.STF_NO; //직원번호
                inPrintingLogInfo.PRNT_STF_MED_DEPT_CD = SessionManager.UserInfo.AOA_WKDP_CD; //직원소속진료과
                inPrintingLogInfo.PRNT_PT_TP_CD = item.PACT_TP_CD; //출력환자구분코드
                inPrintingLogInfo.PT_NO = item.PT_NO; //환자번호
                inPrintingLogInfo.PT_HME_DEPT_CD = item.PT_MED_DEPT_CD; //환자수진부서코드
                inPrintingLogInfo.PACT_ID = item.PACT_ID; //원무접수ID
                inPrintingLogInfo.PRNT_TP_CD = arrPrintLog[8]; //출력구분코드
                inPrintingLogInfo.PRNT_REC_LCLS_CD = "DR"; //출력기록대분류코드
                inPrintingLogInfo.PRNT_REC_SCLS_CD = "D033"; //출력기록소분류코드
                inPrintingLogInfo.PRNT_DTL_CNTE = ""; //출력상세내용
                inPrintingLogInfo.PRNT_RSN_CD = ""; //출력사유코드
                inPrintingLogInfo.PRNT_HIS_PRGM_TP_CD = "AGREEMENT"; //출력사유코드(AGREEMENT : 전자동의서)            
                inPrintingLogInfo.MDRC_ID = Convert.ToString(item.MDRC_ID); //진료기록ID
                inPrintingLogInfo.MDRC_FOM_SEQ = Convert.ToString(item.MDRC_FOM_SEQ); //진료기록개정순번
                inPrintingLogInfo.PRNT_PRD_STR_DT = CommonServiceAgent.SelectSysDate(); //출력기간시작일자
                inPrintingLogInfo.PRNT_PRD_END_DT = CommonServiceAgent.SelectSysDate(); //출력기간종료일자
                inPrintingLogInfo.WRT_DTM = item.WRITING_DATE; //작성일시

                printLogList.Add(inPrintingLogInfo);
            }

            PrintingLogManagement prntObj = new PrintingLogManagement();

            PrintingLogInformation_INOUT result = prntObj.InsertPrintingLogInformation(printLogList, this.model);
            #endregion 출력로그

            if (result != null)
            {
                this.webBrowserElectronicConsent.InvokeScript("GetMessage", "Y", "PrntLogYn");
            }

        }
    }
}
