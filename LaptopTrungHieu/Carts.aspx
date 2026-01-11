<%@ Page Title="Giỏ hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Carts.aspx.cs" Inherits="Laptop.Carts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-header { background: #f8f9fa; font-weight: 700; color: #555; text-transform: uppercase; font-size: 0.9rem; }
        .qty-input { width: 60px; text-align: center; border: 1px solid #ddd; border-radius: 4px; padding: 4px; font-weight: 600; color: #333; }
        .total-price { font-size: 1.5rem; color: #d70018; font-weight: 800; }
        .summary-card { border: 1px solid #eee; border-radius: 8px; background: #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        
        .btn-checkout { 
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%); 
            color: #fff; font-weight: 700; border: none; padding: 12px; border-radius: 6px; width: 100%; text-transform: uppercase; transition: 0.3s; 
        }
        .btn-checkout:hover { 
            background: linear-gradient(135deg, var(--primary-dark) 0%, #003366 100%); 
            color: #fff; transform: translateY(-2px); box-shadow: 0 4px 10px rgba(0, 86, 179, 0.3); 
        }
        
        .cart-img-wrap { width: 80px; height: 80px; border: 1px solid #eee; border-radius: 6px; display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #fff; }
        .cart-img-wrap img { max-height: 100%; max-width: 100%; object-fit: contain; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h2 class="mb-4 fw-bold text-uppercase border-start border-4 border-primary ps-3 text-primary">
            <i class="fa-solid fa-cart-shopping me-2"></i>Giỏ hàng của bạn
        </h2>

        <asp:Panel ID="pnlCoHang" runat="server">
            <div class="row">
                <div class="col-lg-8 mb-4">
                    <div class="table-responsive shadow-sm border rounded bg-white">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="cart-header">
                                <tr>
                                    <th class="py-3 ps-3">Sản phẩm</th>
                                    <th class="py-3 text-center">Đơn giá</th>
                                    <th class="py-3 text-center">Số lượng</th>
                                    <th class="py-3 text-end pe-3">Thành tiền</th>
                                    <th class="py-3 text-center"><i class="fa-solid fa-trash"></i></th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptGioHang" runat="server" OnItemCommand="rptGioHang_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="ps-3 py-3">
                                                <div class="d-flex align-items-center">
                                                    <div class="cart-img-wrap me-3">
                                                        <img src='<%# ResolveUrl("~/Images/Products/" + Eval("HinhAnh")) %>' onerror="this.src='<%= ResolveUrl("~/Images/no-image.png") %>';">
                                                    </div>
                                                    <div>
                                                        <a href='ChiTietSanPham.aspx?id=<%# Eval("MaMay") %>' class="fw-bold text-dark text-decoration-none"><%# Eval("TenMay") %></a>
                                                        <div class="small text-muted mt-1">Mã SP: <%# Eval("MaMay") %></div>
                                                    </div>
                                                </div>
                                                <asp:HiddenField ID="hfMaMay" runat="server" Value='<%# Eval("MaMay") %>' />
                                            </td>
                                            <td class="text-center fw-bold text-muted">
                                                <%# Convert.ToDecimal(Eval("GiaBan")).ToString("N0") %> đ
                                            </td>
                                            <td class="text-center">
                                                <asp:TextBox ID="txtSoLuong" runat="server" Text='<%# Eval("SoLuong") %>' 
                                                    CssClass="qty-input" TextMode="Number" min="1"
                                                    AutoPostBack="true" OnTextChanged="txtSoLuong_TextChanged">
                                                </asp:TextBox>
                                            </td>
                                            <td class="text-end pe-3 fw-bold text-danger">
                                                <%# Convert.ToDecimal(Eval("ThanhTien")).ToString("N0") %> đ
                                            </td>
                                            <td class="text-center">
                                                <asp:LinkButton ID="btnXoa" runat="server" CommandName="Xoa" CommandArgument='<%# Eval("MaMay") %>' 
                                                    CssClass="text-secondary" OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                                    <i class="fa-solid fa-xmark fs-5"></i>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="summary-card p-4 sticky-top" style="top: 90px; z-index: 1;">
                        <h5 class="fw-bold mb-3 border-bottom pb-2">Tổng cộng đơn hàng</h5>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted">Tạm tính:</span>
                            <span class="fw-bold"><asp:Label ID="lblTamTinh" runat="server"></asp:Label></span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="text-muted">Giảm giá:</span>
                            <span class="fw-bold text-success">0 đ</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4 pt-3 border-top">
                            <span class="fw-bold fs-5">Thành tiền:</span>
                            <asp:Label ID="lblTongTien" runat="server" CssClass="total-price"></asp:Label>
                        </div>
                        <div class="alert alert-primary bg-opacity-10 border-primary small mb-3 text-primary">
                            <i class="fa-solid fa-truck-fast me-1"></i> Miễn phí vận chuyển cho đơn hàng này.
                        </div>
                        <asp:Button ID="btnThanhToan" runat="server" Text="TIẾN HÀNH ĐẶT HÀNG" CssClass="btn-checkout shadow-sm" OnClick="btnThanhToan_Click" />
                        <a href="Default.aspx" class="btn btn-outline-secondary w-100 mt-2 border-0 py-2"><i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục mua sắm</a>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlTrong" runat="server" Visible="false" CssClass="text-center py-5 bg-white rounded shadow-sm">
            <div class="mb-4">
                <i class="fa-solid fa-cart-arrow-down text-muted opacity-25" style="font-size: 100px;"></i>
            </div>
            <h4 class="text-muted fw-bold mb-3">Giỏ hàng của bạn đang trống</h4>
            <p class="text-muted mb-4">Hãy dạo một vòng và chọn cho mình những sản phẩm ưng ý nhất nhé!</p>
            <a href="Default.aspx" class="btn btn-primary px-5 py-2 fw-bold text-uppercase rounded-pill shadow-sm">
                <i class="fa-solid fa-shop me-2"></i> Mua sắm ngay
            </a>
        </asp:Panel>
    </div>
</asp:Content>