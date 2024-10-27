using HIS.Core.Global.DTO;
using HIS.Core.Global.DTO.CommonLogging;
//using PDF2IMGOCXLib;
using HIS.Core.Sign;
using HIS.MC.CI.Core.DTO;
using HIS.MC.CI.Core.UI.Common;
using HIS.MC.Core.Common.Controls;
using HIS.MC.Core.Common.Enum;
using HIS.MC.Core.DTO;
/* 빌드관련 주석처리 - 강성희
using HIS.MC.DM.PT.SC.UI;
*/
using HIS.MC.DM.PS.MN.DTO;
using HIS.MC.DR.CR.RC.DTO;
using HIS.MC.DR.RM.CL.UI;
using HIS.MC.DR.RM.RS.DTO;
using HIS.MC.DR.RM.RS.UI;
using HIS.MC.DR.RM.RV.DTO;
using HIS.MC.NR.NV.NV.DTO;
using HIS.MS.PM.COMM.UI.PMCommon; //병리
//using HIS.MC.DM.OR.MN.UI;
using HIS.MS.SE.EXCT.DTO;
using HIS.UI.Base;
//2023-11-21, 박찬규, 개발환경셋팅
//using HSF.TechSvc2010.Server.Remoting;

using HIS.UI.Core;
using HIS.UI.Core.Commands;
using HIS.UI.Core.Individuality;
using HIS.UI.CoreWork.Log;
using HIS.UI.Utility;
using HIS.UI.Utility.Extension;
using HSF.Controls.WPF;
using HSF.Report.Core;
using HSF.Report.Core.Document;
using HSF.Report.Extention;
using HSF.TechSvc2010.Common;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Threading;
using System.Xml;

//namespace HIS.MC.DR.RM.RV.UI


namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : 통합기록조회 UI Data 클래스
    /// desc         : 통합기록조회 UI Data 클래스 개요
    /// author       : 김정훈 
    /// create date  : 2012-07-03 오후 7:43:49
    /// update date  : 2013-12-27 김정훈 : 1. 환자선택권한체크, 환자선택사유입력 체크 추가 (AS-IS 와 동일하도록)   
    /// </summary>
    public class SelectIntegrationMedicalRecordAskData : ViewModelBase
    {
        #region [Consts]
        private const string BIZ_CLASS = "HIS.MC.DR.RM.RV.BIZ.SelectIntegrationMedicalRecordAskBL";
        #endregion //Consts

        #region [Constructor]
        /// <summary>
        /// Initializes a new <see cref="SelectIntegrationMedicalRecordAsk"/>
        /// </summary>
        public SelectIntegrationMedicalRecordAskData()
        {

            this.Init();
        }
        #endregion //Constructor

        #region [Member Variables]

        #region 초기화 정보
        private PatientInformation_INOUT patientInformation = new PatientInformation_INOUT();//환자정보
        private UserInformation_INOUT UserInformation = new UserInformation_INOUT();//사용자정보
        private RecordList_INOUT selected_recordlistbydiagnosis_dto;

        private String _CALLER;//발신자
        private String _PT_NO;//환자번호
        private String _STF_NO;//직원번호
        //private String SNUHView;//본원 파라미터     //미사용 로직제거 22.12월
        //private String PARAM; //PACS에서 뷰어 띄울때 파라미터 //미사용 로직제거 22.12월

        private String _CHGYN;

        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> allCodes; //공통코드정보
        private UserAuthorityManagement_INOUT UsrAuthInfo; //의무기록뷰어 권한정보
        #endregion 초기화 정보

        #region 공통
        private SearchCondition_IN searchCondition = new SearchCondition_IN();//조회조건

        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_Period = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//기간
        private CCCCCSTE_INOUT selectedPeriod = new CCCCCSTE_INOUT();//선택된기간        
        private String selectedPeriodValue = String.Empty; //선택된기간(SelectedValue)
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_Pact_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//원무접수구분
        private CCCCCSTE_INOUT selectedPact_Type = new CCCCCSTE_INOUT();//선택된원무접수구분

        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_Record_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//기록구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_RecordDetail_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//기록상세구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_DoctorRecord_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//진료기록구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_ORder_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//처방구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_NursingRecord_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//간호기록구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_EXam_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//검사구분        
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_SCan_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//스캔자료구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_CharacteristicRecord_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//특성화기록 구분        
        private String selectedCharacteristicRecordType = String.Empty;//선택된 특성화기록 구분

        private HSFDTOCollectionBaseObject<Department_INOUT> MedicalTreatmentHistoryGroupList = new HSFDTOCollectionBaseObject<Department_INOUT>(); //진료과 그룹
        private HSFDTOCollectionBaseObject<Department_INOUT> departmentGroup = new HSFDTOCollectionBaseObject<Department_INOUT>();// 전체 진료과목록
        private Department_INOUT selectedDepartment = new Department_INOUT();// 선택된 진료과

        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> recordTypeGroup = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//전체 기록구분 목록

        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> selectedRecordList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 기록목록(조회될 기록목록)
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordListDR = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 진료기록목록
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordListOR = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 처방목록
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordListNR = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 간호기록목록
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordListEX = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 검사기록목록        
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordListSC = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 스캔자료목록
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordListEC = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 전자동의서목록
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordListCR = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//선택된 특성화기록목록
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> printedRecordList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();//조회된 기록목록

        private RecordList_INOUT selectedRecord = new RecordList_INOUT();//선택된 기록(조회될 기록)
        private Double WindowWidth;     //Window 객체의 Width 값을 저장할 변수
        private String WindowMode;      //Min Max
        private String flowDocumentViewMode;//FlowDocumentReader의 ViewMode
        private bool patientSelectAuthority = true; //환자선택권한
        private bool actingSign = false;//수행사인여부
        private bool isIncludeOrderHistory = false;// 오더 이력포함 여부
        private bool apcnDtm = false;//취소수진여부
        private String listWidth = "0.5*";// 목록조회 Width
        private double listMinWidth = 400d;
        private String contentWidth = "0.492*";// 내용조회 Width

        private bool printAuthority = false;//출력권한
        private bool imagePrintAuthority = true;//이미지출력권한
        private Visibility searchPrintModeVisibility = Visibility.Collapsed;//출력조회버튼 조회
        private Visibility printPreviewVisibility = Visibility.Collapsed;//인쇄미리보기버튼 조회
        private bool imagePrintingAskChecked = false; //이미지 출력 체크여부
        private Visibility imagePrintingAskVisibility = Visibility.Collapsed; //이미지출력 체크박스 Visibility
        private bool isImagePrintingAsEnabled = false;
        private bool printingAskChecked = false; //출력용 조회 체크여부
        private Visibility printingAskVisibility = Visibility.Collapsed; //출력용조회 체크박스 Visibility
        private bool engAskChecked = false; //영문 조회 체크여부
        private bool spcmKorInscrChecked = false; //검체 한글명 병기 체크여부
        private bool NPRecAskYN = false; //정신과기록 조회권한 여부
        private bool recordHistoryAuthority = false;//기록이력조회권한

        private Visibility askByHavingAMedicalExaminationTab = Visibility.Visible; //수진일별 기록조회 Tab Visibility
        private Visibility askByConditionTab = Visibility.Visible; //조건별 기록조회 Tab Visibility
        private Visibility askByHavingAMedicalExaminationHistoryTab = Visibility.Visible; //기록이력조회 Tab Visibility
        private Visibility askByDiagnosisCertificateTab = Visibility.Visible; // 진단서 Tab Visibility
        private Visibility askByConsentFormTab = Visibility.Visible; // 동의서 Tab Visibility
        private Visibility askByCharacteristicRecordTab = Visibility.Visible; // 특성화기록 Tab Visibility

        private bool recordCopyEnabled = false; //기록내용선택 여부(복사)

        //2024-04-19, 박찬규, 이미지 출력 관련 개발 (PSS_MC_0527)
        private Visibility operationimagePrintingAskVisibility = Visibility.Collapsed; //수술기록 이미지출력 체크박스 Visibility
        private bool isImageOperationPrintingAsEnabled = false;
        private bool operationImagePrintingAskChecked = false; //이미지 출력 체크여부
        private bool operationimagePrintAuthority = true;//이미지출력권한

        //2024-07-15, 박찬규, 신포괄 관련 작업 (PSS_MC_0609)
        private Visibility newDrgDeterminationVisibility = Visibility.Collapsed;
        #endregion 공통

        #region 수진일별 기록조회
        private HSFDTOCollectionBaseObject<MedicalTreatmentHistoryList_INOUT> medicalTreatmentHistoryList = new HSFDTOCollectionBaseObject<MedicalTreatmentHistoryList_INOUT>();//수진이력
        private MedicalTreatmentHistoryList_INOUT selectedMedicalTreatmentHistory = new MedicalTreatmentHistoryList_INOUT();//선택된 수진이력
        private HSFDTOCollectionBaseObject<RecordList_INOUT> recordListByMedicalTreatmentDay = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//진료일별 기록목록
        private HSFDTOCollectionBaseObject<RecordList_INOUT> selectedRecordListByMedicalTreatmentDay = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//선택된 진료일별 기록목록

        private CollectionView MedicalTreatmentHistoryListView;// 수진이력목록 CollectionView : ObservableCollection 인 formListItems 을 정렬하기 위한 CollectionView 입니다.        
        private RecordType_IN RecordTypeFilter = new RecordType_IN();

        private String medicalTreatmentHistoryListHeight; // 수진이력목록 높이
        private String medicalTreatmentDayHeight;// 수진일별 기록목록 높이
        private bool IsFirstSearchMedicalTreatmentHistoryList = true;//수진이력조회여부
        #endregion 수진일별 기록조회

        #region 조건별 상세조회

        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> selectedRecordTypeList = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//선택된기록유형목록
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> selectedRecordDetailTypeList = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//선택된기록상세유형목록
        private HSFDTOCollectionBaseObject<RecordList_INOUT> recordListByCondition = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//조건별 기록목록
        private HSFDTOCollectionBaseObject<RecordList_INOUT> selectedRecordListByCondition = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//선택된조건별기록목록
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_Dept_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//진료과구분
        private CCCCCSTE_INOUT selectedDept_Type = new CCCCCSTE_INOUT();//선택된진료과구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_WRTR_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//작성자구분
        private CCCCCSTE_INOUT selectedWRTR_Type = new CCCCCSTE_INOUT();//선택된작성자구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_ListSort_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//목록조회정렬구분
        private CCCCCSTE_INOUT selectedListSort_Type = new CCCCCSTE_INOUT();//선택된목록조회정렬구분
        private HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> code_ContentSort_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();//내용조회정렬구분
        private CCCCCSTE_INOUT selectedContentListSort_Type = new CCCCCSTE_INOUT();//선택된내용조회정렬구분

        #endregion 조건별 상세조회

        #region 기록이력조회

        private MedicalTreatmentHistoryList_INOUT selectedMedicalTreatmentHistory_his = new MedicalTreatmentHistoryList_INOUT();//선택된 수진이력_his
        private HSFDTOCollectionBaseObject<RecordList_INOUT> recordListByMedicalTreatmentDay_his = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//진료일별 기록목록_his
        private HSFDTOCollectionBaseObject<RecordList_INOUT> havingAMedicalExaminationList; //기록이력조회 detail
        private HSFDTOCollectionBaseObject<RecordList_INOUT> havingAMedicalExaminationDetailBindingList;

        private HSFDTOCollectionBaseObject<RecordList_INOUT> selectedHavingAMedicalExaminationDetailBindingList = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//선택된 진료일별 기록목록_his
        private HSFDTOCollectionBaseObject<RecordList_INOUT> selectedRecordListByMedicalTreatmentDay_his = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//



        #endregion 기록이력조회

        #region 진단서 조회
        private HSFDTOCollectionBaseObject<RecordList_INOUT> recordListByDiagnosis = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//진단서 기록목록
        private HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT> diagnosisCertificatePrintList = new HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT>();//진단서 출력목록
        private PrintingLogInformation_INOUT selectedDiagnosisCertificatePrint = new PrintingLogInformation_INOUT();//선택된 진단서출력목록        
        #endregion 진단서 조회

        #region 전자동의서 조회
        private HSFDTOCollectionBaseObject<RecordList_INOUT> recordListByConsentNote = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//전자동의서 기록목록
        private HSFDTOCollectionBaseObject<RecordList_INOUT> selectedRecordListByConsentNote = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//선택된 전자동의서 기록
        #endregion 전자동의서 조회

        #region 전자동의서 출력 로그
        private HSFDTOCollectionBaseObject<RecordList_INOUT> prntLog_DTO = new HSFDTOCollectionBaseObject<RecordList_INOUT>();// 출력로그를 저장하기 위한 DTO
        #endregion 전자동의서 출력 로그

        #region 특성화리포트 조회        
        private HSFDTOCollectionBaseObject<RecordList_INOUT> recordListByCharacteristicRecord = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//특성화 기록목록
        private HSFDTOCollectionBaseObject<RecordList_INOUT> selectedCharacteristicRecord = new HSFDTOCollectionBaseObject<RecordList_INOUT>();//선택된 특성화 기록        
        #endregion 특성화리포트 조회

        #region 제증명 관련        
        private int iPrintCount;// 출력매수

        private bool printSentenceAuthority = false;//출력문구권한
        private bool printGeneExaminationAuthority = false;// 2015-02-05 박제영 : 유전자검사 출력권한        
        #endregion 제증명 관련

        #region 의무기록실 관련
        private bool inCompleteAuthority = false;//미완성등록권한
        private Visibility inCompleteVisibility = Visibility.Collapsed;//미완성등록버튼 조회
        private String selectedPACT_ID;//선택된 원무접수ID
        private String selectedRECORD_DETAIL_TYPE;//선택된 기록상세구분
        #endregion 의무기록실 관련        
        #endregion //Member Variables

        #region [View Properties]
        private bool isFirstLoad = true;
        SelectIntegrationMedicalRecordAsk thisUserControl;
        //UserControlBase diagnosisCertificateFormManagementContent = new UserControlBase();//진단서
        bool isOpenPopup = false; //서식팝업 open 속성

        private MedicalTreatmentRecordHistoryHavingAMedicalExamination_INOUT medrecHeaderInfo;
        public MedicalTreatmentRecordHistoryHavingAMedicalExamination_INOUT MedrecHeaderInfo
        {
            get
            {
                return this.medrecHeaderInfo;
            }
            set
            {
                this.medrecHeaderInfo = value; OnPropertyChanged("MedrecHeaderInfo", value);
            }
        }

        #endregion //View  Properties

        #region [Model Properties]

        #region 초기화정보
        /// <summary>
        /// desc         : 환자정보
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public PatientInformation_INOUT PatientInformation
        {
            get { return this.patientInformation; }
            set { if (this.patientInformation != value) { this.patientInformation = value; this.OnPropertyChanged("PatientInformation"); } }
        }

        /// <summary>
        /// desc         : 화면호출구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String CALLER
        {
            get { return this._CALLER; }
            set { if (this._CALLER != value) { this._CALLER = value; this.OnPropertyChanged("CALLER"); } }
        }

        /// <summary>
        /// desc         : 타 메인에서 환자변경시, 조회되록 하는 구분자
        /// author       : 오윤미
        /// create date  : 2021-05-12
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String CHGYN
        {
            get { return this._CHGYN; }
            set { if (this._CHGYN != value) { this._CHGYN = value; this.OnPropertyChanged("CHGYN"); } }
        }

        /// <summary>
        /// desc         : 환자번호
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String PT_NO
        {
            get { return this._PT_NO; }
            set { if (this._PT_NO != value) { this._PT_NO = value; this.OnPropertyChanged("PT_NO"); } }
        }

        /// <summary>
        /// desc         : 직원번호
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String STF_NO
        {
            get { return this._STF_NO; }
            set { if (this._STF_NO != value) { this._STF_NO = value; this.OnPropertyChanged("STF_NO"); } }
        }
        #endregion 초기화정보

        #region 공통
        /// <summary>
        /// desc         : 선택된 출력사유
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public SearchCondition_IN SearchCondition
        {
            get { return this.searchCondition; }
            set { if (this.searchCondition != value) { this.searchCondition = value; this.OnPropertyChanged("SearchCondition"); } }
        }
        /// <summary>
        /// desc         : 기간
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_Period
        {
            get { return this.code_Period; }
            set { if (this.code_Period != value) { this.code_Period = value; this.OnPropertyChanged("Code_Period"); } }
        }
        /// <summary>
        /// desc         : 선택된 기간
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public CCCCCSTE_INOUT SelectedPeriod
        {
            get { return this.selectedPeriod; }
            set { if (this.selectedPeriod != value) { this.selectedPeriod = value; this.OnPropertyChanged("SelectedPeriod"); } }
        }

        /// <summary>
        /// desc         : 선택된 기간(SelectedValue)
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String SelectedPeriodValue
        {
            get { return this.selectedPeriodValue; }
            set { if (this.selectedPeriodValue != value) { this.selectedPeriodValue = value; this.OnPropertyChanged("SelectedPeriodValue"); } }
        }

        /// <summary>
        /// desc         : 원무접수 구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_Pact_Type
        {
            get { return this.code_Pact_Type; }
            set { if (this.code_Pact_Type != value) { this.code_Pact_Type = value; this.OnPropertyChanged("Code_Pact_Type"); } }
        }

        /// <summary>
        /// desc         : 선택된 원무접수 구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public CCCCCSTE_INOUT SelectedPact_Type
        {
            get { return this.selectedPact_Type; }
            set { if (this.selectedPact_Type != value) { this.selectedPact_Type = value; this.OnPropertyChanged("SelectedPact_Type"); } }
        }

        /// <summary>
        /// desc         : 기록구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_Record_Type
        {
            get { return this.code_Record_Type; }
            set { if (this.code_Record_Type != value) { this.code_Record_Type = value; this.OnPropertyChanged("Code_Record_Type"); } }
        }

        /// <summary>
        /// desc         : 기록상세구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_RecordDetail_Type
        {
            get { return this.code_RecordDetail_Type; }
            set { if (this.code_RecordDetail_Type != value) { this.code_RecordDetail_Type = value; this.OnPropertyChanged("Code_RecordDetail_Type"); } }
        }

        /// <summary>
        /// desc         : 진료기록구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_DoctorRecord_Type
        {
            get { return this.code_DoctorRecord_Type; }
            set { if (this.code_DoctorRecord_Type != value) { this.code_DoctorRecord_Type = value; this.OnPropertyChanged("Code_DoctorRecord_Type"); } }
        }

        /// <summary>
        /// desc         : 처방구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_ORder_Type
        {
            get { return this.code_ORder_Type; }
            set { if (this.Code_ORder_Type != value) { this.Code_ORder_Type = value; this.OnPropertyChanged("Code_ORder_Type"); } }
        }

        /// <summary>
        /// desc         : 간호기록구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_NursingRecord_Type
        {
            get { return this.code_NursingRecord_Type; }
            set { if (this.code_NursingRecord_Type != value) { this.code_NursingRecord_Type = value; this.OnPropertyChanged("Code_NursingRecord_Type"); } }
        }

        /// <summary>
        /// desc         : 검사구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_EXam_Type
        {
            get { return this.code_EXam_Type; }
            set { if (this.code_EXam_Type != value) { this.code_EXam_Type = value; this.OnPropertyChanged("Code_EXam_Type"); } }
        }

        /// <summary>
        /// desc         : 스캔자료구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_SCan_Type
        {
            get { return this.code_SCan_Type; }
            set { if (this.code_SCan_Type != value) { this.code_SCan_Type = value; this.OnPropertyChanged("Code_SCan_Type"); } }
        }

        /// <summary>
        /// desc         : 특성화기록 구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_CharacteristicRecord_Type
        {
            get { return this.code_CharacteristicRecord_Type; }
            set { if (this.code_CharacteristicRecord_Type != value) { this.code_CharacteristicRecord_Type = value; this.OnPropertyChanged("Code_CharacteristicRecord_Type"); } }
        }

        /// <summary>
        /// desc         : 선택된 특성화기록 구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String SelectedCharacteristicRecordType
        {
            get { return this.selectedCharacteristicRecordType; }
            set { if (this.selectedCharacteristicRecordType != value) { this.selectedCharacteristicRecordType = value; this.OnPropertyChanged("SelectedCharacteristicRecordType"); } }
        }

        /// <summary>
        /// desc         : 전체 진료과목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<Department_INOUT> DepartmentGroup
        {
            get { return this.departmentGroup; }
            set { if (this.departmentGroup != value) { this.departmentGroup = value; this.OnPropertyChanged("DepartmentGroup"); } }
        }

        /// <summary>
        /// desc         : 선택된 진료과
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Department_INOUT SelectedDepartment
        {
            get { return this.selectedDepartment; }
            set { if (this.selectedDepartment != value) { this.selectedDepartment = value; this.OnPropertyChanged("SelectedDepartment"); } }
        }

        /// <summary>
        /// desc         : 선택된 기록목록(조회될 기록목록)
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SelectedRecordList
        {
            get { return this.selectedRecordList; }
            set { if (this.selectedRecordList != value) { this.selectedRecordList = value; this.OnPropertyChanged("SelectedRecordList"); } }
        }

        /// <summary>
        /// desc         : 조회된 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<PrintRecordList_INOUT> PrintedRecordList
        {
            get { return this.printedRecordList; }
            set { if (this.printedRecordList != value) { this.printedRecordList = value; this.OnPropertyChanged("PrintedRecordList"); } }
        }

        /// <summary>
        /// desc         : 선택된 기록(조회될 기록)
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public RecordList_INOUT SelectedRecord
        {
            get { return this.selectedRecord; }
            set { if (this.selectedRecord != value) { this.selectedRecord = value; this.OnPropertyChanged("SelectedRecord"); } }
        }

        /// <summary>
        /// desc         : FlowDocumentReader의 ViewMode
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String FlowDocumentViewMode
        {
            get { return this.flowDocumentViewMode; }
            set { if (this.flowDocumentViewMode != value) { this.flowDocumentViewMode = value; this.OnPropertyChanged("FlowDocumentViewMode"); } }
        }

        /// <summary>
        /// desc         : 환자선택권한
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool PatientSelectAuthority
        {
            get { return this.patientSelectAuthority; }
            set { if (this.patientSelectAuthority != value) { this.patientSelectAuthority = value; this.OnPropertyChanged("PatientSelectAuthority"); } }
        }

        /// <summary>
        /// desc         : 수행사인여부
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool ActingSign
        {
            get { return this.actingSign; }
            set { if (this.actingSign != value) { this.actingSign = value; this.OnPropertyChanged("ActingSign"); } }
        }

        /// <summary>
        /// desc         : 오더 이력포함 여부
        /// author       : 이산
        /// create date  : 2023-07-28
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool IsIncludeOrderHistory
        {
            get { return this.isIncludeOrderHistory; }
            set { if (this.isIncludeOrderHistory != value) { this.isIncludeOrderHistory = value; this.OnPropertyChanged("IsIncludeOrderHistory"); } }
        }

        /// <summary>
        /// desc         : 취소수진여부
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool ApcnDtm
        {
            get { return this.apcnDtm; }
            set { if (this.apcnDtm != value) { this.apcnDtm = value; this.OnPropertyChanged("ApcnDtm"); } }
        }

        /// <summary>
        /// desc         : 목록조회 Width
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String ListWidth
        {
            get { return this.listWidth; }
            set { if (this.listWidth != value) { this.listWidth = value; this.OnPropertyChanged("ListWidth"); } }
        }

        public double ListMinWidth
        {
            get { return this.listMinWidth; }
            set { if (this.listMinWidth != value) { this.listMinWidth = value; this.OnPropertyChanged("ListMinWidth"); } }
        }

        /// <summary>
        /// desc         : 내용조회 Width
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String ContentWidth
        {
            get { return this.contentWidth; }
            set { if (this.contentWidth != value) { this.contentWidth = value; this.OnPropertyChanged("ContentWidth"); } }
        }

        /// <summary>
        /// desc         : 출력권한
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool PrintAuthority
        {
            get { return printAuthority; }
            set { if (printAuthority != value) { printAuthority = value; OnPropertyChanged("PrintAuthority", value); } }
        }

        /// <summary>
        /// desc         : 출력조회버튼 조회
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility SearchPrintModeVisibility
        {
            get { return searchPrintModeVisibility; }
            set { if (searchPrintModeVisibility != value) { searchPrintModeVisibility = value; OnPropertyChanged("SearchPrintModeVisibility", value); } }
        }

        /// <summary>
        /// desc         : 인쇄미리보기버튼 조회
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility PrintPreviewVisibility
        {
            get { return printPreviewVisibility; }
            set { if (printPreviewVisibility != value) { printPreviewVisibility = value; OnPropertyChanged("PrintPreviewVisibility", value); } }
        }

        /// <summary>
        /// desc         : 이미지 출력 체크여부
        /// author       : 이산
        /// create date  : 2023-05-30
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool ImagePrintingAskChecked
        {
            get { return imagePrintingAskChecked; }
            set { if (imagePrintingAskChecked != value) { imagePrintingAskChecked = value; OnPropertyChanged("ImagePrintingAskChecked", value); } }
        }

        /// <summary>
        /// desc         : 이미지 출력 체크박스 Visibility
        /// author       : 이산
        /// create date  : 2023-05-30
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility ImagePrintingAskVisibility
        {
            get { return imagePrintingAskVisibility; }
            set { if (imagePrintingAskVisibility != value) { imagePrintingAskVisibility = value; OnPropertyChanged("ImagePrintingAskVisibility", value); } }
        }

        /// <summary>
        /// desc         : 수술기록 이미지 출력 체크박스 Visibility
        /// author       : 박찬규
        /// create date  : 2024-04-19
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility OperationimagePrintingAskVisibility
        {
            get { return operationimagePrintingAskVisibility; }
            set { if (operationimagePrintingAskVisibility != value) { operationimagePrintingAskVisibility = value; OnPropertyChanged("OperationimagePrintingAskVisibility", value); } }
        }

        public bool IsImagePrintingAsEnabled
        {
            get { return isImagePrintingAsEnabled; }
            set { if (isImagePrintingAsEnabled != value) { isImagePrintingAsEnabled = value; OnPropertyChanged("IsImagePrintingAsEnabled", value); } }
        }

        /// <summary>
        /// desc         : 수술기록 이미지 출력 체크여부
        /// author       : 박찬규
        /// create date  : 2024-04-19
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool OperationImagePrintingAskChecked
        {
            get { return operationImagePrintingAskChecked; }
            set { if (operationImagePrintingAskChecked != value) { operationImagePrintingAskChecked = value; OnPropertyChanged("OperationImagePrintingAskChecked", value); } }
        }

        /// <summary>
        /// desc         : 수술기록 이미지 출력 체크박스 Enabled
        /// author       : 박찬규
        /// create date  : 2024-04-19
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool IsImageOperationPrintingAsEnabled
        {
            get { return isImageOperationPrintingAsEnabled; }
            set { if (isImageOperationPrintingAsEnabled != value) { isImageOperationPrintingAsEnabled = value; OnPropertyChanged("IsImageOperationPrintingAsEnabled", value); } }
        }
        /// <summary>
        /// desc         : 출력용 조회 체크여부
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool PrintingAskChecked
        {
            get { return printingAskChecked; }
            set { if (printingAskChecked != value) { printingAskChecked = value; OnPropertyChanged("PrintingAskChecked", value); } }
        }

        /// <summary>
        /// desc         : 출력용 조회 체크박스 Visibility
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility PrintingAskVisibility
        {
            get { return printingAskVisibility; }
            set { if (printingAskVisibility != value) { printingAskVisibility = value; OnPropertyChanged("PrintingAskVisibility", value); } }
        }

        /// <summary>
        /// desc         : 영문 조회 체크여부
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool EngAskChecked
        {
            get { return engAskChecked; }
            set { if (engAskChecked != value) { engAskChecked = value; OnPropertyChanged("EngAskChecked", value); } }
        }

        /// <summary>
        /// desc         : 검체 한글명 병기 체크여부
        /// author       : 강성희
        /// create date  : 2016-10-21 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool SpcmKorInscrChecked
        {
            get { return spcmKorInscrChecked; }
            set { if (spcmKorInscrChecked != value) { spcmKorInscrChecked = value; OnPropertyChanged("SpcmKorInscrChecked", value); } }
        }

        /// <summary>
        /// desc         : 수진일별 기록조회 Tab Visibility
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility AskByHavingAMedicalExaminationTab
        {
            get { return askByHavingAMedicalExaminationTab; }
            set { if (askByHavingAMedicalExaminationTab != value) { askByHavingAMedicalExaminationTab = value; OnPropertyChanged("AskByHavingAMedicalExaminationTab", value); } }
        }

        /// <summary>
        /// desc         : 수진일별 기록조회 Tab Visibility
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility AskByConditionTab
        {
            get { return askByConditionTab; }
            set { if (askByConditionTab != value) { askByConditionTab = value; OnPropertyChanged("AskByConditionTab", value); } }
        }

        /// <summary>
        /// desc         : 
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility AskByHavingAMedicalExaminationHistoryTab
        {
            get { return askByHavingAMedicalExaminationHistoryTab; }
            set { if (askByHavingAMedicalExaminationHistoryTab != value) { askByHavingAMedicalExaminationHistoryTab = value; OnPropertyChanged("AskByHavingAMedicalExaminationHistoryTab", value); } }
        }

        /// <summary>
        /// desc         : 진단서 Tab Visibility
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility AskByDiagnosisCertificateTab
        {
            get { return askByDiagnosisCertificateTab; }
            set { if (askByDiagnosisCertificateTab != value) { askByDiagnosisCertificateTab = value; OnPropertyChanged("AskByDiagnosisCertificateTab", value); } }
        }

        /// <summary>
        /// desc         : 동의서 Tab Visibility
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility AskByConsentFormTab
        {
            get { return askByConsentFormTab; }
            set { if (askByConsentFormTab != value) { askByConsentFormTab = value; OnPropertyChanged("AskByConsentFormTab", value); } }
        }

        /// <summary>
        /// desc         : 특성화기록 Tab Visibility
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility AskByCharacteristicRecordTab
        {
            get { return askByCharacteristicRecordTab; }
            set { if (askByCharacteristicRecordTab != value) { askByCharacteristicRecordTab = value; OnPropertyChanged("AskByCharacteristicRecordTab", value); } }
        }

        /// <summary>
        /// desc         : 의무기록뷰어 기록 블록지정여부(복사가능여부)
        /// author       : 강성희
        /// create date  : 2016-09-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public bool RecordCopyEnabled
        {
            get { return recordCopyEnabled; }
            set { if (recordCopyEnabled != value) { recordCopyEnabled = value; OnPropertyChanged("RecordCopyEnabled", value); } }
        }


        #endregion 공통

        #region 수진일별 기록조회
        /// <summary>
        /// desc         : 수진이력
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedicalTreatmentHistoryList_INOUT> MedicalTreatmentHistoryList
        {
            get { return this.medicalTreatmentHistoryList; }
            set { if (this.medicalTreatmentHistoryList != value) { this.medicalTreatmentHistoryList = value; this.OnPropertyChanged("MedicalTreatmentHistoryList"); } }
        }
        /// <summary>
        /// desc         : 선택된 수진이력
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public MedicalTreatmentHistoryList_INOUT SelectedMedicalTreatmentHistory
        {
            get { return this.selectedMedicalTreatmentHistory; }
            set { if (this.selectedMedicalTreatmentHistory != value) { this.selectedMedicalTreatmentHistory = value; this.OnPropertyChanged("SelectedMedicalTreatmentHistory"); } }
        }
        /// <summary>
        /// desc         : 진료일별 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> RecordListByMedicalTreatmentDay
        {
            get { return this.recordListByMedicalTreatmentDay; }
            set { if (this.recordListByMedicalTreatmentDay != value) { this.recordListByMedicalTreatmentDay = value; this.OnPropertyChanged("RecordListByMedicalTreatmentDay"); } }
        }

        /// <summary>
        /// desc         : 선택된 진료일별 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> SelectedRecordListByMedicalTreatmentDay
        {
            get { return this.selectedRecordListByMedicalTreatmentDay; }
            set { if (this.selectedRecordListByMedicalTreatmentDay != value) { this.selectedRecordListByMedicalTreatmentDay = value; this.OnPropertyChanged("SelectedRecordListByMedicalTreatmentDay"); } }
        }

        /// <summary>
        /// desc         : 수진이력목록 높이
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String MedicalTreatmentHistoryListHeight
        {
            get { return this.medicalTreatmentHistoryListHeight; }
            set { if (this.medicalTreatmentHistoryListHeight != value) { this.medicalTreatmentHistoryListHeight = value; this.OnPropertyChanged("MedicalTreatmentHistoryListHeight"); } }
        }

        /// <summary>
        /// desc         : 수진일별 기록목록 높이
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public String MedicalTreatmentDayHeight
        {
            get { return this.medicalTreatmentDayHeight; }
            set { if (this.medicalTreatmentDayHeight != value) { this.medicalTreatmentDayHeight = value; this.OnPropertyChanged("MedicalTreatmentDayHeight"); } }
        }
        #endregion 수진일별 기록조회

        #region 조건별 상세조회
        /// <summary>
        /// desc         : 선택된기록유형목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> SelectedRecordTypeList
        {
            get { return this.selectedRecordTypeList; }
            set { if (this.selectedRecordTypeList != value) { this.selectedRecordTypeList = value; this.OnPropertyChanged("SelectedRecordTypeList"); } }
        }

        /// <summary>
        /// desc         : 선택된기록상세유형목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> SelectedRecordDetailTypeList
        {
            get { return this.selectedRecordDetailTypeList; }
            set { if (this.selectedRecordDetailTypeList != value) { this.selectedRecordDetailTypeList = value; this.OnPropertyChanged("SelectedRecordDetailTypeList"); } }
        }

        /// <summary>
        /// desc         : 조건별 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> RecordListByCondition
        {
            get { return this.recordListByCondition; }
            set { if (this.recordListByCondition != value) { this.recordListByCondition = value; this.OnPropertyChanged("RecordListByCondition"); } }
        }

        /// <summary>
        /// desc         : 선택된조건별 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> SelectedRecordListByCondition
        {
            get { return this.selectedRecordListByCondition; }
            set { if (this.selectedRecordListByCondition != value) { this.selectedRecordListByCondition = value; this.OnPropertyChanged("SelectedRecordListByCondition"); } }
        }

        /// <summary>
        /// desc         : 진료과구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_Dept_Type
        {
            get { return this.code_Dept_Type; }
            set { if (this.code_Dept_Type != value) { this.code_Dept_Type = value; this.OnPropertyChanged("Code_Dept_Type"); } }
        }

        /// <summary>
        /// desc         : 선택된진료과구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public CCCCCSTE_INOUT SelectedDept_Type
        {
            get { return this.selectedDept_Type; }
            set { if (this.selectedDept_Type != value) { this.selectedDept_Type = value; this.OnPropertyChanged("SelectedDept_Type"); } }
        }

        /// <summary>
        /// desc         : 작성자구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_WRTR_Type
        {
            get { return this.code_WRTR_Type; }
            set { if (this.code_WRTR_Type != value) { this.code_WRTR_Type = value; this.OnPropertyChanged("Code_WRTR_Type"); } }
        }

        /// <summary>
        /// desc         : 선택된작성자구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public CCCCCSTE_INOUT SelectedWRTR_Type
        {
            get { return this.selectedWRTR_Type; }
            set { if (this.selectedWRTR_Type != value) { this.selectedWRTR_Type = value; this.OnPropertyChanged("SelectedWRTR_Type"); } }
        }

        /// <summary>
        /// desc         : 목록조회정렬구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_ListSort_Type
        {
            get { return this.code_ListSort_Type; }
            set { if (this.code_ListSort_Type != value) { this.code_ListSort_Type = value; this.OnPropertyChanged("Code_ListSort_Type"); } }
        }

        /// <summary>
        /// desc         : 선택된목록조회정렬구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public CCCCCSTE_INOUT SelectedListSort_Type
        {
            get { return this.selectedListSort_Type; }
            set { if (this.selectedListSort_Type != value) { this.selectedListSort_Type = value; this.OnPropertyChanged("SelectedListSort_Type"); } }
        }

        /// <summary>
        /// desc         : 내용조회정렬구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> Code_ContentSort_Type
        {
            get { return this.code_ContentSort_Type; }
            set { if (this.code_ContentSort_Type != value) { this.code_ContentSort_Type = value; this.OnPropertyChanged("Code_ContentSort_Type"); } }
        }

        /// <summary>
        /// desc         : 선택된내용조회정렬구분
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public CCCCCSTE_INOUT SelectedContentListSort_Type
        {
            get { return this.selectedContentListSort_Type; }
            set { if (this.selectedContentListSort_Type != value) { this.selectedContentListSort_Type = value; this.OnPropertyChanged("SelectedContentListSort_Type"); } }
        }
        #endregion 조건별 상세조회

        #region 기록이력조회

        /// <summary>
        /// desc         : 선택된 기록이력
        /// author       : chohanna
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public MedicalTreatmentHistoryList_INOUT SelectedMedicalTreatmentHistory_his
        {
            get { return this.selectedMedicalTreatmentHistory_his; }
            set { if (this.selectedMedicalTreatmentHistory_his != value) { this.selectedMedicalTreatmentHistory_his = value; this.OnPropertyChanged("SelectedMedicalTreatmentHistory_his"); } }
        }

        /// <summary>
        /// desc         : 진료일별 기록목록_his
        /// author       : chohanna
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> RecordListByMedicalTreatmentDay_his
        {
            get { return this.recordListByMedicalTreatmentDay_his; }
            set { if (this.recordListByMedicalTreatmentDay_his != value) { this.recordListByMedicalTreatmentDay_his = value; this.OnPropertyChanged("RecordListByMedicalTreatmentDay_his"); } }
        }

        /// <summary>
        /// desc         : 진료일별 기록목록detail _his
        /// author       : chohanna
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> HavingAMedicalExaminationList
        {
            get { return this.havingAMedicalExaminationList; }
            set { this.havingAMedicalExaminationList = value; OnPropertyChanged("HavingAMedicalExaminationList"); }
        }

        /// <summary>
        /// desc         : 진료일별 기록목록detail _his
        /// author       : chohanna
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> HavingAMedicalExaminationDetailBindingList
        {
            get { return this.havingAMedicalExaminationDetailBindingList; }
            set { this.havingAMedicalExaminationDetailBindingList = value; OnPropertyChanged("HavingAMedicalExaminationDetailBindingList"); }
        }

        /// <summary>
        /// desc         : 선택된 진료일별 기록목록
        /// author       : chohanna
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> SelectedHavingAMedicalExaminationDetailBindingList
        {
            get { return this.selectedHavingAMedicalExaminationDetailBindingList; }
            set { if (this.selectedHavingAMedicalExaminationDetailBindingList != value) { this.selectedHavingAMedicalExaminationDetailBindingList = value; this.OnPropertyChanged("SelectedHavingAMedicalExaminationDetailBindingList"); } }
        }

        /// <summary>
        /// desc         : 
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> SelectedRecordListByMedicalTreatmentDay_his
        {
            get { return this.selectedRecordListByMedicalTreatmentDay_his; }
            set { if (this.selectedRecordListByMedicalTreatmentDay_his != value) { this.selectedRecordListByMedicalTreatmentDay_his = value; this.OnPropertyChanged("SelectedRecordListByMedicalTreatmentDay_his"); } }
        }

        #endregion 기록이력조회

        #region 진단서 조회
        /// <summary>
        /// desc         : 진단서 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> RecordListByDiagnosis
        {
            get { return this.recordListByDiagnosis; }
            set { if (this.recordListByDiagnosis != value) { this.recordListByDiagnosis = value; this.OnPropertyChanged("RecordListByDiagnosis"); } }
        }

        /// <summary>
        /// desc         : 진단서 출력목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT> DiagnosisCertificatePrintList
        {
            get { return this.diagnosisCertificatePrintList; }
            set { if (this.diagnosisCertificatePrintList != value) { this.diagnosisCertificatePrintList = value; this.OnPropertyChanged("DiagnosisCertificatePrintList"); } }
        }

        /// <summary>
        /// desc         : 선택된 진단서출력목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public PrintingLogInformation_INOUT SelectedDiagnosisCertificatePrint
        {
            get { return this.selectedDiagnosisCertificatePrint; }
            set { if (this.selectedDiagnosisCertificatePrint != value) { this.selectedDiagnosisCertificatePrint = value; this.OnPropertyChanged("SelectedDiagnosisCertificatePrint"); } }
        }

        /// <summary>
        /// desc         : 외래진료비수납->의무기록 호출 일 때 선택된 첫번째 진단서출력목록
        /// author       : 조한나
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public RecordList_INOUT SELECTED_RECORDLISTBYDIAGNOSIS_DTO
        {
            get { return this.selected_recordlistbydiagnosis_dto; }
            set { if (this.selected_recordlistbydiagnosis_dto != value) { this.selected_recordlistbydiagnosis_dto = value; this.OnPropertyChanged("SELECTED_RECORDLISTBYDIAGNOSIS_DTO"); } }
        }

        #endregion 진단서 조회

        #region 전자동의서 조회
        /// <summary>
        /// desc         : 전자동의서 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> RecordListByConsentNote
        {
            get { return this.recordListByConsentNote; }
            set { if (this.recordListByConsentNote != value) { this.recordListByConsentNote = value; this.OnPropertyChanged("RecordListByConsentNote"); } }
        }

        /// <summary>
        /// desc         : 선택된 전자동의서 기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> SelectedRecordListByConsentNote
        {
            get { return this.selectedRecordListByConsentNote; }
            set { if (this.selectedRecordListByConsentNote != value) { this.selectedRecordListByConsentNote = value; this.OnPropertyChanged("SelectedRecordListByConsentNOTE"); } }
        }
        #endregion 전자동의서 조회

        #region 전자동의서 출력 로그
        /// <summary>
        /// desc         : 출력로그를 저장하기 위한 DTO
        /// author       : 김장권
        /// create date  : 2017-06-09 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> PrntLog_DTO
        {
            get { return this.prntLog_DTO; }
            set { if (this.prntLog_DTO != value) { this.prntLog_DTO = value; this.OnPropertyChanged("PrntLog_DTO"); } }
        }
        #endregion 전자동의서 출력 로그

        #region 특성화기록 조회
        /// <summary>
        /// desc         : 특성화기록 목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> RecordListByCharacteristicRecord
        {
            get { return this.recordListByCharacteristicRecord; }
            set { if (this.recordListByCharacteristicRecord != value) { this.recordListByCharacteristicRecord = value; this.OnPropertyChanged("RecordListByCharacteristicRecord"); } }
        }

        /// <summary>
        /// desc         : 선택된 특성화기록목록
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> SelectedCharacteristicRecord
        {
            get { return this.selectedCharacteristicRecord; }
            set { if (this.selectedCharacteristicRecord != value) { this.selectedCharacteristicRecord = value; this.OnPropertyChanged("SelectedCharacteristicRecord"); } }
        }
        #endregion 특성화기록 조회

        public bool IsOpenPopup
        {
            get { return isOpenPopup; }
            set
            {
                if (isOpenPopup != value)
                { isOpenPopup = value; OnPropertyChanged("IsOpenPopup", value); }
            }
        }

        public int IPrintCount
        {
            get { return this.iPrintCount; }
            set { if (this.iPrintCount != value) { this.iPrintCount = value; this.OnPropertyChanged("IPrintCount"); } }
        }

        #region 제증명 관련        

        public bool PrintSentenceAuthority
        {
            get { return printSentenceAuthority; }
            set { if (printSentenceAuthority != value) { printSentenceAuthority = value; OnPropertyChanged("PrintSentenceAuthority", value); } }
        }

        public bool PrintGeneExaminationAuthority
        {
            get { return printGeneExaminationAuthority; }
            set { if (printGeneExaminationAuthority != value) { printGeneExaminationAuthority = value; OnPropertyChanged("PrintGeneExaminationAuthority", value); } }
        }
        #endregion 제증명 관련

        #region 의무기록실 관련
        public bool InCompleteAuthority
        {
            get { return inCompleteAuthority; }
            set { if (inCompleteAuthority != value) { inCompleteAuthority = value; OnPropertyChanged("InCompleteAuthority", value); } }
        }

        public Visibility InCompleteVisibility
        {
            get { return inCompleteVisibility; }
            set { if (inCompleteVisibility != value) { inCompleteVisibility = value; OnPropertyChanged("InCompleteVisibility", value); } }
        }

        public String SelectedPACT_ID
        {
            get { return selectedPACT_ID; }
            set { if (selectedPACT_ID != value) { selectedPACT_ID = value; OnPropertyChanged("SelectedPACT_ID", value); } }
        }

        public String SelectedRECORD_DETAIL_TYPE
        {
            get { return selectedRECORD_DETAIL_TYPE; }
            set { if (selectedRECORD_DETAIL_TYPE != value) { selectedRECORD_DETAIL_TYPE = value; OnPropertyChanged("SelectedRECORD_DETAIL_TYPE", value); } }
        }

        #endregion 의무기록실 관련        

        /// <summary>
        /// desc         : 인쇄미리보기버튼 조회
        /// author       : 강성희
        /// create date  : 2016-05-02 오후 7:38:56
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        public Visibility NewDrgDeterminationVisibility
        {
            get { return newDrgDeterminationVisibility; }
            set { if (newDrgDeterminationVisibility != value) { newDrgDeterminationVisibility = value; OnPropertyChanged("NewDrgDeterminationVisibility", value); } }
        }
        #endregion //Model Properties

        #region [Commands]
        private ICommand loadCommand;
        /// <summary>
        /// name         : Load Command
        /// desc         : Load시 호출되는 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand LoadCommand
        {
            get
            {
                if (loadCommand == null)
                    loadCommand = new RelayCommand(p => this.Load(p));

                return loadCommand;
            }
        }

        private ICommand searchMedicalTreatmentHistoryListCommand;
        /// <summary>
        /// name         : 수진이력조회 Command
        /// desc         : 수진이력조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchMedicalTreatmentHistoryListCommand
        {
            get
            {
                if (searchMedicalTreatmentHistoryListCommand == null)
                    searchMedicalTreatmentHistoryListCommand = new RelayCommand(p => this.SearchMedicalTreatmentHistoryList());

                return searchMedicalTreatmentHistoryListCommand;
            }
        }

        private ICommand selectPeriodCommand;
        /// <summary>
        /// name         : 기간선택 Command
        /// desc         : 기간선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectPeriodCommand
        {
            get
            {
                if (selectPeriodCommand == null)
                    selectPeriodCommand = new RelayCommand(p => this.SelectPeriod());

                return selectPeriodCommand;
            }
        }

        private ICommand selectPactTypeCommand;
        /// <summary>
        /// name         : 원무접수구분 선택 Command
        /// desc         : 원무접수구분 선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectPactTypeCommand
        {
            get
            {
                if (selectPactTypeCommand == null)
                    selectPactTypeCommand = new RelayCommand(p => this.SelectPactType());

                return selectPactTypeCommand;
            }
        }

        private ICommand selectDepartmentCommand;
        /// <summary>
        /// name         : 진료과 선택 Command
        /// desc         : 진료과 선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectDepartmentCommand
        {
            get
            {
                if (selectDepartmentCommand == null)
                    selectDepartmentCommand = new RelayCommand(p => this.SelectDepartment());

                return selectDepartmentCommand;
            }
        }

        private ICommand searchRecordListByMedicalTreatmentDayCommand;
        /// <summary>
        /// name         : 수진일별 기록조회 Command
        /// desc         : 수진일별 기록조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchRecordListByMedicalTreatmentDayCommand
        {
            get
            {
                if (searchRecordListByMedicalTreatmentDayCommand == null)
                    searchRecordListByMedicalTreatmentDayCommand = new RelayCommand(p => this.SearchRecordListByMedicalTreatmentDay(p));

                return searchRecordListByMedicalTreatmentDayCommand;
            }
        }

        private ICommand searchRecordListByConditionCommand;
        /// <summary>
        /// name         : 조건별 상세조회 Command
        /// desc         : 조건별 상세조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchRecordListByConditionCommand
        {
            get
            {
                if (searchRecordListByConditionCommand == null)
                    searchRecordListByConditionCommand = new RelayCommand(p => this.SearchRecordListByCondition());

                return searchRecordListByConditionCommand;
            }
        }


        private ICommand searchRecordListByDiagnosisCommand;
        /// <summary>
        /// name         : 진단서 조회 Command
        /// desc         : 진단서 조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-26
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchRecordListByDiagnosisCommand
        {
            get
            {
                if (searchRecordListByDiagnosisCommand == null)
                    searchRecordListByDiagnosisCommand = new RelayCommand(p => this.SearchRecordListByDiagnosis());

                return searchRecordListByDiagnosisCommand;
            }
        }

        private ICommand searchDiagnosisCertificatePrintListCommand;
        /// <summary>
        /// name         : 진단서 출력여부 조회 Command
        /// desc         : 진단서 출력여부 조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-26
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchDiagnosisCertificatePrintListCommand
        {
            get
            {
                if (searchDiagnosisCertificatePrintListCommand == null)
                    searchDiagnosisCertificatePrintListCommand = new RelayCommand(p => this.SearchDiagnosisCertificatePrintList());

                return searchDiagnosisCertificatePrintListCommand;
            }
        }

        private ICommand getPrintListToExcelCommand;
        /// <summary>
        /// name         : 진단서 출력목록 엑셀로 내보내기 Command
        /// desc         : 진단서 출력여부 엑셀로 내보내기 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand GetPrintListToExcelCommand
        {
            get
            {
                if (getPrintListToExcelCommand == null)
                    getPrintListToExcelCommand = new RelayCommand(p => this.GetPrintListToExcel());

                return getPrintListToExcelCommand;
            }

        }

        private ICommand searchMultiRecordContentCommand;
        /// <summary>
        /// name         : 다중기록내용조회 Command
        /// desc         : 다중기록내용조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>SelectedRecordListByMedicalTreatmentDay
        public ICommand SearchMultiRecordContentCommand
        {
            get
            {
                if (searchMultiRecordContentCommand == null)
                    searchMultiRecordContentCommand = new RelayCommand(p => this.SearchMultiRecordContent(p));

                return searchMultiRecordContentCommand;
            }
        }

        private ICommand selectRecordTypeCommand;
        /// <summary>
        /// name         : 기록유형선택 Command
        /// desc         : 기록유형선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectRecordTypeCommand
        {
            get
            {
                if (selectRecordTypeCommand == null)
                    selectRecordTypeCommand = new RelayCommand(p => this.SelectRecordType(p));

                return selectRecordTypeCommand;
            }
        }

        private ICommand selectRecordDetailTypeCommand;
        /// <summary>
        /// name         : 기록상세유형선택 Command
        /// desc         : 기록상세유형선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectRecordDetailTypeCommand
        {
            get
            {
                if (selectRecordDetailTypeCommand == null)
                    selectRecordDetailTypeCommand = new RelayCommand(p => this.SelectRecordDetailType(p));

                return selectRecordDetailTypeCommand;
            }
        }

        private ICommand removeSelectedRecordTypeCommand;
        /// <summary>
        /// name         : 기록유형선택제외 Command
        /// desc         : 기록유형선택제외 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand RemoveSelectedRecordTypeCommand
        {
            get
            {
                if (removeSelectedRecordTypeCommand == null)
                    removeSelectedRecordTypeCommand = new RelayCommand(p => this.RemoveSelectedRecordType(p));

                return removeSelectedRecordTypeCommand;
            }
        }

        private ICommand selectNursingRecordTypeCommand;
        /// <summary>
        /// name         : 간호기록유형선택 Command
        /// desc         : 간호기록유형선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectNursingRecordTypeCommand
        {
            get
            {
                if (selectNursingRecordTypeCommand == null)
                    selectNursingRecordTypeCommand = new RelayCommand(p => this.SelectNursingRecordType(p));

                return selectNursingRecordTypeCommand;
            }
        }

        private ICommand selectPatientCommand;
        /// <summary>
        /// name         : 환자선택 Command
        /// desc         : 환자선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectPatientCommand
        {
            get
            {
                if (selectPatientCommand == null)
                    selectPatientCommand = new RelayCommand(p => this.SelectPatient());

                return selectPatientCommand;
            }
        }

        private ICommand originalRecordOpenPopupCommand;
        /// <summary>
        /// name         : 원본기록조회 Command
        /// desc         : 원본기록조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand OriginalRecordOpenPopupCommand
        {
            get
            {
                if (originalRecordOpenPopupCommand == null)
                    originalRecordOpenPopupCommand = new RelayCommand(p => this.OriginalRecordOpenPopup());

                return originalRecordOpenPopupCommand;
            }
        }

        private ICommand diagnosisOriginalRecordOpenPopupCommand;
        /// <summary>
        /// name         : 진단서 원본기록조회 Command
        /// desc         : 진단서 원본기록조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand DiagnosisOriginalRecordOpenPopupCommand
        {
            get
            {
                if (diagnosisOriginalRecordOpenPopupCommand == null)
                    diagnosisOriginalRecordOpenPopupCommand = new RelayCommand(p => this.DiagnosisOriginalRecordOpenPopup(p));

                return diagnosisOriginalRecordOpenPopupCommand;
            }
        }

        private ICommand previewPrintingCommand;
        /// <summary>
        /// name         : 출력 조회 Command
        /// desc         : 출력 조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand PreviewPrintingCommand
        {
            get
            {
                if (previewPrintingCommand == null)
                    previewPrintingCommand = new RelayCommand(p => this.PreviewPrintingOpenPopup());

                return previewPrintingCommand;
            }
        }

        private ICommand newDrgDeterminationCommand;
        /// <summary>
        /// name         : 신포괄확정 Command
        /// desc         : 신포괄확정 Command
        /// author       : 박찬규 
        /// create Date  : 2024-07-15
        /// update date  : 2024-07-15, 박찬규, 신포괄 관련 작업 (PSS_MC_0609)
        /// </summary>
        /// <remarks></remarks>
        public ICommand NewDrgDeterminationCommand
        {
            get
            {
                if (newDrgDeterminationCommand == null)
                    newDrgDeterminationCommand = new RelayCommand(p => this.NewDrgDeterminationOpenPopup());

                return newDrgDeterminationCommand;
            }
        }

        private ICommand searchDiagnosisCertificateFormCommand;
        /// <summary>
        /// name         : 진단서 조회 Command
        /// desc         : 진단서 조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-30
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchDiagnosisCertificateFormCommand
        {
            get
            {
                if (searchDiagnosisCertificateFormCommand == null)
                    searchDiagnosisCertificateFormCommand = new RelayCommand(p => this.SearchDiagnosisCertificateForm(p));

                return searchDiagnosisCertificateFormCommand;
            }
        }

        private ICommand tabSelectionChangeCommand;
        /// <summary>
        /// name         : 기록조회 탭 변경 Command
        /// desc         : 기록조회 탭 변경 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand TabSelectionChangeCommand
        {
            get
            {
                if (tabSelectionChangeCommand == null)
                    tabSelectionChangeCommand = new RelayCommand(p => this.TabSelectionChange());

                return tabSelectionChangeCommand;
            }
        }
        private ICommand setDepartmentCommand;
        /// <summary>
        /// name         : 진료과선택 Command
        /// desc         : 진료과선택 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SetDepartmentCommand
        {
            get
            {
                if (setDepartmentCommand == null)
                    setDepartmentCommand = new RelayCommand(p => this.SetDepartment(p));

                return setDepartmentCommand;
            }
        }

        private ICommand setMedicalTreatmentHistoryListMaxHeightCommand;
        /// <summary>
        /// name         : 수진일목록MAX조회  Command
        /// desc         : 수진일목록MAX조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SetMedicalTreatmentHistoryListMaxHeightCommand
        {
            get
            {
                if (setMedicalTreatmentHistoryListMaxHeightCommand == null)
                    setMedicalTreatmentHistoryListMaxHeightCommand = new RelayCommand(p => this.SetMedicalTreatmentHistoryListMaxHeight());

                return setMedicalTreatmentHistoryListMaxHeightCommand;
            }
        }

        private ICommand setMedicalTreatmentDayMaxHeightCommand;
        /// <summary>
        /// name         : 수진일별기록목록MAX조회  Command
        /// desc         : 수진일별기록목록MAX조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SetMedicalTreatmentDayMaxHeightCommand
        {
            get
            {
                if (setMedicalTreatmentDayMaxHeightCommand == null)
                    setMedicalTreatmentDayMaxHeightCommand = new RelayCommand(p => this.SetMedicalTreatmentDayMaxHeight());

                return setMedicalTreatmentDayMaxHeightCommand;
            }
        }

        private ICommand searchRecordListByConsentNoteCommand;
        /// <summary>
        /// name         : 기타기록목록조회  Command
        /// desc         : 기타기록목록조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchRecordListByConsentNoteCommand
        {
            get
            {
                if (searchRecordListByConsentNoteCommand == null)
                    searchRecordListByConsentNoteCommand = new RelayCommand(p => this.SearchRecordListByConsentNote());

                return searchRecordListByConsentNoteCommand;
            }
        }

        private ICommand selectConsentNoteRecordCommand;
        /// <summary>
        /// name         : 전자동의서 기록 조회 Command
        /// desc         : 전자동의서 기록 조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectConsentNoteRecordCommand
        {
            get
            {
                if (selectConsentNoteRecordCommand == null)
                    selectConsentNoteRecordCommand = new RelayCommand(p => this.SearchElectronicConsentForm());

                return selectConsentNoteRecordCommand;
            }
        }

        private ICommand characteristicRecordAskCommand;
        /// <summary>
        /// name         : 특성화기록 조회 Command
        /// desc         : 특성화기록 조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-07-20
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand CharacteristicRecordAskCommand
        {
            get
            {
                if (characteristicRecordAskCommand == null)
                    characteristicRecordAskCommand = new RelayCommand(p => this.SearchCharacteristicRecordList());

                return characteristicRecordAskCommand;
            }
        }

        private ICommand searchCharacteristicRecordCommand;
        /// <summary>
        /// name         : 특성화기록 조회 Command
        /// desc         : 특성화기록조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-26
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchCharacteristicRecordCommand
        {
            get
            {
                if (searchCharacteristicRecordCommand == null)
                    searchCharacteristicRecordCommand = new RelayCommand(p => this.SearchCharacteristicRecord(p));

                return searchCharacteristicRecordCommand;
            }
        }

        private ICommand searchHistoryRecordContentCommand;
        /// <summary>
        /// name         : 기록이력조회 Command
        /// desc         : 다중기록내용조회 Command
        /// author       : chohanna 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchHistoryRecordContentCommand
        {
            get
            {
                if (searchHistoryRecordContentCommand == null)
                    searchHistoryRecordContentCommand = new RelayCommand(p => this.SearchHistoryRecordContent(p));

                return searchHistoryRecordContentCommand;
            }
        }

        private ICommand searchMultiRecordContentHistoryCommand;
        /// <summary>
        /// name         : 다중기록내용조회 Command
        /// desc         : 다중기록내용조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand SearchMultiRecordContentHistoryCommand
        {
            get
            {
                if (searchMultiRecordContentHistoryCommand == null)
                    searchMultiRecordContentHistoryCommand = new RelayCommand(p => this.SearchMultiRecordContentHistory(p));

                return searchMultiRecordContentHistoryCommand;
            }
        }

        #region 의무기록실 미작성/미비/전자서명누락 관련
        private ICommand selectDCRecordCurrentCommand;
        /// <summary>
        /// name         : DC현황조회 Command
        /// desc         : DC현황조회 Command
        /// author       : 김정훈 
        /// create Date  : 2013-03-02
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectDCRecordCurrentCommand
        {
            get
            {
                if (selectDCRecordCurrentCommand == null)
                    selectDCRecordCurrentCommand = new RelayCommand(p => this.SelectDCRecordCurrent());

                return selectDCRecordCurrentCommand;
            }
        }

        private ICommand saveNonWritingRecordCommand;
        /// <summary>
        /// name         : 미작성등록 Command
        /// desc         : 미작성등록 Command
        /// author       : 김정훈 
        /// create Date  : 2013-03-02
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SaveNonWritingRecordCommand
        {
            get
            {
                if (saveNonWritingRecordCommand == null)
                    saveNonWritingRecordCommand = new RelayCommand(p => this.SaveNonWritingRecord());

                return saveNonWritingRecordCommand;
            }
        }

        private ICommand saveIncompleteRecordCommand;
        /// <summary>
        /// name         : 미비등록 Command
        /// desc         : 미비등록 Command
        /// author       : 김정훈 
        /// create Date  : 2013-03-02
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SaveIncompleteRecordCommand
        {
            get
            {
                if (saveIncompleteRecordCommand == null)
                    saveIncompleteRecordCommand = new RelayCommand(p => this.SaveIncompleteRecord());

                return saveIncompleteRecordCommand;
            }
        }

        private ICommand saveElectronicSignatureCommand;
        /// <summary>
        /// name         : 전자서명누락등록 Command
        /// desc         : 전자서명누락등록 Command
        /// author       : 김정훈 
        /// create Date  : 2013-03-02
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SaveElectronicSignatureCommand
        {
            get
            {
                if (saveElectronicSignatureCommand == null)
                    saveElectronicSignatureCommand = new RelayCommand(p => this.SaveElectronicSignature());

                return saveElectronicSignatureCommand;
            }
        }
        #endregion 의무기록실 미작성/미비/전자서명누락 관련

        #region 정렬 관련
        private ICommand selectListSortTypeCommand;
        /// <summary>
        /// name         : 목록조회 정렬변경 Command
        /// desc         : 목록조회 정렬변경 Command
        /// author       : 김정훈 
        /// create Date  : 2013-03-12
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectListSortTypeCommand
        {
            get
            {
                if (selectListSortTypeCommand == null)
                    selectListSortTypeCommand = new RelayCommand(p => this.SelectListSortType(p));

                return selectListSortTypeCommand;
            }
        }

        private ICommand selectListByCondtitionSortTypeCommand;
        /// <summary>
        /// name         : 조건별상세조회 목록조회 정렬변경 Command
        /// desc         : 조건별상세조회 목록조회 정렬변경 Command
        /// author       : 김정훈 
        /// create Date  : 2013-03-12
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand SelectListByCondtitionSortTypeCommand
        {
            get
            {
                if (selectListByCondtitionSortTypeCommand == null)
                    selectListByCondtitionSortTypeCommand = new RelayCommand(p => this.SelectListByCondtitionSortType(p));

                return selectListByCondtitionSortTypeCommand;
            }
        }



        private ICommand changeSortRecordListByConditionToggleCommand;
        /// <summary>
        /// name         : 조건별상세조회 정렬토글버튼 변경 Command
        /// desc         : 조건별상세조회 정렬토글버튼 변경 Command
        /// author       : 김정훈 
        /// create Date  : 2013-03-12
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public ICommand ChangeSortRecordListByConditionToggleCommand
        {
            get
            {
                if (changeSortRecordListByConditionToggleCommand == null)
                    changeSortRecordListByConditionToggleCommand = new RelayCommand(p => this.ChangeSortRecordListByConditionToggle());

                return changeSortRecordListByConditionToggleCommand;
            }
        }

        #endregion 정렬 관련

        private ICommand printingAskCheckedCommand;
        /// <summary>
        /// name         : 다중기록내용조회 Command
        /// desc         : 다중기록내용조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand PrintingAskCheckedCommand
        {
            get
            {
                if (printingAskCheckedCommand == null)
                    printingAskCheckedCommand = new RelayCommand(p => this.WhenPrintingAskChecked());

                return printingAskCheckedCommand;
            }
        }

        private ICommand imagePrintingAskCheckedCommand;
        /// <summary>
        /// name         : 다중기록내용조회 Command
        /// desc         : 다중기록내용조회 Command
        /// author       : 강성희 
        /// create Date  : 2016-06-25
        /// update date  : 2016-06-25, 작업자, 작업내용
        /// </summary>
        /// <remarks></remarks>
        public ICommand ImagePrintingAskCheckedCommand
        {
            get
            {
                if (imagePrintingAskCheckedCommand == null)
                    imagePrintingAskCheckedCommand = new RelayCommand(p => this.WhenImagePrintingAskChecked());

                return imagePrintingAskCheckedCommand;
            }
        }

        private ICommand operationImagePrintingAskCheckedCommand;
        /// <summary>
        /// name         : 수술기록 이미지 출력 Command
        /// desc         : 수술기록 이미지 출력 Command
        /// author       : 박찬규 
        /// create Date  : 2024-04-19
        /// update date  : 
        /// </summary>
        /// <remarks></remarks>
        public ICommand OperationImagePrintingAskCheckedCommand
        {
            get
            {
                if (operationImagePrintingAskCheckedCommand == null)
                    operationImagePrintingAskCheckedCommand = new RelayCommand(p => this.WhenOperationImagePrintingAskChecked());

                return operationImagePrintingAskCheckedCommand;
            }
        }
        #endregion //Commands

        #region [Methods]
        /// <summary>
        /// name         : ViewModel 초기화 함수
        /// desc         : ViewModel 을 초기화 함수 입니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-16
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void Init()
        {
            selected_recordlistbydiagnosis_dto = new RecordList_INOUT();

            if (LicenseManager.UsageMode == LicenseUsageMode.Designtime)
                return;

        }

        /// <summary>
        /// name         : Load 함수
        /// desc         : Load 시점에 해야할 내용을 처리
        /// author       : 김정훈 
        /// create date  : 2012-11-06
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public void Load(object p)
        {
            if (isFirstLoad)
            {
                thisUserControl = p as SelectIntegrationMedicalRecordAsk;

                Load();
                isFirstLoad = false;
            }
            else
            {
                Load();
            }
        }

        protected override void InitializeLoaded()
        {
            CALLER = base.QueryString["CALLER"];
            STF_NO = base.QueryString["STF_NO"];
            PT_NO = base.QueryString["PT_NO"];

            base.InitializeLoaded();
        }

        /// <summary>
        /// name         : Load 함수
        /// desc         : Load 시점에 해야할 내용을 처리
        /// author       : 김정훈 
        /// create date  : 2012-11-06
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public void Load()
        {
            if (isFirstLoad)
            {
                // 환자,사용자 정보 초기화
                InitInformation();

                // 코드 리스트 초기화
                string[] groupCodes = new string[] { "MD00418", "MD00419", "MD00420" }; //MD00418 : 의무기록뷰어검색기간, MD00419 : 의무기록뷰어기록유형, MD00420 : 의무기록뷰어기록상세유형

                allCodes = CommonServiceAgent.SelectCodeByGroups(groupCodes);

                GetPeriodList();
                GetPactTypeList();
                GetMedDeptList();
                GetDeptTypeList();
                GetWRTRTypeList();
                GetSortTypeList();
                InitPrivilige(); // 권한 설정

                //조회조건 세팅                
                SearchCondition.SEARCH_TO_DATE = CommonServiceAgent.SelectSysDate();
                SelectPeriod();

                RecordTypeFilter.RECORDTYPE_ALL = true;

                SetViewMode();

                InitConfigration(); // 환경설정 

                if (SessionManager.SystemInfo != null && SessionManager.SystemInfo.MAIN_GUBUN != null && (SessionManager.SystemInfo.MAIN_GUBUN.Equals("DR")
                                                                        || SessionManager.SystemInfo.MAIN_GUBUN.Equals("NR")
                                                                        || SessionManager.SystemInfo.MAIN_GUBUN.Equals("IF")
                                                                        || SessionManager.SystemInfo.MAIN_GUBUN.Equals("CA")
                                                                        || SessionManager.SystemInfo.MAIN_GUBUN.Equals("CC")))
                {
                    CommonDTO_INOUT access = new CommonDTO_INOUT() { PT_NO = thisUserControl.txtPT_NO.Text, SID = UserInformation.HIS_SID };
                    if (SessionManager.PatientInfo != null)
                    {
                        if (SessionManager.PatientInfo.PT_NO != access.PT_NO)
                        {
                            SelectPatientOtherMain();
                        }
                    }
                    else SelectPatientOtherMain();
                }

                if (SessionManager.SystemInfo != null && SessionManager.SystemInfo.MAIN_GUBUN != null)
                {

                    if (!SessionManager.SystemInfo.MAIN_GUBUN.Equals("DR")
                            && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("NR")
                            && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("IF")
                            && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("CA")
                            && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("CC"))
                    {
                        SelectPatientOtherMain();
                    }
                }
                if (SessionManager.SystemInfo.MAIN_GUBUN == null)
                {
                    SelectPatientOtherMain();
                }
            }
            else
            {
                // 환자,사용자 정보 초기화
                InitInformation();

                // DTO초기화
                InitializeDTO();

                ResetPrivilige();
            }

        }

        /// <summary>
        /// name         : 진료과 조회 함수
        /// desc         : 페이지 초기화 시 진료과 데이타를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-16
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetMedDeptList()
        {
            var inObj = new Department_INOUT() { };
            this.DepartmentGroup = (HSFDTOCollectionBaseObject<Department_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectMedDeptList", inObj);
            this.DepartmentGroup.Insert(0, new Department_INOUT() { DEPT_CD = "ALL", DEPT_NM = "전체" });

            SelectedDepartment = DepartmentGroup[0];
            SearchCondition.DEPT_CD = SelectedDepartment.DEPT_CD;
        }

        /// <summary>
        /// name         : 환자정보 초기화 함수
        /// desc         : 세션정보를 이용하여 페이지 초기화 시 환자 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-19
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void InitPatientInformation()
        {

            if (SessionManager.PatientInfo == null)
            {
                MsgBox.Display("환자를 선택해 주세요.", MessageType.MSG_TYPE_ERROR);
                return;
            }

            //20.09.22 사생활보호 체크 로직 수정
            #region 정보보호/사생활보호 체크
            PatientInformation_INOUT access_in = new PatientInformation_INOUT();
            access_in.PT_NO = SessionManager.PatientInfo.PT_NO;

            if (CheckPrivate(access_in) == false)
            {
                //20.09.22 초기화
                PatientInformation = new PatientInformation_INOUT();
                SearchCondition.PT_NO = "";

                return;
            }
            #endregion 정보보호/사생활보호 체크


            String strSEX = "";
            switch (SessionManager.PatientInfo.SEX_TP_CD)
            {
                case "M":
                    strSEX = "남";
                    break;
                case "F":
                    strSEX = "여";
                    break;
            }

            // 환자정보 세팅
            PatientInformation = new PatientInformation_INOUT()
            {
                PT_NO = SessionManager.PatientInfo.PT_NO //환자번호
                ,
                PT_NM = SessionManager.PatientInfo.PT_NM //환자명
                ,
                SEX = strSEX
                ,
                AGE = SessionManager.PatientInfo.AGE2 //나이
            };

            //#region 정보보호/사생활보호 체크
            //PatientInformation_INOUT access_in = new PatientInformation_INOUT();
            //access_in.PT_NO = PatientInformation.PT_NO;
            //CheckPrivate(access_in);
            //#endregion 정보보호/사생활보호 체크
        }

        /// <summary>
        /// name         : 환자정보 조회 함수
        /// desc         : 
        /// author       : 김정훈 
        /// create date  : 2012-07-19
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetPatientInformation(String IN_PT_NO, String IN_SID)
        {
            PatientInformation_INOUT Patientin = new PatientInformation_INOUT() { PT_NO = IN_PT_NO };
            PatientInformation = (PatientInformation_INOUT)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectPatientAsk", Patientin);

            //2022.03.23 복호화 로직 추가
            if (PatientInformation != null && PatientInformation.RRN.Contains("=="))
            {
                using (SKCrypASPLib skcryp = new SKCrypASPLib())
                {
                    PatientInformation.RRN = skcryp.DecryptData(PatientInformation.RRN);
                }
            }

        }

        /// <summary>
        /// name         : 사용자정보 초기화 함수
        /// desc         : 세션정보를 이용하여 페이지 초기화 시 사용자정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-12-19
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void InitUserInformation()
        {
            if (SessionManager.UserInfo == null)
            {
                User_IN user = new User_IN();
                user.STF_NO = STF_NO;

                GlobalUserInfo_OUT userInfo = new GlobalUserInfo_OUT();
                userInfo = CommonServiceAgent.SelectGlobalUserInfo(user);

                SessionManager.UserInfo = userInfo;
            }

            // 사용자정보 세팅
            UserInformation = new UserInformation_INOUT()
            {
                STF_NO = SessionManager.UserInfo.STF_NO //직원번호
                ,
                STF_NM = SessionManager.UserInfo.STF_NM //한글성명
                ,
                AOA_WKDP_CD = SessionManager.UserInfo.AOA_WKDP_CD //발령근무부서코드
                ,
                USE_GRP_CD = SessionManager.UserInfo.USE_GRP_CD //사용그룹코드
                ,
                USE_GRP_DTL_CD = SessionManager.UserInfo.USE_GRP_DTL_CD //사용그룹상세코드
                ,
                HIS_SID = SessionManager.UserInfo.SID//직원식별번호
                ,
                PLWK_DEPT_CD = SessionManager.UserInfo.PLWK_DEPT_CD
            };
        }

        /// <summary>
        /// name         : 정보 초기화 함수
        /// desc         : 페이지 초기화 시 기간코드 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-19
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void InitInformation()
        {
            if (CALLER == "PACS") // PACS에서 XBAP으로 호출할때
            {
                GetPatientInformation(PT_NO, SessionManager.UserInfo.SID);
                InitUserInformation();
            }
            else if (CALLER == "SUPREC" || CALLER == "INSIDE") // 진료지원에서 호출할때
            {
                GetPatientInformation(PT_NO, SessionManager.UserInfo.SID);
                InitUserInformation();
            }
            else if (CALLER == "WO") //외래원무수납창구에서 호출시
            {
                GetPatientInformation(PT_NO, SessionManager.UserInfo.SID);
                InitUserInformation();
            }
            else if (CALLER == "REFER") // 전원의뢰화면에서 호출시
            {
                GetPatientInformation(PT_NO, SessionManager.UserInfo.SID);
                InitUserInformation();
                PatientSelectAuthority = false; //환자검색X
                NPRecAskYN = true; //정신과기록 조회O
            }
            else if (CALLER == "CDW") // CDW에서 XBAP으로 호출할때
            {
                GetPatientInformation(PT_NO, SessionManager.UserInfo.SID);
                InitUserInformation();
            }
            else if (CALLER == "CTFS") //간접진료 화면 - 의무기록뷰어 변경시
            {

                //타 메인일 경우, 환자선택 사유창 나오도록 수정 2021.05.12
                if (CHGYN == "Y")
                {
                    InitUserInformation();
                    SelectPatientOtherMain();
                }

            }
            else // 세션정보로 세팅
            {
                InitPatientInformation();
                InitUserInformation();
            }

            SearchCondition.PT_NO = PatientInformation.PT_NO;
            PatientSelectAuthority = true;
        }

        /// <summary>
        ///  정보보호/사생활보호 권한체크
        /// </summary>
        /// <param name="access"></param>
        /// <returns></returns>
        private Boolean CheckPrivate(PatientInformation_INOUT access)
        {
            Boolean isreturn = true;
            PatientInformation_INOUT access_out;
            access_out = UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectInformationProtectionPatient", access) as PatientInformation_INOUT;

            //정보보호 대상 환자인 경우 메시지 출력
            if (!String.IsNullOrEmpty(access_out.PT_NO))
            {
                MessageBoxResult msgResult;
                msgResult = MsgBox.Display("DRMCN_008352", MessageType.MSG_TYPE_INFORMATION, "", true, MessageBoxButton.OKCancel);

                if (msgResult != MessageBoxResult.OK)
                {
                    isreturn = false;
                }

                //MsgBox.Display("위 환자는 자신의 개인 인적사항을 포함한 의료정보의 비밀 보호를 요청한 상태입니다.\n\n" +
                //                   "그러므로 본인 진료목적인 경우를 제외하고, 의료법 및 관계법령에서 정하지 않은 한\n\n" +
                //                   "환자 본인을 제외한 어느 누구에게도 환자의 인적 사항 및 의료정보 내용에 대한\n\n" +
                //                   "열람, 사본발행이 이루어져서는 안됩니다.", MessageType.MSG_TYPE_EXCLAMATION);

                //MsgBox.Display("DRMCN_008352", MessageType.MSG_TYPE_EXCLAMATION);
            }

            return isreturn;
        }

        /// <summary>
        ///  환자선택 사유입력창 
        /// </summary>
        /// <param name="access"></param>
        /// <returns></returns>
        private bool CheckPatientinformationRequestHistory(CommonDTO_INOUT access)
        {
            // 환자 선택사유 입력여부
            string sYesNo = "N";


            //PopUpBase pop_pt = new  PopUpBase("HIS.MC.DM.PS.MN.UI","SavePatientInformationPrivacyRequest.xaml");

            //var view = pop_pt.GetContent() as dynamic;
            //var ViewModel = view.DataContext;

            //ViewModel.PT_NO = access.PT_NO;
            //ViewModel.AprochHisPrg = "RECVIEWER";

            PopUpBase pop_pt = base.OnLoadPopupMenu("DR_HIS.MC.DM.PS.MN.UI_/SavePatientInformationPrivacyRequest.xaml", new object[] { access.PT_NO, null, null, null, null, "RECVIEWER" });
            pop_pt.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
            pop_pt.WindowStartupLocation = WindowStartupLocation.CenterScreen;
            pop_pt.ShowDialog();
            //sYesNo = (((UserControlBase)(((MainMenuInfo)pop_pt.Content).INSTANCE_OF_MENU)) as dynamic).DataContext.RtnValue;
            sYesNo = ((UserControlBase)pop_pt.GetContent() as dynamic).DataContext.RtnValue;

            if (sYesNo.Substring(0, 1) == "Y")
                return true;
            else
                return false;

            //return false;
        }


        /// <summary>
        ///  환자선택 사유입력창 
        /// </summary>
        /// <param name="access"></param>
        /// <returns></returns>
        private bool CheckPatientinformationRequestHistoryOtherMain(CommonDTO_INOUT access)
        {
            // 환자 선택사유 입력여부
            string sYesNo = "N";

            ////////////////////////////////////////////////////////
            //5개메인이면서
            if (SessionManager.SystemInfo != null && SessionManager.SystemInfo.MAIN_GUBUN != null && (SessionManager.SystemInfo.MAIN_GUBUN.Equals("DR")
                            || SessionManager.SystemInfo.MAIN_GUBUN.Equals("NR")
                            || SessionManager.SystemInfo.MAIN_GUBUN.Equals("IF")
                            || SessionManager.SystemInfo.MAIN_GUBUN.Equals("CA")
                            || SessionManager.SystemInfo.MAIN_GUBUN.Equals("CC")))
            {
                if (SessionManager.PatientInfo != null) //세션이 있고
                {
                    if (SessionManager.PatientInfo.PT_NO != access.PT_NO) //세션과 의무기록뷰어에 넘어온 환자번호 불일치 -> 사유팝업+의료법 공지(비번X) 
                    {
                        PopUpBase pop_pt = base.OnLoadPopupMenu("DR_HIS.MC.DM.PS.MN.UI_/SavePatientInformationPrivacyRequest.xaml", new object[] { access.PT_NO, null, null, null, "YY", "RECVIEWER" });
                        pop_pt.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                        pop_pt.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                        pop_pt.ShowDialog();
                        //sYesNo = (((UserControlBase)(((MainMenuInfo)pop_pt.Content).INSTANCE_OF_MENU)) as dynamic).DataContext.RtnValue;
                        sYesNo = ((UserControlBase)pop_pt.GetContent() as dynamic).DataContext.RtnValue;
                    }
                }
                else if (SessionManager.PatientInfo == null) //세션이 없으면
                {
                    PopUpBase pop_pt = base.OnLoadPopupMenu("DR_HIS.MC.DM.PS.MN.UI_/SavePatientInformationPrivacyRequest.xaml", new object[] { access.PT_NO, null, null, null, "YY", "RECVIEWER" });
                    pop_pt.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                    pop_pt.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                    pop_pt.ShowDialog();
                    //sYesNo = (((UserControlBase)(((MainMenuInfo)pop_pt.Content).INSTANCE_OF_MENU)) as dynamic).DataContext.RtnValue;
                    sYesNo = ((UserControlBase)pop_pt.GetContent() as dynamic).DataContext.RtnValue;
                }
            }
            //PACS에서 띄울때
            else if (CALLER == "PACS")
            {
                PopUpBase pop_pt = base.OnLoadPopupMenu("DR_HIS.MC.DM.PS.MN.UI_/SavePatientInformationPrivacyRequestSingle.xaml", new object[] { access.PT_NO, null, null, null, null, "F01", "RECVIEWER" });
                pop_pt.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                pop_pt.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                pop_pt.Width = 620;
                pop_pt.Height = 350;
                pop_pt.ShowDialog();

                //sYesNo = (((UserControlBase)(((MainMenuInfo)pop_pt.Content).INSTANCE_OF_MENU)) as dynamic).DataContext.RtnValue;
                sYesNo = ((UserControlBase)pop_pt.GetContent() as dynamic).DataContext.RtnValue;
            }
            //CDW에서 띄울때
            else if (CALLER == "CDW")
            {
                PopUpBase pop_pt = base.OnLoadPopupMenu("DR_HIS.MC.DM.PS.MN.UI_/SavePatientInformationPrivacyRequestSingle.xaml", new object[] { access.PT_NO, null, null, null, null, "W01", "RECVIEWER" });
                pop_pt.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                pop_pt.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                pop_pt.Width = 700;
                pop_pt.Height = 350;
                pop_pt.ShowDialog();

                sYesNo = ((UserControlBase)pop_pt.GetContent() as dynamic).DataContext.RtnValue;
            }
            //6개 제외한 나머지 메인에서 띄울 때
            else
            {
                PopUpBase pop_pt = base.OnLoadPopupMenu("DR_HIS.MC.DM.PS.MN.UI_/SavePatientInformationPrivacyRequest.xaml", new object[] { access.PT_NO, null, null, null, "YY", "RECVIEWER" });
                pop_pt.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                pop_pt.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                pop_pt.ShowDialog();
                //sYesNo = (((UserControlBase)(((MainMenuInfo)pop_pt.Content).INSTANCE_OF_MENU)) as dynamic).DataContext.RtnValue;
                sYesNo = ((UserControlBase)pop_pt.GetContent() as dynamic).DataContext.RtnValue;
            }

            ////////////////////////////////////////////////////////

            if (sYesNo.Substring(0, 1) == "Y")
                return true;
            else
                return false;

            //return false;
        }

        /// <summary>
        /// 특정조건에서 환경설정
        /// </summary>
        private void InitConfigration()
        {
            if (CALLER == "SUPREC") //진료지원_의무기록에서 호출시
            {
                thisUserControl.tctlSearchRecordList.SelectedTab = (HSF.Controls.WPF.Tab.HTabItem)thisUserControl.tctlSearchRecordList.Items[1]; // 조건별 상세조회 기본세팅           
            }
            else if (CALLER == "INSIDE")
            {
                thisUserControl.tctlSearchRecordList.SelectedTab = (HSF.Controls.WPF.Tab.HTabItem)thisUserControl.tctlSearchRecordList.Items[0]; // 수진일별 기록조회 기본세팅
            }
            else if (CALLER == "WO") //외래원무수납창구에서 호출시
            {
                thisUserControl.tctlSearchRecordList.SelectedTab = (HSF.Controls.WPF.Tab.HTabItem)thisUserControl.tctlSearchRecordList.Items[3]; // 진단서
                TabSelectionChange(); //진단서 목록조회
                if (SELECTED_RECORDLISTBYDIAGNOSIS_DTO != null && SELECTED_RECORDLISTBYDIAGNOSIS_DTO.MDRC_ID > 0)
                {
                    SearchDiagnosisCertificateForm(SELECTED_RECORDLISTBYDIAGNOSIS_DTO);
                }
            }
            else if (CALLER == "PACS")
            {
                thisUserControl.tctlSearchRecordList.SelectedTab = (HSF.Controls.WPF.Tab.HTabItem)thisUserControl.tctlSearchRecordList.Items[1]; // 조건별 상세조회 기본세팅

                //검체검사, 병리검사 자동 세팅
                SelectedRecordTypeList.Clear();
                SelectedRecordTypeList = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>((Code_Record_Type.Where(d => d.COMN_CD == "EX")));

                Code_RecordDetail_Type.Clear();
                Code_EXam_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));

                SelectedRecordDetailTypeList = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>((Code_RecordDetail_Type.Where(d => d.COMN_CD == "EX_SPECIMEN" || d.COMN_CD == "EX_PATHOLOGY")));

                //Scroll 모드 Default
                FlowDocumentViewMode = "Scroll";
            }
            else if (CALLER == "CDW")
            {
                thisUserControl.tctlSearchRecordList.SelectedTab = (HSF.Controls.WPF.Tab.HTabItem)thisUserControl.tctlSearchRecordList.Items[0]; // 수진일별 기록조회 기본세팅           
            }

            #region [간호메인 환경설정 로드]
            //간호메인에서 저장한 개인설정값을 불러옴.
            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"] != null)
            {
                //의무기록뷰어 조회조건 설정(수진일별, 조건별)
                if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_BSC_ASK_CDTN"] != null)
                {
                    var result = IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_BSC_ASK_CDTN"].FirstOrDefault();
                    int val = Convert.ToInt16(result.ITEM_CHR_VAL) - 1;

                    if (val >= 0)
                        thisUserControl.tctlSearchRecordList.SelectedTab = (HSF.Controls.WPF.Tab.HTabItem)thisUserControl.tctlSearchRecordList.Items[val];
                }

                //의무기록뷰어 조회조건 설정(기간)
                if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_SRCH_PRD_COND"] != null)
                {
                    var result = IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_SRCH_PRD_COND"].FirstOrDefault();
                    var val = result.ITEM_CHR_VAL;

                    if (val != null)
                    {
                        SelectedPeriodValue = val;
                        SelectPeriod();
                    }
                }

                //의무기록뷰어 조회조건 설정(기록유형)
                if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_REC_CLS"] != null)
                {
                    var result = IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_REC_CLS"].FirstOrDefault();
                    var val = result.ITEM_CHR_VAL;

                    if (val != null)
                    {
                        SelectedRecordTypeList = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>((Code_Record_Type.Where(d => d.COMN_CD == val)));

                        Code_RecordDetail_Type.Clear();

                        if (val.Equals("DR"))
                        {
                            Code_DoctorRecord_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                        }
                        else if (val.Equals("NR"))
                        {
                            Code_NursingRecord_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                        }
                        else if (val.Equals("EX"))
                        {
                            Code_EXam_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                        }
                        else if (val.Equals("SC"))
                        {
                            Code_SCan_Type.ToList().ForEach(I => Code_RecordDetail_Type.Add(I));
                        }

                        Code_RecordDetail_Type.ToList().ForEach(i => SelectedRecordDetailTypeList.Add(i));
                    }

                }

                //의무기록뷰어 조회조건 설정(기록상세유형)
                if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_REC_DTL_CLS"] != null)
                {
                    var result = IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING["NR"].GLOBAL_PRIVATE_SETTING["MDREC_VWR_REC_DTL_CLS"].FirstOrDefault();
                    var val = result.ITEM_CHR_VAL;

                    if (val != null)
                        SelectedRecordDetailTypeList = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>((Code_RecordDetail_Type.Where(d => d.COMN_CD == val)));
                }
            }
            #endregion [간호메인 환경설정 로드]
        }

        /// <summary>
        /// 권한 설정
        /// </summary>
        private void InitPrivilige()
        {

            #region 1. 권한관리

            UserAuthorityManagement_INOUT inParam = new UserAuthorityManagement_INOUT();

            inParam.SID = SessionManager.UserInfo.SID;
            inParam.AOA_WKDP_CD = SessionManager.UserInfo.AOA_WKDP_CD;
            inParam.STF_NO = SessionManager.UserInfo.STF_NO;

            //if (SessionManager.PatientInfo != null)
            //    inParam.PT_NO = SessionManager.PatientInfo.PT_NO;

            inParam.PT_NO = PatientInformation.PT_NO;

            UsrAuthInfo = (UserAuthorityManagement_INOUT)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectUserAuthority", inParam);

            if (UsrAuthInfo.PRNT_AUTH_YN == "Y")
            {
                ListMinWidth = 700d;
                // 출력권한
                PrintAuthority = true;
                PrintingAskVisibility = Visibility.Visible; //출력용 조회 체크박스 Visible
                //2024-04-18, 박찬규, 출력용 조회 디폴트 체크(PSS_MC_0526)
                PrintingAskChecked = true;
                //2024-04-19, 박찬규, 출력용 조회 디폴트 체크(PSS_MC_0527)
                ImagePrintingAskVisibility = Visibility.Visible;
                OperationimagePrintingAskVisibility = Visibility.Visible;
                OperationImagePrintingAskChecked = true;
                ImagePrintingAskChecked = false;
                IsImageOperationPrintingAsEnabled = true;
                IsImagePrintingAsEnabled = true;
                imagePrintAuthority = false;
                operationimagePrintAuthority = true;
            }

            /* 간호관련 정신과 기록 열람관련하여,  언제부터 UsrAuthInfo.NPREC_READ_YN 가 주석처리되어있는지 모르겠으나,
              2020.08.06 확인한 결과 HIS.MC.DR.RM.RS.SelectNPRecordUserAuthorityAsk (EQS) 를 읽어서 정신과 열람 가능 병동을 관리하는것 같아서,  로직이 주석처리 되어 있는 것 같음.
            if (UsrAuthInfo.NPREC_READ_YN == "Y") 
            {
                //정신과 기록 조회 권한
                NPRecAskYN = true;
            }
            */

            //2023-06-09
            // 기존에는 MRD02의 이미지출력여부 N으로 설정되어있으면 무조건 이미지가 나오지 않았음
            // 출력용조회 눌렀을 때 반영되어야 하는데 기존에는 그런 로직이 아니였음
            //  1. MRD02의 IMG_PRNT_YN(이미지출력여부) 컬럼은 이제 사용하지 않기로 함
            //  2. 이미지출력여부는 HISS소속 직원만 출력조회 클릭하고 조회했을 때 반영되도록 요청하여 변경
            //if (UsrAuthInfo.IMG_PRNT_YN == "N")
            //{
            //    // 이미지 출력여부
            //    imagePrintAuthority = false;
            //}

            // 2023-05-31 (SR)202302-00351
            // HISS부서 직원은 출력권한 테이블과 상관없음 
            // 1. 출력용 조회 체크박스 무조건 보이게 함
            // 2. 이미지 출력여부 무조건 true 
            //2024-04-19, 박찬규, 부서가 상관 없어서 주석 처리 진행 하였습니다 .(PSS_MC_0527)
            //if (SessionManager.UserInfo.AOA_WKDP_CD == "HISS")
            //{
            //    ListMinWidth = 700d;
            //    PrintAuthority = true; // 출력권한
            //    PrintingAskChecked = true;
            //    PrintingAskVisibility = Visibility.Visible; //출력용 조회 체크박스 Visible
            //    ImagePrintingAskVisibility = Visibility.Visible;

            //    //2024-04-18, 박찬규, 출력용 조회 디폴트 체크(PSS_MC_0526)
            //    PrintingAskChecked = true;
            //}

            if (UsrAuthInfo.RS_PRINT_YN == "Y")
            {
                // 방사선안전관리실 사용자 여부
                SearchCondition.RSPrintYN = "Y"; //방사선안전관리실 사용자일 경우 방사선관계종사자 건강진단서만 조회
            }

            if (UsrAuthInfo.RECORD_HISTORY_YN == "N")
            {
                // 기록이력조회권한여부

                AskByHavingAMedicalExaminationHistoryTab = Visibility.Collapsed; //기록이력조회 Tab Visibility
            }

            if (UsrAuthInfo.ONLY_CERTIFCATE_YN == "Y" || UsrAuthInfo.ONLY_SCAN_YN == "Y" || UsrAuthInfo.RS_PRINT_YN == "Y")
            {
                PrintAuthority = true; // 출력권한                
                AskByHavingAMedicalExaminationTab = Visibility.Collapsed; //수진일별 기록조회 Tab Visibility
                AskByConditionTab = Visibility.Collapsed; //조건별 기록조회 Tab Visibility
                AskByHavingAMedicalExaminationHistoryTab = Visibility.Collapsed; //기록이력조회 Tab Visibility
                AskByDiagnosisCertificateTab = Visibility.Collapsed; // 진단서 Tab Visibility
                AskByConsentFormTab = Visibility.Collapsed; // 동의서 Tab Visibility
                AskByCharacteristicRecordTab = Visibility.Collapsed; // 특성화기록 Tab Visibility

                //원무과 직원, 방사선안전관리실 직원의 경우(MDREC_AUTH_UPUR_CD IN ("MRD03","MRD06")) 진단서 Tab만 Display한다.
                if (UsrAuthInfo.ONLY_CERTIFCATE_YN == "Y" || UsrAuthInfo.RS_PRINT_YN == "Y")
                {
                    AskByDiagnosisCertificateTab = Visibility.Visible; // 진단서 Tab Visibility
                    thisUserControl.tctlSearchRecordList.SelectedIndex = 3;
                    TabSelectionChange();
                }

                if (UsrAuthInfo.ONLY_SCAN_YN == "Y")
                {
                    AskByConditionTab = Visibility.Visible; // 조건별 기록조회 Tab Visibility

                    GetRecordTypeList("SCP", UsrAuthInfo.ODF_PAGE_CD_CNTE);

                    thisUserControl.tctlSearchRecordList.SelectedIndex = 1;
                    TabSelectionChange();
                }
            }

            else
            {
                GetRecordTypeList("ALL", null);

                thisUserControl.tctlSearchRecordList.SelectedIndex = 0;
                TabSelectionChange();
            }

            #endregion

            // 2. 미완성등록 권한           
            if (UserInformation.AOA_WKDP_CD == "HMRS" || UsrAuthInfo.INCOMPLETE_RECORD_MNG_YN == "Y") // {#} 테스트를 위해 권한 부여함
            {
                InCompleteAuthority = true;
                InCompleteVisibility = Visibility.Visible; // {#} 미완성 관련 페이지 연동시 주석 제거필요!
            }

            //2024-07-29, 박찬규, 이수미 파트장님 지시사항으로 수정
            // 3. 복사 권한
            if (UserInformation.AOA_WKDP_CD == "INS" || UserInformation.AOA_WKDP_CD == "HCSOT" || UserInformation.AOA_WKDP_CD == "HMRS")
            {
                RecordCopyEnabled = true;
            }
            else
            {
                RecordCopyEnabled = false;
            }

            string mainDeveloperId = CommonServiceAgent.SelectCodeInfo(new CCCCCSTE_INOUT() { COMN_GRP_CD = "MD00739", COMN_CD = "ID0029" }).COMN_CD_NM; // 담당개발자ID
            string subDeveloperId = CommonServiceAgent.SelectCodeInfo(new CCCCCSTE_INOUT() { COMN_GRP_CD = "MD00739", COMN_CD = "ID0035" }).COMN_CD_NM; // 보조개발자ID - 테스트필요시 DB에서 변경해서 사용하세요.
            string assistantId = CommonServiceAgent.SelectCodeInfo(new CCCCCSTE_INOUT() { COMN_GRP_CD = "MD00739", COMN_CD = "ID0036" }).COMN_CD_NM; // 간사ID

            // 4. FLOWDOCUMENT => HTML 변경 권한(개발용)            
            if (UserInformation.STF_NO == mainDeveloperId || UserInformation.STF_NO == subDeveloperId || UserInformation.STF_NO == assistantId)
            {
                thisUserControl.btnHtml.Visibility = Visibility.Visible;
                thisUserControl.btnOriginalFormView.Visibility = Visibility.Visible;
                thisUserControl.btnDiagnosisOriginalFormView.Visibility = Visibility.Visible;
                thisUserControl.btnGC.Visibility = Visibility.Visible;
                // 2. 미완성등록 권한
                InCompleteAuthority = true;
                InCompleteVisibility = Visibility.Visible; // {#} 미완성 관련 페이지 연동시 주석 제거필요!
                // 3. 복사 권한
                RecordCopyEnabled = true;
            }

            //2024-07-15, 박찬규, 신포괄 관련 작업 (PSS_MC_0609)
            //의무기록팀만 신포괄 확정 할 수 있습니다.
            if (SessionManager.UserInfo.AOA_WKDP_CD == "HMRS")
            {
                NewDrgDeterminationVisibility = Visibility.Visible;
            }
        }

        private void ResetPrivilige()
        {
            if (SessionManager.UserInfo.AOA_WKDP_CD == "HISS")
            {
                ImagePrintingAskChecked = false;

                if (!PrintingAskChecked)
                {
                    imagePrintAuthority = true;
                }
            }
        }

        /// <summary>
        /// 환자 변경시 환자정보를 설정합니다.
        /// </summary>
        /// <param name="returnObj"></param>
        public void PatientInformation_SelectedDataChanged(PatientInformation_INOUT returnObj)
        {
            if (returnObj != null)
            {
                PatientInformation = returnObj;
            }
        }

        /// <summary>
        /// name         : 기간코드 조회 함수
        /// desc         : 페이지 초기화 시 기간코드 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-19
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetPeriodList()
        {
            //기간코드 설정
            //Code_Period.Add(new CCCCCSTE_INOUT("Period", "ALL", "전체"));
            //Code_Period.Add(new CCCCCSTE_INOUT("Period", "5Y", "5년"));// 2013-08-13 김정훈 : 영상의학과 요청사항으로 추가
            //Code_Period.Add(new CCCCCSTE_INOUT("Period", "1Y", "1년"));
            //Code_Period.Add(new CCCCCSTE_INOUT("Period", "6M", "6개월"));
            //Code_Period.Add(new CCCCCSTE_INOUT("Period", "3M", "3개월"));
            //Code_Period.Add(new CCCCCSTE_INOUT("Period", "1M", "1개월"));

            HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> codes = CodeBindManager.GetCodeListByGroup(allCodes, "MD00418");
            //기간코드 설정
            Code_Period = codes;

            if (CALLER == "CTFS")
                SelectedPeriod = Code_Period[0]; //2013-05-29 김정훈 : 전체 선택 디폴트 (이지윤)
            else if (CALLER == "PACS")
                SelectedPeriod = Code_Period[2]; //2013-08-23 김정훈 : 1년 선택 디폴트 (김태정)
            else
                SelectedPeriod = Code_Period[4]; // 기본 : 3개월
        }

        /// <summary>
        /// name         : 원무접수구분 조회 함수
        /// desc         : 페이지 초기화 시 원무접수구분 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-19
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetPactTypeList()
        {
            //원무접수구분코드 설정
            Code_Pact_Type.Add(new CCCCCSTE_INOUT("Pact_Type", "ALL", "전체"));
            Code_Pact_Type.Add(new CCCCCSTE_INOUT("Pact_Type", "O", "외래"));
            Code_Pact_Type.Add(new CCCCCSTE_INOUT("Pact_Type", "I", "입원"));
            Code_Pact_Type.Add(new CCCCCSTE_INOUT("Pact_Type", "E", "응급"));
            SelectedPact_Type = Code_Pact_Type[0];
            SearchCondition.PACT_TP_CD = SelectedPact_Type.COMN_CD;
        }

        /// <summary>
        /// name         : 진료과타입 조회 함수
        /// desc         : 페이지 초기화 시 진료과타입 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-11-07
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetDeptTypeList()
        {
            //진료과타입 설정
            Code_Dept_Type.Add(new CCCCCSTE_INOUT("Dept_Type", "ALL", "전체"));
            Code_Dept_Type.Add(new CCCCCSTE_INOUT("Dept_Type", "MED_DEPT", "수진과"));
            Code_Dept_Type.Add(new CCCCCSTE_INOUT("Dept_Type", "WRTR_DEPT", "작성과"));
            SelectedDept_Type = Code_Dept_Type[0];
            SearchCondition.DEPT_TYPE = SelectedDept_Type.COMN_CD;
        }

        /// <summary>
        /// name         : 작성자타입 조회 함수
        /// desc         : 페이지 초기화 시 작성자타입 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-11-07
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetWRTRTypeList()
        {
            //작성자타입 설정
            Code_WRTR_Type.Add(new CCCCCSTE_INOUT("WRTR_Type", "ALL", "전체"));
            Code_WRTR_Type.Add(new CCCCCSTE_INOUT("WRTR_Type", "SELF", "본인"));
            Code_WRTR_Type.Add(new CCCCCSTE_INOUT("WRTR_Type", "SEARCH", "조회"));
            SelectedWRTR_Type = Code_WRTR_Type[0];
            SearchCondition.WRTR_TYPE = SelectedWRTR_Type.COMN_CD;
        }

        /// <summary>
        /// name         : 기록구분 조회 함수
        /// desc         : 페이지 초기화 시 기록구분 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-18
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetRecordTypeList(string flag, string scan_page_cd)
        {
            #region 기록구분전체
            if (flag.Equals("ALL"))
            {
                //기록구분
                //Code_Record_Type.Add(new CCCCCSTE_INOUT("Record_Type", "DR", "진료기록"));
                //Code_Record_Type.Add(new CCCCCSTE_INOUT("Record_Type", "OR", "처방"));
                //Code_Record_Type.Add(new CCCCCSTE_INOUT("Record_Type", "NR", "간호기록"));
                //Code_Record_Type.Add(new CCCCCSTE_INOUT("Record_Type", "EX", "검사"));            
                //Code_Record_Type.Add(new CCCCCSTE_INOUT("Record_Type", "SC", "스캔자료"));

                HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> codes = CodeBindManager.GetCodeListByGroup(allCodes, "MD00419");
                //기록구분 설정                
                Code_Record_Type = codes;

                SelectedRecordTypeList.Add(Code_Record_Type[0]);

                HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> recordDetailCode = CodeBindManager.GetCodeListByGroup(allCodes, "MD00420");
                //진료기록구분
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("DoctorRecord_Type", "DR_ALL", "기록 전체"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D001", "외래초진"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D002", "외래경과"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D003", "입원초진"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D004", "입원경과"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D031", "응급기록"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D005", "수술기록"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D006", "퇴원기록"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D010", "마취기록"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D011", "마취전평가"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D007", "타과의뢰"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D020", "과별서식"));
                //Code_DoctorRecord_Type.Add(new CCCCCSTE_INOUT("진료기록", "D030", "의무기록표지"));

                Code_DoctorRecord_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>(recordDetailCode.Where(d => d.DTRL1_NM == "DR"));

                Code_DoctorRecord_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                Code_RecordDetail_Type.ToList().ForEach(i => SelectedRecordDetailTypeList.Add(i));

                //간호기록구분           
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "01", "초기간호정보"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "02", "임상관찰기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "03", "간호활동수행기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "04", "가정간호경과기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "05", "전과전동간호기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "06", "퇴원간호기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "07", "퇴실간호기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "08", "수술전상태확인"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "09", "간호일지"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "10", "욕창기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "11", "수술간호기록"));            
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "13", "회복간호기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "14", "혈액투석간호기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "15", "복막투석간호기록"));
                //Code_NursingRecord_Type.Add(new CCCCCSTE_INOUT("간호기록", "16", "중환자 Assess"));           

                Code_NursingRecord_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>(recordDetailCode.Where(d => d.DTRL1_NM == "NR"));

                //검사기록구분           
                //Code_EXam_Type.Add(new CCCCCSTE_INOUT("검사", "EX_SPECIMEN", "검체검사"));
                //Code_EXam_Type.Add(new CCCCCSTE_INOUT("검사", "EX_PICTURE", "영상검사"));
                //Code_EXam_Type.Add(new CCCCCSTE_INOUT("검사", "EX_PATHOLOGY", "병리검사"));
                //Code_EXam_Type.Add(new CCCCCSTE_INOUT("검사", "EX_FUNCTION", "기능검사"));

                Code_EXam_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>(recordDetailCode.Where(d => d.DTRL1_NM == "EX"));

                //스캔자료구분
                GetScanDetailList();

                //특성화 레포트 구분
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_CABG", "CABG의무기록"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_HEMODIALYSIS", "혈액투석의무기록"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_AMI", "AMI의무기록"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_CPR", "원내심폐소생술보고서"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_SEDATION", "진정기록"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_RRS", "RRS보고서"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_TRREC", "방사선종양 치료기록"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_CFS", "폐암FlowSheet"));
                //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_NST", "NST모니터링"));

                Code_CharacteristicRecord_Type = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>(recordDetailCode.Where(d => d.DTRL1_NM == "CR"));

                SelectedCharacteristicRecordType = "CR_CABG";
                ////진단서구분
                //Code_DiagnosisCertificate_Type.Add(new CCCCCSTE_INOUT("DiagnosisCertificate_Type", "DC_ALL", "진단서 전체"));            
            }
            #endregion 기록구분전체
            #region 조건별상세조회 - 스캔 only
            //원무직원중 타병원모든기록, 입퇴원 약정서 출력가능 직원일 경우 스캔자료만 선택가능.
            else if (flag == "SCP")
            {
                HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> filteredScanType = new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>();

                Code_Record_Type.Add(new CCCCCSTE_INOUT("Record_Type", "SC", "스캔자료"));

                GetScanDetailList();

                //마스터에서 읽어온 스캔기록 종류만 상세리스트에 추가
                string[] page_cd = scan_page_cd.Split('|');

                foreach (CCCCCSTE_INOUT item in Code_SCan_Type)
                {
                    for (int i = 0; i < page_cd.Length; i++)
                    {
                        if (item.COMN_CD == page_cd[i])
                            filteredScanType.Add(item);
                    }
                }
                Code_SCan_Type = filteredScanType;

                SelectedRecordTypeList.Add(Code_Record_Type[0]);
                Code_SCan_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                Code_RecordDetail_Type.ToList().ForEach(i => SelectedRecordDetailTypeList.Add(i));
            }
            #endregion 조건별상세조회 - 스캔 only
        }

        /// <summary>
        /// name         : 정렬타입 조회 함수
        /// desc         : 페이지 초기화 시 정렬타입 정보를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2013-03-11
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetSortTypeList()
        {
            //목록조회 정렬타입 설정
            Code_ListSort_Type.Add(new CCCCCSTE_INOUT("ListSort_Type", "None", "없음"));
            Code_ListSort_Type.Add(new CCCCCSTE_INOUT("ListSort_Type", "NEW", "최신순"));
            Code_ListSort_Type.Add(new CCCCCSTE_INOUT("ListSort_Type", "OLD", "등록순"));
            //Code_ListSort_Type.Add(new CCCCCSTE_INOUT("ListSort_Type", "ASSEMBLING", "제증명"));
            SelectedListSort_Type = Code_ListSort_Type[0];

            //내용조회 정렬타입 설정
            Code_ContentSort_Type.Add(new CCCCCSTE_INOUT("ContentSort_Type", "None", "없음"));
            Code_ContentSort_Type.Add(new CCCCCSTE_INOUT("ContentSort_Type", "NEW", "최신순"));
            Code_ContentSort_Type.Add(new CCCCCSTE_INOUT("ContentSort_Type", "OLD", "등록순"));
            //Code_ContentSort_Type.Add(new CCCCCSTE_INOUT("ContentSort_Type", "ASSEMBLING", "제증명"));
            SelectedContentListSort_Type = Code_ContentSort_Type[1];

        }

        /// <summary>
        /// name         : 스캔자료 세부항목조회 조회 함수
        /// desc         : 페이지 초기화 시 스캔자료 세부항목 데이터를 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-12-16
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetScanDetailList()
        {
            var inObj = new CCCCCSTE_INOUT() { };
            this.Code_SCan_Type = (HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectScanDetailList", inObj);
        }

        /// <summary>
        /// name         : 수진이력조회 함수
        /// desc         : 수진이력을 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-03
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchMedicalTreatmentHistoryList()
        {
            this.RegisterSingleJob(true, "조회 중입니다...", null, CallbackSearchMedicalTreatmentHistoryList);

        }

        void CallbackSearchMedicalTreatmentHistoryList()
        {
            if (!((UserControlBase)base.Owner).Dispatcher.CheckAccess())
            {
                ((UserControlBase)base.Owner).Dispatcher.BeginInvoke(DispatcherPriority.Send, new Action(CallbackSearchMedicalTreatmentHistoryList));
                return;
            }

            #region CallbackSearchMedicalTreatmentHistoryList
            this.MedicalTreatmentHistoryGroupList.Clear();
            this.MedicalTreatmentHistoryList.Clear();

            this.MedicalTreatmentHistoryGroupList.Merge(DepartmentGroup);

            MedicalTreatmentHistoryList = (HSFDTOCollectionBaseObject<MedicalTreatmentHistoryList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectMedicalTreatmentHistoryList", SearchCondition);

            this.MedicalTreatmentHistoryListView = (CollectionView)CollectionViewSource.GetDefaultView(this.MedicalTreatmentHistoryList);
            this.MedicalTreatmentHistoryListView.GroupDescriptions.Add(new PropertyGroupDescription("ALL_DEPT", new CollectionViewGroupingNameConverter<Department_INOUT>(this.MedicalTreatmentHistoryGroupList, "DEPT_CD", "DEPT_NM")));

            SetMedicalTreatmentHistoryListMaxHeight();

            IsFirstSearchMedicalTreatmentHistoryList = false;

            #endregion
        }


        /// <summary>
        /// name         : 기간선택 함수
        /// desc         : 선택된 기간으로 조회시작일자와 조회종료일자를 변경합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-03
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SelectPeriod()
        {
            if (SelectedPeriod != null)
            {
                if (SelectedPeriod.COMN_CD == "ALL")
                {
                    SearchCondition.SEARCH_FROM_DATE = Convert.ToDateTime("1998-01-01");
                    SearchCondition.SEARCH_TO_DATE = CommonServiceAgent.SelectSysDate();
                }
                else if (SelectedPeriod.COMN_CD == "5Y")
                    SearchCondition.SEARCH_FROM_DATE = SearchCondition.SEARCH_TO_DATE.AddYears(-5);
                else if (SelectedPeriod.COMN_CD == "1Y")
                    SearchCondition.SEARCH_FROM_DATE = SearchCondition.SEARCH_TO_DATE.AddYears(-1);
                else if (SelectedPeriod.COMN_CD == "6M")
                    SearchCondition.SEARCH_FROM_DATE = SearchCondition.SEARCH_TO_DATE.AddMonths(-6);
                else if (SelectedPeriod.COMN_CD == "3M")
                    SearchCondition.SEARCH_FROM_DATE = SearchCondition.SEARCH_TO_DATE.AddMonths(-3);
                else if (SelectedPeriod.COMN_CD == "1M")
                    SearchCondition.SEARCH_FROM_DATE = SearchCondition.SEARCH_TO_DATE.AddMonths(-1);
            }
            else
            {
                SearchCondition.SEARCH_FROM_DATE = SearchCondition.SEARCH_TO_DATE.AddMonths(-3);
            }

        }


        /// <summary>
        /// name         : 원무접수구분 선택 함수
        /// desc         : 원무접수구분 선택 정보를 변경합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-19
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SelectPactType()
        {
            SearchCondition.PACT_TP_CD = SelectedPact_Type.COMN_CD;
        }

        /// <summary>
        /// name         : 진료과 선택 함수
        /// desc         : 진료과 선택 정보를 변경합니다.
        /// author       : 김정훈 
        /// create date  : 2012-09-01
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SelectDepartment()
        {
            if (SelectedDepartment != null)
                SearchCondition.DEPT_CD = SelectedDepartment.DEPT_CD;
        }

        /// <summary>
        /// name         : 수진일별 기록목록조회 함수
        /// desc         : 수진일별 기록목록을 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-08-30
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchRecordListByMedicalTreatmentDay(object p)
        {
            if (p == null) { return; }

            String type = p.ToString();
            if (type == "AA")
            {
                if (SelectedMedicalTreatmentHistory == null)
                { return; }
                //this.RecordGroupList.Clear();
                this.RecordListByMedicalTreatmentDay.Clear();

                SearchCondition.PACT_ID = SelectedMedicalTreatmentHistory.PACT_ID;
                RecordListByMedicalTreatmentDay = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(BIZ_CLASS, "SelectRecordListByMedicalTreatmentDay", SearchCondition);


                if (RecordListByMedicalTreatmentDay.Count == 0)
                {
                    MsgBox.Display("해당 수진일에 작성된 기록이 존재하지 않습니다.", MessageType.MSG_TYPE_EXCLAMATION, "수진내역 확인", TimeSpan: 1000);
                }
                else if (RecordListByMedicalTreatmentDay.Count == 1)
                {
                    // 기록이 1건인 경우 바로 조회
                    SelectedRecordListByMedicalTreatmentDay.Add(RecordListByMedicalTreatmentDay.FirstOrDefault());
                    SearchMultiRecordContent(SelectedRecordListByMedicalTreatmentDay);
                }

                // 정렬
                SelectListSortType(RecordListByMedicalTreatmentDay);

                SetMedicalTreatmentDayMaxHeight();
            }
            else if (type == "BB")
            {
                if (SelectedMedicalTreatmentHistory_his == null)
                { return; }
                //this.RecordGroupList.Clear();
                this.RecordListByMedicalTreatmentDay_his.Clear();

                SearchCondition.PACT_ID = SelectedMedicalTreatmentHistory_his.PACT_ID;
                RecordListByMedicalTreatmentDay_his = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(BIZ_CLASS, "SelectRecordListByMedicalRecordHistory", SearchCondition);


            }

        }

        /// <summary>
        /// name         : 조건별 상세유형 기록목록조회 함수
        /// desc         : 조건별 상세유형 기록목록을 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-09-25
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchRecordListByCondition()
        {
            this.RegisterSingleJob("조회 중입니다...", null, CallbackSearchRecordListByCondition);
            //이 형식의 CollectionView에서는 발송자 스레드와 다른 스레드에서의 해당 SourceCollection에 대한 변경 내용을 지원하지 않습니다.

        }

        void CallbackSearchRecordListByCondition()
        {
            if (!((UserControlBase)base.Owner).Dispatcher.CheckAccess())
            {
                ((UserControlBase)base.Owner).Dispatcher.BeginInvoke(DispatcherPriority.Send, new Action(CallbackSearchRecordListByCondition));
                return;
            }

            #region CallbackSearchRecordListByCondition
            //this.RecordGroupList.Clear();
            this.RecordListByCondition.Clear();
            //this.RecordGroupList.Merge(RecordTypeGroup);

            // 2015-02-05 박제영 : 진료기록 저장 미 포함,  유전자검사 미 포함 초기화
            SearchCondition.SIGN_YN = "";
            SearchCondition.GENE_EXM_YN = "";

            SearchCondition.DEPT_TYPE = SelectedDept_Type.COMN_CD;
            SearchCondition.WRTR_TYPE = SelectedWRTR_Type.COMN_CD;
            if (SelectedDepartment != null)
            {
                SearchCondition.DEPT_CD = SelectedDepartment.DEPT_CD;
            }
            else
            {
                SearchCondition.DEPT_CD = "";
            }
            SearchCondition.STF_NO = thisUserControl.rPRPSearchStaffNoCommon.BindedCode;
            SearchCondition.RECORD_TYPE = "";
            foreach (CCCCCSTE_INOUT item in SelectedRecordTypeList)
            {
                if (String.IsNullOrEmpty(SearchCondition.RECORD_TYPE))
                    SearchCondition.RECORD_TYPE = "" + item.COMN_CD + "";
                else
                    SearchCondition.RECORD_TYPE = SearchCondition.RECORD_TYPE + "," + "" + item.COMN_CD + "";
            }
            SearchCondition.RECORD_DETAIL_TYPE = "";
            foreach (CCCCCSTE_INOUT item in SelectedRecordDetailTypeList)
            {
                //if (String.IsNullOrEmpty(SearchCondition.RECORD_DETAIL_TYPE))
                //    SearchCondition.RECORD_DETAIL_TYPE = "" + item.COMN_CD + "";
                //else
                //    SearchCondition.RECORD_DETAIL_TYPE = SearchCondition.RECORD_DETAIL_TYPE + "," + "" + item.COMN_CD + "";
                SearchCondition.RECORD_DETAIL_TYPE = SearchCondition.RECORD_DETAIL_TYPE + item.COMN_CD + ",";
            }

            if (SearchCondition.DEPT_TYPE != "ALL" && SearchCondition.DEPT_CD == "ALL")
            {
                MsgBox.Display("진료과 혹은 작성과를 선택해 주세요", MessageType.MSG_TYPE_EXCLAMATION, "진료과 확인");
                return;
            }
            //간호기록-취소수진 포함 추가 SR 201802-90007
            if (ApcnDtm == true)
            {
                SearchCondition.APCNDTM_YN = "Y";
            }
            else SearchCondition.APCNDTM_YN = "";

            RecordListByCondition = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectRecordListByCondition", SearchCondition);

            if (RecordListByCondition.Count == 0)
            {
                MsgBox.Display("해당 기간동안 작성된 기록이 존재하지 않습니다.", MessageType.MSG_TYPE_EXCLAMATION, "조회조건 확인", TimeSpan: 1000);
                return;
            }

            // 정렬
            SelectListByCondtitionSortType(RecordListByCondition);

            #endregion CallbackSearchRecordListByCondition
        }

        /// <summary>
        /// name         : 진단서 목록조회 함수
        /// desc         : 진단서 기록목록을 조회합니다.
        /// author       : 강성희 
        /// create date  : 2016-06-08
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchRecordListByDiagnosis()
        {
            this.RecordListByDiagnosis.Clear();

            RecordListByDiagnosis = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectRecordListByDiagnosis", SearchCondition);

            if (RecordListByDiagnosis != null && RecordListByDiagnosis.Count > 0)
            {
                SELECTED_RECORDLISTBYDIAGNOSIS_DTO = (RecordList_INOUT)RecordListByDiagnosis.Where(d => string.IsNullOrEmpty(d.PT_NO)).FirstOrDefault();
            }
        }

        /// <summary>
        /// name         : 진단서 출력 목록조회 함수
        /// desc         : 진단서 출력 목록을 조회합니다.
        /// author       : 강성희 
        /// create date  : 2016-06-08
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchDiagnosisCertificatePrintList()
        {
            this.DiagnosisCertificatePrintList.Clear();

            DiagnosisCertificatePrintList = (HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectDiagnosisCertificatePrintList", SearchCondition);
        }

        /// <summary>
        /// name         : 진단서 출력후 실행되는 메서드
        /// desc         : 진단서 출력후 진단서목록과 진단서 출력목록을 다시 조회합니다.
        /// author       : 강성희 
        /// create date  : 2016-06-08
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public void SearchDiagnosisCertificateListAfterPrint()
        {
            SearchRecordListByDiagnosis();
            SearchDiagnosisCertificatePrintList();
        }

        /// <summary>
        /// name         : 다중기록내용조회 함수
        /// desc         : 다중기록내용조회 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-09-21
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchMultiRecordContent(object p)
        {
            if (p == null)
            { return; }

            this.RegisterSingleJobWithArg("조회 중입니다...", null, CallbackSearchMultiRecordContent, p);

            //위에서 내려온 가이드
            //thisUserControl.OwnerWindow.Width -= 1;
            //thisUserControl.OwnerWindow.Width += 1;


        }

        void CallbackSearchMultiRecordContent(object p)
        {
            if (!((UserControlBase)base.Owner).Dispatcher.CheckAccess())
            {
                ((UserControlBase)base.Owner).Dispatcher.BeginInvoke(DispatcherPriority.Send, new Action<object>(CallbackSearchMultiRecordContent), p);
                return;
            }
            SearchMultiRecordContentCommon(p);
        }

        // 내용조회 공통
        void SearchMultiRecordContentCommon(object p)
        {
            #region CallbackSearchMultiRecordContent
            //선택된 기록목록을 초기화
            ClearSelectedRecordList();
            thisUserControl.flowDocViewer.Document = null;

            if (PrintingAskChecked && PrintAuthority)
            {
                SearchPrintModeVisibility = Visibility.Visible;
                PrintPreviewVisibility = Visibility.Visible;
            }
            else
            {
                SearchPrintModeVisibility = Visibility.Collapsed;
                PrintPreviewVisibility = Visibility.Collapsed;
            }

            IList list = p as IList;

            if (list == null) // 1건 선택한 경우
            {
                if (PrintingAskChecked) //출력용 조회를 체크했을 경우
                {
                    if ((p as RecordList_INOUT).RECORD_TYPE == "DR" && (p as RecordList_INOUT).RECORD_DETAIL_TYPE != "D020") //진료기록(과별서식제외)은 서명된 기록만 조회
                    {
                        if ((p as RecordList_INOUT).MDRC_WRT_STS_CD_YN == "Y")
                            AddSelectedRecordList(p as RecordList_INOUT);
                    }
                    else
                    {
                        AddSelectedRecordList(p as RecordList_INOUT); //진료기록(과별서식제외) 외의 기록은 서명여부 체크 안함.
                    }
                }
                else
                {
                    AddSelectedRecordList(p as RecordList_INOUT); //출력용 조회 체크 안했을 경우는 모두 조회
                }
            }
            else
            {
                IList<RecordList_INOUT> inObject = p as IList<RecordList_INOUT>;
                HSFDTOCollectionBaseObject<RecordList_INOUT> returnObject = new HSFDTOCollectionBaseObject<RecordList_INOUT>(p as IList<RecordList_INOUT>);

                returnObject = SortRecordList(SelectedContentListSort_Type.COMN_CD, inObject, returnObject);
                foreach (RecordList_INOUT item in returnObject)
                {
                    if (PrintingAskChecked) //출력용 조회를 체크했을 경우
                    {
                        if (item.RECORD_TYPE == "DR" && item.RECORD_DETAIL_TYPE != "D020") //진료기록(과별서식제외)은 서명된 기록만 조회
                        {
                            if (item.MDRC_WRT_STS_CD_YN == "Y")
                                AddSelectedRecordList(item);
                        }
                        else
                        {
                            AddSelectedRecordList(item); //진료기록 외의 기록은 서명여부 체크 안함.
                        }
                    }
                    else
                    {
                        AddSelectedRecordList(item); //출력용 조회 체크 안했을 경우는 모두 조회
                    }
                }
            }

            if (SelectedRecordList.Count == 0)
            {
                SearchPrintModeVisibility = Visibility.Collapsed;
                PrintPreviewVisibility = Visibility.Collapsed;

                MsgBox.Display("DRMCN_008053", MessageType.MSG_TYPE_INFORMATION); // [선택한 기록지가 없거나, 서명된 기록이 없습니다.]                                

                return;
            }

            var resourceLocater = new Uri("HIS.MC.DR.RM.RV.UI;component/Resources/WhiteBackgroundStyle.xaml", System.UriKind.Relative);

            FlowDocument rootObject = Application.LoadComponent(resourceLocater) as FlowDocument;

            if (rootObject != null)
            {
                #region 그룹으로 조회
                foreach (var group in this.SelectedRecordList.Select(t => t.RECORD_TYPE).Distinct().ToList())
                {
                    //List<FlowDocument> fDocList = null;
                    //코드 인스펙션. 사용하지 않는 변수 주석. 정성호 수정 2013-11-18
                    //HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = null;

                    switch (group)
                    {
                        //진료기록(DR),처방(OR),간호기록(NR),검사(EX),세미기록(SE),스캔자료(SC),전자동의서(EC)
                        case "DR":
                            SearchGroupDoctorRecordFlowDocument(SelectedRecordListDR);
                            break;
                        case "OR":
                            SearchGroupOrderRecordFlowDocument(SelectedRecordListOR);
                            break;
                        case "NR":
                            SearchGroupNursingRecordFlowDocument(SelectedRecordListNR);
                            break;
                        case "EX":
                            SearchGroupExamFlowDocument(SelectedRecordListEX);
                            break;
                        case "SC":
                            SearchGroupScanFlowDocument(SelectedRecordListSC);
                            break;
                        //case "EC":
                        //    SearchGroupElectronicConsentFlowDocument(SelectedRecordListEC);
                        //    rootObject.PagePadding = new Thickness(5);
                        //    break;
                        default:
                            break;
                    }

                    //String str = GetXaml(thisUserControl.flowDocViewer.Document);

                }
                #endregion 그룹으로 조회

                // 내용조회
                foreach (PrintRecordList_INOUT fdoc in SelectedRecordList)
                {

                    if (fdoc.RecordFlowDocumentList.Count() == 0)
                    {
                        if (fdoc.RecordFlowDocument != null && fdoc.RecordFlowDocument.Blocks.Count != 0)
                        {
                            Section section = new Section();

                            if (thisUserControl.rblPrintOptionPage.IsSelected)
                            {
                                if (fdoc.RECORD_TYPE == "OR" || (fdoc.RECORD_TYPE == "NR" && fdoc.RECORD_DETAIL_TYPE == "09")) // 처방, 간호일지는 연속출력
                                {
                                    section.BreakPageBefore = false;
                                }
                                else
                                    section.BreakPageBefore = true;
                            }
                            else
                                section.BreakPageBefore = false;

                            List<Block> flowDocumentBlocks = new List<Block>(fdoc.RecordFlowDocument.Blocks);
                            fdoc.RecordFlowDocument = null;// {#} 메모리누수 테스트

                            if (rootObject.Blocks.Count != 0 && fdoc.RECORD_TYPE != "SC" && thisUserControl.rblPrintOptionContinue.IsSelected)
                                section.Blocks.Add(new Paragraph(new Run()) { Name = "RecordParagraphBlank", LineHeight = 20 }); // 디자인 가이드 : 기록 단위로 HEIGHT 20 지정

                            foreach (Block aBlock in flowDocumentBlocks)
                            {
                                section.Blocks.Add(aBlock);
                            }

                            rootObject.Blocks.Add(section);
                        }
                    }
                    else
                    {
                        // 검체검사의 경우 하나의 DTO 에 여러개의 FlowDocument를 가지고 있음
                        foreach (FlowDocument ifdocRecordFlowDocument in fdoc.RecordFlowDocumentList)
                        {
                            if (ifdocRecordFlowDocument != null && ifdocRecordFlowDocument.Blocks.Count != 0)
                            {
                                Section section = new Section();

                                if (thisUserControl.rblPrintOptionPage.IsSelected)
                                    section.BreakPageBefore = true;
                                else
                                    section.BreakPageBefore = false;

                                List<Block> flowDocumentBlocks = new List<Block>(ifdocRecordFlowDocument.Blocks);

                                if (rootObject.Blocks.Count != 0 && fdoc.RECORD_TYPE != "SC" && thisUserControl.rblPrintOptionContinue.IsSelected)
                                    section.Blocks.Add(new Paragraph(new Run()) { Name = "RecordParagraphBlank", LineHeight = 20 }); // 디자인 가이드 : 기록 단위로 HEIGHT 20 지정

                                foreach (Block aBlock in flowDocumentBlocks)
                                {
                                    section.Blocks.Add(aBlock);
                                }

                                rootObject.Blocks.Add(section);
                            }
                        }
                        fdoc.RecordFlowDocumentList = null;// {#} 메모리누수 테스트
                    }

                    PrintedRecordList.Add(fdoc);
                }

                thisUserControl.flowDocViewer.Document = rootObject;
                //thisUserControl.flowDocViewer.Document.PreviewMouseLeftButtonDown = true;
            }
            #endregion CallbackSearchMultiRecordContent
        }

        //////////////////////////////이력조회 테스트 
        /// <summary>
        /// name         : 다중기록내용조회 함수
        /// desc         : 다중기록내용조회 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-09-21
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchMultiRecordContentHistory(object p)
        {
            if (p == null)
            { return; }

            this.RegisterSingleJobWithArg("조회 중입니다...", null, CallbackSearchMultiRecordContentHistory, p);

        }

        void CallbackSearchMultiRecordContentHistory(object p)
        {
            if (!((UserControlBase)base.Owner).Dispatcher.CheckAccess())
            {
                ((UserControlBase)base.Owner).Dispatcher.BeginInvoke(DispatcherPriority.Send, new Action<object>(CallbackSearchMultiRecordContentHistory), p);
                return;
            }
            SearchMultiRecordContentCommonHistory(p);
        }

        // 내용조회 공통
        void SearchMultiRecordContentCommonHistory(object p)
        {
            #region CallbackSearchMultiRecordContentHistory
            //선택된 기록목록을 초기화
            ClearSelectedRecordList();
            thisUserControl.flowDocViewer.Document = null;

            if (PrintingAskChecked && PrintAuthority)
            {
                SearchPrintModeVisibility = Visibility.Visible;
                PrintPreviewVisibility = Visibility.Visible;
            }
            else
            {
                SearchPrintModeVisibility = Visibility.Collapsed;
                PrintPreviewVisibility = Visibility.Collapsed;
            }

            IList list = p as IList;

            if (list == null) // 1건 선택한 경우
            {
                if (PrintingAskChecked) //출력용 조회를 체크했을 경우
                {
                    if ((p as RecordList_INOUT).RECORD_TYPE == "DR" && (p as RecordList_INOUT).RECORD_DETAIL_TYPE != "D020") //진료기록(과별서식제외)은 서명된 기록만 조회
                    {
                        if ((p as RecordList_INOUT).MDRC_WRT_STS_CD_YN == "Y")
                            AddSelectedRecordList(p as RecordList_INOUT);
                    }
                    else
                    {
                        AddSelectedRecordList(p as RecordList_INOUT); //진료기록(과별서식제외) 외의 기록은 서명여부 체크 안함.
                    }
                }
                else
                {
                    AddSelectedRecordList(p as RecordList_INOUT); //출력용 조회 체크 안했을 경우는 모두 조회
                }
            }
            else
            {
                IList<RecordList_INOUT> inObject = p as IList<RecordList_INOUT>;
                HSFDTOCollectionBaseObject<RecordList_INOUT> returnObject = new HSFDTOCollectionBaseObject<RecordList_INOUT>(p as IList<RecordList_INOUT>);

                returnObject = SortRecordList(SelectedContentListSort_Type.COMN_CD, inObject, returnObject);
                foreach (RecordList_INOUT item in returnObject)
                {
                    if (PrintingAskChecked) //출력용 조회를 체크했을 경우
                    {
                        if (item.RECORD_TYPE == "DR" && item.RECORD_DETAIL_TYPE != "D020") //진료기록(과별서식제외)은 서명된 기록만 조회
                        {
                            if (item.MDRC_WRT_STS_CD_YN == "Y" && item.MDRC_DC_TP_YN != "Y")
                                AddSelectedRecordList(item);
                        }
                        else
                        {
                            AddSelectedRecordList(item); //진료기록 외의 기록은 서명여부 체크 안함.
                        }
                    }
                    else
                    {
                        AddSelectedRecordList(item); //출력용 조회 체크 안했을 경우는 모두 조회
                    }
                }
            }

            if (SelectedRecordList.Count == 0)
            {
                SearchPrintModeVisibility = Visibility.Collapsed;
                PrintPreviewVisibility = Visibility.Collapsed;

                MsgBox.Display("DRMCN_008053", MessageType.MSG_TYPE_INFORMATION); // [선택한 기록지가 없거나, 서명된 기록이 없습니다.]                                

                return;
            }

            var resourceLocater = new Uri("HIS.MC.DR.RM.RV.UI;component/Resources/WhiteBackgroundStyle.xaml", System.UriKind.Relative);

            FlowDocument rootObject = Application.LoadComponent(resourceLocater) as FlowDocument;

            if (rootObject != null)
            {
                #region 그룹으로 조회
                foreach (var group in this.SelectedRecordList.Select(t => t.RECORD_TYPE).Distinct().ToList())
                {
                    //List<FlowDocument> fDocList = null;
                    //코드 인스펙션. 사용하지 않는 변수 주석. 정성호 수정 2013-11-18
                    //HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = null;

                    switch (group)
                    {
                        //진료기록(DR),처방(OR),간호기록(NR),검사(EX),세미기록(SE),스캔자료(SC),전자동의서(EC)
                        case "DR":
                            SearchGroupDoctorRecordFlowDocument(SelectedRecordListDR);
                            break;
                        case "OR":
                            SearchGroupOrderRecordFlowDocument(SelectedRecordListOR);
                            break;
                        case "NR":
                            SearchGroupNursingRecordFlowDocument(SelectedRecordListNR);
                            break;
                        case "EX":
                            SearchGroupExamFlowDocument(SelectedRecordListEX);
                            break;
                        case "SC":
                            SearchGroupScanFlowDocument(SelectedRecordListSC);
                            break;
                        //case "EC":
                        //    SearchGroupElectronicConsentFlowDocument(SelectedRecordListEC);
                        //    rootObject.PagePadding = new Thickness(5);
                        //    break;
                        default:
                            break;
                    }

                    //String str = GetXaml(thisUserControl.flowDocViewer.Document);

                }
                #endregion 그룹으로 조회

                // 내용조회
                foreach (PrintRecordList_INOUT fdoc in SelectedRecordList)
                {

                    if (fdoc.RecordFlowDocumentList.Count() == 0)
                    {
                        if (fdoc.RecordFlowDocument != null && fdoc.RecordFlowDocument.Blocks.Count != 0)
                        {
                            Section section = new Section();

                            if (thisUserControl.rblPrintOptionPage.IsSelected)
                            {
                                if (fdoc.RECORD_TYPE == "OR" || (fdoc.RECORD_TYPE == "NR" && fdoc.RECORD_DETAIL_TYPE == "09")) // 처방, 간호일지는 연속출력
                                {
                                    section.BreakPageBefore = false;
                                }
                                else
                                    section.BreakPageBefore = true;
                            }
                            else
                                section.BreakPageBefore = false;

                            List<Block> flowDocumentBlocks = new List<Block>(fdoc.RecordFlowDocument.Blocks);
                            fdoc.RecordFlowDocument = null;// {#} 메모리누수 테스트

                            if (rootObject.Blocks.Count != 0 && fdoc.RECORD_TYPE != "SC" && thisUserControl.rblPrintOptionContinue.IsSelected)
                                section.Blocks.Add(new Paragraph(new Run()) { Name = "RecordParagraphBlank", LineHeight = 20 }); // 디자인 가이드 : 기록 단위로 HEIGHT 20 지정

                            foreach (Block aBlock in flowDocumentBlocks)
                            {
                                section.Blocks.Add(aBlock);
                            }

                            rootObject.Blocks.Add(section);
                        }
                    }
                    else
                    {
                        // 검체검사의 경우 하나의 DTO 에 여러개의 FlowDocument를 가지고 있음
                        foreach (FlowDocument ifdocRecordFlowDocument in fdoc.RecordFlowDocumentList)
                        {
                            if (ifdocRecordFlowDocument != null && ifdocRecordFlowDocument.Blocks.Count != 0)
                            {
                                Section section = new Section();

                                if (thisUserControl.rblPrintOptionPage.IsSelected)
                                    section.BreakPageBefore = true;
                                else
                                    section.BreakPageBefore = false;

                                List<Block> flowDocumentBlocks = new List<Block>(ifdocRecordFlowDocument.Blocks);

                                if (rootObject.Blocks.Count != 0 && fdoc.RECORD_TYPE != "SC" && thisUserControl.rblPrintOptionContinue.IsSelected)
                                    section.Blocks.Add(new Paragraph(new Run()) { Name = "RecordParagraphBlank", LineHeight = 20 }); // 디자인 가이드 : 기록 단위로 HEIGHT 20 지정

                                foreach (Block aBlock in flowDocumentBlocks)
                                {
                                    section.Blocks.Add(aBlock);
                                }

                                rootObject.Blocks.Add(section);
                            }
                        }
                        fdoc.RecordFlowDocumentList = null;// {#} 메모리누수 테스트
                    }

                    PrintedRecordList.Add(fdoc);
                }

                thisUserControl.flowDocViewer.Document = rootObject;
                //thisUserControl.flowDocViewer.Document.PreviewMouseLeftButtonDown = true;
            }
            #endregion CallbackSearchMultiRecordContent
        }
        ////////END

        /// <summary>
        /// name         : 선택된 기록목록을 초기화하는 함수
        /// desc         : 선택된 기록목록을 초기화합니다.
        /// author       : 김정훈 
        /// create date  : 2012-12-16
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void ClearSelectedRecordList()
        {
            SelectedRecordList.Clear();
            SelectedRecordListDR.Clear();
            SelectedRecordListOR.Clear();
            SelectedRecordListNR.Clear();
            SelectedRecordListEX.Clear();
            SelectedRecordListSC.Clear();
            SelectedRecordListEC.Clear();
            SelectedRecordListCR.Clear();

            PrintedRecordList.Clear();
        }


        /// <summary>
        /// name         : 선택된 기록목록에 추가하는 함수
        /// desc         : 선택된 기록목록에 추가합니다.
        /// author       : 김정훈 
        /// create date  : 2012-12-16
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void AddSelectedRecordList(RecordList_INOUT item)
        {
            PrintRecordList_INOUT newItem = new PrintRecordList_INOUT()
            {
                RECORD_TYPE = item.RECORD_TYPE,
                RECORD_DETAIL_TYPE = item.RECORD_DETAIL_TYPE,
                ITEM_TYPE = item.ITEM_TYPE,
                ITEM_NM = item.ITEM_NM,
                WRITING_DATE = item.WRITING_DATE,
                WRITING_DEPT_CD = item.WRITING_DEPT_CD,
                WRITING_DEPT_NM = item.WRITING_DEPT_NM,
                WRITER_STF_NO = item.WRITER_STF_NO,
                WRITER_NM = item.WRITER_NM,
                PACT_TP_CD = item.PACT_TP_CD,
                PT_MED_DEPT_CD = item.PT_MED_DEPT_CD,
                DT_START = item.DT_START,
                DT_END = item.DT_END,
                PT_NO = item.PT_NO,
                SORT_SEQ = item.SORT_SEQ,
                KEY_ID = item.KEY_ID,
                PRINT_SEQ = item.PRINT_SEQ,
                NOTE = item.NOTE,
                PACT_ID = item.PACT_ID,
                MDRC_ID = item.MDRC_ID,
                MDRC_FOM_SEQ = item.MDRC_FOM_SEQ,
                MDFM_ID = item.MDFM_ID,
                MDFM_FOM_SEQ = item.MDFM_FOM_SEQ,
                MDFM_CLS_CD = item.MDFM_CLS_CD,
                MDFM_CLS_DTL_CD = item.MDFM_CLS_DTL_CD,
                RECTYPE = item.RECTYPE,
                EXAM_KEY = item.EXAM_KEY,
                GENE_EXM_YN = item.GENE_EXM_YN, // 2015-02-05 박제영 : 유전자검사 여부 추가
                MDRC_WRT_STS_CD_YN = item.MDRC_WRT_STS_CD_YN,
                OP_EXPT_REG_ID = item.OP_EXPT_REG_ID, //수술예정등록ID 추가. 강성희
                RecordFlowDocumentList = new List<FlowDocument>()
            };


            SelectedRecordList.Add(newItem);
            if (item.RECORD_TYPE == "DR")
                SelectedRecordListDR.Add(newItem);
            else if (item.RECORD_TYPE == "OR")
                SelectedRecordListOR.Add(newItem);
            else if (item.RECORD_TYPE == "NR")
                SelectedRecordListNR.Add(newItem);
            else if (item.RECORD_TYPE == "EX")
                SelectedRecordListEX.Add(newItem);
            else if (item.RECORD_TYPE == "SC")
                SelectedRecordListSC.Add(newItem);
            else if (item.RECORD_TYPE == "CR")
                SelectedRecordListCR.Add(newItem);
        }

        /// <summary>
        /// name         : 진료기록 조회 함수(사용안함)
        /// desc         : 진료기록을 FlowDocument로 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-10-18
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private FlowDocument SearchDoctorRecordFlowDocument(RecordList_INOUT record)
        {
            FlowDocument fdoc = new FlowDocument();
            //FlowDocument fdoc = null;
            //record.MDRC_ID;

            //기록내용조회를 위한 헤더정보 가져오기
            MedicalTreatmentRecordAskItemHeader_INOUT IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> in_HeaderList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
            IN_HEADER.MDRC_ID = record.MDRC_ID;
            in_HeaderList = (HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "SelectMedicalTreatmentRecordAskClassByMDRCID", IN_HEADER);
            IN_HEADER = in_HeaderList[0];

            MedicalTreatmentRecordParam param = new MedicalTreatmentRecordParam()
            {
                MedicalTreatmentRecordID = IN_HEADER.MDRC_ID.ToString(),
                MedicalTreatmentRecordSEQ = IN_HEADER.MDRC_FOM_SEQ.ToString(),
                MedicalTreatmentRecordFormSetID = IN_HEADER.MDFM_ID.ToString(),
                MedicalTreatmentRecordFormSetSEQ = IN_HEADER.MDFM_FOM_SEQ.ToString(),
                MedicalTreatmentRecordFormTypeCode = IN_HEADER.MDFM_CLS_CD,
                MedicalTreatmentRecordFormTypeDetailCode = IN_HEADER.MDFM_CLS_DTL_CD,
                MedicalTreatmentRecordFormType = IN_HEADER.BasicFormType,
                UniqueID = IN_HEADER.UniqueID,
                MedicalTreatmentRecordFormTypeName = IN_HEADER.MDFM_CLS_NM,
                MedicalTreatmentRecordState = FormSaveState.Read
            };

            thisUserControl.mtfPanel.MedicalTreatmentFormLoad(param);

            if (IN_HEADER.MDFM_CLS_CD != "D020")
            {
                #region 요약조회test

                SelectMedicalTreatmentRecordAskByMdrcId MdrcIdObj = new SelectMedicalTreatmentRecordAskByMdrcId();
                HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> XamlInputList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
                XamlInputList = (MdrcIdObj.DataContext as SelectMedicalTreatmentRecordAskByMdrcIdData).InputList;
                XamlInputList.Add(IN_HEADER);
                MedicalTreatmentRecordAskPersonalCondition_INOUT personalCondition = new MedicalTreatmentRecordAskPersonalCondition_INOUT() { WhiteBackGround = true, MenuVisible = false, ExpanderVisible = false };
                HSFDTOCollectionBaseObject<MedicalTreatmentRecordFlowDocXamlList_OUT> OutputList = MdrcIdObj.SelectMedicalTreatmentRecordAskFlowdocXamlstr(XamlInputList, personalCondition);
                MdrcIdObj.Dispose(); // {#} 메모리누수 때문에 추가

                #region 요약조회 오류 수정
                // Command 제거
                OutputList[0].MedrecXamlString = OutputList[0].MedrecXamlString.Replace("<hsfcwpfec:RelayCommand />", "");
                #endregion 요약조회 오류 수정

                fdoc = (FlowDocument)XamlReader.Parse(OutputList[0].MedrecXamlString);

                #endregion 요약조회test
            }
            else
            {
                SelectMedicalTreatmentRecordAskByMdrcId MdrcIdObj = new SelectMedicalTreatmentRecordAskByMdrcId();
                HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> XamlInputList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
                XamlInputList = (MdrcIdObj.DataContext as SelectMedicalTreatmentRecordAskByMdrcIdData).InputList;
                XamlInputList.Add(IN_HEADER);
                MedicalTreatmentRecordAskPersonalCondition_INOUT personalCondition = new MedicalTreatmentRecordAskPersonalCondition_INOUT() { WhiteBackGround = true, MenuVisible = false, ExpanderVisible = false };
                HSFDTOCollectionBaseObject<MedicalTreatmentRecordFlowDocXamlList_OUT> OutputList = MdrcIdObj.SelectMedicalTreatmentRecordAskFlowdocXamlstr(XamlInputList, personalCondition);
                MdrcIdObj.Dispose();// {#} 메모리누수 때문에 추가

                fdoc = (FlowDocument)XamlReader.Parse(OutputList[0].MedrecXamlString);

            }
            return fdoc;

        }

        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchGroupDoctorRecordFlowDocument(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();

            #region 1. 공통기록, 과별서식
            //마취기록, 마취전상태평가 제외
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> recordList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>(records.Where(d => !d.RECORD_DETAIL_TYPE.Equals("D010") && !d.RECORD_DETAIL_TYPE.Equals("D011")));

            MedicalTreatmentRecordAskItemHeader_INOUT IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> in_HeaderList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();

            if (thisUserControl.tctlSearchRecordList.SelectedIndex == 2) //기록이력조회tab
            {
                recordHistoryAuthority = true;
                IN_HEADER.MULTI_MDRC_ID = "";
                IN_HEADER.MULTI_MDRC_FOM_SEQ = "";
                foreach (var record in recordList)
                {
                    if (string.IsNullOrEmpty(IN_HEADER.MULTI_MDRC_ID))
                    {
                        IN_HEADER.MULTI_MDRC_ID = "" + record.MDRC_ID + "";
                        IN_HEADER.MULTI_MDRC_FOM_SEQ = record.MDRC_FOM_SEQ + "";
                    }
                    else
                    {
                        IN_HEADER.MULTI_MDRC_ID = IN_HEADER.MULTI_MDRC_ID + "^" + "" + record.MDRC_ID + "";
                        IN_HEADER.MULTI_MDRC_FOM_SEQ = IN_HEADER.MULTI_MDRC_FOM_SEQ + "^" + "" + record.MDRC_FOM_SEQ + "";

                    }

                }

                in_HeaderList = (HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "SelectMedicalTreatmentRecordAskClassByMultiMDRCIDSEQ", IN_HEADER);
            }
            else
            {
                IN_HEADER.MULTI_MDRC_ID = "";

                foreach (var record in recordList)
                {
                    if (string.IsNullOrEmpty(IN_HEADER.MULTI_MDRC_ID))
                    {
                        IN_HEADER.MULTI_MDRC_ID = "" + record.MDRC_ID + "";
                    }
                    else
                    {
                        IN_HEADER.MULTI_MDRC_ID = IN_HEADER.MULTI_MDRC_ID + "," + "" + record.MDRC_ID + "";

                    }

                }

                in_HeaderList = (HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "SelectMedicalTreatmentRecordAskClassByMultiMDRCID", IN_HEADER);
            }


            SelectMedicalTreatmentRecordAskByMdrcId MdrcIdObj = new SelectMedicalTreatmentRecordAskByMdrcId();
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> XamlInputList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
            XamlInputList = (MdrcIdObj.DataContext as SelectMedicalTreatmentRecordAskByMdrcIdData).InputList;

            foreach (var in_Header in in_HeaderList)
            {
                XamlInputList.Add(in_Header);
            }

            //recordHistoryAuthority 추가
            //2024-04-19, 박찬규, 이미지 출력 관련 개발 (PSS_MC_0527)
            MedicalTreatmentRecordAskPersonalCondition_INOUT personalCondition = new MedicalTreatmentRecordAskPersonalCondition_INOUT() { WhiteBackGround = true, MenuVisible = false, ExpanderVisible = false, NoteImageDisplay = imagePrintAuthority, EnglishAsk = EngAskChecked, NPRecAsk = NPRecAskYN, History_Tab_Yn = recordHistoryAuthority, OpNoteImageDisplay = operationimagePrintAuthority };

            recordHistoryAuthority = false;

            //History_Tab_Yn
            if (thisUserControl.tctlSearchRecordList.SelectedIndex == 2)
            {
                foreach (MedicalTreatmentRecordAskItemHeader_INOUT item in XamlInputList)
                {

                    item.History_Tab_Yn = "Y";
                }
            }
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordFlowDocXamlList_OUT> OutputList = MdrcIdObj.SelectMedicalTreatmentRecordAskFlowdoc(XamlInputList, personalCondition);
            MdrcIdObj.Dispose();

            foreach (var record in recordList)
            {
                foreach (var output in OutputList)
                {
                    if (thisUserControl.tctlSearchRecordList.SelectedIndex == 2)
                    {
                        if (record.MDRC_ID == output.MDRC_ID && record.MDRC_FOM_SEQ == output.MDRC_FOM_SEQ)
                        {
                            record.RecordFlowDocument = output.MedrecFlowDocument;
                            fDocList.Add(record);
                            break;
                        }
                    }
                    else
                    {
                        if (record.MDRC_ID == output.MDRC_ID)
                        {
                            record.RecordFlowDocument = output.MedrecFlowDocument;
                            fDocList.Add(record);
                            break;
                        }
                    }

                }
            }
            #endregion 1. 공통기록, 과별서식

            #region 2. 마취기록, 마취전상태평가            

            recordList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>(records.Where(d => d.RECORD_DETAIL_TYPE.Equals("D010") || d.RECORD_DETAIL_TYPE.Equals("D011")));

            foreach (var record in recordList)
            {
                IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();

                IN_HEADER.OP_EXPT_REG_ID = record.OP_EXPT_REG_ID;
                IN_HEADER.MDFM_CLS_CD = record.RECORD_DETAIL_TYPE;
                IN_HEADER.MDFM_CLS_NM = record.ITEM_NM;
                IN_HEADER.PT_NO = PatientInformation.PT_NO;

                SelectAnesthesiaRecordAllViewAsk SelectAnesthesiaRecord = new SelectAnesthesiaRecordAllViewAsk(IN_HEADER, null, personalCondition);

                record.RecordFlowDocument = (SelectAnesthesiaRecord.DataContext as SelectAnesthesiaRecordAllViewAskData).MedrecFlowDocument;

                fDocList.Add(record);
            }

            #endregion 2. 마취기록, 마취전상태평가

            return fDocList;
        }

        /// <summary>
        /// flowdocument를 string으로 변환하는 함수(DEBUG 용)
        /// </summary>
        /// <param name="document"></param>
        /// <returns></returns>
        private string GetXaml(FlowDocument document)
        {
            if (document == null)
                return String.Empty;
            else
            {
                StringBuilder sb = new StringBuilder();
                using (XmlWriter xw = XmlWriter.Create(sb))
                {
                    XamlDesignerSerializationManager sm = new XamlDesignerSerializationManager(xw);
                    sm.XamlWriterMode = XamlWriterMode.Expression;

                    XamlWriter.Save(document, sm);
                }
                sb.Replace("{}", "");
                return sb.ToString();
            }
        }


        /// <summary>
        /// name         : 오더 조회 함수
        /// desc         : 오더를 FlowDocument로 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-10-18
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private FlowDocument SearchOrderRecordFlowDocument(RecordList_INOUT record)
        {
            FlowDocument fdoc = null;

            HIS.MC.DM.OR.MN.UI.SelectFlowDocumentOrderListData popPage = new HIS.MC.DM.OR.MN.UI.SelectFlowDocumentOrderListData();
            //fdoc = popPage.CallOrderListDocument(record.WRITING_DATE, record.WRITING_DATE);

            // RecordList에서 환자번호 제공 받는 경우 추가
            if (string.IsNullOrEmpty(record.PT_NO))
            {
                record.PT_NO = PatientInformation.PT_NO;
            }
            // RecordList에서 수행사인포함여부 제공 받는 경우 추가
            if (!string.IsNullOrEmpty(record.ActingYN))
            {
                if (record.ActingYN == "Y")
                { ActingSign = true; }
                else
                { ActingSign = false; }
            }
            else
            {
                if (ActingSign == true)
                {
                    record.ActingYN = "Y";
                }
            }
            //fdoc = popPage.CallOrderListDocument(record.WRITING_DATE, record.WRITING_DATE, record.PT_NO, record.WRITING_DEPT_CD, record.PACT_TP_CD, ActingSign);
            fdoc = popPage.CallOrderListDocument(record.WRITING_DATE, record.WRITING_DATE, record.PT_NO, record.WRITING_DEPT_CD, record.PACT_TP_CD, ActingSign, IsIncludeOrderHistory);

            ///// 환자의 처방 정보 조회
            ///// <param name="startDate">검색시작일자</param>
            ///// <param name="endDate">검색종료일자</param>
            ///// <param name="patientNo">환자번호</param>
            ///// <param name="mdtCode">진료과코드</param>
            ///// <param name="patientTypeCode">환자구분코드</param>
            ///// <param name="bIncludeFmt">수행사인포함여부</param>
            ///// <returns></returns>
            //public FlowDocument CallOrderListDocument(DateTime startDate, DateTime endDate, string patientNo, string mdtCode, string patientTypeCode, bool bIncludeFmt);

            return fdoc;

        }

        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchGroupOrderRecordFlowDocument(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();
            //코드 인스펙션. 사용하지 않는 변수 주석. 정성호 수정 2013-11-18
            //FlowDocument fdoc = new FlowDocument();

            foreach (var record in records)
            {
                record.RecordFlowDocument = SearchOrderRecordFlowDocument(record);
                fDocList.Add(record);
            }

            return fDocList;
        }

        /// <summary>
        /// name         : 간호 조회 함수
        /// desc         : 간호기록을 FlowDocument로 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-10-18
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private FlowDocument SearchNursingRecordFlowDocument(RecordList_INOUT record)
        {
            FlowDocument fdoc = null;

            // RecordList에서 환자번호 제공 받는 경우 추가
            if (string.IsNullOrEmpty(record.PT_NO))
            {
                record.PT_NO = PatientInformation.PT_NO;
            }

            if (record.RECTYPE == "09")// record.ITEM_TYPE == "간호일지")
            {
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC") 
                //{
                //차세대 시작부터(as-is때부터)  "NPDCC"  빠져 있는 것으로 보임.  HSNP 추가하는 동시에 NPDCC도 같이 추가 해줌. (2020.08.06 김지은 간사 선생님 컨폼완료)

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                NursingDailyRecordGroupTemplate_OUT nursingDailyRecord;
                NursingDailyRecordTemplate_INOUT nursingDailyRecordInfo = new NursingDailyRecordTemplate_INOUT() { PT_NO = record.PT_NO, FROMDATE = record.WRITING_DATE, TODATE = record.WRITING_DATE, PACT_ID = record.PACT_ID, REC_IMG_AUTH_YN = imagePrintAuthority };

                nursingDailyRecord = (NursingDailyRecordGroupTemplate_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerBL", "SelectNursingDailyRecordInfo", nursingDailyRecordInfo, AskAuth);
                nursingDailyRecord.TEMPLATE = "NursingDailyRecordTemplate";
                fdoc = CreateDocument(nursingDailyRecord);
            }
            else if (record.RECTYPE == "03")//record.ITEM_TYPE == "간호활동수행기록")
            {
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)             

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                NursingActivityGroupTemplate_OUT nursingActivity;
                NursingActivityTemplate_INOUT nursingActivityInfo = new NursingActivityTemplate_INOUT() { PT_NO = record.PT_NO, INPT_DTM = record.WRITING_DATE };

                nursingActivity = (NursingActivityGroupTemplate_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordCommonViewerBL", "SelectNursingActivityInfo", nursingActivityInfo, AskAuth);
                nursingActivity.TEMPLATE = "NursingActivityTemplate";
                fdoc = CreateDocument(nursingActivity);
            }
            else if (record.RECTYPE == "08")//record.ITEM_TYPE == "수술전상태확인")
            {
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                PreoperativeNursingStatusGroupTemplate_OUT preoperativeNursingStatus;
                PreoperativeNursingStatusTemplate_INOUT preoperativeNursingStatusInfo = new PreoperativeNursingStatusTemplate_INOUT() { NREC_ID = record.KEY_ID, OP_DATE = record.WRITING_DATE, NR_ITEM_NM = record.ITEM_NM };

                preoperativeNursingStatus = (PreoperativeNursingStatusGroupTemplate_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerSecondBL", "SelectPreoperativeNursingStatus", preoperativeNursingStatusInfo, AskAuth);
                preoperativeNursingStatus.TEMPLATE = "PreoperativeNursingStatusTemplate";
                fdoc = CreateDocument(preoperativeNursingStatus);
            }
            else if (record.RECTYPE == "13")//record.ITEM_TYPE == "회복간호기록")
            {
                RecoveryNursingRecodeTemplate_INOUT recoveryNursingRecord;
                RecoveryNursingRecodeDetailTemplate_INOUT recoveryNursingRecordInfo = new RecoveryNursingRecodeDetailTemplate_INOUT() { NREC_ID = record.KEY_ID, PT_NO = record.PT_NO, UITM_DT = record.WRITING_DATE, PACT_ID = record.PACT_ID, CLCO_REC_WRT_PATH_TP_CD = record.KEY_ID, NRPR_DEPT_CD = UserInformation.PLWK_DEPT_CD };
                recoveryNursingRecord = (RecoveryNursingRecodeTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordCommonViewerBL", "SelectRecoveryNursingRecode", recoveryNursingRecordInfo);
                recoveryNursingRecord.TEMPLATE = "RecoveryNursingRecodeTemplate";
                fdoc = CreateDocument(recoveryNursingRecord);
            }
            else if (record.RECTYPE == "14")//혈액투석간호기록
            {
                HemodialysisRecordTemplate_INOUT hemodialysisRecord;
                HemodialysisRecordTemplate_INOUT hemodialysisRecordInfo = new HemodialysisRecordTemplate_INOUT() { PT_NO = record.PT_NO, PT_DLYS_SEQ = Convert.ToDecimal(record.KEY_ID), UITM_DT = record.WRITING_DATE, PACT_ID = record.PACT_ID, NRPR_DEPT_CD = UserInformation.PLWK_DEPT_CD };

                hemodialysisRecord = (HemodialysisRecordTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordCommonViewerBL", "SelectHemodialysisRecordDetail", hemodialysisRecordInfo);
                hemodialysisRecord.TEMPLATE = "HemodialysisRecordTemplate";
                fdoc = CreateDocument(hemodialysisRecord);
            }
            else if (record.RECTYPE == "15")//복막투석간호기록
            {
                HemodialysisRecordTemplate_INOUT hemodialysisRecord;
                HemodialysisRecordTemplate_INOUT hemodialysisRecordInfo = new HemodialysisRecordTemplate_INOUT() { PT_NO = record.PT_NO, PT_DLYS_SEQ = Convert.ToDecimal(record.KEY_ID), UITM_DT = record.WRITING_DATE, PACT_ID = record.PACT_ID, NRPR_DEPT_CD = UserInformation.PLWK_DEPT_CD };

                hemodialysisRecord = (HemodialysisRecordTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordCommonViewerBL", "SelectPeritonealDialysisRecordDetail", hemodialysisRecordInfo);
                hemodialysisRecord.TEMPLATE = "PeritonealDialysisRecordTemplate";
                fdoc = CreateDocument(hemodialysisRecord);
            }
            else if (record.RECTYPE == "01" || record.RECTYPE == "07" || record.RECTYPE == "04")//초기간호정보, 퇴실간호기록, 가정간호경과기록
            {
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if ((record.RECTYPE == "01") && (record.ITEM_NM == "정신과"))
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                InitialNursingRecodeInfoTemplate_INOUT initialNursingRecord;
                InitialNursingRecodeDetailTemplate_INOUT initialNursingRecordInfo = new InitialNursingRecodeDetailTemplate_INOUT() { ITEM_TYPE = record.ITEM_TYPE, ITEM_NM = record.ITEM_NM, NREC_ID = record.KEY_ID, REC_IMG_AUTH_YN = imagePrintAuthority };

                initialNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerBL", "SelectInitialNursingRecodeDetail", initialNursingRecordInfo, AskAuth);
                initialNursingRecord.TEMPLATE = "InitialNursingRecodeTemplate";
                fdoc = CreateDocument(initialNursingRecord);
            }
            else if (record.RECTYPE == "11")//수술간호기록
            {
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                OperationNursingRecordInfoTemplate_INOUT operationNursingRecord;
                OperationNursingRecordInfoTemplate_INOUT operationNursingRecordInfo = new OperationNursingRecordInfoTemplate_INOUT() { OP_EXPT_REG_ID = record.KEY_ID, WRK_DT = record.WRITING_DATE };

                operationNursingRecord = (OperationNursingRecordInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerSecondBL", "SelectOperationNursingRecord", operationNursingRecordInfo, AskAuth);
                operationNursingRecord.TEMPLATE = "OpNursingRecodeTemplate";
                fdoc = CreateDocument(operationNursingRecord);
            }
            else if (record.RECTYPE == "05")//전과전동기록
            {
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                InitialNursingRecodeInfoTemplate_INOUT transferNursingRecord;
                InitialNursingRecodeDetailTemplate_INOUT transferNursingRecordInfo = new InitialNursingRecodeDetailTemplate_INOUT() { NREC_ID = record.KEY_ID, REC_IMG_AUTH_YN = imagePrintAuthority };

                transferNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerSecondBL", "SelectTransferNursingRecord", transferNursingRecordInfo, AskAuth);
                transferNursingRecord.TEMPLATE = "TransferWardNursingRecodeTemplate";
                fdoc = CreateDocument(transferNursingRecord);
            }
            else if (record.RECTYPE == "06")//퇴원간호기록
            {
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC")
                //{
                //차세대 시작부터(as-is때부터)  "NPDCC"  빠져 있는 것으로 보임.  HSNP 추가하는 동시에 NPDCC도 같이 추가 해줌. (2020.08.06 김지은 간사 선생님 컨폼완료)

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);


                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                InitialNursingRecodeInfoTemplate_INOUT dischargeNursingRecord;
                InitialNursingRecodeDetailTemplate_INOUT dischargeNursingRecordInfo = new InitialNursingRecodeDetailTemplate_INOUT() { NREC_ID = record.KEY_ID, WRT_DT = String.Format("{0:yyyy-MM-dd}", record.WRITING_DATE), REC_IMG_AUTH_YN = imagePrintAuthority };

                dischargeNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerSecondBL", "SelectDischargeNursingRecord", dischargeNursingRecordInfo, AskAuth);
                dischargeNursingRecord.TEMPLATE = "DischargeNursingRecodeTemplate";
                fdoc = CreateDocument(dischargeNursingRecord);
            }
            else if (record.RECTYPE == "16" || record.RECTYPE == "17")//중환자 Assess(16), NICU Assess(17)
            {
                InitialNursingRecodeInfoTemplate_INOUT accessNursingRecord;
                AssessmentNursingRecordTemplate_IN accessNursingRecordInfo = new AssessmentNursingRecordTemplate_IN() { PT_NO = record.PT_NO, WRK_DT = record.WRITING_DATE, RECTYPE = record.RECTYPE };

                accessNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerBL", "SelectAssessmentNursingRecord", accessNursingRecordInfo);
                accessNursingRecord.TEMPLATE = "InitialNursingRecodeTemplate";
                fdoc = CreateDocument(accessNursingRecord);
            }
            else if (record.RECTYPE == "02")//임상관찰기록
            {
                ClinicalObservationRecodeTemplate_INOUT clinicalObservationRecord;
                ClinicalObservationRecodeTemplate_INOUT clinicalObservationRecordInfo = new ClinicalObservationRecodeTemplate_INOUT() { PT_NO = record.PT_NO, UITM_DT = record.WRITING_DATE, PACT_ID = record.PACT_ID, CLCO_REC_WRT_PATH_TP_CD = record.KEY_ID, NRPR_DEPT_CD = UserInformation.PLWK_DEPT_CD };

                clinicalObservationRecord = (ClinicalObservationRecodeTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerBL", "SelectClinicalObservationRecode", clinicalObservationRecordInfo);
                clinicalObservationRecord.TEMPLATE = "ClinicalObservationTemplate";
                fdoc = CreateDocument(clinicalObservationRecord);
            }
            else if (record.RECTYPE == "12")//시술전기록
            {
                PreoperativeNursingStatusGroupTemplate_OUT administrationOfMedicionStatus;
                PreoperativeNursingStatusTemplate_INOUT administrationOfMedicionStatusInfo = new PreoperativeNursingStatusTemplate_INOUT() { NREC_ID = record.KEY_ID };

                administrationOfMedicionStatus = (PreoperativeNursingStatusGroupTemplate_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerSecondBL", "SelectAdministrationOfMedicion", administrationOfMedicionStatusInfo);
                administrationOfMedicionStatus.TEMPLATE = "AdministrationOfMedicionTemplate";
                fdoc = CreateDocument(administrationOfMedicionStatus);
            }
            else if (record.RECTYPE == "18")//가정간호종결
            {
                InitialNursingRecodeInfoTemplate_INOUT homeNursingEndNursingRecord;
                InitialNursingRecodeDetailTemplate_INOUT homeNursingEndNursingRecordInfo = new InitialNursingRecodeDetailTemplate_INOUT() { NREC_ID = record.KEY_ID, PT_NO = record.PT_NO, VIST_SEQ = record.PRINT_SEQ, REC_IMG_AUTH_YN = imagePrintAuthority };

                homeNursingEndNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerHomeNursingBL", "SelectHomeNursingEndNursingRecord", homeNursingEndNursingRecordInfo);
                homeNursingEndNursingRecord.TEMPLATE = "HomeNursingRecodeTemplate";
                fdoc = CreateDocument(homeNursingEndNursingRecord);
            }
            else if (record.RECTYPE == "19")//가정간호의뢰
            {
                InitialNursingRecodeInfoTemplate_INOUT homeNursingReferNursingRecord;
                InitialNursingRecodeDetailTemplate_INOUT homeNursingReferNursingRecordInfo = new InitialNursingRecodeDetailTemplate_INOUT() { NREC_ID = record.KEY_ID, PT_NO = record.PT_NO, REC_IMG_AUTH_YN = imagePrintAuthority };

                homeNursingReferNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerHomeNursingBL", "SelectHomeNursingReferNursingRecord", homeNursingReferNursingRecordInfo);
                homeNursingReferNursingRecord.TEMPLATE = "HomeNursingRecodeTemplate";
                fdoc = CreateDocument(homeNursingReferNursingRecord);
            }
            else if (record.RECTYPE == "20")//낙상위험도평가
            {   //\\hisdevimg\MdrecVwrTmplFile\Templates 
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }
                InitialNursingRecodeInfoTemplate_INOUT homeNursingReferNursingRecord;
                FallNursingRecodeDetailTemplate_INOUT fallNursingRecordInfo = new FallNursingRecodeDetailTemplate_INOUT() { PT_NO = record.PT_NO, INPT_DTM = record.WRITING_DATE };

                homeNursingReferNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerHomeNursingBL", "SelectFallNursingRecord", fallNursingRecordInfo, AskAuth);
                homeNursingReferNursingRecord.TEMPLATE = "SetNursingRecodeTemplate";
                fdoc = CreateDocument(homeNursingReferNursingRecord);
            }
            else if (record.RECTYPE == "21")//욕창위험도평가
            {   //\\hisdevimg\MdrecVwrTmplFile\Templates 
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }
                InitialNursingRecodeInfoTemplate_INOUT homeNursingReferNursingRecord;
                FallNursingRecodeDetailTemplate_INOUT bedsoreNursingRecordInfo = new FallNursingRecodeDetailTemplate_INOUT() { PT_NO = record.PT_NO, INPT_DTM = record.WRITING_DATE };

                homeNursingReferNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerHomeNursingBL", "SelectBedSoreNursingRecord", bedsoreNursingRecordInfo, AskAuth);
                homeNursingReferNursingRecord.TEMPLATE = "SetNursingRecodeTemplate";
                fdoc = CreateDocument(homeNursingReferNursingRecord);
            }
            else if (record.RECTYPE == "22")//정신과환자평가
            {   //\\hisdevimg\MdrecVwrTmplFile\Templates

                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }

                InitialNursingRecodeInfoTemplate_INOUT homeNursingReferNursingRecord;
                InitialNursingRecodeDetailTemplate_INOUT NursingRecordInfo = new InitialNursingRecodeDetailTemplate_INOUT() { PT_NO = record.PT_NO, WRT_DT = String.Format("{0:yyyy-MM-dd}", record.WRITING_DATE), NREC_ID = record.KEY_ID, REC_IMG_AUTH_YN = imagePrintAuthority };

                homeNursingReferNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerHomeNursingBL", "SelectPsychiatryNursingRecord", NursingRecordInfo, AskAuth);
                homeNursingReferNursingRecord.TEMPLATE = "SetNursingRecodeTemplate";
                fdoc = CreateDocument(homeNursingReferNursingRecord);
            }
            else if (record.RECTYPE == "23")//욕창간호기록 
            {   //\\hisdevimg\MdrecVwrTmplFile\Templates 
                bool AskAuth = true; //조회 권한(정신과 유무를 체크)

                string CheckMange = "N"; //조회 권한(정신과 권한 중 운영직은 제외)

                //20200811 공통코드로 관리하기 위함. 기존조건 주석처리
                //if (record.WRITING_DEPT_CD == "NP" || record.WRITING_DEPT_CD == "CHP" || record.WRITING_DEPT_CD == "EQLC" || record.WRITING_DEPT_CD == "NPDCC")
                //{

                //20200811 공통코드로 관리하기 위함. 정신과 부서가 맞는지 체크 
                string sReadingYn = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().PsychiatryReadingCondition(record.WRITING_DEPT_CD, null);

                //2016-11-06 정신과 권한 체크 후, 화면 보이게 하는 체크.
                if (sReadingYn == "Y")
                {
                    if (UsrAuthInfo.NPREC_READ_YN == "Y")
                    {
                        //2016-12-13 정신과 권한 중 운영직은 제외
                        CheckMange = SelectPsychiatryManageAuthCheck();

                        if (CheckMange == "N")
                        {
                            AskAuth = true;
                        }
                        else
                        {
                            AskAuth = false;
                        }
                    }
                    else
                    {
                        AskAuth = false;
                    }
                }
                InitialNursingRecodeInfoTemplate_INOUT BedsoreOccurrenceNursingRecord;
                InitialNursingRecodeDetailTemplate_INOUT BedsoreOccurrenceNursingRecordInfo = new InitialNursingRecodeDetailTemplate_INOUT() { PT_NO = record.PT_NO, WRT_DT = String.Format("{0:yyyy-MM-dd}", record.WRITING_DATE), REC_IMG_AUTH_YN = imagePrintAuthority };

                BedsoreOccurrenceNursingRecord = (InitialNursingRecodeInfoTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerHomeNursingBL", "SelectBedsoreOccurrenceNursingRecord", BedsoreOccurrenceNursingRecordInfo, AskAuth);
                BedsoreOccurrenceNursingRecord.TEMPLATE = "SetNursingRecodeTemplate";
                fdoc = CreateDocument(BedsoreOccurrenceNursingRecord);
            }
            else
            {

            }

            return fdoc;
        }

        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchGroupNursingRecordFlowDocument(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();
            //코드 인스펙션. 사용하지 않는 변수 주석. 정성호 수정 2013-11-18
            //FlowDocument fdoc = new FlowDocument();

            foreach (var record in records)
            {
                record.RecordFlowDocument = SearchNursingRecordFlowDocument(record);
                fDocList.Add(record);
            }

            return fDocList;
        }

        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchGroupExamFlowDocument(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();
            //코드 인스펙션. 사용하지 않는 변수 주석. 정성호 수정 2013-11-18
            //FlowDocument fdoc = new FlowDocument();

            PictureExamTemplate_OUT pictureExam_dto = new PictureExamTemplate_OUT();//영상검사
            FuncExamTemplate_OUT funcExam_dto = new FuncExamTemplate_OUT();//기능검사
            SpecimenExamTemplate_OUT specimenExam_dto = new SpecimenExamTemplate_OUT();//검체검사
            //PathologyExamTemplate_OUT pathologyExam_dto = new PathologyExamTemplate_OUT();//병리검사
            HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT> pathologyExamList = new HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT>();//병리검사

            HSFDTOCollectionBaseObject<PictureExamTemplate_OUT> pictureExamResultList = new HSFDTOCollectionBaseObject<PictureExamTemplate_OUT>();//영상검사결과
            HSFDTOCollectionBaseObject<FuncExamTemplate_OUT> funcExamResultList = new HSFDTOCollectionBaseObject<FuncExamTemplate_OUT>();//기능검사결과
            HSFDTOCollectionBaseObject<SpecimenExamTemplate_OUT> specimenExamResultList = new HSFDTOCollectionBaseObject<SpecimenExamTemplate_OUT>();//검체검사결과
            HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT> pathologyExamResultList = new HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT>();//병리검사결과


            // 검사별 DTO 조회작업 
            foreach (RecordList_INOUT item in records)
            {
                // RecordList에서 환자번호 제공 받는 경우 추가
                if (string.IsNullOrEmpty(item.PT_NO))
                {
                    item.PT_NO = PatientInformation.PT_NO;
                }

                if (item.ITEM_TYPE == "영상검사")
                {
                    if (pictureExam_dto.IPTN_NO == null)
                        pictureExam_dto.IPTN_NO = item.EXAM_KEY;
                    else
                        pictureExam_dto.IPTN_NO = pictureExam_dto.IPTN_NO + "," + item.EXAM_KEY;
                }
                else if (item.ITEM_TYPE == "기능검사")
                {
                    funcExam_dto.KEY = item.EXAM_KEY;
                    funcExamResultList.Add(SelectFuncExamResultFlowDocument(funcExam_dto));
                }
                else if (item.ITEM_TYPE == "검체검사")
                {
                    specimenExam_dto.IN_PT_NO = item.PT_NO;

                    //검체 한글명 병기 여부
                    if (SpcmKorInscrChecked)
                        specimenExam_dto.SPCM_KOR_INSCR_YN = "Y";

                    if (specimenExam_dto.SPCM_NO == null)
                        specimenExam_dto.SPCM_NO = item.KEY_ID + item.EXAM_KEY;
                    else
                        specimenExam_dto.SPCM_NO = specimenExam_dto.SPCM_NO + "," + item.KEY_ID + item.EXAM_KEY;
                }
                else if (item.ITEM_TYPE == "병리검사")
                {
                    PathologyExamTemplate_OUT pathologyItem = new PathologyExamTemplate_OUT();

                    pathologyItem.SPCM_PTHL_KEY = item.EXAM_KEY;

                    pathologyExamList.Add(pathologyItem);
                }
            }

            // 검사별 DTO 조회
            if (pictureExam_dto.IPTN_NO != null)
            {
                if (EngAskChecked) //영문조회
                    pictureExamResultList = (HSFDTOCollectionBaseObject<PictureExamTemplate_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectPictureExaminationResult_Eng", pictureExam_dto);
                else
                    pictureExamResultList = (HSFDTOCollectionBaseObject<PictureExamTemplate_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectPictureExaminationResult", pictureExam_dto);
            }
            if (specimenExam_dto.SPCM_NO != null)
            {
                if (EngAskChecked) //영문조회
                    specimenExamResultList = (HSFDTOCollectionBaseObject<SpecimenExamTemplate_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MS.LM.COMM.BIZ.SelectMRViewerExamBL", "SelecSpecimenExamView_Eng", specimenExam_dto);
                else
                    specimenExamResultList = (HSFDTOCollectionBaseObject<SpecimenExamTemplate_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MS.LM.COMM.BIZ.SelectMRViewerExamBL", "SelecSpecimenExamView", specimenExam_dto);
            }

            // 결과조회
            foreach (var record in records)
            {
                if (record.ITEM_TYPE == "영상검사")
                {
                    foreach (PictureExamTemplate_OUT pictureExamResult in pictureExamResultList)
                    {
                        if (record.EXAM_KEY == pictureExamResult.IPTN_NO)
                        {
                            record.RecordFlowDocument = CreateDocument(pictureExamResult);
                            fDocList.Add(record);
                        }
                    }
                }
                else if (record.ITEM_TYPE == "기능검사")
                {
                    foreach (FuncExamTemplate_OUT funcExamResult in funcExamResultList)
                    {
                        if (record.EXAM_KEY == funcExamResult.KEY)
                        {
                            record.RecordFlowDocument = CreateDocument(funcExamResult);
                            fDocList.Add(record);
                        }
                    }
                }
                else if (record.ITEM_TYPE == "검체검사")
                {
                    foreach (SpecimenExamTemplate_OUT specimenExamResult in specimenExamResultList)
                    {
                        if (record.KEY_ID + record.EXAM_KEY == specimenExamResult.EXM_CTG_CD + specimenExamResult.SPCM_NO) //검체번호로 비교
                        {
                            record.RecordFlowDocument = CreateDocument(specimenExamResult);
                            record.RecordFlowDocumentList.Add(record.RecordFlowDocument);
                            fDocList.Add(record); // 검체검사는 key 하나에 여럿이 조회되는 경우가 있음. 
                        }
                    }
                }
                else if (record.ITEM_TYPE == "병리검사")
                {
                    foreach (PathologyExamTemplate_OUT pathologyExamResult in pathologyExamList)
                    {
                        if (record.EXAM_KEY == pathologyExamResult.SPCM_PTHL_KEY)
                        {
                            record.RecordFlowDocument = PMCommon.SelectResultTextForPreview(pathologyExamResult.SPCM_PTHL_KEY, true, EngAskChecked, "B");

                            fDocList.Add(record);
                        }
                    }
                }
            }

            return fDocList;
        }

        /// <summary>
        /// name         : 기능검사 조회 함수
        /// desc         : 기능검사결과를 FlowDocument로 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2013-01-15
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private FuncExamTemplate_OUT SelectFuncExamResultFlowDocument(FuncExamTemplate_OUT record)
        {

            FuncExamTemplate_OUT funcExam_dto = (FuncExamTemplate_OUT)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectFuncExam", record);
            funcExam_dto.TEMPLATE = "FuncExamTemplate";
            funcExam_dto.FORM_NM = "CanvasSection";

            HSFDTOCollectionBaseObject<FuncExamImageTemplate_OUT> funcExamImages = new HSFDTOCollectionBaseObject<FuncExamImageTemplate_OUT>();

            if (funcExam_dto.FUNCEXAMIMAGETEMPLATE_OUT != null)
            {
                foreach (FuncExamImageTemplate_OUT image in funcExam_dto.FUNCEXAMIMAGETEMPLATE_OUT)
                {
                    image.IMGURL = HIS.UI.Core.ConfigManager.CC.FileServerUrl + image.IMGURL;
                    funcExamImages.Add(image);
                }



                //2021.02 pdf로직 반영하려면 위 foreach 주석처리! 밑 foreach로 진행!
                /*
                foreach (FuncExamImageTemplate_OUT image in funcExam_dto.FUNCEXAMIMAGETEMPLATE_OUT)
                {
                    //pdf추가 작업으로 원래 로직 주석처리 2021.01
                    //image.IMGURL = HIS.UI.Core.ConfigManager.CC.FileServerUrl + image.IMGURL;


                    //PDF 이미지 처리 2021.01
                    var pdfyn = GetFileNmIncludeExtension(image.IMGURL);

                    if (pdfyn.Substring(pdfyn.LastIndexOf('.') + 1).ToUpper() == "PDF")
                    {
                        image.IMGURL = HIS.UI.Core.ConfigManager.CC.IntgSvrUrl + "webservice/CM/ConverterService/ReqeustPDFConvertToJPG.ashx?path=" + HIS.UI.Core.ConfigManager.CC.FileServerUrl + image.IMGURL;

                        //테스트
                        //image.IMGURL = "http://hisdevweb.snuh.org/webservice/CM/ConverterService/ReqeustPDFConvertToJPG.ashx?path=http://hisdevimg.snuh.org//INTERFACE01/DEVICE/20190911/7/67/072/21/INF/20191002094937_76707221_1.pdf";     
                        //image.IMGURL = "http://hisdevimg.snuh.org//INTERFACE01/DEVICE/20190911/7/67/072/21/INF/20191002094937_76707221_1.pdf";
                    }
                    else
                    {
                        image.IMGURL = HIS.UI.Core.ConfigManager.CC.FileServerUrl + image.IMGURL;
                    }


                    funcExamImages.Add(image);
                }
                */



                funcExam_dto.FUNCEXAMIMAGETEMPLATE_OUT = funcExamImages;
            }

            return funcExam_dto;
        }

        /// <summary>
        /// name         : 검체검사 조회 함수
        /// desc         : 검체검사결과를 FlowDocument로 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2013-01-08
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private FlowDocument SearchSpecimenExaminationResultFlowDocument(RecordList_INOUT record)
        {
            FlowDocument fdoc = null;

            SpecimenExamTemplate_OUT specimenExamResultList = (SpecimenExamTemplate_OUT)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectSpecimenExaminationResult", record);

            specimenExamResultList.TEMPLATE = "SpecimenTableExamTemplate";
            fdoc = CreateDocument(specimenExamResultList);

            return fdoc;

        }

        public string SetUrlCharEncode(String sParam)
        {
            sParam = sParam.Replace("%", "%25");
            sParam = sParam.Replace("&", "%26");
            sParam = sParam.Replace("+", "%2B");
            sParam = sParam.Replace("=", "%3D");
            sParam = sParam.Replace("?", "%3F");
            sParam = sParam.Replace("#", "%23");
            return sParam;
        }

        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchGroupScanFlowDocument(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();
            //코드 인스펙션. 사용하지 않는 변수 주석. 정성호 수정 2013-11-18
            //FlowDocument fdoc = new FlowDocument();
            ScanImageTemplate_OUT scanImage_dto = new ScanImageTemplate_OUT();//스캔자료

            foreach (var record in records)
            {
                scanImage_dto.URL = HIS.UI.Core.ConfigManager.CC.FileServerUrl + record.EXAM_KEY;
                //scanImage_dto.URL = "http://172.17.6.1" + record.EXAM_KEY;
                scanImage_dto.TEMPLATE = "ScanImageTemplate";

                record.RecordFlowDocument = CreateDocument(scanImage_dto);

                fDocList.Add(record);
            }

            return fDocList;
        }

        /// <summary>
        /// name         : 진단서 출력이력 엑셀내보내기 함수
        /// desc         : 진단서 출력이력 을 엑셀로 내보냅니다.
        /// author       : 김정훈 
        /// create date  : 2012-11-26
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void GetPrintListToExcel()
        {
            // hdatagridex

            //엑셀 다운로드 사유 로그 적용 20220713
            if (thisUserControl.dgrdDiagnosisCertificatePrintList == null)
            {
                return;
            }

            // 엑셀 다운로드 사유입력 호출
            var excelDownloadLog = new DownloadPrint_IN()
            {
                MenuID = "DR_HIS.MC.DR.RM.RV.UI_/SelectIntegrationMedicalRecordAsk.xaml",
                MenuName = "의무기록뷰어_진단서출력리스트",
                Data = "",
                ExportType = DownloadPrint_IN.DownloadPrintType.Excel
            };

            if (!LoggingReasonHelper.InsertDownloadPrintLog(excelDownloadLog))
            {
                return;
            }

            HDataGridExExtension.ToExcel(thisUserControl.dgrdDiagnosisCertificatePrintList, "진단서출력목록", "진단서출력목록", true, false);
            // dto
            //if (TermList == null) return;
            //TermList.ToExcel("진료용어목록", "진료용어목록", true);

        }

        /// <summary>
        /// name         : 기록유형선택 함수
        /// desc         : 기록유형을 선택합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-22
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SelectRecordType(object p)
        {
            if (p == null)
            { return; }

            Code_RecordDetail_Type.Clear();

            foreach (CCCCCSTE_INOUT item in SelectedRecordTypeList)
            {
                if (item.COMN_CD == "DR")
                {
                    Code_DoctorRecord_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                }
                else if (item.COMN_CD == "NR")
                {
                    Code_NursingRecord_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                }
                else if (item.COMN_CD == "EX")
                {
                    Code_EXam_Type.ToList().ForEach(i => Code_RecordDetail_Type.Add(i));
                }
                else if (item.COMN_CD == "SC")
                {
                    Code_SCan_Type.ToList().ForEach(I => Code_RecordDetail_Type.Add(I));
                }
            }

            Code_RecordDetail_Type.ToList().ForEach(i => SelectedRecordDetailTypeList.Add(i));

        }

        /// <summary>
        /// name         : 기록상세유형선택 함수
        /// desc         : 기록상세유형을 선택합니다.
        /// author       : 김정훈 
        /// create date  : 2012-09-25
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SelectRecordDetailType(object p)
        {
            if (p == null)
            { return; }

            CCCCCSTE_INOUT selectedRecordType = p as CCCCCSTE_INOUT;

            if (SelectedRecordTypeList.Contains(selectedRecordType))
                return;
            else
                SelectedRecordTypeList.Add(selectedRecordType);
        }

        /// <summary>
        /// name         : 기록유형선택제외 함수
        /// desc         : 기록유형을 선택에서 제외합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-22
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void RemoveSelectedRecordType(object p)
        {
            if (p == null)
            { return; }

            CCCCCSTE_INOUT selectedRecordType = p as CCCCCSTE_INOUT;
            SelectedRecordTypeList.Remove(selectedRecordType);
        }

        /// <summary>
        /// name         : 간호기록유형 선택 함수
        /// desc         : 간호기록유형을 선택합니다.
        /// author       : 김정훈 
        /// create date  : 2012-07-23
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SelectNursingRecordType(object p)
        {
            if (p == null)
            { return; }

            //CCCCCSTE_INOUT selectedNursingRecordType = p as CCCCCSTE_INOUT;

        }

        /// <summary>
        /// name         : 원본 서식조회 팝업(임시)
        /// desc         : 원본 서식조회 팝업을 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-11-27
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void OriginalRecordOpenPopup()
        {
            if (this.IsOpenPopup)
                this.IsOpenPopup = false;
            else
            {
                SearchDoctorRecordFlowDocument(SelectedRecordListDR[0]);
                this.IsOpenPopup = true;
            }
        }

        /// <summary>
        /// name         : 원본 서식조회 팝업(임시)
        /// desc         : 원본 서식조회 팝업을 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-11-27
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void DiagnosisOriginalRecordOpenPopup(object p)
        {

            RecordList_INOUT selectedDiagnosisRecord = p as RecordList_INOUT;

            PopUpBase pop = new PopUpBase();
            pop.Content = HIS.UI.Core.AssemblyLoader.LoadComponent("HIS.MC.DR.RM.CL.UI", "DiagnosisCertificateConvertToFlowDocTest", selectedDiagnosisRecord.MDRC_ID);
            pop.ShowDialog();
            pop.ShowInTaskbar = false;
        }

        /// <summary>
        /// name         : 뷰모드 세팅 함수
        /// desc         : 뷰모드를 설정합니다.
        /// author       : 김정훈 
        /// create date  : 2012-12-27
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public void SetViewMode()
        {
            WindowWidth = 1280;

            if (WindowMode == null)
            {
                WindowMode = "Max";
            }

            if (WindowMode == "Max")
            {
                FlowDocumentViewMode = "TwoPage"; // Scroll, Page, TwoPage
            }
            else
            {
                if (FlowDocumentViewMode == null)
                {
                    FlowDocumentViewMode = "Scroll"; // Scroll, Page, TwoPage
                }
            }
        }

        /// <summary>
        /// name         : 뷰모드 변경 함수
        /// desc         : 뷰모드를 변경합니다.
        /// author       : 김정훈 
        /// create date  : 2012-12-21
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public void ChangeViewMode()
        {
            if (thisUserControl.flowDocViewer.ViewingMode.ToString() == "TwoPage")
            {
                if (!Global.SessionManager.HasXBAP)
                {
                    thisUserControl.OwnerWindow.Width = WindowWidth + 610;
                }
                WindowMode = "Max";
                FlowDocumentViewMode = "TwoPage";
            }
            else
            {
                if (!Global.SessionManager.HasXBAP)
                {
                    thisUserControl.OwnerWindow.Width = WindowWidth;
                }
                WindowMode = "Min";
                FlowDocumentViewMode = thisUserControl.flowDocViewer.ViewingMode.ToString();
            }
        }

        /// <summary>
        /// name         : 출력 미리보기 함수
        /// desc         : 출력 미리보기 화면을 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-11-27
        /// update date  : 수정일자, 수정자, 수정개요
        ///                2015-11-26 광파일 서버 By Pass 작업
        /// </summary>
        private void PreviewPrintingOpenPopup(String PrintingOption = "Basic")
        {
            HIS.UI.Base.Unmanaged.NativeMethods.SetProcessWorkingSetSize(System.Diagnostics.Process.GetCurrentProcess().Handle, -1, -1);

            GC.Collect();
            GC.WaitForPendingFinalizers();
            GC.Collect();

            #region 광파일 서버 By Pass 작업

            MessageBoxResult msgResult;

            // 광파일 서버 장애 상황
            if (HIS.UI.Core.CommonServiceAgent.GetMultimediaServerStatus() == "N")
            {
                // 원무팀, 응급실 재증명 발급 창구
                if (SessionManager.UserInfo.AADP_CD == "PAC" || SessionManager.UserInfo.AADP_CD == "EM")
                {
                    MsgBox.Display("CMMCN_000003", MessageType.MSG_TYPE_ERROR);
                    return;
                }
                else
                {
                    // CMMCN_000092 : 파일서버에 문제가 발생하여 병원직인, 의사 서명이미지 및 첨부된 이미지 파일이 출력되지 않습니다. 출력하시겠습니까? (Yes/No)
                    msgResult = MsgBox.Display("CMMCN_000092", MessageType.MSG_TYPE_EXCLAMATION, null, true, MessageBoxButton.YesNo);

                    if (msgResult != MessageBoxResult.Yes)
                    {
                        return;
                    }
                }
            }

            #endregion

            if (thisUserControl.flowDocViewer.Document == null)
            {
                MsgBox.Display("유동 문서가 없습니다.", MessageType.MSG_TYPE_EXCLAMATION, "유동문서 확인");
                return;
            }
            //HIS.MC.Core.Common.TextLogWriter lw = new HIS.MC.Core.Common.TextLogWriter(@"D:\LOG\SelectIntegrationMedicalRecordAsk.txt");
            //lw.AddWithTime("11. PreviewPrintingOpenPopup 시작");

            //1. 출력로그 저장
            if (!SavePrintLog())
                return; //사유가 선택되지 않으면 출력하지 않는다.           

            //2. 미리보기 출력창 
            int iPrint = 0;
            // 출력미리보기에서 사용할 환자정보 세팅
            HSF.Report.UI.PatientInfoToPrint info = new HSF.Report.UI.PatientInfoToPrint(
                PatientInformation.PT_NO, PatientInformation.PT_NM, PatientInformation.SEX, PatientInformation.AGE, UserInformation.STF_NM, !EngAskChecked);

            if (PrintingOption == "Basic")
            {
                HSF.Report.UI.Preview.ShowPreview(thisUserControl.flowDocViewer.Document, info, HSF.Report.Entities.TemplateCategory.Auth); // 출력권한 출력문구

            }
            else if (PrintingOption == "Direct")
            {
                HSF.Report.UI.Preview.DirectPrint(thisUserControl.flowDocViewer.Document, info, out iPrint, HSF.Report.Entities.TemplateCategory.Auth);//출력권한                
            }
            IPrintCount = iPrint;

            HIS.UI.Base.Unmanaged.NativeMethods.SetProcessWorkingSetSize(System.Diagnostics.Process.GetCurrentProcess().Handle, -1, -1);

            GC.Collect();
            GC.WaitForPendingFinalizers();
            GC.Collect();
        }

        /// <summary>
        /// name         : 출력로그 저장
        /// desc         : 출력로그를 저장합니다.
        /// author       : 강성희
        /// create date  : 2016-07-27
        /// update date  : 수정일자, 수정자, 수정개요        
        /// </summary>
        public bool SavePrintLog()
        {
            HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT> print_in = new HSFDTOCollectionBaseObject<PrintingLogInformation_INOUT>();
            string PRNT_HIS_PRGM_TP_CD = "VIEW_HIS";
            if (thisUserControl.tctlSearchRecordList.SelectedIndex == 2) //기록이력조회tab
            {
                foreach (PrintRecordList_INOUT PrintedRecord in PrintedRecordList)
                {
                    PrintingLogInformation_INOUT print = new PrintingLogInformation_INOUT()
                    {
                        PRNT_STF_NO = SessionManager.UserInfo.STF_NO, //직원번호
                        PRNT_STF_MED_DEPT_CD = SessionManager.UserInfo.AOA_WKDP_CD, //직원소속진료과
                        PRNT_PT_TP_CD = PrintedRecord.PACT_TP_CD, //출력환자구분코드
                        PT_NO = PatientInformation.PT_NO, //환자번호
                        PT_HME_DEPT_CD = PrintedRecord.PT_MED_DEPT_CD, //환자수진부서코드
                        PACT_ID = PrintedRecord.PACT_ID, //원무접수ID
                        PRNT_TP_CD = "2", //출력구분코드                     
                        PRNT_REC_LCLS_CD = PrintedRecord.RECORD_TYPE, //출력기록대분류코드
                        PRNT_REC_SCLS_CD = PrintedRecord.RECORD_DETAIL_TYPE, //출력기록소분류코드           
                        PRNT_HIS_PRGM_TP_CD = PRNT_HIS_PRGM_TP_CD, //출력프로그램코드(PRTLG001 : 의무기록뷰어)
                        RCDC_KND_NM = PrintedRecord.ITEM_NM, //기록지 종류명
                        MDRC_ID = PrintedRecord.MDRC_ID.ToString(), //진료기록ID
                        MDRC_FOM_SEQ = PrintedRecord.MDRC_FOM_SEQ.ToString(), //진료기록개정순번
                        PRNT_PRD_STR_DT = SearchCondition.SEARCH_FROM_DATE, //출력기간시작일자
                        PRNT_PRD_END_DT = SearchCondition.SEARCH_TO_DATE, //출력기간종료일자
                        WRT_DTM = PrintedRecord.WRITING_DATE //작성일시
                    };

                    print_in.Add(print);
                }
            }
            else
            {
                foreach (PrintRecordList_INOUT PrintedRecord in PrintedRecordList)
                {
                    PrintingLogInformation_INOUT print = new PrintingLogInformation_INOUT()
                    {
                        PRNT_STF_NO = SessionManager.UserInfo.STF_NO, //직원번호
                        PRNT_STF_MED_DEPT_CD = SessionManager.UserInfo.AOA_WKDP_CD, //직원소속진료과
                        PRNT_PT_TP_CD = PrintedRecord.PACT_TP_CD, //출력환자구분코드
                        PT_NO = PatientInformation.PT_NO, //환자번호
                        PT_HME_DEPT_CD = PrintedRecord.PT_MED_DEPT_CD, //환자수진부서코드
                        PACT_ID = PrintedRecord.PACT_ID, //원무접수ID
                        PRNT_TP_CD = "2", //출력구분코드                     
                        PRNT_REC_LCLS_CD = PrintedRecord.RECORD_TYPE, //출력기록대분류코드
                        PRNT_REC_SCLS_CD = PrintedRecord.RECORD_DETAIL_TYPE, //출력기록소분류코드           
                        PRNT_HIS_PRGM_TP_CD = "PRTLG001", //출력프로그램코드(PRTLG001 : 의무기록뷰어)
                        RCDC_KND_NM = PrintedRecord.ITEM_NM, //기록지 종류명
                        MDRC_ID = PrintedRecord.MDRC_ID.ToString(), //진료기록ID
                        MDRC_FOM_SEQ = PrintedRecord.MDRC_FOM_SEQ.ToString(), //진료기록개정순번
                        PRNT_PRD_STR_DT = SearchCondition.SEARCH_FROM_DATE, //출력기간시작일자
                        PRNT_PRD_END_DT = SearchCondition.SEARCH_TO_DATE, //출력기간종료일자
                        WRT_DTM = PrintedRecord.WRITING_DATE //작성일시
                    };

                    print_in.Add(print);
                }
            }

            PrintingLogManagement prntObj = new PrintingLogManagement();

            PrintingLogInformation_INOUT result = prntObj.InsertPrintingLogInformation(print_in, this);

            //출력사유를 선택하지 않은경우 출력불가.
            if (result != null)
                return true;
            else
                return false;
        }

        /// <summary>
        /// name         : 유전자 검사 출력시 권한 확인
        /// desc         : 유전자 검사 출력시 권한 확인 합니다.
        /// author       : 박제영 
        /// create date  : 2015-02-05
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private bool CheckGeneExaminationPrintingAuthority()
        {
            bool rtnRes = true;

            if (PrintedRecordList.Count() != 0)
            {
                for (int i = 0; i < PrintedRecordList.Count(); i++)
                {
                    if (PrintedRecordList[i].GENE_EXM_YN == "Y")
                    {
                        rtnRes = false;
                        break;
                    }
                }
            }

            return rtnRes;
        }

        /// <summary>
        /// name         : 진단서 조회
        /// desc         : 각 진단서를 조회함
        /// author       : 김정훈
        /// create date  : 2012-11-30 
        /// update date  : 
        /// </summary>
        public void SearchDiagnosisCertificateForm(object p)
        {

            if (p == null)
            { return; }

            this.RegisterSingleJobWithArg("조회 중입니다...", null, CallbackSearchDiagnosisCertificateForm, p);
        }

        // 
        void CallbackSearchDiagnosisCertificateForm(object p)
        {
            if (!((UserControlBase)base.Owner).Dispatcher.CheckAccess())
            {
                ((UserControlBase)base.Owner).Dispatcher.BeginInvoke(DispatcherPriority.Send, new Action<object>(CallbackSearchDiagnosisCertificateForm), p);
                return;
            }

            //기록내용조회를 위한 헤더정보 가져오기
            MedicalTreatmentRecordAskItemHeader_INOUT IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> in_HeaderList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
            IN_HEADER.MDRC_ID = (p as RecordList_INOUT).MDRC_ID;
            in_HeaderList = (HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "SelectMedicalTreatmentRecordAskClassByMDRCID", IN_HEADER);
            IN_HEADER = in_HeaderList[0];

            MedicalTreatmentRecordParam param = new MedicalTreatmentRecordParam()
            {
                MedicalTreatmentRecordID = IN_HEADER.MDRC_ID.ToString(),
                MedicalTreatmentRecordSEQ = IN_HEADER.MDRC_FOM_SEQ.ToString(),
                MedicalTreatmentRecordFormSetID = IN_HEADER.MDFM_ID.ToString(),
                MedicalTreatmentRecordFormSetSEQ = IN_HEADER.MDFM_FOM_SEQ.ToString(),
                MedicalTreatmentRecordFormTypeCode = IN_HEADER.MDFM_CLS_CD,
                MedicalTreatmentRecordFormTypeDetailCode = IN_HEADER.MDFM_CLS_DTL_CD,
                MedicalTreatmentRecordFormType = IN_HEADER.BasicFormType,
                UniqueID = IN_HEADER.UniqueID,
                MedicalTreatmentRecordFormTypeName = IN_HEADER.MDFM_CLS_NM,
                MedicalTreatmentRecordState = FormSaveState.Read,
                MedicalTreatmentRecordWriteStatus = IN_HEADER.MDRC_WRT_STS_CD,
                MedicalTreatmentRecordFormLoadMode = FormLoadMode.PrintOnlyMode,
                MedicalTreatmentRecordHsp_tp_cd = IN_HEADER.HSP_TP_CD
            };

            GlobalPatientInfo_OUT patientInfo = new GlobalPatientInfo_OUT()
            {
                PT_NO = IN_HEADER.PT_NO,
                MED_DEPT_CD = IN_HEADER.PT_MED_DEPT_CD,
                PACT_ID = IN_HEADER.PACT_ID,
                PACT_TP_CD = IN_HEADER.PACT_TP_CD,
                HSP_TP_CD = IN_HEADER.HSP_TP_CD
            };

            // 2024-07-23, 박민우, 1.0에서 작성된 기록들은 웹 뷰어로 표출
            if (param.MedicalTreatmentRecordFormSetID != "-1")
            {
                object page = HIS.UI.Core.AssemblyLoader.LoadComponent("HIS.MC.DR.RM.CL.UI", "DiagnosisCertificateFormManagement", param, ((this.Owner) as UserControl) as DependencyObject, patientInfo);

                dynamic uc = ((dynamic)page).outObj;

                if (uc != null)
                {
                    thisUserControl.ucDiagnosisCertificateFormManagement.Children.Clear();
                    thisUserControl.ucDiagnosisCertificateFormManagement.Children.Add(uc);
                    thisUserControl.ucDiagnosisCertificateFormManagement.Width = 650;
                }
            }
            else
            {
                object page = HIS.UI.Core.AssemblyLoader.LoadComponent("HIS.MC.DR.RM.CL.UI", "SelectOldDoctorRecord", param, ((this.Owner) as UserControl) as DependencyObject, patientInfo);

                dynamic uc = ((dynamic)page).outObj;

                if (uc != null)
                {
                    //DiagnosisCertificateFormManagementContent = uc;
                    if (uc.Parent != null)
                    {
                        thisUserControl.ucDiagnosisCertificateFormManagement.Children.Clear();
                        ((Grid)uc.Parent).Children.Remove(uc);
                    }
                    thisUserControl.ucDiagnosisCertificateFormManagement.Children.Add(uc);
                    thisUserControl.ucDiagnosisCertificateFormManagement.Width = 720;
                }
            }


        }

        /// <summary>
        /// name         : 탭변경 조회
        /// desc         : 기록조회 탭을 변경할 때 발생합니다.
        /// author       : 김정훈
        /// create date  : 2012-11-30 
        /// update date  : 
        /// </summary>
        public void TabSelectionChange()
        {
            if (thisUserControl.tctlSearchRecordList.SelectedTab.Header.ToString() == "진단서")
            {
                SearchPrintModeVisibility = Visibility.Collapsed;
                thisUserControl.flowDocViewer.Visibility = Visibility.Collapsed;
                thisUserControl.flowDocPrintViewer.Visibility = Visibility.Collapsed;
                thisUserControl.ucDiagnosisCertificateFormManagement.Visibility = Visibility.Visible;
                if (thisUserControl.layoutElectronicConsent != null)
                { thisUserControl.layoutElectronicConsent.Visibility = Visibility.Collapsed; }
                if (PrintAuthority)
                    thisUserControl.btnPrintPreview.Visibility = Visibility.Visible;

                SearchRecordListByDiagnosis();
                SearchDiagnosisCertificatePrintList();
            }
            else if (thisUserControl.tctlSearchRecordList.SelectedTab.Header.ToString() == "동의서")
            {
                SearchPrintModeVisibility = Visibility.Collapsed;
                thisUserControl.flowDocViewer.Visibility = Visibility.Collapsed;
                thisUserControl.flowDocPrintViewer.Visibility = Visibility.Collapsed;
                thisUserControl.ucDiagnosisCertificateFormManagement.Visibility = Visibility.Collapsed;
                if (thisUserControl.layoutElectronicConsent != null)
                { thisUserControl.layoutElectronicConsent.Visibility = Visibility.Visible; }
                if (PrintAuthority)
                    thisUserControl.btnPrintPreview.Visibility = Visibility.Visible;
            }
            else if (thisUserControl.tctlSearchRecordList.SelectedTab.Header.ToString() == "특성화 리포트")
            {
                thisUserControl.flowDocViewer.Visibility = Visibility.Visible;
                thisUserControl.flowDocPrintViewer.Visibility = Visibility.Collapsed;
                thisUserControl.ucDiagnosisCertificateFormManagement.Visibility = Visibility.Collapsed;
                if (thisUserControl.layoutElectronicConsent != null)
                { thisUserControl.layoutElectronicConsent.Visibility = Visibility.Collapsed; }
                if (PrintAuthority)
                    thisUserControl.btnPrintPreview.Visibility = Visibility.Visible;
            }
            else
            {
                thisUserControl.flowDocViewer.Document = null;
                thisUserControl.flowDocViewer.Visibility = Visibility.Visible;
                thisUserControl.flowDocPrintViewer.Visibility = Visibility.Collapsed;
                thisUserControl.ucDiagnosisCertificateFormManagement.Visibility = Visibility.Collapsed;
                if (thisUserControl.layoutElectronicConsent != null)
                { thisUserControl.layoutElectronicConsent.Visibility = Visibility.Collapsed; }
                if (PrintAuthority)
                    thisUserControl.btnPrintPreview.Visibility = Visibility.Visible;

                if (thisUserControl.tctlSearchRecordList.SelectedTab.Header.ToString() == "수진일별 기록조회" && IsFirstSearchMedicalTreatmentHistoryList == true)
                {
                    SearchMedicalTreatmentHistoryList();
                }
            }
        }

        /// <summary>
        /// name         : 환자 선택 함수
        /// desc         : 환자번호를 입력하여 환자를 변경 선택합니다.
        /// author       : 김정훈 
        /// create date  : 2012-08-31
        /// update date  : 2012-08-31, 수정자, 수정개요
        /// </summary>
        private void SelectPatient()
        {
            //20.09.22 그리드 초기화
            MedicalTreatmentHistoryList.Clear();
            RecordListByMedicalTreatmentDay.Clear();
            RecordListByCondition.Clear();
            MedicalTreatmentHistoryList.Clear();
            RecordListByMedicalTreatmentDay_his.Clear();
            RecordListByDiagnosis.Clear();
            DiagnosisCertificatePrintList.Clear();
            RecordListByConsentNote.Clear();
            RecordListByCharacteristicRecord.Clear();
            thisUserControl.flowDocViewer.Document = null;//조회기록FlowDocument
            thisUserControl.flowDocPrintViewer.Document = null;//조회기록출력FlowDocument
            thisUserControl.ucDiagnosisCertificateFormManagement.Children.Clear(); //진단서
            thisUserControl.layoutElectronicConsent.Children.Clear();//전자동의서
            ResetPrivilige();

            if (thisUserControl.txtPT_NO.Text.Length != 8)
            {
                //20.09.22 초기화
                PatientInformation = new PatientInformation_INOUT();
                SearchCondition.PT_NO = "";

                //20.09.22 문구제거 _ 김지은 선생님 컨폼
                // MsgBox.Display("8자리 환자번호를 입력해주세요.", MessageType.MSG_TYPE_EXCLAMATION, "환자번호 확인");

                return;
            }

            var Patientin = new PatientInformation_INOUT() { PT_NO = thisUserControl.txtPT_NO.Text };
            PatientInformation = (PatientInformation_INOUT)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectPatientAsk", Patientin);

            if (PatientInformation.PT_NO == null)
            {
                //20.09.22 초기화
                PatientInformation = new PatientInformation_INOUT();
                SearchCondition.PT_NO = "";

                MsgBox.Display("환자 정보가 존재하지 않습니다.", MessageType.MSG_TYPE_EXCLAMATION, "환자번호 확인");

                return;
            }
            else
            {
                //2022.03.23 복호화 로직 추가
                if (PatientInformation != null && PatientInformation.RRN.Contains("=="))
                {
                    using (SKCrypASPLib skcryp = new SKCrypASPLib())
                    {
                        PatientInformation.RRN = skcryp.DecryptData(PatientInformation.RRN);
                    }
                }

                HIS.UI.Base.Unmanaged.NativeMethods.SetProcessWorkingSetSize(System.Diagnostics.Process.GetCurrentProcess().Handle, -1, -1);

                GC.Collect();
                GC.WaitForPendingFinalizers();
                GC.Collect();

                //20.09.22 사생활보호 체크 로직 수정
                #region 정보보호/사생활보호 체크
                PatientInformation_INOUT access_in = new PatientInformation_INOUT();
                access_in.PT_NO = thisUserControl.txtPT_NO.Text;

                if (CheckPrivate(access_in) == false)
                {
                    //초기화 20.09.22
                    PatientInformation = new PatientInformation_INOUT();
                    SearchCondition.PT_NO = "";

                    return;
                }
                #endregion 정보보호/사생활보호 체크


                #region 환자선택 사유입력 체크    
                string medId = CommonServiceAgent.SelectCodeInfo(new CCCCCSTE_INOUT() { COMN_GRP_CD = "MD00739", COMN_CD = "ID0001" }).COMN_CD_NM;

                //의무기록팀, 정보보안팀, 보험과, 원무과(UsrAuthInfo.ONLY_CERTIFCATE_YN="Y")의 경우 사유창을 띄우지 않는다.
                if (!SessionManager.UserInfo.AOA_WKDP_CD.Equals("HMRS")
                    && !SessionManager.UserInfo.AOA_WKDP_CD.Equals("HISS")
                    && !SessionManager.UserInfo.AOA_WKDP_CD.Equals("INS")
                    && !SessionManager.UserInfo.STF_NO.Equals(medId)
                    && !UsrAuthInfo.ONLY_CERTIFCATE_YN.Equals("Y")
                    )
                {
                    //환자의 Active수진 체크
                    HSFDTOCollectionBaseObject<ActiveDepartment_INOUT> activeDeptList;

                    SearchCondition_IN inObj = new SearchCondition_IN() { PT_NO = thisUserControl.txtPT_NO.Text };

                    activeDeptList = UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectActiveMedicalDepartmentAsk", inObj) as HSFDTOCollectionBaseObject<ActiveDepartment_INOUT>;

                    //var deptlist = activeDeptList.Where(d => d.MED_DEPT_CD == SessionManager.UserInfo.AOA_WKDP_CD);
                    bool deptlist = false;

                    foreach (ActiveDepartment_INOUT tmp in activeDeptList)
                    {
                        if (SessionManager.UserInfo.MED_DEPT_LIST.Where(d => d.MED_DEPT_CD == tmp.MED_DEPT_CD).Count() > 0 || SessionManager.UserInfo.AOA_WKDP_CD == tmp.MED_DEPT_CD)
                        {
                            deptlist = true;
                            break;
                        }
                    }

                    //inactive수진이거나 active 수진이 자신의 현소속진료과가 아닐때 환자선택사유 입력(현소속 + 등록진료과 까지도 보는것으로 수정)  
                    //if (deptlist.Count() == 0)
                    if (!deptlist)
                    {
                        //환자선택사유 입력             
                        CommonDTO_INOUT access = new CommonDTO_INOUT() { PT_NO = thisUserControl.txtPT_NO.Text, SID = UserInformation.HIS_SID };
                        if (!CheckPatientinformationRequestHistory(access))
                        {
                            //사유창 입력안했을시, 환자번호 초기화 20.09.22
                            PatientInformation = new PatientInformation_INOUT();
                            SearchCondition.PT_NO = "";

                            if (SessionManager.SystemInfo != null && SessionManager.SystemInfo.MAIN_GUBUN != null)
                            {
                                if (!SessionManager.SystemInfo.MAIN_GUBUN.Equals("DR")
                                && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("NR")
                                && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("IF")
                                && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("CA")
                                && !SessionManager.SystemInfo.MAIN_GUBUN.Equals("CC"))
                                {
                                    thisUserControl.OwnerWindow.Close();
                                    return;
                                }
                            }

                            return;
                        }
                    }
                    else
                    {

                        #region 환자선택로그 입력
                        SavePatientInformationPrivacyRequest_IN inprivate = new SavePatientInformationPrivacyRequest_IN();

                        inprivate.APCH_STF_NO = SessionManager.UserInfo.STF_NO;
                        inprivate.APCH_STF_MED_DEPT_CD = SessionManager.UserInfo.AOA_WKDP_CD;
                        inprivate.PT_NO = PatientInformation.PT_NO;
                        inprivate.PT_HME_MED_DEPT_CD = "";
                        inprivate.PACT_TP_CD = "";
                        inprivate.APOT_CUR_HME_PT_YN = "";
                        inprivate.APOT_PT_CHC_RSN_CD = "110";
                        inprivate.APCH_HIS_PRGM_TP_CD = "PRTLG001";

                        Result_OUT result = (Result_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DM.PS.MN.BIZ.SavePatientInformationPrivacyRequestDataBL", "SavePatientAccessLog", inprivate);

                        #endregion
                    }
                }
                else
                {
                    #region 환자선택로그 입력
                    SavePatientInformationPrivacyRequest_IN inprivate = new SavePatientInformationPrivacyRequest_IN();

                    inprivate.APCH_STF_NO = SessionManager.UserInfo.STF_NO;
                    inprivate.APCH_STF_MED_DEPT_CD = SessionManager.UserInfo.AOA_WKDP_CD;
                    inprivate.PT_NO = PatientInformation.PT_NO;
                    inprivate.PT_HME_MED_DEPT_CD = "";
                    inprivate.PACT_TP_CD = "";
                    inprivate.APOT_CUR_HME_PT_YN = "";
                    inprivate.APOT_PT_CHC_RSN_CD = "504";     //504 : 기타(업무목적)
                    inprivate.APCH_HIS_PRGM_TP_CD = "PRTLG001";

                    Result_OUT result = (Result_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DM.PS.MN.BIZ.SavePatientInformationPrivacyRequestDataBL", "SavePatientAccessLog", inprivate);
                    #endregion
                }
                #endregion 환자선택 사유입력 체크

                //#region 정보보호/사생활보호 체크
                //PatientInformation_INOUT access_in = new PatientInformation_INOUT();
                //access_in.PT_NO = thisUserControl.txtPT_NO.Text;

                //CheckPrivate(access_in);
                //#endregion 정보보호/사생활보호 체크

            }

            SearchCondition.PT_NO = PatientInformation.PT_NO;

            InitializeDTO();
        }


        /// <summary>
        /// name         : 환자 선택 함수(타메인을 통한)
        /// desc         : 환자번호를 입력하여 환자를 변경 선택합니다.
        /// author       : 김정훈 
        /// create date  : 2012-08-31
        /// update date  : 2012-08-31, 수정자, 수정개요
        /// </summary>
        private void SelectPatientOtherMain()
        {
            //20.09.22 그리드 초기화
            MedicalTreatmentHistoryList.Clear();
            RecordListByMedicalTreatmentDay.Clear();
            RecordListByCondition.Clear();
            MedicalTreatmentHistoryList.Clear();
            RecordListByMedicalTreatmentDay_his.Clear();
            RecordListByDiagnosis.Clear();
            DiagnosisCertificatePrintList.Clear();
            RecordListByConsentNote.Clear();
            RecordListByCharacteristicRecord.Clear();
            thisUserControl.flowDocViewer.Document = null;//조회기록FlowDocument
            thisUserControl.flowDocPrintViewer.Document = null;//조회기록출력FlowDocument
            thisUserControl.ucDiagnosisCertificateFormManagement.Children.Clear(); //진단서
            thisUserControl.layoutElectronicConsent.Children.Clear();//전자동의서

            if (thisUserControl.txtPT_NO.Text.Length != 8)
            {
                //20.09.22 초기화
                PatientInformation = new PatientInformation_INOUT();
                SearchCondition.PT_NO = "";

                //20.09.22 문구제거 _ 김지은 선생님 컨폼
                //MsgBox.Display("8자리 환자번호를 입력해주세요.", MessageType.MSG_TYPE_EXCLAMATION, "환자번호 확인");

                return;
            }

            var Patientin = new PatientInformation_INOUT() { PT_NO = thisUserControl.txtPT_NO.Text };
            PatientInformation = (PatientInformation_INOUT)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectPatientAsk", Patientin);

            if (PatientInformation.PT_NO == null)
            {
                //20.09.22 초기화
                PatientInformation = new PatientInformation_INOUT();
                SearchCondition.PT_NO = "";

                MsgBox.Display("환자 정보가 존재하지 않습니다.", MessageType.MSG_TYPE_EXCLAMATION, "환자번호 확인");

                return;
            }
            else
            {

                //2022.03.23 복호화 로직 추가
                if (PatientInformation != null && PatientInformation.RRN.Contains("=="))
                {
                    using (SKCrypASPLib skcryp = new SKCrypASPLib())
                    {
                        PatientInformation.RRN = skcryp.DecryptData(PatientInformation.RRN);
                    }
                }

                HIS.UI.Base.Unmanaged.NativeMethods.SetProcessWorkingSetSize(System.Diagnostics.Process.GetCurrentProcess().Handle, -1, -1);

                GC.Collect();
                GC.WaitForPendingFinalizers();
                GC.Collect();

                //20.09.22 사생활보호 체크 로직 수정
                #region 정보보호/사생활보호 체크
                PatientInformation_INOUT access_in = new PatientInformation_INOUT();
                access_in.PT_NO = thisUserControl.txtPT_NO.Text;

                if (CheckPrivate(access_in) == false)
                {
                    PatientInformation = new PatientInformation_INOUT();
                    SearchCondition.PT_NO = "";

                    return;
                }
                #endregion 정보보호/사생활보호 체크

                #region 환자선택 사유입력 체크           
                //의무기록팀, 정보보안팀, 보험과, 원무과(UsrAuthInfo.ONLY_CERTIFCATE_YN="Y")의 경우 사유창을 띄우지 않는다.
                if (!SessionManager.UserInfo.AOA_WKDP_CD.Equals("HMRS")
                    && !SessionManager.UserInfo.AOA_WKDP_CD.Equals("HISS")
                    && !SessionManager.UserInfo.AOA_WKDP_CD.Equals("INS")
                    && !SessionManager.UserInfo.STF_NO.Equals("HISMC")
                    && !UsrAuthInfo.ONLY_CERTIFCATE_YN.Equals("Y")
                    )
                {
                    //환자의 Active수진 체크
                    HSFDTOCollectionBaseObject<ActiveDepartment_INOUT> activeDeptList;

                    SearchCondition_IN inObj = new SearchCondition_IN() { PT_NO = thisUserControl.txtPT_NO.Text };

                    activeDeptList = UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectActiveMedicalDepartmentAsk", inObj) as HSFDTOCollectionBaseObject<ActiveDepartment_INOUT>;

                    //var deptlist = activeDeptList.Where(d => d.MED_DEPT_CD == SessionManager.UserInfo.AOA_WKDP_CD);
                    bool deptlist = false;

                    foreach (ActiveDepartment_INOUT tmp in activeDeptList)
                    {
                        if (SessionManager.UserInfo.MED_DEPT_LIST.Where(d => d.MED_DEPT_CD == tmp.MED_DEPT_CD).Count() > 0 || SessionManager.UserInfo.AOA_WKDP_CD == tmp.MED_DEPT_CD)
                        {
                            deptlist = true;
                            break;
                        }
                    }

                    //inactive수진이거나 active 수진이 자신의 현소속진료과가 아닐때 환자선택사유 입력(현소속 + 등록진료과 까지도 보는것으로 수정)  
                    //if (deptlist.Count() == 0)
                    if (!deptlist)
                    {
                        //환자선택사유 입력             
                        CommonDTO_INOUT access = new CommonDTO_INOUT() { PT_NO = thisUserControl.txtPT_NO.Text, SID = UserInformation.HIS_SID };
                        if (!CheckPatientinformationRequestHistoryOtherMain(access))
                        {
                            //사유창 입력안했을시, 환자번호 초기화 20.09.22
                            PatientInformation = new PatientInformation_INOUT();
                            SearchCondition.PT_NO = "";

                            if (CALLER == "PACS" || CALLER == "CDW")
                            {
                                Application.Current.Shutdown();
                                //var scriptObject = BrowserInteropHelper.HostScript; // Call close to close the browser window. scriptObject.Close();
                            }
                            thisUserControl.OwnerWindow.Close();

                            return;
                        }
                    }
                    #endregion 환자선택 사유입력 체크                                    
                }

                //#region 정보보호/사생활보호 체크
                //PatientInformation_INOUT access_in = new PatientInformation_INOUT();
                //access_in.PT_NO = thisUserControl.txtPT_NO.Text;

                //CheckPrivate(access_in);
                //#endregion 정보보호/사생활보호 체크

                SearchCondition.PT_NO = PatientInformation.PT_NO;

                InitializeDTO();
            }
        }

        /// <summary>
        /// name         :  DTO 초기화 및 진단서 목록 세팅
        /// desc         :  DTO를 초기화하고 진단서 목록을 세팅합니다.
        /// author       : 강성희 
        /// create date  : 2016-07-31
        /// update date  : 2016-07-31, 수정자, 수정개요
        /// </summary>        
        private void InitializeDTO()
        {
            //DTO 초기화
            MedicalTreatmentHistoryList.Clear();//수진목록
            RecordListByMedicalTreatmentDay.Clear();//수진일별 기록조회 목록
            RecordListByCondition.Clear();//조건별 상세조회 목록
            RecordListByMedicalTreatmentDay_his.Clear();//기록이력조회 기록목록
            if (HavingAMedicalExaminationDetailBindingList != null)
            {
                HavingAMedicalExaminationDetailBindingList.Clear();//기록이력조회 이력목록
            }

            RecordListByDiagnosis.Clear();//진단서 기록조회 목록
            DiagnosisCertificatePrintList.Clear();//진단서 출력 목록
            SelectedRecordList.Clear();//선택된 기록목록
            RecordListByConsentNote.Clear();//전자동의서 조회목록
            RecordListByCharacteristicRecord.Clear();//특성화리포트 조회목록

            PrintedRecordList.Clear();

            thisUserControl.flowDocViewer.Document = null;//조회기록FlowDocument
            thisUserControl.flowDocPrintViewer.Document = null;//조회기록출력FlowDocument
            //DiagnosisCertificateFormManagementContent = new UserControlBase();//진단서
            thisUserControl.ucDiagnosisCertificateFormManagement.Children.Clear();
            thisUserControl.layoutElectronicConsent.Children.Clear();//전자동의서
            this.SearchCharacteristicRecordList(); //특성화기록탭은 리스트 조회버튼이 없기때문에 환자변경될때 자동으로 조회.

            IsFirstSearchMedicalTreatmentHistoryList = true;

            TabSelectionChange();
        }

        private void SetDepartment(object p)
        {
            if (p == null)
            { return; }

            String txtDept = (String)p;

            foreach (Department_INOUT department in DepartmentGroup)
            {
                if (department.DEPT_NM == txtDept)
                {
                    SelectedDepartment = department;
                    break;
                }
            }
        }

        // 수진일별 기록조회 수진이력 Max Height로 변경
        private void SetMedicalTreatmentHistoryListMaxHeight()
        {
            thisUserControl.dgrdMedicalTreatmentHistoryList.UpdateLayout();
            if (thisUserControl.dgrdMedicalTreatmentHistoryList.GetScrollProvider().VerticallyScrollable == true)
            {
                MedicalTreatmentHistoryListHeight = "3*";
                MedicalTreatmentDayHeight = "*";
            }
        }

        //수진일별 기록조회 기록목록 Max Height로 변경
        private void SetMedicalTreatmentDayMaxHeight()
        {
            thisUserControl.dgrdRecordListByMedicalTreatmentDay.UpdateLayout();
            if (thisUserControl.dgrdRecordListByMedicalTreatmentDay.GetScrollProvider().VerticallyScrollable == true)
            {
                MedicalTreatmentHistoryListHeight = "*";
                MedicalTreatmentDayHeight = "3*";
            }
        }

        /// <summary>
        /// name         :  전자동의서기록목록 조회
        /// desc         :  환자에게 작성된 전자동의서 기록 목록을 조회합니다.
        /// author       : 강성희 
        /// create date  : 2016-07-31
        /// update date  : 2016-07-31, 수정자, 수정개요
        /// </summary>
        public void SearchRecordListByConsentNote()
        {
            //전자동의서 기록목록조회
            this.RecordListByConsentNote.Clear();

            if (SelectedDepartment != null)
            {
                SearchCondition.DEPT_CD = SelectedDepartment.DEPT_CD;
            }
            else
            {
                SearchCondition.DEPT_CD = "";
            }

            RecordListByConsentNote = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectRecordListByElectronicConsentNote", SearchCondition);

            if (RecordListByConsentNote.Count == 0)
            {
                MsgBox.Display("DRMCN_006404", MessageType.MSG_TYPE_INFORMATION, "조회조건 확인", TimeSpan: 1000); // [해당 기간동안 작성된 기록이 존재하지 않습니다.]

                return;
            }
        }

        /// <summary>
        /// name         : 전자동의서기록 조회
        /// desc         : 선택된 전자동의서를 조회함
        /// author       : 강성희
        /// create date  : 2016-07-20 
        /// update date  : 
        /// </summary>
        public void SearchElectronicConsentForm()
        {
            if (thisUserControl.layoutElectronicConsent.Children.Count != 0)
            {
                thisUserControl.layoutElectronicConsent.Children.Clear();
            }

            if (RecordListByConsentNote.Count == 0)
            {
                MsgBox.Display("DRMCN_002790", MessageType.MSG_TYPE_INFORMATION); // [선택된 기록지가 없습니다.]

                return;
            }

            PrntLog_DTO.Clear(); // 출력로그를 저장하기 위한 DTO 초기화

            String sArgument = "";

            for (int i = 0; i < SelectedRecordListByConsentNote.Count; i++)
            {
                if (PrintingAskChecked) //출력용 조회 체크시
                {
                    if (SelectedRecordListByConsentNote[i].MDRC_WRT_STS_CD_YN == "Y") //서명된 기록만 조회
                    {
                        if (i == 0)
                        {
                            sArgument = SelectedRecordListByConsentNote[i].MDFM_CLS_CD.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_ID.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_FOM_SEQ.ToString();
                        }
                        else
                        {
                            sArgument = sArgument + "^" + SelectedRecordListByConsentNote[i].MDFM_CLS_CD.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_ID.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_FOM_SEQ.ToString();
                        }

                        PrntLog_DTO.Add(SelectedRecordListByConsentNote[i]);    // 출력로그를 저장하기 위한 DTO 생성
                    }
                }
                else
                {
                    if (i == 0)
                        sArgument = SelectedRecordListByConsentNote[i].MDFM_CLS_CD.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_ID.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_FOM_SEQ.ToString();
                    else
                        sArgument = sArgument + "^" + SelectedRecordListByConsentNote[i].MDFM_CLS_CD.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_ID.ToString() + "_" + SelectedRecordListByConsentNote[i].MDRC_FOM_SEQ.ToString();
                }
            }

            if (String.IsNullOrWhiteSpace(sArgument))
            {
                MsgBox.Display("DRMCN_008053", MessageType.MSG_TYPE_INFORMATION); // [선택한 기록지가 없거나, 서명된 기록이 없습니다.]

                return;
            }


            String strServerUrl;

            strServerUrl = HIS.UI.Core.ConfigManager.CC.IntgSvrUrl;
            strServerUrl += "/EMR/PTMANAGE/MEDREC/AGREEMENTDOC/PrintRecViewAgreement.aspx";

            string data = string.Empty;

            //출력권한체크
            if (PrintingAskChecked && PrintAuthority)
                data += string.Format("&CallBy={0}", "AGREEVIEW");

            data += string.Format("&PtNo={0}", PatientInformation.PT_NO);
            data += string.Format("&PatName={0}", PatientInformation.PT_NM);
            data += string.Format("&Sex={0}", PatientInformation.SEX);
            data += string.Format("&Age={0}", PatientInformation.AGE);
            data += string.Format("&SYSDATE={0}", CommonServiceAgent.SelectSysDateTime());
            data += string.Format("&Argument={0}", sArgument);

            //사용자 정보가 있는 경우(차세대 프로그램을 통해 로그인을 한 경우)에만 데이터를 설정한다.
            if (SessionManager.UserInfo != null)
            {
                //사용자 사번
                data += string.Format("&WKPERS={0}", SessionManager.UserInfo.STF_NO);
                //사용자 이름
                data += string.Format("&NM={0}", SessionManager.UserInfo.STF_NM);
                //사용자 진료과
                data += string.Format("&TRT_DEPT={0}", SessionManager.UserInfo.AOA_WKDP_CD);
            }

            byte[] source = Encoding.Default.GetBytes(data);

            thisUserControl.OpenWebBrowser(strServerUrl, null, source, "Content-Type: application/x-www-form-urlencoded");
        }

        /// <summary>
        /// name         : 특성화기록 목록 조회
        /// desc         : 선택된 특성화기록의 목록을 조회함.
        /// author       : 강성희
        /// create date  : 2016-07-20 
        /// update date  : 
        /// </summary>
        public void SearchCharacteristicRecordList()
        {
            this.RecordListByCharacteristicRecord.Clear();
            this.thisUserControl.flowDocViewer.Document = null;

            #region [ AMI, CABG, 혈액투석 ]
            if (SelectedCharacteristicRecordType.Equals("CR_AMI") || SelectedCharacteristicRecordType.Equals("CR_CABG") || SelectedCharacteristicRecordType.Equals("CR_HEMODIALYSIS"))
            {
                HSFDTOCollectionBaseObject<RecordList_INOUT> RecordListByCharacteristicRecordAll = new HSFDTOCollectionBaseObject<RecordList_INOUT>();

                RecordListByCharacteristicRecordAll = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectCharacteristicRecordListByForm", SearchCondition);

                if (SelectedCharacteristicRecordType.Equals("CR_AMI")) //AMI 리포트
                    RecordListByCharacteristicRecord = new HSFDTOCollectionBaseObject<RecordList_INOUT>(RecordListByCharacteristicRecordAll.Where(d => d.MDFM_CLS_DTL_CD.Equals("01000") || d.MDFM_CLS_DTL_CD.Equals("01001")).ToList());
                else if (SelectedCharacteristicRecordType.Equals("CR_CABG")) //CABG 기록
                    RecordListByCharacteristicRecord = new HSFDTOCollectionBaseObject<RecordList_INOUT>(RecordListByCharacteristicRecordAll.Where(d => d.MDFM_CLS_DTL_CD.Equals("01002")).ToList());
                else if (SelectedCharacteristicRecordType.Equals("CR_HEMODIALYSIS")) //혈액투석의무기록
                    RecordListByCharacteristicRecord = new HSFDTOCollectionBaseObject<RecordList_INOUT>(RecordListByCharacteristicRecordAll.Where(d => d.MDFM_CLS_DTL_CD.Equals("01003") || d.MDFM_CLS_DTL_CD.Equals("01004")
                                                        || d.MDFM_CLS_DTL_CD.Equals("01004") || d.MDFM_CLS_DTL_CD.Equals("01005") || d.MDFM_CLS_DTL_CD.Equals("01006")
                                                        || d.MDFM_CLS_DTL_CD.Equals("01007") || d.MDFM_CLS_DTL_CD.Equals("01008") //혈액투석의무기록 Ver7 진료서식유형상세코드(01008)추가
                                                        || d.MDFM_CLS_DTL_CD.Equals("01009") //혈액투석의무기록 Ver8 진료서식유형상세코드(01009)추가
                                                        ).ToList());
            }
            #endregion [ AMI, CABG, 혈액투석 ]

            #region [ NST 모니터링 ]
            else if (SelectedCharacteristicRecordType.Equals("CR_NST"))
            {
                RecordListByCharacteristicRecord = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectNSTMonitoringRecordList", SearchCondition);
            }
            #endregion [ NST 모니터링 ]

            #region  [ 방사선종양 치료기록 ]
            else if (SelectedCharacteristicRecordType.Equals("CR_TRREC"))
            {
                RecordListByCharacteristicRecord = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectRadioTherapyRecordList", SearchCondition);
            }
            #endregion [ 방사선종양 치료기록 ]

            #region [ 진정기록 - 간호추가 ]

            else if (this.SelectedCharacteristicRecordType == "CR_SEDATION") // 진정기록 Flowdocument에 출력          
            {
                RecordListByCharacteristicRecord = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectSedationRecordList", SearchCondition);
            }

            #endregion

            #region [ CPR기록 - 간호추가 ]

            else if (this.SelectedCharacteristicRecordType == "CR_CPR") // CPR기록 Flowdocument에 출력          
            {
                RecordListByCharacteristicRecord = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectCprRecordList", SearchCondition);
            }

            #endregion

            #region 폐암FlowSheet
            else if (this.SelectedCharacteristicRecordType.Equals("CR_CFS"))
            {
                RecordListByCharacteristicRecord.Clear();

                if (string.IsNullOrEmpty(PatientInformation.PT_NO))
                    return;

                FlowSheetWkpers_INOUT param = new FlowSheetWkpers_INOUT();

                param.PT_NO = PatientInformation.PT_NO;
                param.PT_NM = PatientInformation.PT_NM;
                param.SEX_TP_CD = PatientInformation.SEX;
                param.AGE = PatientInformation.AGE;

                PopUpBase popup = base.OnLoadPopupMenu("DR_HIS.MC.DR.CR.RC.UI_/SaveLungCancerFlowsheet.xaml", param, PrintAuthority);
                popup.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                popup.WindowStartupLocation = WindowStartupLocation.CenterOwner;

                popup.ShowDialog();
            }
            #endregion

            #region RRS보고서
            else if (this.SelectedCharacteristicRecordType.Equals("CR_RRS"))
            {
                RecordListByCharacteristicRecord = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectRRSReportList", SearchCondition);
            }
            #endregion
            //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_CPR", "원내심폐소생술보고서"));
            //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_SEDATION", "진정기록"));
            //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_RRS", "RRS보고서"));
            //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_TRREC", "방사선종양 치료기록"));
            //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_CFS", "폐암FlowSheet"));
            //Code_CharacteristicRecord_Type.Add(new CCCCCSTE_INOUT("CharacteristicRecord_Type", "CR_NST", "NST모니터링"));

            /*
            if (RecordListByCharacteristicRecord.Count == 0)
            {
                MsgBox.Display("해당 기간동안 작성된 기록이 존재하지 않습니다.", MessageType.MSG_TYPE_EXCLAMATION, "조회조건 확인", TimeSpan: 1000);
                return;
            }
            */
        }

        /// <summary>
        /// name         : 특성화기록 내용조회
        /// desc         : 선택된 특성화기록의 내용을 조회함.
        /// author       : 강성희
        /// create date  : 2016-07-20 
        /// update date  : 
        /// </summary>
        public void SearchCharacteristicRecord(object p)
        {
            RecordList_INOUT record = p as RecordList_INOUT;

            if (record == null)
            {
                MsgBox.Display("DRMCN_008053", MessageType.MSG_TYPE_INFORMATION);
                return;
            }

            #region [ AMI, CABG, 혈액투석 ]
            //AMI리포트, CABG기록, 혈액투석의무기록의 경우 서식을 사용
            if (SelectedCharacteristicRecordType.Equals("CR_AMI") || SelectedCharacteristicRecordType.Equals("CR_CABG") || SelectedCharacteristicRecordType.Equals("CR_HEMODIALYSIS"))
            {
                if (PrintingAskChecked)
                {
                    SearchPrintModeVisibility = Visibility.Visible;
                    PrintPreviewVisibility = Visibility.Visible;
                }
                else
                {
                    SearchPrintModeVisibility = Visibility.Collapsed;
                    PrintPreviewVisibility = Visibility.Collapsed;
                }

                //기록내용조회를 위한 헤더정보 가져오기
                MedicalTreatmentRecordAskItemHeader_INOUT IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();
                HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> in_HeaderList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
                IN_HEADER.MDRC_ID = record.MDRC_ID;
                in_HeaderList = (HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "SelectMedicalTreatmentRecordAskClassByMDRCID", IN_HEADER);
                IN_HEADER = in_HeaderList[0];

                MedicalTreatmentRecordParam param = new MedicalTreatmentRecordParam()
                {
                    MedicalTreatmentRecordID = IN_HEADER.MDRC_ID.ToString(),
                    MedicalTreatmentRecordSEQ = IN_HEADER.MDRC_FOM_SEQ.ToString(),
                    MedicalTreatmentRecordFormSetID = IN_HEADER.MDFM_ID.ToString(),
                    MedicalTreatmentRecordFormSetSEQ = IN_HEADER.MDFM_FOM_SEQ.ToString(),
                    MedicalTreatmentRecordFormTypeCode = IN_HEADER.MDFM_CLS_CD,
                    MedicalTreatmentRecordFormTypeDetailCode = IN_HEADER.MDFM_CLS_DTL_CD,
                    MedicalTreatmentRecordFormType = IN_HEADER.BasicFormType,
                    UniqueID = IN_HEADER.UniqueID,
                    MedicalTreatmentRecordFormTypeName = IN_HEADER.MDFM_CLS_NM,
                    MedicalTreatmentRecordState = FormSaveState.Read,
                    MedicalTreatmentRecordWriteStatus = IN_HEADER.MDRC_WRT_STS_CD,
                    MedicalTreatmentRecordFormLoadMode = FormLoadMode.PrintOnlyMode
                };

                GlobalPatientInfo_OUT patientInfo = new GlobalPatientInfo_OUT()
                {
                    PT_NO = in_HeaderList[0].PT_NO
                };

                object page = HIS.UI.Core.AssemblyLoader.LoadComponent("HIS.MC.DR.RM.CL.UI", "DiagnosisCertificateFormManagement", param, ((this.Owner) as UserControl) as DependencyObject, patientInfo);

                dynamic uc = ((dynamic)page).outObj;

                if (uc != null)
                {
                    string[] sQuarter;
                    if (IN_HEADER.MDFM_ID.Equals(803) || IN_HEADER.MDFM_ID.Equals(804) || IN_HEADER.MDFM_ID.Equals(805) || IN_HEADER.MDFM_ID.Equals(806)
                        || IN_HEADER.MDFM_ID.Equals(2002633) || IN_HEADER.MDFM_ID.Equals(2002929)//혈액투석의무기록 Ver6, 혈액투석의무기록 Ver7
                        || IN_HEADER.MDFM_ID.Equals(2003229) //혈액투석의무기록 Ver8
                        )
                    {
                        sQuarter = record.YYYYQ.Split('|');
                    }
                    else
                    {
                        sQuarter = null;
                    }

                    FlowDocument fdoc = (uc as SaveDiagnosisCertificateRegistration).ConvertToFlowDoucment(param, sQuarter);

                    thisUserControl.flowDocViewer.Visibility = Visibility.Visible;

                    thisUserControl.flowDocViewer.Document = fdoc;

                    AddSelectedRecordList(record);

                    PrintedRecordList = SelectedRecordListCR;
                }
            }
            #endregion [AMI, CABG, 혈액투석] 
            #region [ NST 모니터링 ]
            else if (SelectedCharacteristicRecordType.Equals("CR_NST"))
            {
                if (PrintingAskChecked)
                {
                    SearchPrintModeVisibility = Visibility.Visible;
                    PrintPreviewVisibility = Visibility.Visible;
                }
                else
                {
                    SearchPrintModeVisibility = Visibility.Collapsed;
                    PrintPreviewVisibility = Visibility.Collapsed;
                }

                var resourceLocater = new Uri("HIS.MC.DR.RM.RV.UI;component/Resources/WhiteBackgroundStyle.xaml", System.UriKind.Relative);

                FlowDocument fdoc = Application.LoadComponent(resourceLocater) as FlowDocument;
                //fdoc.PagePadding = new Thickness(5);

                NSTMonitoringTemplate NSTMonitoringRecord;
                NSTMonitoringRecord = (NSTMonitoringTemplate)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectNSTMonitoringRecord", p as RecordList_INOUT);
                NSTMonitoringRecord.TEMPLATE = "NSTMonitoringTemplate";
                fdoc = CreateDocument(NSTMonitoringRecord);

                thisUserControl.flowDocViewer.Document = fdoc;

                AddSelectedRecordList(record);

                PrintedRecordList = SelectedRecordListCR;
            }
            #endregion [ NST 모니터링 ]

            #region [ RRS 보고서 ]
            else if (SelectedCharacteristicRecordType.Equals("CR_RRS"))
            {
                string print_yn = "N";

                RssReportActivationEventParticulars_INOUT item = new RssReportActivationEventParticulars_INOUT();
                item.NEW_YN = "";
                item.RRS_PT_CHC_ID = record.RRS_PT_CHC_ID;
                item.PT_NO = record.PT_NO;
                item.PACT_ID = record.PACT_ID;
                item.ADS_DT = record.PACT_DTM.ToString();
                //item.RRS_WRTR_TP_CD = !string.IsNullOrEmpty(SessionManager.UserInfo.USE_GRP_CD) ? SessionManager.UserInfo.USE_GRP_CD.Substring(0, 1) : "";

                if (record.MDRC_WRT_STS_CD_YN == "Y" && PrintAuthority)
                    print_yn = "Y";

                PopUpBase popup = base.OnLoadPopupMenu("DR_HIS.MC.DR.CR.RC.UI_/SelectRssReport.xaml", item, print_yn, "RECVIEWER");
                popup.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                popup.WindowStartupLocation = WindowStartupLocation.CenterOwner;

                popup.ShowDialog();
            }
            #endregion [ RRS 보고서 ]

            #region [ 방사선종양 치료기록 ]
            else if (SelectedCharacteristicRecordType.Equals("CR_TRREC"))
            {
                //환자번호, RT번호, 출력용조회여부 전달
                PopUpBase popup = base.OnLoadPopupMenu("DR_HIS.MC.TR.RO.TR.UI_/SelectRTTRecordManagement.xaml", PatientInformation.PT_NO, (p as RecordList_INOUT).RTT_CRSE_SEQ, printingAskChecked);
                popup.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
                popup.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                MainMenuInfo mainMenuInfo = popup.Content as MainMenuInfo;

                if (mainMenuInfo != null)
                {
                    UserControlBase userControlBase = mainMenuInfo.INSTANCE_OF_MENU as UserControlBase;
                    //유저컨트롤 베이스 자원 접근
                    //(userControlBase as dynamic).txtPtNO = PatientInformation.PT_NO;

                    if (userControlBase != null)
                    {
                        ViewModelBase viewModel = userControlBase.DataContext as ViewModelBase;

                        if (viewModel != null)
                        {
                            //뷰모델 베이스 자원 접근
                            //(viewModel as dynamic).PT_NO = PatientInformation.PT_NO;
                        }
                    }
                }
                popup.ShowDialog();
                popup.ShowInTaskbar = false;
            }
            #endregion [ 방사선종양 치료기록 ]
            #region [ CPR 기록 ]
            else if (SelectedCharacteristicRecordType.Equals("CR_CPR"))
            {
                if (PrintingAskChecked)
                {
                    SearchPrintModeVisibility = Visibility.Visible;
                    PrintPreviewVisibility = Visibility.Visible;
                }
                else
                {
                    SearchPrintModeVisibility = Visibility.Collapsed;
                    PrintPreviewVisibility = Visibility.Collapsed;
                }

                var resourceLocater = new Uri("HIS.MC.DR.RM.RV.UI;component/Resources/WhiteBackgroundStyle.xaml", System.UriKind.Relative);

                FlowDocument fdoc = Application.LoadComponent(resourceLocater) as FlowDocument;
                fdoc.PagePadding = new Thickness(5);

                PreoperativeNursingStatusGroupTemplate_OUT cardiopulmonaryResuscitationStatus;

                InitialNursingRecodeDetailTemplate_INOUT cardiopulmonaryResuscitationStatusInfo = new InitialNursingRecodeDetailTemplate_INOUT() { NREC_SCTN_ID = (p as RecordList_INOUT).MDRC_ID, PACT_ID = (p as RecordList_INOUT).PACT_ID, PT_NO = (p as RecordList_INOUT).PT_NO, ITEM_TYPE = (p as RecordList_INOUT).ITEM_TYPE, REC_IMG_AUTH_YN = imagePrintAuthority };

                cardiopulmonaryResuscitationStatus = (PreoperativeNursingStatusGroupTemplate_OUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerSecondBL", "SelectCardiopulmonaryResuscitation", cardiopulmonaryResuscitationStatusInfo);
                cardiopulmonaryResuscitationStatus.TEMPLATE = "CardiopulmonaryResuscitationTemplate";
                fdoc = CreateDocument(cardiopulmonaryResuscitationStatus);

                thisUserControl.flowDocViewer.Document = fdoc;

                AddSelectedRecordList(record);

                PrintedRecordList = SelectedRecordListCR;
            }
            #endregion [ CPR 기록 ]

            #region 진정기록

            else if (this.SelectedCharacteristicRecordType == "CR_SEDATION")
            {
                if (PrintingAskChecked)
                {
                    SearchPrintModeVisibility = Visibility.Visible;
                    PrintPreviewVisibility = Visibility.Visible;
                }
                else
                {
                    SearchPrintModeVisibility = Visibility.Collapsed;
                    PrintPreviewVisibility = Visibility.Collapsed;
                }

                var resourceLocater = new Uri("HIS.MC.DR.RM.RV.UI;component/Resources/WhiteBackgroundStyle.xaml", System.UriKind.Relative);
                var fdoc = Application.LoadComponent(resourceLocater) as FlowDocument;
                fdoc.PagePadding = new Thickness(5);
                var selectedItem = (p as RecordList_INOUT);
                SedationRecordTemplate_INOUT sedationRecord;
                SedationRecordTemplate_INOUT sedationRecordInfo = new SedationRecordTemplate_INOUT() { PT_NO = selectedItem.PT_NO, SERC_ID = Convert.ToDecimal(selectedItem.KEY_ID), UITM_DT = selectedItem.WRITING_DATE, PACT_ID = selectedItem.PACT_ID, NRPR_DEPT_CD = UserInformation.PLWK_DEPT_CD };

                sedationRecord = (SedationRecordTemplate_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordCommonViewerBL", "SelectSedationRecord", sedationRecordInfo);
                sedationRecord.TEMPLATE = "SedationRecordTemplate";
                fdoc = CreateDocument(sedationRecord);

                thisUserControl.flowDocViewer.Document = fdoc;

                AddSelectedRecordList(record);

                PrintedRecordList = SelectedRecordListCR;
            }

            #endregion
        }
        #region 정렬 관련
        /// <summary>
        /// name         : 목록조회 정렬
        /// desc         : 목록조회 정렬함
        /// author       : 김정훈
        /// create date  : 2013-03-12 
        /// update date  : 
        /// </summary>
        public void SelectListSortType(object p)
        {
            if (p == null)
            { return; }

            if (SelectedListSort_Type == null || SelectedListSort_Type.COMN_CD == "ASSEMBLING")
            { return; }

            IList<RecordList_INOUT> inObject = p as IList<RecordList_INOUT>;
            if (inObject.Count() == 0)
            { return; }
            HSFDTOCollectionBaseObject<RecordList_INOUT> returnObject = p as HSFDTOCollectionBaseObject<RecordList_INOUT>;

            RecordListByMedicalTreatmentDay = SortRecordList(SelectedListSort_Type.COMN_CD, inObject, returnObject);

            SelectedRecordListByMedicalTreatmentDay = CheckRecordList(SelectedListSort_Type.COMN_CD, inObject, SelectedRecordListByMedicalTreatmentDay);
        }

        /// <summary>
        /// name         : 조건별상세조회 목록조회 정렬
        /// desc         : 조건별상세조회 목록조회 정렬함
        /// author       : 김정훈
        /// create date  : 2013-03-13 
        /// update date  : 
        /// </summary>
        public void SelectListByCondtitionSortType(object p)
        {
            if (p == null)
            { return; }

            if (SelectedListSort_Type == null || SelectedListSort_Type.COMN_CD == "ASSEMBLING")
            { return; }

            IList<RecordList_INOUT> inObject = p as IList<RecordList_INOUT>;
            HSFDTOCollectionBaseObject<RecordList_INOUT> returnObject = p as HSFDTOCollectionBaseObject<RecordList_INOUT>;

            RecordListByCondition = SortRecordList(SelectedListSort_Type.COMN_CD, inObject, returnObject);

            SelectedRecordListByCondition = CheckRecordList(SelectedListSort_Type.COMN_CD, inObject, SelectedRecordListByCondition);
        }

        /// <summary>
        /// name         : 기록목록을 정렬함
        /// desc         : 정렬조건대로 기록목록을 정렬함
        /// author       : 김정훈
        /// create date  : 2013-03-14 
        /// update date  : 2024-01-22, 박찬규 , 응급초진 경과 분리
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> SortRecordList(string Sort_Type, IList<RecordList_INOUT> inObject, HSFDTOCollectionBaseObject<RecordList_INOUT> returnObject, HSFDTOCollectionBaseObject<MedicalTreatmentHistoryList_INOUT> historyObject = null)
        {
            if (Sort_Type == "ASSEMBLING")
            {
                //정보가 누락되어 있는 경우 수진일 정보로 채워줌
                //foreach (RecordList_INOUT inObjectItem in inObject)
                //{

                //}

                // 1. 진료과 
                // 2. 외래,응급,입원순 
                // 3. 날짜
                // 4-1. 외래 : 초진, 경과(나머지), 수술, 오더, 검체, 영상, 기능, 병리, 동의서, 스캔
                // 4-2. 응급 : 초진, 경과(나머지), 타과, 과별서식, 퇴실기록, 오더, 검체, 영상, 기능, 병리, 초기간호, 간호일지, 수술전상태, 수술간호기록, 수혈기록, 임상관찰, 퇴원간호계획, 마취전상태평가, 마취기록, 스캔
                // 4-3. 입원 : 초진, 경과(나머지), 타과, 수술기록, 과별서식, 퇴원기록, 오더, 검체, 영상, 기능, 병리, 초기간호, 간호일지, 수술전상태, 수술간호기록, 수혈기록, 임상관찰, 퇴원간호계획, 마취전상태평가, 마취기록, 스캔
                // * 필터 : 스캔_타병원기록 (입원시교육, 진료의뢰서, 타병원모든기록, 수탁검사의뢰, 입원약정, 낙상예방안내문, 119이송기록, 병원간환자이송기록, 선택진료신청서, DRG점검표, 대장암가족력) : 민원발생요인

                #region
                // {#} 작업중...
                ////IOrderedEnumerable<RecordList_INOUT> sortedList = inObject.OrderBy(a => a.PT_MED_DEPT_CD).ThenBy(b => b.PACT_TP_CD).ThenBy(d => d.WRITING_DATE).ThenBy(c => c.MDFM_CLS_CD);
                //IEnumerable<RecordList_INOUT> sortedList = from a in inObject
                //                                           join b in DepartmentGroup on a.WRITING_DEPT_CD equals b.DEPT_CD into _b
                //                                           from b in _b.DefaultIfEmpty() // outerjoin : into _b from b in _b.DefaultIfEmpty()
                //                                           let seqPACT_TP_CD = (a.PACT_TP_CD == "O" ? 1 :
                //                                                               a.PACT_TP_CD == "E" ? 2 :
                //                                                               a.PACT_TP_CD == "I" ? 3 : 9)
                //                                           let seqRECORD_DETAIL_TYPE = (
                //                                               // 외래
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "D001" ? 1001 :
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "D002" ? 1002 :
                //                                               //나머지 1090
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "D005" ? 1101 :
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_TYPE == "OR" ? 1200 :
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_SPECIMEN" ? 1301 :
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_PICTURE" ? 1302 :
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_FUNCTION" ? 1303 :
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_PATHOLOGY" ? 1304 :
                //                                                                       a.PACT_TP_CD == "O" && a.RECORD_TYPE == "SC" ? 1900 :
                //                                                                       a.PACT_TP_CD == "O" ? 1090 :
                //                                               //응급
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D030" ? 2001 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D031" ? 2002 :
                //                                               //나머지 2090
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D007" ? 2101 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D020" ? 2102 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D025" ? 2103 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_TYPE == "OR" ? 2200 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_SPECIMEN" ? 2301 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_PICTURE" ? 2302 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_FUNCTION" ? 2303 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_PATHOLOGY" ? 2304 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "01" ? 2401 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "09" ? 2402 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "08" ? 2403 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "11" ? 2404 :
                //                                               //a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "01" ? 2405 : // 수혈?
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "02" ? 2406 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "06" ? 2407 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D011" ? 2501 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D010" ? 2502 :
                //                                                                       a.PACT_TP_CD == "E" && a.RECORD_TYPE == "SC" ? 2900 :
                //                                                                       a.PACT_TP_CD == "E" ? 2090 :
                //                                               //입원
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D030" ? 3001 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D031" ? 3002 :
                //                                               //나머지 3090
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D007" ? 3101 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D005" ? 3102 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D020" ? 3103 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D006" ? 3104 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_TYPE == "OR" ? 3200 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_SPECIMEN" ? 3301 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_PICTURE" ? 3302 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_FUNCTION" ? 3303 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_PATHOLOGY" ? 3304 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "01" ? 3401 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "09" ? 3402 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "08" ? 3403 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "11" ? 3404 :
                //                                               //a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "01" ? 3405 : // 수혈?
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "02" ? 3406 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "06" ? 3406 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D011" ? 3501 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D010" ? 3502 :
                //                                                                       a.PACT_TP_CD == "I" && a.RECORD_TYPE == "SC" ? 3900 :
                //                                                                       a.PACT_TP_CD == "I" ? 3090 :
                //                                                                       9999
                //                                                                       )
                //                                           //orderby (b.SORT_SEQ ?? 99999) , seqPACT_TP_CD, a.WRITING_DATE, seqRECORD_DETAIL_TYPE // NVL처리 : (b.sort_seq ?? null대체값 )
                //                                           orderby (b == null ? 9999 : b.SORT_SEQ), seqPACT_TP_CD, a.WRITING_DATE, seqRECORD_DETAIL_TYPE, a.SORT_SEQ
                //                                           select a;
                #endregion

                // 1 진료과, 2:외래/응급/입원,  3.수진일, 4. 기록종류, 5.날짜
                IEnumerable<RecordList_INOUT> sortedList = from a in inObject
                                                           join b in DepartmentGroup on a.Items.MED_DEPT_CD equals b.DEPT_CD into _b
                                                           from b in _b.DefaultIfEmpty() // outerjoin : into _b from b in _b.DefaultIfEmpty()
                                                           let seqPACT_TP_CD = (a.Items.PACT_TP_CD == "O" ? 1 :
                                                                                a.Items.PACT_TP_CD == "E" ? 2 :
                                                                                a.Items.PACT_TP_CD == "I" ? 3 : 9)
                                                           let seqRECORD_DETAIL_TYPE = (
                                                                                       // 외래
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "D001" ? 1001 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "D002" ? 1002 :
                                                                                       //나머지 1090
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "D005" ? 1101 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_TYPE == "OR" ? 1200 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_SPECIMEN" ? 1301 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_PICTURE" ? 1302 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_FUNCTION" ? 1303 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_DETAIL_TYPE == "EX_PATHOLOGY" ? 1304 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_TYPE == "EC" ? 1800 :
                                                                                       a.PACT_TP_CD == "O" && a.RECORD_TYPE == "SC" ? 1900 :
                                                                                       a.PACT_TP_CD == "O" ? 1090 :
                                                                                       //응급                                                                                       
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D031" ? 2001 :
                                                                                       //2024-01-22, 박찬규 , 응급초진 경과 분리
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D029" ? 2002 :
                                                                                       //나머지 2090
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D007" ? 2101 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D020" ? 2102 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_TYPE == "OR" ? 2200 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_SPECIMEN" ? 2301 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_PICTURE" ? 2302 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_FUNCTION" ? 2303 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "EX_PATHOLOGY" ? 2304 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "01" ? 2401 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "09" ? 2402 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "08" ? 2403 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "11" ? 2404 :
                                                                                       //a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "01" ? 2405 : // 수혈?
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "02" ? 2406 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "06" ? 2407 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D011" ? 2501 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_DETAIL_TYPE == "D010" ? 2502 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_TYPE == "EC" ? 2800 :
                                                                                       a.PACT_TP_CD == "E" && a.RECORD_TYPE == "SC" ? 2900 :
                                                                                       a.PACT_TP_CD == "E" ? 2090 :
                                                                                       //입원
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D003" ? 3001 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D004" ? 3002 :
                                                                                       //나머지 3090
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D007" ? 3101 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D005" ? 3102 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D020" ? 3103 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D006" ? 3104 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_TYPE == "OR" ? 3200 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_SPECIMEN" ? 3301 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_PICTURE" ? 3302 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_FUNCTION" ? 3303 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "EX_PATHOLOGY" ? 3304 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "01" ? 3401 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "09" ? 3402 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "08" ? 3403 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "11" ? 3404 :
                                                                                       //a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "01" ? 3405 : // 수혈?
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "02" ? 3406 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "06" ? 3406 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D011" ? 3501 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_DETAIL_TYPE == "D010" ? 3502 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_TYPE == "EC" ? 3800 :
                                                                                       a.PACT_TP_CD == "I" && a.RECORD_TYPE == "SC" ? 3900 :
                                                                                       a.PACT_TP_CD == "I" ? 3090 :
                                                                                       9999
                                                                                       )
                                                           //orderby (b == null ? 9999 : b.SORT_SEQ), seqPACT_TP_CD, a.PACT_ID, seqRECORD_DETAIL_TYPE, a.SORT_SEQ
                                                           orderby (b == null ? Decimal.Parse("9999") : b.SORT_SEQ)
                                                                  , seqPACT_TP_CD
                                                                  , (a.PACT_TP_CD == "O" ? null : a.Items.MED_FROM_DATE)
                                                                  , seqRECORD_DETAIL_TYPE
                                                                  , a.WRITING_DATE
                                                                  , a.SORT_SEQ
                                                           select a;

                returnObject = new HSFDTOCollectionBaseObject<RecordList_INOUT>(sortedList.ToList());
            }
            else if (Sort_Type == "NEW")
            {
                IOrderedEnumerable<RecordList_INOUT> sortedList = inObject.OrderByDescending(a => a.WRITING_DATE);
                returnObject = new HSFDTOCollectionBaseObject<RecordList_INOUT>(sortedList.AsEnumerable());
            }
            else if (Sort_Type == "OLD")
            {
                IOrderedEnumerable<RecordList_INOUT> sortedList = inObject.OrderBy(a => a.WRITING_DATE);
                returnObject = new HSFDTOCollectionBaseObject<RecordList_INOUT>(sortedList.AsEnumerable());
            }

            return returnObject;

        }

        /// <summary>
        /// name         : 기록목록을 기본 선택함
        /// desc         : 정렬조건대로 기록목록을 선택함
        /// author       : 김정훈
        /// create date  : 2013-03-14 
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<RecordList_INOUT> CheckRecordList(string Sort_Type, IList<RecordList_INOUT> inObject, HSFDTOCollectionBaseObject<RecordList_INOUT> returnObject)
        {
            if (Sort_Type == "ASSEMBLING")
            {
                // ASSEMBLING에서 제외할 스캔
                //--ADE	입원시교육         
                //--IOF	진료의뢰서          
                //--MDR	타병원 모든 기록    
                //--REQ	수탁검사의뢰        
                //--ADD	입원 약정서          
                //--FE1	낙상예방안내문      
                //--EMS	119 환자이송기록    
                //--IHT	병원간환자이송기록  
                //--SDR	선택진료신청서      
                //--DRG	DRG 점검표          
                //--CRC	대장암 가족력       
                List<String> scanList = new List<String> { "ADE", "IOF", "MDR", "REQ", "ADD", "FE1", "EMS", "IHT", "SDR", "DRG", "CRC" };
                IEnumerable<RecordList_INOUT> sortedList = from a in inObject
                                                           where !scanList.Contains(a.RECORD_DETAIL_TYPE)
                                                           select a;

                returnObject = new HSFDTOCollectionBaseObject<RecordList_INOUT>(sortedList.AsEnumerable());
            }

            return returnObject;
        }


        // 조건별상세조회 정렬 토글버튼 변경
        private void ChangeSortRecordListByConditionToggle()
        {
            thisUserControl.tbtnSortRecordListByCondition.IsChecked = false;
        }

        #endregion 정렬 관련

        #region 의무기록실 미작성/미비/전자서명누락 관련
        /// <summary>
        /// name         : DC현황조회
        /// desc         : DC현황조회 화면을 호출합니다.
        /// author       : 김정훈
        /// create date  : 2013-03-02 
        /// update date  : 
        /// </summary>
        public void SelectDCRecordCurrent()
        {
            PopUpBase popup = base.OnLoadPopupMenu("DR_HIS.MC.DR.RM.IN.UI_/SelectDCRecordCurrentCircumstancesAsk.xaml", PatientInformation.PT_NO, PatientInformation.PT_NM);
            popup.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
            popup.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            MainMenuInfo mainMenuInfo = popup.Content as MainMenuInfo;

            if (mainMenuInfo != null)
            {
                UserControlBase userControlBase = mainMenuInfo.INSTANCE_OF_MENU as UserControlBase;
                //유저컨트롤 베이스 자원 접근
                //(userControlBase as dynamic).txtPtNO = PatientInformation.PT_NO;


                if (userControlBase != null)
                {
                    ViewModelBase viewModel = userControlBase.DataContext as ViewModelBase;

                    if (viewModel != null)
                    {
                        //뷰모델 베이스 자원 접근
                        //(viewModel as dynamic).PT_NO = PatientInformation.PT_NO;
                    }
                }
            }

            popup.ShowDialog();
        }

        /// <summary>
        /// name         : 미작성등록
        /// desc         : 미작성등록 화면을 호출합니다.
        /// author       : 강성희
        /// create date  : 2016-05-02 
        /// update date  : 
        /// </summary>
        public void SaveNonWritingRecord()
        {
            PopUpBase popup = base.OnLoadPopupMenu("DR_HIS.MC.DR.RM.IN.UI_/SaveNonWritingRecordRegistration.xaml", PatientInformation.PT_NO, PatientInformation.PT_NM, SelectedMedicalTreatmentHistory.PACT_ID);
            popup.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
            popup.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            MainMenuInfo mainMenuInfo = popup.Content as MainMenuInfo;

            if (mainMenuInfo != null)
            {
                UserControlBase userControlBase = mainMenuInfo.INSTANCE_OF_MENU as UserControlBase;
                //유저컨트롤 베이스 자원 접근
                //(userControlBase as dynamic).model.OperationAttributeInformation = test;


                if (userControlBase != null)
                {
                    ViewModelBase viewModel = userControlBase.DataContext as ViewModelBase;

                    if (viewModel != null)
                    {
                        //뷰모델 베이스 자원 접근
                        //(viewModel as dynamic).OperationAttributeInformation = selectedOPTerm;
                        //(viewModel as dynamic).SelectedDataChanged += new Action<OperationAttributeInformation_INOUT>(OperationTerminologyAttribute_SelectedDataChanged);

                    }
                }
            }

            popup.ShowDialog();
        }

        /// <summary>
        /// name         : 미비등록
        /// desc         : 미비등록 화면을 호출합니다.
        /// author       : 강성희
        /// create date  : 2016-05-02 
        /// update date  : 
        /// </summary>
        public void SaveIncompleteRecord()
        {
            PopUpBase popup = base.OnLoadPopupMenu("DR_HIS.MC.DR.RM.IN.UI_/SaveIncompleteRecordRegistration.xaml", PatientInformation.PT_NO, PatientInformation.PT_NM, SelectedMedicalTreatmentHistory.PACT_ID);
            popup.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
            popup.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            MainMenuInfo mainMenuInfo = popup.Content as MainMenuInfo;

            if (mainMenuInfo != null)
            {
                UserControlBase userControlBase = mainMenuInfo.INSTANCE_OF_MENU as UserControlBase;
                //유저컨트롤 베이스 자원 접근
                //(userControlBase as dynamic).model.OperationAttributeInformation = test;


                if (userControlBase != null)
                {
                    ViewModelBase viewModel = userControlBase.DataContext as ViewModelBase;

                    if (viewModel != null)
                    {
                        //뷰모델 베이스 자원 접근
                        //(viewModel as dynamic).OperationAttributeInformation = selectedOPTerm;
                        //(viewModel as dynamic).SelectedDataChanged += new Action<OperationAttributeInformation_INOUT>(OperationTerminologyAttribute_SelectedDataChanged);

                    }
                }
            }

            popup.ShowDialog();
        }

        /// <summary>
        /// name         : 전자서명누락등록
        /// desc         : 전자서명누락등록 화면을 호출합니다.
        /// author       : 강성희
        /// create date  : 2016-05-02 
        /// update date  : 
        /// </summary>
        public void SaveElectronicSignature()
        {
            PopUpBase popup = base.OnLoadPopupMenu("DR_HIS.MC.DR.RM.IN.UI_/SaveElectronicSignatureOmissionRecordRegistration.xaml", PatientInformation.PT_NO, PatientInformation.PT_NM, SelectedMedicalTreatmentHistory.PACT_ID);
            popup.Owner = Window.GetWindow(this.Owner);   // ViewModelBase에서 사용하는 경우
            popup.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            MainMenuInfo mainMenuInfo = popup.Content as MainMenuInfo;

            if (mainMenuInfo != null)
            {
                UserControlBase userControlBase = mainMenuInfo.INSTANCE_OF_MENU as UserControlBase;
                //유저컨트롤 베이스 자원 접근
                //(userControlBase as dynamic).model.OperationAttributeInformation = test;


                if (userControlBase != null)
                {
                    ViewModelBase viewModel = userControlBase.DataContext as ViewModelBase;

                    if (viewModel != null)
                    {
                        //뷰모델 베이스 자원 접근
                        //(viewModel as dynamic).OperationAttributeInformation = selectedOPTerm;
                        //(viewModel as dynamic).SelectedDataChanged += new Action<OperationAttributeInformation_INOUT>(OperationTerminologyAttribute_SelectedDataChanged);

                    }
                }
            }

            popup.ShowDialog();
        }
        #endregion 의무기록실 미작성/미비/전자서명누락 관련

        #region [DTO 형태로 가져온 정보를 TEMPLATE에 바인딩]

        /// <summary>
        /// DTO 정보와 TEMPLATE 으로 FlowDocument 생성
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public FlowDocument CreateDocument(MedicalRecordTemplate_INOUT dto)
        {



            ReportData data = new ReportData();

            foreach (var property in dto.GetType().GetProperties())
            {
                if (property.GetSetMethod() != null && dto.GetType().GetProperty(property.Name) != null)
                {
                    if (property.PropertyType.Name.Equals("HSFDTOCollectionBaseObject`1") || property.PropertyType.Name.Equals("DataTable"))
                    {
                        object list = dto.GetType().GetProperty(property.Name).GetValue(dto, null);

                        if (list is IList)
                        {
                            data.DataTables.Add(ListToTable(list as IList, property.Name));
                        }
                        else if (list is DataTable)
                        {
                            ((DataTable)list).TableName = property.Name;
                            data.DataTables.Add(list as DataTable);
                        }
                    }
                    else
                    {
                        data.ReportDocumentValues.Add(property.Name, dto.GetType().GetProperty(property.Name).GetValue(dto, null));
                    }
                }
            }

            var reportDocument = new HSF.Report.Core.ReportDocument();

            if (dto.TEMPLATE == "PictureExamTemplate")
            {
                PictureExamTemplate_OUT objTemp = dto as PictureExamTemplate_OUT;

                //특수 영상검사 오더 발행 시 CI 필수 입력 기능 요청 관련 (SR 201910-00293)
                //2019-11-20 전까지는 기존양식, 그 이후는 CI값이 있는경우 새로운양식 띄우기
                //if (objTemp.COPN_CNTE != null) //테스트
                if (objTemp.COPN_CNTE != null && objTemp.IPTN_DTM.ToString().CompareTo("2019-11-20") >= 0)
                {
                    reportDocument.XamlData = TemplateDownload_CI(dto.TEMPLATE);
                }
                else
                {
                    reportDocument.XamlData = TemplateDownload(dto.TEMPLATE);
                }
            }
            else
            {
                reportDocument.XamlData = TemplateDownload(dto.TEMPLATE);
            }

            //reportDocument.XamlData = TemplateDownload(dto.TEMPLATE);

            FlowDocument doc = reportDocument.CreateFlowDocument(data);


            #region CANVAS 추가부분
            if (dto.TEMPLATE == "FuncExamTemplate")
            {
                //코드 인스펙션. 사용하지 않는 변수 주석. 정성호 수정 2013-11-18
                //List<Canvas> canvasList = new List<Canvas>();

                InlineCanvasSection CanvasSection = doc.FindName(dto.FORM_NM) as InlineCanvasSection;

                #region 기능검사 flowdocument
                SelectResearchList_INOUT inData = new SelectResearchList_INOUT();
                inData.IN_IPTN_NO = dto.KEY;
                HSFDTOCollectionBaseObject<SelectResearchList_INOUT> in_ResearchList = new HSFDTOCollectionBaseObject<SelectResearchList_INOUT>();
                in_ResearchList = (HSFDTOCollectionBaseObject<SelectResearchList_INOUT>)UIMiddlewareAgent.InvokeBizService(BIZ_CLASS, "SelectResearchList", inData);

                // 이미지, ECG를 제외한 판독지만의 리스트를 만들어 MEDICALFORMLIST에 저장한다.
                // (이미지, ECG는 항상 마지막 일련번호에 저장되므로, 일련번호를 다시 정리해 주지는 않아도 된다) 
                in_ResearchList = in_ResearchList.Filter(r => r.MDFM_ID != 3813 && r.MDFM_ID != 1000);

                SelectMedicalTreatmentRecordAskByMdrcId MdrcIdObj = new SelectMedicalTreatmentRecordAskByMdrcId();
                HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> XamlInputList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();

                MedicalTreatmentRecordAskPersonalCondition_INOUT personalCondition = new MedicalTreatmentRecordAskPersonalCondition_INOUT() { WhiteBackGround = true, MenuVisible = false, ExpanderVisible = false, FunctionExamSettingYn = "Y" };
                XamlInputList = (MdrcIdObj.DataContext as SelectMedicalTreatmentRecordAskByMdrcIdData).InputList;

                // 판독지 리스트의 갯수에 따라서 처리
                if (in_ResearchList.Count > 0)
                {
                    foreach (SelectResearchList_INOUT cItem in in_ResearchList)
                    {
                        if (!string.IsNullOrEmpty(cItem.MDFM_INPT_NOTM.ToString()))
                        {
                            // 서식지 값 조회
                            SelectFormValueList_INOUT inData1 = new SelectFormValueList_INOUT();
                            inData1.IN_IPPR_ID = cItem.IPPR_ID.ToString();
                            inData1.IN_MDFM_INPT_NOTM = (decimal)cItem.MDFM_INPT_NOTM;   // 기록지 입력개정번호         -> 이부분 변경됨(DTO에 IN_MDFM_INPT_NOTM 새로 생김)
                            inData1.IN_MDFM_ID = (decimal)cItem.MDFM_ID;	              // 진료서식ID
                            inData1.IN_MDFM_FOM_SEQ = (decimal)cItem.MDFM_FOM_SEQ;       // 서식 개정번호

                            // 서식지 조회 파라미터 작성
                            XamlInputList.Add(new MedicalTreatmentRecordAskItemHeader_INOUT()
                            {
                                IPPR_ID = cItem.IPPR_ID,
                                MDRC_FOM_SEQ = (decimal)cItem.MDFM_INPT_NOTM,  //진료기록 개정 순번
                                MDFM_ID = (decimal)cItem.MDFM_ID,
                                MDFM_FOM_SEQ = cItem.MDFM_FOM_SEQ,
                                MDFM_CLS_CD = cItem.MDFM_CLS_CD,
                                MDFM_CLS_DTL_CD = cItem.MDFM_CLS_DTL_CD,
                                MDFM_NM = cItem.MDFM_NM,
                                MDFM_CLS_NM = "",
                                REC_DTM = DateTime.Now,//cItem.REC_DTM,    //작성시간
                                WRTR_DEPT_NM = "", //cItem.WRTR_DEPT_NM,  //작성자진료과명
                                MED_DT = DateTime.Now, //cItem.MED_DT,  // 진료일자
                                MDRC_SBTIT_INPT_NM = "",  //진료기록 부제목명
                                WK_STF_NO = cItem.WK_STF_NO, // 작성자사번(서명)
                                WK_NM = cItem.WK_NM, // 작성자명
                                USE_GRP_CD = cItem.USE_GRP_CD, //판독지 작성자 직종
                                MDRC_WRT_STS_CD = cItem.EXM_PRGR_STS_CD //판독, 가판독 여부
                            });
                        }
                    }

                    HSFDTOCollectionBaseObject<MedicalTreatmentRecordFlowDocXamlList_OUT> OutputList = MdrcIdObj.SelectMedicalTreatmentRecordFunctionExamAskByMDRCIDFlowdoc(XamlInputList, personalCondition);

                    foreach (var output in OutputList)
                    {
                        FlowDocument fdoc = output.MedrecFlowDocument;
                        Section section = new Section();
                        List<Block> flowDocumentBlocks = new List<Block>(fdoc.Blocks);

                        foreach (Block aBlock in flowDocumentBlocks)
                        {
                            section.Blocks.Add(aBlock);
                        }
                        CanvasSection.Blocks.Add(section);
                    }
                }
                #endregion 기능검사 flowdocument
                #endregion CANVAS 추가부분                
            }
            return doc;
        }

        DataTable ListToTable(IList list, string tableName)
        {
            DataTable dt = new DataTable();
            dt.TableName = tableName;

            int k = -1;

            foreach (var property2 in list.GetType().GetGenericArguments()[0].GetProperties())
            {

                switch (property2.Name)
                {
                    //case "HIS_HSP_TP_CD" :
                    //case "HIS_IP_ADDR" :
                    //case "HIS_LSH_DTM" :
                    //case "HIS_PRGM_ID" :
                    //case "HIS_PRGM_NM" :
                    //case "HIS_SID" :
                    //case "HIS_STF_NO" :
                    //case "HIS_USE_YN":
                    //    break;
                    default:
                        if (property2.GetSetMethod() != null)
                        {
                            k++;

                            if (Nullable.GetUnderlyingType(property2.PropertyType) != null)
                                dt.Columns.Add(property2.Name, System.Type.GetType(Nullable.GetUnderlyingType(property2.PropertyType).FullName));
                            else
                                dt.Columns.Add(property2.Name, property2.PropertyType);

                            switch (k)
                            {
                                case 0:
                                case 1:
                                case 2:
                                    dt.Columns[property2.Name].Caption = "A";
                                    break;
                                case 3:
                                case 4:
                                    dt.Columns[property2.Name].Caption = "K";
                                    break;
                                case 5:
                                case 6:
                                case 7:
                                    dt.Columns[property2.Name].Caption = "B";
                                    break;
                                case 8:
                                case 9:
                                    dt.Columns[property2.Name].Caption = "C";
                                    break;
                                case 10:
                                case 11:
                                    dt.Columns[property2.Name].Caption = "D";
                                    break;
                                case 12:
                                    dt.Columns[property2.Name].Caption = "D";
                                    break;
                            }
                        }
                        break;
                }
            }

            int i = 0;

            foreach (var item in list)
            {
                DataRow dr = dt.NewRow();

                foreach (var property2 in item.GetType().GetProperties())
                {
                    switch (property2.Name)
                    {
                        //case "HIS_HSP_TP_CD":
                        //case "HIS_IP_ADDR":
                        //case "HIS_LSH_DTM":
                        //case "HIS_PRGM_ID":
                        //case "HIS_PRGM_NM":
                        //case "HIS_SID":
                        //case "HIS_STF_NO":
                        //case "HIS_USE_YN":
                        //    break;                        
                        default:
                            if (property2.GetSetMethod() != null)
                            {
                                if (Nullable.GetUnderlyingType(property2.PropertyType) != null)
                                    dr[property2.Name] = property2.GetValue(item, null) ?? DBNull.Value;
                                else
                                    dr[property2.Name] = property2.GetValue(item, null);
                            }
                            break;
                    }
                }

                i++;

                dt.Rows.Add(dr);
            }

            return dt;
        }

        // DTO 에 해당하는 템플릿 가져오기
        string TemplateDownload(string path)
        {
            using (System.Net.WebClient client = new System.Net.WebClient())
            {

                //byte[] buffer = client.DownloadData("http://172.17.12.62/MR/Templates/" + path + ".xaml");
                byte[] buffer = client.DownloadData(HIS.UI.Core.ConfigManager.CC.FileServerUrl + "/HISFILE01/MC/MdrecVwrTmplFile/Templates/" + path + ".xaml");
                return System.Text.Encoding.UTF8.GetString(buffer);
            }
        }

        // DTO 에 해당하는 템플릿 가져오기, xaml파일 생성 시 저장방식이 UT여야함
        string TemplateDownload_CI(string path)
        {
            using (System.Net.WebClient client = new System.Net.WebClient())
            {
                byte[] buffer = client.DownloadData(HIS.UI.Core.ConfigManager.CC.FileServerUrl + "/HISFILE01/MC/MdrecVwrTmplFile/Templates/" + path + "_CI.xaml");
                return System.Text.Encoding.UTF8.GetString(buffer);
            }
        }

        #endregion [sample]

        #region 웹 제공용
        /// <summary>
        /// name         : WEB용 기록조회 함수
        /// desc         : 기록조회를 WEB용으로 제공하기 위해 조회된 내용을 HTML STRING으로 변환하여 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2013-06-28
        /// update date  : 수정일자, 수정자, 수정개요 
        /// </summary>
        public String SearchMultiRecordContentHTML(HSFDTOCollectionBaseObject<RecordList_INOUT> p, bool bViewer = true, bool bBlackTheme = false)
        {
            string rtnOutput = "";
            string byRecordNextLineSpace = "<div style=\"height:30px;\"></div>";
            StringBuilder css = new StringBuilder();
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> rtnResult = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();

            rtnResult = SearchMultiRecordContentHtml(p);

            if (rtnResult.Count() > 0)
            {
                // HTML 생성
                foreach (PrintRecordList_INOUT rtnFdoc in rtnResult)
                {
                    // Flowdocument List가 존재하는 기록(검체검사)
                    if (rtnFdoc.RECORD_DETAIL_TYPE != "EX_FUNCTION" && rtnFdoc.RecordFlowDocumentList.Count() > 0)
                    {
                        foreach (var a in rtnFdoc.RecordFlowDocumentList)
                        {
                            rtnOutput = rtnOutput + HtmlConverter.ConvertFlowDocuToHtmlBody(a, css);
                            rtnOutput = rtnOutput + byRecordNextLineSpace; //기록단위 개행 처리 
                        }
                    }
                    // 검체검사 이외의 기록
                    else
                    {
                        // 진료기록
                        if (rtnFdoc.RECORD_TYPE.Equals("DR"))
                        {
                            //서식생성기 교체에 따른 신규 조회 방식을 적용하지 않는 기록지들은 FlowDocument로 렌더링 후 변환
                            if (rtnFdoc.RecordFlowDocument != null && rtnFdoc.RecordFlowDocument.Blocks.Count != 0)
                            {
                                rtnOutput = rtnOutput + HtmlConverter.ConvertFlowDocuToHtmlBody(rtnFdoc.RecordFlowDocument, css);
                                rtnOutput = rtnOutput + byRecordNextLineSpace; //기록단위 개행 처리  
                            }
                            else
                            {
                                SelectMedicalTreatmentRecordAskByMdrcId MdrcIdObj = new SelectMedicalTreatmentRecordAskByMdrcId();

                                MedicalTreatmentRecordAskItemHeader_INOUT IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();
                                IN_HEADER.MULTI_MDRC_ID = Convert.ToString(rtnFdoc.MDRC_ID);
                                HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> in_HeaderList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
                                in_HeaderList = (HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>)UIMiddlewareAgent.InvokeBizService("HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "SelectMedicalTreatmentRecordAskClassByMultiMDRCID", IN_HEADER);

                                MedicalTreatmentRecordAskPersonalCondition_INOUT personalCondition = new MedicalTreatmentRecordAskPersonalCondition_INOUT() { WhiteBackGround = true, MenuVisible = false, ExpanderVisible = false, NPRecAsk = NPRecAskYN };

                                rtnOutput = rtnOutput + MdrcIdObj.SelectMedicalTreatmentRecordAskHtml(in_HeaderList, personalCondition, bViewer);
                                rtnOutput = rtnOutput + byRecordNextLineSpace; //기록단위 개행 처리

                                // 자원해제
                                MdrcIdObj.Dispose();
                            }
                        }
                        // 기능검사 과별서식
                        else if (rtnFdoc.RECORD_DETAIL_TYPE == "EX_FUNCTION")
                        {
                            // 기능검사 이미지 정보
                            string sTail = string.Empty;

                            // 기능검사 웹서비스 호출시에는 의무기록뷰어용 검사항목 정보를 제외한다.
                            if (rtnFdoc.RecordFlowDocumentList.Count() > 0 && bViewer == true)
                            {
                                if (rtnFdoc.RecordFlowDocumentList.Count() > 1)
                                {
                                    rtnOutput = rtnOutput + HtmlConverter.ConvertFlowDocuToHtmlBody(rtnFdoc.RecordFlowDocumentList[0], css);    // 기능검사 내용
                                    sTail = HtmlConverter.ConvertFlowDocuToHtmlBody(rtnFdoc.RecordFlowDocumentList[1], css);                    // 기능검사 첨부 이미지
                                }
                                else
                                {
                                    rtnOutput = rtnOutput + HtmlConverter.ConvertFlowDocuToHtmlBody(rtnFdoc.RecordFlowDocumentList[0], css);
                                }
                            }

                            // 작성된 기능검사 과별서식 Html 변환
                            if (rtnFdoc.RecordFunctionExamTemplate != null && (rtnFdoc.RecordFunctionExamTemplate.TEMPLATE.Equals("FuncExamTemplate")))
                            {
                                // 기능검사 작성자 정보 변수
                                string sWk_Stf_No = string.Empty;
                                string sWk_Nm = string.Empty;

                                SelectResearchList_INOUT inData = new SelectResearchList_INOUT();
                                inData.IN_IPTN_NO = rtnFdoc.RecordFunctionExamTemplate.KEY;

                                HSFDTOCollectionBaseObject<SelectResearchList_INOUT> in_ResearchList = new HSFDTOCollectionBaseObject<SelectResearchList_INOUT>();
                                in_ResearchList = (HSFDTOCollectionBaseObject<SelectResearchList_INOUT>)UIMiddlewareAgent.InvokeBizService(BIZ_CLASS, "SelectResearchList", inData);

                                // 이미지, ECG를 제외한 판독지만의 리스트를 만들어 MEDICALFORMLIST에 저장한다.
                                // (이미지, ECG는 항상 마지막 일련번호에 저장되므로, 일련번호를 다시 정리해 주지는 않아도 된다)
                                in_ResearchList = in_ResearchList.Filter(r => r.MDFM_ID != 3813 && r.MDFM_ID != 1000);
                                HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> FuncExamFormHeaderList = TransPandocToRecordHeader(in_ResearchList);

                                foreach (MedicalTreatmentRecordAskItemHeader_INOUT m in FuncExamFormHeaderList)
                                {
                                    if (!string.IsNullOrEmpty(rtnOutput))
                                        rtnOutput += byRecordNextLineSpace;

                                    m.MedRecStructureInfo = MedicalTreatmentRecordStructureInfoSelect(m); //폼정보 구성
                                    HSFDTOCollectionBaseObject<MedicalTreatmentRecordFormElementValueInfo_OUT> FunctionExamFormValueList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordFormElementValueInfo_OUT>();
                                    FunctionExamFormValueList = SelectFunctionExamFormValueList(m);
                                    m.MedRecStructureInfo.FormItemValueInfo = FunctionExamFormValueList;

                                    // 기능검사 작성자 정보 변수
                                    sWk_Stf_No = m.WK_STF_NO;
                                    sWk_Nm = m.WK_NM;

                                    // 기능검사 서식 HTML 생성
                                    HIS.MC.DR.RM.RS.UI.Common.ItemToHtmlConvert htmlConvert = new HIS.MC.DR.RM.RS.UI.Common.ItemToHtmlConvert();
                                    rtnOutput = rtnOutput + htmlConvert.Convert(m, false, bBlackTheme);
                                }

                                // 기능검사 작성자 정보
                                if (!String.IsNullOrEmpty(sWk_Stf_No))
                                {
                                    SelectMedicalTreatmentRecordAskByMdrcId MdrcIdObj = new SelectMedicalTreatmentRecordAskByMdrcId();
                                    rtnOutput = rtnOutput + byRecordNextLineSpace + MdrcIdObj.SelectMedicalTreatmentRecordFunctionExamAskWriterInfo(sWk_Nm, sWk_Stf_No, bBlackTheme);

                                    // 자원해제
                                    MdrcIdObj.Dispose();
                                }

                                // 기능검사 첨부된 이미지가 존재 한다면 서식 <-> 이미지 라인 공백 추가
                                // 기능검사 웹서비스 호출시에는 첨부된 이미지는 생략한다.(모바일/대쉬보드에서 첨부된 이미지는 FTP를 통해 이미지 다운함.)
                                if (!string.IsNullOrEmpty(sTail) && bViewer == true)
                                {
                                    rtnOutput = rtnOutput + byRecordNextLineSpace + sTail;
                                }

                                rtnOutput = rtnOutput + byRecordNextLineSpace; //기록단위 개행 처리 
                            }
                        }
                        else // 기타 기존 FlowDocument 구성해서 HTML로 변환하는 기록들
                        {
                            if (rtnFdoc.RecordFlowDocument != null && rtnFdoc.RecordFlowDocument.Blocks.Count != 0)
                            {
                                rtnOutput = rtnOutput + HtmlConverter.ConvertFlowDocuToHtmlBody(rtnFdoc.RecordFlowDocument, css);
                                rtnOutput = rtnOutput + byRecordNextLineSpace; //기록단위 개행 처리  
                            }
                        }
                    }
                }

            }

            #region HTML 문서 생성

            #region 1. 웹 의무기록뷰어

            // 웹 의무기록뷰어 - Header
            String htmlHeaderString = "<!DOCTYPE html>" + Environment.NewLine
                            + "<html>" + Environment.NewLine
                            + "<head>" + Environment.NewLine
                            + "<meta content='text/html; charset=utf-8' http-equiv='Content-Type'>" + Environment.NewLine
                            + "<meta http-equiv='X-UA-Compatible' content='IE=8'>" + Environment.NewLine
                            + "<title>Viewer</title>" + Environment.NewLine
                            + "<style type='text/css'>" + Environment.NewLine
                            + "* { margin:0px;padding:0px; }" + Environment.NewLine
                            + "body { font-family:'Malgun Gothic';font-size:12px; }" + Environment.NewLine
                            + "table { position:relative;border-collapse:collapse; border-spacing:0px;}" + Environment.NewLine
                            + "td { height:18px;border-collapse:collapse; vertical-align:top;}" + Environment.NewLine
                            + "table td, table th { padding:0; border-spacing:0px;}" + Environment.NewLine
                            + ".line_height { margin-bottom:15px; }" + Environment.NewLine
                            //+ ".preserve { white-space:pre-wrap; }" + Environment.NewLine
                            + css.ToString() + Environment.NewLine
                            + "</style>" + Environment.NewLine
                            + "<Script Language='JavaScript'>" + Environment.NewLine
                            + "function ConvertImageSize(orgImage)" + Environment.NewLine
                            + "{" + Environment.NewLine
                            + "var newImage = new Image();" + Environment.NewLine
                            + "var iImageWidth;" + Environment.NewLine
                            + "var iImageHeight;" + Environment.NewLine
                            + "var iRate;" + Environment.NewLine
                            + "newImage.src = orgImage.src;" + Environment.NewLine
                            + "var iImageWidth;" + Environment.NewLine
                            + "iImageWidth = newImage.width;" + Environment.NewLine
                            + "iImageHeight = newImage.height;" + Environment.NewLine
                            + "if (iImageWidth < 500)" + Environment.NewLine
                            + "{" + Environment.NewLine
                            + "orgImage.width	= iImageWidth;" + Environment.NewLine
                            + "orgImage.height	= iImageHeight;" + Environment.NewLine
                            + "}" + Environment.NewLine
                            + "else if (iImageWidth > 500)" + Environment.NewLine
                            + "{" + Environment.NewLine
                            + "orgImage.width = 500;" + Environment.NewLine
                            + "iRate = 500 / iImageWidth;" + Environment.NewLine
                            + "orgImage.height = iImageHeight * iRate;" + Environment.NewLine
                            + "}" + Environment.NewLine
                            + "}" + Environment.NewLine
                            + "function ResizeImage(orgImage)" + Environment.NewLine
                            + "{" + Environment.NewLine
                            + "}" + Environment.NewLine
                            + "</Script>" + Environment.NewLine
                            + "</head>" + Environment.NewLine
                            //+ "<body style='margin:20px;'>" + Environment.NewLine;
                            + "<body oncontextmenu= 'javascript:return false;' id='oBody' bgcolor='#ffffff' background='../../../IMAGES/COMMON/REPORT/bg_CreateMedCertificate_01.gif' style='width:100%;overflow-x:hidden;overflow-y:auto;'>" + Environment.NewLine
                            + "<table width='600' height='50' border='0' cellpadding='0' cellspacing='0'>" + Environment.NewLine
                            + "<tr>" + Environment.NewLine
                            + "<td align='middle' height='50' valign='top'>" + Environment.NewLine
                            + "<img src='../../../IMAGES/CommonViewer/ImgLogo.png' alt='' border='0'/><br/>" + Environment.NewLine
                            + "</td>" + Environment.NewLine
                            + "</tr>" + Environment.NewLine
                            + "</table>" + Environment.NewLine;

            // 웹 의무기록뷰어 - Tail
            String htmlTagString =
                                "<table width='600' border='0' cellpadding='0' cellspacing='0'>" + Environment.NewLine
                            + "<tr>" + Environment.NewLine
                            + "<td colspan='3' valign='bottom'>" + Environment.NewLine
                            + "<hr size='1' color='#c8c8c8' width='100%' height='1'/>" + Environment.NewLine
                            + "</td>" + Environment.NewLine
                            + "</tr>" + Environment.NewLine
                            + "<tr>" + Environment.NewLine
                            + "<td id='oFooterText' height='30' align='middle' colspan='3' valign='top'>" + Environment.NewLine
                            + "본 서식은 서울대학교병원 전자의무기록시스템에서 사용하는 것으로 의무기록 문서로서 효용가치가 없습니다." + Environment.NewLine
                            + "</td>" + Environment.NewLine
                            + "</tr>" + Environment.NewLine
                            + "<tr>" + Environment.NewLine
                            + "<td align='middle' valign='bottom' colspan='3' height='30'>" + Environment.NewLine
                            + "<img src='../../../IMAGES/COMMON/REPORT/report_logo_bottom.gif' width='147' height='30' alt='' border='0'>" + Environment.NewLine
                            + "</td>" + Environment.NewLine
                            + "</body>" + Environment.NewLine
                            + "</html>" + Environment.NewLine;

            #endregion

            #region 2. 기능검사 조회

            String htmlExamHeaderString = "<!DOCTYPE html>" + Environment.NewLine
                                    + "<html>" + Environment.NewLine
                                    + "<head>" + Environment.NewLine
                                    + "<meta content='text/html; charset=utf-8' http-equiv='Content-Type'>" + Environment.NewLine
                                    + "<title>Viewer</title>" + Environment.NewLine
                                    + "<style type='text/css'>" + Environment.NewLine
                                    + "* { margin:0px;padding:0px; }" + Environment.NewLine
                                    + "body { font-family:'Malgun Gothic';font-size:12px; }" + Environment.NewLine
                                    + "table { position:relative;border-collapse:collapse; border-spacing:0px;}" + Environment.NewLine
                                    + "td { height:18px;border-collapse:collapse; vertical-align:top;}" + Environment.NewLine
                                    + "table td, table th { padding:0; border-spacing:0px;}" + Environment.NewLine
                                    + ".line_height { margin-bottom:15px; }" + Environment.NewLine
                                    //+ ".preserve { white-space:pre-wrap; }" + Environment.NewLine
                                    + css.ToString() + Environment.NewLine
                                    + "</style>" + Environment.NewLine
                                    + "<Script Language='JavaScript'>" + Environment.NewLine
                                    + "function ConvertImageSize(orgImage)" + Environment.NewLine
                                    + "{" + Environment.NewLine
                                    + "var newImage = new Image();" + Environment.NewLine
                                    + "var iImageWidth;" + Environment.NewLine
                                    + "var iImageHeight;" + Environment.NewLine
                                    + "var iRate;" + Environment.NewLine
                                    + "newImage.src = orgImage.src;" + Environment.NewLine
                                    + "var iImageWidth;" + Environment.NewLine
                                    + "iImageWidth = newImage.width;" + Environment.NewLine
                                    + "iImageHeight = newImage.height;" + Environment.NewLine
                                    + "if (iImageWidth < 500)" + Environment.NewLine
                                    + "{" + Environment.NewLine
                                    + "orgImage.width	= iImageWidth;" + Environment.NewLine
                                    + "orgImage.height	= iImageHeight;" + Environment.NewLine
                                    + "}" + Environment.NewLine
                                    + "else if (iImageWidth > 500)" + Environment.NewLine
                                    + "{" + Environment.NewLine
                                    + "orgImage.width = 500;" + Environment.NewLine
                                    + "iRate = 500 / iImageWidth;" + Environment.NewLine
                                    + "orgImage.height = iImageHeight * iRate;" + Environment.NewLine
                                    + "}" + Environment.NewLine
                                    + "}" + Environment.NewLine
                                    + "function ResizeImage(orgImage)" + Environment.NewLine
                                    + "{" + Environment.NewLine
                                    + "}" + Environment.NewLine
                                    + "</Script>" + Environment.NewLine
                                    + "</head>" + Environment.NewLine
                                    + "<body style='margin:20px;'>" + Environment.NewLine;

            String htmlExamTagString = "</body>" + Environment.NewLine
                                     + "</html>" + Environment.NewLine;

            #endregion

            #endregion HTML 문서 생성

            // 웹 의무기록뷰어
            if (bViewer)
            {
                rtnOutput = htmlHeaderString + rtnOutput + htmlTagString;
            }
            else
            {
                // 기능검사 조회
                rtnOutput = htmlExamHeaderString + rtnOutput + htmlExamTagString;
            }

            return rtnOutput;
        }

        #region 기능검사 웹 조회 전용

        /// <summary>
        /// name         : 기능검사 서식 조회(Value 포함)를 위한 데이터 세팅(모바일 전용)
        /// desc         : 기능검사 서식 조회(Value 포함)를 위한 데이터를 세팅합니다.모바일 전용)
        /// author       : 박제영 
        /// create date  : 2015-09-09
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> TransPandocToRecordHeader(HSFDTOCollectionBaseObject<SelectResearchList_INOUT> inObjList)
        {
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> XamlInputList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();

            if (inObjList.Count > 0)
            {
                foreach (SelectResearchList_INOUT cItem in inObjList)
                {
                    if (!string.IsNullOrEmpty(cItem.MDFM_INPT_NOTM.ToString()))
                    {
                        // 서식지 값 조회
                        SelectFormValueList_INOUT inData1 = new SelectFormValueList_INOUT();
                        inData1.IN_IPPR_ID = cItem.IPPR_ID.ToString();
                        inData1.IN_MDFM_INPT_NOTM = (decimal)cItem.MDFM_INPT_NOTM;   // 기록지 입력개정번호         -> 이부분 변경됨(DTO에 IN_MDFM_INPT_NOTM 새로 생김)
                        inData1.IN_MDFM_ID = (decimal)cItem.MDFM_ID;	             // 진료서식ID
                        inData1.IN_MDFM_FOM_SEQ = (decimal)cItem.MDFM_FOM_SEQ;       // 서식 개정번호


                        // 서식지 조회 파라미터 작성
                        XamlInputList.Add(new MedicalTreatmentRecordAskItemHeader_INOUT()
                        {
                            IPPR_ID = cItem.IPPR_ID,
                            MDRC_FOM_SEQ = (decimal)cItem.MDFM_INPT_NOTM,           // 진료기록 개정 순번
                            MDFM_ID = (decimal)cItem.MDFM_ID,
                            MDFM_FOM_SEQ = cItem.MDFM_FOM_SEQ,
                            MDFM_CLS_CD = cItem.MDFM_CLS_CD,
                            MDFM_CLS_DTL_CD = cItem.MDFM_CLS_DTL_CD,
                            MDFM_NM = cItem.MDFM_NM,
                            MDFM_CLS_NM = "",
                            REC_DTM = DateTime.Now,                                 // 작성시간
                            WRTR_DEPT_NM = "",                                      // 작성자진료과명
                            MED_DT = DateTime.Now,                                  // 진료일자
                            MDRC_SBTIT_INPT_NM = "",                                // 진료기록 부제목명
                            WK_STF_NO = cItem.WK_STF_NO,                            // 작성자사번(서명)
                            WK_NM = cItem.WK_NM                                     // 작성자명
                        });
                    }
                }
            }

            return XamlInputList;
        }


        /// <summary>
        /// name         : 기능검사 서식 구성을 Structure 정보 조회(모바일 전용)
        /// desc         : 기능검사 서식 구성을 Structure 정보를 조회 합니다.(모바일 전용)
        /// author       : 박제영 
        /// create date  : 2015-09-09
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public MedicalTreatmentRecordStructure_INOUT MedicalTreatmentRecordStructureInfoSelect(MedicalTreatmentRecordAskItemHeader_INOUT inHeader)
        {
            MedicalTreatmentRecordStructure_INOUT rtnObj = new MedicalTreatmentRecordStructure_INOUT();

            MedicalTreatmentRecordStructure_INOUT inputObj = new MedicalTreatmentRecordStructure_INOUT();
            //서식관련 정보 입력정보 서식아이디, 서식개정번호, 기록지아이디, 기록지 개정번호
            inputObj.SectioninputInfo = new MedicalTreatmentRecordSectionInfo_INOUT();
            inputObj.SectioninputInfo.MDFM_ID = inHeader.MDFM_ID;
            inputObj.SectioninputInfo.MDFM_FOM_SEQ = inHeader.MDFM_FOM_SEQ;
            inputObj.SectioninputInfo.MDRC_ID = inHeader.MDRC_ID;
            inputObj.SectioninputInfo.MDRC_FOM_SEQ = inHeader.MDRC_FOM_SEQ;
            inputObj.SectioninputInfo.MDRC_DTL_CLS_CD = inHeader.MDFM_CLS_DTL_CD;
            inputObj.SectioninputInfo.PACT_ID = inHeader.PACT_ID;

            //빌드관련 주석처리
            rtnObj = (MedicalTreatmentRecordStructure_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "MedicalTreatmentRecordStructureInfoSelect", inputObj);

            //2022.04.13 복호화 로직 추가
            rtnObj = new HIS.MC.DR.RM.RS.UI.Common.CommonUtility().DeEnciphermentStructureAsk(rtnObj);

            return rtnObj;
        }

        /// <summary>
        /// name         : 기능검사 서식 Value 구성-전체보기(모바일 전용)
        /// desc         : 기능검사 서식 Value를 구성 합니다.-전체보기(모바일 전용)
        /// author       : 박제영 
        /// create date  : 2015-09-09
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<MedicalTreatmentRecordFormElementValueInfo_OUT> SelectFunctionExamFormValueList(MedicalTreatmentRecordAskItemHeader_INOUT inObj)
        {
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordFormElementValueInfo_OUT> TransFormElementValueInfo = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordFormElementValueInfo_OUT>();

            SelectFormValueList_INOUT inData = new SelectFormValueList_INOUT()
            {
                IN_IPPR_ID = inObj.IPPR_ID,
                IN_MDFM_INPT_NOTM = inObj.MDRC_FOM_SEQ,   // 기록지 입력개정번호
                IN_MDFM_ID = inObj.MDFM_ID,
                IN_MDFM_FOM_SEQ = inObj.MDFM_FOM_SEQ,      // 서식 개정번호                
            };

            HSFDTOCollectionBaseObject<SelectFormValueList_INOUT> valueList = (HSFDTOCollectionBaseObject<SelectFormValueList_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MS.SE.EXCT.BIZ.InsertpretationBL", "SelectFormValueList", inData);


            // 진료지원 기능검사 과별서식 Value Conversion 
            foreach (SelectFormValueList_INOUT v in valueList)
            {
                TransFormElementValueInfo.Add(new MedicalTreatmentRecordFormElementValueInfo_OUT()
                {
                    MDFM_CPEM_NO = v.MDFM_CPEM_NO
                    ,
                    MDFM_ELMT_CCLS_CD = v.ELMT_CCLS_CD
                    ,
                    MDFM_ELMT_INPT_CNTE = v.IPTN_CNTE
                    ,
                    REC_VAL_SEQ = (decimal)v.REC_VAL_SEQ
                    ,
                    MDFM_ID = v.MDFM_ID
                    ,
                    MDFM_FOM_SEQ = v.MDFM_FOM_SEQ
                    ,
                    MDFM_SCTN_SEQ = v.MDFM_SCTN_SEQ
                    ,
                    FCHG_DCST_LDAT = v.FCHG_DCST_LDAT
                });
            }

            return TransFormElementValueInfo;
        }

        #endregion

        /// <summary>
        /// name         : Web 기록조회 공통(모바일 전용)
        /// desc         : Web 기록조회 공통 입니다.(모바일 전용)
        /// author       : 박제영 
        /// create date  : 2015-09-09
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchMultiRecordContentHtml(object p)
        {
            //선택된 기록목록을 초기화
            ClearSelectedRecordList();

            IList list = p as IList;

            if (list == null) // 1건 선택한 경우
            {
                AddSelectedRecordList(p as RecordList_INOUT);
            }
            else // 여러건 선택한 경우
            {
                IList<RecordList_INOUT> inObject = p as IList<RecordList_INOUT>;
                HSFDTOCollectionBaseObject<RecordList_INOUT> returnObject = new HSFDTOCollectionBaseObject<RecordList_INOUT>(p as IList<RecordList_INOUT>);

                returnObject = SortRecordList(SelectedContentListSort_Type.COMN_CD, inObject, returnObject);
                foreach (RecordList_INOUT item in returnObject)
                {
                    AddSelectedRecordList(item);
                }
            }

            #region 그룹으로 조회
            foreach (var group in this.SelectedRecordList.Select(t => t.RECORD_TYPE).Distinct().ToList())
            {
                switch (group)
                {
                    //진료기록(DR),처방(OR),간호기록(NR),검사(EX),스캔자료(SC)
                    case "DR":
                        MedicalTreatmentRecordAskItemHeader_INOUT IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();
                        HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> in_HeaderList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
                        IN_HEADER.MULTI_MDRC_ID = "";

                        #region 마취기록, 마취전상태평가를 제외한 기록
                        HSFDTOCollectionBaseObject<PrintRecordList_INOUT> recordList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>(SelectedRecordListDR.Where(d => !d.MDFM_CLS_CD.Equals("D010") && !d.MDFM_CLS_CD.Equals("D011")));

                        foreach (var record in SelectedRecordListDR.Where(d => !d.MDFM_CLS_CD.Equals("D010") && !d.MDFM_CLS_CD.Equals("D011")))
                        {
                            if (string.IsNullOrEmpty(IN_HEADER.MULTI_MDRC_ID))
                                IN_HEADER.MULTI_MDRC_ID = "" + record.MDRC_ID + "";
                            else
                                IN_HEADER.MULTI_MDRC_ID = IN_HEADER.MULTI_MDRC_ID + "," + "" + record.MDRC_ID + "";
                        }
                        if (!String.IsNullOrEmpty(IN_HEADER.MULTI_MDRC_ID))
                        {
                            in_HeaderList = (HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.DR.RM.RS.BIZ.MedicalTreatmentRecordAskBL", "SelectMedicalTreatmentRecordAskClassByMultiMDRCID", IN_HEADER);

                            SearchGroupDoctorRecordFlowDocumentHtml(SelectedRecordListDR, in_HeaderList);
                        }
                        #endregion 마취기록, 마취전상태평가를 제외한 기록

                        #region 마취기록, 마취전상태평가                       
                        recordList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>(SelectedRecordListDR.Where(d => d.MDFM_CLS_CD.Equals("D010") || d.MDFM_CLS_CD.Equals("D011")));

                        if (recordList.Count > 0)
                            SearchGroupAnesthesiaRecordFlowDocumentHtml(SelectedRecordListDR);

                        #endregion 마취기록, 마취전상태평가

                        break;
                    case "OR":
                        SearchGroupOrderRecordFlowDocument(SelectedRecordListOR);
                        break;
                    case "NR":
                        SearchGroupNursingRecordFlowDocument(SelectedRecordListNR);
                        break;
                    case "EX":
                        SearchGroupExamFlowDocumentHtml(SelectedRecordListEX);
                        break;
                    case "SC":
                        SearchGroupScanFlowDocument(SelectedRecordListSC);
                        break;
                    default:
                        break;
                }
            }

            #endregion 그룹으로 조회

            return SelectedRecordList;
        }

        /// <summary>
        /// name         : Web 진료 기록조회 상세(모바일 전용)
        /// desc         : Web 진료 기록조회 상세 입니다.(모바일 전용)
        /// author       : 박제영 
        /// create date  : 2015-09-09
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchGroupDoctorRecordFlowDocumentHtml(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records, HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> in_HeaderList)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();

            #region 1. 한꺼번에 실행시키는 방법

            // 웹서비스 HTML 구성을 위한 데이터 추출
            SelectMedicalTreatmentRecordAskByMdrcId MdrcIdObj = new SelectMedicalTreatmentRecordAskByMdrcId();
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT> XamlInputList = new HSFDTOCollectionBaseObject<MedicalTreatmentRecordAskItemHeader_INOUT>();
            XamlInputList = (MdrcIdObj.DataContext as SelectMedicalTreatmentRecordAskByMdrcIdData).InputList;
            foreach (var in_Header in in_HeaderList)
            {
                if (!in_Header.MDFM_CLS_CD.Equals("D006") //퇴원기록
                 && !in_Header.MDFM_CLS_CD.Equals("D020") //과별서식                 
                 && !in_Header.MDFM_CLS_CD.Equals("D009") //진단서
                 && !in_Header.MDFM_CLS_CD.Equals("D035") //산재진단서                 
                 )
                {
                    XamlInputList.Add(in_Header);
                }
            }

            #region 정신과기록 열람 여부 설정            
            if (records.FirstOrDefault().EXAM_KEY == "Y") //정신과 소속의 의사인 경우 파라미터로 넘어옴.
                NPRecAskYN = true;
            #endregion 정신과기록 열람 여부 설정

            MedicalTreatmentRecordAskPersonalCondition_INOUT personalCondition = new MedicalTreatmentRecordAskPersonalCondition_INOUT() { WhiteBackGround = true, MenuVisible = false, ExpanderVisible = false, NPRecAsk = NPRecAskYN };
            HSFDTOCollectionBaseObject<MedicalTreatmentRecordFlowDocXamlList_OUT> OutputList = MdrcIdObj.SelectMedicalTreatmentRecordAskFlowdoc(XamlInputList, personalCondition);
            MdrcIdObj.Dispose();

            //마취기록, 마취전상태평가는 제외하고 조회
            foreach (var record in records.Where(d => !d.MDFM_CLS_CD.Equals("D010") && !d.MDFM_CLS_CD.Equals("D011")))
            {
                foreach (var output in OutputList)
                {
                    if (record.MDRC_ID == output.MDRC_ID)
                    {
                        record.RecordFlowDocument = output.MedrecFlowDocument;
                        break;
                    }
                }
            }
            #endregion 1. 한꺼번에 실행시키는 방법

            return records;
        }

        /// <summary>
        /// name         : Web 검사조회 상세(모바일 전용)
        /// desc         : Web 검사조회 상세 입니다.(모바일 전용)
        /// author       : 박제영 
        /// create date  : 2015-09-09
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private HSFDTOCollectionBaseObject<PrintRecordList_INOUT> SearchGroupExamFlowDocumentHtml(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();

            PictureExamTemplate_OUT pictureExam_dto = new PictureExamTemplate_OUT();//영상검사
            FuncExamTemplate_OUT funcExam_dto = new FuncExamTemplate_OUT();//기능검사
            SpecimenExamTemplate_OUT specimenExam_dto = new SpecimenExamTemplate_OUT();//검체검사
            //PathologyExamTemplate_OUT pathologyExam_dto = new PathologyExamTemplate_OUT();//병리검사
            HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT> pathologyExamList = new HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT>();//병리검사

            HSFDTOCollectionBaseObject<PictureExamTemplate_OUT> pictureExamResultList = new HSFDTOCollectionBaseObject<PictureExamTemplate_OUT>();//영상검사결과
            HSFDTOCollectionBaseObject<FuncExamTemplate_OUT> funcExamResultList = new HSFDTOCollectionBaseObject<FuncExamTemplate_OUT>();//기능검사결과
            HSFDTOCollectionBaseObject<SpecimenExamTemplate_OUT> specimenExamResultList = new HSFDTOCollectionBaseObject<SpecimenExamTemplate_OUT>();//검체검사결과
            HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT> pathologyExamResultList = new HSFDTOCollectionBaseObject<PathologyExamTemplate_OUT>();//병리검사결과

            // 검사별 DTO 조회작업 
            foreach (RecordList_INOUT item in records)
            {
                // RecordList에서 환자번호 제공 받는 경우 추가
                if (string.IsNullOrEmpty(item.PT_NO))
                {
                    item.PT_NO = PatientInformation.PT_NO;
                }

                // 영상검사
                if (item.RECORD_DETAIL_TYPE == "EX_PICTURE")
                {
                    if (pictureExam_dto.IPTN_NO == null)
                        pictureExam_dto.IPTN_NO = item.EXAM_KEY;
                    else
                        pictureExam_dto.IPTN_NO = pictureExam_dto.IPTN_NO + "," + item.EXAM_KEY;
                }
                // 기능검사
                else if (item.RECORD_DETAIL_TYPE == "EX_FUNCTION")
                {
                    funcExam_dto.KEY = item.EXAM_KEY;
                    funcExamResultList.Add(SelectFuncExamResultFlowDocument(funcExam_dto));
                }
                //검체검사
                else if (item.RECORD_DETAIL_TYPE == "EX_SPECIMEN")
                {
                    specimenExam_dto.IN_PT_NO = item.PT_NO;
                    if (specimenExam_dto.SPCM_NO == null)
                        specimenExam_dto.SPCM_NO = item.EXAM_KEY;
                    else
                        specimenExam_dto.SPCM_NO = specimenExam_dto.SPCM_NO + "," + item.EXAM_KEY;
                }
                //병리검사
                else if (item.RECORD_DETAIL_TYPE == "EX_PATHOLOGY")
                {
                    PathologyExamTemplate_OUT pathologyItem = new PathologyExamTemplate_OUT();

                    pathologyItem.SPCM_PTHL_KEY = item.EXAM_KEY;

                    pathologyExamList.Add(pathologyItem);
                }
            }

            // 검사별 DTO 조회
            if (pictureExam_dto.IPTN_NO != null)
            {
                pictureExamResultList = (HSFDTOCollectionBaseObject<PictureExamTemplate_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectPictureExaminationResult", pictureExam_dto);
            }
            if (specimenExam_dto.SPCM_NO != null)
            {
                specimenExamResultList = (HSFDTOCollectionBaseObject<SpecimenExamTemplate_OUT>)UIMiddlewareAgent.InvokeBizService(this, "HIS.MS.LM.COMM.BIZ.SelectMRViewerExamBL", "SelecSpecimenExamView", specimenExam_dto);
            }

            // 결과조회
            foreach (var record in records)
            {
                //영상검사
                if (record.RECORD_DETAIL_TYPE == "EX_PICTURE")
                {
                    foreach (PictureExamTemplate_OUT pictureExamResult in pictureExamResultList)
                    {
                        if (record.EXAM_KEY == pictureExamResult.IPTN_NO)
                        {
                            record.RecordFlowDocument = CreateDocument(pictureExamResult);
                            fDocList.Add(record);
                        }
                    }
                }
                // 기능검사
                else if (record.RECORD_DETAIL_TYPE == "EX_FUNCTION")
                {
                    foreach (FuncExamTemplate_OUT funcExamResult in funcExamResultList)
                    {
                        if (record.EXAM_KEY == funcExamResult.KEY)
                        {
                            // 기능검사 내용
                            funcExamResult.TEMPLATE = "FuncExamTemplate";
                            record.RecordFlowDocument = CreateDocumentFunctionExamHtml(funcExamResult);
                            record.RecordFunctionExamTemplate = funcExamResult;
                            record.RecordFlowDocumentList.Add(record.RecordFlowDocument);
                            fDocList.Add(record);

                            /*
                            // 기능검사 이미지
                            funcExamResult.TEMPLATE = "FuncExamTemplateImage";
                            record.RecordFlowDocument = CreateDocumentFunctionExamHtml(funcExamResult);
                            record.RecordFunctionExamTemplate = funcExamResult;
                            record.RecordFlowDocumentList.Add(record.RecordFlowDocument);
                            fDocList.Add(record);
                            */
                        }
                    }
                }
                // 검체검사
                else if (record.RECORD_DETAIL_TYPE == "EX_SPECIMEN")
                {
                    foreach (SpecimenExamTemplate_OUT specimenExamResult in specimenExamResultList)
                    {
                        if (record.EXAM_KEY == specimenExamResult.EXM_CTG_CD + specimenExamResult.SPCM_NO)
                        {
                            record.RecordFlowDocument = CreateDocument(specimenExamResult);
                            record.RecordFlowDocumentList.Add(record.RecordFlowDocument);
                            fDocList.Add(record); // 검체검사는 key 하나에 여럿이 조회되는 경우가 있음. 
                        }
                    }
                }
                // 병리검사
                else if (record.RECORD_DETAIL_TYPE == "EX_PATHOLOGY")
                {
                    foreach (PathologyExamTemplate_OUT pathologyExamResult in pathologyExamList)
                    {
                        if (record.EXAM_KEY == pathologyExamResult.SPCM_PTHL_KEY)
                        {
                            record.RecordFlowDocument = PMCommon.SelectResultTextForPreview(pathologyExamResult.SPCM_PTHL_KEY, true, EngAskChecked, "B");

                            fDocList.Add(record);
                        }
                    }
                }
            }

            return fDocList;
        }

        /// <summary>
        /// name         : 기능검사 템플릿 데이터 조회(모바일 전용)
        /// desc         : 기능검사 템플릿 데이터 조회(모바일 전용)
        /// author       : 박제영 
        /// create date  : 2015-09-09
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        public FlowDocument CreateDocumentFunctionExamHtml(MedicalRecordTemplate_INOUT dto)
        {
            ReportData data = new ReportData();

            foreach (var property in dto.GetType().GetProperties())
            {
                if (property.GetSetMethod() != null && dto.GetType().GetProperty(property.Name) != null)
                {
                    if (property.PropertyType.Name.Equals("HSFDTOCollectionBaseObject`1") || property.PropertyType.Name.Equals("DataTable"))
                    {
                        object list = dto.GetType().GetProperty(property.Name).GetValue(dto, null);

                        if (list is IList)
                        {
                            data.DataTables.Add(ListToTable(list as IList, property.Name));
                        }
                        else if (list is DataTable)
                        {
                            ((DataTable)list).TableName = property.Name;
                            data.DataTables.Add(list as DataTable);
                        }
                    }
                    else
                    {
                        data.ReportDocumentValues.Add(property.Name, dto.GetType().GetProperty(property.Name).GetValue(dto, null));
                    }
                }
            }

            var reportDocument = new HSF.Report.Core.ReportDocument();

            reportDocument.XamlData = TemplateDownload(dto.TEMPLATE);

            FlowDocument doc = reportDocument.CreateFlowDocument(data);

            return doc;
        }

        /// <summary>
        /// name         : Web 마취기록, 마취전상태평가 조회 상세(모바일 전용)
        /// desc         : Web 마취기록, 마취전상태평가 조회 상세(모바일 전용)
        /// author       : 강성희 
        /// create date  : 2016-11-25
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchGroupAnesthesiaRecordFlowDocumentHtml(HSFDTOCollectionBaseObject<PrintRecordList_INOUT> records)
        {
            HSFDTOCollectionBaseObject<PrintRecordList_INOUT> fDocList = new HSFDTOCollectionBaseObject<PrintRecordList_INOUT>();
            MedicalTreatmentRecordAskItemHeader_INOUT IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();
            MedicalTreatmentRecordAskPersonalCondition_INOUT personalCondition = new MedicalTreatmentRecordAskPersonalCondition_INOUT() { WhiteBackGround = true, MenuVisible = false, ExpanderVisible = false };

            //마취기록, 마취전상태평가만 조회
            foreach (var record in records.Where(d => d.MDFM_CLS_CD.Equals("D010") || d.MDFM_CLS_CD.Equals("D011")))
            {
                IN_HEADER = new MedicalTreatmentRecordAskItemHeader_INOUT();

                IN_HEADER.PT_NO = record.PT_NO;
                IN_HEADER.OP_EXPT_REG_ID = record.OP_EXPT_REG_ID;
                IN_HEADER.MDFM_CLS_CD = record.MDFM_CLS_CD;

                if (record.MDFM_CLS_CD.Equals("D010"))
                    IN_HEADER.MDFM_CLS_NM = "마취기록";
                else
                    IN_HEADER.MDFM_CLS_NM = "마취전평가";

                SelectAnesthesiaRecordAllViewAsk SelectAnesthesiaRecord = new SelectAnesthesiaRecordAllViewAsk(IN_HEADER, null, personalCondition);

                record.RecordFlowDocument = (SelectAnesthesiaRecord.DataContext as SelectAnesthesiaRecordAllViewAskData).MedrecFlowDocument;
            }
        }

        #endregion 웹 제공용


        #region 정신과 기록 권한 중 운영직일 경우 권한 부여를 취소

        /// <summary>
        /// name         : 정신과 기록 권한 중 운영직일 경우 권한 부여를 취소
        /// desc         : 정신과 기록 권한 중 운영직일 경우 권한 부여를 취소
        /// author       : 서상훈 
        /// create date  : 2016-12-13
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private string SelectPsychiatryManageAuthCheck()
        {
            string ManageAuth = "N"; //조회 권한(정신과 중 운영직 여부)

            SelectPsychiatryManageAuth_INOUT inObj = new SelectPsychiatryManageAuth_INOUT();

            SelectPsychiatryManageAuth_INOUT mageCheck = new SelectPsychiatryManageAuth_INOUT();

            if (SessionManager.UserInfo != null)
            {
                inObj.STF_NO = SessionManager.UserInfo.STF_NO;

                mageCheck = (SelectPsychiatryManageAuth_INOUT)UIMiddlewareAgent.InvokeBizService(this, "HIS.MC.NR.NV.NV.BIZ.NursingRecordViewerSecondBL", "SelectPsychiatryManageAuth", inObj);

                ManageAuth = mageCheck.AUTH_YN;
            }
            else
            {
                ManageAuth = "N";
            }

            return ManageAuth;
        }

        #endregion

        /// <summary>
        /// name         : 수진일별 기록목록조회 함수_History
        /// desc         : 수진일별 기록목록을 조회합니다.
        /// author       : 김정훈 
        /// create date  : 2012-08-30
        /// update date  : 수정일자, 수정자, 수정개요
        /// </summary>
        private void SearchHistoryRecordContent(object p)
        {
            if (p == null)
            {
                return;
            }

            if ((p.GetType().FullName == "HIS.MC.DR.RM.RV.DTO.RecordList_INOUT"))
            {
                RecordList_INOUT selectedRowdata_dto = new RecordList_INOUT();
                RecordList_INOUT MedrecHeaderInfo_dto = new RecordList_INOUT();

                selectedRowdata_dto = (p as RecordList_INOUT);
                MedrecHeaderInfo_dto = (p as RecordList_INOUT); // 출력에서 사용하려고 추가

                HavingAMedicalExaminationList = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(BIZ_CLASS, "SelectHavingAMedicalExaminationList", SearchCondition);

                var objData = HavingAMedicalExaminationList.Where(d => d.MDRC_ID == selectedRowdata_dto.MDRC_ID).OrderByDescending(a => a.MDRC_ID).OrderByDescending(a => a.MDRC_FOM_SEQ);

                HSFDTOCollectionBaseObject<RecordList_INOUT> selected_item_cdto = new HSFDTOCollectionBaseObject<RecordList_INOUT>(objData);
                HavingAMedicalExaminationDetailBindingList = selected_item_cdto;

                /*
                var SelectedMedrecHistoryContent_single = (from a in HavingAMedicalExaminationList
                                                    where a.MDRC_ID.Equals(selectedRowdata_dto.MDRC_ID)
                                                    orderby a.MDRC_FOM_SEQ descending
                                                    select a).ToList();
                                                    */



            }
            else
            {
                HSFDTOCollectionBaseObject<RecordList_INOUT> selectedRowdata = new HSFDTOCollectionBaseObject<RecordList_INOUT>();
                HSFDTOCollectionBaseObject<RecordList_INOUT> MedrecHeaderInfo = new HSFDTOCollectionBaseObject<RecordList_INOUT>();

                selectedRowdata = (p as HSFDTOCollectionBaseObject<RecordList_INOUT>);
                MedrecHeaderInfo = (p as HSFDTOCollectionBaseObject<RecordList_INOUT>); // 출력에서 사용하려고 추가

                HavingAMedicalExaminationList = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(BIZ_CLASS, "SelectHavingAMedicalExaminationList", SearchCondition);

                var SelectedMedrecHistoryContent = this.HavingAMedicalExaminationList.Join(selectedRowdata, o => o.MDRC_ID, bundle => bundle.MDRC_ID, (o, bundle) => o).OrderByDescending(o => o.MDRC_FOM_SEQ).OrderByDescending(o => o.MDRC_ID);

                HSFDTOCollectionBaseObject<RecordList_INOUT> selected_item_cdto = new HSFDTOCollectionBaseObject<RecordList_INOUT>(SelectedMedrecHistoryContent);
                HavingAMedicalExaminationDetailBindingList = selected_item_cdto;
            }


            ///////////////////////////////////////////////////////////////////////

            if (SelectedMedicalTreatmentHistory == null)
            { return; }
            //this.RecordGroupList.Clear();
            this.RecordListByMedicalTreatmentDay.Clear();

            SearchCondition.PACT_ID = SelectedMedicalTreatmentHistory.PACT_ID;
            RecordListByMedicalTreatmentDay = (HSFDTOCollectionBaseObject<RecordList_INOUT>)UIMiddlewareAgent.InvokeBizService(BIZ_CLASS, "SelectRecordListByMedicalTreatmentDay", SearchCondition);


            //if (HavingAMedicalExaminationDetailBindingList.Count == 0)
            //{
            //    MsgBox.Display("해당 수진일에 작성된 기록이 존재하지 않습니다.", MessageType.MSG_TYPE_EXCLAMATION, "수진내역 확인", TimeSpan: 1000);
            //}
            //else if (HavingAMedicalExaminationDetailBindingList.Count == 1)
            //{
            //    // 기록이 1건인 경우 바로 조회
            //    SelectedRecordListByMedicalTreatmentDay.Add(SelectedMedrecHistoryContent.FirstOrDefault());
            //    SearchMultiRecordContentHistory(SelectedRecordListByMedicalTreatmentDay);

            //}

            // 정렬
            SelectListSortType(RecordListByMedicalTreatmentDay);

            SetMedicalTreatmentDayMaxHeight();
        }


        /// <summary>
        /// name         : GetFileNmIncludeExtension
        /// desc         : 경로에서 파일명(확장자포함)만 추출하는 공통 로직
        /// author       : chohanna
        /// create Date  : 2016-02-17
        /// updatedate   : 수정일시      수정자       수정내용
        /// </summary>
        /// <remarks>예제입니다. 해당 Method 는 삭제 또는 이름변을을 통해 사용해주시기 바랍니다.</remarks>
        /// 
        public string GetFileNmIncludeExtension(string sPath)
        {
            string[] arrString = null;
            string arrStringFileNm = null;

            if (sPath.IndexOf('/') >= 0)
            {
                arrString = sPath.Split('/');
                arrStringFileNm = arrString[arrString.Length - 1];
            }
            else if (sPath.IndexOf("\\") >= 0)
            {
                arrString = sPath.Split('/');
                arrStringFileNm = arrString[arrString.Length - 1];
            }

            return arrStringFileNm;

        }

        //서버 풀경로로 부터 순수 경로만 추출
        public string GetPathFromServerPath(string ServerPathInfo)
        {
            string[] arrString = null;
            string rtnstr = "";

            arrString = ServerPathInfo.Split('/');

            for (int i = 3; i < arrString.Length - 1; i++)
            {
                rtnstr = rtnstr + "/" + arrString[i];
            }

            return rtnstr;
        }

        private void WhenPrintingAskChecked()
        {
            if (PrintingAskChecked)
            {
                imagePrintAuthority = ImagePrintingAskChecked;
                IsImagePrintingAsEnabled = true;

                //2024-04-19, 박찬규, 이미지 출력 관련 개발 (PSS_MC_0527)
                IsImageOperationPrintingAsEnabled = true;
            }
            else
            {
                IsImagePrintingAsEnabled = false;
                imagePrintAuthority = true;
                //2024-04-19, 박찬규, 이미지 출력 관련 개발 (PSS_MC_0527)
                IsImageOperationPrintingAsEnabled = false;
                ImagePrintingAskChecked = false;
                OperationImagePrintingAskChecked = false;
                operationimagePrintAuthority = false;

            }
        }

        //2024-04-19, 박찬규, 이미지 출력 관련 개발 (PSS_MC_0527)
        private void WhenImagePrintingAskChecked()
        {
            if (PrintingAskChecked)
            {
                imagePrintAuthority = ImagePrintingAskChecked;

                if (ImagePrintingAskChecked)
                {
                    OperationImagePrintingAskChecked = false;
                }
            }
        }
        //2024-04-19, 박찬규, 이미지 출력 관련 개발 (PSS_MC_0527)
        private void WhenOperationImagePrintingAskChecked()
        {
            if (PrintingAskChecked)
            {
                operationimagePrintAuthority = OperationImagePrintingAskChecked;

                if (OperationImagePrintingAskChecked)
                {
                    ImagePrintingAskChecked = false;
                }
            }
        }

        //2024-07-15, 박찬규, 신포괄 관련 작업 (PSS_MC_0609)
        private void NewDrgDeterminationOpenPopup()
        {
            String obj1 = "HMRS"; //Caller
            String obj2 = PatientInformation.PT_NO; //환자번호
            String obj22 = PatientInformation.PT_NM;  //환자명

            PopUpBase pop = this.OnLoadPopupMenu("DR_HIS.MC.DR.RM.RS.UI_/SelectMedicalTreatmentRecordHistoryAsk.xaml", obj1, obj2, obj22);

            pop.WindowStartupLocation = WindowStartupLocation.CenterOwner;

            pop.ShowDialog();

        }

        #endregion //Methods
    }
}