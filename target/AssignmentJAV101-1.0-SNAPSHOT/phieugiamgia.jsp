<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Phiếu Giảm Giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Phiếu Giảm Giá</h2>

    <!-- Form Lọc -->
    <form action="${pageContext.request.contextPath}/admin/phieu-giam-gia" method="get" class="row g-3 mb-3">
        <div class="col-md-5"><input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm theo mã, tên phiếu..."></div>
        <div class="col-md-3">
            <select class="form-select" name="trangThai">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="1" ${param.trangThai == '1' ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${param.trangThai == '0' ? 'selected' : ''}>Ngừng</option>
            </select>
        </div>
        <div class="col-md-4">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia" class="btn btn-secondary">Làm mới</a>
        </div>
    </form>

    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Phiếu Giảm Giá</h4>
        <form action="${pageContext.request.contextPath}/admin/phieu-giam-gia/add" method="post" class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="ma" placeholder="Mã" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="tenPhieu" placeholder="Tên phiếu" required></div>
            <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="giaTriGiam" placeholder="Giá trị giảm" required></div>
            <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="giamToiDa" placeholder="Giảm tối đa" required></div>
            <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="donToiThieu" placeholder="Đơn tối thiểu" required></div>
            <div class="col-md-3"><input type="number" class="form-control" name="soLuong" placeholder="Số lượng" required></div>
            <div class="col-md-3"><input type="date" class="form-control" name="ngayKetThuc" required></div>
            <div class="col-md-2"><input type="number" class="form-control" name="trangThai" placeholder="Trạng thái" value="1"></div>
            <div class="col-md-1"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <c:if test="${not empty pggEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Phiếu Giảm Giá</h4>
            <form action="${pageContext.request.contextPath}/admin/phieu-giam-gia/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${pggEdit.id}">
                <div class="col-md-3"><input type="text" class="form-control" name="ma" value="${pggEdit.ma}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="tenPhieu" value="${pggEdit.tenPhieu}" required></div>
                <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="giaTriGiam" value="${pggEdit.giaTriGiam}" required></div>
                <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="giamToiDa" value="${pggEdit.giamToiDa}" required></div>
                <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="donToiThieu" value="${pggEdit.donToiThieu}" required></div>
                <div class="col-md-3"><input type="number" class="form-control" name="soLuong" value="${pggEdit.soLuong}" required></div>
                <fmt:formatDate value="${pggEdit.ngayKetThuc}" pattern="yyyy-MM-dd" var="ngayKT"/>
                <div class="col-md-3"><input type="date" class="form-control" name="ngayKetThuc" value="${ngayKT}" required></div>
                <div class="col-md-2"><input type="number" class="form-control" name="trangThai" value="${pggEdit.trangThai}"></div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-warning w-100">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark"><tr><th>Mã</th><th>Tên phiếu</th><th>Giá trị giảm</th><th>Giảm tối đa</th><th>Đơn tối thiểu</th><th>Số lượng</th><th>Ngày kết thúc</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
        <tbody>
        <c:forEach items="${list}" var="pgg">
            <tr>
                <td>${pgg.ma}</td><td>${pgg.tenPhieu}</td><td>${pgg.giaTriGiam}</td><td>${pgg.giamToiDa}</td><td>${pgg.donToiThieu}</td><td>${pgg.soLuong}</td><td><fmt:formatDate value="${pgg.ngayKetThuc}" pattern="yyyy-MM-dd"/></td><td>${pgg.trangThai}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia/edit?id=${pgg.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia/delete?id=${pgg.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia/detail?id=${pgg.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty detailPgg}">
        <div class="border p-3 mt-3">
            <h3>Chi tiết phiếu giảm giá</h3>
            <p>ID: ${detailPgg.id}</p><p>Mã: ${detailPgg.ma}</p><p>Tên phiếu: ${detailPgg.tenPhieu}</p><p>Giá trị giảm: ${detailPgg.giaTriGiam}</p><p>Giảm tối đa: ${detailPgg.giamToiDa}</p><p>Đơn tối thiểu: ${detailPgg.donToiThieu}</p><p>Số lượng: ${detailPgg.soLuong}</p>
            <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia" class="btn btn-secondary btn-sm">Đóng chi tiết</a>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>