using HIS.UI.Base;
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





        // DAC 정의 = model
        #region [Member Variables]
        /// <summary>
        /// 프레젠테이션 모델(PM) 
        /// </summary>

        private HipassMobileApprovalMngData model;
        #endregion //Member Variables





        #region [Methods]
        // 쿼리 문을 아에 값으로 담아서 보내는 방식도 있음
        private void HipassWay1()
        {
            String strQuery = "";
            if (rblGubun.SelectedIndex == 0)
            {
                strQuery = "HIS.PA.AC.PE.PS.Sel1MedicalCareApprobationAsk";
            }
            else if (rblGubun.SelectedIndex == 1)
            {
                strQuery = "HIS.PA.AC.PE.PS.Sel2MedicalCareApprobationAsk";
            }
            else
            {
                strQuery = "HIS.PA.AC.PE.PS.Sel3MedicalCareApprobationAsk";
            }
            model.MedicalCareApprobationAsk_OUTObj = UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectMedicalCareApprobationAsk", model.MedicalCareApprobationAsk_INObj, strQuery) as HSFDTOCollectionBaseObject<MedicalCareApprobationAsk_OUT>;
            if (model.MedicalCareApprobationAsk_OUTObj.Count == 0) MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);
        }




        // 
        private void HipassWay2()
        {
            Console.WriteLine("2----------------------------------------------------------------");
            // IN 리스트 선언 ->
            HSFDTOCollectionBaseObject<hipassMobileApprovalMng_INObj> in_obj = new HSFDTOCollectionBaseObject<hipassMobileApprovalMng_INObj>();


            // IN 리스트에 날짜 값을 담고 -> 어떻게 담지??????
            in_obj.in_from_date = ftcal.FromDate;
            in_obj.in_to_date = ftcal.ToDate;



            Console.WriteLine("3----------------------------------------------------------------");
            // IN 리스트에 넣은 값을 담아 보내서 OUT 리스트에 담는다.
            HSFDTOCollectionBaseObject<hipassMobileApprovalMng_OUTObj> temp = (HSFDTOCollectionBaseObject<hipassMobileApprovalMng_OUTObj>)UIMiddlewareAgent.InvokeBizService(this, BIZ_CLASS, "SelectMedicalCareApprobationAsk", in_obj);

            


            // 데이터 없을 시
            if (model.MedicalCareNonApprobationAsk_OUTObj.Count == 0) MsgBox.Display("데이터가 존재하지 않습니다.", MessageType.MSG_TYPE_INFORMATION, Owner: this.OwnerWindow, messageButton: MessageBoxButton.OK);

        }



        #endregion //Methods
    }
}
