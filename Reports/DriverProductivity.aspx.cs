using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Reports;
using Telerik.Reporting;

public partial class Reports_DriverProductivity : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         //Telerik.Reporting.Report report = new Telerik.Reporting.Report();
         //report.ReportParameters.Add("FirstName", ReportParameterType.String, "John");
         //report.ReportParameters.Add("LastName", ReportParameterType.String, "Smith");
         //Telerik.Reporting.SqlDataSource sqlDataSource = new Telerik.Reporting.SqlDataSource();
         //sqlDataSource.ConnectionString = "MyAdventureWorksDB";
         //sqlDataSource.SelectCommand = "SELECT * FROM Person.Contact WHERE FirstName = @FirstName AND LastName = @LastName";
         //sqlDataSource.Parameters.Add("@FirstName", System.Data.DbType.String, "=Parameters.FirstName");
         //sqlDataSource.Parameters.Add("@LastName", System.Data.DbType.String, "=Parameters.LastName");
         //report.DataSource = sqlDataSource;

        ReportViewer1.ReportSource = new DriverProductivity();
    }
}