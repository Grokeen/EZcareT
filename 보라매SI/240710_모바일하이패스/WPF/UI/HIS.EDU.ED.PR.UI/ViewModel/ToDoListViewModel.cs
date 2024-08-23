using HIS.EDU.ED.PR.UI.Model;
// ❗️ 모델 디텍토리를 import 한 건가?

using HIS.UI.Base;
using HIS.UI.Core.Commands;



using HSF.TechSvc2010.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;







namespace HIS.EDU.ED.PR.UI.ViewModel
{
    public class ToDoListViewModel : ViewModelBase
    {


// -----------------------------------------------------------------------

        // 📌 생성자?
        #region [Constructor]
        // 📌 [Constructor] : 'Constructor'는 코드 블록의 이름으로, 이 블록이 생성자와 관련된 코드임을 나타냄
        public ToDoListViewModel()
        {
            this.Init();
        }
        #endregion //Constructor




// -----------------------------------------------------------------------
// 디자인패턴, 생성패턴, 빌더(geter,seter)
// 캡슐화
        

        #region [Member Variables]
        private int _CheckCount;
        // 📌 'private int _CheckCount' : 실제 데이터를 저장하기 위한 "백킹 필드(backing field)"
        public int CheckCount
        {
            get { return _CheckCount; }
            set { if (this._CheckCount != value) this._CheckCount = value; this.OnPropertyChanged("CheckCount"); }
            // 📌 seter에 기존값과 다른 새로운 값 -> 백킹 필드에 저장
            // 📌 'this.OnPropertyChanged' : INotifyPropertyChanged 인터페이스의 구현에 필요한 메서드.(프로퍼티의 값이 변경 -> UI나 다른 바인딩된 요소에 알리는 역할)
        }

        private int _TotalCount;
        public int TotalCount
        {
            get { return _TotalCount; }
            set { if (this._TotalCount != value) this._TotalCount = value; this.OnPropertyChanged("TotalCount"); }
        }

        #endregion //Member Variables



// -----------------------------------------------------------------------



        #region [ Properties ]
        private string _InputContent = "";
        public string InputContent
        {
            get { return _InputContent; }
            set { if (this._InputContent != value) this._InputContent = value; this.OnPropertyChanged("InputContent"); }
        }



        // ToDoList 만들기
        private HSFDTOCollectionBaseObject<SelectToDoList_IN> _ToDoList;
        // 📌 'HSFDTOCollectionBaseObject<SelectToDoList_IN>' : 이건,,,, 'HSFDTOCollectionBaseObject' 클래스로 제네릭 타입('SelectToDoList_IN')을 사용하는 컬렉션 클래스를 정의

        public HSFDTOCollectionBaseObject<SelectToDoList_IN> ToDoList
        {
            get { return _ToDoList; }
            set { if (this._ToDoList != value) this._ToDoList = value; this.OnPropertyChanged("ToDoList"); }
        }

        #endregion //Properties



        // 📌 제네릭(Generic) : 클래스, 메서드, 인터페이스 등을 정의할 때 사용하는 중요한 기능입니다. 제네릭을 사용하면 데이터 타입에 독립적인 코드를 작성할 수 있습니다. 제네릭 클래스는 특정 타입에 대해 작업을 수행할 수 있는 클래스를 정의하며, 이를 통해 코드의 재사용성과 타입 안정성을 높일 수 있습니다.

// -----------------------------------------------------------------------
// 디자인패턴. 행위, 커맨드(재사용성)
// 캡슐화, 추상화


        #region [Commands]
        private ICommand _AddCommand;
        // 📌 'ICommand' : 인터페이스 'ICommand'는 System.Windows.Input 네임스페이스에 정의되어 있음 -> WPF나 XAML 기반 프레임워크에서 사용자 인터페이스 요소와 상호작용하기 위해 사용되는 인터페이스

        // ❗️ 제공된 서적에는 ICommand에게 상속 받았다고 표현되어 있음
        public ICommand AddCommand
        {
            get
            {
                if (_AddCommand == null)
                    _AddCommand = new RelayCommand(p => this.AddList(p));
                    // 📌 'RelayCommand' : 일반적으로 WPF(MVVM) 패턴에서 사용되는 커맨드로 뷰 모델(ViewModel)에서 버튼 클릭 등의 이벤트를 처리하기 위해 사용
                return _AddCommand;
            }
        }



