USE [master]
GO
/****** Object:  Database [LaptopTrungHieu]    Script Date: 1/11/2026 7:20:03 PM ******/
CREATE DATABASE [LaptopTrungHieu]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LaptopTrungHieu', FILENAME = N'D:\DeTaiWeb2026\LaptopTrungHieu\App_Data\LaptopTrungHieu.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LaptopTrungHieu_log', FILENAME = N'D:\DeTaiWeb2026\LaptopTrungHieu\App_Data\LaptopTrungHieu_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LaptopTrungHieu] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LaptopTrungHieu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LaptopTrungHieu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET ARITHABORT OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LaptopTrungHieu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LaptopTrungHieu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LaptopTrungHieu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LaptopTrungHieu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET RECOVERY FULL 
GO
ALTER DATABASE [LaptopTrungHieu] SET  MULTI_USER 
GO
ALTER DATABASE [LaptopTrungHieu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LaptopTrungHieu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LaptopTrungHieu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LaptopTrungHieu] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LaptopTrungHieu] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LaptopTrungHieu] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LaptopTrungHieu] SET OPTIMIZED_LOCKING = OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LaptopTrungHieu', N'ON'
GO
ALTER DATABASE [LaptopTrungHieu] SET QUERY_STORE = ON
GO
ALTER DATABASE [LaptopTrungHieu] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LaptopTrungHieu]
GO
/****** Object:  Table [dbo].[ThuongHieu]    Script Date: 1/11/2026 7:20:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuongHieu](
	[MaTH] [int] IDENTITY(1,1) NOT NULL,
	[TenTH] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](255) NULL,
	[ThuTu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MayTinh](
	[MaMay] [int] IDENTITY(1,1) NOT NULL,
	[TenMay] [nvarchar](200) NOT NULL,
	[CauHinh] [nvarchar](max) NULL,
	[MaTH] [int] NOT NULL,
	[GiaBan] [decimal](18, 2) NOT NULL,
	[HinhAnh] [nvarchar](255) NULL,
	[TonKho] [int] NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	[MoTa] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaMay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_DanhSachMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_DanhSachMayTinh] AS
SELECT m.*, th.TenTH 
FROM MayTinh m JOIN ThuongHieu th ON m.MaTH = th.MaTH;
GO
/****** Object:  Table [dbo].[DonDatHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonDatHang](
	[MaDon] [int] IDENTITY(1,1) NOT NULL,
	[MaND] [int] NOT NULL,
	[NgayDat] [datetime] NOT NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
	[TongTien] [decimal](18, 2) NOT NULL,
	[DiaChiGiaoHang] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_DoanhThu]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_DoanhThu] AS
SELECT 
    CONVERT(date, NgayDat) AS Ngay, 
    SUM(TongTien) AS DoanhThu,
    COUNT(MaDon) AS SoDon
FROM DonDatHang 
WHERE TrangThai = N'Đã giao'
GROUP BY CONVERT(date, NgayDat);
GO
/****** Object:  View [dbo].[vw_CanhBaoKho]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_CanhBaoKho] AS
SELECT MaMay, TenMay, TonKho, HinhAnh 
FROM MayTinh 
WHERE TonKho <= 5;
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[MaBanner] [int] IDENTITY(1,1) NOT NULL,
	[HinhAnh] [nvarchar](255) NOT NULL,
	[TieuDe] [nvarchar](200) NULL,
	[LienKet] [nvarchar](255) NULL,
	[ThuTu] [int] NULL,
	[HienThi] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBanner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDon]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDon](
	[MaCT] [int] IDENTITY(1,1) NOT NULL,
	[MaDon] [int] NOT NULL,
	[MaMay] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaBan] [decimal](18, 2) NOT NULL,
	[ThanhTien]  AS ([SoLuong]*[GiaBan]),
PRIMARY KEY CLUSTERED 
(
	[MaCT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietNhap]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietNhap](
	[MaCTN] [int] IDENTITY(1,1) NOT NULL,
	[MaNhap] [int] NOT NULL,
	[MaMay] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaNhap] [decimal](18, 2) NOT NULL,
	[ThanhTien]  AS ([SoLuong]*[GiaNhap]),
PRIMARY KEY CLUSTERED 
(
	[MaCTN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonNhap]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonNhap](
	[MaNhap] [int] IDENTITY(1,1) NOT NULL,
	[MaNPP] [int] NOT NULL,
	[NgayNhap] [datetime] NOT NULL,
	[TongTien] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[MaND] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](150) NOT NULL,
	[Email] [varchar](100) NULL,
	[MatKhau] [varchar](255) NOT NULL,
	[SoDienThoai] [varchar](20) NULL,
	[DiaChi] [nvarchar](255) NULL,
	[VaiTro] [varchar](20) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaPhanPhoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaPhanPhoi](
	[MaNPP] [int] IDENTITY(1,1) NOT NULL,
	[TenNPP] [nvarchar](150) NOT NULL,
	[DiaChi] [nvarchar](255) NULL,
	[SoDienThoai] [varchar](20) NULL,
	[Email] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNPP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThuVienAnh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuVienAnh](
	[MaAnh] [int] IDENTITY(1,1) NOT NULL,
	[MaMay] [int] NOT NULL,
	[DuongDan] [nvarchar](255) NOT NULL,
	[SapXep] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaAnh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Banner] ON 
GO
INSERT [dbo].[Banner] ([MaBanner], [HinhAnh], [TieuDe], [LienKet], [ThuTu], [HienThi]) VALUES (2, N'banner1.png', N'Siêu Sale Khai Trương (Từ 1/1/2026-11/1/2026)', N'#', 1, 1)
GO
INSERT [dbo].[Banner] ([MaBanner], [HinhAnh], [TieuDe], [LienKet], [ThuTu], [HienThi]) VALUES (3, N'banner2.png', N'Đại tiệc Laptop Gaming - Chiến game cực đỉnh', N'ChiTietSanPham?id=2', 2, 1)
GO
INSERT [dbo].[Banner] ([MaBanner], [HinhAnh], [TieuDe], [LienKet], [ThuTu], [HienThi]) VALUES (4, N'banner3.png', N'MacBook Air M1 - Mỏng nhẹ thời thượng', N'ChiTietSanPham.aspx?id=3', 3, 1)
GO
SET IDENTITY_INSERT [dbo].[Banner] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietDon] ON 
GO
INSERT [dbo].[ChiTietDon] ([MaCT], [MaDon], [MaMay], [SoLuong], [GiaBan]) VALUES (1, 2, 4, 1, CAST(24990000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietDon] ([MaCT], [MaDon], [MaMay], [SoLuong], [GiaBan]) VALUES (2, 3, 4, 1, CAST(24990000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietDon] ([MaCT], [MaDon], [MaMay], [SoLuong], [GiaBan]) VALUES (3, 3, 1, 1, CAST(15000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietDon] ([MaCT], [MaDon], [MaMay], [SoLuong], [GiaBan]) VALUES (5, 5, 10, 1, CAST(18990000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietDon] ([MaCT], [MaDon], [MaMay], [SoLuong], [GiaBan]) VALUES (6, 6, 12, 1, CAST(26400000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietDon] ([MaCT], [MaDon], [MaMay], [SoLuong], [GiaBan]) VALUES (7, 7, 12, 1, CAST(26400000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[ChiTietDon] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietNhap] ON 
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (1, 1, 4, 2, CAST(25500000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (2, 1, 7, 2, CAST(23000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (3, 2, 4, 2, CAST(25500000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (4, 2, 7, 2, CAST(23000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (5, 3, 12, 2, CAST(22300000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (6, 4, 12, 1, CAST(23000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (7, 5, 12, 1, CAST(23300000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (8, 6, 12, 1, CAST(24000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (9, 7, 12, 1, CAST(24000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (10, 8, 8, 1, CAST(15500000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ChiTietNhap] ([MaCTN], [MaNhap], [MaMay], [SoLuong], [GiaNhap]) VALUES (11, 9, 8, 2, CAST(16500000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[ChiTietNhap] OFF
GO
SET IDENTITY_INSERT [dbo].[DonDatHang] ON 
GO
INSERT [dbo].[DonDatHang] ([MaDon], [MaND], [NgayDat], [TrangThai], [TongTien], [DiaChiGiaoHang]) VALUES (2, 3, CAST(N'2026-01-11T12:10:17.277' AS DateTime), N'Đã giao', CAST(24990000.00 AS Decimal(18, 2)), N'Nguyễn Văn A - 0912345678 - Số 123, Phường An Hội, Tỉnh Vĩnh Long')
GO
INSERT [dbo].[DonDatHang] ([MaDon], [MaND], [NgayDat], [TrangThai], [TongTien], [DiaChiGiaoHang]) VALUES (3, 2, CAST(N'2026-01-11T12:20:11.027' AS DateTime), N'Đã giao', CAST(39990000.00 AS Decimal(18, 2)), N'Nguyễn Trung Hiếu - 0975728913 - Bến Tre')
GO
INSERT [dbo].[DonDatHang] ([MaDon], [MaND], [NgayDat], [TrangThai], [TongTien], [DiaChiGiaoHang]) VALUES (5, 3, CAST(N'2026-01-11T12:38:12.037' AS DateTime), N'Đã giao', CAST(18990000.00 AS Decimal(18, 2)), N'Nguyễn Văn A - 0912345678 - Số 123, Phường An Hội, Tỉnh Vĩnh Long')
GO
INSERT [dbo].[DonDatHang] ([MaDon], [MaND], [NgayDat], [TrangThai], [TongTien], [DiaChiGiaoHang]) VALUES (6, 10, CAST(N'2026-01-11T17:04:43.413' AS DateTime), N'Đã giao', CAST(26400000.00 AS Decimal(18, 2)), N'Nguyễn Văn B - 0918838483 - 234, Sơn Đông, Vĩnh Long')
GO
INSERT [dbo].[DonDatHang] ([MaDon], [MaND], [NgayDat], [TrangThai], [TongTien], [DiaChiGiaoHang]) VALUES (7, 10, CAST(N'2026-01-11T17:47:09.147' AS DateTime), N'Đã giao', CAST(26400000.00 AS Decimal(18, 2)), N'Nguyễn Văn B - 0918838483 - 234, Sơn Đông, Vĩnh Long')
GO
SET IDENTITY_INSERT [dbo].[DonDatHang] OFF
GO
SET IDENTITY_INSERT [dbo].[DonNhap] ON 
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (1, 3, CAST(N'2026-01-11T14:43:26.370' AS DateTime), CAST(97000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (2, 3, CAST(N'2026-01-11T14:47:03.000' AS DateTime), CAST(97000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (3, 3, CAST(N'2026-01-11T15:56:46.967' AS DateTime), CAST(44600000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (4, 3, CAST(N'2026-01-11T16:10:29.123' AS DateTime), CAST(23000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (5, 3, CAST(N'2026-01-11T16:29:49.640' AS DateTime), CAST(23300000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (6, 3, CAST(N'2026-01-11T16:35:01.607' AS DateTime), CAST(24000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (7, 3, CAST(N'2026-01-11T16:35:21.760' AS DateTime), CAST(24000000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (8, 3, CAST(N'2026-01-11T16:36:04.697' AS DateTime), CAST(15500000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[DonNhap] ([MaNhap], [MaNPP], [NgayNhap], [TongTien]) VALUES (9, 3, CAST(N'2026-01-11T19:12:25.193' AS DateTime), CAST(33000000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[DonNhap] OFF
GO
SET IDENTITY_INSERT [dbo].[MayTinh] ON 
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (1, N'Dell Inspiron 15', N'Core i5, 8GB RAM', 1, CAST(15000000.00 AS Decimal(18, 2)), N'dell.png', 9, CAST(N'2026-01-10T20:22:26.207' AS DateTime), N'
<h3>Thiết kế bền bỉ, đậm chất văn phòng</h3>
<p>Dell Inspiron 15 mang ngôn ngữ thiết kế tối giản nhưng hiện đại. Vỏ máy được hoàn thiện từ chất liệu nhựa cứng cao cấp (hoặc kim loại tùy phiên bản), giúp máy có khả năng chịu va đập tốt, sẵn sàng đồng hành cùng bạn trong mọi chuyến đi học hay công tác mà không lo hỏng hóc vặt.</p>

<h3>Màn hình 15.6 inch rộng rãi</h3>
<p>Sở hữu màn hình kích thước lớn <strong>15.6 inch Full HD</strong>, Dell Inspiron 15 mang lại không gian làm việc thoải mái. Viền màn hình mỏng (Narrow Border) giúp tăng tỷ lệ hiển thị, kết hợp với công nghệ chống chói <strong>Anti-Glare</strong> giúp bảo vệ mắt khi làm việc lâu hoặc ở nơi có ánh sáng mạnh.</p>

<h3>Bàn phím Full-size tiện lợi</h3>
<p>Điểm cộng lớn cho dân kế toán và nhập liệu là cụm bàn phím số (Numpad) riêng biệt. Hành trình phím sâu, độ nảy tốt giúp việc soạn thảo văn bản trở nên êm ái và chính xác hơn bao giờ hết.</p>

<h3>Hiệu năng ổn định</h3>
<p>Máy được trang bị cấu hình tối ưu cho các tác vụ văn phòng như Word, Excel, PowerPoint và lướt web đa nhiệm. Thời lượng pin đủ dùng cho một buổi làm việc, đảm bảo hiệu suất công việc luôn được duy trì.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (2, N'Asus TUF Gaming', N'Core i7, RTX 3050', 2, CAST(20000000.00 AS Decimal(18, 2)), N'asus.png', 5, CAST(N'2026-01-10T20:22:26.207' AS DateTime), N'
<h3>Độ bền chuẩn quân đội Mỹ</h3>
<p>Đúng như tên gọi "The Ultimate Force", Asus TUF Gaming vượt qua hàng loạt bài kiểm tra khắc nghiệt về độ bền chuẩn quân đội <strong>MIL-STD-810H</strong>. Từ va đập, rung lắc cho đến nhiệt độ khắc nghiệt, chiếc laptop này vẫn hoạt động bền bỉ như một "cỗ xe tăng" thực thụ.</p>

<h3>Màn hình 144Hz - Lợi thế cho game thủ</h3>
<p>Sở hữu tần số quét <strong>144Hz</strong>, Asus TUF loại bỏ hoàn toàn hiện tượng xé hình và giật lag. Đây là vũ khí lợi hại trong các tựa game bắn súng FPS (CS:GO, Valorant, PUBG), giúp bạn nhìn thấy đối thủ trước khi họ nhìn thấy bạn.</p>

<h3>Hệ thống tản nhiệt tối ưu</h3>
<p>Công nghệ tản nhiệt HyperCool với quạt kép tự làm sạch bụi bẩn giúp máy luôn mát mẻ ngay cả khi chiến game nặng trong thời gian dài. Bạn có thể tùy chỉnh các chế độ quạt (Silent, Performance, Turbo) để phù hợp với nhu cầu sử dụng.</p>

<h3>Cấu hình chiến game mạnh mẽ</h3>
<p>Sự kết hợp giữa CPU hiệu năng cao và card rời dòng <strong>GTX/RTX</strong> giúp Asus TUF không chỉ chơi mượt các tựa game AAA mà còn xử lý tốt các tác vụ đồ họa 2D, 3D hay dựng video cơ bản.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (3, N'MacBook Air M1', N'M1 Chip, 8GB/256GB', 3, CAST(18500000.00 AS Decimal(18, 2)), N'mac.png', 20, CAST(N'2026-01-10T20:22:26.207' AS DateTime), N'
<h3>Cuộc cách mạng với Apple M1</h3>
<p>MacBook Air M1 đánh dấu bước ngoặt lịch sử với con chip <strong>Apple M1</strong> dựa trên kiến trúc ARM. Hiệu năng CPU nhanh hơn tới 3.5 lần và GPU nhanh hơn 5 lần so với thế hệ trước, cho phép bạn dựng video 4K hay chỉnh sửa ảnh RAW mượt mà đến kinh ngạc.</p>

<h3>Thiết kế không quạt, im lặng tuyệt đối</h3>
<p>Nhờ khả năng quản lý nhiệt xuất sắc của chip M1, Apple đã loại bỏ hoàn toàn quạt tản nhiệt trên MacBook Air. Máy hoạt động <strong>hoàn toàn im lặng</strong>, không gây ra bất kỳ tiếng ồn nào dù bạn đang xử lý tác vụ nặng, mang lại sự tập trung tuyệt đối.</p>

<h3>Màn hình Retina rực rỡ</h3>
<p>Màn hình Retina độ phân giải 2560x1600 với dải màu rộng <strong>P3</strong> và công nghệ <strong>True Tone</strong> giúp hình ảnh hiển thị sắc nét, màu sắc trung thực. Đây là tiêu chuẩn vàng cho các Designer và Creator.</p>

<h3>Thời lượng pin "kỷ lục"</h3>
<p>Với thời lượng pin lên đến <strong>18 giờ</strong> sử dụng liên tục, MacBook Air M1 giải phóng bạn khỏi nỗi lo về sạc. Bạn có thể tự tin mang máy đi làm cả ngày dài mà không cần mang theo cục sạc cồng kềnh.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (4, N'Surface Pro 9', N'Core i5 1235U, 8GB RAM, 256GB SSD, 13" 120Hz Touch', 4, CAST(24990000.00 AS Decimal(18, 2)), N'sur9.png', 16, CAST(N'2026-01-11T09:41:22.887' AS DateTime), N'
<h3>Thiết kế 2-trong-1 đỉnh cao, linh hoạt tối đa</h3>
<p>Surface Pro 9 tiếp tục khẳng định vị thế dẫn đầu trong dòng máy tính lai (2-trong-1). Với trọng lượng chỉ <strong>879g</strong>, máy sở hữu vỏ nhôm nguyên khối cao cấp (Anodized Aluminum) mang lại cảm giác cầm nắm chắc chắn nhưng vô cùng sang trọng. Chân đế Kickstand đặc trưng cho phép gập mở linh hoạt 165 độ, giúp bạn làm việc ở mọi tư thế.</p>

<h3>Màn hình PixelSense Flow 120Hz siêu mượt</h3>
<p>Điểm nhấn lớn nhất là màn hình 13 inch độ phân giải <strong>2880 x 1920 (267 PPI)</strong>. Công nghệ PixelSense Flow hỗ trợ tần số quét <strong>120Hz</strong>, giúp mọi thao tác vuốt chạm, viết vẽ bằng Surface Pen trở nên chân thực như trên giấy. Tỷ lệ màn hình 3:2 tối ưu hóa không gian hiển thị cho các tác vụ văn phòng và lướt web.</p>

<h3>Hiệu năng mạnh mẽ với Intel Gen 12</h3>
<p>Phiên bản này được trang bị vi xử lý <strong>Intel Core i5-1235U</strong> (10 nhân, 12 luồng), mạnh hơn gấp đôi so với người tiền nhiệm Surface Pro 8. Kết hợp với 8GB RAM LPDDR5 và ổ cứng SSD 256GB tốc độ cao, Surface Pro 9 xử lý mượt mà mọi tác vụ từ Word, Excel nặng cho đến chỉnh sửa ảnh cơ bản trên Photoshop/Lightroom.</p>

<h3>Kết nối hiện đại</h3>
<ul>
    <li>2 cổng <strong>Thunderbolt 4</strong> (USB-C): Hỗ trợ xuất ra màn hình 4K, sạc nhanh và truyền dữ liệu tốc độ cao.</li>
    <li>Wi-Fi 6E và Bluetooth 5.1 cho kết nối không dây ổn định nhất.</li>
    <li>Camera trước 1080p và Camera sau 10MP hỗ trợ quay video 4K.</li>
</ul>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (5, N'Surface Laptop 5', N'Core i7 1255U, 16GB RAM, 512GB SSD, 13.5" 2K Touch', 4, CAST(29500000.00 AS Decimal(18, 2)), N'surface-laptop-5.jpg', 8, CAST(N'2026-01-11T09:41:22.887' AS DateTime), N'
<h3>Vẻ đẹp hoàn hảo của sự tối giản</h3>
<p>Surface Laptop 5 giữ nguyên ngôn ngữ thiết kế đã làm nên tên tuổi của dòng máy này: Mỏng, nhẹ và cực kỳ tinh tế. Bạn sẽ có hai tùy chọn hoàn thiện: Vỏ nhôm nguyên khối mát lạnh hoặc lớp vải <strong>Alcantara</strong> êm ái, chống bám bẩn ở phần kê tay. Độ hoàn thiện của máy đạt mức "tuyệt đối", không một chi tiết thừa.</p>

<h3>Màn hình cảm ứng rực rỡ</h3>
<p>Màn hình 13.5 inch PixelSense hiển thị màu sắc cực kỳ chính xác (100% sRGB). Đặc biệt, công nghệ <strong>Dolby Vision IQ</strong> giúp tự động điều chỉnh độ tương phản và độ sáng dựa trên ánh sáng môi trường, mang lại trải nghiệm xem phim điện ảnh sống động.</p>

<h3>Nâng cấp sức mạnh với Thunderbolt 4</h3>
<p>Lần đầu tiên, Microsoft trang bị cổng <strong>Thunderbolt 4</strong> cho dòng Laptop 5, cho phép kết nối với eGPU hoặc xuất ra nhiều màn hình 4K cùng lúc. Vi xử lý <strong>Intel Core i7-1255U</strong> đạt chuẩn Intel Evo, đảm bảo máy luôn thức giấc ngay lập tức (Instant Wake) và có thời lượng pin lên tới <strong>18 giờ</strong> sử dụng hỗn hợp.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (6, N'Surface Laptop Go 3', N'Core i5 1235U, 8GB RAM, 128GB SSD, 12.4" Touch', 4, CAST(14500000.00 AS Decimal(18, 2)), N'surface-go-3.jpg', 15, CAST(N'2026-01-11T09:41:22.887' AS DateTime), N'
<h3>Nhỏ gọn nhưng không "rẻ tiền"</h3>
<p>Surface Laptop Go 3 là chiếc laptop Surface nhẹ nhất (chỉ <strong>1.13kg</strong>) nhưng vẫn giữ được sự cao cấp nhờ nắp lưng bằng nhôm và đế bằng nhựa tổng hợp polycarbonate siêu bền. Đây là sự lựa chọn hoàn hảo cho học sinh, sinh viên hoặc những người thường xuyên phải di chuyển.</p>

<h3>Hiệu năng vượt trội trong tầm giá</h3>
<p>Dù là dòng máy "bình dân" của Microsoft, nhưng Go 3 vẫn được ưu ái trang bị con chip <strong>Intel Core i5-1235U</strong> y hệt như đàn anh Surface Pro 9. Điều này giúp máy chạy nhanh hơn 88% so với phiên bản Go đời đầu. Bạn hoàn toàn yên tâm sử dụng máy trong 3-4 năm tới mà không lo giật lag.</p>

<h3>Bảo mật vân tay một chạm</h3>
<p>Nút nguồn tích hợp cảm biến vân tay (Fingerprint Power Button) giúp bạn đăng nhập vào Windows chỉ trong nháy mắt, an toàn và tiện lợi hơn nhập mật khẩu truyền thống rất nhiều.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (7, N'Surface Laptop Studio 2', N'Core i7 13700H, 32GB RAM, RTX 4050, 1TB SSD', 4, CAST(55900000.00 AS Decimal(18, 2)), N'surface-studio-2.jpg', 7, CAST(N'2026-01-11T09:41:22.887' AS DateTime), N'
<h3>Thiết kế độc bản cho nhà sáng tạo</h3>
<p>Surface Laptop Studio 2 sở hữu thiết kế bản lề <strong>Dynamic Woven Hinge</strong> độc nhất vô nhị, cho phép chuyển đổi linh hoạt giữa 3 chế độ:</p>
<ul>
    <li><strong>Laptop Mode:</strong> Sử dụng như máy tính xách tay bình thường với bàn phím và touchpad xúc giác cực lớn.</li>
    <li><strong>Stage Mode:</strong> Kéo màn hình về phía trước để xem phim, thuyết trình hoặc chơi game bằng tay cầm.</li>
    <li><strong>Studio Mode:</strong> Gập phẳng màn hình xuống để biến thành một chiếc bảng vẽ kỹ thuật số khổng lồ.</li>
</ul>

<h3>Cấu hình "quái vật"</h3>
<p>Đây là chiếc Surface mạnh nhất lịch sử với vi xử lý <strong>Intel Core i7-13700H</strong> (Dòng H hiệu năng cao) và card đồ họa rời <strong>NVIDIA GeForce RTX 4050</strong>. Cấu hình này dư sức để render video 4K, thiết kế 3D chuyên nghiệp hay chiến các tựa game AAA mượt mà.</p>

<h3>Màn hình 14.4 inch 120Hz chuẩn màu</h3>
<p>Màn hình PixelSense Flow 14.4 inch hỗ trợ HDR, độ sáng cực cao và tần số quét 120Hz. Đặc biệt, máy tương thích hoàn hảo với bút <strong>Surface Slim Pen 2</strong>, mang lại cảm giác phản hồi xúc giác (haptic feedback) như đang viết trên giấy thật.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (8, N'HP Pavilion 15', N'Core i5 1240P, 16GB RAM, 512GB SSD, 15.6" FHD IPS', 5, CAST(18150000.00 AS Decimal(18, 2)), N'hp-pavilion-15.jpg', 23, CAST(N'2026-01-11T11:09:32.910' AS DateTime), N'<h3>Vẻ đẹp hiện đại, thanh lịch</h3>
    <p>HP Pavilion 15 sở hữu thiết kế nắp lưng bằng kim loại nhôm nhám sang trọng, ít bám vân tay. Logo HP mạ crom sáng bóng ở giữa tạo điểm nhấn tinh tế. Máy chỉ nhẹ khoảng 1.7kg, rất thuận tiện để mang đi học hay đi làm hàng ngày.</p>

    <h3>Giải trí đỉnh cao với loa B&O</h3>
    <p>Điểm "ăn tiền" nhất trên các dòng HP chính là hệ thống âm thanh được tinh chỉnh bởi hãng <strong>Bang & Olufsen (B&O)</strong> Đan Mạch. Âm thanh trong trẻo, lọc tiếng ồn tốt, giúp bạn có những phút giây nghe nhạc, xem phim tuyệt vời sau giờ làm việc.</p>

    <h3>Hiệu năng mạnh mẽ cho văn phòng</h3>
    <p>Sức mạnh từ con chip <strong>Intel Core i5 dòng P</strong> (hiệu năng cao) giúp máy xử lý mượt mà mọi tác vụ văn phòng nặng, thậm chí là thiết kế 2D cơ bản trên Canva, Photoshop mà không hề giật lag.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (9, N'HP Envy 13 ba1536TU', N'Core i7 1165G7, 8GB RAM, 512GB SSD, 13.3" FHD Tràn viền', 5, CAST(21500000.00 AS Decimal(18, 2)), N'hp-envy-13.jpg', 8, CAST(N'2026-01-11T11:09:32.910' AS DateTime), N'<h3>Tuyệt tác thiết kế mỏng nhẹ</h3>
    <p>HP Envy 13 được ví như một món trang sức công nghệ với vỏ nhôm nguyên khối màu vàng Gold (hoặc Bạc) cực kỳ sang chảnh. Máy siêu mỏng và siêu nhẹ, sẵn sàng nằm gọn trong túi xách của các doanh nhân bận rộn.</p>

    <h3>Màn hình tràn viền vô cực</h3>
    <p>Thiết kế viền màn hình siêu mỏng (Micro-Edge) cho cảm giác hình ảnh như "tràn" ra khỏi khung hình. Độ phủ màu <strong>100% sRGB</strong> mang lại màu sắc rực rỡ, chân thực, rất thích hợp cho nhu cầu chỉnh sửa ảnh bán chuyên.</p>

    <h3>Bảo mật tối đa</h3>
    <p>HP trang bị cho Envy 13 đầy đủ các công nghệ bảo mật hiện đại nhất: Cảm biến vân tay một chạm và nút gạt tắt Camera vật lý, đảm bảo sự riêng tư tuyệt đối cho dữ liệu của bạn.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (10, N'HP Victus 15 2023', N'Ryzen 5 5600H, 16GB RAM, RTX 3050 4GB, 144Hz', 5, CAST(18990000.00 AS Decimal(18, 2)), N'hp-victus-15.jpg', 11, CAST(N'2026-01-11T11:09:32.910' AS DateTime), N'<h3>DNA của dòng OMEN cao cấp</h3>
    <p>Thừa hưởng thiết kế từ dòng OMEN huyền thoại, HP Victus 15 có vẻ ngoài vuông vức, mạnh mẽ với logo chữ "V" nổi bật. Khe tản nhiệt phía sau được thiết kế rộng, tối ưu luồng khí giúp máy luôn mát mẻ khi chiến game.</p>

    <h3>Màn hình 144Hz mượt mà</h3>
    <p>Tần số quét <strong>144Hz</strong> là tiêu chuẩn vàng cho game thủ FPS. Mọi chuyển động trong CS:GO, Valorant hay PUBG đều được tái hiện mượt mà, không xé hình, giúp bạn phản xạ nhanh hơn đối thủ.</p>

    <h3>Cấu hình chiến game ngon trong tầm giá</h3>
    <p>Sự kết hợp giữa <strong>AMD Ryzen 5</strong> và card rời <strong>NVIDIA RTX 3050</strong> mang lại hiệu năng ấn tượng. Máy chiến tốt các tựa game AAA ở mức thiết lập trung bình-cao và dư sức làm đồ họa 3D, dựng video Full HD.</p>')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (11, N'HP Spectre x360 14''''', N'<p>Core i7 1355U, 16GB RAM, 1TB SSD, 13.5&quot; 3K2K OLED</p>
', 5, CAST(38990000.00 AS Decimal(18, 2)), N'639037399944222016.png', 5, CAST(N'2026-01-11T11:11:36.690' AS DateTime), N'<h3><strong>Vi&ecirc;n ngọc qu&yacute; của l&agrave;ng c&ocirc;ng nghệ</strong></h3>

<p>HP Spectre x360 sở hữu thiết kế <strong>Gem-Cut</strong> (v&aacute;t cạnh kim cương) độc bản, kh&ocirc;ng thể nhầm lẫn. C&aacute;c g&oacute;c cạnh được cắt CNC tinh xảo, kết hợp với m&agrave;u Xanh biển s&acirc;u (Nocturne Blue) hoặc Đen nh&aacute;m (Nightfall Black) tạo n&ecirc;n vẻ đẹp sang trọng, cuốn h&uacute;t mọi &aacute;nh nh&igrave;n.</p>

<h3>M&agrave;n h&igrave;nh OLED 3K2K tuyệt mỹ</h3>

<p>&nbsp;</p>

<p>Trải nghiệm thị gi&aacute;c b&ugrave;ng nổ với tấm nền <strong>OLED</strong> độ ph&acirc;n giải 3K2K (3000x2000). M&agrave;u đen s&acirc;u thẳm, độ tương phản v&ocirc; cực v&agrave; dải m&agrave;u 100% DCI-P3 khiến h&igrave;nh ảnh trở n&ecirc;n sống động như thật. Tỷ lệ m&agrave;n h&igrave;nh 3:2 gi&uacute;p hiển thị nhiều nội dung hơn khi lướt web v&agrave; l&agrave;m việc.</p>

<h3>Xoay gập 360 độ linh hoạt</h3>

<p>L&agrave; d&ograve;ng m&aacute;y 2-trong-1, Spectre c&oacute; thể gập ngược 360 độ để biến th&agrave;nh một chiếc m&aacute;y t&iacute;nh bảng mạnh mẽ. Đi k&egrave;m theo m&aacute;y l&agrave; b&uacute;t cảm ứng <strong>HP Rechargeable MPP 2.0</strong>, cho ph&eacute;p bạn viết vẽ, ghi ch&uacute; trực tiếp l&ecirc;n m&agrave;n h&igrave;nh với độ trễ gần như bằng kh&ocirc;ng.</p>

<h3>Bảo mật &amp; Hiệu năng đỉnh cao</h3>

<p>M&aacute;y đạt chuẩn <strong>Intel Evo</strong>, đảm bảo hiệu năng mạnh mẽ, khởi động tức th&igrave; v&agrave; pin d&ugrave;ng cả ng&agrave;y. C&aacute;c t&iacute;nh năng bảo mật như nhận diện khu&ocirc;n mặt IR, cảm biến v&acirc;n tay v&agrave; n&uacute;t tắt camera vật l&yacute; đều được trang bị đầy đủ.</p>
')
GO
INSERT [dbo].[MayTinh] ([MaMay], [TenMay], [CauHinh], [MaTH], [GiaBan], [HinhAnh], [TonKho], [NgayTao], [MoTa]) VALUES (12, N'Surface Laptop 7', N'Snapdragon X Plus,16GB/256GB,13.8 inch
', 4, CAST(26400000.00 AS Decimal(18, 2)), N'639037401572100080.png', 7, CAST(N'2026-01-11T14:55:57.230' AS DateTime), N'<h1><span style="color:#1abc9c">Surface Laptop 7</span>: Trải Nghiệm Ho&agrave;n Hảo Từ Hiệu Năng Đến Thiết Kế</h1>

<p>D&ograve;ng chip Snapdragon X của Qualcomm l&agrave; thứ m&agrave; ch&uacute;ng ta đ&atilde; chờ đợi suốt 7 năm, kể từ khi Windows on Arm trở th&agrave;nh hiện thực. Cuối c&ugrave;ng họ cũng đ&atilde; c&oacute; mặt với một loạt 14 thiết bị ra mắt từ bảy OEM. Dẫn đầu l&agrave; Microsoft với&nbsp;<strong>Surface Laptop 7</strong>&nbsp;v&agrave;&nbsp;<strong>Surface Pro 11</strong>.</p>

<p>Laptop lu&ocirc;n l&agrave; một thiết bị th&uacute; vị, với b&agrave;n ph&iacute;m tuyệt vời v&agrave; &iacute;t nhất l&agrave; m&agrave;n h&igrave;nh ở mức kh&aacute;, c&ugrave;ng với khung nh&ocirc;m cao cấp.</p>

<p>Phần cứng đ&atilde; được cải tiến đ&aacute;ng kể. Khung m&aacute;y c&oacute; diện t&iacute;ch nhỏ hơn lần đầu ti&ecirc;n kể từ khi&nbsp;<strong>Surface Laptop 3</strong>&nbsp;ra mắt (mẫu 13,8 inch l&agrave; mẫu đầu ti&ecirc;n được thay đổi kể từ Surface Laptop ban đầu) v&agrave; bổ sung th&ecirc;m những thứ như b&agrave;n di chuột x&uacute;c gi&aacute;c, webcam tốt hơn, v.v. Tr&ecirc;n mẫu nhỏ hơn, m&aacute;y c&oacute; nhiều m&agrave;u sắc đẹp mắt, như Dune v&agrave; Sapphire.</p>

<p>Nhưng Snapdragon X Elite l&agrave; thứ khiến n&oacute; thực sự tỏa s&aacute;ng, mặc d&ugrave; n&oacute; kh&ocirc;ng ho&agrave;n hảo. Con chip mới kết hợp sức mạnh v&agrave; hiệu quả, hướng đến mục ti&ecirc;u cạnh tranh với MacBooks v&agrave; c&oacute; vẻ như n&oacute; đ&atilde; l&agrave;m được. Vẫn c&ograve;n một số vấn đề nhỏ về khả năng tương th&iacute;ch, nhưng &iacute;t nhất, hầu hết c&aacute;c ứng dụng sử dụng hiện đều l&agrave; ứng dụng gốc, v&igrave; vậy&nbsp;<strong>Surface Laptop 7</strong>&nbsp;rất tuyệt vời. T&ocirc;i nghĩ đ&acirc;y l&agrave; Surface Laptop tốt nhất từ ​​trước đến nay.</p>
')
GO
SET IDENTITY_INSERT [dbo].[MayTinh] OFF
GO
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (1, N'Quản Trị Viên', N'admin@hieu.com', N'123', N'0999888777', N'Server', N'Admin', CAST(N'2026-01-10T20:22:26.210' AS DateTime))
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (2, N'Nguyễn Trung Hiếu', N'hieu@gmail.com', N'456', N'0975728913', N'Bến Tre', N'Khach', CAST(N'2026-01-10T20:22:26.210' AS DateTime))
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (3, N'Nguyễn Văn A', NULL, N'0912345678', N'0912345678', N'Số 123, Phường An Hội, Tỉnh Vĩnh Long', N'Khach', CAST(N'2026-01-11T12:10:17.267' AS DateTime))
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (7, N'Khách hàng 2', NULL, N'0912345679', N'0912345679', N'', N'Khach', CAST(N'2026-01-11T13:30:04.467' AS DateTime))
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (8, N'khách hàng 5', NULL, N'123', N'0912345999', N'', N'Khach', CAST(N'2026-01-11T13:48:29.200' AS DateTime))
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (9, N'khách hàng 8', NULL, N'123', N'0912345671', N'', N'Khach', CAST(N'2026-01-11T13:49:16.137' AS DateTime))
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (10, N'Nguyễn Văn B', N'', N'456', N'0918838483', N'234, Sơn Đông, Vĩnh Long', N'Khach', CAST(N'2026-01-11T17:04:43.400' AS DateTime))
GO
INSERT [dbo].[NguoiDung] ([MaND], [HoTen], [Email], [MatKhau], [SoDienThoai], [DiaChi], [VaiTro], [NgayTao]) VALUES (13, N'Nguyễn Văn C', N'NguyenC@gmail.com', N'1234', N'0912345673', N'', N'Khach', CAST(N'2026-01-11T18:08:07.700' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
GO
SET IDENTITY_INSERT [dbo].[NhaPhanPhoi] ON 
GO
INSERT [dbo].[NhaPhanPhoi] ([MaNPP], [TenNPP], [DiaChi], [SoDienThoai], [Email]) VALUES (1, N'FPT Synnex', N'Hà Nội', N'0901234567', NULL)
GO
INSERT [dbo].[NhaPhanPhoi] ([MaNPP], [TenNPP], [DiaChi], [SoDienThoai], [Email]) VALUES (2, N'Digiworld', N'TPHCM', N'0909888777', NULL)
GO
INSERT [dbo].[NhaPhanPhoi] ([MaNPP], [TenNPP], [DiaChi], [SoDienThoai], [Email]) VALUES (3, N'Microsoft Việt Nam', N'Thành phố HCM', N'088888888', N'')
GO
SET IDENTITY_INSERT [dbo].[NhaPhanPhoi] OFF
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] ON 
GO
INSERT [dbo].[ThuongHieu] ([MaTH], [TenTH], [MoTa], [ThuTu]) VALUES (1, N'Dell', N'Bền bỉ từ Mỹ', 3)
GO
INSERT [dbo].[ThuongHieu] ([MaTH], [TenTH], [MoTa], [ThuTu]) VALUES (2, N'Asus', N'Gaming và Văn phòng', 5)
GO
INSERT [dbo].[ThuongHieu] ([MaTH], [TenTH], [MoTa], [ThuTu]) VALUES (3, N'MacBook', N'Sang trọng từ Apple', 2)
GO
INSERT [dbo].[ThuongHieu] ([MaTH], [TenTH], [MoTa], [ThuTu]) VALUES (4, N'Surface', N'Máy tính cao cấp, sang trọng từ Microsoft', 1)
GO
INSERT [dbo].[ThuongHieu] ([MaTH], [TenTH], [MoTa], [ThuTu]) VALUES (5, N'HP', N'Laptop công nghệ Mỹ - Bền bỉ, Thời trang & Âm thanh đỉnh cao', 4)
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF
GO
SET IDENTITY_INSERT [dbo].[ThuVienAnh] ON 
GO
INSERT [dbo].[ThuVienAnh] ([MaAnh], [MaMay], [DuongDan], [SapXep]) VALUES (1, 4, N'surface-Pro-9-sub1.png', 1)
GO
INSERT [dbo].[ThuVienAnh] ([MaAnh], [MaMay], [DuongDan], [SapXep]) VALUES (2, 4, N'surface-Pro-9-sub2.png', 2)
GO
INSERT [dbo].[ThuVienAnh] ([MaAnh], [MaMay], [DuongDan], [SapXep]) VALUES (3, 4, N'surface-Pro-9-sub3.png', 3)
GO
INSERT [dbo].[ThuVienAnh] ([MaAnh], [MaMay], [DuongDan], [SapXep]) VALUES (4, 4, N'surface-Pro-9-sub4.png', 4)
GO
INSERT [dbo].[ThuVienAnh] ([MaAnh], [MaMay], [DuongDan], [SapXep]) VALUES (5, 12, N'639037418844731361_album_Screenshot 2026-01-11 145447.png', 0)
GO
INSERT [dbo].[ThuVienAnh] ([MaAnh], [MaMay], [DuongDan], [SapXep]) VALUES (6, 12, N'639037418844845907_album_Screenshot 2026-01-11 152402.png', 0)
GO
INSERT [dbo].[ThuVienAnh] ([MaAnh], [MaMay], [DuongDan], [SapXep]) VALUES (7, 12, N'639037418844916432_album_Screenshot 2026-01-11 152419.png', 0)
GO
SET IDENTITY_INSERT [dbo].[ThuVienAnh] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_NguoiDung_Email_Hople]    Script Date: 1/11/2026 7:20:04 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_NguoiDung_Email_Hople] ON [dbo].[NguoiDung]
(
	[Email] ASC
)
WHERE ([Email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ThuongHi__4CF9E74A2531E8E5]    Script Date: 1/11/2026 7:20:04 PM ******/
ALTER TABLE [dbo].[ThuongHieu] ADD UNIQUE NONCLUSTERED 
(
	[TenTH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Banner] ADD  DEFAULT ((0)) FOR [ThuTu]
GO
ALTER TABLE [dbo].[Banner] ADD  DEFAULT ((1)) FOR [HienThi]
GO
ALTER TABLE [dbo].[DonDatHang] ADD  DEFAULT (getdate()) FOR [NgayDat]
GO
ALTER TABLE [dbo].[DonDatHang] ADD  DEFAULT (N'Chờ duyệt') FOR [TrangThai]
GO
ALTER TABLE [dbo].[DonDatHang] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[DonNhap] ADD  DEFAULT (getdate()) FOR [NgayNhap]
GO
ALTER TABLE [dbo].[DonNhap] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[MayTinh] ADD  DEFAULT ((0)) FOR [GiaBan]
GO
ALTER TABLE [dbo].[MayTinh] ADD  DEFAULT ((0)) FOR [TonKho]
GO
ALTER TABLE [dbo].[MayTinh] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[NguoiDung] ADD  DEFAULT ('Khach') FOR [VaiTro]
GO
ALTER TABLE [dbo].[NguoiDung] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[ThuongHieu] ADD  DEFAULT ((50)) FOR [ThuTu]
GO
ALTER TABLE [dbo].[ThuVienAnh] ADD  DEFAULT ((0)) FOR [SapXep]
GO
ALTER TABLE [dbo].[ChiTietDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDon_DonDatHang] FOREIGN KEY([MaDon])
REFERENCES [dbo].[DonDatHang] ([MaDon])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDon] CHECK CONSTRAINT [FK_ChiTietDon_DonDatHang]
GO
ALTER TABLE [dbo].[ChiTietDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDon_MayTinh] FOREIGN KEY([MaMay])
REFERENCES [dbo].[MayTinh] ([MaMay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDon] CHECK CONSTRAINT [FK_ChiTietDon_MayTinh]
GO
ALTER TABLE [dbo].[ChiTietNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietNhap_DonNhap] FOREIGN KEY([MaNhap])
REFERENCES [dbo].[DonNhap] ([MaNhap])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietNhap] CHECK CONSTRAINT [FK_ChiTietNhap_DonNhap]
GO
ALTER TABLE [dbo].[ChiTietNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietNhap_MayTinh] FOREIGN KEY([MaMay])
REFERENCES [dbo].[MayTinh] ([MaMay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietNhap] CHECK CONSTRAINT [FK_ChiTietNhap_MayTinh]
GO
ALTER TABLE [dbo].[DonDatHang]  WITH CHECK ADD  CONSTRAINT [FK_DonDatHang_NguoiDung] FOREIGN KEY([MaND])
REFERENCES [dbo].[NguoiDung] ([MaND])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DonDatHang] CHECK CONSTRAINT [FK_DonDatHang_NguoiDung]
GO
ALTER TABLE [dbo].[DonNhap]  WITH CHECK ADD  CONSTRAINT [FK_DonNhap_NhaPhanPhoi] FOREIGN KEY([MaNPP])
REFERENCES [dbo].[NhaPhanPhoi] ([MaNPP])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DonNhap] CHECK CONSTRAINT [FK_DonNhap_NhaPhanPhoi]
GO
ALTER TABLE [dbo].[MayTinh]  WITH CHECK ADD  CONSTRAINT [FK_MayTinh_ThuongHieu] FOREIGN KEY([MaTH])
REFERENCES [dbo].[ThuongHieu] ([MaTH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MayTinh] CHECK CONSTRAINT [FK_MayTinh_ThuongHieu]
GO
ALTER TABLE [dbo].[ThuVienAnh]  WITH CHECK ADD  CONSTRAINT [FK_ThuVienAnh_MayTinh] FOREIGN KEY([MaMay])
REFERENCES [dbo].[MayTinh] ([MaMay])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThuVienAnh] CHECK CONSTRAINT [FK_ThuVienAnh_MayTinh]
GO
ALTER TABLE [dbo].[ChiTietDon]  WITH CHECK ADD CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[ChiTietNhap]  WITH CHECK ADD CHECK  (([GiaNhap]>=(0)))
GO
ALTER TABLE [dbo].[ChiTietNhap]  WITH CHECK ADD CHECK  (([SoLuong]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[sp_CapNhatGiaBan]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CapNhatGiaBan]
    @MaMay INT,
    @GiaBan DECIMAL(18,2)
AS
BEGIN
    UPDATE MayTinh 
    SET GiaBan = @GiaBan 
    WHERE MaMay = @MaMay;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CapNhatMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Cập nhật Máy Tính
CREATE   PROCEDURE [dbo].[sp_CapNhatMayTinh]
    @MaMay INT,
    @TenMay NVARCHAR(200),
    @CauHinh NVARCHAR(MAX),
    @MaTH INT,
    @GiaBan DECIMAL(18,2),
    @HinhAnh NVARCHAR(255),
    @MoTa NVARCHAR(MAX)
AS
BEGIN
    UPDATE MayTinh
    SET TenMay = @TenMay,
        CauHinh = @CauHinh,
        MaTH = @MaTH,
        GiaBan = @GiaBan,
        HinhAnh = @HinhAnh,
        MoTa = @MoTa
    WHERE MaMay = @MaMay;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CapNhatNguoiDung]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CapNhatNguoiDung]
    @MaND INT,
    @HoTen NVARCHAR(150),
    @Email VARCHAR(100),
    @SoDienThoai VARCHAR(20),
    @DiaChi NVARCHAR(255),
    @VaiTro VARCHAR(20)
