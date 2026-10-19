<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Nhân Viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Nhân Viên</h2>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-outline-secondary">
            <i class="fas fa-home me-1"></i> Trang Chủ Admin
        </a>
    </div>

    <!-- Form Lọc & Tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/nhan-vien" method="get" class="row g-3 mb-3">
        <div class="col-md-5">
            <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm kiếm mã, tên, email, sđt, chức vụ...">
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
            <a href="${pageContext.request.contextPath}/admin/nhan-vien" class="btn btn-secondary">Làm mới</a>
        </div>
    </form>

    <!-- Form Thêm -->
    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Nhân Viên</h4>
        <form action="${pageContext.request.contextPath}/admin/nhan-vien/add" method="post" class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="ma" placeholder="Mã" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="ten" placeholder="Tên" required></div>
            <div class="col-md-3"><input type="email" class="form-control" name="email" placeholder="Email" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="sdt" placeholder="SĐT"></div>
            <div class="col-md-3"><input type="password" class="form-control" name="matKhau" placeholder="Mật khẩu" required></div>
            <div class="col-md-3"><input type="text" class="form-control" name="chucVu" placeholder="Chức vụ"></div>
            <div class="col-md-3"><input type="number" class="form-control" name="trangThai" placeholder="Trạng thái" value="1"></div>
            <div class="col-md-3"><button type="submit" class="btn btn-success w-100" onclick="return confirm('Thêm thành công?')">Thêm</button></div>
        </form>
    </div>

    <!-- Form Sửa -->
    <c:if test="${not empty nvEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Nhân Viên</h4>
            <form action="${pageContext.request.contextPath}/admin/nhan-vien/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${nvEdit.id}">
                <div class="col-md-3"><input type="text" class="form-control" name="ma" value="${nvEdit.ma}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="ten" value="${nvEdit.ten}" required></div>
                <div class="col-md-3"><input type="email" class="form-control" name="email" value="${nvEdit.email}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="sdt" value="${nvEdit.sdt}"></div>
                <div class="col-md-3"><input type="password" class="form-control" name="matKhau" value="${nvEdit.matKhau}" required></div>
                <div class="col-md-3"><input type="text" class="form-control" name="chucVu" value="${nvEdit.chucVu}"></div>
                <div class="col-md-3"><input type="number" class="form-control" name="trangThai" value="${nvEdit.trangThai}"></div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-warning w-100">Xác nhận</button>
                    <a href="${pageContext.request.contextPath}/admin/nhan-vien" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <!-- Bảng danh sách -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr><th>Mã</th><th>Tên</th><th>Email</th><th>SĐT</th><th>Mật khẩu</th><th>Chức vụ</th><th>Trạng thái</th><th>Thao tác</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="nv">
            <tr>
                <td>${nv.ma}</td><td>${nv.ten}</td><td>${nv.email}</td><td>${nv.sdt}</td><td>${nv.matKhau}</td><td>${nv.chucVu}</td><td>${nv.trangThai}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/nhan-vien/edit?id=${nv.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/nhan-vien/delete?id=${nv.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/nhan-vien/detail?id=${nv.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Modal Popup Chi tiết Nhân viên -->
    <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title" id="detailModalLabel">Chi tiết nhân viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Mã:</strong> <span id="modalMa"></span></p>
                    <p><strong>Tên:</strong> <span id="modalTen"></span></p>
                    <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                    <p><strong>SĐT:</strong> <span id="modalSdt"></span></p>
                    <p><strong>Mật khẩu:</strong> <span id="modalMatKhau"></span></p>
                    <p><strong>Chức vụ:</strong> <span id="modalChucVu"></span></p>
                    <p><strong>Trạng thái:</strong> <span id="modalTrangThai"></span></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${not empty detailNv}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                document.getElementById("modalMa").innerText = "${detailNv.ma}";
                document.getElementById("modalTen").innerText = "${detailNv.ten}";
                document.getElementById("modalEmail").innerText = "${detailNv.email}";
                document.getElementById("modalSdt").innerText = "${detailNv.sdt}";
                document.getElementById("modalMatKhau").innerText = "${detailNv.matKhau}";
                document.getElementById("modalChucVu").innerText = "${detailNv.chucVu}";
                document.getElementById("modalTrangThai").innerText = "${detailNv.trangThai == 1 ? 'Hoạt động' : 'Ngừng'}";

                var myModal = new bootstrap.Modal(document.getElementById('detailModal'));
                myModal.show();
            });
        </script>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>