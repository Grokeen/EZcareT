using DH.Lib;
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
using System.Windows.Shapes;
using Microsoft.VisualBasic;
using System.IO;
using System.Threading;
using System.Management;
using System.Runtime.InteropServices;

namespace DH.View.Popup
{
    /// <summary>
    /// CMBackup.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class CMBackup : WinBase
    {
        //SharedAPI sApi = new SharedAPI();

        public CMBackup()
        {
            InitializeComponent();

            this.WindowStartupLocation = System.Windows.WindowStartupLocation.CenterScreen;
        }
        private void WinBase_Loaded_1(object sender, RoutedEventArgs e)
        {
            //int result = sApi.ConnectRemoteServer(@"\\10.2.20.126");

            //MessageBox.Show(result.ToString());

            //ConnectServer();
        }
        private void WinBase_Unloaded_1(object sender, RoutedEventArgs e)
        {
            //sApi.CencelRemoteServer(@"\\10.2.20.126");
        }



        private void ConnectServer()
        {

            return;


            ConnectionOptions options = new ConnectionOptions();
            options.Password = "1";
            options.Username = "송창수";

            //ManagementScope scope = new ManagementScope("\\\\10.2.20.126\\원자력프로젝트\\02.2010년 운영 ITO\\20.운영\\22.산출물 형상관리", options);
            //ManagementScope scope = new ManagementScope("\\\\10.2.20.126", options);
            ManagementScope scope = new ManagementScope("A:\\", options);
            scope.Connect();//here raise an exception 
        }


        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            ((Button)sender).IsEnabled = false;

            Thread th = new Thread(new ParameterizedThreadStart(Copy1));
            th.Start(sender);
        }

        private void Copy1(object btn)
        {
            this.CopyFiles("데이터코드목록및 정의서", @"03.설계\11.데이터코드목록및정의서");

            Dispatcher.BeginInvoke(new Action(delegate
            {
                ((Button)btn).IsEnabled = true;
            }
            ), System.Windows.Threading.DispatcherPriority.Background);
        }




        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            ((Button)sender).IsEnabled = false;

