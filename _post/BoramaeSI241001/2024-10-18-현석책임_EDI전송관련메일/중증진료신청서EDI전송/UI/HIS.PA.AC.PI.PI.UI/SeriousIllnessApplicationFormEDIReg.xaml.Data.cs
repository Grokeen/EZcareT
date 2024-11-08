using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;
using HIS.Core.Common;
using HIS.PA.CORE.UI.LOADER;
using HIS.PA.CORE.UI.UTIL;
using HIS.UI.Base;
using HSF.Controls.WPF;
using HSF.Controls.WPF.Extension;
using HSF.TechSvc2010.Common;

using HIS.UI.Core;
using HIS.UI.Core.Commands;
using HIS.UI.Utility;
using HIS.Core.Global.DTO;
using Microsoft.Win32;
using HIS.PA.AC.PI.PI.DTO;
using HSF.Controls.WPF.Calendars;

namespace HIS.PA.AC.PI.PI.UI
{
    /// <summary>
    /// name         : 논리 UI Data 클래스 명
    /// desc         : UI Data 클래스 개요
    /// author       : kwonwookju 
    /// create date  : 2012-04-13 오후 1:36:04
    /// update date  : 최종 수정일자 , 수정자, 수정개요
    /// </summary>
    public class SeriousIllnessApplicationFormEDIRegData : ViewModelBase
    {
        #region 커멘드
        public ICommand LoadCommand
        {
            get { return loadCommand ?? (loadCommand = new RelayCommand(Load)); }
        }
        private ICommand loadCommand;

        #endregion

        #region 프로퍼티


        public SelSeriousIllnessApplicationFormEDIReg2_IN SelSeriousIllnessApplicationFormEDIReg2_IN
        {
            get { return selSeriousIllnessApplicationFormEDIReg2_IN; }
            set { if (selSeriousIllnessApplicationFormEDIReg2_IN != value) { selSeriousIllnessApplicationFormEDIReg2_IN = value; this.OnPropertyChanged("SelSeriousIllnessApplicationFormEDIReg2_IN"); } }
        }
        private SelSeriousIllnessApplicationFormEDIReg2_IN selSeriousIllnessApplicationFormEDIReg2_IN = new SelSeriousIllnessApplicationFormEDIReg2_IN();

        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg2_OUT> SelSeriousIllnessApplicationFormEDIReg2_OUT
        {
            get { return selSeriousIllnessApplicationFormEDIReg2_OUT; }
            set
            {
                if (selSeriousIllnessApplicationFormEDIReg2_OUT != value)
                {
                    selSeriousIllnessApplicationFormEDIReg2_OUT = value;
                    this.OnPropertyChanged("SelSeriousIllnessApplicationFormEDIReg2_OUT");

                }
            }
        }
        private HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg2_OUT> selSeriousIllnessApplicationFormEDIReg2_OUT = new HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg2_OUT>();

        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT> SelSeriousIllnessApplicationFormEDIReg3_OUT
        {
            get { return selSeriousIllnessApplicationFormEDIReg3_OUT; }
            set { if (selSeriousIllnessApplicationFormEDIReg3_OUT != value) { selSeriousIllnessApplicationFormEDIReg3_OUT = value; this.OnPropertyChanged("SelSeriousIllnessApplicationFormEDIReg3_OUT"); } }
        }
        private HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT> selSeriousIllnessApplicationFormEDIReg3_OUT = new HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT>();

        public UpdSeriousIllnessApplicationFormEDIReg2_OUT UpdSeriousIllnessApplicationFormEDIReg2_OUT
        {
            get { return updSeriousIllnessApplicationFormEDIReg2_OUT; }
            set { if (updSeriousIllnessApplicationFormEDIReg2_OUT != value) { updSeriousIllnessApplicationFormEDIReg2_OUT = value; this.OnPropertyChanged("UpdSeriousIllnessApplicationFormEDIReg2_OUT"); } }
        }
        private UpdSeriousIllnessApplicationFormEDIReg2_OUT updSeriousIllnessApplicationFormEDIReg2_OUT = new UpdSeriousIllnessApplicationFormEDIReg2_OUT();

        public UpdSeriousIllnessApplicationFormEDIReg2_IN UpdSeriousIllnessApplicationFormEDIReg2_IN
        {
            get { return updSeriousIllnessApplicationFormEDIReg2_IN; }
            set { if (updSeriousIllnessApplicationFormEDIReg2_IN != value) { updSeriousIllnessApplicationFormEDIReg2_IN = value; this.OnPropertyChanged("UpdSeriousIllnessApplicationFormEDIReg2_IN"); } }
        }
        private UpdSeriousIllnessApplicationFormEDIReg2_IN updSeriousIllnessApplicationFormEDIReg2_IN = new UpdSeriousIllnessApplicationFormEDIReg2_IN();

        public InsSeriousIllnessApplicationFormEDIReg_IN InsSeriousIllnessApplicationFormEDIReg_IN
        {
            get { return insSeriousIllnessApplicationFormEDIReg_IN; }
            set { if (insSeriousIllnessApplicationFormEDIReg_IN != value) { insSeriousIllnessApplicationFormEDIReg_IN = value; this.OnPropertyChanged("InsSeriousIllnessApplicationFormEDIReg_IN"); } }
        }
        private InsSeriousIllnessApplicationFormEDIReg_IN insSeriousIllnessApplicationFormEDIReg_IN = new InsSeriousIllnessApplicationFormEDIReg_IN();

        public InsSeriousIllnessApplicationFormEDIReg_OUT InsSeriousIllnessApplicationFormEDIReg_OUT
        {
            get { return insSeriousIllnessApplicationFormEDIReg_OUT; }
            set { if (insSeriousIllnessApplicationFormEDIReg_OUT != value) { insSeriousIllnessApplicationFormEDIReg_OUT = value; this.OnPropertyChanged("InsSeriousIllnessApplicationFormEDIReg_OUT"); } }
        }
        private InsSeriousIllnessApplicationFormEDIReg_OUT insSeriousIllnessApplicationFormEDIReg_OUT = new InsSeriousIllnessApplicationFormEDIReg_OUT();

        public SelSeriousIllnessApplicationFormEDIReg1_IN SelSeriousIllnessApplicationFormEDIReg1_IN
        {
            get { return selSeriousIllnessApplicationFormEDIReg1_IN; }
            set { if (selSeriousIllnessApplicationFormEDIReg1_IN != value) { selSeriousIllnessApplicationFormEDIReg1_IN = value; this.OnPropertyChanged("SelSeriousIllnessApplicationFormEDIReg1_IN"); } }
        }
        private SelSeriousIllnessApplicationFormEDIReg1_IN selSeriousIllnessApplicationFormEDIReg1_IN = new SelSeriousIllnessApplicationFormEDIReg1_IN();

        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_OUT
        {
            get { return selSeriousIllnessApplicationFormEDIReg1_OUT; }
            set { if (selSeriousIllnessApplicationFormEDIReg1_OUT != value) { selSeriousIllnessApplicationFormEDIReg1_OUT = value; this.OnPropertyChanged("SelSeriousIllnessApplicationFormEDIReg1_OUT"); } }
        }
        private HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> selSeriousIllnessApplicationFormEDIReg1_OUT = new HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>();

