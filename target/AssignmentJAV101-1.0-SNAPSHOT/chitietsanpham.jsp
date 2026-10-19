<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Biến Thể Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Biến Thể Sản Phẩm</h2>

    <!-- Form Lọc -->
    <form action="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" method="get" class="row g-3 mb-3">
        <div class="col-md-3">
            <select class="form-select" name="idSanPham">
                <option value="">-- Tất cả sản phẩm --</option>
                <c:forEach items="${listSP}" var="sp">
                    <option value="${sp.id}" ${param.idSanPham == sp.id ? 'selected' : ''}>${sp.tenSanPham}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <select class="form-select" name="idMauSac">
                <option value="">-- Màu sắc --</option>
                <c:forEach items="${listMS}" var="ms">
                    <option value="${ms.id}" ${param.idMauSac == ms.id ? 'selected' : ''}>${ms.tenMau}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <select class="form-select" name="idKichCo">
                <option value="">-- Kích cỡ --</option>
                <c:forEach items="${listKC}" var="kc">
                    <option value="${kc.id}" ${param.idKichCo == kc.id ? 'selected' : ''}>${kc.tenSize}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <select class="form-select" name="trangThai">
                <option value="">-- Trạng thái --</option>
                <option value="1" ${param.trangThai == '1' ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${param.trangThai == '0' ? 'selected' : ''}>Ngừng</option>
            </select>
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-primary">Lọc</button>
            <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="btn btn-secondary">Làm mới</a>
        </div>
    </form>

    <!-- Form Thêm -->
    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Biến Thể</h4>
        <form action="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/add" method="post" class="row g-3">
            <div class="col-md-3">
                <select class="form-select" name="idSanPham" required>
                    <option value="">Chọn sản phẩm</option>
                    <c:forEach items="${listSP}" var="sp"><option value="${sp.id}">${sp.tenSanPham}</option></c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <select class="form-select" name="idMauSac" required>
                    <option value="">Chọn màu</option>
                    <c:forEach items="${listMS}" var="ms"><option value="${ms.id}">${ms.tenMau}</option></c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <select class="form-select" name="idKichCo" required>
                    <option value="">Chọn size</option>
                    <c:forEach items="${listKC}" var="kc"><option value="${kc.id}">${kc.tenSize}</option></c:forEach>
                </select>
            </div>
            <div class="col-md-2"><input type="number" step="0.01" class="form-control" name="giaBan" placeholder="Giá bán" required></div>
            <div class="col-md-2"><input type="number" class="form-control" name="soLuongTon" placeholder="Tồn kho" required></div>
            <div class="col-md-1"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <!-- Form Sửa -->
    <c:if test="${not empty ctspEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Biến Thể</h4>
            <form action="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${ctspEdit.id}">
                <div class="col-md-3">
                    <select class="form-select" name="idSanPham">
                        <c:forEach items="${listSP}" var="sp">
                            <option value="${sp.id}" ${sp.id == ctspEdit.sanPham.id ? 'selected' : ''}>${sp.tenSanPham}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" name="idMauSac">
                        <c:forEach items="${listMS}" var="ms">
                            <option value="${ms.id}" ${ms.id == ctspEdit.mauSac.id ? 'selected' : ''}>${ms.tenMau}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" name="idKichCo">
                        <c:forEach items="${listKC}" var="kc">
                            <option value="${kc.id}" ${kc.id == ctspEdit.kichCo.id ? 'selected' : ''}>${kc.tenSize}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2"><input type="number" step="0.01" class="form-control" name="giaBan" value="${ctspEdit.giaBan}" required></div>
                <div class="col-md-2"><input type="number" class="form-control" name="soLuongTon" value="${ctspEdit.soLuongTon}" required></div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-warning w-100">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark"><tr><th>ID</th><th>Sản phẩm</th><th>Màu</th><th>Size</th><th>Giá bán</th><th>Tồn kho</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
        <tbody>
        <c:forEach items="${list}" var="ctsp">
            <tr>
                <td>${ctsp.id}</td><td>${ctsp.sanPham.tenSanPham}</td><td>${ctsp.mauSac.tenMau}</td><td>${ctsp.kichCo.tenSize}</td><td>${ctsp.giaBan}</td><td>${ctsp.soLuongTon}</td><td>${ctsp.trangThai}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/edit?id=${ctsp.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/delete?id=${ctsp.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/detail?id=${ctsp.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty detailCtsp}">
        <div class="border p-3 mt-3">
            <h3>Chi tiết biến thể sản phẩm</h3>
            <p>ID: ${detailCtsp.id}</p><p>Sản phẩm: ${detailCtsp.sanPham.tenSanPham}</p><p>Màu: ${detailCtsp.mauSac.tenMau}</p><p>Size: ${detailCtsp.kichCo.tenSize}</p><p>Giá: ${detailCtsp.giaBan}</p><p>Tồn: ${detailCtsp.soLuongTon}</p>
            <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="btn btn-secondary btn-sm">Đóng chi tiết</a>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>