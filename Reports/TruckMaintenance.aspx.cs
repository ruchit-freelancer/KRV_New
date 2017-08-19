using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Reporting;
using System.Configuration;
using System.Data.Common;
using System.Data;
using Reports;

public partial class Reports_TruckMaintenance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.Report = new TruckMaintenance();
    }
}