<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý hóa đơn chi tiết</title>
</head>
<body>

<h2>Quản lý hóa đơn chi tiết</h2>

<%-- Form Thêm --%>
<form action="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/add" method="post">
    Mã hóa đơn:
    <select name="idHoaDon">
        <c:forEach items="${listHD}" var="hd">
            <option value="${hd.id}">${hd.maHoaDon}</option>
        </c:forEach>
    </select><br>
    Sản phẩm chi tiết (Biến thể):
    <select name="idChiTietSanPham">
        <c:forEach items="${listCTSP}" var="ctsp">
            <option value="${ctsp.id}">${ctsp.sanPham.tenSanPham} - ${ctsp.mauSac.tenMau} - ${ctsp.kichCo.tenSize}</option>
        </c:forEach>
    </select><br>
    <input type="number" name="soLuong" placeholder="Số lượng" required><br>
    <input type="number" step="0.01" name="donGia" placeholder="Đơn giá" required><br>
    <button type="submit">Thêm</button>
</form>

<%-- Form Sửa (Hiện khi hdctEdit không rỗng) --%>
<c:if test="${not empty hdctEdit}">
    <h3>Sửa hóa đơn chi tiết</h3>
    <form action="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/update" method="post">
        <input type="hidden" name="id" value="${hdctEdit.id}">
        Mã hóa đơn:
        <select name="idHoaDon">
            <c:forEach items="${listHD}" var="hd">
                <option value="${hd.id}" ${hd.id == hdctEdit.hoaDon.id ? 'selected' : ''}>${hd.maHoaDon}</option>
            </c:forEach>
        </select><br>
        Sản phẩm chi tiết:
        <select name="idChiTietSanPham">
            <c:forEach items="${listCTSP}" var="ctsp">
                <option value="${ctsp.id}" ${ctsp.id == hdctEdit.chiTietSanPham.id ? 'selected' : ''}>${ctsp.sanPham.tenSanPham} - ${ctsp.mauSac.tenMau} - ${ctsp.kichCo.tenSize}</option>
            </c:forEach>
        </select><br>
        <input type="number" name="soLuong" value="${hdctEdit.soLuong}" required><br>
        <input type="number" step="0.01" name="donGia" value="${hdctEdit.donGia}" required><br>
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="6">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã Hóa Đơn</th>
        <th>Sản phẩm / Biến thể</th>
        <th>Số lượng</th>
        <th>Đơn giá</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="hdct">
        <tr>
            <td>${hdct.id}</td>
            <td>${hdct.hoaDon.maHoaDon}</td>
            <td>${hdct.chiTietSanPham.sanPham.tenSanPham} (${hdct.chiTietSanPham.mauSac.tenMau} - ${hdct.chiTietSanPham.kichCo.tenSize})</td>
            <td>${hdct.soLuong}</td>
            <td>${hdct.donGia}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/detail?id=${hdct.id}" style="text-decoration: none">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/edit?id=${hdct.id}" style="text-decoration: none">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/delete?id=${hdct.id}" onclick="return confirm('Bạn có chắc muốn xóa?')" style="text-decoration: none">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty detailHdct}">
    <h3>Chi tiết hóa đơn chi tiết</h3>
    <p>ID: ${detailHdct.id}</p>
    <p>Mã Hóa Đơn: ${detailHdct.hoaDon.maHoaDon}</p>
    <p>Sản phẩm: ${detailHdct.chiTietSanPham.sanPham.tenSanPham}</p>
    <p>Màu sắc: ${detailHdct.chiTietSanPham.mauSac.tenMau}</p>
    <p>Kích cỡ: ${detailHdct.chiTietSanPham.kichCo.tenSize}</p>
    <p>Số lượng: ${detailHdct.soLuong}</p>
    <p>Đơn giá: ${detailHdct.donGia}</p>
    <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet">Đóng chi tiết</a>
</c:if>
</body>
</html>