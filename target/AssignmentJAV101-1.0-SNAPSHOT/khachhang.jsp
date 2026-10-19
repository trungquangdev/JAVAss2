
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý khách hàng</title>
</head>
<body>

<h2>Quản lý khách hàng</h2>

<form action="${pageContext.request.contextPath}/admin/khach-hang" method="get" class="row g-3 mb-3">
    <div class="col-md-5">
        <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm kiếm mã, tên, sđt, email, địa chỉ...">
    </div>
    <div class="col-md-3">
        <select class="form-select" name="trangThai">
            <option value="">-- Tất cả trạng thái --</option>
            <option value="1" ${param.trangThai == '1' ? 'selected' : ''}>Hoạt động</option>
            <option value="0" ${param.trangThai == '0' ? 'selected' : ''}>Ngừng</option>
        </select>
    </div>
    <div class="col-md-4">
        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        <a href="${pageContext.request.contextPath}/admin/khach-hang" class="btn btn-secondary">Làm mới</a>
    </div>
</form>

<form action="${pageContext.request.contextPath}/admin/khach-hang/add" method="post">
    <input type="text" name="ma" placeholder="Mã khách hàng" required>
    <input type="text" name="ten" placeholder="Tên khách hàng" required>
    <input type="text" name="sdt" placeholder="Số điện thoại">
    <input type="email" name="email" placeholder="Email">
    <input type="text" name="diaChi" placeholder="Địa chỉ">
    <input type="number" name="trangThai" placeholder="Trạng thái" value="1">

    <button type="submit">Thêm</button>
</form>

<c:if test="${not empty editKhachHang}">
    <h3>Sửa khách hàng</h3>

    <form action="${pageContext.request.contextPath}/admin/khach-hang/update" method="post">
        <input type="hidden" name="id" value="${editKhachHang.id}">
        <input type="text" name="ma" value="${editKhachHang.ma}" required>
        <input type="text" name="ten" value="${editKhachHang.ten}" required>
        <input type="text" name="sdt" value="${editKhachHang.sdt}">
        <input type="email" name="email" value="${editKhachHang.email}">
        <input type="text" name="diaChi" value="${editKhachHang.diaChi}">
        <input type="number" name="trangThai" value="${editKhachHang.trangThai}">

        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/khach-hang">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã</th>
        <th>Tên</th>
        <th>Số điện thoại</th>
        <th>Email</th>
        <th>Địa chỉ</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach items="${list}" var="kh">
        <tr>
            <td>${kh.id}</td>
            <td>${kh.ma}</td>
            <td>${kh.ten}</td>
            <td>${kh.sdt}</td>
            <td>${kh.email}</td>
            <td>${kh.diaChi}</td>
            <td>${kh.trangThai}</td>
            <td>
                <a href="/admin/khach-hang/detail?id=${kh.id}">detail</a>
                <a href="${pageContext.request.contextPath}/admin/khach-hang/edit?id=${kh.id}">Sửa</a>

                <a href="${pageContext.request.contextPath}/admin/khach-hang/delete?id=${kh.id}"
                   onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<%--     <a href="${pageContext.request.contextPath}/chi-tiet-san-pham/detail?id=${s.idCTSP}"> Detail </a>--%>
<%--    viet trong action--%>

<c:if test="${not empty detail}">
    <h3>Chi tiết khách hàng</h3>
    <p>ID: ${detail.id}</p>
    <p>Mã: ${detail.ma}</p>
    <p>Tên: ${detail.ten}</p>
    <p>SĐT: ${detail.sdt}</p>
    <p>Email: ${detail.email}</p>
    <p>Địa chỉ: ${detail.diaChi}</p>
    <p>Trạng thái: ${detail.trangThai}</p>
    <a href="/admin/khach-hang">Đóng chi tiết</a>
</c:if>
</body>
</html>
