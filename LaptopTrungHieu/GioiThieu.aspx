<%@ Page Title="Về chúng tôi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioiThieu.aspx.cs" Inherits="Laptop.GioiThieu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Banner giới thiệu - Phong cách Microsoft Blue */
        .about-banner {
            background: linear-gradient(135deg, #0078D7, #005a9e); /* Màu xanh đặc trưng của Surface/Windows */
            color: white;
            padding: 90px 0;
            text-align: center;
            margin-bottom: 60px;
        }
        .about-banner h1 { font-weight: 900; text-transform: uppercase; letter-spacing: 2px; font-size: 2.5rem; }
        .about-banner p { font-size: 1.3rem; opacity: 0.9; max-width: 700px; margin: 20px auto 0; font-weight: 300; }

        /* Section chung */
        .about-section { margin-bottom: 80px; }
        .text-justify { text-align: justify; }
        
        /* Ảnh minh họa */
        .about-img-box {
            position: relative;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        .about-img-box img { width: 100%; display: block; transition: 0.5s; }
        .about-img-box:hover img { transform: scale(1.03); }

        /* Khối "Tại sao chọn Surface" */
        .surface-box {
            background-color: #f8f9fa;
            border-radius: 15px;
            padding: 40px;
            text-align: center;
            transition: 0.3s;
            height: 100%;
            border: 1px solid #e9ecef;
        }
        .surface-box:hover {
            background-color: #fff;
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,120,215,0.15); /* Bóng màu xanh Surface */
            border-color: #0078D7;
        }
        .surface-icon { font-size: 3rem; color: #0078D7; margin-bottom: 25px; }

        /* Tầm nhìn sứ mệnh */
        .quote-box {
            border-left: 5px solid #0078D7;
            padding-left: 25px;
            margin: 30px 0;
            font-style: italic;
            color: #555;
            font-size: 1.1rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="about-banner">
        <div class="container">
            <h1>Trung Hiếu Surface</h1>
            <p>Tiên phong mang hệ sinh thái Microsoft Surface chính hãng & Laptop cao cấp đến người dùng Việt</p>
        </div>
    </div>

    <div class="container">
        <div class="row about-section align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <div class="about-img-box">
                    <img src="images/gioithieu.png" alt="Surface Laptop">
                </div>
            </div>
            <div class="col-lg-6 ps-lg-5">
                <h6 class="text-primary fw-bold text-uppercase ls-2">Về chúng tôi</h6>
                <h2 class="fw-bold mb-4 display-6">Đam mê sự hoàn hảo của công nghệ</h2>
                <div class="text-muted text-justify">
                    <p>Khởi nguồn từ niềm đam mê mãnh liệt với thiết kế tinh tế và hiệu năng mạnh mẽ của dòng máy <strong>Microsoft Surface</strong>, Laptop Trung Hiếu được thành lập với mục tiêu trở thành điểm đến tin cậy nhất cho các tín đồ công nghệ.</p>
                    <p>Khác với các cửa hàng bán lẻ đại trà, chúng tôi chọn một lối đi riêng: <strong>Tập trung chuyên sâu vào Surface và các dòng Laptop doanh nhân cao cấp (Dell XPS, HP Spectre)</strong>. Chúng tôi không chỉ bán máy tính, chúng tôi bán trải nghiệm "sang trọng, mỏng nhẹ và mạnh mẽ" đúng như triết lý của Microsoft.</p>
                </div>
                <div class="quote-box">
                    "Chúng tôi tin rằng chiếc Surface không chỉ là một thiết bị điện tử, nó là món trang sức công nghệ khẳng định đẳng cấp của người sở hữu."
                </div>
            </div>
        </div>

        <div class="about-section">
            <div class="text-center mb-5">
                <h2 class="fw-bold">Hệ sinh thái Microsoft Surface</h2>
                <p class="text-muted">Sự kết hợp hoàn hảo giữa phần cứng đẳng cấp và hệ điều hành Windows bản quyền</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="surface-box">
                        <div class="surface-icon"><i class="fa-brands fa-windows"></i></div>
                        <h4 class="fw-bold">Chuẩn mực Windows</h4>
                        <p class="text-muted">Không ai hiểu Windows bằng chính Microsoft. Surface mang lại trải nghiệm phần mềm mượt mà, ổn định và bảo mật tuyệt đối.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="surface-box">
                        <div class="surface-icon"><i class="fa-solid fa-pen-nib"></i></div>
                        <h4 class="fw-bold">Thiết kế Độc bản</h4>
                        <p class="text-muted">Từ chân đế Kickstand của Surface Pro đến bản lề Dynamic của Surface Studio - Mỗi thiết bị là một kiệt tác thiết kế công nghiệp.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="surface-box">
                        <div class="surface-icon"><i class="fa-solid fa-display"></i></div>
                        <h4 class="fw-bold">Màn hình PixelSense</h4>
                        <p class="text-muted">Công nghệ màn hình cảm ứng độ phân giải cao, tỉ lệ 3:2 tối ưu cho công việc, mang lại hình ảnh sắc nét và sống động nhất.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="about-section bg-light p-5 rounded-4">
            <div class="row align-items-center">
                <div class="col-lg-5 mb-4 mb-lg-0">
                    <h2 class="fw-bold mb-3">Cam kết vàng từ<br><span class="text-primary">Laptop Trung Hiếu</span></h2>
                    <p class="text-muted">Sự hài lòng của khách hàng là thước đo thành công duy nhất của chúng tôi.</p>
                    <a href="Default.aspx" class="btn btn-primary btn-lg mt-3 px-4 shadow-sm fw-bold">XEM SẢN PHẨM NGAY</a>
                </div>
                <div class="col-lg-7">
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center bg-white p-3 rounded shadow-sm">
                                <i class="fa-solid fa-check-circle text-success fs-3 me-3"></i>
                                <div><strong>Hàng chuẩn US/UK</strong><br><small class="text-muted">Nguyên bản 100%</small></div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center bg-white p-3 rounded shadow-sm">
                                <i class="fa-solid fa-rotate text-primary fs-3 me-3"></i>
                                <div><strong>Bảo hành 1 đổi 1</strong><br><small class="text-muted">Trong 30 ngày đầu</small></div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center bg-white p-3 rounded shadow-sm">
                                <i class="fa-solid fa-gift text-danger fs-3 me-3"></i>
                                <div><strong>Full bộ quà tặng</strong><br><small class="text-muted">Balo, Chuột, Túi sốc</small></div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="d-flex align-items-center bg-white p-3 rounded shadow-sm">
                                <i class="fa-solid fa-headset text-warning fs-3 me-3"></i>
                                <div><strong>Hỗ trợ trọn đời</strong><br><small class="text-muted">Cài đặt phần mềm Free</small></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="about-section text-center">
            <h5 class="text-muted text-uppercase mb-4">Ghé thăm Showroom trải nghiệm</h5>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card border-0 shadow-sm p-4">
                        <i class="fa-solid fa-store text-primary display-4 mb-3"></i>
                        <h3 class="fw-bold">Laptop Trung Hiếu</h3>
                        <p class="fs-5 mb-1">TP. Bến Tre, Tỉnh Bến Tre</p>
                        <p class="text-muted">Hotline: <strong>0975.728.913</strong></p>
                        <p class="small text-muted fst-italic">"Nơi bạn tìm thấy chiếc Surface trong mơ của mình"</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>