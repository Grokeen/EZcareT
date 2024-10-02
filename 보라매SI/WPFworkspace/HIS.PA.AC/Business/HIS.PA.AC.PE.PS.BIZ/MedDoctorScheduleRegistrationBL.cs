
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;


using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ORM;
using HSF.TechSvc2010.Server.ComBase;

using HIS.Core;
//using HIS.PA.AC.PE.SC.DTO;
//using HIS.PA.AC.PE.SC.DAC;

using HIS.PA.AC.PE.PS.DTO;
using HIS.PA.AC.PE.PS.DAC;

namespace HIS.PA.AC.PE.PS.BIZ
{
    class MedDoctorScheduleRegistrationBL : BizBase
    {


        /// ---------------------------------------------------------------------
        /// <summary>
        /// name               : UpdateDoctorPlusWorkBIZ
        /// desc               : 보충진료등록 화면 신규/수정/삭제
        /// author             : 김용록
        /// update date        : 2024-09-25
        /// </summary>
        /// ---------------------------------------------------------------------
        [HSFTransaction(HSFTransactionOption.Required)]
        public Boolean UpdateDoctorPlusWorkBIZ(MedDoctorScheduleRegistration_PlusWork_UPDATE GR_inObj)
        {
            using (MedDoctorScheduleRegistrationDL com = new MedDoctorScheduleRegistrationDL())
            {
                return com.UpdateDoctorPlusWork(GR_inObj);
            }
        }

        /// ---------------------------------------------------------------------
        /// <summary>
        /// name               : SelectDoctorPlusWorkBIZ
        /// desc               : 보충진료등록 화면 조회
        /// author             : 김용록
        /// update date        : 2024-09-25
        /// </summary>
        /// ---------------------------------------------------------------------
        [HSFTransaction(HSFTransactionOption.Supported)]
        public HSFDTOCollectionBaseObject<MedDoctorScheduleRegistration_PlusWork_INOUT> SelectDoctorPlusWorkBIZ(MedDoctorScheduleRegistration_PlusWork_INOUT YR_inObj)
        {
            using (MedDoctorScheduleRegistrationDL com = new MedDoctorScheduleRegistrationDL())
            {
                return com.SelectDoctorPlusWork(YR_inObj);
            }
        }
    }
}