        public UpdSeriousIllnessApplicationFormEDIReg1_IN UpdSeriousIllnessApplicationFormEDIReg1_IN
        {
            get { return updSeriousIllnessApplicationFormEDIReg1_IN; }
            set { if (updSeriousIllnessApplicationFormEDIReg1_IN != value) { updSeriousIllnessApplicationFormEDIReg1_IN = value; this.OnPropertyChanged("UpdSeriousIllnessApplicationFormEDIReg1_IN"); } }
        }
        private UpdSeriousIllnessApplicationFormEDIReg1_IN updSeriousIllnessApplicationFormEDIReg1_IN = new UpdSeriousIllnessApplicationFormEDIReg1_IN();

        public UpdSeriousIllnessApplicationFormEDIReg1_OUT UpdSeriousIllnessApplicationFormEDIReg1_OUT
        {
            get { return updSeriousIllnessApplicationFormEDIReg1_OUT; }
            set { if (updSeriousIllnessApplicationFormEDIReg1_OUT != value) { updSeriousIllnessApplicationFormEDIReg1_OUT = value; this.OnPropertyChanged("UpdSeriousIllnessApplicationFormEDIReg1_OUT"); } }
        }
        private UpdSeriousIllnessApplicationFormEDIReg1_OUT updSeriousIllnessApplicationFormEDIReg1_OUT = new UpdSeriousIllnessApplicationFormEDIReg1_OUT();

        public bool IsCheck_DP
        {
            get { return ischeckdp; }
            set { if (ischeckdp != value) { ischeckdp = value; this.OnPropertyChanged("IsCheck_DP"); } }
        }
        private bool ischeckdp = true;


        public DateTime FromDate
        {
            get { return fromdate; }
            set { if (fromdate != value) { fromdate = value; this.OnPropertyChanged("FromDate"); } }
        }
        private DateTime fromdate;


        public DateTime ToDate
        {
            get { return todate; }
            set { if (todate != value) { todate = value; this.OnPropertyChanged("ToDate"); } }
        }
        private DateTime todate;



        #endregion

        private UserControlBase foundBase = null;

        private HDataGridEx grid1 = null;
        private HDataGridEx grid2 = null;

        private HCheckBox chkSignMissing = null;

        private HButton btnSearhCommand1 = null;
        private HButton btnSearhCommand2 = null;
        private HButton btnInsertCommand = null;

        private HButton btnOpenCommand = null;
        private HButton btnUpLoadCommand = null;
        private HButton btnCloseCommand1 = null;
        private HButton btnRcvCommand = null;

        private HTextBox txtGridCount1 = null;
        private HTextBox txtGridCount2 = null;
        private UserControl txtPtno = null;

        private HCheckBox chbSendFg = null;
        private HFromToCalendar ftc = null;

        private HRadioButton rdocncr = null;
        private HRadioButton rdocfsc = null;
        private HRadioButton rdotb = null;
        private HRadioButton rdolt = null;

        
        //private HRadioButton rdocfsc = null;

        private readonly string 필터 = "Text 파일 (*.txt)|*.txt|sam 파일(*.sam)|*.sam| All files (*.*)|*.*";
        private readonly string 건수 = "건수 : ";
        private readonly string 건조회 = "건 조회";
        private readonly string 매칭 = "건 매칭";
        private readonly string 생성 = "생성";
        //private readonly string 중증신청서 = "중증신청서_";
        private readonly string 암환자등록증 = "11100079_암환자등록증_";
        //private readonly string 지사 = "성남남부지사";
        //private readonly string 전화 = "031-788-4114";
        private readonly string N = "N";
        //private readonly string Y = "Y";
        private readonly string C = @"C:\";
        //private readonly string TXT = ".txt";
        private readonly string SAM = ".sam";
        private readonly string 업로드 = "업로드";
        
