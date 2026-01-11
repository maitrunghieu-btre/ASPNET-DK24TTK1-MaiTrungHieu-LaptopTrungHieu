<%@ Page Title="Tổng quan hệ thống" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Laptop.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Card thống kê với hiệu ứng Gradient */
        .stat-card {
            border-radius: 12px;
            padding: 25px;
            color: white;
            position: relative;
            overflow: hidden;
            height: 100%;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .stat-card:hover { transform: translateY(-5px); }
        
        .stat-card h3 { font-size: 2.2rem; font-weight: 800; margin: 0; }
        .stat-card p { font-size: 1rem; font-weight: 500; margin: 0; opacity: 0.9; text-transform: uppercase; letter-spacing: 1px; }
        .stat-card .icon-bg {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 4.5rem;
            opacity: 0.15;
        }

        /* Màu sắc từng thẻ */
        .bg-gradient-1 { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); } /* Tím xanh */
        .bg-gradient-2 { background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%, #feada6 100%); color: #fff; } /* Hồng phấn (Option 1) */
        .bg-gradient-2-fix { background: linear-gradient(135deg, #ff6a00 0%, #ee0979 100%); } /* Cam đỏ */
        .bg-gradient-3 { background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%); } /* Xanh dương */
        .bg-gradient-4 { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); } /* Xanh lá */
        
        .welcome-card {
            background: #fff; border: none; border-radius: 10px;
            border-left: 5px solid #007bff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-gauge-high me-2 text-primary"></i>TỔNG QUAN (DASHBOARD)
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="row g-4 mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="stat-card bg-gradient-1">
                <p>Doanh thu</p>
                <h3><asp:Label ID="lblDoanhThu" runat="server">0</asp:Label></h3>
                <i class="fa-solid fa-sack-dollar icon-bg"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="stat-card bg-gradient-2-fix">
                <p>Đơn chờ duyệt</p>
                <h3><asp:Label ID="lblDonMoi" runat="server">0</asp:Label></h3>
                <i class="fa-solid fa-bell icon-bg"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="stat-card bg-gradient-3">
                <p>Khách hàng</p>
                <h3><asp:Label ID="lblKhachHang" runat="server">0</asp:Label></h3>
                <i class="fa-solid fa-users icon-bg"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6">
            <div class="stat-card bg-gradient-4">
                <p>Sản phẩm</p>
                <h3><asp:Label ID="lblSanPham" runat="server">0</asp:Label></h3>
                <i class="fa-solid fa-laptop icon-bg"></i>
            </div>
        </div>
    </div>

    <div class="card welcome-card shadow-sm p-4 mb-4">
        <h4 class="fw-bold text-dark">Chào mừng trở lại, Quản trị viên!</h4>
        <p class="text-muted">Hệ thống quản trị Laptop Trung Hiếu đang hoạt động ổn định.</p>
        <hr />
        <p class="mb-2 fw-bold">Thao tác nhanh:</p>
        <div class="d-flex gap-3 flex-wrap">
            <a href="QuanLyDonHang.aspx" class="btn btn-outline-primary"><i class="fa-solid fa-list-check me-2"></i>Duyệt đơn hàng</a>
            <a href="QuanLySanPham.aspx" class="btn btn-outline-success"><i class="fa-solid fa-plus me-2"></i>Thêm máy mới</a>
            <a href="QuanLyNguoiDung.aspx" class="btn btn-outline-info"><i class="fa-solid fa-user-gear me-2"></i>Xem khách hàng</a>
        </div>
    </div>

</asp:Content>