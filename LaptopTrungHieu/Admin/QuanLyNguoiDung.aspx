<%@ Page Title="Quản lý Người dùng" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="QuanLyNguoiDung.aspx.cs" Inherits="Laptop.Admin.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .role-badge { font-size: 0.8rem; padding: 5px 10px; border-radius: 20px; font-weight: bold; }
        .bg-admin { background-color: #e74c3c; color: #fff; }
        .bg-khach { background-color: #3498db; color: #fff; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background: #eee; display: flex; align-items: center; justify-content: center; font-weight: bold; color: #888; }
    </style>
    <script>
        function openEditModal() {
            var myModal = new bootstrap.Modal(document.getElementById('editUserModal'));
            myModal.show();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-users-gear me-2"></i>QUẢN LÝ NGƯỜI DÙNG
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 text-secondary fw-bold">Danh sách thành viên hệ thống</h5>
            </div>
            <div class="card-body p-0">
                <asp:GridView ID="gvNguoiDung" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover mb-0 align-middle" GridLines="None"
                    AllowPaging="True" PageSize="10" OnPageIndexChanging="gvNguoiDung_PageIndexChanging"
                    OnRowDataBound="gvNguoiDung_RowDataBound" OnRowCommand="gvNguoiDung_RowCommand">
                    <HeaderStyle CssClass="table-light text-uppercase small fw-bold text-secondary" />
                    <Columns>
                        <asp:BoundField DataField="MaND" HeaderText="ID" ItemStyle-Width="60px" ItemStyle-CssClass="text-center fw-bold" />
                        <asp:TemplateField HeaderText="Người dùng">
                            <ItemTemplate>
                                <div class="d-flex align-items-center">
                                    <div class="user-avatar me-2"><%# Eval("HoTen").ToString().Length > 0 ? Eval("HoTen").ToString().Substring(0,1).ToUpper() : "U" %></div>
                                    <div>
                                        <div class="fw-bold text-primary"><%# Eval("HoTen") %></div>
                                        <small class="text-muted"><%# Eval("Email") %></small>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="SoDienThoai" HeaderText="SĐT" />
                        <asp:TemplateField HeaderText="Vai trò" ItemStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:Label ID="lblVaiTro" runat="server" Text='<%# Eval("VaiTro") %>' CssClass="role-badge"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thao tác" ItemStyle-CssClass="text-end" ItemStyle-Width="120px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditUser" CommandArgument='<%# Eval("MaND") %>' CssClass="btn btn-sm btn-outline-primary me-1"><i class="fa-solid fa-pen"></i> Sửa</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content text-start">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold"><asp:Literal ID="ltrModalTitle" runat="server"></asp:Literal></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblMsg" runat="server" CssClass="d-block alert alert-danger py-2 mb-3" Visible="false"></asp:Label>

                    <asp:HiddenField ID="hfMaND" runat="server" />
                    <div class="mb-3"><label class="fw-bold">Họ và tên (*)</label><asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control"></asp:TextBox></div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="fw-bold">Email (Có thể trống)</label><asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox></div>
                        <div class="col-md-6 mb-3"><label class="fw-bold text-primary">Số điện thoại (*)</label><asp:TextBox ID="txtSDT" runat="server" CssClass="form-control"></asp:TextBox></div>
                    </div>
                    <div class="mb-3">
                        <label class="fw-bold text-danger">Mật khẩu mới</label>
                        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <small class="text-muted fst-italic">(Để trống nếu muốn giữ mật khẩu cũ)</small>
                    </div>
                    <div class="mb-3"><label class="fw-bold">Địa chỉ</label><asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox></div>
                    <div class="mb-3">
                        <label class="fw-bold">Vai trò</label>
                        <asp:DropDownList ID="ddlVaiTroEdit" runat="server" CssClass="form-select">
                            <asp:ListItem Value="Khach">Khách hàng (Khach)</asp:ListItem>
                            <asp:ListItem Value="Admin">Quản trị viên (Admin)</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <asp:Button ID="btnSave" runat="server" Text="Lưu thay đổi" CssClass="btn btn-primary fw-bold" OnClick="btnSave_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>