using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; // Cần thiết để dùng SqlParameter
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBanner();
                LoadMenuHang();
                LoadSanPham();
            }
        }

        // 1. Load Banner Slider
        private void LoadBanner()
        {
            // Đảm bảo bạn đã có SP sp_LayBannerHienThi trong SQL
            DataTable dt = DBConnect.GetData("sp_LayBannerHienThi", null, true);
            rptBanner.DataSource = dt;
            rptBanner.DataBind();
        }

        // 2. Load Menu Hãng
        private void LoadMenuHang()
        {
            DataTable dt = DBConnect.GetData("sp_LayThuongHieu", null, true);
            rptMenuHang.DataSource = dt;
            rptMenuHang.DataBind();
        }

        // 3. Load Sản Phẩm (Logic chọn SP phù hợp)
        private void LoadSanPham()
        {
            DataTable dt = new DataTable();

            // TRƯỜNG HỢP 1: Tìm kiếm từ khóa (Ưu tiên cao nhất)
            if (Request.QueryString["k"] != null)
            {
                string keyword = Request.QueryString["k"].ToString();
                SqlParameter[] param = { new SqlParameter("@TuKhoa", keyword) };

                dt = DBConnect.GetData("sp_TimKiemMayTinh", param, true);
                lblTieuDe.Text = "Kết quả tìm kiếm: \"" + keyword + "\"";
            }
            // TRƯỜNG HỢP 2: Lọc theo Hãng
            else if (Request.QueryString["hang"] != null)
            {
                int maTH;
                if (int.TryParse(Request.QueryString["hang"], out maTH))
                {
                    SqlParameter[] param = { new SqlParameter("@MaTH", maTH) };
                    dt = DBConnect.GetData("sp_LayMayTinhTheoHang", param, true);

                    // Lấy tên hãng để hiển thị tiêu đề đẹp hơn
                    DataRow rHang = DBConnect.GetOneRow("SELECT TenTH FROM ThuongHieu WHERE MaTH=" + maTH);
                    if (rHang != null) lblTieuDe.Text = "Laptop " + rHang["TenTH"].ToString();
                }
            }
            // TRƯỜNG HỢP 3: Mặc định (Lấy máy mới nhất)
            else
            {
                // Gọi SP lấy 20 máy mới nhất
                SqlParameter[] param = { new SqlParameter("@SoLuong", 20) };
                dt = DBConnect.GetData("sp_LayMayTinhMoi", param, true);
                lblTieuDe.Text = "Sản phẩm mới về";
            }

            // Hiển thị dữ liệu ra Repeater
            if (dt != null && dt.Rows.Count > 0)
            {
                rptSanPham.DataSource = dt;
                rptSanPham.DataBind();
                lblSoLuong.Text = dt.Rows.Count.ToString();
                pnlNoData.Visible = false;
            }
            else
            {
                rptSanPham.DataSource = null;
                rptSanPham.DataBind();
                lblSoLuong.Text = "0";
                pnlNoData.Visible = true;
            }
        }

        // 4. Xử lý Thêm vào giỏ
        protected void btnMua_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int maMay = Convert.ToInt32(btn.CommandArgument);

            // Dùng Stored Procedure sp_XemChiTietMayTinh để lấy thông tin và tồn kho
            SqlParameter[] p = { new SqlParameter("@MaMay", maMay) };
            DataRow row = DBConnect.GetOneRow("sp_XemChiTietMayTinh", p, true);

            if (row != null)
            {
                int tonKho = Convert.ToInt32(row["TonKho"]);
                if (tonKho <= 0)
                {
                    Response.Write("<script>alert('Xin lỗi, sản phẩm này vừa hết hàng!');</script>");
                    return;
                }

                // Xử lý Session Giỏ hàng
                List<CartItem> cart = Session["GioHang"] as List<CartItem> ?? new List<CartItem>();

                var item = cart.FirstOrDefault(x => x.MaMay == maMay);
                if (item != null)
                {
                    if (item.SoLuong < tonKho)
                        item.SoLuong++;
                    else
                        Response.Write("<script>alert('Bạn đã chọn tối đa số lượng có sẵn trong kho!');</script>");
                }
                else
                {
                    cart.Add(new CartItem()
                    {
                        MaMay = maMay,
                        TenMay = row["TenMay"].ToString(),
                        HinhAnh = row["HinhAnh"].ToString(),
                        GiaBan = Convert.ToDecimal(row["GiaBan"]),
                        SoLuong = 1
                    });
                }

                Session["GioHang"] = cart;

                // Refresh lại trang để cập nhật số lượng trên Header
                Response.Redirect(Request.RawUrl);
            }
        }

        // Helper: Active menu hãng đang chọn
        protected string CheckActive(object maTH)
        {
            return (Request.QueryString["hang"] != null && Request.QueryString["hang"] == maTH.ToString()) ? "active" : "";
        }
    }
}