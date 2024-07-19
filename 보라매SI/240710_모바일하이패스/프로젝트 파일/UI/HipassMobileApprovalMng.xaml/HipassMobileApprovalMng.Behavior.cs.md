using HIS.PA.AC.PE.PS.DTO;
using HIS.UI.Base;
using HIS.UI.Core;
using HSF.TechSvc2010.Common;
using System;
using System.Linq;
using System.Windows;

namespace HIS.PA.AC.PE.PS.UI
{
    /// <summary>
    /// name         : HipassMobileApprovalMng Behavior 클래스
    /// desc         : HipassMobileApprovalMng Behavior 클래스
    /// author       : JaeGang 
    /// create date  : 2023-12-26 오전 9:17:34
    /// update date  : 최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    public partial class HipassMobileApprovalMng
    {
        #region [Consts]
        private const string BIZ_CLASS = "HIS.PA.AC.PE.PS.BIZ.HipassMobileApprovalMngBL";
        #endregion //Consts




        #region [Dependency Properties]
        #endregion //Dependency Properties




        // Date 정의 = model = O
        // DAC 정의 = model = X
        #region [Member Variables]
        /// <summary>
        /// 프레젠테이션 모델(PM) 
        /// </summary>
        private HipassMobileApprovalMngData model;

        #endregion 


        #region [Methods]
        private void HipassSearch()
        {
            // Console.WriteLine("2----------------------------------------------------------------");
            // IN 리스트 선언 ->
            //HSFDTOCollectionBaseObject<hipassMobileApprovalMng_INObj> in_obj = new HSFDTOCollectionBaseObject<hipassMobileApprovalMng_INObj>();


            // IN 리스트에 날짜 값을 담고 -> 어떻게 담지??????
            //in_obj.in_from_date = ftcal.FromDate;
            //in_obj.in_to_date = ftcal.ToDate;

            // 테스트값
            String in_from_date = "2024-04-01";
            String in_to_date = "2024-07-10";

            //model.hipassMobileApprovalMng_GrData_IN.IN_FROM_DATE = HIS.UI.Core.CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMdd");


            //model.hipassMobileApprovalMng_GrData_IN.IN_TO_DATE = HIS.UI.Core.CommonServiceAgent.SelectSysDateTime().ToString("yyyyMMdd");


            //model.MedicalCareNonApprobationAsk_INObj.IN_RPY_STF_NO = HIS.UI.Base.SessionManager.UserInfo.STF_NO;


            // IN 리스트에 넣은 값을 담아 보내서 OUT 리스트에 담는다.
            model.HipassMobileApprovalMng_OUTObj = (HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "HipassMobileApprovalMng_GrDateAV", in_from_date, in_to_date);


            // 데이터 없을 시
            if (model.HipassMobileApprovalMng_OUTObj.Count == 0)
            {
                MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
            }


            // OUT 값 초기화
            model.MedicalCareNonApprobationAsk_OUTObj.Clear();

            rblGubun.SelectedIndex = 0;
            ControlHelper.HFromToCalendarFocus(ftcal);

        }

        private void GRbtn_Click(object sender)
        {
            /* --------------------------------------------------------------- */
            // 조회 버튼
            if (sender.Equals(btnSearch))
            {
                HipassSearch();
            }



            /* --------------------------------------------------------------- */
            //승인 상태 체크박스
            if (sender.Equals(CheckBoxConfirm_YN))
            {

            }



            /* --------------------------------------------------------------- */
            // 승인 버튼
            if (sender.Equals(btnConfirm))
            {

            }


            /* --------------------------------------------------------------- */
            // 취소 버튼
            if (sender.Equals(btnCancle))
            {

            }


            /* --------------------------------------------------------------- */
            // 알림톡 버튼
            if (sender.Equals(btnAlarm))
            {

            }


            /* --------------------------------------------------------------- */
            // 초기화 버튼
            if (sender.Equals(btnFormat))
            {

            }


            /* --------------------------------------------------------------- */
            // 엑셀 버튼
            if (sender.Equals(btnExcel))
            {
                //this.dgrdMain.ToExcel("과별예약현황", "", true, false, 1, 1);
                #region 다운로드/출력 로그 설정                
                var excelDownloadLog = new DownloadPrint_IN()
                {
                    MenuID = "AC_HIS.PA.AC.PE.PS.UI_/MedicalTreDeptClassByOutPatientResvPatientCntAsk",
                    MenuName = "모바일하이패스",
                    Data = dgrdMain,
                    ExportType = DownloadPrint_IN.DownloadPrintType.Excel
                };

                if (!LoggingReasonHelper.InsertDownloadPrintLog(excelDownloadLog))
                {
                    return;
                }
                else
                {
                    this.dgrdMain.ToExcel("과별예약현황", "", true, false, 1, 1);
                }
                #endregion
            }


            /* --------------------------------------------------------------- */
            //닫기 버튼
            if (sender.Equals(btnClose)) 
            {
                this.Close();

            }

        }



        #endregion //Methods
    }
}
