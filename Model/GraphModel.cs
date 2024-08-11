using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProtoType.Model
{
    public class GraphModel
    {
        public string equip { get; set; }
        public decimal dura { get; set; }

        public string sdate { get; set; }
        public string stime { get; set; }
        public string edate { get; set; }
        public string etime { get; set; }
        public string mcode { get; set; }
        public string dcode { get; set; }
        public string ccode { get; set; }
        public string updateby { get; set; }
        public string updatetime { get; set; }
        public string equip_code { get; set; }
        public string fcode { get; set; }
        public string fdesc { get; set; }
        public int rid { get; set; }
        public List<DrilldownItem> drilldown { get; set; }
    }

    public class DrilldownItem
    {
        public string name { get; set; }
        public decimal y { get; set; }
    }
}