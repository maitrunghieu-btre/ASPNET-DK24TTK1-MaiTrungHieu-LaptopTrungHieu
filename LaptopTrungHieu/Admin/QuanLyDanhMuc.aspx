<%@ Page Title="Quản lý Thương hiệu" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="QuanLyDanhMuc.aspx.cs" Inherits="Laptop.Admin.QuanLyDanhMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-tags me-2"></i>QUẢN LÝ THƯƠNG HIỆU
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="mb-3 text-end">
        <asp:Button ID="btnThemMoi" runat="server" Text="+ Thêm Thương Hiệu" CssClass="btn btn-primary shadow-sm" OnClick="btnThemMoi_Click" />
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <asp:GridView ID="gvThuongHieu" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover mb-0 align-middle" 
                OnRowCommand="gvThuongHieu_RowCommand" GridLines="None">
                <HeaderStyle CssClass="table-light text-uppercase small fw-bold text-secondary" />
                <Columns>
                    <asp:BoundField DataField="MaTH" HeaderText="ID" ItemStyle-Width="50px" ItemStyle-CssClass="text-center fw-bold text-muted" />
                    
                    <asp:TemplateField HeaderText="Tên Thương Hiệu">
                        <ItemTemplate>
                            <span class="fw-bold text-primary fs-6"><%# Eval("TenTH") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="MoTa" HeaderText="Mô tả ngắn" ItemStyle-CssClass="text-muted small" />
                    
                    <asp:TemplateField HeaderText="Thứ tự" ItemStyle-Width="80px" ItemStyle-CssClass="text-center">
                        <ItemTemplate>
                            <span class="badge bg-light text-dark border"><%# Eval("ThuTu") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="150px" ItemStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnSua" runat="server" CommandName="Sua" 
                                CommandArgument='<%# Eval("MaTH") + ";" + Eval("TenTH") + ";" + Eval("MoTa") + ";" + Eval("ThuTu") %>' 
                                CssClass="btn btn-sm btn-light text-primary me-1" ToolTip="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="btnXoa" runat="server" CommandName="Xoa" 
                                CommandArgument='<%# Eval("MaTH") %>' 
                                CssClass="btn btn-sm btn-light text-danger" 
                                OnClientClick="return confirm('Cảnh báo: Xóa thương hiệu này có thể ảnh hưởng đến sản phẩm. Bạn chắc chắn chứ?');" ToolTip="Xóa">
                                <i class="fa-solid fa-trash"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-5">
                        <i class="fa-solid fa-tag fs-1 text-muted mb-3 opacity-50"></i>
                        <p class="text-muted">Chưa có thương hiệu nào.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <div class="modal fade" id="brandModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold"><asp:Label ID="lblModalTitle" runat="server"></asp:Label></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfMaTH" runat="server" />
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Tên Thương Hiệu (*)</label>
                        <asp:TextBox ID="txtTenTH" runat="server" CssClass="form-control" placeholder="VD: Dell, MacBook..."></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTen" runat="server" ControlToValidate="txtTenTH" ErrorMessage="Vui lòng nhập tên" CssClass="text-danger small" ValidationGroup="Brand" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Thứ tự hiển thị</label>
                        <asp:TextBox ID="txtThuTu" runat="server" CssClass="form-control" TextMode="Number" placeholder="VD: 1, 2, 3..."></asp:TextBox>
                        <div class="form-text small">Số nhỏ sẽ hiển thị trước trên Menu.</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Mô tả ngắn</label>
                        <asp:TextBox ID="txtMoTa" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="VD: Laptop bền bỉ từ Mỹ..."></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <asp:Button ID="btnLuu" runat="server" Text="Lưu Dữ Liệu" CssClass="btn btn-success" OnClick="btnLuu_Click" ValidationGroup="Brand" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function openBrandModal() {
            var myModal = new bootstrap.Modal(document.getElementById('brandModal'));
            myModal.show();
        }
    </script>
</asp:Content>