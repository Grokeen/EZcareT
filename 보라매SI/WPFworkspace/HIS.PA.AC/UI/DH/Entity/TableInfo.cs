using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class TableInfo : BaseEntity
    {
        public string OWNER { get; set; }
        public string TABLE_NAME { get; set; }
        public string TABLE_COMMENTS { get; set; }
        public int CREATED_DAYS { get; set; }
        public int MODIFY_DAYS { get; set; }
        public string KEYWORD { get; set; }

        public string EX_OWNER { get; set; }
    }
}
