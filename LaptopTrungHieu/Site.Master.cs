using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMenu();
                CheckLoginStatus();
                UpdateCartCount();
            }
        }

        // 1. Load Menu Thương Hiệu
        private void LoadMenu()
        {
            DataTable dt = DBConnect.GetData("sp_LayThuongHieu", null, true);
            rptMenuHang.DataSource = dt;
            rptMenuHang.DataBind();
        }

        // 2. Kiểm tra trạng thái đăng nhập & Phân quyền
        private void CheckLoginStatus()
        {
            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (Session["MaND"] != null && Session["HoTen"] != null)
            {
                // -- TRẠNG THÁI: ĐÃ ĐĂNG NHẬP --
                pnlGuest.Visible = false;
                pnlUser.Visible = true;

                // Hiển thị tên người dùng
                lblHoTen.Text = Session["HoTen"].ToString();

                // Kiểm tra vai trò (Admin hay Khach)
                string vaiTro = Session["VaiTro"] != null ? Session["VaiTro"].ToString() : "Khach";

                if (vaiTro == "Admin")
                {
                    // Hiện Menu Admin
                    pnlAdminMenu.Visible = true;
                    pnlCustomerMenu.Visible = false;
                }
                else
                {
                    // Hiện Menu Khách hàng
                    pnlAdminMenu.Visible = false;
                    pnlCustomerMenu.Visible = true;
                }
            }
            else
            {
                // -- TRẠNG THÁI: CHƯA ĐĂNG NHẬP --
                pnlGuest.Visible = true;
                pnlUser.Visible = false;
            }
        }

        // 3. Cập nhật số lượng giỏ hàng
        public void UpdateCartCount()
        {
            List<CartItem> cart = Session["GioHang"] as List<CartItem>;
            if (cart != null && cart.Count > 0)
            {
                lblCartCount.Text = cart.Sum(x => x.SoLuong).ToString();
                lblCartCount.Visible = true;
            }
            else
            {
                lblCartCount.Text = "0";
            }
        }

        // 4. Xử lý Đăng xuất
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xóa toàn bộ Session đăng nhập
            Session["MaND"] = null;
            Session["HoTen"] = null;
            Session["Email"] = null;
            Session["VaiTro"] = null;

            // Chuyển về trang chủ
            Response.Redirect("~/Default.aspx");
        }

        // 5. Xử lý Tìm kiếm
        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtTimKiem.Text))
            {
                Response.Redirect("~/Default.aspx?k=" + txtTimKiem.Text.Trim());
            }
        }
    }
}