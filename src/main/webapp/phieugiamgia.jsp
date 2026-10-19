<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý phiếu giảm giá</title>
</head>
<body>

<h2>Quản lý phiếu giảm giá</h2>


<form action="${pageContext.request.contextPath}/admin/phieu-giam-gia" method="get" class="row g-3 mb-3">
    <div class="col-md-5">
        <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm theo mã, tên phiếu...">
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
        <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia" class="btn btn-secondary">Làm mới</a>
    </div>
</form>

<%-- Form Thêm --%>
<form action="${pageContext.request.contextPath}/admin/phieu-giam-gia/add" method="post">
    <input type="text" name="ma" placeholder="Mã phiếu" required>
    <input type="text" name="tenPhieu" placeholder="Tên phiếu" required>
    <input type="number" step="0.01" name="giaTriGiam" placeholder="Giá trị giảm" required>
    <input type="number" step="0.01" name="giamToiDa" placeholder="Giảm tối đa" required>
    <input type="number" step="0.01" name="donToiThieu" placeholder="Đơn tối thiểu" required>
    <input type="number" name="soLuong" placeholder="Số lượng" required>
    Ngày kết thúc: <input type="date" name="ngayKetThuc" required>
    <input type="number" name="trangThai" placeholder="Trạng thái" value="1">
    <button type="submit">Thêm</button>
</form>

<%-- Form Sửa (Hiện khi pggEdit không rỗng) --%>
<c:if test="${not empty pggEdit}">
    <h3>Sửa phiếu giảm giá</h3>
    <form action="${pageContext.request.contextPath}/admin/phieu-giam-gia/update" method="post">
        <input type="hidden" name="id" value="${pggEdit.id}">
        <input type="text" name="ma" value="${pggEdit.ma}" required>
        <input type="text" name="tenPhieu" value="${pggEdit.tenPhieu}" required>
        <input type="number" step="0.01" name="giaTriGiam" value="${pggEdit.giaTriGiam}" required>
        <input type="number" step="0.01" name="giamToiDa" value="${pggEdit.giamToiDa}" required>
        <input type="number" step="0.01" name="donToiThieu" value="${pggEdit.donToiThieu}" required>
        <input type="number" name="soLuong" value="${pggEdit.soLuong}" required>
        <fmt:formatDate value="${pggEdit.ngayKetThuc}" pattern="yyyy-MM-dd" var="ngayKT"/>
        Ngày kết thúc: <input type="date" name="ngayKetThuc" value="${ngayKT}" required>
        <input type="number" name="trangThai" value="${pggEdit.trangThai}">
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="6">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã</th>
        <th>Tên phiếu</th>
        <th>Giá trị giảm</th>
        <th>Giảm tối đa</th>
        <th>Đơn tối thiểu</th>
        <th>Số lượng</th>
        <th>Ngày kết thúc</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="pgg">
        <tr>
            <td>${pgg.id}</td>
            <td>${pgg.ma}</td>
            <td>${pgg.tenPhieu}</td>
            <td>${pgg.giaTriGiam}</td>
            <td>${pgg.giamToiDa}</td>
            <td>${pgg.donToiThieu}</td>
            <td>${pgg.soLuong}</td>
            <td><fmt:formatDate value="${pgg.ngayKetThuc}" pattern="yyyy-MM-dd"/></td>
            <td>${pgg.trangThai}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia/detail?id=${pgg.id}" style="text-decoration: none">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia/edit?id=${pgg.id}" style="text-decoration: none">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia/delete?id=${pgg.id}" onclick="return confirm('Bạn có chắc muốn xóa?')" style="text-decoration: none">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty detailPgg}">
    <h3>Chi tiết phiếu giảm giá</h3>
    <p>ID: ${detailPgg.id}</p>
    <p>Mã: ${detailPgg.ma}</p>
    <p>Tên phiếu: ${detailPgg.tenPhieu}</p>
    <p>Giá trị giảm: ${detailPgg.giaTriGiam}</p>
    <p>Giảm tối đa: ${detailPgg.giamToiDa}</p>
    <p>Đơn tối thiểu: ${detailPgg.donToiThieu}</p>
    <p>Số lượng: ${detailPgg.soLuong}</p>
    <p>Ngày kết thúc: <fmt:formatDate value="${detailPgg.ngayKetThuc}" pattern="yyyy-MM-dd"/></p>
    <p>Trạng thái: ${detailPgg.trangThai}</p>
    <a href="${pageContext.request.contextPath}/admin/phieu-giam-gia">Đóng chi tiết</a>
</c:if>
</body>
</html>