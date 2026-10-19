<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Hóa Đơn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Hóa Đơn</h2>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-outline-secondary">
            <i class="fas fa-home me-1"></i> Trang Chủ Admin
        </a>
    </div>

    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Hóa Đơn</h4>
        <form action="${pageContext.request.contextPath}/admin/hoa-don/add" method="post" class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="maHoaDon" placeholder="Mã HĐ" required></div>
            <div class="col-md-3">
                <select class="form-select" name="idKhachHang" required>
                    <option value="">Chọn khách hàng</option>
                    <c:forEach items="${listKH}" var="kh"><option value="${kh.id}">${kh.ten}</option></c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" name="idNhanVien" required>
                    <option value="">Chọn nhân viên</option>
                    <c:forEach items="${listNV}" var="nv"><option value="${nv.id}">${nv.ten}</option></c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" name="idPhieuGiamGia">
                    <option value="">-- Chọn phiếu giảm giá --</option>
                    <c:forEach items="${listPGG}" var="pgg"><option value="${pgg.id}">${pgg.tenPhieu}</option></c:forEach>
                </select>
            </div>
            <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="tongTien" placeholder="Tổng tiền" required></div>
            <div class="col-md-3"><input type="date" class="form-control" name="ngayTao" required></div>
            <div class="col-md-2"><input type="number" class="form-control" name="trangThai" placeholder="Trạng thái" value="1"></div>
            <div class="col-md-2"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <c:if test="${not empty hdEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Hóa Đơn</h4>
            <form action="${pageContext.request.contextPath}/admin/hoa-don/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${hdEdit.id}">
                <div class="col-md-3"><input type="text" class="form-control" name="maHoaDon" value="${hdEdit.maHoaDon}" required></div>
                <div class="col-md-3">
                    <select class="form-select" name="idKhachHang">
                        <c:forEach items="${listKH}" var="kh">
                            <option value="${kh.id}" ${kh.id == hdEdit.khachHang.id ? 'selected' : ''}>${kh.ten}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="idNhanVien">
                        <c:forEach items="${listNV}" var="nv">
                            <option value="${nv.id}" ${nv.id == hdEdit.nhanVien.id ? 'selected' : ''}>${nv.ten}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="idPhieuGiamGia">
                        <option value="">-- Chọn phiếu giảm giá --</option>
                        <c:forEach items="${listPGG}" var="pgg">
                            <option value="${pgg.id}" ${hdEdit.phieuGiamGia != null && pgg.id == hdEdit.phieuGiamGia.id ? 'selected' : ''}>${pgg.tenPhieu}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3"><input type="number" step="0.01" class="form-control" name="tongTien" value="${hdEdit.tongTien}" required></div>
                <fmt:formatDate value="${hdEdit.ngayTao}" pattern="yyyy-MM-dd" var="ngayT"/>
                <div class="col-md-3"><input type="date" class="form-control" name="ngayTao" value="${ngayT}" required></div>
                <div class="col-md-2"><input type="number" class="form-control" name="trangThai" value="${hdEdit.trangThai}"></div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-warning w-100">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark"><tr><th>Mã HĐ</th><th>Khách hàng</th><th>Nhân viên</th><th>Tổng tiền</th><th>Ngày tạo</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
        <tbody>
        <c:forEach items="${list}" var="hd">
            <tr>
                <td>${hd.maHoaDon}</td><td>${hd.khachHang.ten}</td><td>${hd.nhanVien.ten}</td><td>${hd.tongTien}</td><td><fmt:formatDate value="${hd.ngayTao}" pattern="yyyy-MM-dd"/></td><td>${hd.trangThai}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don/edit?id=${hd.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don/delete?id=${hd.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/hoa-don/detail?id=${hd.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="modal fade" id="detailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title">Chi tiết hóa đơn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Mã HĐ:</strong> <span id="modalMa"></span></p>
                    <p><strong>Khách hàng:</strong> <span id="modalKH"></span></p>
                    <p><strong>Nhân viên:</strong> <span id="modalNV"></span></p>
                    <p><strong>Tổng tiền:</strong> <span id="modalTien"></span></p>
                </div>
                <div class="modal-footer"><button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button></div>
            </div>
        </div>
    </div>

    <c:if test="${not empty detailHd}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                document.getElementById("modalMa").innerText = "${detailHd.maHoaDon}";
                document.getElementById("modalKH").innerText = "${detailHd.khachHang.ten}";
                document.getElementById("modalNV").innerText = "${detailHd.nhanVien.ten}";
                document.getElementById("modalTien").innerText = "${detailHd.tongTien}";
                new bootstrap.Modal(document.getElementById('detailModal')).show();
            });
        </script>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>