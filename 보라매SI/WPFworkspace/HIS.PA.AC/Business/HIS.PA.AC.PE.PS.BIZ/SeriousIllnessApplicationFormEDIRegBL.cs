using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using HIS.PA.AC.PE.PS.DAC;
using HIS.PA.AC.PE.PS.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ORM;
using HSF.TechSvc2010.Server.ComBase;

using HIS.Core;
using HIS.Core.BIZ;

namespace HIS.PA.AC.PE.PS.BIZ
{
    /// <summary>
    /// name         : 중증edi코드생성 조회
    /// desc         : 중증edi코드생성 조회함
    /// author       : jeonkwangsik
    /// create date  : 2012-06-25 오후 1:57:56
    /// update date  : 최종 수정일자, 수정자, 수정개요
    /// </summary>

    public class SeriousIllnessApplicationFormEDIRegBL : BizBase//, ISeriousIllnessApplicationFormEDIRegBL
    {

        /// <summary>
        /// name                : 중증edi코드생성 조회
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 조회함
        /// desc                : 중증edi코드생성 조회함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg3_OUT> SelSeriousIllnessApplicationFormEDIReg2(SelSeriousIllnessApplicationFormEDIReg2_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.SelSeriousIllnessApplicationFormEDIReg2(inObj);
            }
        }

        /// <summary>
        /// name                : 중증edi코드생성 수정
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 수정함
        /// desc                : 중증edi코드생성 수정함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public UpdSeriousIllnessApplicationFormEDIReg2_OUT UpdSeriousIllnessApplicationFormEDIReg2(UpdSeriousIllnessApplicationFormEDIReg2_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.UpdSeriousIllnessApplicationFormEDIReg2(inObj);
            }
        }

        /// <summary>
        /// name                : 중증edi코드생성 조회
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 등록함
        /// desc                : 중증edi코드생성 등록함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public InsSeriousIllnessApplicationFormEDIReg_OUT InsSeriousIllnessApplicationFormEDIReg(InsSeriousIllnessApplicationFormEDIReg_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.InsSeriousIllnessApplicationFormEDIReg(inObj);
            }
        }


        /// <summary>
        /// name                : 이미 등록된 확인증 정보가 있으면 타병원 N으로 업데이트
        /// i/f inheritance yn  : Y
        /// logic               : 이미 등록된 확인증 정보가 있으면 타병원 N으로 업데이트
        /// desc                : 이미 등록된 확인증 정보가 있으면 타병원 N으로 업데이트
        /// author              : 송민수
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public InsSeriousIllnessApplicationFormEDIReg_OUT UpdateSeriousIllnessApplicationFormEDIRegGCDN(InsSeriousIllnessApplicationFormEDIReg_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.UpdateSeriousIllnessApplicationFormEDIRegGCDN(inObj);
            }
        }

        
        /// <summary>
        /// name                : 중증edi코드생성 조회(20190226 이전 암)
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 조회함
        /// desc                : 중증edi코드생성 조회함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.SelSeriousIllnessApplicationFormEDIReg1(inObj);
            }
        }

        /// <summary>
        /// name                : 중증edi코드생성 조회(암)
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 조회함
        /// desc                : 중증edi코드생성 조회함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_0(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.SelSeriousIllnessApplicationFormEDIReg1_0(inObj);
            }
        }

        /// <summary>
        /// name                : 중증edi코드생성 조회(산정특례)
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 조회함
        /// desc                : 중증edi코드생성 조회함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_1(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.SelSeriousIllnessApplicationFormEDIReg1_1(inObj);
            }
        }

        /// <summary>
        /// name                : 중증edi코드생성 조회(결핵, 화상)
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 조회함
        /// desc                : 중증edi코드생성 조회함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_2(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.SelSeriousIllnessApplicationFormEDIReg1_2(inObj);
            }
        }

        /// <summary>
        /// name                : 중증edi코드생성 조회(잠복결핵)
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 조회함
        /// desc                : 중증edi코드생성 조회함
        /// author              : paekmyungsu
        /// create date         : 2021-06-29 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public HSFDTOCollectionBaseObject<SelSeriousIllnessApplicationFormEDIReg4_OUT> SelSeriousIllnessApplicationFormEDIReg1_3(SelSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.SelSeriousIllnessApplicationFormEDIReg1_3(inObj);
            }
        }

        /// <summary>
        /// name                : 중증edi코드생성 조회
        /// i/f inheritance yn  : Y
        /// logic               : 중증edi코드생성 수정함
        /// desc                : 중증edi코드생성 수정함
        /// author              : jeonkwangsik
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public int UpdSeriousIllnessApplicationFormEDIReg1(UpdSeriousIllnessApplicationFormEDIReg1_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.UpdSeriousIllnessApplicationFormEDIReg1(inObj);
            }
        }


        /// <summary>
        /// name                : GCD에 같은데이터있는지 조회
        /// i/f inheritance yn  : Y
        /// logic               : GCD에 같은데이터있는지 조회
        /// desc                : GCD에 같은데이터있는지 조회
        /// author              : 송민수
        /// create date         : 2012-06-25 오후 1:57:56
        /// update date         : 최종 수정일자 , 수정자, 수정개요 
        /// </summary>
        /// <param name="inObj"></param>
        /// <returns></returns>
        [HSFTransaction(HSFTransactionOption.Required)]
        public SelSeriousIllnessApplicationFormEDIReg3_OUT SelSeriousIllnessApplicationFormEDIRegGCDCheck(InsSeriousIllnessApplicationFormEDIReg_IN inObj)
        {
            using (SeriousIllnessApplicationFormEDIRegDL seriousIllnessApplicationFormEDIRegDL = new SeriousIllnessApplicationFormEDIRegDL())
            {
                return seriousIllnessApplicationFormEDIRegDL.SelSeriousIllnessApplicationFormEDIRegGCDCheck(inObj);
            }
        }

        

    }
}
