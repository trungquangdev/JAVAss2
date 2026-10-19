<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Khách Hàng</h2>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-outline-secondary">
            <i class="fas fa-home me-1"></i> Trang Chủ Admin
        </a>
    </div>

    <!-- Form Lọc & Tìm kiếm -->
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

    <!-- Form Thêm -->
    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Khách Hàng</h4>
        <form action="${pageContext.request.contextPath}/admin/khach-hang/add" method="post" class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="ma" placeholder="Mã khách hàng" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="ten" placeholder="Tên khách hàng" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="sdt" placeholder="Số điện thoại"></div>
            <div class="col-md-3"><input type="email" class="form-control" name="email" placeholder="Email"></div>
            <div class="col-md-6"><input type="text" class="form-control" name="diaChi" placeholder="Địa chỉ"></div>
            <div class="col-md-3"><input type="number" class="form-control" name="trangThai" placeholder="Trạng thái" value="1"></div>
            <div class="col-md-3"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <!-- Form Sửa -->
    <c:if test="${not empty editKhachHang}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Khách Hàng</h4>
            <form action="${pageContext.request.contextPath}/admin/khach-hang/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${editKhachHang.id}">
                <div class="col-md-3"><input type="text" class="form-control" name="ma" value="${editKhachHang.ma}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="ten" value="${editKhachHang.ten}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="sdt" value="${editKhachHang.sdt}"></div>
                <div class="col-md-3"><input type="email" class="form-control" name="email" value="${editKhachHang.email}"></div>
                <div class="col-md-6"><input type="text" class="form-control" name="diaChi" value="${editKhachHang.diaChi}"></div>
                <div class="col-md-3"><input type="number" class="form-control" name="trangThai" value="${editKhachHang.trangThai}"></div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-warning w-100">Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/admin/khach-hang" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <!-- Bảng danh sách -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th><th>Mã</th><th>Tên</th><th>SĐT</th><th>Email</th><th>Địa chỉ</th><th>Trạng thái</th><th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="kh">
            <tr>
                <td>${kh.id}</td><td>${kh.ma}</td><td>${kh.ten}</td><td>${kh.sdt}</td><td>${kh.email}</td><td>${kh.diaChi}</td><td>${kh.trangThai}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/khach-hang/edit?id=${kh.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/khach-hang/delete?id=${kh.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/khach-hang/detail?id=${kh.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

<%--    <c:if test="${not empty detail}">--%>
<%--        <div class="border p-3 mt-3">--%>
<%--            <h3>Chi tiết khách hàng</h3>--%>
<%--            <p>ID: ${detail.id}</p><p>Mã: ${detail.ma}</p><p>Tên: ${detail.ten}</p><p>SĐT: ${detail.sdt}</p><p>Email: ${detail.email}</p><p>Địa chỉ: ${detail.diaChi}</p>--%>
<%--            <a href="${pageContext.request.contextPath}/admin/khach-hang" class="btn btn-secondary btn-sm">Đóng chi tiết</a>--%>
<%--        </div>--%>
<%--    </c:if>--%>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Modal Hiển Thị Chi Tiết -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title" id="detailModalLabel">Chi tiết khách hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>ID:</strong> <span id="modalId"></span></p>
                <p><strong>Mã:</strong> <span id="modalMa"></span></p>
                <p><strong>Tên:</strong> <span id="modalTen"></span></p>
                <p><strong>SĐT:</strong> <span id="modalSdt"></span></p>
                <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                <p><strong>Địa chỉ:</strong> <span id="modalDiaChi"></span></p>
                <p><strong>Trạng thái:</strong> <span id="modalTrangThai"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- Script tự động bật Modal nếu có dữ liệu detail được truyền từ Controller -->
<c:if test="${not empty detail}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Gán dữ liệu vào modal
            document.getElementById("modalId").innerText = "${detail.id}";
            document.getElementById("modalMa").innerText = "${detail.ma}";
            document.getElementById("modalTen").innerText = "${detail.ten}";
            document.getElementById("modalSdt").innerText = "${detail.sdt}";
            document.getElementById("modalEmail").innerText = "${detail.email}";
            document.getElementById("modalDiaChi").innerText = "${detail.diaChi}";
            document.getElementById("modalTrangThai").innerText = "${detail.trangThai == 1 ? 'Hoạt động' : 'Ngừng'}";

            // Kích hoạt hiển thị modal bằng Bootstrap 5
            var myModal = new bootstrap.Modal(document.getElementById('detailModal'));
            myModal.show();
        });
    </script>
</c:if>
</body>
</html>