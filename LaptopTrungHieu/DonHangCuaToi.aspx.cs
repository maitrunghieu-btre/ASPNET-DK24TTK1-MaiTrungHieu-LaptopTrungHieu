using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    public partial class DonHangCuaToi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["MaND"] == null)
                {
                    pnlChuaDangNhap.Visible = true;
                    pnlDaDangNhap.Visible = false;
                }
                else
                {
                    pnlChuaDangNhap.Visible = false;
                    pnlDaDangNhap.Visible = true;
                    LoadDanhSachDonHang();
                }
            }
        }

        private void LoadDanhSachDonHang()
        {
            int maND = Convert.ToInt32(Session["MaND"]);
            SqlParameter[] p = { new SqlParameter("@MaND", maND) };

            DataTable dt = DBConnect.GetData("sp_LayDonHangCuaToi", p, true);
            if (dt != null && dt.Rows.Count > 0)
            {
                rptDonHang.DataSource = dt;
                rptDonHang.DataBind();
                lblThongBao.Text = "";
            }
            else
            {
                rptDonHang.DataSource = null;
                rptDonHang.DataBind();
                lblThongBao.Text = "<div class='alert alert-info text-center mt-3'>Bạn chưa có đơn hàng nào. <a href='Default.aspx' class='fw-bold'>Mua sắm ngay</a></div>";
            }
        }

        protected void rptDonHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int maDon = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "HuyDon")
            {
                SqlParameter[] p = { new SqlParameter("@MaDon", maDon) };
                object result = DBConnect.ExecuteScalar("sp_HuyDonHang", p, true);

                if (result != null && Convert.ToInt32(result) == 1)
                {
                    LoadDanhSachDonHang();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Đã hủy đơn hàng thành công! Số lượng đã được hoàn lại kho.');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Không thể hủy đơn hàng này (Đơn đã giao hoặc đang vận chuyển).');", true);
                }
            }
            else if (e.CommandName == "XemDon")
            {
                LoadChiTietHoaDon(maDon);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openInvoiceModal();", true);
            }
        }

        private void LoadChiTietHoaDon(int maDon)
        {
            // 1. Lấy thông tin Header (Dùng tham số p1)
            SqlParameter[] p1 = { new SqlParameter("@MaDon", maDon) };
            DataRow row = DBConnect.GetOneRow("sp_LayThongTinDonHang", p1, true);

            if (row != null)
            {
                lblModalMaDon.Text = maDon.ToString();
                lblModalNgayDat.Text = Convert.ToDateTime(row["NgayDat"]).ToString("dd/MM/yyyy HH:mm");
                lblModalTrangThai.Text = row["TrangThai"].ToString();

                string nguoiNhan = $"{row["HoTen"]} ({row["SoDienThoai"]})";
                lblModalNguoiNhan.Text = nguoiNhan;
                lblModalDiaChi.Text = row["DiaChiGiaoHang"].ToString();

                lblModalTongTien.Text = Convert.ToDecimal(row["TongTien"]).ToString("N0") + "₫";
            }

            // 2. Lấy chi tiết sản phẩm (QUAN TRỌNG: Tạo tham số p2 mới để tránh lỗi reuse)
            SqlParameter[] p2 = { new SqlParameter("@MaDon", maDon) };
            DataTable dtCT = DBConnect.GetData("sp_LayChiTietSanPhamDon", p2, true);

            rptChiTietModal.DataSource = dtCT;
            rptChiTietModal.DataBind();
        }

        public string GetStatusClass(object trangThai)
        {
            string s = trangThai.ToString();
            if (s == "Chờ duyệt") return "st-cho-duyet";
            if (s == "Đã giao") return "st-da-giao";
            if (s == "Đã hủy") return "st-da-huy";
            return "st-default";
        }
    }
}