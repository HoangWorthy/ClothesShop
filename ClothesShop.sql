USE [master]
GO
/****** Object:  Database [ClothesShop]    Script Date: 3/24/2025 1:04:16 AM ******/
CREATE DATABASE [ClothesShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClothesShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ClothesShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ClothesShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ClothesShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ClothesShop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClothesShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClothesShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClothesShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClothesShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClothesShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClothesShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClothesShop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ClothesShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClothesShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClothesShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClothesShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClothesShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClothesShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClothesShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClothesShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClothesShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ClothesShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClothesShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClothesShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClothesShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClothesShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClothesShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClothesShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClothesShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ClothesShop] SET  MULTI_USER 
GO
ALTER DATABASE [ClothesShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClothesShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClothesShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClothesShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClothesShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ClothesShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ClothesShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [ClothesShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ClothesShop]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/24/2025 1:04:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[username] [varchar](20) NOT NULL,
	[password] [char](60) NOT NULL,
	[roleId] [char](2) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[address] [varchar](100) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[phone] [varchar](14) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 3/24/2025 1:04:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[quantity] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[accountId] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/24/2025 1:04:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/24/2025 1:04:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orderHeaderId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NOT NULL,
	[discount] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderHeader]    Script Date: 3/24/2025 1:04:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHeader](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[accountId] [varchar](20) NOT NULL,
	[status] [varchar](30) NOT NULL,
	[shipToAddress] [nchar](50) NOT NULL,
 CONSTRAINT [PK__OrderHea__3213E83FDE7762B3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/24/2025 1:04:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[price] [float] NOT NULL,
	[discount] [float] NOT NULL,
	[categoryId] [int] NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK__Product__3213E83FC12EC01D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([username], [password], [roleId], [name], [address], [email], [phone]) VALUES (N'hoang', N'Test@12345                                                  ', N'US', N'Hoang', N'test', N'test@gmail.com', N'09123120123')
INSERT [dbo].[Account] ([username], [password], [roleId], [name], [address], [email], [phone]) VALUES (N'test', N'123                                                         ', N'AD', N'hoang', N'address', N'test138272@gmail.com', N'0979091321')
INSERT [dbo].[Account] ([username], [password], [roleId], [name], [address], [email], [phone]) VALUES (N'test1', N'Test@12345                                                  ', N'US', N'hoang', N'address', N'test138272@gmail.com', N'0979091321')
INSERT [dbo].[Account] ([username], [password], [roleId], [name], [address], [email], [phone]) VALUES (N'test123', N'Test@12344                                                  ', N'US', N'Dang Minh Hoang', N'duong test 123', N'hoang@gmail.com', N'0979091123')
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([id], [quantity], [productId], [accountId]) VALUES (17, 1, 1, N'test')
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name]) VALUES (1, N'Shirt')
INSERT [dbo].[Category] ([id], [name]) VALUES (2, N'Hoodie')
INSERT [dbo].[Category] ([id], [name]) VALUES (3, N'Jacket')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (0, 1, 1, 2, 10, 0.10005002501250626)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (1, 1, 5, 1, 10, 0.0989010989010989)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (2, 1, 12, 3, 10, 0.75)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (3, 2, 25, 1, 10, 0.10588235294117647)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (4, 2, 30, 2, 10, 0.13043478260869565)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (5, 3, 45, 1, 10, 0.104)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (6, 3, 50, 2, 10, 0.10687022900763359)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (7, 4, 10, 3, 10, 0.13461538461538461)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (8, 4, 15, 1, 10, 0.086956521739130432)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (9, 4, 20, 2, 10, 0.11764705882352941)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (10, 5, 33, 1, 10, 0.10077519379844961)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (11, 5, 35, 2, 10, 0.12121212121212122)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (12, 6, 8, 1, 10, 0.10638297872340426)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (13, 6, 28, 2, 10, 0.10227272727272728)
INSERT [dbo].[OrderDetail] ([id], [orderHeaderId], [productId], [quantity], [price], [discount]) VALUES (14, 6, 38, 1, 10, 0.0967741935483871)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderHeader] ON 