AS
BEGIN
    UPDATE NguoiDung
    SET HoTen = @HoTen,
        Email = @Email,
        SoDienThoai = @SoDienThoai,
        DiaChi = @DiaChi,
        VaiTro = @VaiTro
    WHERE MaND = @MaND;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CapNhatThongTin]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CapNhatThongTin]
    @MaTK INT,
    @HoTen NVARCHAR(100),
    @SoDienThoai VARCHAR(20),
    @DiaChi NVARCHAR(255),
    @Email VARCHAR(100)
AS
BEGIN
    -- 1. Kiểm tra trùng Số điện thoại (Trừ chính mình ra: MaTK != @MaTK)
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE SoDienThoai = @SoDienThoai AND MaTK != @MaTK)
    BEGIN
        SELECT -1; -- Mã lỗi: Trùng SĐT
        RETURN;
    END

    -- 2. Kiểm tra trùng Email (Nếu có nhập)
    IF @Email IS NOT NULL AND @Email <> ''
    BEGIN
        IF EXISTS (SELECT 1 FROM TaiKhoan WHERE Email = @Email AND MaTK != @MaTK)
        BEGIN
            SELECT -2; -- Mã lỗi: Trùng Email
            RETURN;
        END
    END

    -- 3. Nếu không trùng thì cho Update
    UPDATE TaiKhoan 
    SET HoTen = @HoTen, 
        SoDienThoai = @SoDienThoai, 
        DiaChi = @DiaChi,
        Email = @Email
    WHERE MaTK = @MaTK;

    SELECT 1; -- Thành công
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CapNhatTrangThaiDon]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Cập nhật trạng thái đơn
CREATE   PROCEDURE [dbo].[sp_CapNhatTrangThaiDon]
    @MaDon INT,
    @TrangThaiMoi NVARCHAR(50)
