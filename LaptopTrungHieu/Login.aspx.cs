using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu đã đăng nhập rồi thì đá về trang chủ hoặc trang quản lý đơn
            if (Session["MaND"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string taiKhoan = txtTaiKhoan.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            if (string.IsNullOrEmpty(taiKhoan) || string.IsNullOrEmpty(matKhau))
            {
                lblThongBao.Text = "Vui lòng nhập đầy đủ thông tin!";
                lblThongBao.CssClass = "alert alert-warning d-block";
                return;
            }

            // Gọi SP Đăng Nhập
            SqlParameter[] p = {
                new SqlParameter("@TaiKhoan", taiKhoan),
                new SqlParameter("@MatKhau", matKhau)
            };

            DataRow row = DBConnect.GetOneRow("sp_DangNhap", p, true);

            if (row != null)
            {
                // --- ĐĂNG NHẬP THÀNH CÔNG ---

                // 1. Lưu thông tin quan trọng vào Session
                Session["MaND"] = row["MaND"].ToString();
                Session["HoTen"] = row["HoTen"].ToString();
                Session["Email"] = row["Email"].ToString();
                Session["VaiTro"] = row["VaiTro"].ToString(); // Để phân quyền Admin/Khách

                // 2. Điều hướng
                // Nếu là Admin -> Vào trang quản trị
                if (row["VaiTro"].ToString() == "Admin")
                {
                    Response.Redirect("~/Admin/Dashboard.aspx");
                }
                else
                {
                    // Nếu là Khách -> Về trang chủ hoặc trang đơn hàng
                    Response.Redirect("Default.aspx");
                }
            }
            else
            {
                // --- ĐĂNG NHẬP THẤT BẠI ---
                lblThongBao.Text = "Sai tài khoản hoặc mật khẩu!";
                lblThongBao.CssClass = "alert alert-danger d-block";
            }
        }
    }
}