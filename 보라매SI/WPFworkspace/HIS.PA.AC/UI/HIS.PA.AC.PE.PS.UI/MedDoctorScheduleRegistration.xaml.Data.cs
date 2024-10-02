using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

using HSF.Controls.WPF;
//using HSF.Controls.WPF.Extension;
using HSF.TechSvc2010.Common;

using HIS.UI.Core;
using HIS.UI.Core.Commands;
using HIS.UI.Utility;
//using HIS.PA.AC.PE.SC.DTO;
using HIS.PA.AC.PE.PS.DTO;

using HIS.Core.Global.DTO;
using HIS.UI.Base;
using System.Collections.ObjectModel;
//using HSF.Controls.WPF.Extension.CalendarEx;
using HSF.Controls.WPF.DataManager.Calendars;
//using HIS.PA.AC.PE.AP.DTO;

using HIS.PA.CORE.DTO;

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : #MedDoctorScheduleRegistration Data 클래스
    /// desc         : #MedDoctorScheduleRegistration Data 클래스
    /// author       : EZCARE 
    /// create date  : 2024-10-01 오전 11:28:32
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class MedDoctorScheduleRegistrationData : ViewModelBase
    {
        #region [Consts]

        private const string BIZ_CLASS = "";

        #endregion //Consts
        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT> selectDrPlusWork_OUT = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>();
        /// ---------------------------------------------------------------------
        /// <summary>
        /// desc         : SelectDrPlusWork_OUT
        /// author       : 김용록
        /// create date  : 2024-09-25 오후 14:10:00
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT> SelectDrPlusWork_OUT
        {
            get { return this.selectDrPlusWork_OUT; }
            set { if (this.selectDrPlusWork_OUT != value) { this.selectDrPlusWork_OUT = value; this.OnPropertyChanged("SelectDrPlusWork_OUT"); } }
        }

        MedDoctorScheduleRegistration_PlusWork_INOUT selectDrPlusWork_IN = new MedDoctorScheduleRegistration_PlusWork_INOUT();
        /// ---------------------------------------------------------------------
        /// <summary>
        /// desc         : SelectDrPlusWork_IN
        /// author       : 김용록
        /// create date  : 2024-09-25 오후 14:10:00
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        public MedDoctorScheduleRegistration_PlusWork_INOUT SelectDrPlusWork_IN
        {
            get { return this.selectDrPlusWork_IN; }
            set
            {
                if (this.selectDrPlusWork_IN != value)
                { this.selectDrPlusWork_IN = value; this.OnPropertyChanged("SelectDrPlusWork_IN"); }
            }
        }

        MedDoctorScheduleRegistration_PlusWork_UPDATE updateDrPlusWork = new MedDoctorScheduleRegistration_PlusWork_UPDATE();
        /// ---------------------------------------------------------------------
        /// <summary>
        /// desc         : UpdateDrPlusWork
        /// author       : 김용록 
        /// create Date  : 2024-09-25 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        /// ---------------------------------------------------------------------
        public MedDoctorScheduleRegistration_PlusWork_UPDATE UpdateDrPlusWork
        {
            get { return this.updateDrPlusWork; }
            set
            {
                if (this.updateDrPlusWork != value)
                { this.updateDrPlusWork = value; this.OnPropertyChanged("UpdateDrPlusWork"); }
            }
        }

    }
}