AS
BEGIN
    UPDATE DonDatHang SET TrangThai = @TrangThaiMoi WHERE MaDon = @MaDon;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CapNhatVaiTroNguoiDung]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Thay đổi vai trò người dùng
CREATE   PROCEDURE [dbo].[sp_CapNhatVaiTroNguoiDung]
    @MaND INT,
    @VaiTroMoi VARCHAR(20)
AS
BEGIN
    UPDATE NguoiDung SET VaiTro = @VaiTroMoi WHERE MaND = @MaND;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DangKyTaiKhoan]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_DangKyTaiKhoan]
    @HoTen NVARCHAR(150),
    @SoDienThoai VARCHAR(20),
    @Email VARCHAR(100) = NULL,
    @MatKhau VARCHAR(255),
    @DiaChi NVARCHAR(255) = NULL
AS
BEGIN
    -- 1. Kiểm tra Số điện thoại
    IF EXISTS (SELECT 1 FROM NguoiDung WHERE SoDienThoai = @SoDienThoai)
    BEGIN
        SELECT -1 AS KetQua; -- Lỗi: Trùng SĐT
        RETURN;
    END

    -- 2. Kiểm tra Email (Chỉ kiểm tra nếu khách có nhập)
    IF @Email IS NOT NULL AND @Email <> ''
    BEGIN
        IF EXISTS (SELECT 1 FROM NguoiDung WHERE Email = @Email)
        BEGIN
            SELECT -2 AS KetQua; -- Lỗi: Trùng Email
            RETURN;
        END
    END

    -- 3. Thêm mới (Mặc định vai trò là 'Khach')
    INSERT INTO NguoiDung(HoTen, SoDienThoai, Email, MatKhau, DiaChi, VaiTro, NgayTao)
    VALUES(@HoTen, @SoDienThoai, @Email, @MatKhau, @DiaChi, 'Khach', GETDATE());

    SELECT 1 AS KetQua; -- Thành công
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DangNhap]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_DangNhap]
    @TaiKhoan VARCHAR(100), -- Nhập Email hoặc SĐT vào đây
    @MatKhau VARCHAR(255)
