using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RadClientExportManager1.PdfSettings.Fonts.Add("Arial Unicode MS", "Fonts/ArialUnicodeMS.ttf");
        if (!IsPostBack)
        {
            RadPivotGrid1.CollapseAllRowGroups(1, false);
        }
    }
    protected void RadPivotGrid1_CellDataBound(object sender, Telerik.Web.UI.PivotGridCellDataBoundEventArgs e)
    {
        if (e.Cell is PivotGridDataCell)
        {
            PivotGridDataCell dataCell = e.Cell as PivotGridDataCell;
            dataCell.HorizontalAlign = HorizontalAlign.Right;
        }
    }    
}