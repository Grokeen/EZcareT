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
using HSF.Controls.WPF.Extension;
using HSF.TechSvc2010.Common;

using HIS.UI.Core;
using HIS.UI.Core.Commands;
using HIS.UI.Utility;
using HIS.PA.AC.PE.SC.DTO;
using HIS.Core.Global.DTO;
using HIS.UI.Base;
using System.Collections.ObjectModel;
using HSF.Controls.WPF.Extension.CalendarEx;
using HSF.Controls.WPF.DataManager.Calendars;
using HIS.PA.AC.PE.AP.DTO;

using HIS.PA.CORE.DTO;

namespace HIS.PA.AC.PE.SC.UI
{
    /// <summary>
    /// name         : 논리 UI Data 클래스 명
    /// desc         : UI Data 클래스 개요
    /// author       : kimchihwan 
    /// create date  : 2012-06-07 오후 5:08:32
    /// update date  : 최종 수정일자 , 수정자, 수정개요
    /// </summary>
    public class MedDoctorScheduleRegistrationData : ViewModelBase
    {
        public MedDoctorScheduleRegistrationData()
        {
        }
        /// <summary>
        /// name         : cxbCRDOCYN
        /// desc         : 공문 표기
        /// author       : kimchihwan 
        /// create date  : 2012-04-24 오전 11:41:28
        /// update date  : 2012-04-24 오전 11:41:28, kimchihwan, 수정개요
        /// </summary>
        private HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_INOUT> cxbcrdocyn = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_INOUT>()
        {
            new MedDoctorScheduleRegistration_INOUT{COMN_CD="Y", COMN_CD_NM="●"},
            new MedDoctorScheduleRegistration_INOUT{COMN_CD="N", COMN_CD_NM=""}
        };
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_INOUT> cxbCRDOCYN
        {
            get { return cxbcrdocyn; }
            set { if (this.cxbcrdocyn != value) { this.cxbcrdocyn = value; this.OnPropertyChanged("cxbCRDOCYN", value); } }
        }

