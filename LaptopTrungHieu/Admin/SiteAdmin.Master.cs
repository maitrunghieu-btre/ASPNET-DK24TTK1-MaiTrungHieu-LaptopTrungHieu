using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop.Admin
{
    public partial class SiteAdmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // BẢO MẬT: Kiểm tra quyền Admin
            // Nếu chưa đăng nhập HOẶC Vai trò không phải Admin -> Chuyển hướng
            if (Session["MaND"] == null || Session["VaiTro"] == null || Session["VaiTro"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                // Hiển thị tên Admin lên Sidebar
                if (Session["HoTen"] != null)
                {
                    litAdminName.Text = Session["HoTen"].ToString();
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xóa sạch Session và về trang Login
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}