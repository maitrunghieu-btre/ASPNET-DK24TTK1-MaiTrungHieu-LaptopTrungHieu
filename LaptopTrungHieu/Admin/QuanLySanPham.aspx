<%@ Page Title="Quản lý Sản phẩm" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="Laptop.Admin.QuanLySanPham" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.ckeditor.com/4.22.1/full/ckeditor.js"></script>
    <style>
        .table-container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .product-img { width: 60px; height: 60px; object-fit: cover; border-radius: 5px; border: 1px solid #ddd; }
        .filter-bar { background: #f8f9fa; padding: 15px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #eee; }
        
        /* FIX LỖI POPUP CKEDITOR BỊ CHÌM DƯỚI MODAL BOOTSTRAP */
        .cke_dialog { z-index: 10000005 !important; }
        .cke_dialog_background_cover { z-index: 10000000 !important; }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
    <i class="fa-solid fa-laptop"></i> QUẢN LÝ SẢN PHẨM
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        
        <div class="filter-bar row g-3 align-items-end">
            <div class="col-md-3">
                <label class="form-label fw-bold">Thương hiệu:</label>
                <asp:DropDownList ID="ddlFilterHang" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterHang_SelectedIndexChanged"></asp:DropDownList>
            </div>
            
            <div class="col-md-2">
                <label class="form-label fw-bold">Tồn kho <=</label>
                <asp:TextBox ID="txtFilterTon" runat="server" CssClass="form-control" TextMode="Number" placeholder="VD: 5"></asp:TextBox>
            </div>

            <div class="col-md-4">
                <label class="form-label fw-bold">Tìm kiếm:</label>
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Tên laptop..."></asp:TextBox>
                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click">
                        <i class="fa-solid fa-magnifying-glass"></i> Lọc & Tìm
                    </asp:LinkButton>
                </div>
            </div>
            
            <div class="col-md-3 text-end">
                 <button type="button" class="btn btn-success fw-bold" onclick="resetAndOpenModal()">
                    <i class="fa-solid fa-plus me-2"></i> Thêm Mới
                </button>
            </div>
        </div>

        <div class="table-container">
            <h5 class="fw-bold mb-3 text-secondary border-bottom pb-2">Danh sách Laptop hiện có</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th>Hình</th>
                            <th>Tên Laptop</th>
                            <th>Thương hiệu</th>
                            <th>Giá bán</th>
                            <th>Tồn kho</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptLaptop" runat="server" OnItemCommand="rptLaptop_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <img src='<%# ResolveUrl("~/Images/Products/" + Eval("HinhAnh")) %>' class="product-img" onerror="this.src='/Images/no-image.png'" />
                                    </td>
                                    <td>
                                        <div class="fw-bold text-primary"><%# Eval("TenMay") %></div>
                                        <small class="text-muted">ID: #<%# Eval("MaMay") %></small>
                                    </td>
                                    <td><span class="badge bg-secondary"><%# Eval("TenTH") %></span></td>
                                    <td class="text-danger fw-bold"><%# Convert.ToDecimal(Eval("GiaBan")).ToString("N0") %></td>
                                    <td>
                                        <%# Convert.ToInt32(Eval("TonKho")) <= 5 ? "<span class='text-danger fw-bold'>"+Eval("TonKho")+"</span>" : Eval("TonKho") %>
                                    </td>
                                    <td class="text-end">
                                        <a href="QuanLyNhapHang.aspx?id=<%# Eval("MaMay") %>" class="btn btn-sm btn-info text-white me-1" title="Nhập thêm hàng này">
                                            <i class="fa-solid fa-download"></i> Nhập
                                        </a>

                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditLap" CommandArgument='<%# Eval("MaMay") %>' 
                                            CssClass="btn btn-sm btn-outline-warning me-1" ToolTip="Cập nhật"><i class="fa-solid fa-pen-to-square"></i></asp:LinkButton>
                                        
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteLap" CommandArgument='<%# Eval("MaMay") %>' 
                                            CssClass="btn btn-sm btn-outline-danger" ToolTip="Xóa"
                                            OnClientClick="return confirm('CẢNH BÁO: Xóa sản phẩm sẽ mất hết lịch sử và hình ảnh!\nBạn có chắc chắn?');">
                                            <i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
             <asp:Label ID="lblThongBao" runat="server" Visible="false" CssClass="alert alert-info d-block mt-3 text-center">Không tìm thấy sản phẩm nào phù hợp.</asp:Label>
        </div>
    </div>

    <div class="modal fade" id="productModal" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold" id="modalTitle">Thông tin Laptop</h5>
                    <button type="button" class="btn-close btn-close-white" onclick="closeProductModal()"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfMaMay" runat="server" Value="0" />
                    <asp:HiddenField ID="hfOldImage" runat="server" />

                    <div class="row">
                        <div class="col-md-4 border-end">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Tên Laptop (*)</label>
                                <asp:TextBox ID="txtTenMay" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txtTenMay" ValidationGroup="Save" ErrorMessage="Nhập tên máy" CssClass="text-danger small" Display="Dynamic"/>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Thương hiệu</label>
                                <asp:DropDownList ID="ddlHang" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="row">
                                <div class="col-6 mb-3">
                                    <label class="form-label fw-bold">Giá bán</label>
                                    <asp:TextBox ID="txtGiaBan" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="txtGiaBan" ValidationGroup="Save" ErrorMessage="Nhập giá" CssClass="text-danger small" Display="Dynamic"/>
                                </div>
                                <div class="col-6 mb-3">
                                    <label class="form-label fw-bold">Tồn kho</label>
                                    <asp:TextBox ID="txtTonKho" runat="server" CssClass="form-control bg-light" Enabled="false" Text="0"></asp:TextBox>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Hình ảnh đại diện</label>
                                <asp:FileUpload ID="fuHinhAnh" runat="server" CssClass="form-control" onchange="previewImage(this)" />
                                <div class="mt-2 text-center p-2 border rounded bg-light">
                                    <asp:Image ID="imgPreview" runat="server" CssClass="img-fluid" style="max-height: 150px;" ImageUrl="~/Images/no-image.png" />
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold text-success"><i class="fa-solid fa-images me-1"></i>Thêm ảnh vào Thư Viện</label>
                                <asp:FileUpload ID="fuAlbum" runat="server" CssClass="form-control" AllowMultiple="true" />
                                <div class="form-text small">Giữ <b>Ctrl</b> để chọn nhiều file cùng lúc.</div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Cấu hình tóm tắt</label>
                                <asp:TextBox ID="txtCauHinh" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <label class="form-label fw-bold">Mô tả chi tiết bài viết</label>
                            <p class="small text-muted mb-1"><i class="fa-solid fa-circle-info"></i> Hỗ trợ định dạng văn bản và upload ảnh trực tiếp trong bài.</p>
                            <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                            
                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    if (document.getElementById('<%= txtMoTa.ClientID %>')) {
                                        CKEDITOR.replace('<%= txtMoTa.ClientID %>', {
                                            filebrowserUploadUrl: 'UploadImage.ashx', // Đường dẫn xử lý upload
                                            height: 450,
                                            // Cấu hình Toolbar đầy đủ
                                            toolbar: [
                                                { name: 'document', items: ['Source', '-', 'Preview'] },
                                                { name: 'clipboard', items: ['Cut', 'Copy', 'Paste', '-', 'Undo', 'Redo'] },
                                                { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike'] },
                                                { name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
                                                { name: 'insert', items: ['Image', 'Table', 'HorizontalRule'] },
                                                { name: 'styles', items: ['Format', 'Font', 'FontSize'] },
                                                { name: 'colors', items: ['TextColor', 'BGColor'] },
                                                { name: 'tools', items: ['Maximize'] }
                                            ]
                                        });
                                    }
                                });
                            </script>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeProductModal()">Hủy</button>
                    <asp:Button ID="btnSave" runat="server" Text="Lưu thay đổi" CssClass="btn btn-warning fw-bold" OnClick="btnSave_Click" ValidationGroup="Save" />
                </div>
            </div>
        </div>
    </div>

    <script>
        // Hàm mở modal để thêm mới (Reset form)
        function resetAndOpenModal() {
            document.getElementById('<%= hfMaMay.ClientID %>').value = "0";
            document.getElementById('<%= hfOldImage.ClientID %>').value = "";
            document.getElementById('<%= txtTenMay.ClientID %>').value = "";
            document.getElementById('<%= txtGiaBan.ClientID %>').value = "";
            document.getElementById('<%= txtTonKho.ClientID %>').value = "0";
            document.getElementById('<%= txtCauHinh.ClientID %>').value = "";
            document.getElementById('<%= imgPreview.ClientID %>').src = "/Images/no-image.png";

            // Reset CKEditor
            if (CKEDITOR.instances['<%= txtMoTa.ClientID %>']) {
                CKEDITOR.instances['<%= txtMoTa.ClientID %>'].setData('');
            }

            document.getElementById('modalTitle').innerText = "THÊM SẢN PHẨM MỚI";
            showModalServer();
        }

        // Hàm hiện modal (được gọi từ Server hoặc client)
        function showModalServer() {
            var modalElement = document.getElementById('productModal');
            if (modalElement) {
                var myModal = bootstrap.Modal.getInstance(modalElement);
                if (!myModal) {
                    myModal = new bootstrap.Modal(modalElement, { backdrop: 'static', keyboard: false, focus: false });
                }
                myModal.show();
            }
        }

        // Hàm đóng modal
        function closeProductModal() {
            var modalElement = document.getElementById('productModal');
            var myModal = bootstrap.Modal.getInstance(modalElement);
            if (myModal) myModal.hide();
            // Xóa backdrop nếu bị kẹt
            document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
            document.body.classList.remove('modal-open');
        }

        // Preview ảnh
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgPreview.ClientID %>').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>