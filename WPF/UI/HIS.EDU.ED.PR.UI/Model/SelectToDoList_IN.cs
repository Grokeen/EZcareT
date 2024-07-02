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
