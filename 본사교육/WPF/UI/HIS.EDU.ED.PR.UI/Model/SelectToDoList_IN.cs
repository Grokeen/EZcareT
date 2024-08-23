using HIS.Core.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HIS.EDU.ED.PR.UI.Model
{
    public class SelectToDoList_IN : HISDTOBase
    {

        // 📌 백업필드, 얘네가 실제 저장되는 전역변수 -> private이라 직접 참조는 안되고, 아래에서 특정 액션에 값이 저장?
        private bool _Status;
        private string _ToDoContent;
        private string _TextStauts;




        /// <summary>
        /// name : 체크 상태
        /// </summary>
        public bool Status
        {
            get { return _Status; }
            set { if (this._Status != value) this._Status = value; this.OnPropertyChanged("Status"); }
            // 📌 'this.OnPropertyChanged' : INotifyPropertyChanged 인터페이스의 구현에 필요한 메서드.(프로퍼티의 값이 변경 -> UI나 다른 바인딩된 요소에 알리는 역할)
        }



        /// <summary>
        /// name : 해야 할 일 내용
        /// </summary>
        public string ToDoContent
        {
            get { return _ToDoContent; }
            set { if (this._ToDoContent != value) this._ToDoContent = value; this.OnPropertyChanged("ToDoContent"); }
        }



        /// <summary>
        /// name : Text상태
        /// </summary>
        public string TextStauts
        {
            get { return _TextStauts; }
            set { if (this._TextStauts != value) this._TextStauts = value; this.OnPropertyChanged("TextStauts"); }
        }
    }
}
