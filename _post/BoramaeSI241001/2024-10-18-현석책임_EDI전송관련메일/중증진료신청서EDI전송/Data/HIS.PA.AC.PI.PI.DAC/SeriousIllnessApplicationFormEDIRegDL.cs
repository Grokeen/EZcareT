using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using HIS.PA.AC.PI.PI.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ORM;
using HSF.TechSvc2010.Server.ComBase;
using HSF.TechSvc2010.Server.QueryStorage;

namespace HIS.PA.AC.PI.PI.DAC
{
    /// <summary>
    /// name         : 논리 DAC 클래스 명
    /// desc         : DAC 클래스 개요	
    /// author       : jeonkwangsik
    /// create date  : 2012-06-25 오후 1:56:02
    /// update date  : 최종 수정일자, 수정자, 수정개요
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class SeriousIllnessApplicationFormEDIRegDL : DacBase
    {
        /// <summary>
        /// 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT> SelSeriousIllnessApplicationFormEDIReg2(SelSeriousIllnessApplicationFormEDIReg2_IN inObj)
        {
            return this.DacAgent.Fill
                ("HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg2", inObj, typeof(HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT>)) as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT>;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public UpdSeriousIllnessApplicationFormEDIReg2_OUT UpdSeriousIllnessApplicationFormEDIReg2(UpdSeriousIllnessApplicationFormEDIReg2_IN inObj)
        {
            UpdSeriousIllnessApplicationFormEDIReg2_OUT result = new UpdSeriousIllnessApplicationFormEDIReg2_OUT();
            result.COUNT = Convert.ToInt32(this.DacAgent.ExecuteNonQuery("HIS.PA.AC.PI.PI.UpdSeriousIllnessApplicationFormEDIReg2", inObj));
            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public InsSeriousIllnessApplicationFormEDIReg_OUT InsSeriousIllnessApplicationFormEDIReg(InsSeriousIllnessApplicationFormEDIReg_IN inObj)
        {
            InsSeriousIllnessApplicationFormEDIReg_OUT result = new InsSeriousIllnessApplicationFormEDIReg_OUT();
            result.COUNT = Convert.ToInt32(this.DacAgent.ExecuteNonQuery("HIS.PA.AC.PI.PI.InsSeriousIllnessApplicationFormEDIReg", inObj));
            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public InsSeriousIllnessApplicationFormEDIReg_OUT UpdateSeriousIllnessApplicationFormEDIRegGCDN(InsSeriousIllnessApplicationFormEDIReg_IN inObj)
        {
            InsSeriousIllnessApplicationFormEDIReg_OUT result = new InsSeriousIllnessApplicationFormEDIReg_OUT();
            result.COUNT = Convert.ToInt32(this.DacAgent.ExecuteNonQuery("HIS.PA.AC.PI.PI.UpdateSeriousIllnessApplicationFormEDIRegGCDN", inObj));
            return result;
        }


        
        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            return this.DacAgent.Fill
                ("HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1", inObj, typeof(HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>)) as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_0(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            return this.DacAgent.Fill
                ("HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_0", inObj, typeof(HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>)) as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_1(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            return this.DacAgent.Fill
                ("HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_1", inObj, typeof(HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>)) as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_2(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            return this.DacAgent.Fill
                ("HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_2", inObj, typeof(HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>)) as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_3(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            return this.DacAgent.Fill
                ("HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg1_3", inObj, typeof(HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>)) as HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT>;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public int UpdSeriousIllnessApplicationFormEDIReg1(UpdSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            DataItem item = new DataItem();
            item.add("IN_FROMDATE",  inObj.IN_FROMDATE);
            item.add("IN_TODATE", inObj.IN_TODATE);
            item.add("IN_STF_NO", inObj.HIS_STF_NO);
            item.add("IN_SRIL_CDOC", inObj.IN_SRIL_CDOC);
            item.add("IN_PRGM_NM", inObj.HIS_PRGM_NM);
            item.add("IN_IP_ADDR", inObj.HIS_IP_ADDR);
            item.add("IN_PT_NO", inObj.IN_PT_NO);
            item.add("IO_ERROR_YN", ParameterDirection.InputOutput);
            item.add("IO_MSG", ParameterDirection.InputOutput);
            string query = QueryProvider.GetQuery("HIS.PA.AC.PI.PI.UpdSeriousIllnessApplicationFormEDIReg1");

            int result = (int)(this.DacAgent.ExecuteNonQuery(CommandType.StoredProcedure, query, item));
            //UpdSeriousIllnessApplicationFormEDIReg1_OUT result = new UpdSeriousIllnessApplicationFormEDIReg1_OUT();
            //result.COUNT = Convert.ToInt32(this.DacAgent.ExecuteNonQuery("HIS.PA.AC.PI.PI.UpdSeriousIllnessApplicationFormEDIReg1", inObj));
            return result;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        public SelSeriousIllnessApplicationFormEDIReg3_OUT SelSeriousIllnessApplicationFormEDIRegGCDCheck(InsSeriousIllnessApplicationFormEDIReg_IN inObj)
        {
            return this.DacAgent.Fill
                ("HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIRegGCDCheck", inObj, typeof(SelSeriousIllnessApplicationFormEDIReg3_OUT)) as SelSeriousIllnessApplicationFormEDIReg3_OUT;
        }

    }
}