        public void Load(object param)
        {
            foundBase = param as UserControlBase;

            grid1 = ControlHelper.FindChild<HDataGridEx>(foundBase, "grid1");
            grid2 = ControlHelper.FindChild<HDataGridEx>(foundBase, "grid2");

            chkSignMissing = ControlHelper.FindChild<HCheckBox>(foundBase, "chkSignMissing");
            btnSearhCommand1 = ControlHelper.FindChild<HButton>(foundBase, "btnSearhCommand1");
            btnSearhCommand2 = ControlHelper.FindChild<HButton>(foundBase, "btnSearhCommand2");
            btnInsertCommand = ControlHelper.FindChild<HButton>(foundBase, "btnInsertCommand");

            btnOpenCommand = ControlHelper.FindChild<HButton>(foundBase, "btnOpenCommand");
            btnUpLoadCommand = ControlHelper.FindChild<HButton>(foundBase, "btnUpLoadCommand");
            btnCloseCommand1 = ControlHelper.FindChild<HButton>(foundBase, "btnCloseCommand1");
            btnRcvCommand = ControlHelper.FindChild<HButton>(foundBase, "btnRcvCommand");

            txtGridCount1 = ControlHelper.FindChild<HTextBox>(foundBase, "txtGridCount1");
            txtGridCount2 = ControlHelper.FindChild<HTextBox>(foundBase, "txtGridCount2");
            chbSendFg = ControlHelper.FindChild<HCheckBox>(foundBase, "chbSendFg");
            chbSendFg.IsChecked = true;
            ftc = ControlHelper.FindChild<HFromToCalendar>(foundBase, "ftc");

            rdocncr = ControlHelper.FindChild<HRadioButton>(foundBase, "rdocncr");
            rdocfsc = ControlHelper.FindChild<HRadioButton>(foundBase, "rdocfsc");
            rdotb = ControlHelper.FindChild<HRadioButton>(foundBase, "rdotb");
            rdolt = ControlHelper.FindChild<HRadioButton>(foundBase, "rdolt");
            txtPtno = ControlHelper.FindChild<UserControl>(foundBase, "Ptno");
            FromDate = DateTime.Now.AddMonths(-3);
            ToDate = DateTime.Now.AddDays(-1);

            //환자서명 누락건 제외
            if (chkSignMissing != null)
            {
                //IsCheck_DP
            }
            //EDI생성 조회
            if (btnSearhCommand1 != null)
            {
                btnSearhCommand1.Click += delegate (object sender, RoutedEventArgs e)
                {
                    //Loader.LoadingBar.ON();
                    //new Thread(() =>
                    {
                        
                        //SelSeriousIllnessApplicationFormEDIReg1_IN.IN_SIGNYN = (IsCheck_DP == true) ? Y : N;
                        SelSeriousIllnessApplicationFormEDIReg1_IN.SENDFG = (chbSendFg.IsChecked == true) ? "1" : "0";
                        SelSeriousIllnessApplicationFormEDIReg1_IN.FROMDATE = ftc.FromDate.ToString().Substring(0, 10).Replace("-", "");
                        SelSeriousIllnessApplicationFormEDIReg1_IN.TODATE = ftc.ToDate.ToString().Substring(0, 10).Replace("-", "");
                        SelSeriousIllnessApplicationFormEDIReg1_IN.IN_PT_NO = ((HIS.PA.CORE.UI.PACodeAsk)txtPtno).SelectedTextCode;

                        //SelSeriousIllnessApplicationFormEDIReg1_OUT =
                        //    Loader.BeginInvokeService(this, foundBase,
                        //                                "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "SelSeriousIllnessApplicationFormEDIReg1",
                        //                                SelSeriousIllnessApplicationFormEDIReg1_IN)
                        //                                as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg1_OUT>;
                        if (rdocncr.IsChecked == true)
                        {
                            SelSeriousIllnessApplicationFormEDIReg1_OUT = UIMiddlewareAgent.InvokeBizService(
                                this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "SelSeriousIllnessApplicationFormEDIReg1_0", SelSeriousIllnessApplicationFormEDIReg1_IN)
                                 as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
                        }
                        else if (rdocfsc.IsChecked == true)
                        {
                            SelSeriousIllnessApplicationFormEDIReg1_OUT = UIMiddlewareAgent.InvokeBizService(
                                this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "SelSeriousIllnessApplicationFormEDIReg1_1", SelSeriousIllnessApplicationFormEDIReg1_IN)
                                 as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
                        }
                        else if (rdotb.IsChecked == true)
                        {
                            SelSeriousIllnessApplicationFormEDIReg1_OUT = UIMiddlewareAgent.InvokeBizService(
                                this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "SelSeriousIllnessApplicationFormEDIReg1_2", SelSeriousIllnessApplicationFormEDIReg1_IN)
                                 as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
                        }
                        else
                        {// 잠복결핵
                            SelSeriousIllnessApplicationFormEDIReg1_OUT = UIMiddlewareAgent.InvokeBizService(
                                this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "SelSeriousIllnessApplicationFormEDIReg1_3", SelSeriousIllnessApplicationFormEDIReg1_IN)
                                 as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
                        }

                        if (SelSeriousIllnessApplicationFormEDIReg1_OUT.Count == 0)
                        {
                            MsgBox.Display("PAMVB_000001", MessageType.MSG_TYPE_INFORMATION, VariableMessages: new string[] { "해당기관에 대상자가 없습니다." }); // ["{0}"]
                            return;
                        }

                        IsBtnInsertCommand(true);

                        for (int i = 0; i < SelSeriousIllnessApplicationFormEDIReg1_OUT.Count; i++)
                        {
                            if (SelSeriousIllnessApplicationFormEDIReg1_IN.SENDFG == "Y" && SelSeriousIllnessApplicationFormEDIReg1_OUT[i].SENDYN == "Y")
                            {
                                SelSeriousIllnessApplicationFormEDIReg1_OUT.RemoveAt(i - 1);
                                i = i - 1;
                                continue;
                            }

                            if (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].MSG != "")
                            {
                                SelSeriousIllnessApplicationFormEDIReg1_OUT[i].MSG = "P";
                            }


                        }


                        if (txtGridCount1 != null)
                            txtGridCount1.Dispatcher.Invoke(new Action(() => txtGridCount1.Text = 건수 + SelSeriousIllnessApplicationFormEDIReg1_OUT.Count.ToString() + 건조회));

                        //if (SelSeriousIllnessApplicationFormEDIReg1_OUT.Count > 0 && IsCheck_DP == false)
                        //IsBtnInsertCommand(true);
                        //else
                        //    IsBtnInsertCommand(false);
                    };
                    //).Start();
                };
            }
            //중증신청서 생성
            if (btnInsertCommand != null)
            {
                btnInsertCommand.Click += delegate (object sender, RoutedEventArgs e)
                {

                    //주요 체크 항목 로직 추가 2022.04.11
                    if (selSeriousIllnessApplicationFormEDIReg1_OUT.Count != selSeriousIllnessApplicationFormEDIReg1_OUT.Distinct().GroupBy(i=>i.DOCTOR_NOTE_ID).Count())
                    {
                        foreach(SelSeriousIllnessApplicationFormEDIReg4_OUT a in selSeriousIllnessApplicationFormEDIReg1_OUT)
                        {
                            MsgBox.Display("환자번호 : " + a.PT_NO + " 의 신청서가 이중 등록 됐습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                            return;
                        }
                    }

                    MsgBox.Display("EDI용 파일을 생성 합니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);

                    //Loader.LoadingBar.ON();
                    //new Thread(() =>
                    {
                        string dir = C;
                        string filePath = System.IO.Path.Combine(dir, 암환자등록증 + CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMddHHmmss") + SAM);
                        string FileText = "";
                        int padLen = 0;
                        int count = 0;

                        if (rdocncr.IsChecked == true)
                        {
                            filePath = System.IO.Path.Combine(dir, "11100079_암환자등록증_" + CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMddHHmmss") + SAM);
                        }
                        else if(rdocfsc.IsChecked == true) {
                            filePath = System.IO.Path.Combine(dir, "11100079_희귀중증환자등록증_" + CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMddHHmmss") + SAM);
                        }
                        else if (rdotb.IsChecked == true) {
                            filePath = System.IO.Path.Combine(dir, "11100079_결핵환자등록증_" + CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMddHHmmss") + SAM);
                        }
                        else if (rdolt.IsChecked == true) {
                            filePath = System.IO.Path.Combine(dir, "11100079_잠복결핵환자등록증_" + CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMddHHmmss") + SAM);
                        }

                        if (!File.Exists(filePath))
                        { File.Delete(filePath); }

                        using (StreamWriter streamWriter = new StreamWriter(filePath, false, Encoding.Default))
                        {
                            for (int i = 0; i < grid1.Items.Count; i++)
                            {
                                FileText = "";
                                UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_PT_NO = (grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg4_OUT).PT_NO;

                                UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE = (grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg4_OUT).C12;

                                UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_AIDYN = (grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg4_OUT).AIDYN;
                                UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_DOCTOR_NOTE_ID = (grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg4_OUT).DOCTOR_NOTE_ID;

                                if (rdocncr.IsChecked == true && UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE == "1") // 1 암
                                {
                                    if (!string.IsNullOrEmpty(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1))
                                        // 2021-07-28 백명수 보험증번호에 11자리 이상 입력하는 케이스가 종종 있어서 강제로 11자리로 셋팅
                                        //FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Length); //1.건강보험 증번호
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, 11); //1.건강보험 증번호
                                    else
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1; //1.건강보험 증번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "");                       //2.가입자(세대주)성명
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "");                       //3.수진자성명 
                                    padLen = 13 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "");                       //4.수진자주민번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "");                       //5.휴대전화번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "");                       //6.자택전화번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "");                       //7.우편번호
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "");                       //8.주소(기본)
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "");                       //9.주소(상세)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "");                     //10.등록결과통보방법(1(SMS), 2(E-MAIL))
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "");                     //11.이메일주소
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "");                     //12.질환구분(1 암)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "");                     //13.신청구분(1(신규), 2(재등록), 3 (중복암), 4(중복암재등록)) 
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "");                     //14.진료과목
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "");                     //15.진료구분(1:입원, 2:외래)
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "");                     //16.진단확진일자
                                    padLen = 4 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "");                     //17.특정기호

                                    //2021-08-12 백명수 원발전이여부... 체크하기
                                    if (!string.IsNullOrEmpty(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim()))
                                    {
                                        padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "")).Length;

                                        if (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim().Substring(0,3) == "C77" ||
                                           SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim().Substring(0, 3) == "C78" ||
                                           SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim().Substring(0, 3) == "C79")
                                        {
                                            
                                            FileText += "".PadLeft(padLen) + "2";                     //18.원발전이여부
                                        }
                                        else
                                        {
                                            FileText += "".PadLeft(padLen) + "1";                     //18.원발전이여부
                                        }
                                    }

