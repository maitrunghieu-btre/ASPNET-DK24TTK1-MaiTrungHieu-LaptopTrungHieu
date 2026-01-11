<%@ Page Title="Đăng ký tài khoản" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Laptop.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .register-container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
        }
        .register-title {
            font-weight: 800;
            color: var(--primary-color);
            text-transform: uppercase;
            text-align: center;
            margin-bottom: 30px;
            letter-spacing: 1px;
        }
        .form-label { font-weight: 600; color: #555; font-size: 0.9rem; }
        .form-control { height: 45px; border-radius: 8px; padding-left: 15px; border: 1px solid #e1e1e1; }
        .form-control:focus { border-color: var(--primary-color); box-shadow: 0 0 0 0.2rem rgba(0, 86, 179, 0.15); }
        
        .btn-register {
            width: 100%; height: 50px;
            background: linear-gradient(135deg, #00b09b, #96c93d); 
            color: #fff; font-weight: 700; border: none; border-radius: 8px;
            text-transform: uppercase; transition: 0.3s; margin-top: 20px; font-size: 1.1rem;
        }
        .btn-register:hover {
            transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,176,155,0.3); color: #fff;
            background: linear-gradient(135deg, #009987, #85b533);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="register-container">
            <h3 class="register-title"><i class="fa-solid fa-user-plus me-2"></i>Đăng Ký Tài Khoản</h3>
            
            <asp:Panel ID="pnlRegister" runat="server" DefaultButton="btnRegister">
                <asp:Label ID="lblThongBao" runat="server"></asp:Label>

                <div class="mb-3">
                    <label class="form-label">Họ và tên (*)</label>
                    <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Ví dụ: Nguyễn Văn A" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvHoTen" runat="server" ControlToValidate="txtHoTen" ErrorMessage="Vui lòng nhập họ tên" CssClass="text-danger small fw-bold" Display="Dynamic" />
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Số điện thoại (*)</label>
                        <asp:TextBox ID="txtSoDT" runat="server" CssClass="form-control" placeholder="Không được trùng!" autocomplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSDT" runat="server" ControlToValidate="txtSoDT" ErrorMessage="Vui lòng nhập SĐT" CssClass="text-danger small fw-bold" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revSDT" runat="server" ControlToValidate="txtSoDT" ValidationExpression="^0\d{9}$" ErrorMessage="SĐT không hợp lệ (cần 10 số)" CssClass="text-danger small" Display="Dynamic" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email (Tùy chọn)</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="email@example.com" autocomplete="off"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email không đúng định dạng" CssClass="text-danger small" Display="Dynamic" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Mật khẩu (*)</label>
                        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" placeholder="Nhập mật khẩu..." autocomplete="new-password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMK" runat="server" ControlToValidate="txtMatKhau" ErrorMessage="Vui lòng nhập mật khẩu" CssClass="text-danger small fw-bold" Display="Dynamic" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Xác nhận mật khẩu (*)</label>
                        <asp:TextBox ID="txtNhapLaiMK" runat="server" CssClass="form-control" TextMode="Password" placeholder="Nhập lại mật khẩu..." autocomplete="new-password"></asp:TextBox>
                        <asp:CompareValidator ID="cvMK" runat="server" ControlToValidate="txtNhapLaiMK" ControlToCompare="txtMatKhau" ErrorMessage="Mật khẩu không khớp" CssClass="text-danger small fw-bold" Display="Dynamic" />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Địa chỉ (Tùy chọn)</label>
                    <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Nhập địa chỉ giao hàng mặc định..." autocomplete="off"></asp:TextBox>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Đăng Ký Ngay" CssClass="btn btn-register shadow-sm" OnClick="btnRegister_Click" />
            </asp:Panel>

            <div class="text-center mt-4 pt-3 border-top">
                <p class="text-muted mb-2">Bạn đã có tài khoản?</p>
                <a href="Login.aspx" class="text-primary fw-bold text-decoration-none fs-6">
                    <i class="fa-solid fa-arrow-right-to-bracket me-1"></i> Đăng nhập tại đây
                </a>
            </div>
        </div>
    </div>
</asp:Content>