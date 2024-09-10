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

//using HIS.Admin.Base.UI.Personalization;
//using HIS.Admin.Base.DTO;
using HIS.UI.CoreWork.DTO;
using HIS.Core.Global.DTO.Individuality;
using HIS.UI.Core.Individuality;
using HIS.Core.Common;
using HIS.Core.Global.DTO;
using System.Drawing.Printing;

namespace HIS.PA.PZ.AC.UI
{
    /// <summary>
    /// name         : #UserPersonalization Data 클래스
    /// desc         : #UserPersonalization Data 클래스
    /// author       : songminsu 
    /// create date  : 2016-09-27 오후 5:10:20
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public class UserPersonalizationData : HISDTOBase
    {

        #region [Member Variables]


        // this.CheckChangedData(model.RCP_PRNT_YN == true ? "Y" : "N", "AC", "PA004");
        // this.CheckChangedData(model.RSV_PRNT_STU_YN == true ? "Y" : "N", "AC", "PA005");
        // this.CheckChangedData(model.TEL_RSV_CLOS_CFMT_YN == true ? "Y" : "N", "AC", "PA006");
        // this.CheckChangedData(model.PRINT_INFO, "AC", "PA007");
        // this.CheckChangedData(model.KNLG_SEQ_PV, "AC", "PA008");
        // this.CheckChangedData(model.CTFS_CONR_PRTR, "AC", "PA009");
        // this.CheckChangedData(model.PRCD_ISSU_PV, "AC", "PA010");
        // this.CheckChangedData(model.LCD_AMT_MRK_PV_GUID_WDNG, "AC", "PA011");
        // this.CheckChangedData(model.USR_HSP_TP, "AC", "PA012");
        // this.CheckChangedData(model.OTPT_RPY_ASK_PRD, "AC", "PA014");
        // this.CheckChangedData(model.RPY_HH_BSC, "AC", "PA015");
        // this.CheckChangedData(model.FAX_PORT, "AC", "PA016");


        //금액표시기 화면 구분
        private string amt_mrk_mchn_scrn_tp;
        public string AMT_MRK_MCHN_SCRN_TP
        {
            get { return this.amt_mrk_mchn_scrn_tp; }
            set { this.amt_mrk_mchn_scrn_tp = value; this.OnPropertyChanged("AMT_MRK_MCHN_SCRN_TP"); }
        }

        //진료비 수납 재정산여부
        private bool mcst_rpy_acal_yn;
        public bool MCST_RPY_ACAL_YN
        {
            get { return this.mcst_rpy_acal_yn; }
            set { this.mcst_rpy_acal_yn = value; this.OnPropertyChanged("MCST_RPY_ACAL_YN"); }
        }


        //소속진료과목록 표시여부
        private bool blng_mtd_list_mrk_yn;
        public bool BLNG_MTD_LIST_MRK_YN
        {
            get { return this.blng_mtd_list_mrk_yn; }
            set { this.blng_mtd_list_mrk_yn = value; this.OnPropertyChanged("BLNG_MTD_LIST_MRK_YN"); }
        }

        //계산증출력여부
        private bool rcp_prnt_yn;
        public bool RCP_PRNT_YN
        {
            get { return this.rcp_prnt_yn; }
            set { this.rcp_prnt_yn = value; this.OnPropertyChanged("RCP_PRNT_YN"); }
        }

        //예약증출력 설정여부
        private bool rsv_prnt_stu_yn;
        public bool RSV_PRNT_STU_YN
        {
            get { return this.rsv_prnt_stu_yn; }
            set { this.rsv_prnt_stu_yn = value; this.OnPropertyChanged("RSV_PRNT_STU_YN"); }
        }

        //전화예약 닫힘 확인여부
        private bool tel_rsv_clos_cfmt_yn;
        public bool TEL_RSV_CLOS_CFMT_YN
        {
            get { return this.tel_rsv_clos_cfmt_yn; }
            set { this.tel_rsv_clos_cfmt_yn = value; this.OnPropertyChanged("TEL_RSV_CLOS_CFMT_YN"); }
        }

        //프린터설정
        private String _print_info;
        public String PRINT_INFO
        {
            get { return this._print_info; }
            set { this._print_info = value; this.OnPropertyChanged("PRINT_INFO"); }
        }

        private String _print_info2;
        public String PRINT_INFO2
        {
            get { return this._print_info2; }
            set { this._print_info2 = value; this.OnPropertyChanged("PRINT_INFO2"); }
        }

        private String _print_info3;
        public String PRINT_INFO3
        {
            get { return this._print_info3; }
            set { this._print_info3 = value; this.OnPropertyChanged("PRINT_INFO3"); }
        }

        private String _print_info4;
        public String PRINT_INFO4
        {
            get { return this._print_info4; }
            set { this._print_info4 = value; this.OnPropertyChanged("PRINT_INFO4"); }
        }

        //지능형순번기
        private string knlg_seq_pv;
        public string KNLG_SEQ_PV
        {
            get { return this.knlg_seq_pv; }
            set
            { this.knlg_seq_pv = value; this.OnPropertyChanged("KNLG_SEQ_PV"); }
        }

        //제증명창구 프린터
        private string ctfs_conr_prtr;
        public string CTFS_CONR_PRTR
        {
            get { return this.ctfs_conr_prtr; }
            set { this.ctfs_conr_prtr = value; this.OnPropertyChanged("CTFS_CONR_PRTR"); }
        }

        //진찰권 발급기
        private string prcd_issu_pv;
        public string PRCD_ISSU_PV
        {
            get { return this.prcd_issu_pv; }
            set { this.prcd_issu_pv = value; this.OnPropertyChanged("PRCD_ISSU_PV"); }
        }

        //LCD 금액표시기 안내문구
        private string lcd_amt_mrk_pv_guid_wdng;
        public string LCD_AMT_MRK_PV_GUID_WDNG
        {
            get { return this.lcd_amt_mrk_pv_guid_wdng; }
            set { this.lcd_amt_mrk_pv_guid_wdng = value; this.OnPropertyChanged("LCD_AMT_MRK_PV_GUID_WDNG"); }
        }


        //사용자 병원구분
        private string usr_hsp_tp;
        public string USR_HSP_TP
        {
            get { return this.usr_hsp_tp; }
            set { this.usr_hsp_tp = value; this.OnPropertyChanged("USR_HSP_TP"); }
        }

        //외래수납조회 기간
        private string otpt_rpy_ask_prd;
        public string OTPT_RPY_ASK_PRD
        {
            get { return this.otpt_rpy_ask_prd; }
            set { this.otpt_rpy_ask_prd = value; this.OnPropertyChanged("OTPT_RPY_ASK_PRD"); }
        }


        //수납 시 기본 결제수단-카드,현금영수증,현금
        private string rpy_hh_bsc;
        public string RPY_HH_BSC
        {
            get { return this.rpy_hh_bsc; }
            set { this.rpy_hh_bsc = value; this.OnPropertyChanged("RPY_HH_BSC"); }
        }


        //FAX포트
        private string fax_port;
        public string FAX_PORT
        {
            get { return this.fax_port; }
            set { this.fax_port = value; this.OnPropertyChanged("FAX_PORT"); }
        }


        //대상환자(보험)
        private bool tgt_pt_yn;
        public bool TGT_PT_YN
        {
            get { return this.tgt_pt_yn; }
            set { this.tgt_pt_yn = value; this.OnPropertyChanged("TGT_PT_YN"); }
        }


        //입원등록 공단자동체크
        private bool ads_reg_pcor_auto_insp_yn;
        public bool ADS_REG_PCOR_AUTO_INSP_YN
        {
            get { return this.ads_reg_pcor_auto_insp_yn; }
            set { this.ads_reg_pcor_auto_insp_yn = value; this.OnPropertyChanged("ADS_REG_PCOR_AUTO_INSP_YN"); }
        }

        //파일구분(보험)
        private string file_tp;
        public string FILE_TP
        {
            get { return this.file_tp; }
            set { this.file_tp = value; this.OnPropertyChanged("FILE_TP"); }
        }

        //청구구분(보험)
        private string dmd_tp;
        public string DMD_TP
        {
            get { return this.dmd_tp; }
            set { this.dmd_tp = value; this.OnPropertyChanged("DMD_TP"); }
        }

        //발송순번(보험)
        private string ship_seq;
        public string SHIP_SEQ
        {
            get { return this.ship_seq; }
            set { this.ship_seq = value; this.OnPropertyChanged("SHIP_SEQ"); }
        }

        //보험자구분(보험)
        private string isur_tp;
        public string ISUR_TP
        {
            get { return this.isur_tp; }
            set { this.isur_tp = value; this.OnPropertyChanged("ISUR_TP"); }
        }

        //진료년월(보험)
        private string med_yy_mm;
        public string MED_YY_MM
        {
            get { return this.med_yy_mm; }
            set { this.med_yy_mm = value; this.OnPropertyChanged("MED_YY_MM"); }
        }

        //진료분야(보험)
        private string med_fld;
        public string MED_FLD
        {
            get { return this.med_fld; }
            set { this.med_fld = value; this.OnPropertyChanged("MED_FLD"); }
        }

        // 라벨프린터
        private string label_prt;
        public string LABEL_PRT
        {
            get { return this.label_prt; }
            set
            {
                this.label_prt = value;
                this.OnPropertyChanged("LABEL_PRT");
            }
        }

        //응급실구분
        private bool emrm_yn;
        public bool EMRM_YN
        {
            get { return this.emrm_yn; }
            set
            {
                this.emrm_yn = value;
                this.OnPropertyChanged("EMRM_YN");
            }
        }


        //전화예약 체크리스트 사용여부
        private bool tel_rsv_insp_list_cfmt_yn;
        public bool TEL_RSV_INSP_LIST_CFMT_YN
        {
            get { return this.tel_rsv_insp_list_cfmt_yn; }
            set
            {
                this.tel_rsv_insp_list_cfmt_yn = value;
                this.OnPropertyChanged("TEL_RSV_INSP_LIST_CFMT_YN");
            }
        }

        //원외처방전 프린터 사용여부
        private bool hsot_ord_prtr_stu_yn;
        public bool HSOT_ORD_PRTR_STU_YN
        {
            get { return this.hsot_ord_prtr_stu_yn; }
            set
            {
                this.hsot_ord_prtr_stu_yn = value;
                this.OnPropertyChanged("HSOT_ORD_PRTR_STU_YN");
            }
        }

        

        /// <summary>
        /// SIXMONTH_YN	    -- 180 조회 //2013.07.19 추가
        /// </summary> 
        public bool SIXMONTH_YN
        {
            get { return this.sixmonth_yn; }
            set { if (this.sixmonth_yn != value) { this.sixmonth_yn = value; this.OnPropertyChanged("SIXMONTH_YN", value); } }
        }
        private bool sixmonth_yn;

        /// <summary>
        /// 사용자 환경설정에 들어갈 영수증 급지함 세팅.
        /// </summary>
        private Int16 bill_tray_num;
        public Int16 BILL_TRAY_NUM
        {
            get { return this.bill_tray_num; }
            set { if (this.bill_tray_num != value) { this.bill_tray_num = value; this.OnPropertyChanged("BILL_TRAY_NUM", value); } }
        }

        /// <summary>
        /// 사용자 환경설정에 들어갈 원외처방전 급지함 세팅.
        /// </summary>
        private Int16 pres_tray_num;
        public Int16 PRES_TRAY_NUM
        {
            get { return this.pres_tray_num; }
            set { if (this.pres_tray_num != value) { this.pres_tray_num = value; this.OnPropertyChanged("PRES_TRAY_NUM", value); } }
        }

        /// <summary>
        /// 사용자 환경설정에 들어갈 제증명 급지함 세팅.
        /// </summary>
        private Int16 repo_tray_num;
        public Int16 REPO_TRAY_NUM
        {
            get { return this.repo_tray_num; }
            set { if (this.repo_tray_num != value) { this.repo_tray_num = value; this.OnPropertyChanged("REPO_TRAY_NUM", value); } }
        }
        // 진찰권 프린트 
        //public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> PRCD_PRINT
        //{
        //    get
        //    {
        //        return new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>() { new CCCCCSTE_INOUT() { COMN_CD = "", COMN_CD_NM = "없음" }, new CCCCCSTE_INOUT() { COMN_CD = "HODOO", COMN_CD_NM = "신형" }, new CCCCCSTE_INOUT() { COMN_CD = "SMART", COMN_CD_NM = "I&A" } };
        //    }
        //}


        // 라벨 프린트 
        //public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> LABEL_PRINT
        //{
        //    get
        //    {
        //        return new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>() { new CCCCCSTE_INOUT() { COMN_CD = "", COMN_CD_NM = "없음" }, new CCCCCSTE_INOUT() { COMN_CD = "ZEBRA", COMN_CD_NM = "ZEBRA" } };
        //    }
        //}

        // LCD 금액표시기 안내문구
        public HSFDTOCollectionBaseObject<CCCCCSTE_INOUT> LCD_SCREENS
        {
            get
            {
                return new HSFDTOCollectionBaseObject<CCCCCSTE_INOUT>() { new CCCCCSTE_INOUT() { COMN_CD = "GF", COMN_CD_NM = "정상근무" }, new CCCCCSTE_INOUT() { COMN_CD = "N1", COMN_CD_NM = "전산장애" }
                                                                        , new CCCCCSTE_INOUT() { COMN_CD = "N2", COMN_CD_NM = "휴가중" }, new CCCCCSTE_INOUT() { COMN_CD = "N3", COMN_CD_NM = "점심시간" }
                                                                        , new CCCCCSTE_INOUT() { COMN_CD = "N4", COMN_CD_NM = "외부교육" }, new CCCCCSTE_INOUT() { COMN_CD = "N5", COMN_CD_NM = "타업무중" }};

            }
        }     
        
        #endregion //Member Variables

        #region [View Properties]
        #endregion //View  Properties

        #region [Model Properties]


        /// <summary>
        /// 변경된 메인별 전역 개인화 항목을 관리 한다.
        /// </summary>
        public HSFDTOCollectionBaseObject<PrivateSetting_DTO> GLOBAL_ITEM_LIST
        {
            get { return global_item_list; }
            set { if (global_item_list != value) { global_item_list = value; OnPropertyChanged("GLOBAL_ITEM_LIST", value); } }
        }

        private HSFDTOCollectionBaseObject<PrivateSetting_DTO> global_item_list = new HSFDTOCollectionBaseObject<PrivateSetting_DTO>();

        /// <summary>
        /// name         : 사용자 개인화 설정 정보
        /// desc         : 넘겨 받은 인자 값으로 부터(mainCd, itemCd) 사용자 개인화 설정 정보를 검색하여 PrivateSetting_DTO Type으로 반환 한다.
        /// author       : 송일현 
        /// create date  : 2012-11-23 오전 10:49:12
        /// update date  : 최종 수
        /// </summary>
        /// <param name="value"></param>
        /// <param name="mainCd"></param>
        /// <param name="itemCd"></param>
        public HSFDTOCollectionBaseObject<PrivateSetting_DTO> Get_GLOBAL_DTO(String mainCd, String itemCd, Individuality_Classify mode)
        {
            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd] == null)
            {
                return null;
            }

            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd] == null)
            {
                return null;
            }

            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].Count > 0)
            {
                return IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING.SearchPrivateSettingItemInfoList(mode, itemCd);
            }
            else
            {
                return null;
            }
        }


        /// <summary>
        /// name         : 사용자 개인화 설정 정보
        /// desc         : 넘겨 받은 인자 값으로 부터(mainCd, itemCd) 사용자 개인화 설정 정보를 검색하여 PrivateSetting_DTO Type으로 반환 한다.
        /// author       : 송일현 
        /// create date  : 2012-11-23 오전 10:49:12
        /// update date  : 최종 수
        /// </summary>
        /// <param name="value"></param>
        /// <param name="mainCd"></param>
        /// <param name="itemCd"></param>
        public PrivateSetting_DTO Get_GLOBAL_DTO(String mainCd, String itemCd)
        {
            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd] == null)
            {
                return null;
            }

            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd] == null)
            {
                return null;
            }

            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].Count > 0)
            {
                return IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault();
            }
            else
            {
                return null;
            }
        }



        /// <summary>
        /// name         : 사용자 개인화 설정 정보의 항목 설정값
        /// desc         : 넘겨 받은 인자 값으로 부터(mainCd, itemCd) 사용자 개인화 설정 정보를 검색하여 항목에 설정된 Value값을 String Type으로 반환 한다.
        /// author       : 송일현 
        /// create date  : 2012-11-23 오전 10:49:12
        /// update date  : 최종 수
        /// </summary>
        /// <param name="value"></param>
        /// <param name="mainCd"></param>
        /// <param name="itemCd"></param>
        public string Get_GLOBAL_String(String mainCd, String itemCd)
        {
            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd] == null)
            {
                return "";
            }

            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd] == null)
            {
                return "";
            }

            if (IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].Count > 0)
            {
                return IndividualityWizard.PRIVATE_SETTING.HOSPITAL_PRIVATE_SETTING[mainCd].GLOBAL_PRIVATE_SETTING[itemCd].FirstOrDefault().ITEM_CHR_VAL;
            }
            else
            {
                return "";
            }
        }


        //금액표시기 화면 위치
        private string amt_mrk_mchn_scrn_pstn;
        public string AMT_MRK_MCHN_SCRN_PSTN
        {
            get { return this.amt_mrk_mchn_scrn_pstn; }
            set
            {
                this.amt_mrk_mchn_scrn_pstn = value;
                this.OnPropertyChanged("AMT_MRK_MCHN_SCRN_PSTN");
            }
        }


        #endregion //Model Properties
    }


    /// <summary>
    /// 영수증, 처방전 등 설치된 프린터 정보
    /// </summary>
    public class InstalledPrinter : HISDTOBase
    {
        private String _print_name;
        public String PRINT_NAME
        {
            get { return this._print_name; }
            set
            {
                this._print_name = value;
                this.OnPropertyChanged("PRINT_NAME");
            }
        }

        HSFDTOCollectionBaseObject<PrinterSource> print_source = new HSFDTOCollectionBaseObject<PrinterSource>();
        /// <summary>
        /// name         : 설치된 프린터 정보
        /// desc         : 설치된 프린터 정보
        /// author       : 장선진
        /// create Date  : 2018-04-16 
        /// update date  : 최종 수정일자 , 수정자, 수정개요
        /// </summary>
        /// <remarks></remarks>
        public HSFDTOCollectionBaseObject<PrinterSource> Printer_Sources
        {
            get { return print_source; }
            set { if (print_source != value) { print_source = value; OnPropertyChanged("Printer_Sources", value); } }
        }
    }
    /// <summary>
    /// 영수증, 처방전 등 지정된 프린터의 급지함 정보를 저장한다. 
    /// </summary>
    public class PrinterSource : HISDTOBase
    {
        private int _rawkind;
        /// <summary>
        /// 급지함 RawKind
        /// </summary>
        public int RAWKIND
        {
            get { return this._rawkind; }
            set
            {
                this._rawkind = value;
                this.OnPropertyChanged("RAWKIND");
            }
        }

        /// <summary>
        /// 급지함 이름
        /// </summary>
        private String _source_name;
        public String SOURCE_NAME
        {
            get { return this._source_name; }
            set
            {
                this._source_name = value;
                this.OnPropertyChanged("SOURCE_NAME");
            }
        }
    }
}
