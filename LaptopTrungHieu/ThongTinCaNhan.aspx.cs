using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    public partial class ThongTinCaNhan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra Session MaND (Hệ thống mới)
            if (Session["MaND"] == null)
            {
                pnlProfile.Visible = false;
                pnlPassword.Visible = false;
                pnlChuaLogin.Visible = true;
                return;
            }
            else
            {
                pnlProfile.Visible = true;
                pnlPassword.Visible = true;
                pnlChuaLogin.Visible = false;
            }

            if (!IsPostBack)
            {
                LoadThongTin();
            }
        }

        private void LoadThongTin()
        {
            int maND = Convert.ToInt32(Session["MaND"]);

            // Lấy thông tin từ bảng NguoiDung
            string sql = "SELECT HoTen, Email, SoDienThoai, DiaChi FROM NguoiDung WHERE MaND = @MaND";
            SqlParameter[] p = { new SqlParameter("@MaND", maND) };

            DataRow row = DBConnect.GetOneRow(sql, p);

            if (row != null)
            {
                txtHoTen.Text = row["HoTen"].ToString();
                txtEmail.Text = row["Email"].ToString(); // Hiển thị email vào textbox
                txtSoDT.Text = row["SoDienThoai"].ToString();
                txtDiaChi.Text = row["DiaChi"].ToString();
            }
        }

        // --- CẬP NHẬT THÔNG TIN ---
        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int maND = Convert.ToInt32(Session["MaND"]);
                string sdt = txtSoDT.Text.Trim();
                string email = txtEmail.Text.Trim();

                // Chuẩn bị tham số gọi Stored Procedure
                SqlParameter[] p = {
                    new SqlParameter("@MaTK", maND), // SP dùng tham số @MaTK nhưng giá trị là MaND
                    new SqlParameter("@HoTen", txtHoTen.Text.Trim()),
                    new SqlParameter("@SoDienThoai", string.IsNullOrEmpty(sdt) ? (object)DBNull.Value : sdt),
                    new SqlParameter("@DiaChi", txtDiaChi.Text.Trim()),
                    new SqlParameter("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email)
                };

                try
                {
                    // Gọi SP sp_CapNhatThongTin
                    object ketQua = DBConnect.ExecuteScalar("sp_CapNhatThongTin", p, true);
                    int status = Convert.ToInt32(ketQua);

                    if (status == 1)
                    {
                        Session["HoTen"] = txtHoTen.Text.Trim(); // Cập nhật lại tên trên Header
                        lblThongBaoProfile.Text = "Cập nhật thông tin thành công!";
                        lblThongBaoProfile.CssClass = "text-success fw-bold";
                    }
                    else if (status == -1)
                    {
                        lblThongBaoProfile.Text = "Lỗi: Số điện thoại này đã được người khác sử dụng!";
                        lblThongBaoProfile.CssClass = "text-danger fw-bold";
                    }
                    else if (status == -2)
                    {
                        lblThongBaoProfile.Text = "Lỗi: Email này đã được người khác sử dụng!";
                        lblThongBaoProfile.CssClass = "text-danger fw-bold";
                    }
                }
                catch (Exception ex)
                {
                    // SỬA LỖI BIẾN ex: Sử dụng ex.Message để hiển thị lỗi chi tiết
                    lblThongBaoProfile.Text = "Lỗi hệ thống: " + ex.Message;
                    lblThongBaoProfile.CssClass = "text-danger fw-bold";
                }
            }
        }

        // --- ĐỔI MẬT KHẨU ---
        protected void btnDoiMatKhau_Click(object sender, EventArgs e)
        {
            if (Session["MaND"] == null) return;

            if (Page.IsValid)
            {
                int maND = Convert.ToInt32(Session["MaND"]);
                string mkCu = txtMatKhauCu.Text.Trim();
                string mkMoi = txtMatKhauMoi.Text.Trim();

                // 1. Kiểm tra mật khẩu cũ
                string sqlCheck = "SELECT MatKhau FROM NguoiDung WHERE MaND = @MaND AND MatKhau = @MatKhauCu";
                SqlParameter[] pCheck = {
                    new SqlParameter("@MaND", maND),
                    new SqlParameter("@MatKhauCu", mkCu)
                };

                DataRow row = DBConnect.GetOneRow(sqlCheck, pCheck);

                if (row == null)
                {
                    lblThongBaoPassword.Text = "Mật khẩu cũ không chính xác!";
                    lblThongBaoPassword.CssClass = "text-danger fw-bold";
                    return;
                }

                // 2. Cập nhật mật khẩu mới
                string sqlUpdate = "UPDATE NguoiDung SET MatKhau = @MatKhauMoi WHERE MaND = @MaND";
                SqlParameter[] pUpdate = {
                    new SqlParameter("@MatKhauMoi", mkMoi),
                    new SqlParameter("@MaND", maND)
                };

                try
                {
                    DBConnect.Execute(sqlUpdate, pUpdate);
                    lblThongBaoPassword.Text = "Đổi mật khẩu thành công!";
                    lblThongBaoPassword.CssClass = "text-success fw-bold";

                    // Xóa trắng các ô mật khẩu
                    txtMatKhauCu.Text = "";
                    txtMatKhauMoi.Text = "";
                    txtXacNhanMoi.Text = "";
                }
                catch (Exception)
                {
                    // SỬA LỖI BIẾN ex: Bỏ khai báo 'ex' nếu không dùng
                    lblThongBaoPassword.Text = "Lỗi hệ thống khi đổi mật khẩu.";
                    lblThongBaoPassword.CssClass = "text-danger fw-bold";
                }
            }
        }
    }
}