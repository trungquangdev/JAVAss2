<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light">

<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold"><i class="fas fa-box-open me-2"></i>Quản Lý Sản Phẩm</h2>

    <!-- FORM TÌM KIẾM VÀ LỌC -->
    <form action="${pageContext.request.contextPath}/admin/san-pham" method="get" class="row g-3 mb-3">
        <div class="col-md-5">
            <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm kiếm theo mã, tên, mô tả...">
        </div>
        <div class="col-md-3">
            <select class="form-select" name="trangThai">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="1" ${param.trangThai == '1' ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${param.trangThai == '0' ? 'selected' : ''}>Ngừng kinh doanh</option>
            </select>
        </div>
        <div class="col-md-4">
            <button type="submit" class="btn btn-primary"><i class="fas fa-search me-1"></i> Tìm kiếm</button>
            <a href="${pageContext.request.contextPath}/admin/san-pham" class="btn btn-secondary"><i class="fas fa-redo me-1"></i> Làm mới</a>
        </div>
    </form>

    <!-- FORM THÊM / SỬA SẢN PHẨM -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">${not empty spEdit ? 'Cập Nhật Sản Phẩm' : 'Thêm Mới Sản Phẩm'}</h5>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/san-pham/${not empty spEdit ? 'update' : 'add'}" method="post">
                <c:if test="${not empty spEdit}">
                    <input type="hidden" name="id" value="${spEdit.id}">
                </c:if>
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Mã Sản Phẩm</label>
                        <input type="text" class="form-control" name="ma" value="${spEdit.ma}" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Tên Sản Phẩm</label>
                        <input type="text" class="form-control" name="tenSanPham" value="${spEdit.tenSanPham}" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Trạng Thái</label>
                        <select class="form-select" name="trangThai">
                            <option value="1" ${spEdit.trangThai == 1 ? 'selected' : ''}>Đang kinh doanh</option>
                            <option value="0" ${spEdit.trangThai == 0 ? 'selected' : ''}>Ngừng kinh doanh</option>
                        </select>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Mô Tả</label>
                        <textarea class="form-control" name="moTa" rows="2">${spEdit.moTa}</textarea>
                    </div>
                    <div class="col-md-12 text-end">
                        <c:if test="${not empty spEdit}">
                            <a href="${pageContext.request.contextPath}/admin/san-pham" class="btn btn-secondary me-2">Hủy</a>
                        </c:if>
                        <button type="submit" class="btn btn-success px-4">
                            <i class="fas fa-save me-1"></i> ${not empty spEdit ? 'Cập Nhật' : 'Thêm Mới'}
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- BẢNG DANH SÁCH SẢN PHẨM -->
    <div class="card shadow-sm">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 text-secondary">Danh Sách Sản Phẩm</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Mã</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Mô Tả</th>
                        <th>Trạng Thái</th>
                        <th class="text-center">Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="sp">
                        <tr>
                            <td>${sp.id}</td>
                            <td class="fw-bold">${sp.ma}</td>
                            <td>${sp.tenSanPham}</td>
                            <td>${sp.moTa}</td>
                            <td>
                                    <span class="badge ${sp.trangThai == 1 ? 'bg-success' : 'bg-danger'}">
                                            ${sp.trangThai == 1 ? 'Hoạt động' : 'Ngừng'}
                                    </span>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/san-pham/detail?id=${sp.id}" class="btn btn-info btn-sm text-white me-1">
                                    <i class="fas fa-eye"></i> Chi tiết
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/san-pham/edit?id=${sp.id}" class="btn btn-warning btn-sm text-white me-1">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/san-pham/delete?id=${sp.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
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
    <c:if test="${not empty detailSp}">
        <div class="card shadow-sm mt-4 border-info">
            <div class="card-header bg-info text-white">
                <h5 class="mb-0">Thông Tin Chi Tiết Sản Phẩm</h5>
            </div>
            <div class="card-body">
                <p><strong>ID:</strong> ${detailSp.id}</p>
                <p><strong>Mã:</strong> ${detailSp.ma}</p>
                <p><strong>Tên Sản Phẩm:</strong> ${detailSp.tenSanPham}</p>
                <p><strong>Mô Tả:</strong> ${detailSp.moTa}</p>
                <p><strong>Trạng Thái:</strong> ${detailSp.trangThai == 1 ? 'Hoạt động' : 'Ngừng'}</p>
                <a href="${pageContext.request.contextPath}/admin/san-pham" class="btn btn-secondary btn-sm">Đóng chi tiết</a>
            </div>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>