AS
BEGIN
    SELECT * FROM NguoiDung 
    WHERE (Email = @TaiKhoan OR SoDienThoai = @TaiKhoan) 
      AND MatKhau = @MatKhau;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DoiMatKhau]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Thủ tục Đổi mật khẩu riêng (để an toàn và tách biệt)
CREATE   PROCEDURE [dbo].[sp_DoiMatKhau]
    @MaND INT,
    @MatKhauCu VARCHAR(255),
    @MatKhauMoi VARCHAR(255)
AS
BEGIN
    -- Kiểm tra mật khẩu cũ có đúng không
    IF EXISTS (SELECT 1 FROM NguoiDung WHERE MaND = @MaND AND MatKhau = @MatKhauCu)
    BEGIN
        UPDATE NguoiDung SET MatKhau = @MatKhauMoi WHERE MaND = @MaND;
        SELECT 1 AS KetQua; -- Thành công
    END
    ELSE
    BEGIN
        SELECT 0 AS KetQua; -- Sai mật khẩu cũ
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_HuyDonHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_HuyDonHang]
    @MaDon INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TrangThai NVARCHAR(50);
    
    SELECT @TrangThai = TrangThai FROM DonDatHang WHERE MaDon = @MaDon;

    -- Logic: Cho phép hủy khi Chờ duyệt, Đã duyệt HOẶC Đang giao (khách không nhận)
    IF @TrangThai = N'Chờ duyệt' OR @TrangThai = N'Đã duyệt' OR @TrangThai = N'Đang giao'
    BEGIN
        -- 1. Hoàn tồn kho cho tất cả sản phẩm trong đơn
        UPDATE MayTinh
        SET TonKho = TonKho + c.SoLuong
        FROM MayTinh m
        JOIN ChiTietDon c ON m.MaMay = c.MaMay
        WHERE c.MaDon = @MaDon;

        -- 2. Cập nhật trạng thái thành Đã hủy
        UPDATE DonDatHang 
        SET TrangThai = N'Đã hủy' 
        WHERE MaDon = @MaDon;

        SELECT 1 AS KetQua;
    END
    ELSE
    BEGIN
        SELECT 0 AS KetQua; -- Không được phép hủy khi đã 'Đã giao'
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_KiemTraKhachHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. SP Kiểm tra Khách hàng qua SĐT
CREATE   PROCEDURE [dbo].[sp_KiemTraKhachHang]
    @SoDienThoai VARCHAR(20)
