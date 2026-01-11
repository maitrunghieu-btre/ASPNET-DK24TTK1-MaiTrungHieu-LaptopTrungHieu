using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop.Admin
{
    public partial class QuanLyNguoiDung : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDanhSachNguoiDung();
            }
        }

        private void LoadDanhSachNguoiDung()
        {
            // Lấy toàn bộ danh sách để quản lý, sắp xếp người dùng mới nhất lên đầu
            string sql = "SELECT MaND, HoTen, Email, SoDienThoai, DiaChi, VaiTro, NgayTao FROM NguoiDung ORDER BY MaND DESC";
            gvNguoiDung.DataSource = DBConnect.GetData(sql);
            gvNguoiDung.DataBind();
        }

        protected void gvNguoiDung_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNguoiDung.PageIndex = e.NewPageIndex;
            LoadDanhSachNguoiDung();
        }

        protected void gvNguoiDung_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string vt = DataBinder.Eval(e.Row.DataItem, "VaiTro").ToString();
                Label lbl = (Label)e.Row.FindControl("lblVaiTro");
                if (lbl != null)
                {
                    // Gán màu sắc cho Badge dựa trên vai trò
                    lbl.CssClass += (vt == "Admin") ? " bg-admin" : " bg-khach";
                }
            }
        }

        protected void gvNguoiDung_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataRow r = DBConnect.GetOneRow("SELECT * FROM NguoiDung WHERE MaND = " + id);
                if (r != null)
                {
                    // Đổ dữ liệu vào các ô nhập trong Modal
                    hfMaND.Value = id.ToString();
                    txtHoTen.Text = r["HoTen"].ToString();
                    txtEmail.Text = r["Email"].ToString();
                    txtSDT.Text = r["SoDienThoai"].ToString();
                    txtMatKhau.Text = ""; // Mật khẩu luôn để trống khi mở form sửa
                    txtDiaChi.Text = r["DiaChi"].ToString();
                    ddlVaiTroEdit.SelectedValue = r["VaiTro"].ToString();

                    ltrModalTitle.Text = "Chỉnh sửa thành viên: " + r["HoTen"];
                    lblMsg.Visible = false; // Ẩn thông báo lỗi cũ

                    // Gọi script mở Modal
                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openEditModal();", true);
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            lblMsg.Visible = false;

            // Kiểm tra các trường bắt buộc
            if (string.IsNullOrEmpty(txtHoTen.Text.Trim()) || string.IsNullOrEmpty(txtSDT.Text.Trim()))
            {
                lblMsg.Text = "Họ tên và Số điện thoại không được để trống!";
                lblMsg.Visible = true;
                return;
            }

            int maND = int.Parse(hfMaND.Value);
            SqlParameter[] p = {
                new SqlParameter("@MaND", maND),
                new SqlParameter("@HoTen", txtHoTen.Text.Trim()),
                new SqlParameter("@Email", txtEmail.Text.Trim()),
                new SqlParameter("@MatKhau", txtMatKhau.Text.Trim()),
                new SqlParameter("@SoDienThoai", txtSDT.Text.Trim()),
                new SqlParameter("@DiaChi", txtDiaChi.Text.Trim()),
                new SqlParameter("@VaiTro", ddlVaiTroEdit.SelectedValue)
            };

            // Thực thi Stored Procedure và nhận kết quả trả về
            // Trả về: 1 (Thành công), -1 (Trùng Email), -2 (Trùng SĐT)
            object result = DBConnect.ExecuteScalar("sp_LuuNguoiDung", p, true);
            int res = Convert.ToInt32(result);

            if (res == -2)
            {
                lblMsg.Text = "Số điện thoại này đã được sử dụng bởi thành viên khác!";
                lblMsg.Visible = true;
            }
            else if (res == -1)
            {
                lblMsg.Text = "Email này đã được sử dụng bởi thành viên khác!";
                lblMsg.Visible = true;
            }
            else if (res == 1)
            {
                LoadDanhSachNguoiDung();
                // Thông báo thành công và đóng Modal bằng Javascript
                string script = "alert('Cập nhật thông tin thành công!'); var m = bootstrap.Modal.getInstance(document.getElementById('editUserModal')); m.hide();";
                ScriptManager.RegisterStartupScript(this, GetType(), "Success", script, true);
            }
        }
    }
}