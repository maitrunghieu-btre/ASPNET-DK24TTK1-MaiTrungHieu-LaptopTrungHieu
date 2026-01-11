<%@ Page Title="Nhập hàng vào kho" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="QuanLyNhapHang.aspx.cs" Inherits="Laptop.Admin.QuanLyNhapHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function openProductModal() {
            var myModal = new bootstrap.Modal(document.getElementById('productModal'));
            myModal.show();
        }

        // Hàm mở modal cảnh báo giá từ Server
        function openConfirmModal() {
            var myModal = new bootstrap.Modal(document.getElementById('modalConfirmPrice'));
            myModal.show();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-boxes-packing me-2"></i>NHẬP HÀNG VÀO KHO
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:HiddenField ID="hfTempMaMay" runat="server" />
    <asp:HiddenField ID="hfTempTenMay" runat="server" />
    <asp:HiddenField ID="hfTempSoLuong" runat="server" />
    <asp:HiddenField ID="hfTempGiaNhap" runat="server" />

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white fw-bold">
            <i class="fa-solid fa-circle-info me-2"></i>Thông tin phiếu nhập
        </div>
        <div class="card-body">
            <div class="row align-items-end">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Chọn Nhà Phân Phối (*)</label>
                    <asp:DropDownList ID="ddlNPP" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>
                <div class="col-md-6 text-end">
                    <span class="text-muted fw-bold">
                        <i class="fa-regular fa-calendar-days me-1"></i> Ngày nhập: <%= DateTime.Now.ToString("dd/MM/yyyy") %>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-secondary text-white fw-bold">
            <i class="fa-solid fa-list-check me-2"></i>Chi tiết hàng nhập
        </div>
        <div class="card-body bg-light">
            <asp:Literal ID="litThongBao" runat="server"></asp:Literal>

            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold">Sản phẩm</label>
                    <div class="input-group">
                        <asp:DropDownList ID="ddlSanPham" runat="server" CssClass="form-select"></asp:DropDownList>
                        <button type="button" class="btn btn-success" onclick="openProductModal()" title="Tạo nhanh">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>

                <div class="col-md-2">
                    <label class="form-label fw-bold">Số lượng</label>
                    <asp:TextBox ID="txtSoLuong" runat="server" CssClass="form-control text-center" TextMode="Number" min="1" Text="1"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <label class="form-label fw-bold">Giá nhập (VNĐ)</label>
                    <asp:TextBox ID="txtGiaNhap" runat="server" CssClass="form-control text-end fw-bold text-primary" TextMode="Number" min="0" placeholder="0"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <label class="form-label fw-bold">Tỉ lệ lãi mong muốn</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white text-success fw-bold">%</span>
                        <asp:DropDownList ID="ddlTiLeLai" runat="server" CssClass="form-select fw-bold text-success">
                            <asp:ListItem Value="0">Không tính lãi</asp:ListItem>
                            <asp:ListItem Value="5">5%</asp:ListItem>
                            <asp:ListItem Value="10" Selected="True">10%</asp:ListItem>
                            <asp:ListItem Value="15">15%</asp:ListItem>
                            <asp:ListItem Value="20">20%</asp:ListItem>
                            <asp:ListItem Value="25">25%</asp:ListItem>
                            <asp:ListItem Value="30">30%</asp:ListItem>
                            <asp:ListItem Value="40">40%</asp:ListItem>
                            <asp:ListItem Value="50">50%</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-text small text-muted">* Dùng để tính giá bán mới nếu cần.</div>
                </div>
                
                <div class="col-12 text-end mt-3 border-top pt-3">
                    <asp:Button ID="btnThemSP" runat="server" Text="+ Thêm vào phiếu" CssClass="btn btn-warning fw-bold px-4" OnClick="btnThemSP_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <asp:GridView ID="gvChiTietNhap" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-bordered table-hover mb-0 align-middle" ShowFooter="True" OnRowCommand="gvChiTietNhap_RowCommand">
                <HeaderStyle CssClass="table-light text-center fw-bold" />
                <Columns>
                    <asp:BoundField DataField="MaMay" HeaderText="ID" ItemStyle-Width="50px" ItemStyle-CssClass="text-center" />
                    <asp:TemplateField HeaderText="Tên Sản Phẩm">
                        <ItemTemplate>
                            <span class="fw-bold"><%# Eval("TenMay") %></span>
                            <div class="small text-success fst-italic mt-1">
                                <%# Convert.ToDecimal(Eval("GiaBanMoi")) > 0 ? 
                                    "<i class='fa-solid fa-arrow-up'></i> Giá bán mới: " + Convert.ToDecimal(Eval("GiaBanMoi")).ToString("N0") : "" %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SoLuong" HeaderText="SL" ItemStyle-CssClass="text-center fw-bold" ItemStyle-Width="80px" />
                    <asp:TemplateField HeaderText="Giá nhập">
                        <ItemTemplate><%# Convert.ToDecimal(Eval("GiaNhap")).ToString("N0") %></ItemTemplate>
                        <ItemStyle CssClass="text-end" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thành tiền">
                        <ItemTemplate>
                            <span class="fw-bold text-danger"><%# Convert.ToDecimal(Eval("ThanhTien")).ToString("N0") %></span>
                        </ItemTemplate>
                        <ItemStyle CssClass="text-end" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="50px" ItemStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnXoa" runat="server" CommandName="Xoa" CommandArgument='<%# Container.DataItemIndex %>' CssClass="text-danger btn btn-sm btn-light">
                                <i class="fa-solid fa-trash"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-5 text-muted">
                        <i class="fa-solid fa-cart-flatbed fs-1 mb-3 opacity-25"></i>
                        <p>Chưa có sản phẩm nào trong phiếu nhập.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
        <div class="card-footer bg-white p-3">
            <div class="row align-items-center">
                <div class="col-md-6 fs-5">
                    Tổng tiền phiếu nhập: <asp:Label ID="lblTongTien" runat="server" CssClass="fw-bold text-danger">0₫</asp:Label>
                </div>
                <div class="col-md-6 text-end">
                    <asp:Button ID="btnLuuPhieu" runat="server" Text="LƯU PHIẾU & NHẬP KHO" CssClass="btn btn-primary btn-lg fw-bold shadow" 
                        OnClick="btnLuuPhieu_Click" OnClientClick="return confirm('Xác nhận nhập kho? Kho sẽ được cộng dồn.');" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalConfirmPrice" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title fw-bold"><i class="fa-solid fa-triangle-exclamation me-2"></i>Cảnh báo giá nhập</h5>
                </div>
                <div class="modal-body">
                    <p>Sản phẩm: <asp:Label ID="lblConfirmTen" runat="server" CssClass="fw-bold"></asp:Label></p>
                    <div class="row mb-3">
                        <div class="col-6">Giá nhập mới:<br/><span class="text-danger fw-bold fs-5"><asp:Label ID="lblConfirmGiaNhap" runat="server"></asp:Label></span></div>
                        <div class="col-6">Giá bán hiện tại:<br/><span class="text-success fw-bold fs-5"><asp:Label ID="lblConfirmGiaBan" runat="server"></asp:Label></span></div>
                    </div>
                    <div class="alert alert-light border border-warning">
                        Giá nhập đang <b>CAO HƠN</b> hoặc bằng giá bán. Bạn có muốn hệ thống tự động cập nhật giá bán mới không?
                        <br />
                        <small class="text-muted">(Dựa trên mức lãi <asp:Label ID="lblConfirmLai" runat="server" fw-bold></asp:Label> đang chọn)</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnBoQuaUpdate" runat="server" Text="Giữ giá cũ (Bán lỗ)" CssClass="btn btn-secondary" OnClick="btnBoQuaUpdate_Click" />
                    <asp:Button ID="btnDongYUpdate" runat="server" Text="Đồng ý Cập nhật" CssClass="btn btn-primary fw-bold" OnClick="btnDongYUpdate_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title fw-bold"><i class="fa-solid fa-plus me-2"></i>Tạo Sản Phẩm Mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="fw-bold">Tên máy (*)</label>
                        <asp:TextBox ID="txtNewTenMay" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txtNewTenMay" ValidationGroup="NewProd" ErrorMessage="Nhập tên" CssClass="text-danger small" Display="Dynamic" />
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="fw-bold">Thương hiệu</label>
                            <asp:DropDownList ID="ddlNewThuongHieu" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold">Giá bán dự kiến</label>
                            <asp:TextBox ID="txtNewGiaBan" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="fw-bold">Cấu hình</label>
                        <asp:TextBox ID="txtNewCauHinh" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="fw-bold">Ảnh đại diện</label>
                        <asp:TextBox ID="txtNewHinhAnh" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <asp:Button ID="btnLuuSanPhamMoi" runat="server" Text="Lưu & Chọn Ngay" CssClass="btn btn-success fw-bold" OnClick="btnLuuSanPhamMoi_Click" ValidationGroup="NewProd" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>