INSERT [dbo].[OrderHeader] ([id], [date], [accountId], [status], [shipToAddress]) VALUES (1, CAST(N'2025-03-01T00:00:00.000' AS DateTime), N'hoang', N'OnGoing', N'Test Address 1                                    ')
INSERT [dbo].[OrderHeader] ([id], [date], [accountId], [status], [shipToAddress]) VALUES (2, CAST(N'2025-03-05T00:00:00.000' AS DateTime), N'test', N'New', N'Test Address 2                                    ')
INSERT [dbo].[OrderHeader] ([id], [date], [accountId], [status], [shipToAddress]) VALUES (3, CAST(N'2025-03-10T00:00:00.000' AS DateTime), N'test1', N'Cancel', N'Test Address 3                                    ')
INSERT [dbo].[OrderHeader] ([id], [date], [accountId], [status], [shipToAddress]) VALUES (4, CAST(N'2025-03-15T00:00:00.000' AS DateTime), N'test123', N'OnGoing', N'Duong test 123                                    ')
INSERT [dbo].[OrderHeader] ([id], [date], [accountId], [status], [shipToAddress]) VALUES (5, CAST(N'2025-03-20T00:00:00.000' AS DateTime), N'hoang', N'New', N'Test Address 4                                    ')
INSERT [dbo].[OrderHeader] ([id], [date], [accountId], [status], [shipToAddress]) VALUES (6, CAST(N'2025-03-22T00:00:00.000' AS DateTime), N'test', N'Cancel', N'Test Address 5                                    ')
SET IDENTITY_INSERT [dbo].[OrderHeader] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (1, N'Classic Cotton T-Shirt', 10, 0.10005002501250626, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (2, N'Premium V-Neck T-Shirt', 10, 0.069767441860465115, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (3, N'Casual Striped T-Shirt', 10, 0, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (4, N'Graphic Printed T-Shirt', 10, 0.12, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (5, N'Slim Fit Polo Shirt', 10, 0.0989010989010989, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (6, N'Sports Performance Tee', 10, 0.11964785914365748, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (7, N'Oversized Streetwear Tee', 10, 0.094807050976655552, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (8, N'Basic Crew Neck Tee', 10, 0.10638297872340426, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (9, N'Minimalist Pocket Tee', 10, 0.5, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (10, N'Tie-Dye Fashion Tee', 10, 0.13461538461538461, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (11, N'Breathable Gym T-Shirt', 10, 0.059523809523809521, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (12, N'Long Sleeve Henley Shirt', 10, 0.75, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (13, N'Relaxed Fit Summer Tee', 10, 0.090909090909090912, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (14, N'Retro Band Logo Tee', 10, 0.10416666666666667, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (15, N'Embroidered Designer Tee', 10, 0.086956521739130432, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (16, N'Eco-Friendly Organic Tee', 10, 0.073170731707317069, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (17, N'Techwear Compression Tee', 10, 0.10344827586206896, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (18, N'Stylish Striped Polo', 10, 0.1087429317094389, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (19, N'Casual Buttoned Tee', 10, 0.5, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (20, N'Luxury Silk Blend Tee', 10, 0.11764705882352941, 1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (21, N'Classic Pullover Hoodie', 10, 0.1250312578144536, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (22, N'Zip-Up Fleece Hoodie', 10, 0.10588235294117647, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (23, N'Oversized Street Hoodie', 10, 0.10233393177737882, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (24, N'Graphic Printed Hoodie', 10, 0.12222222222222222, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (25, N'Slim Fit Lightweight Hoodie', 10, 0.10179640718562874, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (26, N'Heavy-Duty Winter Hoodie', 10, 0.11343487156171857, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (27, N'Athletic Performance Hoodie', 10, 0.097340814832886063, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (28, N'Retro 90s Style Hoodie', 10, 0.10112359550561798, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (29, N'Minimalist Logo Hoodie', 10, 0.088607594936708861, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (30, N'Fuzzy Sherpa Hoodie', 10, 0.13043478260869565, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (31, N'Urban Camo Hoodie', 10, 0.0975609756097561, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (32, N'Luxury Cashmere Hoodie', 10, 0.082802547770700632, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (33, N'Techwear Zip Hoodie', 10, 0.095238095238095233, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (34, N'Comfy Oversized Hoodie', 10, 0.10227272727272728, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (35, N'Eco-Friendly Bamboo Hoodie', 10, 0.093023255813953487, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (36, N'Distressed Vintage Hoodie', 10, 0.086419753086419748, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (37, N'Thermal-Lined Hoodie', 10, 0.10179640718562874, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (38, N'Heavyweight Cotton Hoodie', 10, 0.104675505931612, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (39, N'Double-Layered Hoodie', 10, 0.094339622641509441, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (40, N'Water-Resistant Hoodie', 10, 0.10989010989010989, 2, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (41, N'Classic Denim Jacket', 10, 0.11668611435239207, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (42, N'Slim Fit Leather Jacket', 10, 0.104, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (43, N'Padded Winter Parka', 10, 0.10154263434480421, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (44, N'Premium Wool Blazer', 10, 0.11538461538461539, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (45, N'Casual Bomber Jacket', 10, 0.10121457489878542, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (46, N'Heavy-Duty Work Jacket', 10, 0.10923581809657759, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (47, N'Faux Fur Lined Jacket', 10, 0.098212821774061321, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (48, N'Quilted Puffer Jacket', 10, 0.10077519379844961, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (49, N'Urban Windbreaker Jacket', 10, 0.092436974789915971, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (50, N'Luxury Trench Coat', 10, 0.12121212121212122, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (51, N'Techwear Utility Jacket', 10, 0.098360655737704916, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (52, N'Retro Varsity Jacket', 10, 0.088607594936708861, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (53, N'Minimalist Zip-Up Jacket', 10, 0.0967741935483871, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (54, N'Streetwear Hooded Jacket', 10, 0.1015625, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (55, N'Eco-Friendly Recycled Jacket', 10, 0.095238095238095233, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (56, N'Breathable Sports Jacket', 10, 0.090909090909090912, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (57, N'Distressed Denim Jacket', 10, 0.10121457489878542, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (58, N'Convertible Travel Jacket', 10, 0.10319098269566597, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (59, N'Waterproof Rain Jacket', 10, 0.096234309623430964, 3, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId], [status]) VALUES (60, N'Luxury Suede Jacket', 10, 0.10687022900763359, 3, 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Account] FOREIGN KEY([accountId])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Account]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Product] FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Product]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__order__4316F928] FOREIGN KEY([orderHeaderId])
REFERENCES [dbo].[OrderHeader] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK__OrderDeta__order__4316F928]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__produ__47DBAE45] FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK__OrderDeta__produ__47DBAE45]
GO
ALTER TABLE [dbo].[OrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_OrderHeader_Account] FOREIGN KEY([accountId])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[OrderHeader] CHECK CONSTRAINT [FK_OrderHeader_Account]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__categor__49C3F6B7] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__categor__49C3F6B7]
GO
USE [master]
GO
ALTER DATABASE [ClothesShop] SET  READ_WRITE 
GO
