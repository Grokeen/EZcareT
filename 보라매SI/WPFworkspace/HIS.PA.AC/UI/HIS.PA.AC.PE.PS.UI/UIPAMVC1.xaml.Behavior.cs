using HIS.UI.Base;
using HIS.UI.Controls;
using HIS.UI.Core;
using HIS.UI.Utility;
using HSF.Controls.WPF;
using HSF.TechSvc2010.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : #UIPAMVC1 Behavior 클래스
    /// desc         : #UIPAMVC1 Behavior 클래스
    /// author       : EZCARE 
    /// create date  : 2024-10-18 오후 1:16:18
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class UIPAMVC1
    {
        #region [Consts]
        /// <summary>
        /// Biz 클래스명
        /// </summary>
        private const string BIZ_CLASS = "";
        #endregion //Consts

        #region [Dependency Properties]

        #endregion //Dependency Properties

        #region [Member Variables]

        /// <summary>
        /// 프레젠테이션 모델(PM) 
        /// </summary>
        private UIPAMVC1Data model;

        #endregion //Member Variables

        #region [Properties]

        #endregion //Properties

        #region [컨트롤 초기화]

        /// <summary>
        /// name         : 컨트롤 초기화
		/// desc         : UI에서 사용할 컨트롤을 초기화 함
		/// author       : EZCARE
		/// create date  : 2024-10-18 오후 1:16:18
		/// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void ControlInit()
        {
        }
        #endregion //컨트롤 초기화

        #region [데이타초기화(공통코드)]

        /// <summary>
        /// name         : 데이터 초기화
		/// desc         : 화면 로드시 데이터를 초기화 함
		/// author       : EZCARE 
		/// create date  : 2024-10-18 오후 1:16:18
		/// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        private void DataInit()
        {
        }
        #endregion //데이타초기화(공통코드)

        #region [Methods]

        /// <summary>
        /// name         : 데이터 조회
        /// desc         : 데이터를 조회함
        /// author       : EZCARE 
        /// create date  : 2024-10-18 오후 1:16:18
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void SelectData(object p)
        {
            //UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectData", null);
        }

        #endregion //Methods
    }
}
