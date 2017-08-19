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

public partial class Reports_UnitMonthly : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.Report = new FuelEfficiencyTruck();

        //Telerik.Reporting.Report report = new Telerik.Reporting.Report();
        //report.ReportParameters.Add("City", ReportParameterType.String, "Nashville");
        //report.ReportParameters.Add("Month", ReportParameterType.Integer, 4);
        //report.ReportParameters.Add("Year", ReportParameterType.Integer, 2012);

        //Telerik.Reporting.SqlDataSource sqlDataSource = new Telerik.Reporting.SqlDataSource();
        //sqlDataSource.ConnectionString = ConfigurationManager.ConnectionStrings["dbConnString"].ToString();
        ////sqlDataSource.SelectCommand = "SELECT * FROM Person.Contact WHERE FirstName = @FirstName AND LastName = @LastName";
        //sqlDataSource.SelectCommandType = Telerik.Reporting.SqlDataSourceCommandType.StoredProcedure;
        //sqlDataSource.SelectCommand = "KRV_Report_UnitMonthly";
        //sqlDataSource.Parameters.Add("@City", System.Data.DbType.String, "Nashville");
        //sqlDataSource.Parameters.Add("@Month", System.Data.DbType.Int32, 4);
        //sqlDataSource.Parameters.Add("@Year", System.Data.DbType.Int32, 2012);
        //report.DataSource = sqlDataSource.Se;
    }
}