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

namespace HIS.PA.AC.PE.PS.DAC
{
    /// <summary>
    /// name         : 논리 DAC 클래스 명
    /// desc         : DAC 클래스 개요	
    /// author       : jangyongkyu
    /// create date  : 2012-03-19 오후 1:10:45
    /// update date  : 최종 수정일자, 수정자, 수정개요
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class HavingAMedicalExaminationHistoryAskDL : DacBase
    {
        /// <summary>
        /// name         : 메소드 논리명
        /// desc         : 메소드 개요
        /// author       : jangyongkyu
        /// create date  : 2012-03-19 오후 1:10:45
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle;
        }






        /// <summary>
        /// name         : 외래수진이력 조회
        /// desc         : 외래수진이력 정보를 조회함.
        /// author       : 장용규
        /// create date  : 2012-02-07 오후 7:35:44
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>데이타셋</returns>
        public HSFDTOCollectionBaseObject<SelOutPatientHavingAMedicalHistory_OUT> SelPatientHavingMedicalDL(SelOutPatientHavingAMedicalHistory_IN inObj)
        {

            HSFDTOCollectionBaseObject<SelOutPatientHavingAMedicalHistory_OUT> result = (HSFDTOCollectionBaseObject<SelOutPatientHavingAMedicalHistory_OUT>)this.DacAgent.Fill
                ("HIS.PA.AC.PE.PS.SelOutPatientHavingAMedicalHistory", inObj, typeof(HSFDTOCollectionBaseObject<SelOutPatientHavingAMedicalHistory_OUT>)) as HSFDTOCollectionBaseObject<SelOutPatientHavingAMedicalHistory_OUT>;
            return result;

        }


        /// <summary>
        /// name         : 입원수진이력 조회
        /// desc         : 입원수진이력 정보를 조회함.
        /// author       : 장용규
        /// create date  : 2012-02-07 오후 7:35:44
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>데이타셋</returns>
        public HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalDetail_OUT> SelAdmissionHisrotyDL(SelOutPatientHavingAMedicalHistory_IN inObj)
        {

            HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalDetail_OUT> result = (HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalDetail_OUT>)this.DacAgent.Fill
                ("HIS.PA.AC.PE.PS.SelAdmissionHavingAMedicalDetail", inObj, typeof(HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalDetail_OUT>)) as HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalDetail_OUT>;
            return result;
        }


        /// <summary>
        /// name         : 수진일자별 조회, 외래수진 상세조회
        /// desc         : 수진일자별 조회 및 외래수진 상세(진료과 입력) 정보를 조회함.
        /// author       : 이종은
        /// create date  : 2012-02-07 오후 7:35:44
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>데이타셋</returns>
        public HSFDTOCollectionBaseObject<HavingAMedicalExaminationDateClassfiedBy_OUT> SelectHavingAMedicalExaminationDateClassfiedBy(HavingAMedicalExaminationDateClassfiedBy_IN inObj)
        {

            HSFDTOCollectionBaseObject<HavingAMedicalExaminationDateClassfiedBy_OUT> result = (HSFDTOCollectionBaseObject<HavingAMedicalExaminationDateClassfiedBy_OUT>)this.DacAgent.Fill
                ("HIS.PA.AC.PE.PS.SelHavingAMedicalExaminationDateClassfiedBy", inObj, typeof(HSFDTOCollectionBaseObject<HavingAMedicalExaminationDateClassfiedBy_OUT>)) as HSFDTOCollectionBaseObject<HavingAMedicalExaminationDateClassfiedBy_OUT>;
            return result;
        }






        /// <summary>
        /// name         : 입원수진이력 상세조회
        /// desc         : Relations 구조의 데이타를 DTO에 바인딩
        /// author       : 장용규
        /// create date  : 2012-02-07 오후 7:35:44
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>데이타셋</returns>
        public HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalExaminationDetail_OUT> SelAdmissionHavingDetailDL(SelAdmissionHavingAMedicalExaminationDetail_IN inObj)
        {

            HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalExaminationDetail_OUT> result = (HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalExaminationDetail_OUT>)this.DacAgent.Fill
                ("HIS.PA.AC.PE.PS.SelectAdmissionHavingAMedicalExaminationDetail", inObj, typeof(HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalExaminationDetail_OUT>)) as HSFDTOCollectionBaseObject<SelAdmissionHavingAMedicalExaminationDetail_OUT>;
            return result;
        }




