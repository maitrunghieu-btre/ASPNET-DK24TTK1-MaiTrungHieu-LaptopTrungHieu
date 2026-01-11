using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop.Admin
{
    public partial class QuanLyDanhMuc : System.Web.UI.Page
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
            // Sử dụng SP có sẵn: sp_LayThuongHieu
            DataTable dt = DBConnect.GetData("sp_LayThuongHieu", null, true);
            gvThuongHieu.DataSource = dt;
            gvThuongHieu.DataBind();
        }

        // --- NÚT THÊM MỚI ---
        protected void btnThemMoi_Click(object sender, EventArgs e)
        {
            hfMaTH.Value = ""; // Xóa ID -> Chế độ Thêm
            txtTenTH.Text = "";
            txtMoTa.Text = "";
            txtThuTu.Text = "50"; // Mặc định thứ tự 50
            lblModalTitle.Text = "THÊM THƯƠNG HIỆU MỚI";

            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openBrandModal();", true);
        }

        // --- XỬ LÝ SỰ KIỆN GRIDVIEW ---
        protected void gvThuongHieu_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Sua")
            {
                // Argument format: "ID;Ten;MoTa;ThuTu"
                string[] args = e.CommandArgument.ToString().Split(';');
                if (args.Length >= 4)
                {
                    hfMaTH.Value = args[0];
                    txtTenTH.Text = args[1];
                    txtMoTa.Text = args[2];
                    txtThuTu.Text = args[3];
                    lblModalTitle.Text = "CẬP NHẬT THƯƠNG HIỆU";

                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openBrandModal();", true);
                }
            }
            else if (e.CommandName == "Xoa")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                SqlParameter[] p = { new SqlParameter("@MaTH", id) };

                object result = DBConnect.ExecuteScalar("sp_XoaThuongHieu", p, true);
                int code = Convert.ToInt32(result);

                if (code == 1)
                {
                    LoadDanhSach();
                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Đã xóa thành công!');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Không thể xóa! Đang có sản phẩm thuộc hãng này.');", true);
                }
            }
        }

        // --- NÚT LƯU ---
        protected void btnLuu_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string tenTH = txtTenTH.Text.Trim();
            string moTa = txtMoTa.Text.Trim();
            int thuTu = 0;
            int.TryParse(txtThuTu.Text, out thuTu);

            if (string.IsNullOrEmpty(hfMaTH.Value))
            {
                // 1. THÊM MỚI
                SqlParameter[] p = {
                    new SqlParameter("@TenTH", tenTH),
                    new SqlParameter("@MoTa", moTa),
                    new SqlParameter("@ThuTu", thuTu)
                };
                DBConnect.Execute("sp_ThemThuongHieu", p, true);
            }
            else
            {
                // 2. CẬP NHẬT
                int id = Convert.ToInt32(hfMaTH.Value);
                SqlParameter[] p = {
                    new SqlParameter("@MaTH", id),
                    new SqlParameter("@TenTH", tenTH),
                    new SqlParameter("@MoTa", moTa),
                    new SqlParameter("@ThuTu", thuTu)
                };
                DBConnect.Execute("sp_SuaThuongHieu", p, true);
            }

            Response.Redirect("QuanLyDanhMuc.aspx");
        }
    }
}