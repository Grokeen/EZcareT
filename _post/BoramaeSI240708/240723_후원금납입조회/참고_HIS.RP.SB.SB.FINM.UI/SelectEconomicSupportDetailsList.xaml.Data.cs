using HIS.UI.Base;
using HIS.RP.SB.SB.FINM.DTO;
using HIS.Core.Global.DTO;
using HSF.TechSvc2010.Common;
using HIS.Core.Common;
using System;
using System.Windows.Input;

namespace HIS.RP.SB.SB.FINM.UI
{
    /// <summary>
    /// name         : #SelectEconomicSupportDetailsList Data 클래스
    /// desc         : #SelectEconomicSupportDetailsList Data 클래스
    /// author       : hwseong 
    /// create date  : 2024-07-18 오후 6:51:09
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class SelectEconomicSupportDetailsListData : ViewModelBase
    {
        #region [Constructor]
        /// <summary>
        /// Initializes a new <see cref="SelectEconomicSupportDetailsList"/>
        /// </summary>
        public SelectEconomicSupportDetailsListData()
        {
            this.Init();
        }
        #endregion //Constructor

        /// <summary>
        /// desc         : 경제적 지원 통계 조회 조건 DTO
        /// author       : 성혜원 
        /// create date  : 2024-07-17
        /// update date  : 2024-07-17, 성혜원, 최초 작성
        /// </summary>
        SelectEconomicSupportStatistics_INOUT inobj = new SelectEconomicSupportStatistics_INOUT();

        public SelectEconomicSupportStatistics_INOUT Inobj
        {
            get { return this.inobj; }
            set { if (this.inobj != value) { this.inobj = value; this.OnPropertyChanged("Inobj"); } }
        }

        /// <summary>
        /// desc         : 경제적 지원 통계 조회 결과 DTO
        /// author       : 성혜원 
        /// create date  : 2024-07-17
        /// update date  : 2024-07-17, 성혜원, 최초 작성
        /// </summary>
        HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> outobj = new HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT>();

        public HSFDTOCollectionBaseObject<SelectEconomicSupportStatistics_INOUT> Outobj
        {
            get { return this.outobj; }
            set { if (this.outobj != value) { this.outobj = value; this.OnPropertyChanged("Outobj"); } }
        }

        /// <summary>
        /// desc         : 통계분류 콤보박스 DTO
        /// author       : 성혜원 
        /// create date  : 2024-07-17
        /// update date  : 2024-07-17, 성혜원, 최초 작성
        /// </summary>
        HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> cbxobj1 = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();

        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Cbxobj1
        {
            get { return this.cbxobj1; }
            set { if (this.cbxobj1 != value) { this.cbxobj1 = value; this.OnPropertyChanged("Cbxobj1"); } }
        }

        /// <summary>
        /// desc         : 조회일자기준 콤보박스 DTO
        /// author       : 성혜원 
        /// create date  : 2024-07-17
        /// update date  : 2024-07-17, 성혜원, 최초 작성
        /// </summary>
        HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> cbxobj2 = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();

        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Cbxobj2
        {
            get { return this.cbxobj2; }
            set { if (this.cbxobj2 != value) { this.cbxobj2 = value; this.OnPropertyChanged("Cbxobj2"); } }
        }

        #region [Methods]
        /// <summary>
        /// name         : ViewModel 초기화 함수
        /// desc         : ViewModel 초기화 함수 입니다.
        /// author       : hwseong
        /// create date  : 2024-07-17
        /// update date  : 2024-07-17, 성혜원 , 최초 작성
        /// </summary>
        private void Init()
        {
            //여기 말고 쓸 일이 없어서... 공통코드 귀찮아서.. 
            Cbxobj1.Add(new CCCCCSTE_INOUT() { COMN_CD = "PT",   COMN_CD_NM = "환자별 후원금내역조회" });
            Cbxobj1.Add(new CCCCCSTE_INOUT() { COMN_CD = "GRP",  COMN_CD_NM = "기관별 후원금내역조회" });
            Cbxobj1.Add(new CCCCCSTE_INOUT() { COMN_CD = "DEPT", COMN_CD_NM = "진료과별 후원금내역조회" });

            Cbxobj2.Add(new CCCCCSTE_INOUT() { COMN_CD = "D", COMN_CD_NM = "지원결정일 기준" });
            Cbxobj2.Add(new CCCCCSTE_INOUT() { COMN_CD = "S", COMN_CD_NM = "지원일 기준" });
        }
        #endregion
    }
}
