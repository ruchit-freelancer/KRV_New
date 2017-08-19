using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Reports;

public partial class Reports_DriverWorksheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.Report = new DriverWorksheet();
    }
}