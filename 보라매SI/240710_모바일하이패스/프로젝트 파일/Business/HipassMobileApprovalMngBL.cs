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
using HIS.PA.AC.PE.PS.DTO;
using HIS.PA.AC.PE.PS.DAC;
using HIS.Core;

namespace HIS.PA.AC.PE.PS.BIZ
{
    /// <summary>
    /// name         : 수진이력 조회 BIZ 클래스
    /// desc         : 수진이력 조회 BIZ 클래스
    /// author       : 장용규
    /// create date  : 2012-12-06 오후 4:02:42
    /// update date  : 최종 수정일자, 수정자, 수정개요
    /// </summary>
    public class HipassMobileApprovalMngBL : BizBase//, IHavingAMedicalExaminationHistoryBL
    {



        /// <summary>
        /// name               : 진료과별 수진상병조회
        /// i/f inheritance yn : Y
        /// logic              : 진료과별 수진상병정보를 조회함.
        /// desc               : 진료과별 수진상병정보를 조회함.
        /// author             : 장용규 
        /// create date        : 2011-12-21
        /// update date        : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <param name="in_from_date, in_to_date">날짜 범위</param>
        /// <returns>반환문자열</returns>
        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> HipassMobileApprovalMng_GrDateAV(HipassMobileApprovalMng_IN temp)
        {
            // 테스트값
            //in_from_date = "2023-03-01";
            //in_to_date = "2024-07-10";



            // 여기서 참조를? 하면서 바로 return?
            using (HipassMobileApprovalMngDL GrDate_Average = new HipassMobileApprovalMngDL())
            {
                return GrDate_Average.SelectHipassMobileApprovalMng_OUT(temp);
            }
        }



    }
}
