<%@ Page Title="Thanh toán" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Laptop.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-box { background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); border: 1px solid #f0f0f0; }
        .step-title { font-weight: 800; color: #333; border-bottom: 2px solid #e9ecef; padding-bottom: 15px; margin-bottom: 25px; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-label { font-weight: 600; color: #555; margin-bottom: 8px; }
        .form-control { padding: 12px 15px; border-radius: 8px; border: 1px solid #dee2e6; transition: 0.3s; }
        .form-control:focus { border-color: var(--primary-color); box-shadow: 0 0 0 0.25rem rgba(0, 86, 179, 0.15); }
        
        .summary-box { background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 12px; padding: 25px; }
        .item-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 0.95rem; border-bottom: 1px dashed #dee2e6; padding-bottom: 15px; }
        .item-row:last-child { border-bottom: none; }
        .total-row { border-top: 2px solid var(--primary-color); margin-top: 20px; padding-top: 20px; display: flex; justify-content: space-between; align-items: center; }
        .total-price { font-size: 1.5rem; font-weight: 800; color: #d70018; }
        .btn-submit-order { background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%); color: #fff; font-size: 1.1rem; font-weight: 800; text-transform: uppercase; padding: 16px; border-radius: 8px; width: 100%; border: none; transition: 0.3s; box-shadow: 0 4px 15px rgba(0, 86, 179, 0.3); }
        .btn-submit-order:hover { background: linear-gradient(135deg, var(--primary-dark) 0%, #003366 100%); transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0, 86, 179, 0.4); color: #fff; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h2 class="mb-5 fw-bold text-center text-uppercase text-primary">
            <i class="fa-solid fa-credit-card me-2"></i>Thanh toán & Giao hàng
        </h2>

        <div class="row g-4">
            <div class="col-lg-7">
                <div class="checkout-box h-100">
                    <h5 class="step-title"><i class="fa-solid fa-user-pen me-2 text-primary"></i>1. Thông tin người nhận</h5>
                    
                    <asp:HiddenField ID="hfMaND" runat="server" />
                    <asp:HiddenField ID="hfIsNew" runat="server" Value="true" />

                    <div class="mb-3">
                        <label class="form-label fw-bold">Số điện thoại (*)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-mobile-screen"></i></span>
                            
                            <asp:TextBox ID="txtSoDT" runat="server" CssClass="form-control" 
                                placeholder="Nhập SĐT rồi click ra ngoài..." autocomplete="off"
                                AutoPostBack="true" OnTextChanged="txtSoDT_TextChanged"
                                CausesValidation="false"></asp:TextBox>
                        </div>
                        <div class="form-text text-muted small"><i class="fa-solid fa-circle-info"></i> Nhập SĐT để hệ thống tự điền thông tin cũ.</div>
                    </div>

                    <asp:Label ID="lblThongBao" runat="server"></asp:Label>

                    <div class="row g-3 mt-1">
                        <div class="col-12">
                            <label class="form-label fw-bold">Họ và tên (*)</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nguyễn Văn A"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvHoTen" runat="server" ControlToValidate="txtHoTen" 
                                ErrorMessage="Chưa nhập họ tên" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        
                        <div class="col-12">
                            <label class="form-label fw-bold">Địa chỉ giao hàng (*)</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Số nhà, đường, xã/phường..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDiaChi" runat="server" ControlToValidate="txtDiaChi" 
                                ErrorMessage="Chưa nhập địa chỉ" CssClass="text-danger small" Display="Dynamic" />
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold">Email (Tùy chọn)</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="email@example.com"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold">Ghi chú (Tùy chọn)</label>
                            <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Lời nhắn cho shipper..."></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="summary-box sticky-top" style="top: 100px; z-index: 10;">
                    <h5 class="step-title"><i class="fa-solid fa-bag-shopping me-2 text-primary"></i>2. Đơn hàng</h5>
                    
                    <div style="max-height: 350px; overflow-y: auto;">
                        <asp:Repeater ID="rptTomTat" runat="server">
                            <ItemTemplate>
                                <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                                    <div class="d-flex align-items-center">
                                        <div class="position-relative me-3">
                                            <img src='<%# ResolveUrl("~/Images/Products/" + Eval("HinhAnh")) %>' style="width: 50px; height: 50px; object-fit: contain; border: 1px solid #ddd; border-radius: 4px;" onerror="this.src='<%= ResolveUrl("~/Images/no-image.png") %>';">
                                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary"><%# Eval("SoLuong") %></span>
                                        </div>
                                        <div><div class="fw-bold text-dark small"><%# Eval("TenMay") %></div></div>
                                    </div>
                                    <div class="fw-bold text-primary small"><%# Convert.ToDecimal(Eval("ThanhTien")).ToString("N0") %>₫</div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top border-2 border-primary">
                        <span class="fs-5 fw-bold text-dark">TỔNG CỘNG:</span>
                        <asp:Label ID="lblTongTien" runat="server" CssClass="total-price"></asp:Label>
                    </div>

                    <div class="alert alert-light border mt-3 small">
                        <i class="fa-solid fa-truck-fast text-success me-1"></i> Miễn phí vận chuyển<br>
                        <i class="fa-solid fa-wallet text-primary me-1"></i> Thanh toán khi nhận hàng (COD)
                    </div>

                    <asp:Button ID="btnHoanTat" runat="server" Text="ĐẶT HÀNG NGAY" CssClass="btn-submit-order mt-2" 
                        OnClick="btnHoanTat_Click" />
                    
                    <div class="text-center mt-3">
                        <a href="Carts.aspx" class="text-decoration-none text-muted small"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại giỏ hàng</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>