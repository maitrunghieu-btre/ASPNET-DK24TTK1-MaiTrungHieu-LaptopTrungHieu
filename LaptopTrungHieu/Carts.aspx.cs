using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Laptop
{
    // Đã đổi tên class thành Carts
    public partial class Carts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGioHang();
            }
        }

        private void LoadGioHang()
        {
            List<CartItem> cart = Session["GioHang"] as List<CartItem>;
            if (cart != null && cart.Count > 0)
            {
                pnlCoHang.Visible = true;
                pnlTrong.Visible = false;

                rptGioHang.DataSource = cart;
                rptGioHang.DataBind();

                TinhTongTien(cart);
            }
            else
            {
                pnlCoHang.Visible = false;
                pnlTrong.Visible = true;
            }
        }

        private void TinhTongTien(List<CartItem> cart)
        {
            decimal tong = cart.Sum(x => x.ThanhTien);
            lblTamTinh.Text = tong.ToString("N0") + "₫";
            lblTongTien.Text = tong.ToString("N0") + "₫";
        }

        // Xử lý thay đổi số lượng
        protected void txtSoLuong_TextChanged(object sender, EventArgs e)
        {
            TextBox txtQty = (TextBox)sender;
            RepeaterItem item = (RepeaterItem)txtQty.NamingContainer;
            HiddenField hfMaMay = (HiddenField)item.FindControl("hfMaMay");

            int maMay = int.Parse(hfMaMay.Value);
            int slMoi;

            List<CartItem> cart = Session["GioHang"] as List<CartItem>;

            if (int.TryParse(txtQty.Text, out slMoi))
            {
                var sp = cart.FirstOrDefault(x => x.MaMay == maMay);
                if (sp != null)
                {
                    sp.SoLuong = slMoi <= 0 ? 1 : slMoi;
                }
            }

            Session["GioHang"] = cart;
            LoadGioHang();
        }

        // Xử lý Xóa
        protected void rptGioHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Xoa")
            {
                int maMay = Convert.ToInt32(e.CommandArgument);
                List<CartItem> cart = Session["GioHang"] as List<CartItem>;

                var item = cart.FirstOrDefault(x => x.MaMay == maMay);
                if (item != null) cart.Remove(item);

                Session["GioHang"] = cart;
                LoadGioHang();
                Response.Redirect(Request.RawUrl);
            }
        }

        // Chuyển sang trang Thanh Toán (DatHang.aspx hoặc Checkout.aspx tùy bạn đặt)
        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx");
        }
    }
}