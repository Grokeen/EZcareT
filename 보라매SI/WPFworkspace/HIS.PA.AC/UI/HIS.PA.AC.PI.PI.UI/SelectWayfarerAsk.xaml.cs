using System;
using System.Linq;
using System.Windows;
using HIS.UI.Base;

namespace HIS.PA.AC.PI.PI.UI
{
    /// <summary>
    /// id           : #프로그램 ID
    /// name         : #화면 논리명
    /// clss         : #{메인|공통|팝업|일반용지|서식용지|바코드}
    /// desc         : #화면 클래스 개요
    /// author       : EZCARE 
    /// create date  : 2024-08-11 오전 2:49:41
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class SelectWayfarerAsk : UserControlBase
    {
        #region [Constructor]

        /// <summary>
        /// name         : SelectWayfarerAsk 생성자
        /// desc         : SelectWayfarerAsk 생성자
        /// author       : EZCARE 
        /// create date  : 2024-08-11 오전 2:49:41
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public SelectWayfarerAsk()
        {
            InitializeComponent();

            //this.model = this.DataContext as SelectWayfarerAskData;
        }
        #endregion //Constructor

        #region [Event Handlers]

        #endregion //Event Handlers
    }
}
