using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop.Admin
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComboboxHang();
                LoadDanhSachLaptop();
            }
        }

        // 1. Load Dropdown Hãng
        private void LoadComboboxHang()
        {
            DataTable dt = DBConnect.GetData("sp_LayThuongHieu", null, true);

            // Dropdown lọc (Thêm mục Tất cả)
            ddlFilterHang.DataSource = dt;
            ddlFilterHang.DataTextField = "TenTH";
            ddlFilterHang.DataValueField = "MaTH";
            ddlFilterHang.DataBind();
            ddlFilterHang.Items.Insert(0, new ListItem("-- Tất cả Hãng --", "0"));

            // Dropdown trong Modal sửa
            ddlHang.DataSource = dt;
            ddlHang.DataTextField = "TenTH";
            ddlHang.DataValueField = "MaTH";
            ddlHang.DataBind();
        }

        // 2. Load Danh Sách Máy Tính
        private void LoadDanhSachLaptop()
        {
            int maHang = int.Parse(ddlFilterHang.SelectedValue);
            string key = txtSearch.Text.Trim();

            int maxTon = -1;
            if (!string.IsNullOrEmpty(txtFilterTon.Text))
            {
                int.TryParse(txtFilterTon.Text, out maxTon);
            }

            SqlParameter[] p = {
                new SqlParameter("@MaTH", maHang),
                new SqlParameter("@TuKhoa", key),
                new SqlParameter("@MaxTon", maxTon)
            };

            DataTable dt = DBConnect.GetData("sp_QuanLyMayTinh_Filter", p, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                rptLaptop.DataSource = dt;
                rptLaptop.DataBind();
                lblThongBao.Visible = false;
            }
            else
            {
                rptLaptop.DataSource = null;
                rptLaptop.DataBind();
                lblThongBao.Visible = true;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadDanhSachLaptop();
        }

        protected void ddlFilterHang_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadDanhSachLaptop();
        }

        // 3. Xử lý Sự kiện (Sửa / Xóa)
        protected void rptLaptop_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int maMay = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteLap")
            {
                try
                {
                    // A. XÓA FILE ẢNH VẬT LÝ TRƯỚC KHI XÓA DB

                    // 1. Xóa ảnh đại diện & ảnh trong bài viết mô tả
                    DataRow row = DBConnect.GetOneRow("SELECT HinhAnh, MoTa FROM MayTinh WHERE MaMay=" + maMay);
                    if (row != null)
                    {
                        DeleteFile(row["HinhAnh"].ToString());
                        DeleteImagesInHtml(row["MoTa"].ToString());
                    }

                    // 2. Xóa ảnh trong Thư viện ảnh (Albums)
                    DataTable dtAlbum = DBConnect.GetData("SELECT DuongDan FROM ThuVienAnh WHERE MaMay=" + maMay);
                    if (dtAlbum != null)
                    {
                        foreach (DataRow dr in dtAlbum.Rows) DeleteFile(dr["DuongDan"].ToString());
                    }

                    // B. XÓA DỮ LIỆU TRONG DB (Các bảng con tự xóa do Cascade hoặc xử lý trong SP)
                    SqlParameter[] p = { new SqlParameter("@MaMay", maMay) };
                    object result = DBConnect.ExecuteScalar("sp_XoaMayTinh", p, true);

                    if (Convert.ToInt32(result) == 1)
                    {
                        LoadDanhSachLaptop();
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Đã xóa sản phẩm và dọn dẹp hình ảnh thành công!');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Không thể xóa! Máy này đang có đơn hàng.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Lỗi: {ex.Message}');", true);
                }
            }
            else if (e.CommandName == "EditLap")
            {
                // LOAD DỮ LIỆU LÊN MODAL
                DataRow row = DBConnect.GetOneRow("SELECT * FROM MayTinh WHERE MaMay=" + maMay);
                if (row != null)
                {
                    hfMaMay.Value = maMay.ToString();
                    txtTenMay.Text = row["TenMay"].ToString();
                    ddlHang.SelectedValue = row["MaTH"].ToString();
                    txtGiaBan.Text = Convert.ToInt64(row["GiaBan"]).ToString();
                    txtTonKho.Text = row["TonKho"].ToString();
                    txtCauHinh.Text = row["CauHinh"].ToString();
                    txtMoTa.Text = row["MoTa"].ToString();

                    string oldImg = row["HinhAnh"].ToString();
                    hfOldImage.Value = oldImg;
                    imgPreview.ImageUrl = "~/Images/Products/" + oldImg;
                    imgPreview.Visible = true;

                    // JavaScript để mở Modal và đổi tiêu đề
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "document.getElementById('modalTitle').innerText='CẬP NHẬT SẢN PHẨM'; showModalServer();", true);
                }
            }
        }

        // 4. Xử lý Lưu (Thêm mới / Cập nhật)
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int maMay = Convert.ToInt32(hfMaMay.Value); // 0 là thêm mới, >0 là sửa
            string tenMay = txtTenMay.Text.Trim();
            int maTH = Convert.ToInt32(ddlHang.SelectedValue);
            decimal giaBan = string.IsNullOrEmpty(txtGiaBan.Text) ? 0 : Convert.ToDecimal(txtGiaBan.Text);
            string cauHinh = txtCauHinh.Text;
            string moTa = txtMoTa.Text;

            // Xử lý ảnh đại diện
            string hinhAnh = hfOldImage.Value; // Giữ ảnh cũ
            if (fuHinhAnh.HasFile)
            {
                // Nếu có ảnh mới -> Xóa ảnh cũ (trừ ảnh mặc định) -> Up ảnh mới
                if (!string.IsNullOrEmpty(hinhAnh) && hinhAnh != "no-image.png") DeleteFile(hinhAnh);
                hinhAnh = UploadFile(fuHinhAnh);
            }
            if (string.IsNullOrEmpty(hinhAnh)) hinhAnh = "no-image.png";

            if (maMay == 0)
            {
                // --- THÊM MỚI ---
                SqlParameter[] p = {
                    new SqlParameter("@TenMay", tenMay),
                    new SqlParameter("@CauHinh", cauHinh),
                    new SqlParameter("@MaTH", maTH),
                    new SqlParameter("@GiaBan", giaBan),
                    new SqlParameter("@HinhAnh", hinhAnh),
                    new SqlParameter("@MoTa", moTa)
                };

                // SP sp_ThemMayTinh trả về ID mới tạo (SELECT SCOPE_IDENTITY)
                object newId = DBConnect.ExecuteScalar("sp_ThemMayTinh", p, true);
                maMay = Convert.ToInt32(newId);
            }
            else
            {
                // --- CẬP NHẬT ---
                SqlParameter[] p = {
                    new SqlParameter("@MaMay", maMay),
                    new SqlParameter("@TenMay", tenMay),
                    new SqlParameter("@CauHinh", cauHinh),
                    new SqlParameter("@MaTH", maTH),
                    new SqlParameter("@GiaBan", giaBan),
                    new SqlParameter("@HinhAnh", hinhAnh),
                    new SqlParameter("@MoTa", moTa)
                };
                DBConnect.Execute("sp_CapNhatMayTinh", p, true);
            }

            // Xử lý Thư viện ảnh (Album) - Upload nhiều file
            if (fuAlbum.HasFiles)
            {
                foreach (HttpPostedFile uploadedFile in fuAlbum.PostedFiles)
                {
                    // Upload file vật lý
                    string albumFileName = DateTime.Now.Ticks.ToString() + "_album_" + uploadedFile.FileName;
                    string savePath = Server.MapPath("~/Images/Products/") + albumFileName;
                    uploadedFile.SaveAs(savePath);

                    // Lưu vào DB (Bảng ThuVienAnh)
                    SqlParameter[] pAlbum = {
                        new SqlParameter("@MaMay", maMay),
                        new SqlParameter("@DuongDan", albumFileName)
                    };
                    DBConnect.Execute("sp_ThemThuVienAnh", pAlbum, true);
                }
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Lưu dữ liệu thành công!'); closeProductModal();", true);
            LoadDanhSachLaptop();
        }

        // --- CÁC HÀM HỖ TRỢ XỬ LÝ FILE ---

        private string UploadFile(FileUpload fu)
        {
            if (fu.HasFile)
            {
                try
                {
                    // Tạo tên file ngẫu nhiên theo thời gian để tránh trùng
                    string fileName = DateTime.Now.Ticks.ToString() + "_" + fu.FileName;
                    string filePath = Server.MapPath("~/Images/Products/") + fileName;

                    // Kiểm tra thư mục tồn tại chưa
                    string dir = Server.MapPath("~/Images/Products/");
                    if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);

                    fu.SaveAs(filePath);
                    return fileName;
                }
                catch { }
            }
            return "";
        }

        private void DeleteFile(string fileName)
        {
            if (!string.IsNullOrEmpty(fileName) && fileName != "no-image.png")
            {
                try
                {
                    string filePath = Server.MapPath("~/Images/Products/") + fileName;
                    if (File.Exists(filePath)) File.Delete(filePath);
                }
                catch { }
            }
        }

        // Hàm xóa ảnh trong nội dung HTML (CKEditor) bằng Regex
        private void DeleteImagesInHtml(string htmlContent)
        {
            if (string.IsNullOrEmpty(htmlContent)) return;

            // Regex tìm tất cả thẻ <img src="...">
            string pattern = "<img.+?src=[\"'](.+?)[\"'].*?>";
            foreach (Match match in Regex.Matches(htmlContent, pattern, RegexOptions.IgnoreCase))
            {
                string src = match.Groups[1].Value;
                // Chỉ xóa ảnh nằm trong thư mục Products của mình
                if (src.Contains("/Images/Products/"))
                {
                    string fileName = Path.GetFileName(src);
                    DeleteFile(fileName);
                }
            }
        }
    }
}