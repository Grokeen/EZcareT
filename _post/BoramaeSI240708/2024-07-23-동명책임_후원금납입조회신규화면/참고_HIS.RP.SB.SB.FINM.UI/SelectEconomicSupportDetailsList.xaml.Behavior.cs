using HIS.UI.Base;
using HIS.UI.Controls;
using HIS.UI.Core;
using HIS.UI.Utility;
using HSF.Controls.WPF;
using HSF.TechSvc2010.Common;
using HIS.RP.CORE.UI.Message;
using HIS.RP.SB.SB.FINM.DTO;
using HIS.Core.Global.DTO;
using HIS.RP.CORE.DTO.SB;
using HIS.RP.CORE.UI;
using HIS.UI.Controls.Extension;
using System;
using System.Text;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Threading;

namespace HIS.RP.SB.SB.FINM.UI
{
    /// <summary>
    /// name         : #SelectEconomicSupportDetailsList Behavior 클래스
    /// desc         : #SelectEconomicSupportDetailsList Behavior 클래스
    /// author       : hwseong 
    /// create date  : 2024-07-18 오후 6:51:09
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class SelectEconomicSupportDetailsList
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
        private SelectEconomicSupportDetailsListData model;

        #endregion //Member Variables

        #region [Properties]

        #endregion //Properties

        #region [컨트롤 초기화]

        /// <summary>
        /// name         : 컨트롤 초기화
		/// desc         : UI에서 사용할 컨트롤을 초기화 함
		/// author       : hwseong
		/// create date  : 2024-07-18 오후 6:51:09
		/// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void ControlInit()
        {
            this.cbxStaticsTp.SelectedIndex = 0;
            this.cbxDateTp.SelectedIndex = 0;

            this.ucTerm.FromDateProperty = DateTime.Today.AddDays(-7);
            this.ucTerm.ToDateProperty = DateTime.Today;

            CodeBindManager.BaseCodeBind(cbxGrpTp, CommonServiceAgent.SelectCodeByGroup("W24", CodeUseYN.Use));
        }
        #endregion //컨트롤 초기화

        #region [데이타초기화(공통코드)]

        /// <summary>
        /// name         : 데이터 초기화
		/// desc         : 화면 로드시 데이터를 초기화 함
		/// author       : hwseong 
		/// create date  : 2024-07-18 오후 6:51:09
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
        /// author       : hwseong 
        /// create date  : 2024-07-18 오후 6:51:09
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void SelectEconomicSupportList()
        {
            try
            {
                this.RegisterShowBusyIndicator(Const.DoneWorkMsg);

                if (this.ucTerm.FromDateProperty == null || this.ucTerm.ToDateProperty == null)
                {
                    MsgBox.Display("조회일자를 입력하세요.", MessageType.MSG_TYPE_EXCLAMATION, "", true, MessageBoxButton.OK);
                    return;
                }


                this.model.Inobj.IN_FROM_DT = this.ucTerm.FromDateProperty.Value.ToShortDateString();
                this.model.Inobj.IN_TO_DT = this.ucTerm.ToDateProperty.Value.ToShortDateString();
                this.model.Inobj.IN_STC_TP = this.cbxStaticsTp.SelectedValue.ToString();


                this.model.Outobj = (HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT>)UIMiddlewareAgent.InvokeBizService(this
                     , "HIS.RP.SB.SB.FINM.BIZ.SelectEconomicSupportStatisticsBL"
                     , "SelectEconomicSupportDetailsList"
                     , this.model.Inobj);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                this.RegisterCloseBusyIndicator();
            }
        }

        #endregion //Methods
    }
}
