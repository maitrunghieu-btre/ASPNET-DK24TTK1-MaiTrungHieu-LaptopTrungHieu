using System;
using System.Data;
using System.Web.UI;

namespace Laptop.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadThongKe();
            }
        }

        private void LoadThongKe()
        {
            try
            {
                // Gọi SP trả về 1 dòng duy nhất chứa cả 4 chỉ số
                // Tham số thứ 3 là isProcedure = true
                DataRow row = DBConnect.GetOneRow("sp_ThongKeDashboard", null, true);

                if (row != null)
                {
                    // 1. Doanh thu
                    decimal dt = Convert.ToDecimal(row["DoanhThu"]);
                    if (dt >= 1000000000)
                        lblDoanhThu.Text = (dt / 1000000000).ToString("0.##") + " tỷ";
                    else if (dt >= 1000000)
                        lblDoanhThu.Text = (dt / 1000000).ToString("0.##") + " tr";
                    else
                        lblDoanhThu.Text = dt.ToString("N0") + "đ";

                    // 2. Các chỉ số còn lại
                    lblDonMoi.Text = row["DonMoi"].ToString();
                    lblKhachHang.Text = row["KhachHang"].ToString();
                    lblSanPham.Text = row["SanPham"].ToString();
                }
            }
            catch (Exception)
            {
                // Bỏ khai báo biến 'ex' để tránh cảnh báo "declared but never used"
                lblDoanhThu.Text = "0";
                lblDonMoi.Text = "0";
                lblKhachHang.Text = "0";
                lblSanPham.Text = "0";
            }
        }
    }
}