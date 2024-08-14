using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class TableAddInfo : BaseEntity
    {
        public string TABLE_NAME { get; set; }

        public string COL_NAME { get; set; }
        public string COL_VALUE { get; set; }
    }
}
