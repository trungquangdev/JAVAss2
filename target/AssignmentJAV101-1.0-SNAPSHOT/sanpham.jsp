<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Sản Phẩm</h2>

    <!-- Form Lọc & Tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/san-pham" method="get" class="row g-3 mb-3">
        <div class="col-md-5">
            <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm theo mã, tên, mô tả...">
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
            <a href="${pageContext.request.contextPath}/admin/san-pham" class="btn btn-secondary">Làm mới</a>
        </div>
    </form>

    <!-- Form Thêm -->
    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Sản Phẩm</h4>
        <form action="${pageContext.request.contextPath}/admin/san-pham/add" method="post" class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="ma" placeholder="Mã sản phẩm" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="tenSanPham" placeholder="Tên sản phẩm" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="moTa" placeholder="Mô tả"></div>
            <div class="col-md-2"><input type="number" class="form-control" name="trangThai" placeholder="Trạng thái" value="1"></div>
            <div class="col-md-1"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <!-- Form Sửa -->
    <c:if test="${not empty spEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Sản Phẩm</h4>
            <form action="${pageContext.request.contextPath}/admin/san-pham/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${spEdit.id}">
                <div class="col-md-3"><input type="text" class="form-control" name="ma" value="${spEdit.ma}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="tenSanPham" value="${spEdit.tenSanPham}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="moTa" value="${spEdit.moTa}"></div>
                <div class="col-md-2"><input type="number" class="form-control" name="trangThai" value="${spEdit.trangThai}"></div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-warning w-100">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/san-pham" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <!-- Bảng danh sách -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr><th>Mã</th><th>Tên sản phẩm</th><th>Mô tả</th><th>Trạng thái</th><th>Thao tác</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="s">
            <tr>
                <td>${s.ma}</td><td>${s.tenSanPham}</td><td>${s.moTa}</td><td>${s.trangThai}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/san-pham/edit?id=${s.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/san-pham/delete?id=${s.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/san-pham/detail?id=${s.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty detail}">
        <div class="border p-3 mt-3">
            <h3>Chi tiết sản phẩm</h3>
            <p>ID: ${detail.id}</p><p>Mã: ${detail.ma}</p><p>Tên: ${detail.tenSanPham}</p><p>Mô tả: ${detail.moTa}</p><p>Trạng thái: ${detail.trangThai}</p>
            <a href="${pageContext.request.contextPath}/admin/san-pham" class="btn btn-secondary btn-sm">Đóng chi tiết</a>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>