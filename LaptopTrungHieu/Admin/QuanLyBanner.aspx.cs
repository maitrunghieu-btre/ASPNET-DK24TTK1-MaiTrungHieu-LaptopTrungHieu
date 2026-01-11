using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Laptop.Admin
{
    public partial class QuanLyBanner : System.Web.UI.Page
    {
        // Định nghĩa đường dẫn lưu trữ tập trung để dễ quản lý
        private readonly string uploadFolder = "~/Images/Banners/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDanhSachBanner();
            }
        }

        private void LoadDanhSachBanner()
        {
            gvBanner.DataSource = DBConnect.GetData("sp_QuanLyBanner_Filter", null, true);
            gvBanner.DataBind();
        }

        protected void gvBanner_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool hienThi = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "HienThi"));
                Label lbl = (Label)e.Row.FindControl("lblHienThi");
                if (lbl != null)
                {
                    lbl.Text = hienThi ? "ĐANG HIỆN" : "ĐANG ẨN";
                    lbl.CssClass += hienThi ? " bg-active" : " bg-hidden";
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            hfMaBanner.Value = "0"; txtTieuDe.Text = ""; txtLienKet.Text = "#";
            txtThuTu.Text = "0"; chkHienThi.Checked = true; divHinhHienTai.Visible = false;
            ltrModalTitle.Text = "<i class='fa-solid fa-plus me-1'></i> Thêm Banner mới";
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openEditModal();", true);
        }

        protected void gvBanner_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditBanner")
            {
                DataRow r = DBConnect.GetOneRow("SELECT * FROM Banner WHERE MaBanner = " + id);
                if (r != null)
                {
                    hfMaBanner.Value = id.ToString();
                    txtTieuDe.Text = r["TieuDe"].ToString();
                    txtLienKet.Text = r["LienKet"].ToString();
                    txtThuTu.Text = r["ThuTu"].ToString();
                    chkHienThi.Checked = Convert.ToBoolean(r["HienThi"]);

                    // Cập nhật đường dẫn ảnh xem trước trong Modal
                    imgHienTai.ImageUrl = uploadFolder + r["HinhAnh"].ToString();
                    divHinhHienTai.Visible = true;

                    ltrModalTitle.Text = "<i class='fa-solid fa-pen-to-square me-1'></i> Chỉnh sửa Banner";
                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenModal", "openEditModal();", true);
                }
            }
            else if (e.CommandName == "DeleteBanner")
            {
                DBConnect.Execute("DELETE FROM Banner WHERE MaBanner = " + id);
                LoadDanhSachBanner();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfMaBanner.Value);
            string hinhAnh = "";

            if (string.IsNullOrEmpty(txtTieuDe.Text.Trim()))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Vui lòng nhập tiêu đề!');", true);
                return;
            }

            // Xử lý Upload file vào thư mục Images/Banners
            if (fuHinhAnh.HasFile)
            {
                // Kiểm tra và tạo thư mục nếu chưa tồn tại
                string physicalPath = Server.MapPath(uploadFolder);
                if (!Directory.Exists(physicalPath)) Directory.CreateDirectory(physicalPath);

                string ext = Path.GetExtension(fuHinhAnh.FileName);
                hinhAnh = "banner_" + DateTime.Now.Ticks + ext;
                fuHinhAnh.SaveAs(physicalPath + hinhAnh);
            }
            else
            {
                if (id == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Vui lòng chọn ảnh!');", true);
                    return;
                }
                else
                {
                    DataRow r = DBConnect.GetOneRow("SELECT HinhAnh FROM Banner WHERE MaBanner = " + id);
                    hinhAnh = r["HinhAnh"].ToString();
                }
            }

            SqlParameter[] p = {
                new SqlParameter("@MaBanner", id),
                new SqlParameter("@HinhAnh", hinhAnh),
                new SqlParameter("@TieuDe", txtTieuDe.Text.Trim()),
                new SqlParameter("@LienKet", txtLienKet.Text.Trim()),
                new SqlParameter("@ThuTu", int.Parse(txtThuTu.Text)),
                new SqlParameter("@HienThi", chkHienThi.Checked)
            };

            DBConnect.Execute("sp_LuuBanner", p, true);
            LoadDanhSachBanner();
            ScriptManager.RegisterStartupScript(this, GetType(), "Success", "alert('Lưu thành công!'); var m = bootstrap.Modal.getInstance(document.getElementById('editBannerModal')); m.hide();", true);
        }
    }
}