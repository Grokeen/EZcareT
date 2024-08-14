using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class ColInfo : BaseEntity
    {
        public string TABLE_NAME { get; set; }

        public string OWNER { get; set; }
        public string COL_NAME { get; set; }
        public string NULLABLE { get; set; }
        public string DATATYPE { get; set; }
        public string COMMENTS { get; set; }

        public string DEFAULT { get; set; }
        

    }
}
