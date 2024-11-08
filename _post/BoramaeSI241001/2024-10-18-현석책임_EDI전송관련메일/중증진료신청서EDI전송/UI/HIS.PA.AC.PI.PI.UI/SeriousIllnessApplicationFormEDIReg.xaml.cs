using System;
using System.Collections.Generic;
using System.ComponentModel;
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
using System.Data;

using HSF.Controls.WPF;
using HSF.TechSvc2010.Common;

using HIS.UI.Base;
using HIS.UI.Core;
using HIS.UI.Controls;
using HIS.UI.Utility;

namespace HIS.PA.AC.PI.PI.UI
{
    /// <summary>
    /// id           : UI-PA-AC-PI-025
    /// name         : 중증신청서EDI등록
    /// clss         : 메인
    /// desc         : 중증신청서EDI등록
    /// author       : kwonwookju
    /// create date  : 2012-04-13 오후 1:36:04
    /// update date  : 2012-04-13 오후 1:36:04, kwonwookju, 수정내용
    /// </summary>
    public partial class SeriousIllnessApplicationFormEDIReg : UserControlBase
    {
        #region [Constructor]

        /// <summary>
        /// Initializes a new <see cref="SeriousIllnessApplicationFormEDIReg"/>
        /// </summary>
        public SeriousIllnessApplicationFormEDIReg()
        {
            InitializeComponent();

            this.Model = this.DataContext as SeriousIllnessApplicationFormEDIRegData;
        }
        #endregion //Constructor 
    }
}
