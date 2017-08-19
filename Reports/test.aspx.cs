using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Reporting;
using Reports;

public partial class Reports_test : System.Web.UI.Page
{
     protected void Page_Load(object sender, EventArgs e)
     {
         RadImageGallery1.LightBox.Modal = true;
     }

     protected void btnClick_Click(object sender, EventArgs e)
     {
          //Report1 rpt = new Report1("Charlotte");
          //ReportViewer1.Report = rpt;
     }
}