<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Biến Thể Sản Phẩm</title>
    <!-- Nhúng Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold"><i class="fas fa-tags me-2"></i>Quản Lý Biến Thể Sản Phẩm (Chi Tiết SP)</h2>

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
                <option value="1" ${param.trangThai == '1' ? 'selected' : ''}>Đang bán</option>
                <option value="0" ${param.trangThai == '0' ? 'selected' : ''}>Ngừng bán</option>
            </select>
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-primary">Lọc</button>
            <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="btn btn-secondary">Làm mới</a>
        </div>
    </form>

    <!-- FORM THÊM / SỬA BIẾN THỂ SẢN PHẨM -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">${not empty ctspEdit ? 'Cập Nhật Biến Thể Sản Phẩm' : 'Thêm Mới Biến Thể Sản Phẩm'}</h5>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/${not empty ctspEdit ? 'update' : 'add'}" method="post">
                <c:if test="${not empty ctspEdit}">
                    <input type="hidden" name="id" value="${ctspEdit.id}">
                </c:if>
                <div class="row g-3">
                    <!-- Combobox chọn Sản phẩm -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Sản Phẩm</label>
                        <select class="form-select" name="idSanPham" required>
                            <option value="">-- Chọn sản phẩm --</option>
                            <c:forEach items="${listSP}" var="sp">
                                <option value="${sp.id}" ${sp.id == ctspEdit.sanPham.id ? 'selected' : ''}>
                                        ${sp.tenSanPham}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Combobox chọn Màu sắc -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Màu Sắc</label>
                        <select class="form-select" name="idMauSac" required>
                            <option value="">-- Chọn màu sắc --</option>
                            <c:forEach items="${listMS}" var="ms">
                                <option value="${ms.id}" ${ms.id == ctspEdit.mauSac.id ? 'selected' : ''}>
                                        ${ms.tenMau}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Combobox chọn Kích cỡ -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Kích Cỡ</label>
                        <select class="form-select" name="idKichCo" required>
                            <option value="">-- Chọn kích cỡ --</option>
                            <c:forEach items="${listKC}" var="kc">
                                <option value="${kc.id}" ${kc.id == ctspEdit.kichCo.id ? 'selected' : ''}>
                                        ${kc.tenSize}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Các ô nhập thông tin giá và số lượng -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Giá Bán</label>
                        <input type="number" step="0.01" class="form-control" name="giaBan" value="${ctspEdit.giaBan}" placeholder="Nhập giá bán" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Số Lượng Tồn</label>
                        <input type="number" class="form-control" name="soLuongTon" value="${ctspEdit.soLuongTon}" placeholder="Nhập số lượng tồn" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Trạng Thái</label>
                        <select class="form-select" name="trangThai">
                            <option value="1" ${ctspEdit.trangThai == 1 ? 'selected' : ''}>Đang bán</option>
                            <option value="0" ${ctspEdit.trangThai == 0 ? 'selected' : ''}>Ngừng bán</option>
                        </select>
                    </div>

                    <!-- Nút thao tác form -->
                    <div class="col-md-12 text-end">
                        <c:if test="${not empty ctspEdit}">
                            <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="btn btn-secondary me-2">Hủy</a>
                        </c:if>
                        <button type="submit" class="btn btn-success px-4">
                            <i class="fas fa-save me-1"></i> ${not empty ctspEdit ? 'Cập Nhật' : 'Thêm Mới'}
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- BẢNG DANH SÁCH BIẾN THỂ SẢN PHẨM -->
    <div class="card shadow-sm">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 text-secondary">Danh Sách Biến Thể Sản Phẩm</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Màu Sắc</th>
                        <th>Kích Cỡ</th>
                        <th>Giá Bán</th>
                        <th>Tồn Kho</th>
                        <th>Trạng Thái</th>
                        <th class="text-center">Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="ctsp">
                        <tr>
                            <td>${ctsp.id}</td>
                            <td class="fw-bold">${ctsp.sanPham.tenSanPham}</td>
                            <td><span class="badge bg-secondary">${ctsp.mauSac.tenMau}</span></td>
                            <td><span class="badge bg-info text-dark">${ctsp.kichCo.tenSize}</span></td>
                            <td class="text-danger fw-bold">${ctsp.giaBan} VNĐ</td>
                            <td>${ctsp.soLuongTon}</td>
                            <td>
                                    <span class="badge ${ctsp.trangThai == 1 ? 'bg-success' : 'bg-danger'}">
                                            ${ctsp.trangThai == 1 ? 'Đang bán' : 'Ngừng bán'}
                                    </span>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/detail?id=${ctsp.id}" class="btn btn-info btn-sm text-white me-1">
                                    <i class="fas fa-eye"></i> Chi tiết
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/edit?id=${ctsp.id}" class="btn btn-warning btn-sm text-white me-1">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/delete?id=${ctsp.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa biến thể này?')">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- KHUNG HIỂN THỊ CHI TIẾT (NẾU CÓ) -->
    <c:if test="${not empty detailCtsp}">
        <div class="card shadow-sm mt-4 border-info">
            <div class="card-header bg-info text-white">
                <h5 class="mb-0">Chi Tiết Biến Thể Sản Phẩm</h5>
            </div>
            <div class="card-body">
                <p><strong>ID:</strong> ${detailCtsp.id}</p>
                <p><strong>Sản Phẩm:</strong> ${detailCtsp.sanPham.tenSanPham}</p>
                <p><strong>Màu Sắc:</strong> ${detailCtsp.mauSac.tenMau}</p>
                <p><strong>Kích Cỡ:</strong> ${detailCtsp.kichCo.tenSize}</p>
                <p><strong>Giá Bán:</strong> ${detailCtsp.giaBan} VNĐ</p>
                <p><strong>Số Lượng Tồn:</strong> ${detailCtsp.soLuongTon}</p>
                <p><strong>Trạng Thái:</strong> ${detailCtsp.trangThai == 1 ? 'Đang bán' : 'Ngừng bán'}</p>
                <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham" class="btn btn-secondary btn-sm">Đóng chi tiết</a>
            </div>
        </div>
    </c:if>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>