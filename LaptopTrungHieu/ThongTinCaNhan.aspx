<%@ Page Title="Thông tin cá nhân" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThongTinCaNhan.aspx.cs" Inherits="Laptop.ThongTinCaNhan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-card { max-width: 800px; margin: 40px auto; padding: 30px; background: #fff; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); border-top: 5px solid #ff6600; }
        .profile-header { text-align: center; margin-bottom: 30px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .profile-header i { font-size: 3rem; color: #ff6600; margin-bottom: 10px; }
        .profile-header h4 { font-weight: 700; color: #333; }
        .form-control:focus { border-color: #ff6600; box-shadow: 0 0 0 0.2rem rgba(255, 102, 0, 0.25); }
        .btn-update { background: linear-gradient(135deg, #ff6600 0%, #ff4500 100%); color: #fff; font-weight: 700; padding: 10px 25px; border: none; transition: 0.3s; width: 100%; border-radius: 5px;}
        .btn-update:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 69, 0, 0.3); color: #fff; }
        .password-section { margin-top: 40px; padding-top: 30px; border-top: 1px dashed #ddd; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="profile-card">
            
            <div class="profile-header">
                <i class="fa-solid fa-user-gear"></i>
                <h4>Quản lý hồ sơ</h4>
            </div>

            <asp:Panel ID="pnlProfile" runat="server">
                <h5 class="mb-3 text-secondary"><i class="fa-solid fa-user me-2"></i> Thông tin cơ bản</h5>
                <asp:Label ID="lblThongBaoProfile" runat="server" CssClass="d-block mb-3 text-center"></asp:Label>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Họ tên (*)</label>
                        <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvHoTen" runat="server" ControlToValidate="txtHoTen" ErrorMessage="Nhập họ tên" CssClass="text-danger small" Display="Dynamic" ValidationGroup="ProfileGroup" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Số điện thoại (*)</label>
                        <asp:TextBox ID="txtSoDT" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSDT" runat="server" ControlToValidate="txtSoDT" ErrorMessage="Nhập SĐT" CssClass="text-danger small" Display="Dynamic" ValidationGroup="ProfileGroup" />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="example@gmail.com"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Địa chỉ</label>
                    <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>
                
                <div class="mt-3 text-end">
                    <asp:Button ID="btnCapNhat" runat="server" Text="LƯU THÔNG TIN" CssClass="btn-update" OnClick="btnCapNhat_Click" ValidationGroup="ProfileGroup" />
                </div>
            </asp:Panel>
            
            <asp:Panel ID="pnlPassword" runat="server" CssClass="password-section">
                <h5 class="mb-3 text-secondary"><i class="fa-solid fa-lock me-2"></i> Đổi mật khẩu</h5>
                <asp:Label ID="lblThongBaoPassword" runat="server" CssClass="d-block mb-3 text-center"></asp:Label>

                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label class="form-label small">Mật khẩu cũ</label>
                        <asp:TextBox ID="txtMatKhauCu" runat="server" CssClass="form-control form-control-sm" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCu" runat="server" ControlToValidate="txtMatKhauCu" ErrorMessage="*" CssClass="text-danger" ValidationGroup="PasswordGroup" />
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="form-label small">Mật khẩu mới</label>
                        <asp:TextBox ID="txtMatKhauMoi" runat="server" CssClass="form-control form-control-sm" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMoi" runat="server" ControlToValidate="txtMatKhauMoi" ErrorMessage="*" CssClass="text-danger" ValidationGroup="PasswordGroup" />
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="form-label small">Xác nhận mới</label>
                        <asp:TextBox ID="txtXacNhanMoi" runat="server" CssClass="form-control form-control-sm" TextMode="Password"></asp:TextBox>
                        <asp:CompareValidator ID="cvXacNhan" runat="server" ControlToValidate="txtXacNhanMoi" ControlToCompare="txtMatKhauMoi" ErrorMessage="*" CssClass="text-danger" ValidationGroup="PasswordGroup" />
                    </div>
                </div>
                
                <div class="mt-2 text-center">
                    <asp:Button ID="btnDoiMatKhau" runat="server" Text="ĐỔI MẬT KHẨU" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnDoiMatKhau_Click" ValidationGroup="PasswordGroup" />
                </div>
            </asp:Panel>
            
            <asp:Panel ID="pnlChuaLogin" runat="server" Visible="false" CssClass="text-center py-4">
                <p class="text-muted">Bạn cần đăng nhập để xem thông tin cá nhân.</p>
                <a href="Login.aspx" class="btn btn-outline-primary">Đăng nhập ngay</a>
            </asp:Panel>
        </div>
    </div>
</asp:Content>