AS
BEGIN
    SELECT * FROM NguoiDung WHERE SoDienThoai = @SoDienThoai;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayBannerHienThi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 1. Lấy danh sách Banner hiển thị
CREATE PROCEDURE [dbo].[sp_LayBannerHienThi]
AS
BEGIN
    SELECT * FROM Banner 
    WHERE HienThi = 1 
    ORDER BY ThuTu ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayChiTietSanPhamDon]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Lấy danh sách sản phẩm trong đơn (Body)
CREATE   PROCEDURE [dbo].[sp_LayChiTietSanPhamDon]
    @MaDon INT
AS
BEGIN
    SELECT c.*, m.TenMay, m.HinhAnh 
    FROM ChiTietDon c 
    JOIN MayTinh m ON c.MaMay = m.MaMay 
    WHERE c.MaDon = @MaDon;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayDanhSachMayTinh_DonGian]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Lấy danh sách máy tính (Chỉ lấy Ma, Ten) để fill vào Dropdown
CREATE   PROCEDURE [dbo].[sp_LayDanhSachMayTinh_DonGian]
AS
BEGIN
    SELECT MaMay, TenMay FROM MayTinh ORDER BY TenMay;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayDonHangCuaToi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Lấy danh sách đơn hàng của tôi
CREATE   PROCEDURE [dbo].[sp_LayDonHangCuaToi]
    @MaND INT
