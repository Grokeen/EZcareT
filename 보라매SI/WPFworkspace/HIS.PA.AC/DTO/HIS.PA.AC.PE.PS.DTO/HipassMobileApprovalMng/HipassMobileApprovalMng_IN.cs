using System;
using System.Runtime.Serialization;
using HIS.Core.Common;

/// <summary>
/// name        : HipassMobileApprovalMng_IN
/// desc        : HipassMobileApprovalMng_IN 
/// author      : 김용록 
/// create date : 2024-07-10 오후 5:21:35
/// update date : #최종 수정 일자, 수정자, 수정개요 
/// </summary>
[Serializable]
[DataContract]
public class HipassMobileApprovalMng_IN : HISDTOBase
{
    private String in_from_date;         //시작일자
    private String in_to_date;           //종료일자
    private String in_hpcd_cncl_rsn_cd;  //취소사유코드

    /// <summary>
    /// name : 시작일자
    /// </summary>
    [DataMember]
    public string IN_FROM_DATE
    {
        get { return in_from_date; }
        set { if (this.in_from_date != value) { this.in_from_date = value; this.OnPropertyChanged("IN_FROM_DATE"); } }
    }


    /// <summary>
    /// name : 종료일자
    /// </summary>
    [DataMember]
    public string IN_TO_DATE
    {
        get { return in_to_date; }
        set { if (this.in_to_date != value) { this.in_to_date = value; this.OnPropertyChanged("IN_TO_DATE"); } }
    }




    /// <summary>
    /// name : 취소사유코드
    /// </summary>
    [DataMember]
    public string IN_HPCD_CNCL_RSN_CD
    {
        get { return in_hpcd_cncl_rsn_cd; }
        set { if (this.in_hpcd_cncl_rsn_cd != value) { this.in_hpcd_cncl_rsn_cd = value; this.OnPropertyChanged("IN_HPCD_CNCL_RSN_CD"); } }
    }

}

