<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý kích cỡ</title>
</head>
<body>

<h2>Quản lý kích cỡ</h2>

<%-- Form Thêm --%>
<form action="${pageContext.request.contextPath}/admin/kich-co/add" method="post">
    <input type="text" name="ma" placeholder="Mã kích cỡ" required>
    <input type="text" name="tenSize" placeholder="Tên kích cỡ" required>
    <button type="submit">Thêm</button>
</form>

<%-- Form Sửa (Hiện khi kcEdit không rỗng) --%>
<c:if test="${not empty kcEdit}">
    <h3>Sửa kích cỡ</h3>
    <form action="${pageContext.request.contextPath}/admin/kich-co/update" method="post">
        <input type="hidden" name="id" value="${kcEdit.id}">
        <input type="text" name="ma" value="${kcEdit.ma}" required>
        <input type="text" name="tenSize" value="${kcEdit.tenSize}" required>
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/kich-co">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="6">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã kích cỡ</th>
        <th>Tên kích cỡ</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="kc">
        <tr>
            <td>${kc.id}</td>
            <td>${kc.ma}</td>
            <td>${kc.tenSize}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/kich-co/detail?id=${kc.id}" style="text-decoration: none">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/kich-co/edit?id=${kc.id}" style="text-decoration: none">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/kich-co/delete?id=${kc.id}" onclick="return confirm('Bạn có chắc muốn xóa?')" style="text-decoration: none">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty detailKc}">
    <h3>Chi tiết kích cỡ</h3>
    <p>ID: ${detailKc.id}</p>
    <p>Mã: ${detailKc.ma}</p>
    <p>Tên size: ${detailKc.tenSize}</p>
    <a href="${pageContext.request.contextPath}/admin/kich-co">Đóng chi tiết</a>
</c:if>
</body>
</html>