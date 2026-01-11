using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop.Admin
{
    public partial class QuanLyNhaPhanPhoi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDanhSach();
            }
        }

        private void LoadDanhSach()
        {
            DataTable dt = DBConnect.GetData("sp_LayNhaPhanPhoi", null, true);
            gvNPP.DataSource = dt;
            gvNPP.DataBind();
        }

        // --- NÚT THÊM MỚI ---
        protected void btnThemMoi_Click(object sender, EventArgs e)
        {
            hfMaNPP.Value = ""; // Xóa ID -> Chế độ Thêm
            txtTenNPP.Text = "";
            txtSDT.Text = "";
            txtEmail.Text = "";
            txtDiaChi.Text = "";
            lblModalTitle.Text = "THÊM NHÀ PHÂN PHỐI MỚI";

            // Mở modal
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openNPPModal();", true);
        }

        // --- XỬ LÝ SỰ KIỆN GRIDVIEW (SỬA / XÓA) ---
        protected void gvNPP_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Sua")
            {
                // Chuỗi Argument: "ID;Ten;SDT;Email;DiaChi"
                string[] args = e.CommandArgument.ToString().Split(';');
                if (args.Length >= 5)
                {
                    hfMaNPP.Value = args[0];
                    txtTenNPP.Text = args[1];
                    txtSDT.Text = args[2];
                    txtEmail.Text = args[3];
                    txtDiaChi.Text = args[4];
                    lblModalTitle.Text = "CẬP NHẬT THÔNG TIN NPP";

                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openNPPModal();", true);
                }
            }
            else if (e.CommandName == "Xoa")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                SqlParameter[] p = { new SqlParameter("@MaNPP", id) };

                object result = DBConnect.ExecuteScalar("sp_XoaNhaPhanPhoi", p, true);
                int code = Convert.ToInt32(result);

                if (code == 1)
                {
                    LoadDanhSach();
                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Đã xóa thành công!');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Không thể xóa! NPP này đã có đơn nhập hàng (dữ liệu ràng buộc).');", true);
                }
            }
        }

        // --- NÚT LƯU ---
        protected void btnLuu_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string ten = txtTenNPP.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string email = txtEmail.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();

            if (string.IsNullOrEmpty(hfMaNPP.Value))
            {
                // 1. THÊM MỚI
                SqlParameter[] p = {
                    new SqlParameter("@TenNPP", ten),
                    new SqlParameter("@DiaChi", diaChi),
                    new SqlParameter("@SoDienThoai", sdt),
                    new SqlParameter("@Email", email)
                };
                DBConnect.Execute("sp_ThemNhaPhanPhoi", p, true);
            }
            else
            {
                // 2. CẬP NHẬT
                int id = Convert.ToInt32(hfMaNPP.Value);
                SqlParameter[] p = {
                    new SqlParameter("@MaNPP", id),
                    new SqlParameter("@TenNPP", ten),
                    new SqlParameter("@DiaChi", diaChi),
                    new SqlParameter("@SoDienThoai", sdt),
                    new SqlParameter("@Email", email)
                };
                DBConnect.Execute("sp_SuaNhaPhanPhoi", p, true);
            }

            Response.Redirect("QuanLyNhaPhanPhoi.aspx");
        }
    }
}