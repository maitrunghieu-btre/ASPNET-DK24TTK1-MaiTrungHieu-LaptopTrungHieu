using System;

namespace Laptop
{
    // Class đại diện cho một sản phẩm trong giỏ hàng
    [Serializable]
    public class CartItem
    {
        public int MaMay { get; set; }      // Mã máy (Đã đổi từ MaLap -> MaMay theo CSDL mới)
        public string TenMay { get; set; }  // Tên máy
        public string HinhAnh { get; set; } // Ảnh đại diện
        public decimal GiaBan { get; set; } // Giá bán
        public int SoLuong { get; set; }    // Số lượng khách mua

        // Thành tiền = Giá * Số lượng
        public decimal ThanhTien
        {
            get { return GiaBan * SoLuong; }
        }

        public CartItem() { }

        public CartItem(int maMay, string tenMay, string hinhAnh, decimal giaBan, int soLuong)
        {
            this.MaMay = maMay;
            this.TenMay = tenMay;
            this.HinhAnh = hinhAnh;
            this.GiaBan = giaBan;
            this.SoLuong = soLuong;
        }
    }
}