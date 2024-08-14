using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class ALL_SOURCE : BaseEntity
    {
        public string OWNER { get; set; }
        public string NAME { get; set; }
        public string TYPE { get; set; }
        public int LINE { get; set; }
        public string TEXT { get; set; }

    }
}
