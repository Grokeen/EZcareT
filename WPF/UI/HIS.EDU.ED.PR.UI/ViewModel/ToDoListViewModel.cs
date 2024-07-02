using HIS.EDU.ED.PR.UI.Model;
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
        #region [Constructor]

        public ToDoListViewModel()
        {
            this.Init();
        }
        #endregion //Constructor

        #region [Member Variables]
        private int _CheckCount;
        public int CheckCount
        {
            get { return _CheckCount; }
            set { if (this._CheckCount != value) this._CheckCount = value; this.OnPropertyChanged("CheckCount"); }
        }

        private int _TotalCount;
        public int TotalCount
        {
            get { return _TotalCount; }
            set { if (this._TotalCount != value) this._TotalCount = value; this.OnPropertyChanged("TotalCount"); }
        }

        #endregion //Member Variables

        #region [ Properties ]
        private string _InputContent = "";
        public string InputContent
        {
            get { return _InputContent; }
            set { if (this._InputContent != value) this._InputContent = value; this.OnPropertyChanged("InputContent"); }
        }

        // ToDoList 만들기
        private HSFDTOCollectionBaseObject<SelectToDoList_IN> _ToDoList;
        public HSFDTOCollectionBaseObject<SelectToDoList_IN> ToDoList
        {
            get { return _ToDoList; }
            set { if (this._ToDoList != value) this._ToDoList = value; this.OnPropertyChanged("ToDoList"); }
        }

        #endregion //Properties

        #region [Commands]

        private ICommand _AddCommand;
        public ICommand AddCommand
        {
            get
            {
                if (_AddCommand == null)
                    _AddCommand = new RelayCommand(p => this.AddList(p));
                return _AddCommand;
            }
        }

        private void AddList(object p)
        {
            if (InputContent != "")
            {
                SelectToDoList_IN item = new SelectToDoList_IN() { Status = false, ToDoContent = InputContent };
                ToDoList.Add(item);

                TotalCount = ToDoList.Count();
                CheckToDoList();

                InputContent = "";
            }
            else
            {
                MessageBox.Show("내용을 입력해 주세요.");
            }
        }

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
    }
}
