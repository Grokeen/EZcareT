using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class BasicSetting : BaseEntity
    {
        public string CODE { get; set; }
        public string PROPERTY { get; set; }

        public string VALUE { get; set; }
        public string REMARK { get; set; }

    }
}
