<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ Thống Quản Lý Bán Hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light">
<div class="container py-5">
    <h1 class="text-center mb-4 text-primary fw-bold"><i class="fas fa-cogs me-2"></i>HỆ THỐNG QUẢN LÝ BÁN HÀNG - ADMIN</h1>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-users fa-3x text-primary mb-3"></i>
                    <h5 class="card-title">Quản Lý Khách Hàng</h5>
                    <a href="${pageContext.request.contextPath}/admin/khach-hang" class="btn btn-outline-primary mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-user-shield fa-3x text-success mb-3"></i>
                    <h5 class="card-title">Quản Lý Nhân Viên</h5>
                    <a href="${pageContext.request.contextPath}/admin/nhan-vien" class="btn btn-outline-success mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-box fa-3x text-warning mb-3"></i>
                    <h5 class="card-title">Quản Lý Sản Phẩm</h5>
                    <a href="${pageContext.request.contextPath}/admin/san-pham" class="btn btn-outline-warning mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-tags fa-3x text-info mb-3"></i>
                    <h5 class="card-title">Biến Thể Sản Phẩm</h5>
                    <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="btn btn-outline-info mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-palette fa-3x text-secondary mb-3"></i>
                    <h5 class="card-title">Thuộc Tính: Màu Sắc</h5>
                    <a href="${pageContext.request.contextPath}/admin/mau-sac" class="btn btn-outline-secondary mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-ruler fa-3x text-danger mb-3"></i>
                    <h5 class="card-title">Thuộc Tính: Kích Cỡ</h5>
                    <a href="${pageContext.request.contextPath}/admin/kich-co" class="btn btn-outline-danger mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-ticket-alt fa-3x text-dark mb-3"></i>
                    <h5 class="card-title">Phiếu Giảm Giá</h5>
                    <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia" class="btn btn-outline-dark mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-calendar-alt fa-3x text-primary mb-3"></i>
                    <h5 class="card-title">Đợt Giảm Giá</h5>
                    <a href="${pageContext.request.contextPath}/admin/dot-giam-gia" class="btn btn-outline-primary mt-2">Truy cập</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="fas fa-file-invoice-dollar fa-3x text-success mb-3"></i>
                    <h5 class="card-title">Quản Lý Hóa Đơn</h5>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don" class="btn btn-outline-success mt-2">Truy cập</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>