        MedDoctorScheduleCriteriaRegistrationTree_IN meddoctorschedulecriteriaregistrationtreeinobj = new MedDoctorScheduleCriteriaRegistrationTree_IN();
        /// <summary>
        /// desc         : 전체 진료과 진료의 Tree InDTO
        /// author       : kimchihwan
        /// create date  : 2012-04-30 오후 5:29:13
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleCriteriaRegistrationTree_IN MedDoctorScheduleCriteriaRegistrationTreeInObj
        {
            get { return this.meddoctorschedulecriteriaregistrationtreeinobj; }
            set { if (this.meddoctorschedulecriteriaregistrationtreeinobj != value) { this.meddoctorschedulecriteriaregistrationtreeinobj = value; this.OnPropertyChanged("MedDoctorScheduleCriteriaRegistrationTreeInObj"); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> meddoctorschedulecriteriaregistrationtreeoutobj = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>();
        /// <summary>
        /// desc         : 전체 진료과 진료의 SID Tree OutDTO
        /// author       : kimchihwan
        /// create date  : 2012-04-30 오후 5:29:13
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> MedDoctorScheduleCriteriaRegistrationTreeOutObj
        {
            get { return this.meddoctorschedulecriteriaregistrationtreeoutobj; }
            set { if (this.meddoctorschedulecriteriaregistrationtreeoutobj != value) { this.meddoctorschedulecriteriaregistrationtreeoutobj = value; this.OnPropertyChanged("MedDoctorScheduleCriteriaRegistrationTreeOutObj", value); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> meddoctorschedulecriteriaregistrationtree2outobj = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT>();
        /// <summary>
        /// desc         : 전체 진료과 진료의 STF Tree OutDTO
        /// author       : kimchihwan
        /// create date  : 2012-04-30 오후 5:29:13
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistrationTree_OUT> MedDoctorScheduleCriteriaRegistrationTree2OutObj
        {
            get { return this.meddoctorschedulecriteriaregistrationtree2outobj; }
            set { if (this.meddoctorschedulecriteriaregistrationtree2outobj != value) { this.meddoctorschedulecriteriaregistrationtree2outobj = value; this.OnPropertyChanged("MedDoctorScheduleCriteriaRegistrationTree2OutObj", value); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Tree_OUT> meddoctorschedulecriteriaregistrationtree3outobj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Tree_OUT>();
        /// <summary>
        /// desc         : 일괄휴진 STF Tree OutDTO
        /// author       : kimchihwan
        /// create date  : 2012-11-17 오후 5:29:13
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Tree_OUT> MedDoctorScheduleCriteriaRegistrationTree3OutObj
        {
            get { return this.meddoctorschedulecriteriaregistrationtree3outobj; }
            set { if (this.meddoctorschedulecriteriaregistrationtree3outobj != value) { this.meddoctorschedulecriteriaregistrationtree3outobj = value; this.OnPropertyChanged("MedDoctorScheduleCriteriaRegistrationTree3OutObj", value); } }
        }

        MedDoctorScheduleRegistration_Tree_OUT batchnspinoutobj = new MedDoctorScheduleRegistration_Tree_OUT();
        /// <summary>
        /// desc         : 일괄휴진 STF Tree INOutDTO
        /// author       : kimchihwan
        /// create date  : 2012-11-17 오후 5:29:13
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleRegistration_Tree_OUT BatchNSPInOutObj
        {
            get { return this.batchnspinoutobj; }
            set { if (this.batchnspinoutobj != value) { this.batchnspinoutobj = value; this.OnPropertyChanged("BatchNSPInOutObj", value); } }
        }

        MedDoctorScheduleRegistration_CODE_IN schedulecodeinobj = new MedDoctorScheduleRegistration_CODE_IN();
        /// <summary>
        /// desc         : 진료일정기본코드 조회 InDTO
        /// author       : kimchihwan
        /// create date  : 2012-09-15
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleRegistration_CODE_IN ScheduleCodeInObj
        {
            get { return this.schedulecodeinobj; }
            set { if (this.schedulecodeinobj != value) { this.schedulecodeinobj = value; this.OnPropertyChanged("ScheduleCodeInObj"); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CODE_OUT> schedulecodeoutobj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CODE_OUT>();
        /// <summary>
        /// desc         : 진료일정기본코드 조회 OutDTO
        /// author       : kimchihwan
        /// create date  : 2012-09-15
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CODE_OUT> ScheduleCodeOutObj
        {
            get { return this.schedulecodeoutobj; }
            set { if (this.schedulecodeoutobj != value) { this.schedulecodeoutobj = value; this.OnPropertyChanged("ScheduleCodeOutObj", value); } }
        }

        ObservableCollection<HolidayInformation> holidayInformations = new ObservableCollection<HolidayInformation>();
        /// <summary>
        /// desc         : 휴일 OUT DTO Property
        /// author       : kimchihwan 
        /// create Date  : 2012-09-17 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public ObservableCollection<HolidayInformation> HolidayInformations
        {
            get { return this.holidayInformations; }
            set
            {
                if (this.holidayInformations != value)
                { this.holidayInformations = value; this.OnPropertyChanged("HolidayInformations", value); }
            }
        }

        private CustomDateInfoCollection holidayinfocollection;
        /// <summary>
        /// desc         : 휴일 OUT DTO Property
        /// author       : kimchihwan 
        /// create Date  : 2012-09-17 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public CustomDateInfoCollection HoliDayInfoCollection
        {
            get { return this.holidayinfocollection; }
            set { if (this.holidayinfocollection != value) { this.holidayinfocollection = value; this.OnPropertyChanged("EventCollection"); } }
        }

        MedDoctorScheduleCriteriaRegistration_IN meddoctorschedulecriteriaregistrationinobj = new MedDoctorScheduleCriteriaRegistration_IN();
        /// <summary>
        /// desc         : 진료일정 조회 In DTO
        /// author       : kimchihwan
        /// create date  : 2012-09-17 오후 12:44:07
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleCriteriaRegistration_IN MedDoctorScheduleCriteriaRegistrationInObj
        {
            get { return this.meddoctorschedulecriteriaregistrationinobj; }
            set { if (this.meddoctorschedulecriteriaregistrationinobj != value) { this.meddoctorschedulecriteriaregistrationinobj = value; this.OnPropertyChanged("MedDoctorScheduleCriteriaRegistrationInObj"); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> meddoctorschedulecriteriaregistrationinoutobj = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>();
        /// <summary>
        /// desc         : 진료일정 기본정보  InOutDTO
        /// author       : kimchihwan
        /// create date  : 2012-04-30 오후 5:29:13
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> MedDoctorScheduleCriteriaRegistrationInOutObj
        {
            get { return this.meddoctorschedulecriteriaregistrationinoutobj; }
            set { if (this.meddoctorschedulecriteriaregistrationinoutobj != value) { this.meddoctorschedulecriteriaregistrationinoutobj = value; this.OnPropertyChanged("MedDoctorScheduleCriteriaRegistrationInOutObj", value); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_OUT> seldoctoraclinicinformationoutobj = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_OUT>();
        /// <summary>
        /// desc         : 의사별 클리닉 정보 조회 OutDTO
        /// author       : kimchihwan
        /// create date  : 2012-05-03 오후 9:45:20
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_OUT> SelDoctorAClinicInformationOutObj
        {
            get { return this.seldoctoraclinicinformationoutobj; }
            set { if (this.seldoctoraclinicinformationoutobj != value) { this.seldoctoraclinicinformationoutobj = value; this.OnPropertyChanged("SelDoctorAClinicInformationOutObj", value); } }
        }

        MedDoctorScheduleRegistration_NSP_IN nspinobj = new MedDoctorScheduleRegistration_NSP_IN();
        /// <summary>
        /// desc         : 휴진일정 조회 In DTO
        /// author       : kimchihwan
        /// create date  : 2012-09-17 오후 12:44:07
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleRegistration_NSP_IN NspInObj
        {
            get { return this.nspinobj; }
            set { if (this.nspinobj != value) { this.nspinobj = value; this.OnPropertyChanged("NspInObj"); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT> nspoutobj = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>();
        /// <summary>
        /// desc         : 휴진일정 조회 OutDTO
        /// author       : kimchihwan
        /// create date  : 2012-09-17 오후 12:44:07
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT> NspOutObj
        {
            get { return this.nspoutobj; }
            set { if (this.nspoutobj != value) { this.nspoutobj = value; this.OnPropertyChanged("NspOutObj", value); } }
        }

        MedDoctorScheduleRegistration_NSP_OUT nspinoutobj = new MedDoctorScheduleRegistration_NSP_OUT();
        /// <summary>
        /// desc         : 휴진일정 작업 InOutDTO
        /// author       : kimchihwan
        /// create date  : 2012-09-17 오후 12:44:07
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleRegistration_NSP_OUT NspInOutObj
        {
            get { return this.nspinoutobj; }
            set { if (this.nspinoutobj != value) { this.nspinoutobj = value; this.OnPropertyChanged("NspInOutObj", value); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_INOUT> medschedulechangeparticularsinout = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_INOUT>();
        /// <summary>
        /// desc         : 의사 휴진일정 외래예약환자 InOutDTO
        /// author       : kimchihwan
        /// create date  : 2012-09-24 오후 12:44:07
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_INOUT> MedScheduleChangeParticularsInOut
        {
            get { return this.medschedulechangeparticularsinout; }
            set { if (this.medschedulechangeparticularsinout != value) { this.medschedulechangeparticularsinout = value; this.OnPropertyChanged("NspOutObj", value); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT> crdoc_temp = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT>();
        /// <summary>
        /// desc         : 협조전 저장 OutDTO
        /// author       : kimchihwan
        /// create date  : 2013-07-09 오후 12:44:07
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_NSP_OUT> CRDOC_TEMP
        {
            get { return this.crdoc_temp; }
            set { if (this.crdoc_temp != value) { this.crdoc_temp = value; this.OnPropertyChanged("CRDOC_TEMP", value); } }
        }

        private CustomDateInfoCollection patternCollection;

        public CustomDateInfoCollection PatternCollection
        {
            get { return this.patternCollection; }
            set { if (this.patternCollection != value) { this.patternCollection = value; this.OnPropertyChanged("PatternCollection"); } }
        }

        private CustomDateInfoCollection eventCollection;

        public CustomDateInfoCollection EventCollection
        {
            get { return this.eventCollection; }
            set { if (this.eventCollection != value) { this.eventCollection = value; this.OnPropertyChanged("EventCollection"); } }
        }
        HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> scheduel_temp = new HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>();
        /// <summary>
        /// desc         : 진료일정 기본정보  InOutDTO
        /// author       : kimchihwan
        /// create date  : 2012-04-30 오후 5:29:13
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT> Scheduel_TEMP
        {
            get { return this.scheduel_temp; }
            set { if (this.scheduel_temp != value) { this.scheduel_temp = value; this.OnPropertyChanged("Scheduel_TEMP", value); } }
        }

        List<HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>> scheduel_list = new List<HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>>();
        /// <summary>
        /// desc         : 진료일정 기본정보  InOutDTO
        /// author       : kimchihwan
        /// create date  : 2012-04-30 오후 5:29:13
        /// update date  : 
        /// </summary>
        public List<HSFDTOCollectionBaseObject<MedDoctorScheduleCriteriaRegistration_INOUT>> Scheduel_LIST
        {
            get { return this.scheduel_list; }
            set { if (this.scheduel_list != value) { this.scheduel_list = value; this.OnPropertyChanged("Scheduel_LIST", value); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Schedule_IN> schedule_in = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Schedule_IN>();
        /// <summary>
        /// desc         : 의사일정 등록 In DTO
        /// author       : kimchihwan
        /// create date  : 2012-09-17 오후 12:44:07
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Schedule_IN> Schedule_IN
        {
            get { return this.schedule_in; }
            set { if (this.schedule_in != value) { this.schedule_in = value; this.OnPropertyChanged("Schedule_IN"); } }
        }

        MedDoctorScheduleRegistration_Schedule_IN schedule_in_part = new MedDoctorScheduleRegistration_Schedule_IN();
        /// <summary>
        /// desc         : 의사일정 등록 In DTO
        /// author       : kimchihwan
        /// create date  : 2012-09-17 오후 12:44:07
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleRegistration_Schedule_IN Schedule_IN_Part
        {
            get { return this.schedule_in_part; }
            set { if (this.schedule_in_part != value) { this.schedule_in_part = value; this.OnPropertyChanged("Schedule_IN_Part"); } }
        }

        MedDoctorScheduleRegistration_SFAD_INOUT sfad_in = new MedDoctorScheduleRegistration_SFAD_INOUT();
        /// <summary>
        /// desc         : 대진일정조회 InDTO
        /// author       : kimchihwan
        /// create date  : 2012-10-16 오후 14:10:00
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleRegistration_SFAD_INOUT SFAD_IN
        {
            get { return this.sfad_in; }
            set { if (this.sfad_in != value) { this.sfad_in = value; this.OnPropertyChanged("SFAD_IN"); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_SFAD_INOUT> sfad_out = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_SFAD_INOUT>();
        /// <summary>
        /// desc         : 대진일정조회 OUT DTO
        /// author       : kimchihwan
        /// create date  : 2012-10-16 오후 14:10:00
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_SFAD_INOUT> SFAD_OUT
        {
            get { return this.sfad_out; }
            set { if (this.sfad_out != value) { this.sfad_out = value; this.OnPropertyChanged("SFAD_OUT"); } }
        }

        MedDoctorScheduleRegistration_CALL_IN call_in = new MedDoctorScheduleRegistration_CALL_IN();
        /// <summary>
        /// desc         : 콜전송내역 InDTO
        /// author       : kimchihwan
        /// create date  : 2012-10-16 오후 14:10:00
        /// update date  : 
        /// </summary>
        public MedDoctorScheduleRegistration_CALL_IN CALL_IN
        {
            get { return this.call_in; }
            set { if (this.call_in != value) { this.call_in = value; this.OnPropertyChanged("CALL_IN"); } }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CALL_OUT> call_out = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CALL_OUT>();
        /// <summary>
        /// desc         : 콜전송내역 OUT DTO
        /// author       : kimchihwan
        /// create date  : 2012-10-16 오후 14:10:00
        /// update date  : 
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_CALL_OUT> CALL_OUT
        {
            get { return this.call_out; }
            set { if (this.call_out != value) { this.call_out = value; this.OnPropertyChanged("CALL_OUT"); } }
        }

        TimeZoneClassfiedByReservation_IN selTimeZoneClassfiedByReservationinobj = new TimeZoneClassfiedByReservation_IN();
        /// <summary>
        /// desc         : 시간대별진료예약현황조회 IN DTO Property
        /// author       : SeoSeokMin 
        /// create Date  : 2012-02-08 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public TimeZoneClassfiedByReservation_IN SelTimeZoneClassfiedByReservationInObj
        {
            get { return this.selTimeZoneClassfiedByReservationinobj; }
            set
            {
                if (this.selTimeZoneClassfiedByReservationinobj != value)
                { this.selTimeZoneClassfiedByReservationinobj = value; this.OnPropertyChanged("SelTimeZoneClassfiedByReservationInObj"); }
            }
        }


        MedDoctorScheduleRegistrationCostRegularReservation_INOUT inCostRegularReservation = new MedDoctorScheduleRegistrationCostRegularReservation_INOUT();
        /// <summary>
        /// desc         : 비정규예약 IN DTO Property
        /// author       : 송민수 
        /// create Date  : 2016-03-08 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public MedDoctorScheduleRegistrationCostRegularReservation_INOUT InCostRegularReservation
        {
            get { return this.inCostRegularReservation; }
            set
            {
                if (this.inCostRegularReservation != value)
                { this.inCostRegularReservation = value; this.OnPropertyChanged("InCostRegularReservation"); }
            }
        }



        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationCostRegularReservation_INOUT> selCostRegularReservation = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationCostRegularReservation_INOUT>();
        /// <summary>
        /// desc         : 비정규예약 OUT DTO Property
        /// author       : 송민수 
        /// create Date  : 2016-03-08 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationCostRegularReservation_INOUT> SelCostRegularReservation
        {
            get { return this.selCostRegularReservation; }
            set
            {
                if (this.selCostRegularReservation != value)
                { this.selCostRegularReservation = value; this.OnPropertyChanged("SelCostRegularReservation"); }
            }
        }


        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT> selMedDoctorScheduleRegistrationSaveACDPCAPD = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT>();
        /// <summary>
        /// desc         : 비정규예약 체크조회 OUT DTO
        /// author       : 송민수 
        /// create Date  : 2016-03-08 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT> SelMedDoctorScheduleRegistrationSaveACDPCAPD
        {
            get { return this.selMedDoctorScheduleRegistrationSaveACDPCAPD; }
            set
            {
                if (this.selMedDoctorScheduleRegistrationSaveACDPCAPD != value)
                { this.selMedDoctorScheduleRegistrationSaveACDPCAPD = value; this.OnPropertyChanged("SelMedDoctorScheduleRegistrationSaveACDPCAPD"); }
            }
        }

        MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT inMedDoctorScheduleRegistrationSaveACDPCAPD = new MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT();
        /// <summary>
        /// desc         : 비정규예약 Save InDTO
        /// author       : 송민수 
        /// create Date  : 2016-03-08 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public MedDoctorScheduleRegistrationSaveACDPCAPD_INOUT InMedDoctorScheduleRegistrationSaveACDPCAPD
        {
            get { return this.inMedDoctorScheduleRegistrationSaveACDPCAPD; }
            set
            {
                if (this.inMedDoctorScheduleRegistrationSaveACDPCAPD != value)
                { this.inMedDoctorScheduleRegistrationSaveACDPCAPD = value; this.OnPropertyChanged("InMedDoctorScheduleRegistrationSaveACDPCAPD"); }
            }
        }
        MedDoctorScheduleRegistrationSaveACDPCAPDReqMemo_IN inMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo = new MedDoctorScheduleRegistrationSaveACDPCAPDReqMemo_IN();
        /// <summary>
        /// desc         : 비정규예약 Save InDTO
        /// author       : 송민수 
        /// create Date  : 2016-03-08 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public MedDoctorScheduleRegistrationSaveACDPCAPDReqMemo_IN InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo
        {
            get { return this.inMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo; }
            set
            {
                if (this.inMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo != value)
                { this.inMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo = value; this.OnPropertyChanged("InMedDoctorScheduleRegistrationSaveACDPCAPDReqMemo"); }
            }
        }

        HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Session_IN> inSessionInform = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Session_IN>();
        /// <summary>
        /// desc         : 비정규예약 Save InDTO
        /// author       : 송민수 
        /// create Date  : 2016-03-08 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_Session_IN> InSessionInform
        {
            get { return this.inSessionInform; }
            set
            {
                if (this.inSessionInform != value)
                { this.inSessionInform = value; this.OnPropertyChanged("InSessionInform"); }
            }
        }

        HSFDTOCollectionBaseObject<CommCdNmAsk_OUT> rsvRtcRsnList = new HSFDTOCollectionBaseObject<CommCdNmAsk_OUT>();
        /// <summary>
        /// desc         : 진료일정내역조회 OUT DTO Property
        /// author       : namdongkyun 
        /// create Date  : 2021-08-02 오후 09:01:23
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public HSFDTOCollectionBaseObject<CommCdNmAsk_OUT> RsvRtcRsnList
        {
            get { return this.rsvRtcRsnList; }
            set
            {
                if (this.rsvRtcRsnList != value)
                { this.rsvRtcRsnList = value; this.OnPropertyChanged("RsvRtcRsnList"); }
            }
        }


        private bool isFocused1 = false;
        public bool IsFocused1
        {
            get { return this.isFocused1; }
            set { this.isFocused1 = value; base.OnPropertyChanged("IsFocused1", value); }
        }

        private bool isFocused2 = false;
        public bool IsFocused2
        {
            get { return this.isFocused2; }
            set { this.isFocused2 = value; base.OnPropertyChanged("IsFocused2", value); }
        }

        private bool isFocused3 = false;
        public bool IsFocused3
        {
            get { return this.isFocused3; }
            set { this.isFocused3 = value; base.OnPropertyChanged("IsFocused3", value); }
        }

        private bool isFocused4 = false;
        public bool IsFocused4
        {
            get { return this.isFocused4; }
            set { this.isFocused4 = value; base.OnPropertyChanged("IsFocused4", value); }
        }

        CCCCCSTE_INOUT selectAcppricmInOutObj = new CCCCCSTE_INOUT();
        /// <summary>
        /// desc         : 원무사용자권한 INOUTDTO
        /// author       : namdongkyun 
        /// create Date  : 2020-09-29 오후 12:44:07
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        public CCCCCSTE_INOUT SelectAcppricmInOutObj
        {
            get { return this.selectAcppricmInOutObj; }
            set
            {
                if (this.selectAcppricmInOutObj != value)
                { this.selectAcppricmInOutObj = value; this.OnPropertyChanged("SelectAcppricmInOutObj"); }
            }
        }

        private string checkChanged; // Control_OnSelectChange 여러번 실행되는 것 방지
        /// <summary>
        /// name : Control_OnSelectChange 여러번 실행되는 것 방지
        /// </summary>
        public string CheckChanged
        {
            get { return checkChanged; }
            set { if (this.checkChanged != value) this.checkChanged = value; this.OnPropertyChanged("CheckChanged"); }
        }
    }
}
