using System;
using System.Linq;
using System.Windows;
using HIS.UI.Base;

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// id           : #프로그램 ID
    /// name         : #화면 논리명
    /// clss         : #{메인|공통|팝업|일반용지|서식용지|바코드}
    /// desc         : #화면 클래스 개요
    /// author       : EZCARE 
    /// create date  : 2024-10-01 오전 11:28:32
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class MedDoctorScheduleRegistration : UserControlBase
    {
        #region [Constructor]

        /// <summary>
        /// name         : MedDoctorScheduleRegistration 생성자
        /// desc         : MedDoctorScheduleRegistration 생성자
        /// author       : EZCARE 
        /// create date  : 2024-10-01 오전 11:28:32
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public MedDoctorScheduleRegistration()
        {
            InitializeComponent();

            //this.model = this.DataContext as MedDoctorScheduleRegistrationData;



            /*  */
            btn_Add.Visibility = Visibility.Collapsed;
            btn_CrDoc.Visibility = Visibility.Collapsed;
            btn_Rcep.Visibility = Visibility.Collapsed;

        }
        #endregion //Constructor



        private void HButton_Click(object sender, RoutedEventArgs e)
        {
            this.btn_Click(sender);
        }


        /// ---------------------------------------------------------------------
        /// <summary>
        /// desc         : btnPlusWork_Select
        /// author       : 김용록
        /// create date  : 2024-09-25 오후 14:10:00
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void btnPlusWork_Select(object sender, RoutedEventArgs e)
        {
            SelectPlusWork();
        }





        

        /// ---------------------------------------------------------------------
        /// <summary>
        /// desc         : btnPlusWork_Select
        /// author       : 김용록
        /// create date  : 2024-09-25 오후 14:10:00
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        private void HFromToCalendar_KeyDown(object sender, ResourceKey e)
        {
            
        }














    }
}
