using HIS.PA.AC.PI.PI.DTO;
using HIS.UI.Base;
using HSF.TechSvc2010.Common;
using System;
using System.Windows.Input;
using HIS.PA.AC.PI.PI.DTO.SelectWayfarerAsk;

namespace HIS.PA.AC.PI.PI.UI
{
    /// <summary>
    /// name         : 행려환자내역조회
    /// desc         : #SelectWayfarerAsk Data 클래스
    /// author       : 김용록 
    /// create date  : 2024-08-08 오전 11:10:10
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class SelectWayfarerAskData : ViewModelBase
    {


        private SelectWayfarerAsk_IN selectWayfarerAsk_GrIN = new SelectWayfarerAsk_IN();

        private HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT> selectWayfarerAsk_GrOUT = new HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT>();

        /// ---------------------------------------------------------------------
        /// <summary>
        /// desc         : SelectWayfarerAsk_IN DTO Property
        /// author       : 김용록 
        /// create Date  : 2024-08-14 오전 9:57:31                                   
        /// update date  : 
        /// ---------------------------------------------------------------------
        public SelectWayfarerAsk_IN SelectWayfarerAsk_GrIN
        {
            get { return this.selectWayfarerAsk_GrIN; }
            set
            {
                if (this.selectWayfarerAsk_GrIN != value)
                {
                    this.selectWayfarerAsk_GrIN = value;
                    this.OnPropertyChanged("SelectWayfarerAsk_GrIN");
                }
            }
        }
        /// ---------------------------------------------------------------------
        /// <summary>
        /// desc         : SelectWayfarerAsk_OUT DTO Property
        /// author       : 김용록 
        /// create Date  : 2024-08-14 오전 9:57:31
        /// update date  : 
        /// ---------------------------------------------------------------------
        public HSFDTOCollectionBaseObject<SelectWayfarerAsk_OUT> SelectWayfarerAsk_GrOUT
        {
            get
            {
                return selectWayfarerAsk_GrOUT;
            }
            set
            {
                if (selectWayfarerAsk_GrOUT != value)
                {
                    selectWayfarerAsk_GrOUT = value;
                    this.OnPropertyChanged("SelectWayfarerAsk_GrOUT", value);
                }
            }
        }
    }
}
