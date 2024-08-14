using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class IndexInfo : BaseEntity
    {
        public string OWNER { get; set; }

        public string TABLE_NAME { get; set; }

        public string INDEX_NAME { get; set; }
        public string COL_NAME { get; set; }
        public string COMMENTS { get; set; }
    }
}
