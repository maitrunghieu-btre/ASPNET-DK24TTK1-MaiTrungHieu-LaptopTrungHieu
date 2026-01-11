<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Laptop.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Tông màu chủ đạo */
        :root { --primary-color: #0056b3; --text-dark: #333; }

        /* Carousel Banner */
        .carousel-item { background-color: #000; } /* Màu nền đen đề phòng ảnh chưa load kịp */
        .carousel-item img { width: 100%; height: auto; display: block; }
        .carousel-caption { background: rgba(0,0,0,0.5); padding: 15px; border-radius: 10px; bottom: 40px; }

        /* Menu Hãng bên trái */
        .brand-list .list-group-item { border: none; font-weight: 500; color: #555; transition: 0.2s; border-left: 3px solid transparent; }
        .brand-list .list-group-item:hover, .brand-list .list-group-item.active { 
            background-color: #e7f1ff; color: var(--primary-color); border-left-color: var(--primary-color); font-weight: 700; 
        }

        /* Card Sản phẩm */
        .product-card { background: #fff; border: 1px solid #eee; border-radius: 8px; transition: 0.3s; position: relative; overflow: hidden; height: 100%; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,86,179,0.15); border-color: var(--primary-color); }
        
        .img-wrap { height: 200px; padding: 20px; display: flex; align-items: center; justify-content: center; background: #fff; }
        .img-wrap img { max-height: 100%; max-width: 100%; object-fit: contain; transition: 0.3s; }
        .product-card:hover .img-wrap img { transform: scale(1.05); }

        .card-body { padding: 15px; }
        .prod-title { font-size: 1rem; font-weight: 700; margin-bottom: 5px; height: 2.4em; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .prod-title a { color: #333; text-decoration: none; }
        .prod-title a:hover { color: var(--primary-color); }

        .specs { font-size: 0.8rem; color: #777; background: #f8f9fa; padding: 5px; border-radius: 4px; margin-bottom: 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        
        .price { color: #d70018; font-size: 1.15rem; font-weight: 800; }
        .old-price { font-size: 0.9rem; text-decoration: line-through; color: #aaa; margin-left: 5px; }

        /* Nút Mua & Hết hàng */
        .btn-buy { width: 100%; border: 1px solid var(--primary-color); background: #fff; color: var(--primary-color); font-weight: 600; margin-top: 10px; transition: 0.2s; }
        .btn-buy:hover { background: var(--primary-color); color: #fff; }
        
        .out-stock-label { width: 100%; background: #f8f9fa; color: #999; border: 1px solid #ddd; padding: 6px; border-radius: 4px; font-weight: 600; margin-top: 10px; text-align: center; cursor: not-allowed; display: block; }
        
        .badge-stock { position: absolute; top: 10px; right: 10px; font-size: 0.7rem; padding: 4px 8px; border-radius: 4px; z-index: 10; font-weight: bold; }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-danger { background: #f8d7da; color: #721c24; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mb-4">
        <div id="mainCarousel" class="carousel slide shadow-sm rounded overflow-hidden" data-bs-ride="carousel">
            <div class="carousel-inner">
                <asp:Repeater ID="rptBanner" runat="server">
                    <ItemTemplate>
                        <div class='carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>'>
                            <a href='<%# Eval("LienKet") %>'>
                                <img src='<%# ResolveUrl("~/Images/Banners/" + Eval("HinhAnh")) %>' 
                                     alt='<%# Eval("TieuDe") %>' 
                                     onerror="this.src='<%= ResolveUrl("~/Images/no-image.png") %>'; this.onerror=null;">
                            </a>
                            <div class="carousel-caption d-none d-md-block">
                                <h5><%# Eval("TieuDe") %></h5>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev"><span class="carousel-control-prev-icon"></span></button>
            <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next"><span class="carousel-control-next-icon"></span></button>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row">
            
            <div class="col-lg-3 mb-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white fw-bold text-uppercase py-3 border-bottom text-primary">
                        <i class="fa-solid fa-bars me-2"></i> Danh mục Hãng
                    </div>
                    <div class="list-group list-group-flush brand-list">
                        <a href="Default.aspx" class='list-group-item list-group-item-action <%= Request.QueryString["hang"] == null && Request.QueryString["k"] == null ? "active" : "" %>'>
                            <i class="fa-solid fa-laptop me-2"></i> Tất cả sản phẩm
                        </a>
                        <asp:Repeater ID="rptMenuHang" runat="server">
                            <ItemTemplate>
                                <a href='Default.aspx?hang=<%# Eval("MaTH") %>' class='list-group-item list-group-item-action <%# CheckActive(Eval("MaTH")) %>'>
                                    <i class="fa-solid fa-chevron-right me-2 font-small"></i> Laptop <%# Eval("TenTH") %>
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                    <h4 class="fw-bold m-0 text-primary"><asp:Label ID="lblTieuDe" runat="server" Text="Sản phẩm nổi bật"></asp:Label></h4>
                    <span class="badge bg-secondary"><asp:Label ID="lblSoLuong" runat="server" Text="0"></asp:Label> máy</span>
                </div>

                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
                    <asp:Repeater ID="rptSanPham" runat="server">
                        <ItemTemplate>
                            <div class="col">
                                <div class="product-card h-100">
                                    <span class='badge-stock <%# Convert.ToInt32(Eval("TonKho")) > 0 ? "badge-success" : "badge-danger" %>'>
                                        <%# Convert.ToInt32(Eval("TonKho")) > 0 ? "Sẵn hàng" : "Hết hàng" %>
                                    </span>

                                    <div class="img-wrap">
                                        <a href='<%# ResolveUrl("~/ChiTietSanPham.aspx?id=" + Eval("MaMay")) %>'>
                                            <img src='<%# ResolveUrl("~/Images/Products/" + Eval("HinhAnh")) %>' 
                                                 alt='<%# Eval("TenMay") %>' 
                                                 onerror="this.src='<%= ResolveUrl("~/Images/no-image.png") %>'; this.onerror=null;">
                                        </a>
                                    </div>

                                    <div class="card-body">
                                        <div class="prod-title">
                                            <a href='<%# ResolveUrl("~/ChiTietSanPham.aspx?id=" + Eval("MaMay")) %>'><%# Eval("TenMay") %></a>
                                        </div>
                                        <div class="specs" title='<%# Eval("CauHinh") %>'>
                                            <i class="fa-solid fa-microchip"></i> <%# Eval("CauHinh") %>
                                        </div>
                                        <div class="price">
                                            <%# Convert.ToDecimal(Eval("GiaBan")).ToString("N0") %> đ
                                        </div>

                                        <asp:LinkButton ID="btnMua" runat="server" CssClass="btn btn-buy" 
                                            CommandArgument='<%# Eval("MaMay") %>' OnClick="btnMua_Click"
                                            Visible='<%# Convert.ToInt32(Eval("TonKho")) > 0 %>'>
                                            <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ
                                        </asp:LinkButton>

                                        <asp:Label ID="lblHetHang" runat="server" CssClass="out-stock-label" 
                                            Visible='<%# Convert.ToInt32(Eval("TonKho")) <= 0 %>' Text="Tạm hết hàng"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                
                <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="text-center py-5">
                    <img src='<%= ResolveUrl("~/Images/empty-box.png") %>' style="width: 100px; opacity: 0.5" />
                    <h5 class="text-muted mt-3">Không tìm thấy sản phẩm nào!</h5>
                    <a href="Default.aspx" class="btn btn-primary mt-2">Xem tất cả</a>
                </asp:Panel>
            </div>

        </div>
    </div>
</asp:Content>