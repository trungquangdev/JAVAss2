<%--
  Created by IntelliJ IDEA.
  User: Trung
  Date: 10/11/2026
  Time: 10:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>HỆ THỐNG QUẢN LÝ BÁN HÀNG (ADMIN)</h3>
<hr/>
<ul>
    <li><b>Quản lý bán hàng:</b>
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/hoa-don">Quản lý Hóa Đơn</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet">Quản lý Hóa Đơn Chi Tiết</a></li>
        </ul>
    </li>
    <li><b>Quản lý sản phẩm:</b>
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/san-pham">Sản phẩm & Biến thể</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/mau-sac">Thuộc tính: Màu sắc</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/kich-co">Thuộc tính: Kích cỡ</a></li>
        </ul>
    </li>
    <li><b>Quản lý khuyến mãi:</b>
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/phieu-giam-gia">Phiếu Giảm Giá</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/dot-giam-gia">Đợt Giảm Giá</a></li>
        </ul>
    </li>
    <li><b>Quản lý người dùng:</b>
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/nhan-vien">Nhân Viên</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/khach-hang">Khách Hàng</a></li>
        </ul>
    </li>
</ul>
</body>
</html>
