using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Laptop
{
    public class DBConnect
    {
        // 1. Lấy chuỗi kết nối từ Web.config (Đã sửa tên key thành LaptopTrungHieuDB)
        private static string strKetNoi = ConfigurationManager.ConnectionStrings["LaptopTrungHieuDB"].ConnectionString;

        /// <summary>
        /// Lấy dữ liệu dạng Bảng (DataTable) - Dùng cho SELECT
        /// </summary>
        public static DataTable GetData(string query, SqlParameter[] param = null, bool isProcedure = false)
        {
            using (SqlConnection con = new SqlConnection(strKetNoi))
            {
                try
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Nếu isProcedure = true thì set kiểu là StoredProcedure, ngược lại là Text
                        cmd.CommandType = isProcedure ? CommandType.StoredProcedure : CommandType.Text;

                        if (param != null) cmd.Parameters.AddRange(param);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
                catch (Exception ex)
                {
                    // Có thể log lỗi ra file hoặc Console nếu cần
                    // Console.WriteLine(ex.Message);
                    return null;
                }
            }
        }

        /// <summary>
        /// Thực thi lệnh Thêm/Sửa/Xóa (Không trả về dữ liệu)
        /// </summary>
        public static void Execute(string query, SqlParameter[] param = null, bool isProcedure = false)
        {
            using (SqlConnection con = new SqlConnection(strKetNoi))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandType = isProcedure ? CommandType.StoredProcedure : CommandType.Text;

                    if (param != null) cmd.Parameters.AddRange(param);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        /// <summary>
        /// Lấy 1 giá trị đơn (Ví dụ: đếm số dòng, lấy tổng tiền)
        /// </summary>
        public static object ExecuteScalar(string query, SqlParameter[] param = null, bool isProcedure = false)
        {
            using (SqlConnection con = new SqlConnection(strKetNoi))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandType = isProcedure ? CommandType.StoredProcedure : CommandType.Text;

                    if (param != null) cmd.Parameters.AddRange(param);

                    return cmd.ExecuteScalar();
                }
            }
        }

        /// <summary>
        /// Lấy 1 dòng dữ liệu đầu tiên (DataRow)
        /// </summary>
        public static DataRow GetOneRow(string query, SqlParameter[] param = null, bool isProcedure = false)
        {
            DataTable dt = GetData(query, param, isProcedure);
            if (dt != null && dt.Rows.Count > 0)
                return dt.Rows[0];
            return null;
        }
    }
}