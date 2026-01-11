using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop.Admin
{
    public partial class QuanLyNhapHang : System.Web.UI.Page
    {
        private DataTable DtChiTiet
        {
            get
            {
                if (ViewState["ChiTietNhap"] == null)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("MaMay", typeof(int));
                    dt.Columns.Add("TenMay", typeof(string));
                    dt.Columns.Add("SoLuong", typeof(int));
                    dt.Columns.Add("GiaNhap", typeof(decimal));
                    dt.Columns.Add("ThanhTien", typeof(decimal));
                    dt.Columns.Add("GiaBanMoi", typeof(decimal));
                    ViewState["ChiTietNhap"] = dt;
                }
                return (DataTable)ViewState["ChiTietNhap"];
            }
            set { ViewState["ChiTietNhap"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
                if (Request.QueryString["id"] != null)
                {
                    string maMay = Request.QueryString["id"];
                    if (ddlSanPham.Items.FindByValue(maMay) != null)
                    {
                        ddlSanPham.SelectedValue = maMay;
                        txtGiaNhap.Focus();
                    }
                }
            }
        }

        private void LoadData()
        {
            DataTable dtNPP = DBConnect.GetData("sp_LayNhaPhanPhoi", null, true);
            ddlNPP.DataSource = dtNPP;
            ddlNPP.DataTextField = "TenNPP";
            ddlNPP.DataValueField = "MaNPP";
            ddlNPP.DataBind();

            LoadSanPham();

            DataTable dtTH = DBConnect.GetData("sp_LayThuongHieu", null, true);
            ddlNewThuongHieu.DataSource = dtTH;
            ddlNewThuongHieu.DataTextField = "TenTH";
            ddlNewThuongHieu.DataValueField = "MaTH";
            ddlNewThuongHieu.DataBind();
        }

        private void LoadSanPham()
        {
            DataTable dtSP = DBConnect.GetData("sp_LayDanhSachMayTinh_DonGian", null, true);
            ddlSanPham.DataSource = dtSP;
            ddlSanPham.DataTextField = "TenMay";
            ddlSanPham.DataValueField = "MaMay";
            ddlSanPham.DataBind();
            ddlSanPham.Items.Insert(0, new ListItem("-- Chọn sản phẩm --", "0"));
        }

        // --- BƯỚC 1: XỬ LÝ KHI BẤM NÚT THÊM ---
        protected void btnThemSP_Click(object sender, EventArgs e)
        {
            litThongBao.Text = "";
            int maMay = int.Parse(ddlSanPham.SelectedValue);
            if (maMay == 0) { litThongBao.Text = "<div class='alert alert-danger'>Vui lòng chọn sản phẩm!</div>"; return; }

            int soLuong;
            if (!int.TryParse(txtSoLuong.Text, out soLuong) || soLuong <= 0) { litThongBao.Text = "<div class='alert alert-danger'>Số lượng phải > 0</div>"; return; }

            decimal giaNhap;
            if (!decimal.TryParse(txtGiaNhap.Text, out giaNhap) || giaNhap < 0) { litThongBao.Text = "<div class='alert alert-danger'>Giá nhập không hợp lệ</div>"; return; }

            // Lấy giá bán hiện tại để so sánh
            decimal giaBanHienTai = 0;
            string tenMay = ddlSanPham.SelectedItem.Text;
            DataRow rowInfo = DBConnect.GetOneRow("SELECT GiaBan FROM MayTinh WHERE MaMay=" + maMay);
            if (rowInfo != null) giaBanHienTai = Convert.ToDecimal(rowInfo["GiaBan"]);

            // ==> LOGIC CẢNH BÁO
            if (giaNhap >= giaBanHienTai)
            {
                // Lưu tạm vào HiddenField
                hfTempMaMay.Value = maMay.ToString();
                hfTempTenMay.Value = tenMay;
                hfTempSoLuong.Value = soLuong.ToString();
                hfTempGiaNhap.Value = giaNhap.ToString();

                // Hiển thị thông tin lên Modal Cảnh Báo
                lblConfirmTen.Text = tenMay;
                lblConfirmGiaNhap.Text = giaNhap.ToString("N0") + "đ";
                lblConfirmGiaBan.Text = giaBanHienTai.ToString("N0") + "đ";
                lblConfirmLai.Text = ddlTiLeLai.SelectedValue + "%";

                // Mở Modal (dùng JS)
                ScriptManager.RegisterStartupScript(this, GetType(), "Confirm", "openConfirmModal();", true);
            }
            else
            {
                // Giá an toàn -> Thêm luôn (Giá mới = 0 vì không cần update)
                ThemSanPhamVaoLuoi(maMay, tenMay, soLuong, giaNhap, 0);
            }
        }

        // --- BƯỚC 2A: NGƯỜI DÙNG CHỌN ĐỒNG Ý CẬP NHẬT GIÁ ---
        protected void btnDongYUpdate_Click(object sender, EventArgs e)
        {
            int maMay = int.Parse(hfTempMaMay.Value);
            string tenMay = hfTempTenMay.Value;
            int soLuong = int.Parse(hfTempSoLuong.Value);
            decimal giaNhap = decimal.Parse(hfTempGiaNhap.Value);
            int tiLe = int.Parse(ddlTiLeLai.SelectedValue);

            // Tính giá mới: Giá Nhập + % Lãi
            decimal giaBanMoi = giaNhap + (giaNhap * tiLe / 100);

            ThemSanPhamVaoLuoi(maMay, tenMay, soLuong, giaNhap, giaBanMoi);

            // Đóng modal thủ công bằng JS (vì đây là PostBack)
            ScriptManager.RegisterStartupScript(this, GetType(), "HideConf", "var m = bootstrap.Modal.getInstance(document.getElementById('modalConfirmPrice')); m.hide();", true);
        }

        // --- BƯỚC 2B: NGƯỜI DÙNG CHỌN GIỮ NGUYÊN GIÁ CŨ (CHẤP NHẬN BÁN LỖ) ---
        protected void btnBoQuaUpdate_Click(object sender, EventArgs e)
        {
            int maMay = int.Parse(hfTempMaMay.Value);
            string tenMay = hfTempTenMay.Value;
            int soLuong = int.Parse(hfTempSoLuong.Value);
            decimal giaNhap = decimal.Parse(hfTempGiaNhap.Value);

            ThemSanPhamVaoLuoi(maMay, tenMay, soLuong, giaNhap, 0); // 0 nghĩa là không update giá

            ScriptManager.RegisterStartupScript(this, GetType(), "HideConf", "var m = bootstrap.Modal.getInstance(document.getElementById('modalConfirmPrice')); m.hide();", true);
        }

        // --- HÀM CHUNG: THÊM VÀO DATATABLE ---
        private void ThemSanPhamVaoLuoi(int maMay, string tenMay, int soLuong, decimal giaNhap, decimal giaBanMoi)
        {
            decimal thanhTien = soLuong * giaNhap;
            DataTable dt = DtChiTiet;

            // Kiểm tra trùng -> Cộng dồn
            bool exists = false;
            foreach (DataRow row in dt.Rows)
            {
                if ((int)row["MaMay"] == maMay)
                {
                    row["SoLuong"] = (int)row["SoLuong"] + soLuong;
                    row["GiaNhap"] = giaNhap;
                    row["ThanhTien"] = (int)row["SoLuong"] * giaNhap;
                    // Nếu lần này có giá mới thì cập nhật đè lên
                    if (giaBanMoi > 0) row["GiaBanMoi"] = giaBanMoi;
                    exists = true;
                    break;
                }
            }

            if (!exists)
            {
                dt.Rows.Add(maMay, tenMay, soLuong, giaNhap, thanhTien, giaBanMoi);
            }

            DtChiTiet = dt;
            BindGrid();

            // Reset form
            txtSoLuong.Text = "1";
            txtGiaNhap.Text = "";
            txtGiaNhap.Focus();
        }

        // --- CÁC HÀM XỬ LÝ KHÁC (XÓA, TẠO MỚI, LƯU PHIẾU) ---
        protected void gvChiTietNhap_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Xoa")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                DataTable dt = DtChiTiet;
                if (index >= 0 && index < dt.Rows.Count)
                {
                    dt.Rows.RemoveAt(index);
                    DtChiTiet = dt;
                    BindGrid();
                }
            }
        }

        private void BindGrid()
        {
            DataTable dt = DtChiTiet;
            gvChiTietNhap.DataSource = dt;
            gvChiTietNhap.DataBind();

            decimal tongTien = 0;
            foreach (DataRow dr in dt.Rows) tongTien += Convert.ToDecimal(dr["ThanhTien"]);
            lblTongTien.Text = tongTien.ToString("N0") + "₫";
        }

        protected void btnLuuSanPhamMoi_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlParameter[] p = {
                    new SqlParameter("@TenMay", txtNewTenMay.Text.Trim()),
                    new SqlParameter("@MaTH", ddlNewThuongHieu.SelectedValue),
                    new SqlParameter("@CauHinh", txtNewCauHinh.Text.Trim()),
                    new SqlParameter("@GiaBan", txtNewGiaBan.Text.Trim()),
                    new SqlParameter("@HinhAnh", txtNewHinhAnh.Text.Trim())
                };
                object res = DBConnect.ExecuteScalar("sp_TaoMayTinhNhanh", p, true);
                if (res != null)
                {
                    LoadSanPham();
                    ddlSanPham.SelectedValue = res.ToString();
                    txtNewTenMay.Text = ""; txtNewCauHinh.Text = ""; txtNewGiaBan.Text = "";
                    ScriptManager.RegisterStartupScript(this, GetType(), "Close", "var m = bootstrap.Modal.getInstance(document.getElementById('productModal')); m.hide();", true);
                    txtGiaNhap.Focus();
                }
            }
        }

        protected void btnLuuPhieu_Click(object sender, EventArgs e)
        {
            DataTable dt = DtChiTiet;
            if (dt.Rows.Count == 0) { litThongBao.Text = "<div class='alert alert-danger'>Chưa có hàng!</div>"; return; }

            int maNPP = int.Parse(ddlNPP.SelectedValue);
            decimal tongTien = 0;
            foreach (DataRow dr in dt.Rows) tongTien += Convert.ToDecimal(dr["ThanhTien"]);

            // 1. Tạo Đơn
            SqlParameter[] pDon = { new SqlParameter("@MaNPP", maNPP), new SqlParameter("@TongTien", tongTien) };
            int maNhap = Convert.ToInt32(DBConnect.ExecuteScalar("sp_TaoDonNhap", pDon, true));

            // 2. Lưu Chi Tiết & Update Giá
            foreach (DataRow dr in dt.Rows)
            {
                int maMay = Convert.ToInt32(dr["MaMay"]);
                decimal giaBanMoi = Convert.ToDecimal(dr["GiaBanMoi"]);

                SqlParameter[] pCT = {
                    new SqlParameter("@MaNhap", maNhap), new SqlParameter("@MaMay", maMay),
                    new SqlParameter("@SoLuong", dr["SoLuong"]), new SqlParameter("@GiaNhap", dr["GiaNhap"])
                };
                DBConnect.Execute("sp_ThemChiTietNhap", pCT, true);

                if (giaBanMoi > 0)
                {
                    SqlParameter[] pUp = { new SqlParameter("@MaMay", maMay), new SqlParameter("@GiaBan", giaBanMoi) };
                    DBConnect.Execute("sp_CapNhatGiaBan", pUp, true);
                }
            }

            DtChiTiet = null;
            BindGrid();
            litThongBao.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "Success", "alert('Nhập kho thành công!'); window.location='QuanLySanPham.aspx';", true);
        }
    }
}