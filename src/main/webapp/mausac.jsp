<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Màu Sắc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="mb-4 text-primary fw-bold">Quản Lý Màu Sắc</h2>

    <div class="card shadow-sm mb-4 p-3">
        <h4>Thêm Màu Sắc</h4>
        <form action="${pageContext.request.contextPath}/admin/mau-sac/add" method="post" class="row g-3">
            <div class="col-md-5"><input type="text" class="form-control" name="ma" placeholder="Mã màu" required></div>
            <div class="col-md-5"><input type="text" class="form-control" name="tenMau" placeholder="Tên màu" required></div>
            <div class="col-md-2"><button type="submit" class="btn btn-success w-100">Thêm</button></div>
        </form>
    </div>

    <c:if test="${not empty msEdit}">
        <div class="card shadow-sm mb-4 p-3 border-warning">
            <h4>Sửa Màu Sắc</h4>
            <form action="${pageContext.request.contextPath}/admin/mau-sac/update" method="post" class="row g-3">
                <input type="hidden" name="id" value="${msEdit.id}">
                <div class="col-md-5"><input type="text" class="form-control" name="ma" value="${msEdit.ma}" required></div>
                <div class="col-md-5"><input type="text" class="form-control" name="tenMau" value="${msEdit.tenMau}" required></div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-warning w-100">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/mau-sac" class="btn btn-secondary w-100 mt-1">Hủy</a>
                </div>
            </form>
        </div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark"><tr><th>ID</th><th>Mã màu</th><th>Tên màu</th><th>Thao tác</th></tr></thead>
        <tbody>
        <c:forEach items="${list}" var="ms">
            <tr>
                <td>${ms.id}</td><td>${ms.ma}</td><td>${ms.tenMau}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/mau-sac/edit?id=${ms.id}" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/mau-sac/delete?id=${ms.id}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa?')">Xóa</a>
                    <a href="${pageContext.request.contextPath}/admin/mau-sac/detail?id=${ms.id}" class="btn btn-sm btn-info text-white">Detail</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty detailMs}">
        <div class="border p-3 mt-3">
            <h3>Chi tiết màu sắc</h3>
            <p>ID: ${detailMs.id}</p><p>Mã: ${detailMs.ma}</p><p>Tên màu: ${detailMs.tenMau}</p>
            <a href="${pageContext.request.contextPath}/admin/mau-sac" class="btn btn-secondary btn-sm">Đóng chi tiết</a>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>