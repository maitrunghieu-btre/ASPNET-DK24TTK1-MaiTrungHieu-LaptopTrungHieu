using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Laptop
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Nếu đã đăng nhập thì đá về trang chủ
                if (Session["MaND"] != null)
                {
                    Response.Redirect("Default.aspx");
                }

                // Xóa sạch form khi mới vào trang
                ClearForm();
            }
        }

        // Hàm xóa trắng các ô nhập liệu
        private void ClearForm()
        {
            txtHoTen.Text = string.Empty;
            txtSoDT.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtMatKhau.Text = string.Empty;
            txtNhapLaiMK.Text = string.Empty;
            txtDiaChi.Text = string.Empty;

            // Xóa thông báo lỗi cũ (nếu có)
            lblThongBao.Text = string.Empty;
            lblThongBao.CssClass = string.Empty;

            // Focus vào ô đầu tiên
            txtHoTen.Focus();
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string hoTen = txtHoTen.Text.Trim();
            string sdt = txtSoDT.Text.Trim();
            string email = txtEmail.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();

            SqlParameter[] p = {
                new SqlParameter("@HoTen", hoTen),
                new SqlParameter("@SoDienThoai", sdt),
                new SqlParameter("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email),
                new SqlParameter("@MatKhau", matKhau),
                new SqlParameter("@DiaChi", diaChi)
            };

            object result = DBConnect.ExecuteScalar("sp_DangKyTaiKhoan", p, true);
            int code = Convert.ToInt32(result);

            if (code == 1)
            {
                string js = "alert('🎉 Đăng ký thành công! Hãy đăng nhập ngay.'); window.location='Login.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "registerSuccess", js, true);
            }
            else if (code == -1)
            {
                lblThongBao.Text = "Số điện thoại này đã được sử dụng!";
                lblThongBao.CssClass = "alert alert-danger d-block text-center";
                txtSoDT.Focus();
            }
            else if (code == -2)
            {
                lblThongBao.Text = "Email này đã được sử dụng!";
                lblThongBao.CssClass = "alert alert-danger d-block text-center";
                txtEmail.Focus();
            }
            else
            {
                lblThongBao.Text = "Lỗi hệ thống, vui lòng thử lại sau!";
                lblThongBao.CssClass = "alert alert-warning d-block text-center";
            }
        }
    }
}