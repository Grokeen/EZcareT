using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class ALL_VIEWS : BaseEntity
    {
        public string OWNER { get; set; }
        public string NAME { get; set; }

        public string COL_INFO { get; set; }
        
        public string TEXT { get; set; }

    }
}