AS
BEGIN
    SELECT * FROM DonDatHang 
    WHERE MaND = @MaND 
    ORDER BY MaDon DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayMayTinhLienQuan]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Thủ tục lấy 4 máy tính cùng hãng (trừ máy đang xem)
CREATE PROCEDURE [dbo].[sp_LayMayTinhLienQuan]
    @MaTH INT,
    @MaMayHienTai INT
AS
BEGIN
    SELECT  * FROM MayTinh 
    WHERE MaTH = @MaTH AND MaMay != @MaMayHienTai 
    ORDER BY NEWID(); -- Lấy ngẫu nhiên
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayMayTinhMoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Thủ tục lấy danh sách sản phẩm MỚI NHẤT (Mặc định trang chủ)
CREATE   PROCEDURE [dbo].[sp_LayMayTinhMoi]
    @SoLuong INT
AS
BEGIN
    SELECT TOP (@SoLuong) * FROM MayTinh 
    ORDER BY MaMay DESC; -- Máy mới nhập về xếp lên đầu
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayMayTinhTheoHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Thủ tục lọc sản phẩm theo HÃNG
CREATE   PROCEDURE [dbo].[sp_LayMayTinhTheoHang]
    @MaTH INT
AS
BEGIN
    SELECT * FROM MayTinh 
    WHERE MaTH = @MaTH 
    ORDER BY GiaBan ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayNhaPhanPhoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Lấy danh sách Nhà phân phối
CREATE   PROCEDURE [dbo].[sp_LayNhaPhanPhoi]
AS
BEGIN
    SELECT * FROM NhaPhanPhoi ORDER BY MaNPP DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayThongTinDonHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Lấy thông tin chi tiết đơn hàng (Header)
CREATE   PROCEDURE [dbo].[sp_LayThongTinDonHang]
    @MaDon INT
AS
BEGIN
    SELECT d.*, n.HoTen, n.SoDienThoai, n.Email
    FROM DonDatHang d 
    JOIN NguoiDung n ON d.MaND = n.MaND 
    WHERE d.MaDon = @MaDon;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayThuongHieu]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Thủ tục lấy danh sách Thương hiệu (Menu)
CREATE PROCEDURE [dbo].[sp_LayThuongHieu]
AS
BEGIN
    SELECT * FROM ThuongHieu ORDER BY ThuTu ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LayThuVienAnh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_LayThuVienAnh]
    @MaMay INT
AS
BEGIN
    SELECT * FROM ThuVienAnh 
    WHERE MaMay = @MaMay 
    ORDER BY SapXep ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LuuNguoiDung]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_LuuNguoiDung]
    @MaND INT, 
    @HoTen NVARCHAR(150),
    @Email VARCHAR(100),
    @MatKhau VARCHAR(255),
    @SoDienThoai VARCHAR(20),
    @DiaChi NVARCHAR(255),
    @VaiTro VARCHAR(20)
AS
BEGIN
    -- 1. Kiểm tra trùng Số điện thoại (Bắt buộc không trùng với người khác)
    IF EXISTS (SELECT 1 FROM NguoiDung WHERE SoDienThoai = @SoDienThoai AND MaND <> @MaND)
    BEGIN
        SELECT -2 AS KetQua; -- Lỗi trùng SĐT
        RETURN;
    END

    -- 2. Kiểm tra trùng Email (Chỉ kiểm tra nếu có nhập Email)
    IF ISNULL(@Email, '') <> '' AND EXISTS (SELECT 1 FROM NguoiDung WHERE Email = @Email AND MaND <> @MaND)
    BEGIN
        SELECT -1 AS KetQua; -- Lỗi trùng Email
        RETURN;
    END

    -- 3. Logic Mật khẩu: Nếu trống thì giữ cũ, nếu có thì cập nhật mới
    DECLARE @RealPassword VARCHAR(255);
    IF ISNULL(@MatKhau, '') <> ''
        SET @RealPassword = @MatKhau;
    ELSE
        SELECT @RealPassword = MatKhau FROM NguoiDung WHERE MaND = @MaND;

    -- 4. Cập nhật thông tin
    UPDATE NguoiDung
    SET HoTen = @HoTen, 
        Email = @Email, 
        MatKhau = @RealPassword,
        SoDienThoai = @SoDienThoai, 
        DiaChi = @DiaChi, 
        VaiTro = @VaiTro
    WHERE MaND = @MaND;

    SELECT 1 AS KetQua; -- Thành công
