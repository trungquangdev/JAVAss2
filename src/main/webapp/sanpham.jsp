<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
</head>
<body>

<h2>Quản lý sản phẩm</h2>

<%-- Form Thêm --%>
<form action="${pageContext.request.contextPath}/admin/san-pham/add" method="post">
    <input type="text" name="ma" placeholder="Mã sản phẩm" required>
    <input type="text" name="tenSanPham" placeholder="Tên sản phẩm" required>
    <input type="text" name="moTa" placeholder="Mô tả">
    <input type="number" name="trangThai" placeholder="Trạng thái" value="1">
    <button type="submit">Thêm</button>
</form>

<%-- Form Sửa (Chỉ hiện khi có spEdit) --%>
<c:if test="${not empty spEdit}">
    <h3>Sửa sản phẩm</h3>
    <form action="${pageContext.request.contextPath}/admin/san-pham/update" method="post">
        <input type="hidden" name="id" value="${spEdit.id}">
        <input type="text" name="ma" value="${spEdit.ma}" required>
        <input type="text" name="tenSanPham" value="${spEdit.tenSanPham}" required>
        <input type="text" name="moTa" value="${spEdit.moTa}">
        <input type="number" name="trangThai" value="${spEdit.trangThai}">
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/san-pham">Hủy</a>
    </form>
</c:if>

<%-- Bảng danh sách --%>
<table border="1" cellpadding="6" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã</th>
        <th>Tên sản phẩm</th>
        <th>Mô tả</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="sp">
        <tr>
            <td>${sp.id}</td>
            <td>${sp.ma}</td>
            <td>${sp.tenSanPham}</td>
            <td>${sp.moTa}</td>
            <td>${sp.trangThai}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/san-pham/detail?id=${sp.id}">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/san-pham/edit?id=${sp.id}">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/san-pham/delete?id=${sp.id}"
                   onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<%-- Phần hiển thị Chi tiết (Chỉ hiện khi bấm nút Detail) --%>
<c:if test="${not empty detailSp}">
    <h3>Chi tiết sản phẩm</h3>
    <p>ID: ${detailSp.id}</p>
    <p>Mã: ${detailSp.ma}</p>
    <p>Tên sản phẩm: ${detailSp.tenSanPham}</p>
    <p>Mô tả: ${detailSp.moTa}</p>
    <p>Trạng thái: ${detailSp.trangThai}</p>
    <a href="${pageContext.request.contextPath}/admin/san-pham">Đóng chi tiết</a>
</c:if>

</body>
</html>