using System;
using System.Runtime.Serialization;
using HIS.Core.Common;

/// <summary>
/// name        : #논리DTO 클래스명
/// desc        : #DTO클래스 개요 
/// author      : EZCARE 
/// create date : 2024-07-10 오후 5:21:35
/// update date : #최종 수정 일자, 수정자, 수정개요 
/// </summary>
[Serializable]
[DataContract]
public class HipassMobileApprovalMng_INSERT : HISDTOBase
{
    private String in_cncl_dt;           //취소일자(insert)


    /// <summary>
    /// name : 현재일자(취소날짜)
    /// </summary>
    [DataMember]
    public string IN_CNCL_DT
    {
        get { return in_cncl_dt; }
        set { if (this.in_cncl_dt != value) { this.in_cncl_dt = value; this.OnPropertyChanged("IN_CNCL_DT"); } }
    }




}

