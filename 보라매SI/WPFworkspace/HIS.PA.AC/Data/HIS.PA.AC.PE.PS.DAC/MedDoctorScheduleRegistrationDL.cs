using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;

using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ORM;
using HSF.TechSvc2010.Server.ComBase;
using HIS.PA.AC.PE.PS.DTO;
using HSF.TechSvc2010.Server.DAC;



using HSF.COM.Core;

namespace HIS.PA.AC.PE.PS.DAC
{

    [HSFTransaction(HSFTransactionOption.Supported)]
    class MedDoctorScheduleRegistrationDL
    {

        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : 김용록 
        /// create date  : 2024-07-21 오후 1:14:17
        /// update date  : 
        /// </summary>
        //protected override void SetDataSource()
        //{
        //    base.DataSource = DBEnum.BILOracle; // #팀별 적절한 DBEnum으로 변경
        //}



        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : UpdateDoctorPlusWork
        /// desc         : 보충진료등록 화면 신규/수정/삭제
        /// author       : 김용록
        /// create date  : 2024-09-25
        /// update date  :
        /// </summary>
        /// ---------------------------------------------------------------------
        public Boolean UpdateDoctorPlusWork(MedDoctorScheduleRegistration_PlusWork_UPDATE GR_inObj)
        {

            //if (GR_inObj.IN_TYPE == "1")
            //{ //신규
            //    return (int)this.DacAgent.ExecuteBatch(GR_inObj, "HIS.PA.AC.PE.SC.InsertDoctorPlusWork") > 0;
            //}
            //else if (GR_inObj.IN_TYPE == "2")
            //{ //수정
            //    return (int)this.DacAgent.ExecuteBatch(GR_inObj, "HIS.PA.AC.PE.SC.UpdateDoctorPlusWork") > 0;
            //}
            //else if (GR_inObj.IN_TYPE == "3")
            //{//삭제
            //    return (int)this.DacAgent.ExecuteBatch(GR_inObj, "HIS.PA.AC.PE.SC.UpdateCnlDoctorPlusWork") > 0;
            //}
            return false;
        }

        /// ---------------------------------------------------------------------
        /// <summary>
        /// name         : SelectDoctorPlusWork
        /// desc         : 보충진료등록 화면 조회
        /// author       : 김용록
        /// create date  : 2024-09-25
        /// update date  : 
        /// </summary>
        /// ---------------------------------------------------------------------
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT> SelectDoctorPlusWork(MedDoctorScheduleRegistration_PlusWork_INOUT YR_inObj)
        {
            //return (HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>)this.DacAgent.Fill("HIS.PA.AC.PE.SC.SelectDoctorPlusWork", YR_inObj, typeof(HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>));

            //return this.DacAgent.Fill("HIS.PA.AC.PE.SC.SelectDoctorPlusWork", YR_inObj, typeof(HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>)) as HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>;

            HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT> aa = new HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT>();
            return aa;

        }


    }
}
