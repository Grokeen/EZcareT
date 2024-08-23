using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DH.Entity
{
    public class FXQUERYSTORE : BaseEntity
    {
        public string QUERY_ID { get; set; }

        public string QUERYID { get; set; }

        public int CATEGORYID { get; set; }
        public string QUERYTEXT { get; set; }
        public string REMARKS { get; set; }
        public string CREATEUSERID { get; set; }
        public DateTime CREATEDATE { get; set; }

    }
}
