
using HIS.PA.AC.PE.PS.DTO;
using HSF.COM.Core;
using HSF.TechSvc2010.Common;
using HSF.TechSvc2010.Server.ComBase;
using HSF.TechSvc2010.Server.DAC;
using System;
using System.Data;

namespace HIS.PA.AC.PE.PS.DAC
{
    /// <summary>
    /// name         : #��DAC Ŭ������
    /// desc         : #DACŬ���� ����
    /// author       : leegidong 
    /// create date  : 2016-06-21 ���� 1:14:17
    /// update date  : #���� ���� ����, ������, �������� 
    /// </summary>
    [HSFTransaction(HSFTransactionOption.Supported)]
    public class HipassMobileApprovalMngDL : DacBase
    {
        /// <summary>
        /// name         : #DB Connection ����
        /// desc         : #������ DB Connection�� �����մϴ�.
        /// author       : leegidong 
        /// create date  : 2016-06-21 ���� 1:14:17
        /// update date  : #���� ���� ����, ������, �������� 
        /// </summary>
        protected override void SetDataSource()
        {
            base.DataSource = DBEnum.BILOracle; // #���� ������ DBEnum���� ����
        }

        /// <summary>
        /// name         : #�޼ҵ� ����
        /// desc         : #�޼ҵ� ����
        /// author       : leegidong 
        /// create date  : 2016-06-21 ���� 11:09:06
        /// update date  : #���� ���� ����, ������, �������� 
        /// </summary>      
        public HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT> SelectHipassMobileApprovalMng_OUT(HipassMobileApprovalMng_IN temp)
        {


            return this.DacAgent.Fill("HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG", temp, typeof(HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>)) as HSFDTOCollectionBaseObject<HipassMobileApprovalMng_OUT>;
            // as������ : Ÿ���� ��ȯ �� ��, as �ڿ� �������� �ްڴ�.
        }




    }
}
