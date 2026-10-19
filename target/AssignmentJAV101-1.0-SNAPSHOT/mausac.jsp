<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý màu sắc</title>
</head>
<body>

<h2>Quản lý màu sắc</h2>

<%-- Form Thêm --%>
<form action="${pageContext.request.contextPath}/admin/mau-sac/add" method="post">
    <input type="text" name="ma" placeholder="Mã màu" required>
    <input type="text" name="tenMau" placeholder="Tên màu" required>
    <button type="submit">Thêm</button>
</form>

<%-- Form Sửa (Hiện khi msEdit không rỗng) --%>
<c:if test="${not empty msEdit}">
    <h3>Sửa màu sắc</h3>
    <form action="${pageContext.request.contextPath}/admin/mau-sac/update" method="post">
        <input type="hidden" name="id" value="${msEdit.id}">
        <input type="text" name="ma" value="${msEdit.ma}" required>
        <input type="text" name="tenMau" value="${msEdit.tenMau}" required>
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/mau-sac">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="6">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã màu</th>
        <th>Tên màu</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="ms">
        <tr>
            <td>${ms.id}</td>
            <td>${ms.ma}</td>
            <td>${ms.tenMau}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/mau-sac/detail?id=${ms.id}" style="text-decoration: none">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/mau-sac/edit?id=${ms.id}" style="text-decoration: none">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/mau-sac/delete?id=${ms.id}" onclick="return confirm('Bạn có chắc muốn xóa?')" style="text-decoration: none">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty detailMs}">
    <h3>Chi tiết màu sắc</h3>
    <p>ID: ${detailMs.id}</p>
    <p>Mã: ${detailMs.ma}</p>
    <p>Tên màu: ${detailMs.tenMau}</p>
    <a href="${pageContext.request.contextPath}/admin/mau-sac">Đóng chi tiết</a>
</c:if>
</body>
</html>