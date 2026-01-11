<%@ Page Title="Quản lý Banner" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="QuanLyBanner.aspx.cs" Inherits="Laptop.Admin.QuanLyBanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .banner-preview { height: 80px; width: 180px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd; }
        .status-badge { font-size: 0.75rem; padding: 3px 8px; border-radius: 12px; font-weight: bold; }
        .bg-active { background-color: #d1e7dd; color: #0f5132; }
        .bg-hidden { background-color: #f8d7da; color: #842029; }
    </style>
    <script>
        function openEditModal() {
            var myModal = new bootstrap.Modal(document.getElementById('editBannerModal'));
            myModal.show();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-images me-2"></i>QUẢN LÝ BANNER QUẢNG CÁO
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h5 class="mb-0 text-secondary fw-bold">Danh sách các chiến dịch Banner</h5>
            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-success fw-bold shadow-sm" OnClick="btnAdd_Click">
                <i class="fa-solid fa-plus me-1"></i> Thêm mới Banner
            </asp:LinkButton>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <asp:GridView ID="gvBanner" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover mb-0 align-middle" GridLines="None"
                    OnRowCommand="gvBanner_RowCommand" OnRowDataBound="gvBanner_RowDataBound">
                    <HeaderStyle CssClass="table-light text-uppercase small fw-bold text-secondary" />
                    <Columns>
                        <asp:BoundField DataField="MaBanner" HeaderText="ID" ItemStyle-Width="60px" ItemStyle-CssClass="text-center fw-bold" />
                        
                        <asp:TemplateField HeaderText="Hình ảnh">
                            <ItemTemplate>
                                <%-- Cập nhật đường dẫn hiển thị từ Images/Banners --%>
                                <img src='../Images/Banners/<%# Eval("HinhAnh") %>' class="banner-preview" alt="Banner" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thông tin Banner">
                            <ItemTemplate>
                                <div class="fw-bold text-primary"><%# Eval("TieuDe") %></div>
                                <div class="small text-muted text-truncate" style="max-width: 300px;">
                                    <i class="fa-solid fa-link me-1"></i>Link: <%# Eval("LienKet") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="ThuTu" HeaderText="Thứ tự" ItemStyle-Width="80px" ItemStyle-CssClass="text-center" />

                        <asp:TemplateField HeaderText="Trạng thái" ItemStyle-Width="120px" ItemStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblHienThi" runat="server" CssClass="status-badge"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác" ItemStyle-CssClass="text-end" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditBanner" CommandArgument='<%# Eval("MaBanner") %>'
                                    CssClass="btn btn-sm btn-outline-primary me-1" ToolTip="Sửa thông tin">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteBanner" CommandArgument='<%# Eval("MaBanner") %>'
                                    CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Bạn có thực sự muốn xóa banner này?');">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-5 text-center text-muted">Chưa có banner nào được tạo.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editBannerModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold"><asp:Literal ID="ltrModalTitle" runat="server"></asp:Literal></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfMaBanner" runat="server" Value="0" />
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Tiêu đề quảng cáo (*)</label>
                        <asp:TextBox ID="txtTieuDe" runat="server" CssClass="form-control" placeholder="Nhập tiêu đề banner..."></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Liên kết khi Click (Link)</label>
                        <asp:TextBox ID="txtLienKet" runat="server" CssClass="form-control" placeholder="Ví dụ: #"></asp:TextBox>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Thứ tự hiển thị</label>
                            <asp:TextBox ID="txtThuTu" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3 d-flex align-items-end pb-2">
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="chkHienThi" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label fw-bold ms-2">Cho phép hiển thị</label>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Hình ảnh Banner (*)</label>
                        <asp:FileUpload ID="fuHinhAnh" runat="server" CssClass="form-control mb-2" />
                        <div id="divHinhHienTai" runat="server" visible="false">
                            <small class="text-muted d-block mb-1">Hình ảnh hiện tại:</small>
                            <asp:Image ID="imgHienTai" runat="server" CssClass="img-thumbnail" style="max-height: 100px;" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                    <asp:Button ID="btnSave" runat="server" Text="Lưu dữ liệu" CssClass="btn btn-primary fw-bold" OnClick="btnSave_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>