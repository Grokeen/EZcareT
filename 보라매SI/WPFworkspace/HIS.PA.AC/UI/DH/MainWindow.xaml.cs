using System;
using System.Collections.Generic;
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
using System.Collections;
using DH.Entity;
using IBatisNet.Common.Utilities;
using IBatisNet.DataMapper;
using IBatisNet.DataMapper.Configuration;
using DH.Lib;
using System.Collections.ObjectModel;
using DH.View;
using System.Windows.Threading;
using System.IO;
using System.Xml.Serialization;
using System.Xml;
using System.Deployment.Application;
using System.Reflection;
using System.Diagnostics;
using System.Threading;
using System.Net;
using System.Net.Sockets;

namespace DH
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : WinBase
    {
        private ObservableCollection<BasicSetting> ocBasicSetting = new ObservableCollection<BasicSetting>();
        private ObservableCollection<DBUser> ocDB1User = new ObservableCollection<DBUser>();
        private ObservableCollection<DBUser> ocDB2User = new ObservableCollection<DBUser>();

        //private DBUser dbUser_Sel = new DBUser();

        public ObservableCollection<BasicSetting> OcBasicSetting { get => ocBasicSetting; set => ocBasicSetting = value; }

        public ObservableCollection<DBUser> OcDB1User { get => ocDB1User; set => ocDB1User = value; }
        public ObservableCollection<DBUser> OcDB2User { get => ocDB2User; set => ocDB2User = value; }
        //public DBUser DbUser_Sel { get => dbUser_Sel; set => dbUser_Sel = value; }

        public bool IsSettingCompleted { get; set; }

        TabItem PREV_TAB;

        private System.Timers.Timer tmCheckNewVersion;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            this.grdMsgBox.Visibility = Visibility.Collapsed;
            this.Title = "Developer Helper " + this.GetPublishedVersion();


            this.ProgressOff();
            this.MaxScreen();

            //기본설정값 불러옴
            this.GetBasicSetting();

            this.GetDB1User();
            this.GetDB2User();

            //Default DB2 선택
            rdoApp.IsChecked = true;



            //DBUser 설정값에서 읽어오기
            cboDB1.ItemsSource = this.ocDB1User;
            //cboDB2.SelectedItem = DbUser_Sel;
            cboDB1.DisplayMemberPath = "USER_NAME";
            cboDB1.SelectedValuePath = "USER_NAME";


            cboDB2.ItemsSource = this.ocDB2User;
            //cboDB2.SelectedItem = DbUser_Sel;
            cboDB2.DisplayMemberPath = "USER_NAME";
            cboDB2.SelectedValuePath = "USER_NAME";





            this.AddTab("DBHelper", "테이블");
            this.AddTab("SelectQuery", "쿼리실행");


            this.AddTab("CommonCode", "공통코드");
            this.AddTab("FavQueryManagement", "My Query");

            this.AddTab("SourceGenerator", "소스생성");

            this.AddTab("CodeGenerator", "코드변환");

            this.AddTab("DBSourceFinder", "DB소스검색");
            this.AddTab("EQS", "EQS");

            this.AddTab("TFS", "TFS");

            this.AddTab("EAM", "EAM");


            //this.AddTab("SqlFormatter", "SqlFormatter");

            this.AddTab("IntegratedSearch", "ETC");
            //this.AddTab("UserInfo");
            //this.AddTab("DeptInfo");
            //this.AddTab("Apipdlst");
            //this.AddTab("Apopdlst");

            //this.AddTab("UpdateNote", "Update");
            this.AddTab("Setting", "Setting");

            string[] ip = this.GetIpAddress().Split('.');
            //if (ip[2] == "103")
            //    this.AddTab("DailyWork", "DailyWork");
            //this.AddTab("tiManual");


            tabMain.SelectedIndex = 0;

            if (ApplicationDeployment.IsNetworkDeployed)
            {
                this.tmCheckNewVersion = new System.Timers.Timer(1000 * 60 * 5); //5분마다 신규버전 체크

                this.tmCheckNewVersion.Elapsed += TmCheckNewVersion_Elapsed;

                // Timer에서 Elapsed 이벤트를 반복해서 발생
                this.tmCheckNewVersion.AutoReset = true;
                this.tmCheckNewVersion.Enabled = true;
            }


            //화면 로드 후 이벤트 추가 (중복실행 방지)
            this.rdoDev.Checked += rdoDev_Checked;
            this.rdoApp.Checked += rdoApp_Checked;

            this.cboDB1.SelectionChanged += cboDB1_SelectionChanged;
            this.cboDB2.SelectionChanged += cboDB2_SelectionChanged;
        }


        private void TmCheckNewVersion_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            this.CheckNewVersion(false);
        }

        protected delegate void Work();

        public void ProgressOn()
        {
            return;

            this.Dispatcher.Invoke(DispatcherPriority.Send, (ThreadStart)delegate ()
            {
                this.grdProgress.Dispatcher.BeginInvoke(DispatcherPriority.Input, (Action)delegate ()
                {
                    ExeProgressOn();
                });
            });


            //Dispatcher.Invoke(DispatcherPriority.Background, new Work(ExeProgressOn));
        }
        public void ProgressOff()
        {
            return;

            this.Dispatcher.Invoke(DispatcherPriority.Send, (ThreadStart)delegate ()
            {
                this.grdProgress.Dispatcher.BeginInvoke(DispatcherPriority.Input, (Action)delegate ()
                {
                    ExeProgressOff();
                });
            });

            //Dispatcher.Invoke(DispatcherPriority.Background, new Work(ExeProgressOff));
        }

        public void ExeProgressOn()
        {
            grdProgress.Visibility = System.Windows.Visibility.Visible;
        }

        public void ExeProgressOff()
        {
            grdProgress.Visibility = System.Windows.Visibility.Collapsed;
        }



        //private int DBTAB_CNT = 1;
        private void btnAddTab_Click(object sender, RoutedEventArgs e)
        {
            var selectedTab = tabMain.SelectedItem as TabItem;

            this.AddTab(selectedTab.Tag.ToString(), selectedTab.Header.ToString(), tabMain.SelectedIndex + 1);



            //DBTAB_CNT++;
        }

        /// <summary>
        /// 탭추가
        /// </summary>
        /// <param name="tabItemName"></param>
        private void AddTab(string view_name, string tab_header)
        {
            this.AddTab(view_name, tab_header, -1);
        }

        private void AddTab(string view_name, string tab_header, int tab_index)
        {
            TabItem ti = new TabItem();
            ti.HeaderTemplate = TryFindResource("Tab_Header") as DataTemplate;

            ti.Header = tab_header;
            ti.Name = "ti" + view_name;
            ti.Tag = view_name;

            string type_name = "DH.View." + view_name;

            Type t = Type.GetType(type_name);
            if (t == null) return;

            object uc = Activator.CreateInstance(t);

            if (uc is DBHelper dh)
                dh.IsSelectWithStart = true; // 시작과 동시에 조회함..


            ti.Content = uc;


            //if (view_name == "DBHelper")
            //{
            //    DH.View.DBHelper uc = new DH.View.DBHelper();
            //    uc.IsSelectWithStart = true; // 시작과 동시에 조회함..
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiSelectQuery")
            //{
            //    DH.View.SelectQuery uc = new DH.View.SelectQuery();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiFavQueryManagement")
            //{
            //    DH.View.FavQueryManagement uc = new DH.View.FavQueryManagement();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiUserInfo")
            //{
            //    DH.View.UserInfo uc = new DH.View.UserInfo();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiCommonCode")
            //{
            //    DH.View.CommonCode uc = new DH.View.CommonCode();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiEAM")
            //{
            //    DH.View.EAM uc = new DH.View.EAM();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiDBSourceFinder")
            //{
            //    DH.View.DBSourceFinder uc = new DH.View.DBSourceFinder();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiEQS")
            //{
            //    DH.View.EQS uc = new DH.View.EQS();
            //    ti.Content = uc;
            //}

            //else if (view_name == "tiDeptInfo")
            //{
            //    DH.View.DeptInfo uc = new DH.View.DeptInfo();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiPatientInfo")
            //{
            //    DH.View.PatientInfo uc = new DH.View.PatientInfo();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiApipdlst")
            //{
            //    DH.View.Apipdlst uc = new DH.View.Apipdlst();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiApopdlst")
            //{
            //    DH.View.Apopdlst uc = new DH.View.Apopdlst();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiSqlFormatter")
            //{
            //    DH.View.SqlFormatter uc = new DH.View.SqlFormatter();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiSGRsvInfo")
            //{
            //    DH.View.SGRsvInfo uc = new DH.View.SGRsvInfo();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiDrugInfo")
            //{
            //    DH.View.DrugInfo uc = new DH.View.DrugInfo();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiCodeGenerator")
            //{
            //    DH.View.CodeGenerator uc = new DH.View.CodeGenerator();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiSourceGenerator")
            //{
            //    DH.View.SourceGenerator uc = new DH.View.SourceGenerator();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiTFS")
            //{
            //    DH.View.TFS uc = new DH.View.TFS();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiSetting")
            //{
            //    DH.View.Setting uc = new DH.View.Setting();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiManual")
            //{
            //    DH.View.Manual uc = new DH.View.Manual();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiUpdate")
            //{
            //    DH.View.UpdateNote uc = new DH.View.UpdateNote();
            //    ti.Content = uc;
            //}
            //else if (view_name == "tiDailyWork")
            //{
            //    DH.View.DailyWork uc = new DH.View.DailyWork();
            //    ti.Content = uc;
            //}


            //tabMain.Items.Insert(DBTAB_CNT, ti);
            if (tab_index > -1)
            {
                tabMain.Items.Insert(tab_index, ti);
                tabMain.SelectedItem = ti;
            }
            else
            {
                tabMain.Items.Add(ti);
            }


        }

        private string GetIpAddress()
        {
            IPAddress[] addresses = Dns.GetHostAddresses(Dns.GetHostName());
            foreach (IPAddress address in addresses)
            {
                if (address.AddressFamily == AddressFamily.InterNetwork)
                {
                    return address.ToString();
                }
            }

            return "";
        }
        private void btnCloseTab_Click(object sender, RoutedEventArgs e)
        {
            TabItem ti = tabMain.SelectedItem as TabItem;

            if (GetTabCount(ti.Name) == 1)
            {
                return;
            }

            tabMain.Items.Remove(ti);
        }

        private int GetTabCount(string tabName)
        {
            int cnt = 0;
            foreach (TabItem item in tabMain.Items)
            {
                if (item.Name == tabName)
                {
                    cnt++;
                }
            }

            return cnt;
        }





        private void tabMain_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (!(e.Source is TabControl)) return;

            TabItem ti = tabMain.SelectedItem as TabItem;

            if (ti == null) return;

            spDB.Visibility = System.Windows.Visibility.Visible;
            //셋팅 탭일때 숨기기            
            if (ti.Name == "tiSetting")
            {
                spDB.Visibility = System.Windows.Visibility.Hidden;
            }

            //이전 탭의 DB 정보 기록
            if (e.RemovedItems.Count > 0)
            {
                if (e.RemovedItems[0] is TabItem)
                {
                    //화면에서 마우스back버튼을 누르면 이전탭으로 이동하기 위해 변경 전 탭정보 저장

                    this.PREV_TAB = (TabItem)e.RemovedItems[0];

                    UCBase prev_uc = ((TabItem)e.RemovedItems[0]).Content as UCBase;

                    if (prev_uc != null)
                    {
                        if (rdoDev.IsChecked == true)
                            prev_uc.DB = 1;
                        else
                            prev_uc.DB = 2;
                    }
                }
            }

            // 현재 탭의 저장되어 있는 DB1, DB2 선택 불러오기
            UCBase selectedUC = ti.Content as UCBase;

            if (selectedUC != null)
            {
                if (selectedUC.DB == 0) selectedUC.DB = 1;

                if (selectedUC.DB == 1)
                    rdoDev.IsChecked = true;
                else if (selectedUC.DB == 2)
                    rdoApp.IsChecked = true;
            }


        }

        private void TabItem_PreviewMouseMove(object sender, MouseEventArgs e)
        {
            var tabItem = e.Source as TabItem;

            if (tabItem == null)
                return;

            if (Mouse.PrimaryDevice.LeftButton == MouseButtonState.Pressed)
            {
                DragDrop.DoDragDrop(tabItem, tabItem, DragDropEffects.All);
            }
        }


        private void TabItem_Drop(object sender, DragEventArgs e)
        {
            var tabItemTarget = e.Source as TabItem;

            if (tabItemTarget == null) return;

            var tabItemSource = e.Data.GetData(typeof(TabItem)) as TabItem;

            if (tabItemSource == null) return;

            if (!tabItemTarget.Equals(tabItemSource))
            {
                var tabControl = tabItemTarget.Parent as TabControl;
                int sourceIndex = tabControl.Items.IndexOf(tabItemSource);
                int targetIndex = tabControl.Items.IndexOf(tabItemTarget);

                tabControl.Items.Remove(tabItemSource);
                tabControl.Items.Insert(targetIndex, tabItemSource);

                //tabControl.Items.Remove(tabItemTarget);
                //tabControl.Items.Insert(sourceIndex, tabItemTarget);

                tabControl.SelectedItem = tabItemSource;
            }
        }

        private void btnOpenCMBackUp_Click(object sender, RoutedEventArgs e)
        {
            DH.View.Popup.CMBackup winCMBackup = new View.Popup.CMBackup();
            winCMBackup.Show();
            winCMBackup.Owner = this;
        }

        private void WinBase_Activated(object sender, EventArgs e)
        {

        }

        //StackPanel sp = new StackPanel();
        //sp.Orientation = Orientation.Horizontal;
        //sp.Margin = new Thickness(0,3,0,3);

        //// 이미지 추가
        //Image img = new Image();
        //BitmapImage BitImg = new BitmapImage(new Uri("/DH;component/Images/Icon/drive-harddocument-save22.png", UriKind.Relative));
        //img.Source = BitImg;
        //img.Stretch = Stretch.Fill;
        //sp.Children.Add(img);

        // 텍스트 추가
        //TextBlock tb = new TextBlock();
        //tb.Text = " Table Info (" + (DBTAB_CNT + 1) + ")";
        //sp.Children.Add(tb);



        #region 참고코드
        //private void button1_Click(object sender, RoutedEventArgs e)
        //{
        //    ISqlMapper mapper = null;
        //    DomSqlMapBuilder dom = new DomSqlMapBuilder();

        //    ArrayList lstResultSet = new ArrayList();
        //    //List<IList> lstResultSet = new List<IList>();
        //    IList lstResult = null;

        //    TableInfo item = new TableInfo();
        //    item.ServiceName = "DH";
        //    item.QueryId = "DH.SELECT.TABLEINFO.S01";
        //    item.KEYWORD = "MOE";

        //    //mapper = GetMapper(item.ServiceName);

        //    ////// 쿼리실행
        //    //lstResult = mapper.QueryForList(item.QueryId, item);

        //    //// Data 없을시 처리
        //    //if (lstResult.Count == 0)
        //    //{

        //    //}
        //}
        #endregion


        private void rdoDev_Checked(object sender, RoutedEventArgs e)
        {
            if (this.cboDB1 == null || this.cboDB2 == null) return;

            //this.GetDBUser();
            this.cboDB1.Visibility = Visibility.Visible;
            this.cboDB2.Visibility = Visibility.Collapsed;

            this.cboDB1_SelectionChanged(null, null);
        }


        private void rdoApp_Checked(object sender, RoutedEventArgs e)
        {
            if (this.cboDB1 == null || this.cboDB2 == null) return;

            //this.GetDBUser();
            this.cboDB1.Visibility = Visibility.Collapsed;
            this.cboDB2.Visibility = Visibility.Visible;

            this.cboDB2_SelectionChanged(null, null);
        }



        private void cboDB1_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

            //ComboBoxItem item = cboDB.SelectedItem as ComboBoxItem;
            DBUser item = cboDB1.SelectedItem as DBUser;
            if (item == null) return;

            //Application.Current.Properties["ServiceName"] = item.USER_NAME;

            this.SetConnectionString(item.CONNECT_STRING);

        }
        private void cboDB2_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

            //ComboBoxItem item = cboDB.SelectedItem as ComboBoxItem;
            DBUser item = cboDB2.SelectedItem as DBUser;
            if (item == null) return;

            //Application.Current.Properties["ServiceName"] = item.USER_NAME;

            this.SetConnectionString(item.CONNECT_STRING);

        }


        private void SetConnectionString(string connStr)
        {

            string config_file = string.Format(@".\Config\DH.SqlMap.config");
            XmlDocument xml = new XmlDocument();
            xml.Load(config_file);

            var x = xml.ChildNodes[1]["database"]["dataSource"].Attributes["connectionString"].Value = connStr;

            xml.Save(config_file);



        }


        public void GetBasicSetting()
        {
            this.OcBasicSetting = this.GetBasicSettingFromSettingFile();

            if (this.OcBasicSetting == null || this.OcBasicSetting.Count == 0)
            {
                //this.OwnerWindow.ShowMsgBox("Setting 탭에서 기본셋팅 정보를 설정하세요.");

                //this.SelectTabItem("tiSetting");
            }


        }


        public ObservableCollection<BasicSetting> GetBasicSettingFromSettingFile()
        {
            string file_path = this.GetBasicSettingFilePath();

            if (!File.Exists(file_path)) return null;

            XmlSerializer xs = new XmlSerializer(typeof(ObservableCollection<BasicSetting>));

            ObservableCollection<BasicSetting> xdata = null;
            using (StreamReader rd = new StreamReader(file_path))
            {
                xdata = xs.Deserialize(rd) as ObservableCollection<BasicSetting>;
            }


            var setting = new ObservableCollection<BasicSetting>();

            foreach (var item in xdata)
            {
                setting.Add(item);
            }

            return setting;
        }



        //public void GetDBUser()
        //{
        //    OcDBUser.Clear();

        //    string dbGbn = "APP";
        //    if (rdoDev.IsChecked == true)
        //    {
        //        dbGbn = "DEV";
        //    }


        //    string file_path = this.GetDBInfoSettingFilePath(dbGbn);


        //    if (!File.Exists(file_path)) return;

        //    XmlSerializer xs = new XmlSerializer(typeof(ObservableCollection<DBUser>));

        //    ObservableCollection<DBUser> xdata = null;
        //    using (StreamReader rd = new StreamReader(file_path))
        //    {
        //        xdata = xs.Deserialize(rd) as ObservableCollection<DBUser>;
        //    }



        //    foreach (var item in xdata)
        //    {
        //        OcDBUser.Add(item);

        //    }

        //    if (this.ocDBUser.Count == 0)
        //    {
        //        this.OwnerWindow.ShowMsgBox("Setting 탭에서 DB Connection 정보를 설정하세요.");
        //    }
        //    else
        //    { 
        //        //DbUser_Sel = this.ocDBUser[0];
        //        if (cboDB != null && this.cboDB.SelectedIndex == -1) cboDB.SelectedIndex = 0;
        //    }

        //}


        public void GetDB1User()
        {
            OcDB1User.Clear();

            //string dbGbn = "APP";

            string file_path = this.GetDBInfoSettingFilePath("DEV");


            if (!File.Exists(file_path)) return;

            XmlSerializer xs = new XmlSerializer(typeof(ObservableCollection<DBUser>));

            ObservableCollection<DBUser> xdata = null;
            using (StreamReader rd = new StreamReader(file_path))
            {
                xdata = xs.Deserialize(rd) as ObservableCollection<DBUser>;

                rd.Close();
            }



            foreach (var item in xdata)
            {
                OcDB1User.Add(item);

            }

            if (this.OcDB1User.Count == 0)
            {
                this.ShowMsgBox("Setting 탭에서 DB Connection 정보를 설정하세요.", 3000);
            }
            else
            {
                IsSettingCompleted = true;
                //DbUser_Sel = this.ocDBUser[0];
                if (cboDB1 != null && this.cboDB1.SelectedIndex == -1) cboDB1.SelectedIndex = 0;
            }

        }

        public void GetDB2User()
        {
            OcDB2User.Clear();

            //string dbGbn = "APP";

            string file_path = this.GetDBInfoSettingFilePath("APP");


            if (!File.Exists(file_path)) return;

            XmlSerializer xs = new XmlSerializer(typeof(ObservableCollection<DBUser>));

            ObservableCollection<DBUser> xdata = null;
            using (StreamReader rd = new StreamReader(file_path))
            {
                xdata = xs.Deserialize(rd) as ObservableCollection<DBUser>;

                rd.Close();
            }





            foreach (var item in xdata)
            {
                OcDB2User.Add(item);

            }

            if (this.OcDB2User.Count == 0)
            {
                this.ShowMsgBox("Setting 탭에서 DB Connection 정보를 설정하세요.", 3000);
            }
            else
            {
                IsSettingCompleted = true;
                //DbUser_Sel = this.ocDBUser[0];
                if (cboDB2 != null && this.cboDB2.SelectedIndex == -1) cboDB2.SelectedIndex = 0;
            }

        }

        private void CboDB1_Loaded(object sender, RoutedEventArgs e)
        {
            if (this.ocDB1User.Count > 0)
            {
                if (this.cboDB1.SelectedIndex == -1)
                    this.cboDB1.SelectedIndex = 0;
                //DbUser_Sel = this.ocDBUser[0];
            }
        }
        private void CboDB2_Loaded(object sender, RoutedEventArgs e)
        {
            if (this.ocDB2User.Count > 0)
            {
                if (this.cboDB2.SelectedIndex == -1)
                    this.cboDB2.SelectedIndex = 0;
                //DbUser_Sel = this.ocDBUser[0];
            }
        }



        public string GetBasicSettingFilePath()
        {
            string file_path = "";
            if (ApplicationDeployment.IsNetworkDeployed)
            {
                var deployment = ApplicationDeployment.CurrentDeployment;
                string file_name = string.Format(@"Setting.xml");
                file_path = System.IO.Path.Combine(deployment.DataDirectory, file_name);
            }
            else
            {
                file_path = string.Format(@".\Setting.xml");
            }

            return file_path;
        }


        public string GetDBInfoSettingFilePath(string dbGbn)
        {
            string file_path = "";
            if (ApplicationDeployment.IsNetworkDeployed)
            {
                var deployment = ApplicationDeployment.CurrentDeployment;
                string file_name = string.Format(@"Setting{0}.xml", dbGbn);
                file_path = System.IO.Path.Combine(deployment.DataDirectory, file_name);
            }
            else
            {
                file_path = string.Format(@".\Config\Setting{0}.xml", dbGbn);
            }

            return file_path;
        }


        private void BtnCopyright_Click(object sender, RoutedEventArgs e)
        {
            Copyright window = new Copyright();
            window.Owner = this.Parent as Window;
            window.ShowDialog();

        }


        public Version GetPublishedVersion()
        {
            XmlDocument xmlDoc = new XmlDocument();
            Assembly asmCurrent = System.Reflection.Assembly.GetExecutingAssembly();
            string executePath = new Uri(asmCurrent.GetName().CodeBase).LocalPath;

            xmlDoc.Load(executePath + ".manifest");
            string retval = string.Empty;
            if (xmlDoc.HasChildNodes)
            {
                retval = xmlDoc.ChildNodes[1].ChildNodes[0].Attributes.GetNamedItem("version").Value.ToString();
            }
            return new Version(retval);
        }



        public UCBase GetTabItem(string tab_name)
        {
            foreach (TabItem item in this.tabMain.Items)
            {
                if (item.Name == tab_name)
                    return (UCBase)item.Content;
            }

            return null;
        }


        public void SelectTabItem(string tab_name)
        {
            foreach (TabItem item in this.tabMain.Items)
            {
                if (item.Name == tab_name)
                {
                    this.tabMain.SelectedItem = item;
                    return;
                }
            }
        }



        private void WinBase_PreviewMouseDown(object sender, MouseButtonEventArgs e)
        {


            if (e.ChangedButton == MouseButton.XButton1)
            {
                //MessageBox.Show(e.ChangedButton.ToString());

                if (this.PREV_TAB != null)
                {
                    this.tabMain.SelectedItem = this.PREV_TAB;
                }
            }
        }


        //System.Threading.Timer _timeoutTimer;
        public void ShowMsgBox(string msg, int timeout)
        {
            var timer = new System.Timers.Timer(timeout) { AutoReset = false };
            timer.Elapsed += delegate
            {
                Application.Current.Dispatcher.BeginInvoke(new Action(() =>
                {
                    this.tbMsgBox.Text = "";
                    this.grdMsgBox.Visibility = Visibility.Collapsed;
                }), System.Windows.Threading.DispatcherPriority.Send);
            };
            timer.Enabled = true;

            Application.Current.Dispatcher.BeginInvoke(new Action(() =>
            {
                this.tbMsgBox.Text = msg;
                this.grdMsgBox.Visibility = Visibility.Visible;
            }), System.Windows.Threading.DispatcherPriority.Send);



            //_timeoutTimer = new System.Threading.Timer(OnTimerElapsed, null, timeout, System.Threading.Timeout.Infinite);
            //using (_timeoutTimer)
            //{
            //    Application.Current.Dispatcher.BeginInvoke(new Action(() =>
            //    {
            //        this.tbMsgBox.Text = msg;
            //        this.grdMsgBox.Visibility = Visibility.Visible;
            //    }), System.Windows.Threading.DispatcherPriority.Send);
            //}
        }

        private void btnCheckNewVersion_Click(object sender, RoutedEventArgs e)
        {
            this.CheckNewVersion(true);
        }


        private void CheckNewVersion(bool is_show_lastest_version_msg)
        {
            try
            {
                if (ApplicationDeployment.IsNetworkDeployed)
                {
                    var deploy = ApplicationDeployment.CurrentDeployment;

                    if (deploy.CheckForUpdate())
                    {
                        this.ShowMsgBox("새로운 버전이 존재합니다.", 10000);

                        UpdateCheckInfo info = deploy.CheckForDetailedUpdate();
                        if (info.UpdateAvailable)
                        {
                        }
                    }
                    else
                    {
                        if (is_show_lastest_version_msg)
                            this.ShowMsgBox("현재버전이 최신버전입니다.", 3000);
                    }
                }
            }
            catch (Exception e2)
            {

            }
        }


        private void grdMsgBox_MouseUp(object sender, MouseButtonEventArgs e)
        {
            this.grdMsgBox.Visibility = Visibility.Collapsed;
        }

        //void OnTimerElapsed(object state)
        //{
        //    Application.Current.Dispatcher.BeginInvoke(new Action(() =>
        //    {
        //        this.tbMsgBox.Text = "";
        //        this.grdMsgBox.Visibility = Visibility.Collapsed;
        //    }), System.Windows.Threading.DispatcherPriority.Send);


        //}




    }

}
