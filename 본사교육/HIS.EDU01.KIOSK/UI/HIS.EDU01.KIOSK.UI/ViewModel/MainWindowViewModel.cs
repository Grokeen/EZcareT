using HIS.EDU01.KIOSK.DTO;
using HIS.UI.Base;
using HIS.UI.Core.Commands;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Windows.Media;

namespace HIS.EDU01.KIOSK.UI
{
    public class MainWindowViewModel : ViewModelBase
    {
        // 생성자
        public MainWindowViewModel()
        {
            // 객체 생성
            MenuList = new ObservableCollection<SelectMenuInfo_INOUT>();

            // 데이터 담기
            MenuList.Add(new SelectMenuInfo_INOUT { NAME = "아메리카노", PRICE = 2000, COLOR = new SolidColorBrush(Colors.WhiteSmoke) });

            MenuList.Add(new SelectMenuInfo_INOUT { NAME = "카페라떼", PRICE = 2500, COLOR = new SolidColorBrush(Colors.Linen) });

            MenuList.Add(new SelectMenuInfo_INOUT { NAME = "콜드블루", PRICE = 3000, COLOR = new SolidColorBrush(Colors.YellowGreen) });

            MenuList.Add(new SelectMenuInfo_INOUT { NAME = "에스프레소", PRICE = 2500, COLOR = new SolidColorBrush(Colors.Violet) });
            MenuList.Add(new SelectMenuInfo_INOUT { NAME = "말차", PRICE = 4000, COLOR = new SolidColorBrush(Colors.WhiteSmoke) });
            MenuList.Add(new SelectMenuInfo_INOUT { NAME = "디카페인", PRICE = 3000, COLOR = new SolidColorBrush(Colors.IndianRed) });
            MenuList.Add(new SelectMenuInfo_INOUT { NAME = "수박 쥬스", PRICE = 3500, COLOR = new SolidColorBrush(Colors.Honeydew) });

            // 선택 메뉴 리스트
            SelectedMenuList = new ObservableCollection<SelectMenuInfo_INOUT>();
        }

        // 메뉴 리스트
        private ObservableCollection<SelectMenuInfo_INOUT> _MenuList;
        public ObservableCollection<SelectMenuInfo_INOUT> MenuList { get { return _MenuList; } set { _MenuList = value; OnPropertyChanged("MenuList"); } }

        // 선택 메뉴 리스트
        private ObservableCollection<SelectMenuInfo_INOUT> _SelectedMenuList;
        public ObservableCollection<SelectMenuInfo_INOUT> SelectedMenuList { get { return _SelectedMenuList; } set { _SelectedMenuList = value; OnPropertyChanged("SelectedMenuList"); } }
        
        // 계산 부분에 사용되는 총 가격
        private int _TOTAL;
        public int TOTAL { get { return _TOTAL; } set { _TOTAL = value; OnPropertyChanged("TOTAL"); } }

        private ICommand _MinusCommand;
        public ICommand MinusCommand
        {
            get
            {
                if (_MinusCommand == null)
                    _MinusCommand = new RelayCommand(p => this.Minus(p));
                return _MinusCommand;
            }
        }

        private ICommand _PlusCommand;
        public ICommand PlusCommand
        {
            get
            {
                if (_PlusCommand == null)
                    _PlusCommand = new RelayCommand(p => this.Plus(p));
                return _PlusCommand;
            }
        }

        private ICommand _DelCommand;
        public ICommand DelCommand
        {
            get
            {
                if (_DelCommand == null)
                    _DelCommand = new RelayCommand(p => this.Del(p));
                return _DelCommand;
            }
        }
        private ICommand _AddCommand;
        public ICommand AddCommand
        {
            get
            {
                if (_AddCommand == null)
                    _AddCommand = new RelayCommand(p => this.Add(p));
                return _AddCommand;
            }
        }

        private void Add(object p)
        {
            if(p is SelectMenuInfo_INOUT)
            {
                SelectMenuInfo_INOUT item = p as SelectMenuInfo_INOUT;
                SelectedMenuList.Add(new SelectMenuInfo_INOUT { NAME = item.NAME, EA = 1, PRICE = item.PRICE, EA_PRICE = item.PRICE });
                Calc();
            }
        }

        private void Del(object p)
        {
            SelectedMenuList.Remove(p as SelectMenuInfo_INOUT);
            Calc();
        }

        private void Plus(object p)
        {
            SelectMenuInfo_INOUT item = p as SelectMenuInfo_INOUT;
            item.EA++;
            item.EA_PRICE = item.EA * item.PRICE;
            Calc();
        }

        private void Minus(object p)
        {
            SelectMenuInfo_INOUT item = p as SelectMenuInfo_INOUT;
            item.EA--;
            item.EA_PRICE = item.EA * item.PRICE;
            Calc();
        }

        private void Calc()
        {
            TOTAL = SelectedMenuList.Sum(p => p.EA * p.PRICE);
        }
    }
}