        private void AddList(object p)
        {
            if (InputContent != "")
            {
                SelectToDoList_IN item = new SelectToDoList_IN() { Status = false, ToDoContent = InputContent };
                ToDoList.Add(item);
                // ❗️ 위 region[Properties]에서 선언한 제네릭 사용

                TotalCount = ToDoList.Count();
                CheckToDoList();
                // ❗️아래 region[Methods]에서 선언된 'CheckToDoList' 클래스 실행

                InputContent = "";
            }
            else
            {
                MessageBox.Show("내용을 입력해 주세요.");
            }
        }

     
        // 📌 재사용성을 높이기 위한 커맨드 패턴
        private ICommand _CheckedCommand;
        public ICommand CheckedCommand
        {
            get
            {
                if (_CheckedCommand == null)
                    _CheckedCommand = new RelayCommand(p => this.CheckedList(p));
                return _CheckedCommand;
            }
        }
         
        
        private ICommand _UnCheckedCommand;
        public ICommand UnCheckedCommand
        {
            get
            {
                if (_UnCheckedCommand == null)
                    _UnCheckedCommand = new RelayCommand(p => this.UnCheckedList(p));
                return _UnCheckedCommand;
            }
        }

        
        private ICommand _DelCommand;
        public ICommand DelCommand
        {
            get
            {
                if (_DelCommand == null)
                    _DelCommand = new RelayCommand(p => this.DeleteList(p));
                return _DelCommand;
            }
        }

           
        private ICommand _ClearCommand;
        public ICommand ClearCommand
        {
            get
            {
                if (_ClearCommand == null)
                    _ClearCommand = new RelayCommand(p => this.ClearList(p));
                return _ClearCommand;
            }
        }


        private ICommand _CheckedAllCommand;
        public ICommand CheckedAllCommand
        {
            get
            {
                if (_CheckedAllCommand == null)
                    _CheckedAllCommand = new RelayCommand(p => this.CheckedAll(p));
                return _CheckedAllCommand;
            }
        }










        private void CheckedAll(object p)
        {
            foreach (SelectToDoList_IN item in ToDoList)
            {
                item.Status = true;
                CheckedList(item);
            }

            // 📌 
        }
        private void ClearList(object p)
        {
            ToDoList = new HSFDTOCollectionBaseObject<SelectToDoList_IN>();
            CheckToDoList();
        }
        private void CheckedList(object p)
        {
            SelectToDoList_IN data = p as SelectToDoList_IN;
            data.TextStauts = "Strikethrough";

            //foreach(SelectToDoList_IN item in ToDoList)
            //{
            //    if(item.ToDoContent == data.ToDoContent)
            //    {
            //        item.TextStauts = "Strikethrough";
            //    }
            //}
            CheckToDoList();
        }
        private void UnCheckedList(object p)
        {
            SelectToDoList_IN data = p as SelectToDoList_IN;
            data.TextStauts = "none";
            CheckToDoList();
        }
        private void DeleteList(object p)
        {
            SelectToDoList_IN data = p as SelectToDoList_IN;
            if (ToDoList != null)
            {
                ToDoList.Remove(data);
            }
            CheckToDoList();
        }

        #endregion //Commands





// -----------------------------------------------------------------------



        #region [Methods]
        /// <summary>
        /// name         : ViewModel 초기화
        /// desc         : ViewModel을 초기화함
        /// author       : AA02 
        /// create date  : 2023-05-01 오후 11:51:32
        /// update date  : 최종 수정 일자, 수정자, 수정개요 
        /// </summary>
        private void Init()
        {
            ToDoList = new HSFDTOCollectionBaseObject<SelectToDoList_IN>();
            CheckToDoList();
        }

        private void CheckToDoList()
        {
            // 1. 전체 리스트 갯수 체크
            TotalCount = ToDoList.Count();

            // 2. 완료 목록 체크
            if (ToDoList != null)
            {
                CheckCount = 0;
                foreach (var item in ToDoList)
                {
                    if (item.Status == true)
                    {
                        CheckCount++;
                    }
                }
            }
        }


        #endregion //Methods




// -----------------------------------------------------------------------
    }
}
