﻿--- Proc xóa sản phẩm
CREATE PROC DELETE_SP @MASP VARCHAR(10)
AS
BEGIN
	DELETE FROM dbo.SANPHAM WHERE MASP = @MASP
END

EXEC dbo.DELETE_SP @MASP = 'SP20' -- varchar(10)
 
 DELETE FROM dbo.KHACHHANG WHERE MAKH = 'KH15'
 DELETE FROM dbo.TAIKHOAN WHERE TAIKHOAN = 'taikhoan1'

 ALTER TABLE dbo.HOADON
 ADD CONSTRAINT FK_KHHD
 FOREIGN KEY (MAKH) REFERENCES dbo.KHACHHANG(MAKH) ON DELETE SET NULL;

 -- Check valid Login
CREATE OR ALTER PROC CHECK_LOGIN @USERNAME NVARCHAR(50), @PASS NVARCHAR(50)
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.TAIKHOAN WHERE TAIKHOAN = @USERNAME AND MATKHAU = @PASS COLLATE SQL_Latin1_General_CP1_CS_AS  AND MALOAI = 1)
		SELECT 1 AS CODE
	ELSE IF EXISTS(SELECT * FROM dbo.TAIKHOAN WHERE TAIKHOAN = @USERNAME AND MATKHAU = @PASS COLLATE SQL_Latin1_General_CP1_CS_AS  AND MALOAI = 2)
		SELECT 2 AS CODE
	ELSE IF EXISTS(SELECT * FROM dbo.TAIKHOAN WHERE TAIKHOAN = @USERNAME AND MATKHAU != @PASS COLLATE SQL_Latin1_General_CP1_CS_AS  )
		SELECT 3 AS CODE
	ELSE
		SELECT 4 AS CODE
END

EXEC CHECK_LOGIN 'ADMIN', 'ADMIN1234'

-- Lấy sản phẩm
CREATE PROC GET_PRODUCT
AS 
BEGIN
	SELECT MASP, TENSP, GIATIEN, DONVITINH, SOLUONGTON, TENKHO FROM dbo.SANPHAM, dbo.KHO WHERE dbo.SANPHAM.MAKHO = dbo.KHO.MAKHO

END
EXEC GET_PRODUCT

----- Insert Hóa đơn 
CREATE OR ALTER PROC INSERT_HOADON @MAHD VARCHAR(10), @MANV VARCHAR(10), 
@MAKH VARCHAR(10), @NGAYLAP DATE, @KHUYENMAI INT, @THANHTIEN MONEY
AS
BEGIN
	INSERT INTO dbo.HOADON
	(
	    MAHD,
	    MANV,
	    MAKH,
	    NGAYLAP,
	    THANHTIEN,
	    KHUYENMAI
	)
	VALUES
	(   @MAHD,        -- MAHD - varchar(10)
	    @MANV,        -- MANV - varchar(10)
	    @MAKH,        -- MAKH - varchar(10)
	    @NGAYLAP, -- NGAYLAP - date
	    @THANHTIEN,      -- THANHTIEN - money
	    @KHUYENMAI       -- KHUYENMAI - float
	    )
END
EXEC dbo.INSERT_HOADON @MAHD = 'HDA2A4',              -- varchar(10)
                       @MANV = 'NV01',              -- varchar(10)
                       @MAKH = 'KH01',              -- varchar(10)
                       @NGAYLAP = '', -- date
                       @KHUYENMAI = 10,          -- int
                       @THANHTIEN = 50000000      -- money

-- insert  Giỏ hàng
CREATE PROC INSERT_GIOHANG @MAHD VARCHAR(10), @MASP VARCHAR(10), @SOLUONG INT, @GIABAN MONEY
AS
BEGIN
	INSERT INTO dbo.GIOHANG
	(
	    MAHD,
	    MASP,
	    SOLUONG,
	    GIABAN
	)
	VALUES
	(   @MAHD,  -- MAHD - varchar(10)
	    @MASP,  -- MASP - varchar(10)
	    @SOLUONG,   -- SOLUONG - int
	    @GIABAN -- GIABAN - money
	    )
END
EXEC dbo.INSERT_GIOHANG @MAHD = 'HD11',    -- varchar(10)
                        @MASP = 'SP11',    -- varchar(10)
                        @SOLUONG = 10,  -- int
                        @GIABAN = 500000 -- money

GO
------ cập nhật trạng thái thanh toán
CREATE PROC UPDATE_TRANGTHAI @MAHD VARCHAR(10)
AS
BEGIN
	UPDATE dbo.HOADON SET TRANGTHAI = N'ĐÃ THANH TOÁN' WHERE MAHD = @MAHD

END
EXEC dbo.UPDATE_TRANGTHAI @MAHD = '5ZEGIG1N' -- varchar(10)



-- THÔNG TIN HÓA ĐƠN BÁN HÀNG
GO
CREATE OR ALTER PROC GET_INF_INVOICE @MAHD VARCHAR(10)
AS
BEGIN
	SELECT SP.TENSP, SP.HANSUDUNG, GH.SOLUONG, GH.GIABAN,HD.MAHD
	FROM dbo.HOADON HD, dbo.SANPHAM SP, dbo.GIOHANG GH
	WHERE HD.MAHD = GH.MAHD AND GH.MASP = SP.MASP AND HD.MAHD = @MAHD
END
GO
EXEC GET_INF_INVOICE 'HD01'