            Thread th = new Thread(new ParameterizedThreadStart(Copy2));
            th.Start(sender);
        }

        private void Copy2(object btn)
        {
            this.CopyFiles("메뉴구조도", @"02.요구정의및분석\07.메뉴구조도");

            Dispatcher.BeginInvoke(new Action(delegate
            {
                ((Button)btn).IsEnabled = true;
            }
            ), System.Windows.Threading.DispatcherPriority.Background);

        }




        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            ((Button)sender).IsEnabled = false;

            Thread th = new Thread(new ParameterizedThreadStart(Copy3));
            th.Start(sender);
        }

        private void Copy3(object btn)
        {
            this.CopyFiles("사용자 메뉴얼", @"05.이행\06.사용자매뉴얼");

            Dispatcher.BeginInvoke(new Action(delegate
            {
                ((Button)btn).IsEnabled = true;
            }
            ), System.Windows.Threading.DispatcherPriority.Background);

        }




        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            ((Button)sender).IsEnabled = false;

            Thread th = new Thread(new ParameterizedThreadStart(Copy4));
            th.Start(sender);

        }

        private void Copy4(object btn)
        {
            this.CopyFiles("테이블_배치\\05.배치목록및프로그램사양서", @"03.설계\05.배치목록및프로그램사양서");
            this.CopyFiles("테이블_배치\\12.1.테이블목록 및 정의서(2012년도)", @"03.설계\12.1.테이블목록 및 정의서(2012년도)");

            Dispatcher.BeginInvoke(new Action(delegate
            {
                ((Button)btn).IsEnabled = true;
            }
            ), System.Windows.Threading.DispatcherPriority.Background);

        }




        private void Button_Click_5(object sender, RoutedEventArgs e)
        {
            ((Button)sender).IsEnabled = false;

            Thread th = new Thread(new ParameterizedThreadStart(Copy5));
            th.Start(sender);
        }


        private void Copy5(object btn)
        {
            this.CopyFiles("프로세스정의서", @"02.요구정의및분석\12.프로세스정의서");

            Dispatcher.BeginInvoke(new Action(delegate
            {
                ((Button)btn).IsEnabled = true;
            }
            ), System.Windows.Threading.DispatcherPriority.Background);

        }







        private void Button_Click_6(object sender, RoutedEventArgs e)
        {
            ((Button)sender).IsEnabled = false;

            Thread th = new Thread(new ParameterizedThreadStart(Copy6));
            th.Start(sender);
        }

        private void Copy6(object btn)
        {
            this.CopyFiles("화면_보고서_인터페이스\\04.시스템인터페이스목록및정의서", @"03.설계\04.시스템인터페이스목록및정의서");
            this.CopyFiles("화면_보고서_인터페이스\\07.화면목록", @"03.설계\07.화면목록");
            this.CopyFiles("화면_보고서_인터페이스\\08.화면정의서", @"03.설계\08.화면정의서");
            this.CopyFiles("화면_보고서_인터페이스\\09.보고서목록", @"03.설계\09.보고서목록");
            this.CopyFiles("화면_보고서_인터페이스\\10.보고서정의서", @"03.설계\10.보고서정의서");


            Dispatcher.BeginInvoke(new Action(delegate
            {
                ((Button)btn).IsEnabled = true;
            }
            ), System.Windows.Threading.DispatcherPriority.Background);

        }


        private void CopyFiles(string targetFolder, string srcFolder)
        {
            string rootTargetPath = string.Format(@"\\10.2.20.126\원자력프로젝트\02.2010년 운영 ITO\20.운영\22.산출물 형상관리\{0} 산출물\", DateTime.Now.ToString("yyyy-MM-dd"));
            string targetPath = rootTargetPath + targetFolder;

            string rootSrcPath = @"C:\DIRAMS\DIRAMS_DOC\";
            string srcPath = rootSrcPath + srcFolder;

            this.CopyFilesAll(targetPath, srcPath);
        }

        private void CopyFilesAll(string targetPath, string srcPath)
        {
            if (!System.IO.Directory.Exists(targetPath))
            {
                System.IO.Directory.CreateDirectory(targetPath);
            }

            if (System.IO.Directory.Exists(targetPath))
            {
                string[] files = System.IO.Directory.GetFiles(srcPath);

                foreach (string s in files)
                {
                    // Use static Path methods to extract only the file name from the path.
                    string fileName = System.IO.Path.GetFileName(s);
                    string _currFileName = System.IO.Path.Combine(targetPath, fileName);

                    if (File.Exists(_currFileName)) File.Delete(_currFileName);


                    System.IO.File.Copy(s, _currFileName, true);
                }


                // 자식 폴더
                DirectoryInfo[] srcDirs = (new DirectoryInfo(srcPath).GetDirectories());
                foreach (DirectoryInfo dir in srcDirs)
                {
                    if (dir.Name.IndexOf(".metadata") > -1) continue;

                    CopyFilesAll(targetPath + "\\" + dir.Name, srcPath + "\\" + dir.Name);
                }

            }
        }



    }



    class SharedAPI
    {
        // 구조체 선언
        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
        public struct NETRESOURCE
        {
            public uint dwScope;
            public uint dwType;
            public uint dwDisplayType;
            public uint dwUsage;
            public string lpLocalName;
            public string lpRemoteName;
            public string lpComment;
            public string lpProvider;
        }
        // API 함수 선언
        [DllImport("mpr.dll", CharSet = CharSet.Auto)]
        public static extern int WNetUseConnection(
                    IntPtr hwndOwner,
                    [MarshalAs(UnmanagedType.Struct)] ref NETRESOURCE lpNetResource,
                    string lpPassword,
                    string lpUserID,
                    uint dwFlags,
                    StringBuilder lpAccessName,
                    ref int lpBufferSize,
                    out uint lpResult);
        // API 함수 선언 (공유해제)
        [DllImport("mpr.dll", EntryPoint = "WNetCancelConnection2", CharSet = CharSet.Auto)]
        public static extern int WNetCancelConnection2A(string lpName, int dwFlags, int fForce);
        // 공유연결
        public int ConnectRemoteServer(string server)
        {
            int capacity = 64;
            uint resultFlags = 0;
            uint flags = 0;
            System.Text.StringBuilder sb = new System.Text.StringBuilder(capacity);
            NETRESOURCE ns = new NETRESOURCE();
            ns.dwType = 1;              // 공유 디스크
            ns.lpLocalName = null;   // 로컬 드라이브 지정하지 않음
            ns.lpRemoteName = server;
            ns.lpProvider = null;
            int result = 0;

            /*
            if (server == @"\\10.2.20.126\원자력프로젝트\02.2010년 운영 ITO\20.운영\22.산출물 형상관리")
            {
                result = WNetUseConnection(IntPtr.Zero, ref ns, "1", "송창수", flags,
                                            sb, ref capacity, out resultFlags);
            }
            else
            {
                result = WNetUseConnection(IntPtr.Zero, ref ns, "PASSWORD", "LOGINID", flags,
                                                sb, ref capacity, out resultFlags);
            }
            */


            result = WNetUseConnection(IntPtr.Zero, ref ns, "PASSWORD", "LOGINID", flags,
                                                sb, ref capacity, out resultFlags);

            return result;
        }
        // 공유해제
        public void CencelRemoteServer(string server)
        {
            WNetCancelConnection2A(server, 1, 0);
        }
    }

}
