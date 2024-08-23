using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class DBUser : BaseEntity
    {
        public string USER_NAME { get; set; }

        public string CONNECT_STRING { get; set; }

    }
}