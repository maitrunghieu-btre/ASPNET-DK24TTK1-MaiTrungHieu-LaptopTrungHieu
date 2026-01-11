<%@ Page Title="Quản lý Đơn hàng" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="Laptop.Admin.QuanLyDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .status-badge { font-size: 0.85rem; padding: 5px 10px; border-radius: 20px; font-weight: 600; display: inline-block; }
        .bg-cho-duyet { background-color: #fff3cd; color: #856404; }
        .bg-da-duyet { background-color: #cce5ff; color: #004085; }
        .bg-dang-giao { background-color: #d1ecf1; color: #0c5460; }
        .bg-da-giao { background-color: #d4edda; color: #155724; }
        .bg-da-huy { background-color: #f8d7da; color: #721c24; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-file-invoice-dollar me-2"></i>QUẢN LÝ ĐƠN ĐẶT HÀNG
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card shadow-sm mb-4">
        <div class="card-body bg-light">
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="fw-bold">Trạng thái:</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="btnFilter_Click">
                        <asp:ListItem Value="All">-- Tất cả --</asp:ListItem>
                        <asp:ListItem Value="Chờ duyệt">Chờ duyệt</asp:ListItem>
                        <asp:ListItem Value="Đã duyệt">Đã duyệt (Chuẩn bị hàng)</asp:ListItem>
                        <asp:ListItem Value="Đang giao">Đang giao hàng</asp:ListItem>
                        <asp:ListItem Value="Đã giao">Hoàn tất (Đã giao)</asp:ListItem>
                        <asp:ListItem Value="Đã hủy">Đã hủy</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Từ ngày:</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Đến ngày:</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="fw-bold">Tìm kiếm:</label>
                    <div class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Tên khách, SĐT..."></asp:TextBox>
                        <asp:LinkButton ID="btnFilter" runat="server" CssClass="btn btn-primary" OnClick="btnFilter_Click">
                            <i class="fa-solid fa-filter"></i> Lọc
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover mb-0 align-middle" GridLines="None"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvDonHang_PageIndexChanging"
                OnRowCommand="gvDonHang_RowCommand" OnRowDataBound="gvDonHang_RowDataBound">
                <HeaderStyle CssClass="table-light text-uppercase small fw-bold text-secondary" />
                <Columns>
                    <asp:BoundField DataField="MaDon" HeaderText="Mã Đơn" ItemStyle-CssClass="fw-bold text-center" ItemStyle-Width="80px" />
                    <asp:TemplateField HeaderText="Khách hàng">
                        <ItemTemplate>
                            <div class="fw-bold text-primary"><%# Eval("HoTen") %></div>
                            <div class="small text-muted"><i class="fa-solid fa-phone me-1"></i><%# Eval("SoDienThoai") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="NgayDat" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:TemplateField HeaderText="Tổng tiền">
                        <ItemTemplate>
                            <span class="text-danger fw-bold"><%# Convert.ToDecimal(Eval("TongTien")).ToString("N0") %>₫</span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Trạng thái" ItemStyle-Width="150px" ItemStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:Label ID="lblTrangThai" runat="server" Text='<%# Eval("TrangThai") %>' CssClass="status-badge"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="250px" ItemStyle-CssClass="text-center">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnXem" runat="server" CommandName="XemChiTiet" CommandArgument='<%# Eval("MaDon") %>' CssClass="btn btn-sm btn-outline-info me-1" ToolTip="Xem chi tiết"><i class="fa-solid fa-eye"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnDuyet" runat="server" CommandName="DuyetDon" CommandArgument='<%# Eval("MaDon") %>' CssClass="btn btn-sm btn-success me-1" ToolTip="Duyệt đơn này"><i class="fa-solid fa-check"></i> Duyệt</asp:LinkButton>
                            <asp:LinkButton ID="btnGiao" runat="server" CommandName="GiaoHang" CommandArgument='<%# Eval("MaDon") %>' CssClass="btn btn-sm btn-warning me-1" ToolTip="Bắt đầu giao hàng"><i class="fa-solid fa-truck"></i> Giao</asp:LinkButton>
                            <asp:LinkButton ID="btnHuy" runat="server" CommandName="HuyDon" CommandArgument='<%# Eval("MaDon") %>' CssClass="btn btn-sm btn-danger" ToolTip="Hủy đơn hàng" OnClientClick="return confirm('Bạn chắc chắn muốn hủy đơn này? Kho sẽ được hoàn lại.');"><i class="fa-solid fa-xmark"></i> Hủy</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="p-3" HorizontalAlign="Center" />
                <EmptyDataTemplate><div class="text-center p-5 text-muted">Không tìm thấy đơn hàng nào.</div></EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <div class="modal fade" id="orderModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title fw-bold">Chi tiết đơn hàng #<asp:Label ID="lblModalMaDon" runat="server"></asp:Label></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-light border mb-3">
                        <h6><i class="fa-solid fa-user me-2"></i>Thông tin giao hàng:</h6>
                        <asp:Label ID="lblModalThongTin" runat="server"></asp:Label>
                    </div>
                    <table class="table table-bordered align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">SL</th>
                                <th class="text-end">Đơn giá</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptChiTiet" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src='<%# ResolveUrl("~/Images/Products/" + Eval("HinhAnh")) %>' width="50" class="me-2 rounded border" />
                                                <span class="fw-bold"><%# Eval("TenMay") %></span>
                                            </div>
                                        </td>
                                        <td class="text-center"><%# Eval("SoLuong") %></td>
                                        <td class="text-end"><%# Convert.ToDecimal(Eval("GiaBan")).ToString("N0") %></td>
                                        <td class="text-end fw-bold text-danger"><%# Convert.ToDecimal(Eval("ThanhTien")).ToString("N0") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                        <tfoot class="table-light fw-bold">
                            <tr>
                                <td colspan="3" class="text-end">TỔNG CỘNG:</td>
                                <td class="text-end text-danger fs-5"><asp:Label ID="lblModalTongTien" runat="server"></asp:Label></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" onclick="window.print()"><i class="fa-solid fa-print me-1"></i> In hóa đơn</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        function openOrderModal() {
            var myModal = new bootstrap.Modal(document.getElementById('orderModal'));
            myModal.show();
        }
    </script>
</asp:Content>