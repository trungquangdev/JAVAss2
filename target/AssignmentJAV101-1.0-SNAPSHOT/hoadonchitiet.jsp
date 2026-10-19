<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Hóa Đơn Chi Tiết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Hóa Đơn Chi Tiết</h2>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-outline-secondary">
            <i class="fas fa-home me-1"></i> Trang Chủ Admin
        </a>
    </div>

    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Hóa Đơn Chi Tiết</h4>
        <form action="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/add" method="post" class="row g-3">
            <div class="col-md-3">
                <select class="form-select" name="idHoaDon" required>
                    <option value="">Chọn hóa đơn</option>
                    <c:forEach items="${listHD}" var="hd"><option value="${hd.id}">${hd.maHoaDon}</option></c:forEach>
                </select>
            </div>
            <div class="col-md-4">
                <select class="form-select" name="idChiTietSanPham" required>
                    <option value="">Chọn biến thể sản phẩm</option>
                    <c:forEach items="${listCTSP}" var="ctsp">
                        <option value="${ctsp.id}">${ctsp.sanPham.tenSanPham} - ${ctsp.mauSac.tenMau} - ${ctsp.kichCo.tenSize}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2"><input type="number" class="form-control" name="soLuong" placeholder="Số lượng" required></div>
            <div class="col-md-2"><input type="number" step="0.01" class="form-control" name="donGia" placeholder="Đơn giá" required></div>
            <div class="col-md-1"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <c:if test="${not empty hdctEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Hóa Đơn Chi Tiết</h4>
            <form action="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${hdctEdit.id}">
                <div class="col-md-3">
                    <select class="form-select" name="idHoaDon">
                        <c:forEach items="${listHD}" var="hd">
                            <option value="${hd.id}" ${hd.id == hdctEdit.hoaDon.id ? 'selected' : ''}>${hd.maHoaDon}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <select class="form-select" name="idChiTietSanPham">
                        <c:forEach items="${listCTSP}" var="ctsp">
                            <option value="${ctsp.id}" ${ctsp.id == hdctEdit.chiTietSanPham.id ? 'selected' : ''}>${ctsp.sanPham.tenSanPham} - ${ctsp.mauSac.tenMau} - ${ctsp.kichCo.tenSize}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2"><input type="number" class="form-control" name="soLuong" value="${hdctEdit.soLuong}" required></div>
                <div class="col-md-2"><input type="number" step="0.01" class="form-control" name="donGia" value="${hdctEdit.donGia}" required></div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-warning w-100">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark"><tr><th>Mã HĐ</th><th>Sản phẩm / Biến thể</th><th>Số lượng</th><th>Đơn giá</th><th>Thao tác</th></tr></thead>
        <tbody>
        <c:forEach items="${list}" var="hdct">
            <tr>
                <td>${hdct.hoaDon.maHoaDon}</td><td>${hdct.chiTietSanPham.sanPham.tenSanPham} (${hdct.chiTietSanPham.mauSac.tenMau} - ${hdct.chiTietSanPham.kichCo.tenSize})</td><td>${hdct.soLuong}</td><td>${hdct.donGia}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/edit?id=${hdct.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/delete?id=${hdct.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don-chi-tiet/detail?id=${hdct.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="modal fade" id="detailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title">Chi tiết hóa đơn chi tiết</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Mã HĐ:</strong> <span id="modalMa"></span></p>
                    <p><strong>Sản phẩm:</strong> <span id="modalSP"></span></p>
                    <p><strong>Số lượng:</strong> <span id="modalSL"></span></p>
                    <p><strong>Đơn giá:</strong> <span id="modalGia"></span></p>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button></div>
            </div>
        </div>
    </div>

    <c:if test="${not empty detailHdct}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                document.getElementById("modalMa").innerText = "${detailHdct.hoaDon.maHoaDon}";
                document.getElementById("modalSP").innerText = "${detailHdct.chiTietSanPham.sanPham.tenSanPham}";
                document.getElementById("modalSL").innerText = "${detailHdct.soLuong}";
                document.getElementById("modalGia").innerText = "${detailHdct.donGia}";
                new bootstrap.Modal(document.getElementById('detailModal')).show();
            });
        </script>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>