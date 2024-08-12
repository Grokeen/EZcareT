
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Windows.Data;
using System.Windows.Documents;

using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;





using HIS.Core.Global.DTO;
using HIS.UI.Base;
using HIS.UI.Core;
using HIS.UI.Core.Individuality;
using HSF.TechSvc2010.Common.Auth;
using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace HIS.PA.AC
{
    /// <summary>
    /// 개발자 디버깅용 메인
    /// </summary>
    public partial class debugmain : WindowBase
    {
        /// <summary>
        /// 생성자
        /// </summary>
        public debugmain()
        {
            InitializeComponent();
        }

        /// <summary>
        /// 윈도우 로드이벤트 핸들러
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void WindowBase_Loaded(object sender, RoutedEventArgs e)
        {
            //사용자세션정보 세팅
            User_IN user = new User_IN();
            user.STF_NO = "Y0NGR";
            user.HSP_TP_CD = "7";
            user.SID = "8000004";

            GlobalUserInfo_OUT userInfo = new GlobalUserInfo_OUT();

            // 2408010927 실행할 때, 에러나서 잠깐 2줄 주석
            //userInfo = CommonServiceAgent.SelectGlobalUserInfo(user);
            //SessionManager.UserInfo = userInfo;

            SessionManager.SystemInfo.HSP_TP_CD = "7";
            SessionManager.SystemInfo.MAIN_GUBUN = "AC"; //공통 환경 설정에서 사용


            // 2408010927 실행할 때, 에러나서 잠깐 2줄 주석
            //20240401 신동명 IndividualityWizard에서 PRIVATE_SETTING을 가져오지 못해 디버그시 계속 에러가 발생하여 추가.
            //IndividualityWizard.PRIVATE_SETTING.GenerateHospitalPrivateSetting(userInfo.STF_NO);
        }

        /// <summary>
        /// 메뉴클릭 이벤트 핸들러
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void menTopMenu_Click(object sender, RoutedEventArgs e)
        {
            MenuItem item = e.OriginalSource as MenuItem;

            char[] seperator = { ';' };
            string[] menuInfo = item.Tag.ToString().Split(seperator);
            PopUpBase pop = new PopUpBase(menuInfo[0].ToString(), menuInfo[1].ToString());


            pop.WindowStartupLocation = System.Windows.WindowStartupLocation.CenterScreen;
            pop.Show();
            pop.Owner = this;
            pop.ShowInTaskbar = false;

        }

        private void menuTopMenu4Sub20_Click(object sender, RoutedEventArgs e)
        {


        }

    }
}