END
GO
/****** Object:  StoredProcedure [dbo].[sp_QuanLyDonHang_Filter]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Lấy danh sách đơn hàng (Có lọc)
CREATE   PROCEDURE [dbo].[sp_QuanLyDonHang_Filter]
    @TuKhoa NVARCHAR(100) = '', -- Tìm tên khách hoặc SĐT
    @TrangThai NVARCHAR(50) = 'All', -- 'All' hoặc 'Chờ duyệt', 'Đã giao'...
    @TuNgay DATE = NULL,
    @DenNgay DATE = NULL
AS
BEGIN
    SELECT d.*, n.HoTen, n.SoDienThoai
    FROM DonDatHang d
    JOIN NguoiDung n ON d.MaND = n.MaND
    WHERE (@TrangThai = 'All' OR d.TrangThai = @TrangThai)
      AND (@TuKhoa = '' OR n.HoTen LIKE N'%' + @TuKhoa + '%' OR n.SoDienThoai LIKE '%' + @TuKhoa + '%')
      AND (@TuNgay IS NULL OR CONVERT(DATE, d.NgayDat) >= @TuNgay)
      AND (@DenNgay IS NULL OR CONVERT(DATE, d.NgayDat) <= @DenNgay)
    ORDER BY d.MaDon DESC; -- Đơn mới nhất lên đầu
END
GO
/****** Object:  StoredProcedure [dbo].[sp_QuanLyMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Lấy danh sách máy tính (Có lọc theo Thương Hiệu và Tìm kiếm)
CREATE   PROCEDURE [dbo].[sp_QuanLyMayTinh]
    @MaTH INT = 0,       -- 0: Lấy tất cả
    @TuKhoa NVARCHAR(100) = '' -- '': Không tìm kiếm
AS
BEGIN
    SELECT m.*, th.TenTH
    FROM MayTinh m
    JOIN ThuongHieu th ON m.MaTH = th.MaTH
    WHERE (@MaTH = 0 OR m.MaTH = @MaTH)
      AND (@TuKhoa = '' OR m.TenMay LIKE N'%' + @TuKhoa + '%')
    ORDER BY m.MaMay DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_QuanLyMayTinh_Filter]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Lấy danh sách máy tính (Hỗ trợ lọc Hãng, Tên, Tồn kho)
CREATE   PROCEDURE [dbo].[sp_QuanLyMayTinh_Filter]
    @MaTH INT = 0,
    @TuKhoa NVARCHAR(100) = '',
    @MaxTon INT = -1 -- -1 là không lọc tồn kho
AS
BEGIN
    SELECT m.*, th.TenTH 
    FROM MayTinh m 
    JOIN ThuongHieu th ON m.MaTH = th.MaTH 
    WHERE (@MaTH = 0 OR m.MaTH = @MaTH)
      AND (@TuKhoa = '' OR m.TenMay LIKE N'%' + @TuKhoa + '%')
      AND (@MaxTon = -1 OR m.TonKho <= @MaxTon)
    ORDER BY m.MaMay DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_QuanLyNguoiDung_Filter]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Lấy danh sách người dùng với bộ lọc
CREATE   PROCEDURE [dbo].[sp_QuanLyNguoiDung_Filter]
    @TuKhoa NVARCHAR(100) = '',
    @VaiTro VARCHAR(20) = 'All' -- 'Admin', 'Khach' hoặc 'All'
AS
BEGIN
    SELECT MaND, HoTen, Email, SoDienThoai, DiaChi, VaiTro, NgayTao
    FROM NguoiDung
    WHERE (@VaiTro = 'All' OR VaiTro = @VaiTro)
      AND (@TuKhoa = '' OR HoTen LIKE N'%' + @TuKhoa + '%' 
           OR Email LIKE '%' + @TuKhoa + '%' 
           OR SoDienThoai LIKE '%' + @TuKhoa + '%')
    ORDER BY MaND DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Sửa Máy Tính
CREATE   PROCEDURE [dbo].[sp_SuaMayTinh]
    @MaMay INT,
    @TenMay NVARCHAR(200),
    @CauHinh NVARCHAR(MAX),
    @MaTH INT,
    @GiaBan DECIMAL(18,2),
    @HinhAnh NVARCHAR(255),
    @MoTa NVARCHAR(MAX)
AS
BEGIN
    UPDATE MayTinh
    SET TenMay = @TenMay,
        CauHinh = @CauHinh,
        MaTH = @MaTH,
        GiaBan = @GiaBan,
        HinhAnh = @HinhAnh,
        MoTa = @MoTa
    WHERE MaMay = @MaMay;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaNhaPhanPhoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Sửa thông tin Nhà phân phối
CREATE   PROCEDURE [dbo].[sp_SuaNhaPhanPhoi]
    @MaNPP INT,
    @TenNPP NVARCHAR(150),
    @DiaChi NVARCHAR(255),
    @SoDienThoai VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    UPDATE NhaPhanPhoi 
    SET TenNPP = @TenNPP, DiaChi = @DiaChi, SoDienThoai = @SoDienThoai, Email = @Email
    WHERE MaNPP = @MaNPP;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SuaThuongHieu]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Sửa Thương hiệu
CREATE   PROCEDURE [dbo].[sp_SuaThuongHieu]
    @MaTH INT,
    @TenTH NVARCHAR(100),
    @MoTa NVARCHAR(255) = NULL,
    @ThuTu INT = 0
AS
BEGIN
    UPDATE ThuongHieu 
    SET TenTH = @TenTH, 
        MoTa = @MoTa,
        ThuTu = @ThuTu
    WHERE MaTH = @MaTH;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaoDonDatHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. SP Tạo Đơn Đặt Hàng
CREATE   PROCEDURE [dbo].[sp_TaoDonDatHang]
    @MaND INT,
    @TongTien DECIMAL(18,2),
    @DiaChiGiaoHang NVARCHAR(255)
AS
BEGIN
    INSERT INTO DonDatHang(MaND, NgayDat, TrangThai, TongTien, DiaChiGiaoHang)
    VALUES(@MaND, GETDATE(), N'Chờ duyệt', @TongTien, @DiaChiGiaoHang);
    
    SELECT SCOPE_IDENTITY(); -- Trả về MaDon vừa tạo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaoDonHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. SP Tạo Đơn hàng
CREATE   PROCEDURE [dbo].[sp_TaoDonHang]
    @MaND INT,
    @TongTien DECIMAL(18,2),
    @DiaChiGiaoHang NVARCHAR(255)
AS
BEGIN
    INSERT INTO DonDatHang(MaND, NgayDat, TrangThai, TongTien, DiaChiGiaoHang)
    VALUES(@MaND, GETDATE(), N'Chờ duyệt', @TongTien, @DiaChiGiaoHang);
    
    SELECT SCOPE_IDENTITY(); -- Trả về Mã Đơn vừa tạo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaoDonNhap]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Tạo Đơn Nhập (Header)
CREATE   PROCEDURE [dbo].[sp_TaoDonNhap]
    @MaNPP INT,
    @TongTien DECIMAL(18,2)
AS
BEGIN
    INSERT INTO DonNhap(MaNPP, NgayNhap, TongTien)
    VALUES(@MaNPP, GETDATE(), @TongTien);
    
    SELECT SCOPE_IDENTITY(); -- Trả về MaNhap
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaoKhachHangMoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. SP Tạo Khách hàng Mới (Dùng khi khách chưa có SĐT trong hệ thống)
CREATE   PROCEDURE [dbo].[sp_TaoKhachHangMoi]
    @HoTen NVARCHAR(150),
    @SoDienThoai VARCHAR(20),
    @DiaChi NVARCHAR(255),
    @Email VARCHAR(100) = NULL
AS
BEGIN
    -- Mật khẩu mặc định chính là Số điện thoại
    INSERT INTO NguoiDung(HoTen, SoDienThoai, DiaChi, Email, MatKhau, VaiTro, NgayTao)
    VALUES(@HoTen, @SoDienThoai, @DiaChi, @Email, @SoDienThoai, 'Khach', GETDATE());
    
    SELECT SCOPE_IDENTITY(); -- Trả về MaND vừa tạo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaoMayTinhNhanh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Tạo nhanh sản phẩm mới (Dùng cho Modal nhập hàng)
CREATE   PROCEDURE [dbo].[sp_TaoMayTinhNhanh]
    @TenMay NVARCHAR(200),
    @MaTH INT,
    @CauHinh NVARCHAR(MAX),
    @GiaBan DECIMAL(18,2),
    @HinhAnh NVARCHAR(255)
AS
BEGIN
    INSERT INTO MayTinh(TenMay, MaTH, CauHinh, GiaBan, HinhAnh, TonKho, NgayTao)
    VALUES(@TenMay, @MaTH, @CauHinh, @GiaBan, @HinhAnh, 0, GETDATE());
    
    SELECT SCOPE_IDENTITY(); -- Trả về ID máy vừa tạo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemAnhThuVien]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Thêm ảnh vào thư viện
CREATE   PROCEDURE [dbo].[sp_ThemAnhThuVien]
    @MaMay INT,
    @DuongDan NVARCHAR(255)
AS
BEGIN
    -- Mặc định sắp xếp cuối cùng
    DECLARE @MaxSort INT;
    SELECT @MaxSort = ISNULL(MAX(SapXep), 0) FROM ThuVienAnh WHERE MaMay = @MaMay;
    
    INSERT INTO ThuVienAnh(MaMay, DuongDan, SapXep)
    VALUES(@MaMay, @DuongDan, @MaxSort + 1);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemChiTietDon]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. SP Thêm Chi Tiết Đơn (Trigger kho sẽ tự chạy ở đây)
CREATE   PROCEDURE [dbo].[sp_ThemChiTietDon]
    @MaDon INT,
    @MaMay INT,
    @SoLuong INT,
    @GiaBan DECIMAL(18,2)
AS
BEGIN
    INSERT INTO ChiTietDon(MaDon, MaMay, SoLuong, GiaBan)
    VALUES(@MaDon, @MaMay, @SoLuong, @GiaBan);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemChiTietNhap]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Thêm Chi Tiết Nhập (Body) - Trigger kho sẽ tự chạy ở đây
CREATE   PROCEDURE [dbo].[sp_ThemChiTietNhap]
    @MaNhap INT,
    @MaMay INT,
    @SoLuong INT,
    @GiaNhap DECIMAL(18,2)
AS
BEGIN
    INSERT INTO ChiTietNhap(MaNhap, MaMay, SoLuong, GiaNhap)
    VALUES(@MaNhap, @MaMay, @SoLuong, @GiaNhap);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Thêm Máy Tính Mới
CREATE   PROCEDURE [dbo].[sp_ThemMayTinh]
    @TenMay NVARCHAR(200),
    @CauHinh NVARCHAR(MAX),
    @MaTH INT,
    @GiaBan DECIMAL(18,2),
    @HinhAnh NVARCHAR(255),
    @MoTa NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO MayTinh(TenMay, CauHinh, MaTH, GiaBan, HinhAnh, MoTa, TonKho, NgayTao)
    VALUES(@TenMay, @CauHinh, @MaTH, @GiaBan, @HinhAnh, @MoTa, 0, GETDATE());
    
    SELECT SCOPE_IDENTITY(); -- Trả về ID vừa tạo để thêm Album ảnh
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemNhaPhanPhoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Thêm Nhà phân phối mới
CREATE   PROCEDURE [dbo].[sp_ThemNhaPhanPhoi]
    @TenNPP NVARCHAR(150),
    @DiaChi NVARCHAR(255),
    @SoDienThoai VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    INSERT INTO NhaPhanPhoi(TenNPP, DiaChi, SoDienThoai, Email) 
    VALUES(@TenNPP, @DiaChi, @SoDienThoai, @Email);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemThuongHieu]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Thêm Thương hiệu (Có Mota, ThuTu)
CREATE   PROCEDURE [dbo].[sp_ThemThuongHieu]
    @TenTH NVARCHAR(100),
    @MoTa NVARCHAR(255) = NULL,
    @ThuTu INT = 0
AS
BEGIN
    INSERT INTO ThuongHieu(TenTH, MoTa, ThuTu) 
    VALUES(@TenTH, @MoTa, @ThuTu);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemThuVienAnh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Thêm ảnh vào Thư viện (Album)
CREATE   PROCEDURE [dbo].[sp_ThemThuVienAnh]
    @MaMay INT,
    @DuongDan NVARCHAR(255)
AS
BEGIN
    INSERT INTO ThuVienAnh(MaMay, DuongDan, SapXep) VALUES(@MaMay, @DuongDan, 0);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongKeDashboard]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_ThongKeDashboard]
AS
BEGIN
    SELECT 
        (SELECT ISNULL(SUM(TongTien), 0) FROM DonDatHang WHERE TrangThai != N'Đã hủy') AS DoanhThu,
        (SELECT COUNT(*) FROM DonDatHang WHERE TrangThai = N'Chờ duyệt') AS DonMoi,
        (SELECT COUNT(*) FROM NguoiDung WHERE VaiTro = 'Khach') AS KhachHang,
        (SELECT COUNT(*) FROM MayTinh) AS SanPham;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TimKiemMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_TimKiemMayTinh]
    @TuKhoa NVARCHAR(100)
AS
BEGIN
    SELECT m.*, th.TenTH
    FROM MayTinh m
    JOIN ThuongHieu th ON m.MaTH = th.MaTH
    WHERE 
        -- 1. Tìm theo Tên máy (VD: 'Inspiron')
        m.TenMay LIKE N'%' + @TuKhoa + '%' 
        
        -- 2. Tìm theo Cấu hình (VD: 'Core i7', '16GB', 'RTX')
        OR m.CauHinh LIKE N'%' + @TuKhoa + '%'
        
        -- 3. Tìm theo Tên Hãng (VD: 'Dell', 'Asus', 'Surface')
        OR th.TenTH LIKE N'%' + @TuKhoa + '%'
        
        -- 4. (Tùy chọn) Tìm trong cả Mô tả nếu muốn kỹ hơn
        -- OR m.MoTa LIKE N'%' + @TuKhoa + '%'

    ORDER BY m.GiaBan ASC; -- Xếp sản phẩm giá rẻ lên trước
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XemChiTietDonHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Xem chi tiết 1 đơn hàng (Lấy sản phẩm)
CREATE   PROCEDURE [dbo].[sp_XemChiTietDonHang]
    @MaDon INT
AS
BEGIN
    SELECT c.*, m.TenMay, m.HinhAnh
    FROM ChiTietDon c
    JOIN MayTinh m ON c.MaMay = m.MaMay
    WHERE c.MaDon = @MaDon;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XemChiTietMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_XemChiTietMayTinh]
    @MaMay INT
AS
BEGIN
    SELECT m.*, th.TenTH
    FROM MayTinh m
    JOIN ThuongHieu th ON m.MaTH = th.MaTH
    WHERE m.MaMay = @MaMay;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaAnhThuVien]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2. Xóa 1 ảnh cụ thể trong thư viện (Dùng khi bấm nút Xóa nhỏ ở hình)
CREATE   PROCEDURE [dbo].[sp_XoaAnhThuVien]
    @MaAnh INT
AS
BEGIN
    DELETE FROM ThuVienAnh WHERE MaAnh = @MaAnh;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaDonHangKhiLoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 5. SP Xóa Đơn Hàng (Dùng để rollback khi lỗi kho)
CREATE   PROCEDURE [dbo].[sp_XoaDonHangKhiLoi]
    @MaDon INT
AS
BEGIN
    DELETE FROM DonDatHang WHERE MaDon = @MaDon;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaMayTinh]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Xóa Máy Tính
CREATE   PROCEDURE [dbo].[sp_XoaMayTinh]
    @MaMay INT
AS
BEGIN
    -- Kiểm tra ràng buộc (đã bán hoặc đã nhập chưa)
    IF EXISTS (SELECT 1 FROM ChiTietDon WHERE MaMay = @MaMay) OR EXISTS (SELECT 1 FROM ChiTietNhap WHERE MaMay = @MaMay)
    BEGIN
        SELECT -1 AS KetQua; -- Không thể xóa
        RETURN;
    END

    DELETE FROM MayTinh WHERE MaMay = @MaMay;
    SELECT 1 AS KetQua;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaNhaPhanPhoi]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. Xóa Nhà phân phối (Kiểm tra ràng buộc với Đơn Nhập)
CREATE   PROCEDURE [dbo].[sp_XoaNhaPhanPhoi]
    @MaNPP INT
AS
BEGIN
    -- Kiểm tra xem NPP này đã có đơn nhập hàng nào chưa (Bảng DonNhap)
    IF EXISTS (SELECT 1 FROM DonNhap WHERE MaNPP = @MaNPP)
    BEGIN
        SELECT -1 AS KetQua; -- Trả về -1: Không được xóa vì đã có lịch sử nhập hàng
        RETURN;
    END

    DELETE FROM NhaPhanPhoi WHERE MaNPP = @MaNPP;
    SELECT 1 AS KetQua; -- Thành công
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XoaThuongHieu]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 3. Xóa Thương hiệu (Kiểm tra ràng buộc)
CREATE   PROCEDURE [dbo].[sp_XoaThuongHieu]
    @MaTH INT
AS
BEGIN
    -- Nếu đã có Laptop thuộc hãng này thì không cho xóa
    IF EXISTS (SELECT 1 FROM MayTinh WHERE MaTH = @MaTH)
    BEGIN
        SELECT -1 AS KetQua; -- Lỗi: Đang có dữ liệu
        RETURN;
    END

    DELETE FROM ThuongHieu WHERE MaTH = @MaTH;
    SELECT 1 AS KetQua; -- Thành công
END
GO
/****** Object:  StoredProcedure [dbo].[sp_XuLyKhachHang]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. SP Xử lý thông tin khách hàng (Check hoặc Tạo mới)
CREATE   PROCEDURE [dbo].[sp_XuLyKhachHang]
    @HoTen NVARCHAR(150),
    @SoDienThoai VARCHAR(20),
    @DiaChi NVARCHAR(255)
AS
BEGIN
    DECLARE @MaND INT;

    -- Kiểm tra xem SĐT này đã có chưa
    SELECT @MaND = MaND FROM NguoiDung WHERE SoDienThoai = @SoDienThoai;

    IF @MaND IS NOT NULL
    BEGIN
        -- Đã có -> Trả về ID cũ
        SELECT @MaND AS MaND;
    END
    ELSE
    BEGIN
        -- Chưa có -> Tạo mới (Mật khẩu mặc định là SĐT)
        INSERT INTO NguoiDung(HoTen, SoDienThoai, DiaChi, MatKhau, VaiTro, NgayTao)
        VALUES(@HoTen, @SoDienThoai, @DiaChi, @SoDienThoai, 'Khach', GETDATE());
        
        SELECT SCOPE_IDENTITY() AS MaND;
    END
END
GO
/****** Object:  Trigger [dbo].[trg_CapNhatKho_Ban]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_CapNhatKho_Ban]
ON [dbo].[ChiTietDon]
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM MayTinh m JOIN inserted i ON m.MaMay = i.MaMay WHERE m.TonKho < i.SoLuong)
    BEGIN
        RAISERROR (N'Lỗi: Kho không đủ hàng để bán!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    UPDATE MayTinh
    SET TonKho = TonKho - i.SoLuong
    FROM MayTinh m
    JOIN inserted i ON m.MaMay = i.MaMay;
END;
GO
ALTER TABLE [dbo].[ChiTietDon] ENABLE TRIGGER [trg_CapNhatKho_Ban]
GO
/****** Object:  Trigger [dbo].[trg_HuyDon_TraKho]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_HuyDon_TraKho]
ON [dbo].[ChiTietDon]
AFTER DELETE
AS
BEGIN
    UPDATE MayTinh
    SET TonKho = TonKho + d.SoLuong
    FROM MayTinh m
    JOIN deleted d ON m.MaMay = d.MaMay;
END;
GO
ALTER TABLE [dbo].[ChiTietDon] ENABLE TRIGGER [trg_HuyDon_TraKho]
GO
/****** Object:  Trigger [dbo].[trg_SuaDon_CanDoiKho]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_SuaDon_CanDoiKho]
ON [dbo].[ChiTietDon]
AFTER UPDATE
AS
BEGIN
    IF UPDATE(SoLuong)
    BEGIN
        -- Kiểm tra nếu tăng số lượng mà kho không đủ
        IF EXISTS (
            SELECT 1 
            FROM MayTinh m
            JOIN inserted i ON m.MaMay = i.MaMay
            JOIN deleted d ON m.MaMay = d.MaMay
            WHERE m.TonKho < (i.SoLuong - d.SoLuong)
        )
        BEGIN
            RAISERROR (N'Lỗi: Kho không đủ để cập nhật số lượng!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Trừ đi phần chênh lệch (Mới - Cũ)
        UPDATE MayTinh
        SET TonKho = TonKho - (i.SoLuong - d.SoLuong)
        FROM MayTinh m
        JOIN inserted i ON m.MaMay = i.MaMay
        JOIN deleted d ON m.MaMay = d.MaMay;
    END
END;
GO
ALTER TABLE [dbo].[ChiTietDon] ENABLE TRIGGER [trg_SuaDon_CanDoiKho]
GO
/****** Object:  Trigger [dbo].[trg_CapNhatKho_Nhap]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_CapNhatKho_Nhap]
ON [dbo].[ChiTietNhap]
AFTER INSERT
AS
BEGIN
    UPDATE MayTinh
    SET TonKho = TonKho + i.SoLuong
    FROM MayTinh m
    JOIN inserted i ON m.MaMay = i.MaMay;
END;
GO
ALTER TABLE [dbo].[ChiTietNhap] ENABLE TRIGGER [trg_CapNhatKho_Nhap]
GO
/****** Object:  Trigger [dbo].[trg_HuyNhap_HoanKho]    Script Date: 1/11/2026 7:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_HuyNhap_HoanKho]
ON [dbo].[ChiTietNhap]
AFTER DELETE
AS
BEGIN
    UPDATE MayTinh
    SET TonKho = TonKho - d.SoLuong
    FROM MayTinh m
    JOIN deleted d ON m.MaMay = d.MaMay;
END;
GO
ALTER TABLE [dbo].[ChiTietNhap] ENABLE TRIGGER [trg_HuyNhap_HoanKho]
GO
USE [master]
GO
ALTER DATABASE [LaptopTrungHieu] SET  READ_WRITE 
GO
