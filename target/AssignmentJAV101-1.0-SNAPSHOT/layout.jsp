<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Trị Admin</title>
    <!-- Nhúng Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome để dùng icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- SIDEBAR MENU -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark text-white sidebar collapse min-vh-100 p-3">
            <h4 class="text-center py-3 text-warning">ADMIN PANEL</h4>
            <hr>
            <ul class="nav flex-column">
                <li class="nav-item mb-2">
                    <a href="${pageContext.request.contextPath}/admin/hoa-don" class="nav-link text-white">
                        <i class="fas fa-file-invoice-dollar me-2"></i> Quản Lý Hóa Đơn
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="${pageContext.request.contextPath}/admin/san-pham" class="nav-link text-white">
                        <i class="fas fa-box me-2"></i> Quản Lý Sản Phẩm
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="nav-link text-white">
                        <i class="fas fa-tags me-2"></i> Biến Thể Sản Phẩm
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia" class="nav-link text-white">
                        <i class="fas fa-ticket-alt me-2"></i> Phiếu Giảm Giá
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="${pageContext.request.contextPath}/admin/dot-giam-gia" class="nav-link text-white">
                        <i class="fas fa-calendar-alt me-2"></i> Đợt Giảm Giá
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="${pageContext.request.contextPath}/admin/nhan-vien" class="nav-link text-white">
                        <i class="fas fa-user-shield me-2"></i> Quản Lý Nhân Viên
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="${pageContext.request.contextPath}/admin/khach-hang" class="nav-link text-white">
                        <i class="fas fa-users me-2"></i> Quản Lý Khách Hàng
                    </a>
                </li>
            </ul>
        </nav>

        <!-- MAIN CONTENT AREA -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <!-- Nội dung từng trang JSP sẽ được đổ vào đây -->
        </main>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>