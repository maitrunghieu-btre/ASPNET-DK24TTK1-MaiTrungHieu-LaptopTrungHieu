<%@ Page Title="Quản lý Nhà Phân Phối" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="QuanLyNhaPhanPhoi.aspx.cs" Inherits="Laptop.Admin.QuanLyNhaPhanPhoi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-truck-fast me-2"></i>QUẢN LÝ NHÀ PHÂN PHỐI (NGUỒN HÀNG)
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="mb-3 text-end">
        <asp:Button ID="btnThemMoi" runat="server" Text="+ Thêm NPP Mới" CssClass="btn btn-primary shadow-sm" OnClick="btnThemMoi_Click" />
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <asp:GridView ID="gvNPP" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover mb-0 align-middle" 
                OnRowCommand="gvNPP_RowCommand" GridLines="None">
                <HeaderStyle CssClass="table-light text-uppercase small fw-bold text-secondary" />
                <Columns>
                    <asp:BoundField DataField="MaNPP" HeaderText="ID" ItemStyle-Width="60px" ItemStyle-CssClass="text-center fw-bold text-muted" />
                    
                    <asp:TemplateField HeaderText="Tên Nhà Phân Phối">
                        <ItemTemplate>
                            <div class="fw-bold text-primary"><%# Eval("TenNPP") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="SoDienThoai" HeaderText="Điện thoại" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="DiaChi" HeaderText="Địa chỉ" />

                    <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="150px" ItemStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnSua" runat="server" CommandName="Sua" 
                                CommandArgument='<%# Eval("MaNPP") + ";" + Eval("TenNPP") + ";" + Eval("SoDienThoai") + ";" + Eval("Email") + ";" + Eval("DiaChi") %>' 
                                CssClass="btn btn-sm btn-light text-primary me-1" ToolTip="Sửa">
                                <i class="fa-solid fa-pen"></i>
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="btnXoa" runat="server" CommandName="Xoa" 
                                CommandArgument='<%# Eval("MaNPP") %>' 
                                CssClass="btn btn-sm btn-light text-danger" 
                                OnClientClick="return confirm('Bạn có chắc chắn muốn xóa NPP này?');" ToolTip="Xóa">
                                <i class="fa-solid fa-trash"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-5">
                        <i class="fa-solid fa-box-open fs-1 text-muted mb-3"></i>
                        <p class="text-muted">Chưa có nhà phân phối nào.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <div class="modal fade" id="nppModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold"><asp:Label ID="lblModalTitle" runat="server"></asp:Label></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfMaNPP" runat="server" />
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Tên Nhà Phân Phối (*)</label>
                        <asp:TextBox ID="txtTenNPP" runat="server" CssClass="form-control" placeholder="VD: FPT Synnex, Digiworld..."></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTen" runat="server" ControlToValidate="txtTenNPP" ErrorMessage="Chưa nhập tên NPP" CssClass="text-danger small" ValidationGroup="NPP" Display="Dynamic" />
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" placeholder="090..."></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="contact@abc.com"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Địa chỉ</label>
                        <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Địa chỉ kho hàng..."></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <asp:Button ID="btnLuu" runat="server" Text="Lưu Dữ Liệu" CssClass="btn btn-success" OnClick="btnLuu_Click" ValidationGroup="NPP" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function openNPPModal() {
            var myModal = new bootstrap.Modal(document.getElementById('nppModal'));
            myModal.show();
        }
    </script>
</asp:Content>