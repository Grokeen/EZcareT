using HIS.Core.Common;
using System;
using System.Runtime.Serialization;
using System.Windows.Media;

namespace HIS.EDU01.KIOSK.DTO
{
    /// <summary>
    /// name        : #논리DTO 클래스명
    /// desc        : #DTO클래스 개요 
    /// author      : user 
    /// create date : 2024-07-03 오후 3:22:39
    /// update date : #최종 수정 일자, 수정자, 수정개요 
    /// </summary>
    [Serializable]
    [DataContract]
    public class SelectMenuInfo_INOUT : HISDTOBase
    {
        // 상품 이름
        private string _NAME;
        public string NAME { get { return _NAME; } set { _NAME = value; OnPropertyChanged("NAME"); } }
        // 상품 가격
        private int _PRICE;
        public int PRICE { get { return _PRICE; } set { _PRICE = value; OnPropertyChanged("PRICE"); } }
        // 상품 갯수
        private int _EA;
        public int EA { get { return _EA; } set { _EA = value; OnPropertyChanged("EA"); } }
        // 상품 갯수 별 가격
        private int _EA_PRICE;
        public int EA_PRICE { get { return _EA_PRICE; } set { _EA_PRICE = value; OnPropertyChanged("EA_PRICE"); } }
        // 상품 색상
        private Brush _COLOR;
        public Brush COLOR { get { return _COLOR; } set { _COLOR = value; OnPropertyChanged("COLOR"); } }
    }
}
