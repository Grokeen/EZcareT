
using HIS.PA.AC.PE.PS.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using System;

namespace HIS.PA.AC.PE.PS.DAC
{
    /// <summary>
    /// name         : #논리DAC 클래스명
    /// desc         : #DAC클래스 개요
    /// author       : leegidong 
    /// create date  : 2016-05-06 오후 3:56:23
    /// update date  : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class SelectStfPsnyFamAdsCrccmDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection 설정
        /// desc         : #실행할 DB Connection을 지정합니다.
        /// author       : leegidong 
        /// create date  : 2016-05-06 오후 3:56:23
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle; // #팀별 적절한 DBEnum으로 변경
        }

        /// <summary>
        /// name         : #메소드 논리명
        /// desc         : #메소드 개요
        /// author       : leegidong 
        /// create date  : 2016-01-29 오전 11:10:11
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>      
        public HSFDTOCollectionBaseObject<SelectStfPsnyFamAdsCrccm_OUT> SelectStfPsnyFamAdsCrccm_01(SelectStfPsnyFamAdsCrccm_IN obj)
        {
            var result = this.DacAgent.Fill("HIS.PA.AC.PE.PS.SelectStfPsnyFamAdsCrccm_01", obj, typeof(HSFDTOCollectionBaseObject<SelectStfPsnyFamAdsCrccm_OUT>)) as HSFDTOCollectionBaseObject<SelectStfPsnyFamAdsCrccm_OUT>;
            return result;
        }

        /// <summary>
        /// name         : #메소드 논리명
        /// desc         : #메소드 개요
        /// author       : leegidong 
        /// create date  : 2016-01-29 오전 11:10:11
        /// update date  : #최종 수정 일자, 수정자, 수정개요 
        /// </summary>      
        public HSFDTOCollectionBaseObject<SelectStfPsnyFamAdsCrccm_OUT> SelectStfPsnyFamAdsCrccm_02(SelectStfPsnyFamAdsCrccm_IN obj)
        {
            var result = this.DacAgent.Fill("HIS.PA.AC.PE.PS.SelectStfPsnyFamAdsCrccm_02", obj, typeof(HSFDTOCollectionBaseObject<SelectStfPsnyFamAdsCrccm_OUT>)) as HSFDTOCollectionBaseObject<SelectStfPsnyFamAdsCrccm_OUT>;
            return result;
        }
    }
}
