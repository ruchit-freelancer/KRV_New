using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using System.Globalization;
using System.Threading;
using System.Data.SqlTypes;

/// <summary>
/// Summary description for SQLHelper
/// </summary>
public class SQLHelper
{
	public SQLHelper()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static string GetConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["dbConnString"].ToString();
        }
    }

    /// <summary>
    /// Returns the standard application connection.
    /// </summary>
    /// <returns>Connection</returns>
    public static SqlConnection GetConnection()
    {
#if NOTWEB
                return new System.Data.SqlClient.SqlConnection(ConfigurationSettings.AppSettings["DefaultDatabase"]);;    
#else
        ConnectionStringSettings settings =
                ConfigurationManager.ConnectionStrings["dbConnString"];
        return new System.Data.SqlClient.SqlConnection(settings.ConnectionString);
#endif
    }

    /// <summary>
    /// Executes the SQL string against the given connection.
    /// </summary>
    /// <param name="sql">SQL Command</param>
    /// <param name="connection">Connection</param>
    public static void ExecuteSqlCommand(string sql, SqlConnection connection)
    {
        SqlCommand cmd = new SqlCommand(sql, connection);
        cmd.CommandType = CommandType.Text;
        ExecuteSqlCommand(cmd);
    }

    /// <summary>
    /// Opens the database connection if it is not open already.
    /// Waits for any processing on the connection to complete
    /// before doing this.
    /// </summary>
    /// <param name="connection">The connection to ensure is open</param>
    /// <returns>True if the connection was previously closed.</returns>
    public static bool OpenConnection(SqlConnection connection)
    {
        bool connectionopened = false;

        // Wait for the current connection to stop processing.
        while (connection.State == ConnectionState.Connecting ||
            connection.State == ConnectionState.Executing ||
            connection.State == ConnectionState.Fetching)
        {
            Thread.Sleep(0);
        }

        // Open the connection if it is not currently.
        if (connection.State == ConnectionState.Closed)
        {
            connection.Open();
            connectionopened = true;
            //HttpContext.Current.Response.Write(connectionopened);
        }

        return connectionopened;
    }

    /// <summary>
    /// Executes the SQL command checking the connection status beforehand.
    /// If the connection needs to be opened the method will close it before
    /// returning.
    /// </summary>
    /// <param name="cmd">A fully setup SQLCommand</param>
    public static void ExecuteSqlCommand(SqlCommand cmd)
    {
        bool connectionopened = OpenConnection(cmd.Connection);
        //HttpContext.Current.Response.Write("<br>Open Connection::" + connectionopened);
        // Execute the command allowing other threads
        // to execute during the time it takes a response
        // to be returned.
        try
        {
            //HttpContext.Current.Response.Write("Start OF try"); 

            IAsyncResult result = cmd.BeginExecuteNonQuery();

            //HttpContext.Current.Response.Write("before while");
            while (!result.IsCompleted)
            {
                Thread.Sleep(0);
            }
            //HttpContext.Current.Response.Write("after while");
            cmd.EndExecuteNonQuery(result);

            //HttpContext.Current.Response.Write("<br>End Exec non query::"+cmd.EndExecuteNonQuery(result));
        }
        catch (Exception ex)
        {
            //HttpContext.Current.Response.Write("alpa");
            throw ex;
        }
        finally
        {
            // Close the connection if it was not already open.
            if (connectionopened == true)
            {
                cmd.Connection.Close();
            }
        }
    }

    public static System.Data.SqlClient.SqlCommand GetCommandFromSQL(string sql)
    {
        System.Data.SqlClient.SqlCommand cmd =
            new System.Data.SqlClient.SqlCommand(sql, GetConnection());
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        return cmd;
    }

    public static System.Data.SqlClient.SqlCommand GetCommandFromSQL(string sql, SqlConnection conn)
    {
        System.Data.SqlClient.SqlCommand cmd =
            new System.Data.SqlClient.SqlCommand(sql, conn);
        cmd.CommandType = System.Data.CommandType.Text;
        return cmd;
    }

    /// <summary>
    /// Passed an SQL command with all it's parameters set. Adds
    /// a parameter to capture the return value as an Integer. Executes
    /// the command and returns the Integer return value.
    /// </summary>
    /// <param name="cmd">SQLCommand already setup on the database.</param>
    /// <returns>Integer return value.</returns>
    public static int ExecuteSqlCommandReturnInt(string SQL)
    {
        object obj = SQLHelper.ExecuteScalar(SQL);
        return obj is DBNull || obj == null ? 0 : (int)obj;
    }

    /// <summary>
    /// Passed an SQL command with all it's parameters set. Adds
    /// a parameter to capture the return value as a String. Executes
    /// the command and returns the String return value.
    /// </summary>
    /// <param name="cmd">SQLCommand already setup on the database.</param>
    /// <returns>String return value.</returns>
    public static string ExecuteSqlCommandReturnString(string SQL)
    {
        object obj = SQLHelper.ExecuteScalar(SQL);
        return obj is DBNull || obj == null ? null : obj.ToString();
    }

    /// <summary>
    /// Execute Scalar the SQL command checking the connection status beforehand.
    /// If the connection needs to be opened the method will close it before
    /// returning.
    /// </summary>
    /// <param name="cmd">A fully setup SQLCommand</param>
    public static object ExecuteScalar(string SQL)
    {
        SqlCommand cmd = new SqlCommand(SQL, SQLHelper.GetConnection());
        object res = null;
        bool connectionopened = OpenConnection(cmd.Connection);

        // Execute the command Scalar allowing other threads
        // to execute during the time it takes a response
        // to be returned.
        try
        {
            res = cmd.ExecuteScalar();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            // Close the connection if it was not already open.
            if (connectionopened == true)
            {
                cmd.Connection.Close();
            }
        }
        return res;
    }

    /// <summary>
    /// Creates a standard StoredProcedure command.
    /// </summary>
    /// <param name="name">The name of the command in the default database.</param>
    /// <returns>An SQLCommand Stored Procedure object with it's connection set to the default
    /// database and it's name set to the value passed into the method.</returns>
    public static SqlCommand MakeStoredProcedureCommand(string name)
    {
        return MakeStoredProcedureCommand(name, SQLHelper.GetConnection());
    }

    public static SqlCommand MakeStoredProcedureCommand(string name, SqlConnection connection)
    {
        SqlCommand cmd = new SqlCommand(name, SQLHelper.GetConnection());
        cmd.CommandType = CommandType.Text;
        return cmd;
    }

    public static SqlParameter MakeOutputParameter(string name, SqlDbType type)
    {
        SqlParameter ret = new SqlParameter(name, type);
        ret.Direction = ParameterDirection.Output;
        ret.IsNullable = true;
        return ret;
    }

    //public static SqlParameter MakeParameter(SqlCommand sqlCommand,string name, SqlDbType type,object value)
    //{
    //    SqlParameter sqlParameter = new SqlParameter(name, type);
    //    sqlParameter.Value = value;
    //    sqlCommand.Parameters.Add(sqlParameter);
    //    return sqlParameter;
    //}

    //public static SqlParameter MakeParameter(SqlCommand sqlCommand, string name, SqlDbType type, object value,int size)
    //{
    //    SqlParameter sqlParameter = new SqlParameter(name, type,size);
    //    sqlParameter.Value = value;
    //    sqlCommand.Parameters.Add(sqlParameter);
    //    return sqlParameter;
    //}

    public static long DataTableReaderBytes(DataTable dt, int field, Stream str)
    {
        const int BUFFER_SIZE = 4096;

        int pos = 0;
        byte[] buf = new byte[BUFFER_SIZE];
        long bytes = 0;
        long read = 0;

        DataTableReader dr = dt.CreateDataReader();
        if (dr != null)
        {
            if (dr.Read())
            {
                read = dr.GetBytes(field, pos, buf, 0, BUFFER_SIZE);
                while (read > 0)
                {
                    bytes += read;
                    str.Write(buf, 0, Convert.ToInt32(read));
                    pos += BUFFER_SIZE;
                    read = dr.GetBytes(field, pos, buf, 0, BUFFER_SIZE);
                }
            }
            dr.Close();
        }

        return bytes;
    }

    public static string FormatDateTime(DateTime dt)
    {
        return String.Format("{0:s}", dt);
    }

    public static string FormatDateTime(SqlDateTime sdt)
    {
        return String.Format("{0:s}", sdt);
    }

    /// <summary>
    /// Formats a date for inclusion in an SQL string. The date is
    /// converted to it's UTC value and then returned as a SqlDateTime.
    /// </summary>
    /// <param name="dt">DateTime value</param>
    /// <returns>SqlDateTime</returns>
    public static SqlDateTime GetSQLUniversalTime(DateTime dt)
    {
        return GetSQLDateTime(dt.ToUniversalTime());
    }

    /// <summary>
    /// Takes a string date and time and turns it into a DateTime
    /// variable for inclusion in an SQL parameter query that
    /// takes datetime objects.
    /// If the date is invalid we return the SQL Server's minimum date.
    /// By trapping the exception in this method we avoid excessive
    /// error handling in other objects.
    /// </summary>
    /// <param name="dateTime">Date time in any format</param>
    /// <returns>DateTime version.</returns>
    public static SqlDateTime GetSQLDateTime(DateTime dt)
    {
        SqlDateTime sdt;
        try
        {
            sdt = new SqlDateTime(dt);
        }
        catch
        {
            // The date is out of range so return the lowest value.
            sdt = new SqlDateTime(0, 0);
        }
        return sdt;
    }

    public static string FormatSQLString(string src)
    {
        if (src != null)
        {
            return src.Replace("'", "''");
        }
        return null;
    }

    public static int ExecuteNonQuery(string sql, SqlParameter[] sqlParams,string outputParameter,SqlDbType type)
    {
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        cmd.CommandType = CommandType.StoredProcedure;
        for (int i = 0; i < sqlParams.Length; i++)
        {
            cmd.Parameters.Add(sqlParams[i]);
        }

        SqlParameter retValue = MakeOutputParameter(outputParameter, type);
        retValue.Direction = ParameterDirection.ReturnValue;
        cmd.Parameters.Add(retValue);

        int retVal = 0;
        try
        {
            cmd.ExecuteNonQuery();
            retVal=Convert.ToInt32(retValue.Value);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        cmd.Dispose();
        return retVal;
    }

    public static string ExecuteNonQuery(string sql, SqlParameter[] sqlParams, string outputParameter, SqlDbType type,int size)
    {
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        cmd.CommandType = CommandType.StoredProcedure;
        for (int i = 0; i < sqlParams.Length; i++)
        {
            cmd.Parameters.Add(sqlParams[i]);
        }

        SqlParameter retValue = MakeOutputParameter(outputParameter, type);
        retValue.Size = size;
        retValue.Direction = ParameterDirection.ReturnValue;
        cmd.Parameters.Add(retValue);

        string retVal = "";
        try
        {
            cmd.ExecuteNonQuery();
            retVal = retValue.Value.ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        cmd.Dispose();
        return retVal;
    }

    public static int ExecuteNonQuery(string sql, SqlParameter[] sqlParams)
    {
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        cmd.CommandType = CommandType.StoredProcedure;
        for (int i = 0; i < sqlParams.Length; i++)
        {
            cmd.Parameters.Add(sqlParams[i]);
        }
        int retVal = 0;
        try
        {
            retVal = cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        cmd.Dispose();
        return retVal;
    }
    public static int ExecuteNonQuery(string sql, CommandType cmdType, SqlParameter[] sqlParams)
    {
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        cmd.CommandType = cmdType;
        for (int i = 0; i < sqlParams.Length; i++)
        {
            cmd.Parameters.Add(sqlParams[i]);
        }
        int retVal = 0;
        try
        {
            retVal = cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        cmd.Dispose();
        return retVal;
    }
    public static int ExecuteNonQuery(string sql)
    {
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        int retVal = 0;
        try
        {
            retVal = cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        cmd.Dispose();
        return retVal;
    }
    public static DataSet ExecuteDataset(string sql)
    {
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        try
        {
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        return ds;
    }
    public static DataSet ExecuteDataset(string sql, SqlParameter[] sqlParams)
    {
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        cmd.CommandType = CommandType.StoredProcedure;
        for (int i = 0; i < sqlParams.Length; i++)
        {
            cmd.Parameters.Add(sqlParams[i]);
        }
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        try
        {
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        return ds;
    }
    public static string ExecuteScalar(string sql, SqlParameter[] sqlParams)
    {
        SqlCommand cmd = new SqlCommand(sql, SQLHelper.GetConnection());
        bool connectionopened = OpenConnection(cmd.Connection);
        cmd.CommandType = CommandType.StoredProcedure;
        for (int i = 0; i < sqlParams.Length; i++)
        {
            cmd.Parameters.Add(sqlParams[i]);
        }
        string retString = "";
        try
        {
            retString = cmd.ExecuteScalar().ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd.Connection.State == ConnectionState.Open)
                cmd.Connection.Close();
        }
        cmd.Dispose();
        return retString;
    }
}
