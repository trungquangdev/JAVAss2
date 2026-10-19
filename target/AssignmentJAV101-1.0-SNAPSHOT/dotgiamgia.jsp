<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Đợt Giảm Giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Đợt Giảm Giá</h2>

    <!-- Form Lọc -->
    <form action="${pageContext.request.contextPath}/admin/dot-giam-gia" method="get" class="row g-3 mb-3">
        <div class="col-md-5"><input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm theo mã, tên đợt..."></div>
        <div class="col-md-3">
            <select class="form-select" name="trangThai">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="1" ${param.trangThai == '1' ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${param.trangThai == '0' ? 'selected' : ''}>Ngừng</option>
            </select>
        </div>
        <div class="col-md-4">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            <a href="${pageContext.request.contextPath}/admin/dot-giam-gia" class="btn btn-secondary">Làm mới</a>
        </div>
    </form>

    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Đợt Giảm Giá</h4>
        <form action="${pageContext.request.contextPath}/admin/dot-giam-gia/add" method="post" class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="ma" placeholder="Mã đợt" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="tenDot" placeholder="Tên đợt" required></div>
            <div class="col-md-2"><input type="number" class="form-control" name="phanTramGiam" placeholder="% Giảm" required></div>
            <div class="col-md-2"><input type="date" class="form-control" name="ngayBatDau" required></div>
            <div class="col-md-2"><input type="date" class="form-control" name="ngayKetThuc" required></div>
            <div class="col-md-2"><input type="number" class="form-control" name="trangThai" placeholder="Trạng thái" value="1"></div>
            <div class="col-md-2"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <c:if test="${not empty dggEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Đợt Giảm Giá</h4>
            <form action="${pageContext.request.contextPath}/admin/dot-giam-gia/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${dggEdit.id}">
                <div class="col-md-3"><input type="text" class="form-control" name="ma" value="${dggEdit.ma}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="tenDot" value="${dggEdit.tenDot}" required></div>
                <div class="col-md-2"><input type="number" class="form-control" name="phanTramGiam" value="${dggEdit.phanTramGiam}" required></div>
                <fmt:formatDate value="${dggEdit.ngayBatDau}" pattern="yyyy-MM-dd" var="ngayBD"/>
                <fmt:formatDate value="${dggEdit.ngayKetThuc}" pattern="yyyy-MM-dd" var="ngayKT"/>
                <div class="col-md-2"><input type="date" class="form-control" name="ngayBatDau" value="${ngayBD}" required></div>
                <div class="col-md-2"><input type="date" class="form-control" name="ngayKetThuc" value="${ngayKT}" required></div>
                <div class="col-md-2"><input type="number" class="form-control" name="trangThai" value="${dggEdit.trangThai}"></div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-warning w-100">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/dot-giam-gia" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark"><tr><th>Mã</th><th>Tên đợt</th><th>% Giảm</th><th>Ngày bắt đầu</th><th>Ngày kết thúc</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
        <tbody>
        <c:forEach items="${list}" var="dgg">
            <tr>
                <td>${dgg.ma}</td><td>${dgg.tenDot}</td><td>${dgg.phanTramGiam}%</td><td><fmt:formatDate value="${dgg.ngayBatDau}" pattern="yyyy-MM-dd"/></td><td><fmt:formatDate value="${dgg.ngayKetThuc}" pattern="yyyy-MM-dd"/></td><td>${dgg.trangThai}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/dot-giam-gia/edit?id=${dgg.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/dot-giam-gia/delete?id=${dgg.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/dot-giam-gia/detail?id=${dgg.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty detailDgg}">
        <div class="border p-3 mt-3">
            <h3>Chi tiết đợt giảm giá</h3>
            <p>ID: ${detailDgg.id}</p><p>Mã: ${detailDgg.ma}</p><p>Tên đợt: ${detailDgg.tenDot}</p><p>Phần trăm giảm: ${detailDgg.phanTramGiam}%</p>
            <a href="${pageContext.request.contextPath}/admin/dot-giam-gia" class="btn btn-secondary btn-sm">Đóng chi tiết</a>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>