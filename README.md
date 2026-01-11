# 💻 Đồ án: Website Bán Laptop Trung Hiếu

Hệ thống quản lý và bán hàng Laptop trực tuyến được xây dựng bằng công nghệ ASP.NET Web Forms, tối ưu hóa quy trình kho vận và quản trị đơn hàng.



## 🛠 Công nghệ sử dụng
* **Ngôn ngữ:** C# (ASP.NET Framework 4.8)
* **Cơ sở dữ liệu:** SQL Server (sử dụng Stored Procedures, Triggers, Views)
* **Giao diện:** Bootstrap 5 (Responsive), FontAwesome 6
* **Công cụ soạn thảo:** CKEditor 4 Full Package

## 🚀 Tính năng nổi bật
* **Quản lý kho tự động:** Tự động cập nhật tồn kho thông qua Trigger khi Nhập/Bán/Hủy đơn.
* **Quản trị chuyên sâu:** Admin quản lý Sản phẩm (kèm Album ảnh), Banner quảng cáo và Đơn hàng.
* **Báo cáo thông minh:** Thống kê doanh thu thực tế và cảnh báo sản phẩm sắp hết hàng qua View.
* **Trải nghiệm người dùng:** Giỏ hàng tiện lợi, tự động điền thông tin thanh toán cho thành viên.

## 📂 Cấu trúc Cơ sở dữ liệu
Dự án bao gồm các bảng chính:
* `MayTinh`: Lưu thông tin sản phẩm và cấu hình.
* `DonDatHang` & `ChiTietDon`: Quản lý giao dịch bán hàng.
* `DonNhap` & `ChiTietNhap`: Quản lý nhập hàng từ nhà cung cấp.
* `NguoiDung`: Phân quyền Admin và Khách hàng.
* `Banner`: Quản lý hình ảnh quảng cáo trang chủ.

## 📝 Hướng dẫn cài đặt
1.  **Clone dự án:** Tải mã nguồn từ GitHub về máy cá nhân.
2.  **Thiết lập Cơ sở dữ liệu:**
    * Mở SQL Server Management Studio (SSMS).
    * Mở file `SQL.sql` đính kèm trong thư mục dự án.
    * Chạy (Execute) toàn bộ kịch bản để tạo Database, Table, Trigger và dữ liệu mẫu.
3.  **Cấu hình kết nối:** * Mở file `web.config` trong Visual Studio.
    * Sửa chuỗi `connectionString` cho phù hợp với Server của bạn.
4.  **Chạy dự án:** Nhấn **F5** trong Visual Studio 2022 để khởi chạy.

## 👤 Thông tin thực hiện
* **Mã sv:** 170124062
* **Sinh viên:** Mai Trung Hiếu
* **Lớp:** DK24TTK1
