using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace db_projecta.Models
{
    public class CommonFunc
    {
        public class Commonfnx
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Fast"].ConnectionString);

            public void Query(string query)
            {
                try
                {
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // Handle or log the exception
                    throw ex;
                }
                finally
                {
                    con.Close();
                }
            }

            public int InsertAndGetId(string query)
            {
                int insertedId = 0;

                try
                {
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.ExecuteNonQuery();

                    // Retrieve the generated ID
                    cmd.CommandText = "SELECT SCOPE_IDENTITY()";
                    insertedId = Convert.ToInt32(cmd.ExecuteScalar());
                }
                catch (Exception ex)
                {
                    // Handle or log the exception
                    throw ex;
                }
                finally
                {
                    con.Close();
                }

                return insertedId;
            }

            public DataTable Fetch(string query)
            {
                DataTable dt = new DataTable();

                try
                {
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Handle or log the exception
                    throw ex;
                }
                finally
                {
                    con.Close();
                }

                return dt;
            }
        }
    }
}
