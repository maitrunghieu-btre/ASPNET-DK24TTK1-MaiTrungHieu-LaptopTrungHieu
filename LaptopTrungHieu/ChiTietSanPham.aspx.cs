using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    public partial class ChiTietSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    int id;
                    if (int.TryParse(Request.QueryString["id"], out id))
                    {
                        LoadChiTiet(id);
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
            }
        }

        private void LoadChiTiet(int id)
        {
            // --- LẦN GỌI 1: Lấy thông tin máy ---
            // Dùng p1 riêng cho lần gọi này
            SqlParameter[] p1 = { new SqlParameter("@MaMay", id) };
            DataRow row = DBConnect.GetOneRow("sp_XemChiTietMayTinh", p1, true);

            if (row != null)
            {
                // Gán dữ liệu cơ bản
                lblTenMay.Text = row["TenMay"].ToString();
                lblTenMayBreadcrumb.Text = row["TenMay"].ToString();
                lblMaMay.Text = row["MaMay"].ToString();
                lblThuongHieu.Text = row["TenTH"].ToString();
                lblHang.Text = row["TenTH"].ToString();
                lblGiaBan.Text = Convert.ToDecimal(row["GiaBan"]).ToString("N0") + " đ";

                // --- LẦN GỌI 2: Lấy Album ảnh ---
                // QUAN TRỌNG: Tạo p2 MỚI TINH, không dùng lại p1 để tránh lỗi mất tham số
                SqlParameter[] p2 = { new SqlParameter("@MaMay", id) };
                DataTable dtAlbum = DBConnect.GetData("sp_LayThuVienAnh", p2, true);

                if (dtAlbum != null && dtAlbum.Rows.Count > 0)
                {
                    // Có ảnh phụ -> Hiện Album và dải thumbnail
                    rptAlbum.DataSource = dtAlbum; rptAlbum.DataBind();
                    rptThumb.DataSource = dtAlbum; rptThumb.DataBind();

                    rptThumb.Visible = true;
                    pnlControls.Visible = (dtAlbum.Rows.Count > 1);
                }
                else
                {
                    // Không có ảnh phụ -> Lấy ảnh chính làm giả Album
                    DataTable dtFake = new DataTable();
                    dtFake.Columns.Add("DuongDan");
                    dtFake.Rows.Add(row["HinhAnh"]);

                    rptAlbum.DataSource = dtFake; rptAlbum.DataBind();

                    rptThumb.Visible = false; // Ẩn thumbnail vì chỉ có 1 ảnh
                    pnlControls.Visible = false;
                }

                // Xử lý Cấu hình
                string cauHinhFull = row["CauHinh"].ToString();
                string[] specs = cauHinhFull.Split(',');
                if (specs.Length > 0) lblCPU.Text = specs[0].Trim();
                if (specs.Length > 1) lblRamSsd.Text = specs[1].Trim();
                if (specs.Length > 2) lblManHinh.Text = specs[2].Trim();
                else lblManHinh.Text = cauHinhFull;

                // Xử lý Mô tả
                string moTa = row["MoTa"].ToString();
                litMoTa.Text = string.IsNullOrEmpty(moTa) ? "<p class='text-muted fst-italic'>Đang cập nhật nội dung...</p>" : moTa;

                // Xử lý Tồn kho
                int tonKho = Convert.ToInt32(row["TonKho"]);
                if (tonKho > 0)
                {
                    lblTinhTrang.Text = "Còn hàng"; lblTinhTrang.CssClass = "badge bg-success";
                    btnMuaNgay.Visible = true; lblHetHang.Visible = false;
                }
                else
                {
                    lblTinhTrang.Text = "Hết hàng"; lblTinhTrang.CssClass = "badge bg-danger";
                    btnMuaNgay.Visible = false; lblHetHang.Visible = true;
                }

                // --- LẦN GỌI 3: Load Liên quan ---
                LoadLienQuan(Convert.ToInt32(row["MaTH"]), id);
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        private void LoadLienQuan(int maTH, int currentId)
        {
            // Tạo tham số riêng cho phần liên quan
            SqlParameter[] p = {
                new SqlParameter("@MaTH", maTH),
                new SqlParameter("@MaMayHienTai", currentId)
            };

            DataTable dt = DBConnect.GetData("sp_LayMayTinhLienQuan", p, true);
            rptLienQuan.DataSource = dt;
            rptLienQuan.DataBind();
        }

        protected void btnMuaNgay_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                AddToCart(int.Parse(Request.QueryString["id"]));
                Response.Redirect("Carts.aspx");
            }
        }

        protected void btnMuaLienQuan_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int maMay = Convert.ToInt32(btn.CommandArgument);
            AddToCart(maMay);
            Response.Redirect(Request.RawUrl);
        }

        private void AddToCart(int id)
        {
            SqlParameter[] p = { new SqlParameter("@MaMay", id) };
            DataRow row = DBConnect.GetOneRow("sp_XemChiTietMayTinh", p, true);

            if (row != null)
            {
                int tonKho = Convert.ToInt32(row["TonKho"]);
                if (tonKho <= 0) return;

                List<CartItem> cart = Session["GioHang"] as List<CartItem> ?? new List<CartItem>();
                var item = cart.FirstOrDefault(x => x.MaMay == id);

                if (item != null)
                {
                    if (item.SoLuong < tonKho) item.SoLuong++;
                }
                else
                {
                    cart.Add(new CartItem()
                    {
                        MaMay = id,
                        TenMay = row["TenMay"].ToString(),
                        HinhAnh = row["HinhAnh"].ToString(),
                        GiaBan = Convert.ToDecimal(row["GiaBan"]),
                        SoLuong = 1
                    });
                }
                Session["GioHang"] = cart;
            }
        }
    }
}