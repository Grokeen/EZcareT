using HIS.Core.Global.DTO;
using HIS.PA.AC.PE.PS.DTO;
using HIS.UI.Base;
using HIS.UI.Core;
using HIS.UI.Core.Commands;
using HIS.UI.Utility;
using HSF.TechSvc2010.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows;
using System.Windows.Input;

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : #HipassMobileApprovalMng Data 클래스
    /// desc         : #HipassMobileApprovalMng Data 클래스
    /// author       : JaeGang 
    /// create date  : 2023-12-26 오전 9:17:34
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class HipassMobileApprovalMngData : ViewModelBase
    {
        #region [Consts]
        private const string BIZ_CLASS = "";
        #endregion //Consts


        #region [Constructor]
        /// <summary>
        /// Initializes a new <see cref="MedicalCareApprobationAsk"/>
        /// </summary>
        public HipassMobileApprovalMngData()
        {
            //생성자 함수
            this.Init();
        }
        #endregion //Constructor




        #region [Properties]

        #endregion //Model Properties


        #region [Methods]



        //// 왜 
        //private HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> dataList;
        ///// <summary>
        ///// desc         : 조회 데이터 리스트
        ///// author       : leegidong 
        ///// create date  : 2016-03-18 오전 10:42:13
        ///// update date  : 최종 수정 일자, 수정자, 수정개요 
        ///// </summary>
        //public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> DataList
        //{
        //    get { return this.dataList; }
        //    set { if (this.dataList != value) { this.dataList = value; this.OnPropertyChanged("DataList", value); } }
        //}






        /// <summary>
        /// name         : ViewModel 초기화 함수
        /// desc         : ViewModel 을 초기화 함수 입니다.
        /// author       : kimeunjung 
        /// create date  : 2012-04-26 09:46:07
        /// update date  : 2012-04-26 09:46:07, kimeunjung, 수정개요
        /// </summary>
        private void Init()
        {
        }


        // 나중에 리스트로 받기 위해서 일단 만들고
        //private HSFDTOCollectionBaseObject<HipassMobileApprovalMng_IN> hipassMobileApprovalMng_INObj = new HSFDTOCollectionBaseObject<HipassMobileApprovalMng_IN>();
        //public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_IN> HipassMobileApprovalMng_INObj
        //{
        //    get
        //    {
        //        return hipassMobileApprovalMng_INObj;
        //    }
        //    set
        //    {
        //        if (hipassMobileApprovalMng_INObj != value)
        //        {
        //            hipassMobileApprovalMng_INObj = value;
        //            this.OnPropertyChanged("HipassMobileApprovalMng_INObj", value);
        //        }
        //    }
        //}

        HipassMobileApprovalMng_IN HipassMobileApprovalMng_GrData_IN = new HipassMobileApprovalMng_IN();
        /// <summary>
        /// desc         : IN DTO Property
        /// author       : leegidong 
        /// create Date  : 2016-07-05 오전 9:57:31
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        public HipassMobileApprovalMng_IN hipassMobileApprovalMng_GrData_IN
        {
            get { return this.hipassMobileApprovalMng_GrData_IN; }
            set
            {
                if (this.hipassMobileApprovalMng_GrData_IN != value)
                { 
                    this.hipassMobileApprovalMng_GrData_IN = value; 
                    this.OnPropertyChanged("HipassMobileApprovalMng_GrData_IN"); 
                }
            }
        }


        //HipassMobileApprovalMng_IN

        //hipassMobileApprovalMng_GrData_IN

        private HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> hipassMobileApprovalMng_OUTObj = new HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>();
        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> HipassMobileApprovalMng_OUTObj
        {
            get
            {
                return hipassMobileApprovalMng_OUTObj;
            }
            
            set
            {
                if (hipassMobileApprovalMng_OUTObj != value)
                {
                    hipassMobileApprovalMng_OUTObj = value;
                    this.OnPropertyChanged("HipassMobileApprovalMng_OUTObj", value);
                }
            }
        }
        #endregion //Methods
    }


}

