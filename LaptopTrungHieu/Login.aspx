<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Laptop.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .login-container {
            max-width: 450px;
            margin: 50px auto;
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .login-title {
            font-weight: 800;
            color: var(--primary-color);
            text-transform: uppercase;
            text-align: center;
            margin-bottom: 30px;
        }
        .form-control {
            height: 48px;
            border-radius: 8px;
            padding-left: 15px;
        }
        .btn-login {
            width: 100%;
            height: 48px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: #fff;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            text-transform: uppercase;
            transition: 0.3s;
            margin-top: 10px;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,86,179,0.3);
            color: #fff;
        }
        .divider {
            height: 1px;
            background: #eee;
            margin: 25px 0;
            position: relative;
        }
        .divider span {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 0 10px;
            color: #999;
            font-size: 0.85rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="login-container">
            <h3 class="login-title">Đăng Nhập</h3>
            
            <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnLogin">
                <asp:Label ID="lblThongBao" runat="server"></asp:Label>

                <div class="mb-3">
                    <label class="form-label fw-bold text-muted">Email hoặc Số điện thoại</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-user"></i></span>
                        <asp:TextBox ID="txtTaiKhoan" runat="server" CssClass="form-control" placeholder="Nhập email hoặc SĐT..."></asp:TextBox>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold text-muted">Mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-lock"></i></span>
                        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" placeholder="Nhập mật khẩu..."></asp:TextBox>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4 small">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="chkNhoMatKhau">
                        <label class="form-check-label" for="chkNhoMatKhau">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="#" class="text-decoration-none">Quên mật khẩu?</a>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Đăng Nhập" CssClass="btn btn-login" OnClick="btnLogin_Click" />
            </asp:Panel>

            <div class="divider"><span>HOẶC</span></div>

            <div class="text-center">
                <p class="text-muted mb-2">Bạn chưa có tài khoản?</p>
                <a href="Register.aspx" class="btn btn-outline-primary w-100 fw-bold">ĐĂNG KÝ TÀI KHOẢN MỚI</a>
            </div>
        </div>
    </div>
</asp:Content>