                                    //padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "")).Length;
                                    //FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "");                     //18.원발전이여부

                                    padLen = 7 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim() : "");                     //19.상병코드
                                    padLen = 3 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "");                     //20.상병코드 중복연번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "");                     //21.최종확진방법_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "");                     //22.최종확진방법_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "");                     //23.최종확진방법_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "");                     //24.최종확진방법_3_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "");                     //25.최종확진방법_3_2번
                                    padLen = 80 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "");                     //26.최종확진방법_3_2번내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "");                     //27.최종확진방법_3_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "");                     //28.최종확진방법_3_4번
                                    padLen = 80 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "");                     //29.최종확진방법_3_4번내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "");                     //30.최종확진방법_4번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "");                     //31.최종확진방법_4_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "");                     //32.최종확진방법_4_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "");                     //33.최종확진방법_4_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "");                     //34.최종확진방법_5번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "");                     //35.최종확진방법_6번
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "");                     //36.최종확진방법_6번내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "");                     //37.조직검사 세포검사 미실시 사유_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38.Trim() : "");                     //38.조직검사 세포검사 미실시 사유_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39.Trim() : "");                     //39.조직검사 세포검사 미실시 사유_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40.Trim() : "");                     //40.조직검사 세포검사 미실시 사유_4번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41.Trim() : "");                     //41.조직검사 세포검사 미실시 사유_5번
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim() : "")).Length;
                                    // 2021-10-22 백명수 강제 자르기 추가
                                    if (padLen < 0)
                                    {
                                        padLen = 0;
                                        byte[] byteTmp = Encoding.Default.GetBytes(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim());
                                        string retVal = Encoding.Default.GetString(byteTmp, 0, 120);
                                        FileText += "".PadLeft(padLen) + retVal;                     //43.환자상태 및 진료소견
                                    }
                                    else
                                    {
                                        FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim() : "");                     //42.조직검사 세포검사 미실시 사유_5번 내용
                                    }

                                    //FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim() : "");                     //42.조직검사 세포검사 미실시 사유_5번 내용
                                    padLen = 400 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43.Trim() : "")).Length;
                                    // 2021-07-21 백명수 내용이 400을 넘어가는 현상이 나타남.. 강제로 자르기 추가
                                    if (padLen < 0)
                                    {
                                        padLen = 0;
                                        byte[] byteTmp = Encoding.Default.GetBytes(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43.Trim());
                                        string retVal = Encoding.Default.GetString(byteTmp, 0, 400);
                                        FileText += "".PadLeft(padLen) + retVal;                     //43.환자상태 및 진료소견
                                    }
                                    else
                                    {
                                        FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43.Trim() : "");                     //43.환자상태 및 진료소견
                                    }
                                    
                                    padLen = 50 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44.Trim() : "");                     //44.요양기관명
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45.Trim() : "");                     //45.요양기관기호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46.Trim() : "");                     //46.입력자 주민번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim() : "");                     //47.의사면허번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48.Trim() : "");                     //48.담당의사성명
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49.Trim() : "");                     //49.전문의자격번호
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50.Trim() : "");                     //50.담당의사전문과목
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51.Trim() : "")).Length;
                                    //FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51.Trim() : "");                     //51.신청자 성명
                                    // 2022-04-11 백명수 신청자성명 외국인 이름 강제로 자르기 추가
                                    if (padLen < 0)
                                    {
                                        padLen = 0;
                                        byte[] byteTmp = Encoding.Default.GetBytes(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51.Trim());
                                        string retVal = Encoding.Default.GetString(byteTmp, 0, 20);
                                        FileText += "".PadLeft(padLen) + retVal;                     // 51.신청자 성명
                                    }
                                    else
                                    {
                                        FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51.Trim() : "");                 //51.신청자 성명
                                    }

                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52.Trim() : "");                     //52.수진자와의 관계
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53.Trim() : "");                     //53.발행일자
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54.Trim() : "");                     //54.신청일자
                                }
                                else if(rdocfsc.IsChecked == true && (
                                                                      UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE == "2" ||
                                                                      UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE == "5" ||
                                                                      UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE == "6" ||
                                                                      UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE == "7" ||
                                                                      UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE == "8" ||
                                                                      UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_REQTYPE == "9"
                                                                     ) 
                                       )  //2 희귀질환, 5 극희귀질환, 6 상세불명희귀질환, 7 중증치매, 8 중증난치, 9 기타염색체 이상질환
                                {
                                    if (!string.IsNullOrEmpty(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1))
                                        // 2021-07-28 백명수 보험증번호에 11자리 이상 입력하는 케이스가 종종 있어서 강제로 11자리로 셋팅
                                        //FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Length); //1.건강보험 증번호
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, 11); //1.건강보험 증번호
                                    else
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1; //1.건강보험 증번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "");                       //2.가입자(세대주)성명
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "");                       //3.수진자성명 
                                    padLen = 13 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "");                       //4.수진자주민번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "");                       //5.휴대전화번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "");                       //6.자택전화번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "");                       //7.우편번호
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "");                       //8.주소(기본)
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "");                       //9.주소(상세)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "");                     //10.등록결과통보방법(1(SMS), 2(E-MAIL))
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "");                     //11.이메일주소
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "");                     //12.질환구분(2(희귀질환), 5(극희귀질환), 6(상세불명희귀질환), 7(중증치매), 8(중증난치), 9(기타염색체 이상질환))
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "");                     //13.신청구분(N:신규등록, Y:재등록) 
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "");                     //14.진료과목
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "");                     //15.진료구분(1:입원, 2:외래)
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "");                     //16.진단확진일자
                                    padLen = 4 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "");                     //17.특정기호
                                    padLen = 7 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "");                     //18.상병코드

                                    //2021-07-28 백명수 V900 극희귀는 연번 자리수가 3자리인데.. 2자리수가 나오면 앞에 0을 붙여야 함...
                                    string C19Tmp = string.Empty;
                                    C19Tmp = SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim();
                                    if (string.IsNullOrEmpty(C19Tmp))
                                    {
                                        padLen = 3;
                                    }
                                    else
                                    {
                                        if (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() == "V900")
                                        {
                                            C19Tmp = ("0" + C19Tmp).Substring(("0" + C19Tmp).Length - 3);
                                        }
                                        
                                        padLen = 3 - Encoding.Default.GetBytes(C19Tmp).Length;
                                    }
                                    //FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim() : "");                     //19.상병코드 중복연번
                                    FileText += "".PadLeft(padLen) + C19Tmp;                                                                                                                                              //19.상병코드 중복연번

                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "");                     //20.최종확진방법_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "");                     //21.최종확진방법_1_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "");                     //22.최종확진방법_1_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "");                     //23.최종확진방법_1_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "");                     //24.최종확진방법_1_4번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "");                     //25.최종확진방법_1_5번
                                    padLen = 80 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "");                     //26.최종확진방법_1_5번 내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "");                     //27.최종확진방법_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "");                     //28.최종확진방법_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "");                     //29.최종확진방법_4번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "");                     //30.최종확진방법_5번
                                    padLen = 80 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "");                     //31.최종확진방법_5번 내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "");                     //32.최종확진방법_6번
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "");                     //33.최종확진방법_6번 내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "");                     //34.가족력 없음
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "");                     //35.가족력 있음
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "");                     //36.가족력_있음_1(조부)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "");                     //37.가족력_있음_2(조모)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38.Trim() : "");                     //38.가족력_있음_3(외조부)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39.Trim() : "");                     //39.가족력_있음_4(외조모)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40.Trim() : "");                     //40.가족력_있음_5(부)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41.Trim() : "");                     //41.가족력_있음_6(모)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim() : "");                     //42.가족력_있음_7(동성형제)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43.Trim() : "");                     //43.가족력_있음_8(이성형제)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44.Trim() : "");                     //44.가족력_있음_9(자)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45.Trim() : "");                     //45.가족력_있음_10(녀)
                                    padLen = 50 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46.Trim() : "");                     //46.요양기관명
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim() : "");                     //47.요양기관기호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48.Trim() : "");                     //48.입력자 주민번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49.Trim() : "");                     //49.의사면허번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50.Trim() : "");                     //50.담당자의사성명
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C51.Trim() : "");                     //51.전문의자격번호
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C52.Trim() : "");                     //52.담당의사전문과목
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53.Trim() : "")).Length;
                                    //FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53.Trim() : "");                     //53.신청자성명
                                    // 2022-04-11 백명수 신청자성명 외국인 이름 강제로 자르기 추가
                                    if (padLen < 0)
                                    {
                                        padLen = 0;
                                        byte[] byteTmp = Encoding.Default.GetBytes(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53.Trim());
                                        string retVal = Encoding.Default.GetString(byteTmp, 0, 20);
                                        FileText += "".PadLeft(padLen) + retVal;                     // 53.신청자 성명
                                    }
                                    else
                                    {
                                        FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C53.Trim() : "");                 //53.신청자 성명
                                    }

                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C54.Trim() : "");                     //54.수진자와의 관계
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C55 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C55.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C55 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C55.Trim() : "");                     //55.발행일자
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C56 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C56.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C56 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C56.Trim() : "");                     //56.신청일자            
                                }
                                else if (rdotb.IsChecked == true ) //결핵
                                {
                                    if (!string.IsNullOrEmpty(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1))
                                        // 2021-07-28 백명수 보험증번호에 11자리 이상 입력하는 케이스가 종종 있어서 강제로 11자리로 셋팅
                                        //FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Length); //1.건강보험 증번호
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, 11); //1.건강보험 증번호
                                    else
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1; //1.건강보험 증번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "");                       //2.가입자(세대주)성명
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "");                       //3.수진자성명 
                                    padLen = 13 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "");                       //4.수진자주민번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "");                       //5.휴대전화번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "");                       //6.자택전화번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "");                       //7.우편번호
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "");                       //8.주소(기본)
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "");                       //9.주소(상세)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "");                     //10.등록결과통보방법(1(SMS), 2(E-MAIL))
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "");                     //11.이메일주소
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "");                     //12.질환구분(3 중증화상, A 결핵)
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "");                     //13.진료과목
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "");                     //14.진료구분(1:입원, 2:외래)
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "");                     //15.진단확진일자
                                    padLen = 4 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "");                     //16.특정기호
                                    padLen = 10 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "");                     //17.상병코드
                                    padLen = 3 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "");                     //18.상병코드 중복연번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim() : "");                     //19.최종확진방법_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "");                     //20.최종확진방법_1_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "");                     //21.최종확진방법_1_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "");                     //22.최종확진방법_1_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "");                     //23.최종확진방법_1_4번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "");                     //24.최종확진방법_1_5번
                                    padLen = 80 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "");                     //25.최종확진방법_1_5번 내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "");                     //26.최종확진방법_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "");                     //27.최종확진방법_2_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "");                     //28.최종확진방법_2_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "");                     //29.최종확진방법_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "");                     //30.최종확진방법_4번
                                    padLen = 80 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "");                     //31.최종확진방법_4번 내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "");                     //32.최종확진방법_5번
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "");                     //33.최종확진방법_5번 내용
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "");                     //34.타요양기관확진_없음
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "");                     //35.타요양기관확진_있음
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "");                     //36.타요양기관확진_있음_1
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "");                     //37.타요양기관확진_있음_2
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C38.Trim() : "");                     //38.타요양기관확진_있음_3
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C39.Trim() : "");                     //39.타요양기관확진_있음_5
                                    padLen = 50 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C40.Trim() : "");                     //40.요양기관명
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C41.Trim() : "");                     //41.요양기관기호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C42.Trim() : "");                     //42.입력자 주민번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C43.Trim() : "");                     //43.의사면허번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C44.Trim() : "");                     //44.담당의사성명
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C45.Trim() : "");                     //45.요양기관기호
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C46.Trim() : "");                     //46.담당의사전문과목
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim() : "")).Length;
                                    //FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim() : "");                     //47.신청자 성명
                                    // 2022-04-11 백명수 신청자성명 외국인 이름 강제로 자르기 추가
                                    if (padLen < 0)
                                    {
                                        padLen = 0;
                                        byte[] byteTmp = Encoding.Default.GetBytes(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim());
                                        string retVal = Encoding.Default.GetString(byteTmp, 0, 20);
                                        FileText += "".PadLeft(padLen) + retVal;                     // 47.신청자 성명
                                    }
                                    else
                                    {
                                        FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C47.Trim() : "");                 //47.신청자 성명
                                    }

                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C48.Trim() : "");                     //48.수진자와의 관계
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C49.Trim() : "");                     //49.발행일자
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C50.Trim() : "");                     //50.신청일자
                                }
                                else //잠복결핵
                                {
                                    if (!string.IsNullOrEmpty(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1))
                                        // 2021-07-28 백명수 보험증번호에 11자리 이상 입력하는 케이스가 종종 있어서 강제로 11자리로 셋팅
                                        //FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Length); //1.건강보험 증번호
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1.Substring(0, 11); //1.건강보험 증번호
                                    else
                                        FileText += SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C1; //1.건강보험 증번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C2.Trim() : "");                       //2.가입자(세대주)성명
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C3.Trim() : "");                       //3.수진자성명 
                                    padLen = 13 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C4.Trim() : "");                       //4.수진자주민번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C5.Trim() : "");                       //5.휴대전화번호
                                    padLen = 14 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C6.Trim() : "");                       //6.자택전화번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C7.Trim() : "");                       //7.우편번호
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C8.Trim() : "");                       //8.주소(기본)
                                    padLen = 120 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C9.Trim() : "");                       //9.주소(상세)
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C10.Trim() : "");                     //10.등록결과통보방법(1(SMS), 2(E-MAIL))
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C11.Trim() : "");                     //11.이메일주소
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C12.Trim() : "");                     //12.질환구분(3 중증화상, A 결핵)
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C13.Trim() : "");                     //13.진료과목
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C14.Trim() : "");                     //14.진료구분(1:입원, 2:외래)
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C15.Trim() : "");                     //15.진단확진일자
                                    padLen = 4 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C16.Trim() : "");                     //16.특정기호
                                    padLen = 10 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C17.Trim() : "");                     //17.상병코드
                                    padLen = 3 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C18.Trim() : "");                     //18.상병코드 중복연번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C19.Trim() : "");                     //19.최종확진방법_1번
                                    padLen = 1- Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C20.Trim() : "");                     //20.최종확진방법_2번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C21.Trim() : "");                     //21.최종확진방법_3번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C22.Trim() : "");                     //22.최종확진방법_4번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C23.Trim() : "");                     //23.최종확진방법_5번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C24.Trim() : "");                     //24.최종확진방법_6번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C25.Trim() : "");                     //25.최종확진방법_6_1번
                                    padLen = 1 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C26.Trim() : "");                     //26.최종확진방법_6_2번
                                    padLen = 50 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C27.Trim() : "");                     //27.요양기관명
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C28.Trim() : "");                     //28.요양기관기호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C29.Trim() : "");                     //29.입력자 주민번호
                                    padLen = 6 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C30.Trim() : "");                     //30.의사면허번호
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C31.Trim() : "");                     //31.담당의사성명
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C32.Trim() : "");                     //32.요양기관기호
                                    padLen = 40 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C33.Trim() : "");                     //33.담당의사전문과목
                                    padLen = 20 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "")).Length;
                                    //FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "");                     //34.신청자 성명
                                    // 2022-04-11 백명수 신청자성명 외국인 이름 강제로 자르기 추가
                                    if (padLen < 0)
                                    {
                                        padLen = 0;
                                        byte[] byteTmp = Encoding.Default.GetBytes(SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim());
                                        string retVal = Encoding.Default.GetString(byteTmp, 0, 20);
                                        FileText += "".PadLeft(padLen) + retVal;                     // 34.신청자 성명
                                    }
                                    else
                                    {
                                        FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C34.Trim() : "");                 //34.신청자 성명
                                    }
                                    padLen = 2 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C35.Trim() : "");                     //35.수진자와의 관계
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C36.Trim() : "");                     //36.발행일자
                                    padLen = 8 - Encoding.Default.GetBytes((SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "")).Length;
                                    FileText += "".PadLeft(padLen) + (SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37 != null ? SelSeriousIllnessApplicationFormEDIReg1_OUT[i].C37.Trim() : "");                     //37.신청일자
                                }

                                //streamWriter.WriteLine((grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg1_OUT).FILETEXT.Substring(0, (grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg1_OUT).FILETEXT.Length - 3));

                                streamWriter.WriteLine(FileText);

                                UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_FROMDATE = FromDate.ToString("yyyyMMdd");
                                UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_TODATE = ToDate.ToString("yyyyMMdd");
                                if (rdocncr.IsChecked == true)
                                {
                                    UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_SRIL_CDOC = "J";
                                }
                                else if (rdocfsc.IsChecked == true)
                                {
                                    UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_SRIL_CDOC = "S";
                                }
                                else if (rdotb.IsChecked == true)
                                {
                                    UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_SRIL_CDOC = "T";
                                }
                                else
                                {
                                    UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_SRIL_CDOC = "L";
                                }
                                
                                UpdSeriousIllnessApplicationFormEDIReg1_IN.IN_PT_NO = ((HIS.PA.CORE.UI.PACodeAsk)txtPtno).SelectedTextCode;
                                int result = (int)UIMiddlewareAgent.InvokeBizService(
                                   this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "UpdSeriousIllnessApplicationFormEDIReg1", UpdSeriousIllnessApplicationFormEDIReg1_IN)
                                    ;
                                if (result == -1)
                                {
                                    count++;
                                }


                                //if (UpdSeriousIllnessApplicationFormEDIReg1_OUT.COUNT != 0)
                                //    (grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg1_OUT).UPDATE_YN = 0;
                                //else
                                //    (grid1.Items[i] as SelSeriousIllnessApplicationFormEDIReg1_OUT).UPDATE_YN = 1;

                                txtGridCount1.Dispatcher.Invoke(new Action(() => txtGridCount1.Text = 건수 + count + "/" + count + 생성));

                                //txtGridCount1.Text = 건수 + SelSeriousIllnessApplicationFormEDIReg1_OUT.Sum(x => x.UPDATE_YN ?? 0).ToString() + "/" + grid1.Items.Count + 생성));
                            }

                            IsBtnInsertCommand(false);
                        }

                        foundBase.Dispatcher.Invoke(new Action(() => MsgBox.Display(txtGridCount1.Text + "중증신청서 생성 완료", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow)));
                    }
                    //).Start();
                };
            }

            //EDI업로드 조회
            if (btnSearhCommand2 != null)
            {
                btnSearhCommand2.Click += delegate (object sender, RoutedEventArgs e)
                {
                    //Loader.LoadingBar.ON();
                    //new Thread(() =>
                    {
                        if (grid2.Items.Count == 0)
                        {
                            //Loader.LoadingBar.OFF();
                            foundBase.Dispatcher.Invoke(
                                new Action(() => MsgBox.Display("조회건 수 가 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow)));

                            return;
                        }

                        for (int i = 0; i < grid2.Items.Count; i++)
                        {
                            SelSeriousIllnessApplicationFormEDIReg2_IN.IN_RRN = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).주민번호;
                            SelSeriousIllnessApplicationFormEDIReg2_IN.IN_REQTYPE = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).중증번호;
                            SelSeriousIllnessApplicationFormEDIReg2_IN.IN_FROMDATE = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).적용개시일;

                            //SelSeriousIllnessApplicationFormEDIReg3_OUT = Loader.BeginInvokeService(this, foundBase,
                            //                                   "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL",
                            //                                   "SelSeriousIllnessApplicationFormEDIReg2",
                            //                                   SelSeriousIllnessApplicationFormEDIReg2_IN)
                            //                                   as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT>;

                            SelSeriousIllnessApplicationFormEDIReg3_OUT = UIMiddlewareAgent.InvokeBizService(
                                   this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "SelSeriousIllnessApplicationFormEDIReg2", SelSeriousIllnessApplicationFormEDIReg2_IN)
                                    as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT>;

                            if (SelSeriousIllnessApplicationFormEDIReg3_OUT.Count != 0)
                            {
                                grid2.Dispatcher.Invoke(new Action(() =>
                                {
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).등록번호 = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].PT_NO;
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).YN = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].YN;
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).APLC_DT = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].APLC_DT;
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).HMPS_POST_NO = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].HMPS_POST_NO;
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).HMPS_POST_NO_SEQ = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].HMPS_POST_NO_SEQ.ToString();
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).HM_DTL_ADDR = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].HM_DTL_ADDR;
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).MDRC_ID = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].MDRC_ID.ToString();
                                    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).APLC_ICD10_DUP_SEQ_CD = SelSeriousIllnessApplicationFormEDIReg3_OUT[0].APLC_ICD10_DUP_SEQ_CD;
                                }));
                            }

                            if (string.IsNullOrEmpty((grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).등록번호))
                                (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).EMPTY_YN = 0;
                            else
                                (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).EMPTY_YN = 1;

                            foundBase.Dispatcher.Invoke(new Action(() => txtGridCount2.Text = 건수 + SelSeriousIllnessApplicationFormEDIReg2_OUT.Sum(x => x.EMPTY_YN ?? 0).ToString() + "/" + grid2.Items.Count + 매칭));
                        }

                        IsBtnUpLoadCommand(true);
                        foundBase.Dispatcher.Invoke(new Action(() => MsgBox.Display("매칭 완료", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow)));

                    };
                    //).Start();
                };
            }



            //중증등록증 화일열기
            if (btnOpenCommand != null)
            {
                btnOpenCommand.Click += delegate (object sender, RoutedEventArgs e)
                {
                    OpenFileDialog openFileDialog = new OpenFileDialog();
                    openFileDialog.InitialDirectory = "C:\\";
                    openFileDialog.Filter = 필터;

                    if ((bool)openFileDialog.ShowDialog())
                    {
                        //Encoding encode = System.Text..GetEncoding("euc-kr");
                        //IsBtnUpLoadCommand(false);
                        SelSeriousIllnessApplicationFormEDIReg2_OUT.Clear();
                        List<string> list = File.ReadAllLines(openFileDialog.FileName, Encoding.Default).ToList<string>();
                        int devidCount;

                        Encoding enc = Encoding.GetEncoding("ks_c_5601-1987");
                        byte[] strBuf;

                        //    StreamReader aa = new StreamReader();
                        //Loader.LoadingBar.ON();
                        //new Thread(() =>
                        {
                            //Loader.InvokeHelper(this, foundBase, new Action(() =>
                            //{
                            foundBase.Dispatcher.Invoke(DispatcherPriority.Send, new Action(() =>
                            {
                                for (int i = 0; i < list.Count; i++)
                                {
                                    strBuf = null;
                                    strBuf = enc.GetBytes(list[i]);

                                    SelSeriousIllnessApplicationFormEDIReg2_OUT tempOut = new SelSeriousIllnessApplicationFormEDIReg2_OUT();
                                    tempOut.등록번호 = string.Empty;
                                    tempOut.보험증번호 = StringHelper.LimitByteLength(list[i], 11);
                                    devidCount = (Encoding.Default.GetByteCount(StringHelper.LimitByteLength(list[i].Substring(11), 20).Trim()) / 2);
                                    tempOut.환자명 = enc.GetString(strBuf, 11, 20);
                                    tempOut.주민번호 = enc.GetString(strBuf, 31, 13);
                                    tempOut.중증번호 = enc.GetString(strBuf, 44, 10);
                                    tempOut.적용개시일 = enc.GetString(strBuf, 54, 8);
                                    //list[i].Substring(606, 8).Trim();
                                    tempOut.적용종료일 = enc.GetString(strBuf, 62, 8);
                                    tempOut.IN_RTNCODE = (enc.GetString(strBuf, 70, 100).Trim()).Substring(0, 2);
                                    tempOut.IN_RTN_MSG = (enc.GetString(strBuf, 70, 100).Trim()).Substring(3);


                                    if (enc.GetString(strBuf, 45, 2).Equals("01")) //중증암
                                    {
                                        tempOut.IN_J3_GUBN = "J3";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("05"))//산정
                                    {
                                        tempOut.IN_J3_GUBN = "SC";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("21"))//희귀질환
                                    {
                                        tempOut.IN_J3_GUBN = "21";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("23"))//중증난치질환
                                    {
                                        tempOut.IN_J3_GUBN = "23";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("14"))//기타염색체 이상질환
                                    {
                                        tempOut.IN_J3_GUBN = "14";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("07"))//결핵
                                    {
                                        tempOut.IN_J3_GUBN = "TB";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("11"))//극희귀
                                    {
                                        tempOut.IN_J3_GUBN = "SS";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("08"))//극희귀
                                    {
                                        tempOut.IN_J3_GUBN = "TC";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("15") || enc.GetString(strBuf, 45, 2).Equals("16"))//중증치매
                                    {
                                        tempOut.IN_J3_GUBN = "SD";
                                    }
                                    else if (enc.GetString(strBuf, 45, 2).Equals("22") )//잠복결핵
                                    {
                                        tempOut.IN_J3_GUBN = "LT";
                                    }
                                    else
                                    {
                                        tempOut.IN_J3_GUBN = "";
                                    }
                                    //StringHelper.LimitByteLength(list[i].Substring(62 - devidCount), 8);

                                    //tempOut.환자명 = StringHelper.LimitByteLength(list[i].Substring(11), 20);
                                    //tempOut.주민번호 = StringHelper.LimitByteLength(list[i].Substring(31), 13);
                                    //tempOut.중증번호 = StringHelper.LimitByteLength(list[i].Substring(44 - devidCount), 10);
                                    //tempOut.적용개시일 = StringHelper.LimitByteLength(list[i].Substring(54 - devidCount), 8);
                                    //tempOut.적용종료일 = StringHelper.LimitByteLength(list[i].Substring(62 - devidCount), 8);
                                    tempOut.YN = string.Empty;

                                    SelSeriousIllnessApplicationFormEDIReg2_OUT.Add(tempOut);


                                    if (txtGridCount2 != null)
                                    {
                                        txtGridCount2.Dispatcher.Invoke(new Action(() => txtGridCount2.Text = 건수 + SelSeriousIllnessApplicationFormEDIReg2_OUT.Count.ToString() + 건조회));
                                    }
                                }
                            }));
                            //}));




                            if (list.Count == 0)
                            {
                                MsgBox.Display("조회건 수 가 없습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow);
                                return;
                            }
                        };
                        //).Start();
                    }
                };
            }
            //업로드
            if (btnUpLoadCommand != null)
            {
                btnUpLoadCommand.Click += delegate (object sender, RoutedEventArgs e)
                {
                    for (int i = 0; i < grid2.Items.Count; i++)
                    {
                        if (!string.IsNullOrEmpty((grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).등록번호)
                        && (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).YN == N)
                        {
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CFMT_NO = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).중증번호;
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_APY_STR_DT = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).적용개시일.Replace("-", "").Trim();
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_APY_END_DT = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).적용종료일.Replace("-", "").Trim();
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_APLC_SNBK_CD_CNTE = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).IN_RTNCODE;
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_APLC_SNBK_MSG_CNTE = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).IN_RTN_MSG;
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_PT_NO = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).등록번호;
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).중증번호.Substring(0, 2);
                            UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_DOCTOR_NOTE_ID = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).MDRC_ID;

                            switch (UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD)
                            {
                                case "01":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "J3";
                                    break;
                                case "05":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "SC";
                                    break;
                                case "21":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "21";
                                    break;
                                case "23":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "23";
                                    break;
                                case "14":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "14";
                                    break;
                                case "07":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "TB";
                                    break;
                                case "11":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "SS";
                                    break;
                                case "08":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "TC";
                                    break;
                                case "15":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "SD";
                                    break;
                                case "16":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "SD";
                                    break;
                                case "22":
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "LT";
                                    break;
                                default:
                                    UpdSeriousIllnessApplicationFormEDIReg2_IN.IN_SRIL_CDOC_APLC_TP_CD = "";
                                    break;
                            }

                            //UpdSeriousIllnessApplicationFormEDIReg2_OUT = Loader.BeginInvokeService(this, foundBase,
                            //                                   "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL",
                            //                                   "UpdSeriousIllnessApplicationFormEDIReg2",
                            //                                   UpdSeriousIllnessApplicationFormEDIReg2_IN)
                            //                                   as UpdSeriousIllnessApplicationFormEDIReg2_OUT;


                            UpdSeriousIllnessApplicationFormEDIReg2_OUT = UIMiddlewareAgent.InvokeBizService(
                                this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "UpdSeriousIllnessApplicationFormEDIReg2", UpdSeriousIllnessApplicationFormEDIReg2_IN)
                                 as UpdSeriousIllnessApplicationFormEDIReg2_OUT;


                            if (UpdSeriousIllnessApplicationFormEDIReg2_OUT.COUNT != 0)
                            {
                                grid2.Dispatcher.Invoke(new Action(() =>
                                {


                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_PT_NO = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).등록번호;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CFMT_NO = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).중증번호;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).중증번호.Substring(0, 2);
                                    switch (InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD)
                                    {
                                        case "01":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "J3";
                                            break;
                                        case "05":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "SC";
                                            break;
                                        case "21":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "21";
                                            break;
                                        case "23":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "23";
                                            break;
                                        case "14":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "14";
                                            break;
                                        case "07":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "TB";
                                            break;
                                        case "11":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "SS";
                                            break;
                                        case "08":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "TC";
                                            break;
                                        case "15":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "SD";
                                            break;
                                        case "16":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "SD";
                                            break;
                                        case "22":
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "LT";
                                            break;
                                        default:
                                            InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_CDOC_APLC_TP_CD = "J3";
                                            break;
                                    }
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_HLTH_INSC_NO = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).보험증번호;

                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_APY_STR_DT = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).적용개시일.Replace("-", "").Trim();
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_APY_END_DT = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).적용종료일.Replace("-", "").Trim();
                                    //InsSeriousIllnessApplicationFormEDIReg_IN.IN_PBL_DT = CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMdd");
                                    //InsSeriousIllnessApplicationFormEDIReg_IN.IN_REGB_RECV_POST_NO_SEQ = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).HMPS_POST_NO_SEQ;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_REGB_RECV_ADDR = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).HM_DTL_ADDR;

                                    //InsSeriousIllnessApplicationFormEDIReg_IN.IN_PBL_BROF_NM = 지사;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_PBL_BROF_NM = string.Empty;
                                    //InsSeriousIllnessApplicationFormEDIReg_IN.IN_PBL_BROF_TEL_NO = 전화;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_PBL_BROF_TEL_NO = string.Empty;

                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_OTHSP_PBL_YN = N;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_MDC_ISSU_NO = string.Empty;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_SCLD_ETSN_YN = N;
                                    insSeriousIllnessApplicationFormEDIReg_IN.IN_CFSC_KND_CD = "BB";
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_MDRC_ID = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).MDRC_ID;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_APLC_SNBK_CD_CNTE = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).IN_RTNCODE;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.IN_SRIL_APLC_SNBK_MSG_CNTE = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).IN_RTN_MSG;
                                    InsSeriousIllnessApplicationFormEDIReg_IN.APLC_ICD10_DUP_SEQ_CD = (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).APLC_ICD10_DUP_SEQ_CD;

                                    //InsSeriousIllnessApplicationFormEDIReg_OUT = Loader.BeginInvokeService(this, foundBase,
                                    //                    "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL",
                                    //                    "InsSeriousIllnessApplicationFormEDIReg",
                                    //                    InsSeriousIllnessApplicationFormEDIReg_IN)
                                    //                    as InsSeriousIllnessApplicationFormEDIReg_OUT;



                                    SelSeriousIllnessApplicationFormEDIReg3_OUT InsSeriousIllnessApplicationFormEDIReg_OUT1 = UIMiddlewareAgent.InvokeBizService(
                           this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "SelSeriousIllnessApplicationFormEDIRegGCDCheck", InsSeriousIllnessApplicationFormEDIReg_IN)
                            as SelSeriousIllnessApplicationFormEDIReg3_OUT;

                                    if (!string.IsNullOrEmpty(InsSeriousIllnessApplicationFormEDIReg_OUT1.PT_NO)) //이미 등록된(배치에서든 어디든) 확인증 정보가 있으면
                                    {
                                        InsSeriousIllnessApplicationFormEDIReg_OUT = UIMiddlewareAgent.InvokeBizService(
                                     this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "UpdateSeriousIllnessApplicationFormEDIRegGCDN", InsSeriousIllnessApplicationFormEDIReg_IN)
                                      as InsSeriousIllnessApplicationFormEDIReg_OUT;
                                    }
                                    else
                                    {
                                        if (!string.IsNullOrEmpty((grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).적용개시일))
                                        {
                                            if (!string.IsNullOrEmpty((grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).적용개시일.Replace("-", "").Trim()))
                                            {
                                                InsSeriousIllnessApplicationFormEDIReg_OUT = UIMiddlewareAgent.InvokeBizService(
                                              this, "HIS.PA.AC.PI.PI.BIZ.SeriousIllnessApplicationFormEDIRegBL", "InsSeriousIllnessApplicationFormEDIReg", InsSeriousIllnessApplicationFormEDIReg_IN)
                                               as InsSeriousIllnessApplicationFormEDIReg_OUT;


                                            }
                                        }
                                    }

                                    if (InsSeriousIllnessApplicationFormEDIReg_OUT.COUNT == 0)
                                        (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).UPLOAD_YN = 0;
                                    else
                                        (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).UPLOAD_YN = 1;

                                    //else
                                    //{
                                    //    (grid2.Items[i] as SelSeriousIllnessApplicationFormEDIReg2_OUT).UPLOAD_YN = 1;
                                    //}



                                    txtGridCount2.Dispatcher.Invoke(new Action(() => txtGridCount2.Text = 건수 + SelSeriousIllnessApplicationFormEDIReg2_OUT.Sum(x => x.UPLOAD_YN ?? 0).ToString() + "/" + grid2.Items.Count + 업로드));


                                }));
                            }


                        }
                    }
                    IsBtnUpLoadCommand(false);
                    foundBase.Dispatcher.Invoke(new Action(() => MsgBox.Display("업로드 완료", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow)));
                };
            }

            //업로드
            if (btnRcvCommand != null)
            {
                btnRcvCommand.Click += delegate (object sender, RoutedEventArgs e)
                {
                    var pop = OnLoadPopupMenu("AC_HIS.PA.AC.PI.PI.UI_/SeriousIllnessApplicationFormEDIRcv");

                    dynamic model = ((pop.GetContent()) as UserControlBase).DataContext;
                    pop.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                    pop.ShowInTaskbar = false;
                    pop.Owner = this.OwnerWindow;
                    pop.ShowDialog();
                    pop.Close();
                };
            }


            if (btnCloseCommand1 != null)
            {
                btnSearhCommand1.Click -= delegate (object sender, RoutedEventArgs e)
                { };
                btnInsertCommand.Click -= delegate (object sender, RoutedEventArgs e)
                { };
                btnSearhCommand2.Click -= delegate (object sender, RoutedEventArgs e)
                { };
                btnOpenCommand.Click -= delegate (object sender, RoutedEventArgs e)
                { };
                btnUpLoadCommand.Click -= delegate (object sender, RoutedEventArgs e)
                { };
                btnCloseCommand1.Click += delegate (object sender, RoutedEventArgs e)
                { ControlHelper.FindMainAndClose(foundBase); };

                btnRcvCommand.Click -= delegate (object sender, RoutedEventArgs e)
                { };
            }

            if (grid1 != null)
            {

            }

            if (grid2 != null)
            {

            }
        }

        private void IsBtnUpLoadCommand(bool val)
        {
            btnUpLoadCommand.Dispatcher.Invoke(new Action(() => btnUpLoadCommand.IsEnabled = val));
        }

        private void IsBtnInsertCommand(bool val)
        {
            btnInsertCommand.Dispatcher.Invoke(new Action(() => btnInsertCommand.IsEnabled = val));
        }

    }
}
