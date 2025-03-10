USE [master]
GO
/****** Object:  Database [ClothesShop]    Script Date: 3/8/2025 11:33:49 AM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 3/8/2025 11:33:50 AM ******/
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
/****** Object:  Table [dbo].[Carts]    Script Date: 3/8/2025 11:33:50 AM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 3/8/2025 11:33:50 AM ******/
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
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/8/2025 11:33:50 AM ******/
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
/****** Object:  Table [dbo].[OrderHeader]    Script Date: 3/8/2025 11:33:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHeader](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[accountid] [varchar](20) NOT NULL,
	[status] [varchar](30) NOT NULL,
	[shipToAddress] [nchar](50) NOT NULL,
 CONSTRAINT [PK__OrderHea__3213E83FDE7762B3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/8/2025 11:33:50 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([username], [password], [roleId], [name], [address], [email], [phone]) VALUES (N'hoang', N'1234                                                        ', N'US', N'Hoang', N'test', N'test', N'09123120')
INSERT [dbo].[Account] ([username], [password], [roleId], [name], [address], [email], [phone]) VALUES (N'test', N'123                                                         ', N'AD', N'hoang', N'address', N'test138272@gmail.com', N'0979091321')
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([id], [quantity], [productId], [accountId]) VALUES (1, 3, 1, N'hoang')
INSERT [dbo].[Carts] ([id], [quantity], [productId], [accountId]) VALUES (2, 2, 2, N'hoang')
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name]) VALUES (1, N'Shirt')
INSERT [dbo].[Category] ([id], [name]) VALUES (2, N'Hoodie')
INSERT [dbo].[Category] ([id], [name]) VALUES (3, N'Jacket')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (1, N'Shirt 1', 240.23, 0.14, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (2, N'Shirt 2', 112.03, 0.15, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (3, N'Shirt 3', 161.99, 0.1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (4, N'Shirt 4', 205.51, 0.1, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (5, N'Shirt 5', 248, 0.06, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (6, N'Shirt 6', 172.97, 0.03, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (7, N'Shirt 7', 100.46, 0.11, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (8, N'Shirt 8', 240.99, 0.16, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (9, N'Shirt 9', 239.14, 0.09, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (10, N'Shirt 10', 136.5, 0.16, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (11, N'Shirt 11', 211.07, 0.09, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (12, N'Shirt 12', 25.34, 0.17, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (13, N'Shirt 13', 235.73, 0.12, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (14, N'Shirt 14', 200.09, 0.06, 1)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (15, N'Hoodie 15', 49.47, 0.08, 2)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (16, N'Hoodie 16', 89.08, 0.11, 2)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (17, N'Hoodie 17', 78.24, 0.2, 2)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (18, N'Hoodie 18', 78.73, 0.05, 2)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (19, N'Hoodie 19', 118.43, 0.08, 2)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (20, N'Hoodie 20', 209.66, 0.18, 2)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (21, N'Hoodie 21', 92.08, 0.18, 2)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (22, N'Jacket 22', 131.2, 0.02, 3)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (23, N'Jacket 23', 102.36, 0.15, 3)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (24, N'Jacket 24', 120.18, 0.08, 3)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (25, N'Jacket 25', 44.64, 0.03, 3)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (26, N'Jacket 26', 54.38, 0.18, 3)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (27, N'Jacket 27', 49.64, 0.11, 3)
INSERT [dbo].[Product] ([id], [description], [price], [discount], [categoryId]) VALUES (28, N'Jacket 28', 90.35, 0.07, 3)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[OrderHeader] ADD  CONSTRAINT [DF__OrderHead__statu__3F466844]  DEFAULT ('New') FOR [status]
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
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[OrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_OrderHeader_Account] FOREIGN KEY([accountid])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[OrderHeader] CHECK CONSTRAINT [FK_OrderHeader_Account]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[OrderHeader]  WITH CHECK ADD  CONSTRAINT [CK__OrderHead__statu__403A8C7D] CHECK  (([status]='Close' OR [status]='Cancel' OR [status]='Shipping' OR [status]='New'))
GO
ALTER TABLE [dbo].[OrderHeader] CHECK CONSTRAINT [CK__OrderHead__statu__403A8C7D]
GO
USE [master]
GO
ALTER DATABASE [ClothesShop] SET  READ_WRITE 
GO