        /// <summary>
        /// name         : 수진 상병내역 정보 조회
        /// desc         : Relations 구조의 데이타를 DTO에 바인딩
        /// author       : 이종은
        /// create date  : 2012-02-07 오후 7:35:44
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>데이타셋</returns>
        public HSFDTOCollectionBaseObject<HavingAMedicalExaminationSickness_OUT> SelHavingMedicalExamSicknessDL(SelOutPatientHavingAMedicalHistory_IN inObj)
        {

            HSFDTOCollectionBaseObject<HavingAMedicalExaminationSickness_OUT> result = (HSFDTOCollectionBaseObject<HavingAMedicalExaminationSickness_OUT>)this.DacAgent.Fill
                ("HIS.PA.AC.PE.PS.SelHavingAMedicalExaminationSickness", inObj, typeof(HSFDTOCollectionBaseObject<HavingAMedicalExaminationSickness_OUT>)) as HSFDTOCollectionBaseObject<HavingAMedicalExaminationSickness_OUT>;
            return result;
        }



        /// <summary>
        /// name         : 수진 상병내역 정보 조회
        /// desc         : Relations 구조의 데이타를 DTO에 바인딩
        /// author       : 이종은
        /// create date  : 2012-02-07 오후 7:35:44
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>데이타셋</returns>
        public SelOutPatientHavingAMedicalHistory_OUT SelBscAdressDL(SelOutPatientHavingAMedicalHistory_IN inObj)
        {

            SelOutPatientHavingAMedicalHistory_OUT result = (SelOutPatientHavingAMedicalHistory_OUT)this.DacAgent.Fill
                ("HIS.PA.AC.PE.PS.SelBscAdress", inObj, typeof(SelOutPatientHavingAMedicalHistory_OUT)) as SelOutPatientHavingAMedicalHistory_OUT;
            return result;
        }


        ////// <summary>
        ////// name         : Relations 구조의 데이타를 DTO에 바인딩
        ////// desc         : Relations 구조의 데이타를 DTO에 바인딩
        ////// author       : 이종은
        ////// create date  : 2012-02-07 오후 7:35:44
        ////// update date  : 최종 수정일자, 수정자, 수정개요
        ////// </summary>
        ////// <returns>데이타셋</returns>
        //[HSFTransaction(HSFTransactionOption.Supported)]
        //public HSFDTOCollectionBaseObject<HavingAMedicalAdmissionHistory_OUT> SelectAdmissionHistory(HavingAMedicalExaminationHistoryAsk_IN inObj)
        //{

        //    HSFDTOCollectionBaseObject<HavingAMedicalAdmissionHistory_OUT> result = (HSFDTOCollectionBaseObject<HavingAMedicalAdmissionHistory_OUT>)this.DacAgent.Fill
        //        ("HIS.PA.AC.PE.PS.SelectAdmissionHistory", inObj, typeof(HSFDTOCollectionBaseObject<HavingAMedicalAdmissionHistory_OUT>)) as HSFDTOCollectionBaseObject<HavingAMedicalAdmissionHistory_OUT>;
        //    return result;
        //}

        /// <summary>
        /// name         : 수진 상병내역 정보 조회
        /// desc         : Relations 구조의 데이타를 DTO에 바인딩
        /// author       : 이종은
        /// create date  : 2012-02-07 오후 7:35:44
        /// update date  : 최종 수정일자, 수정자, 수정개요
        /// </summary>
        /// <returns>데이타셋</returns>
        public HSFDTOCollectionBaseObject<SelGradeWdDeptInfo_OUT> SelGradeWdDeptInfoDL(SelGradeWdDeptInfo_IN inObj)
        {

            HSFDTOCollectionBaseObject<SelGradeWdDeptInfo_OUT> result = (HSFDTOCollectionBaseObject<SelGradeWdDeptInfo_OUT>)this.DacAgent.Fill
                ("HIS.PA.AC.PE.PS.SelGradeWardNoInfo", inObj, typeof(HSFDTOCollectionBaseObject<SelGradeWdDeptInfo_OUT>)) as HSFDTOCollectionBaseObject<SelGradeWdDeptInfo_OUT>;
            return result;
        }

    }
}
