using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class ParamInfo : BaseEntity
    {
        public string PKG_NAME { get; set; }
        public string PROC_NAME { get; set; }

        public string ARGUMENT_NAME { get; set; }

        public string DATA_TYPE { get; set; }

        public string IN_OUT { get; set; }

    }
}
