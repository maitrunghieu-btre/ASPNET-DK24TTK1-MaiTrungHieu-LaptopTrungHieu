using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<CartItem> cart = Session["GioHang"] as List<CartItem>;
                if (cart == null || cart.Count == 0)
                {
                    Response.Redirect("Carts.aspx");
                    return;
                }
                LoadTomTat(cart);
                txtSoDT.Focus();

                if (Session["MaND"] != null)
                {
                    int maND = Convert.ToInt32(Session["MaND"]);
                    AutoCheckUser(maND);
                }
            }
        }

        private void LoadTomTat(List<CartItem> cart)
        {
            rptTomTat.DataSource = cart;
            rptTomTat.DataBind();
            lblTongTien.Text = cart.Sum(x => x.ThanhTien).ToString("N0") + "₫";
        }

        private void AutoCheckUser(int maND)
        {
            SqlParameter[] p = { new SqlParameter("@MaND", maND) };
            DataRow row = DBConnect.GetOneRow("SELECT SoDienThoai FROM NguoiDung WHERE MaND=@MaND", p);
            if (row != null)
            {
                txtSoDT.Text = row["SoDienThoai"].ToString();
                XuLyKiemTraSDT(txtSoDT.Text);
            }
        }

        // --- SỰ KIỆN TỰ ĐỘNG KHI NHẬP SĐT ---
        protected void txtSoDT_TextChanged(object sender, EventArgs e)
        {
            string sdt = txtSoDT.Text.Trim();
            if (!string.IsNullOrEmpty(sdt))
            {
                XuLyKiemTraSDT(sdt);
            }
        }

        private void XuLyKiemTraSDT(string sdt)
        {
            SqlParameter[] p = { new SqlParameter("@SoDienThoai", sdt) };
            DataRow row = DBConnect.GetOneRow("sp_KiemTraKhachHang", p, true);

            if (row != null)
            {
                // KHÁCH CŨ
                txtHoTen.Text = row["HoTen"].ToString();
                txtDiaChi.Text = row["DiaChi"].ToString();
                txtEmail.Text = row["Email"].ToString();

                hfMaND.Value = row["MaND"].ToString();
                hfIsNew.Value = "false";

                lblThongBao.Text = $"<i class='fa-solid fa-check-circle'></i> Chào mừng trở lại, <b>{row["HoTen"]}</b>.";
                lblThongBao.CssClass = "alert alert-success d-block small p-2 mt-2";
            }
            else
            {
                // KHÁCH MỚI
                txtHoTen.Text = "";
                txtDiaChi.Text = "";
                txtEmail.Text = "";

                hfMaND.Value = "";
                hfIsNew.Value = "true";

                lblThongBao.Text = "<i class='fa-solid fa-circle-info'></i> SĐT mới. Vui lòng điền thông tin bên dưới.";
                lblThongBao.CssClass = "alert alert-info d-block small p-2 mt-2";

                txtHoTen.Focus(); // Chuyển con trỏ xuống ô Tên
            }
        }

        // --- SỰ KIỆN ĐẶT HÀNG ---
        protected void btnHoanTat_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Kiểm tra SĐT lần cuối
            if (string.IsNullOrEmpty(txtSoDT.Text.Trim()))
            {
                lblThongBao.Text = "Vui lòng nhập SĐT!";
                lblThongBao.CssClass = "alert alert-danger d-block small";
                txtSoDT.Focus();
                return;
            }

            List<CartItem> cart = Session["GioHang"] as List<CartItem>;
            if (cart == null || cart.Count == 0) return;

            string hoTen = txtHoTen.Text.Trim();
            string sdt = txtSoDT.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();
            string email = txtEmail.Text.Trim();
            string ghiChu = txtGhiChu.Text.Trim();
            decimal tongTien = cart.Sum(x => x.ThanhTien);
            string diaChiGiaoHang = $"{hoTen} - {sdt} - {diaChi}";
            if (!string.IsNullOrEmpty(ghiChu)) diaChiGiaoHang += $" (Ghi chú: {ghiChu})";

            int maND = 0;
            int maDonMoi = 0;

            try
            {
                if (hfIsNew.Value == "true" || string.IsNullOrEmpty(hfMaND.Value))
                {
                    SqlParameter[] pUser = {
                        new SqlParameter("@HoTen", hoTen),
                        new SqlParameter("@SoDienThoai", sdt),
                        new SqlParameter("@DiaChi", diaChi),
                        new SqlParameter("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email)
                    };
                    object newId = DBConnect.ExecuteScalar("sp_TaoKhachHangMoi", pUser, true);
                    maND = Convert.ToInt32(newId);
                }
                else
                {
                    maND = Convert.ToInt32(hfMaND.Value);
                }

                SqlParameter[] pDon = {
                    new SqlParameter("@MaND", maND),
                    new SqlParameter("@TongTien", tongTien),
                    new SqlParameter("@DiaChiGiaoHang", diaChiGiaoHang)
                };
                object resDon = DBConnect.ExecuteScalar("sp_TaoDonDatHang", pDon, true);

                if (resDon != null)
                {
                    maDonMoi = Convert.ToInt32(resDon);
                    foreach (var item in cart)
                    {
                        SqlParameter[] pCT = {
                            new SqlParameter("@MaDon", maDonMoi),
                            new SqlParameter("@MaMay", item.MaMay),
                            new SqlParameter("@SoLuong", item.SoLuong),
                            new SqlParameter("@GiaBan", item.GiaBan)
                        };
                        DBConnect.Execute("sp_ThemChiTietDon", pCT, true);
                    }

                    Session["GioHang"] = null;
                    string js = $"alert('🎉 Đặt hàng thành công! Mã đơn: #{maDonMoi}.'); window.location='Default.aspx';";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", js, true);
                }
            }
            catch (Exception ex)
            {
                if (maDonMoi > 0)
                {
                    SqlParameter[] pXoa = { new SqlParameter("@MaDon", maDonMoi) };
                    DBConnect.Execute("sp_XoaDonHangKhiLoi", pXoa, true);
                }
                lblThongBao.Text = $"Lỗi: {ex.Message}";
                lblThongBao.CssClass = "alert alert-danger d-block mt-2";
            }
        }
    }
}