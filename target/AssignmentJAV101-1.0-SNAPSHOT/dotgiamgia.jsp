<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý đợt giảm giá</title>
</head>
<body>

<h2>Quản lý đợt giảm giá</h2>

<%-- Form Thêm --%>
<form action="${pageContext.request.contextPath}/admin/dot-giam-gia/add" method="post">
    <input type="text" name="ma" placeholder="Mã đợt" required>
    <input type="text" name="tenDot" placeholder="Tên đợt" required>
    <input type="number" name="phanTramGiam" placeholder="Phần trăm giảm (%)" required>
    Từ ngày: <input type="date" name="ngayBatDau" required>
    Đến ngày: <input type="date" name="ngayKetThuc" required>
    <input type="number" name="trangThai" placeholder="Trạng thái" value="1">
    <button type="submit">Thêm</button>
</form>

<%-- Form Sửa (Hiện khi dggEdit không rỗng) --%>
<c:if test="${not empty dggEdit}">
    <h3>Sửa đợt giảm giá</h3>
    <form action="${pageContext.request.contextPath}/admin/dot-giam-gia/update" method="post">
        <input type="hidden" name="id" value="${dggEdit.id}">
        <input type="text" name="ma" value="${dggEdit.ma}" required>
        <input type="text" name="tenDot" value="${dggEdit.tenDot}" required>
        <input type="number" name="phanTramGiam" value="${dggEdit.phanTramGiam}" required>
        <fmt:formatDate value="${dggEdit.ngayBatDau}" pattern="yyyy-MM-dd" var="ngayBD"/>
        <fmt:formatDate value="${dggEdit.ngayKetThuc}" pattern="yyyy-MM-dd" var="ngayKT"/>
        Từ ngày: <input type="date" name="ngayBatDau" value="${ngayBD}" required>
        Đến ngày: <input type="date" name="ngayKetThuc" value="${ngayKT}" required>
        <input type="number" name="trangThai" value="${dggEdit.trangThai}">
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/dot-giam-gia">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="6">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã</th>
        <th>Tên đợt</th>
        <th>Phần trăm giảm</th>
        <th>Ngày bắt đầu</th>
        <th>Ngày kết thúc</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="dgg">
        <tr>
            <td>${dgg.id}</td>
            <td>${dgg.ma}</td>
            <td>${dgg.tenDot}</td>
            <td>${dgg.phanTramGiam}%</td>
            <td><fmt:formatDate value="${dgg.ngayBatDau}" pattern="yyyy-MM-dd"/></td>
            <td><fmt:formatDate value="${dgg.ngayKetThuc}" pattern="yyyy-MM-dd"/></td>
            <td>${dgg.trangThai}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/dot-giam-gia/detail?id=${dgg.id}" style="text-decoration: none">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/dot-giam-gia/edit?id=${dgg.id}" style="text-decoration: none">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/dot-giam-gia/delete?id=${dgg.id}" onclick="return confirm('Bạn có chắc muốn xóa?')" style="text-decoration: none">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty detailDgg}">
    <h3>Chi tiết đợt giảm giá</h3>
    <p>ID: ${detailDgg.id}</p>
    <p>Mã: ${detailDgg.ma}</p>
    <p>Tên đợt: ${detailDgg.tenDot}</p>
    <p>Phần trăm giảm: ${detailDgg.phanTramGiam}%</p>
    <p>Ngày bắt đầu: <fmt:formatDate value="${detailDgg.ngayBatDau}" pattern="yyyy-MM-dd"/></p>
    <p>Ngày kết thúc: <fmt:formatDate value="${detailDgg.ngayKetThuc}" pattern="yyyy-MM-dd"/></p>
    <p>Trạng thái: ${detailDgg.trangThai}</p>
    <a href="${pageContext.request.contextPath}/admin/dot-giam-gia">Đóng chi tiết</a>
</c:if>
</body>
</html>