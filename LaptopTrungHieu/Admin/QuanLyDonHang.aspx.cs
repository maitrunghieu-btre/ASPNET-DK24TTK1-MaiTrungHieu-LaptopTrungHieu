using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop.Admin
{
    public partial class QuanLyDonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDonHang();
            }
        }

        private void LoadDonHang()
        {
            string tuKhoa = txtSearch.Text.Trim();
            string trangThai = ddlStatus.SelectedValue;

            object tuNgay = string.IsNullOrEmpty(txtFromDate.Text) ? (object)DBNull.Value : txtFromDate.Text;
            object denNgay = string.IsNullOrEmpty(txtToDate.Text) ? (object)DBNull.Value : txtToDate.Text;

            SqlParameter[] p = {
                new SqlParameter("@TuKhoa", tuKhoa),
                new SqlParameter("@TrangThai", trangThai),
                new SqlParameter("@TuNgay", tuNgay),
                new SqlParameter("@DenNgay", denNgay)
            };

            DataTable dt = DBConnect.GetData("sp_QuanLyDonHang_Filter", p, true);
            gvDonHang.DataSource = dt;
            gvDonHang.DataBind();
        }

        protected void btnFilter_Click(object sender, EventArgs e) { LoadDonHang(); }

        protected void gvDonHang_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDonHang.PageIndex = e.NewPageIndex;
            LoadDonHang();
        }

        protected void gvDonHang_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string trangThai = DataBinder.Eval(e.Row.DataItem, "TrangThai").ToString();

                LinkButton btnDuyet = (LinkButton)e.Row.FindControl("btnDuyet");
                LinkButton btnGiao = (LinkButton)e.Row.FindControl("btnGiao");
                LinkButton btnHuy = (LinkButton)e.Row.FindControl("btnHuy");

                // BƯỚC 1: Mặc định ẩn tất cả các nút xử lý
                if (btnDuyet != null) btnDuyet.Visible = false;
                if (btnGiao != null) btnGiao.Visible = false;
                if (btnHuy != null) btnHuy.Visible = false;

                // BƯỚC 2: Hiển thị dựa trên quy trình
                if (trangThai == "Chờ duyệt")
                {
                    btnDuyet.Visible = true;
                    btnHuy.Visible = true;
                }
                else if (trangThai == "Đã duyệt")
                {
                    btnGiao.Visible = true;
                    btnHuy.Visible = true;
                }
                else if (trangThai == "Đang giao")
                {
                    // Nút Hoàn tất giao hàng
                    if (btnGiao != null)
                    {
                        btnGiao.Visible = true;
                        btnGiao.Text = "<i class='fa-solid fa-check-double'></i> Hoàn tất";
                        btnGiao.CommandName = "HoanTat";
                        btnGiao.CssClass = "btn btn-sm btn-primary me-1";
                    }
                    // Nút Hủy (Hoàn kho) xuất hiện khi khách không nhận hàng
                    if (btnHuy != null)
                    {
                        btnHuy.Visible = true;
                        btnHuy.ToolTip = "Khách không nhận - Hoàn kho";
                    }
                }
                // Trạng thái "Đã giao" hoặc "Đã hủy" sẽ ẩn hết các nút trên
            }
        }
        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "XemChiTiet")
            {
                LoadChiTietDon(Convert.ToInt32(e.CommandArgument));
            }
            else if (e.CommandName == "DuyetDon") UpdateStatus(Convert.ToInt32(e.CommandArgument), "Đã duyệt");
            else if (e.CommandName == "GiaoHang") UpdateStatus(Convert.ToInt32(e.CommandArgument), "Đang giao");
            else if (e.CommandName == "HoanTat") UpdateStatus(Convert.ToInt32(e.CommandArgument), "Đã giao");
            else if (e.CommandName == "HuyDon")
            {
                int maDon = Convert.ToInt32(e.CommandArgument);
                SqlParameter[] p = { new SqlParameter("@MaDon", maDon) };

                // Gọi sp_HuyDonHang (Đã được cập nhật để cho phép hủy trạng thái Đã duyệt)
                DBConnect.Execute("sp_HuyDonHang", p, true);
                LoadDonHang();
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Đã hủy đơn hàng và hoàn trả tồn kho!');", true);
            }
        }

        private void UpdateStatus(int maDon, string statusMoi)
        {
            SqlParameter[] p = { new SqlParameter("@MaDon", maDon), new SqlParameter("@TrangThaiMoi", statusMoi) };
            DBConnect.Execute("sp_CapNhatTrangThaiDon", p, true);
            LoadDonHang();
        }

        private void LoadChiTietDon(int maDon)
        {
            SqlParameter[] pHeader = { new SqlParameter("@MaDon", maDon) };
            DataRow rowHeader = DBConnect.GetOneRow("sp_LayThongTinDonHang", pHeader, true);

            if (rowHeader != null)
            {
                lblModalMaDon.Text = maDon.ToString();
                lblModalThongTin.Text = $"<b>{rowHeader["HoTen"]}</b> ({rowHeader["SoDienThoai"]})<br/>Địa chỉ: {rowHeader["DiaChiGiaoHang"]}";
                lblModalTongTien.Text = Convert.ToDecimal(rowHeader["TongTien"]).ToString("N0") + "₫";
            }

            SqlParameter[] pBody = { new SqlParameter("@MaDon", maDon) };
            rptChiTiet.DataSource = DBConnect.GetData("sp_LayChiTietSanPhamDon", pBody, true);
            rptChiTiet.DataBind();

            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openOrderModal();", true);
        }
    }
}