<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý hóa đơn</title>
</head>
<body>
<h2>Quản lý hóa đơn</h2>

<form action="${pageContext.request.contextPath}/admin/hoa-don/add" method="post">
    <input type="text" name="maHoaDon" placeholder="Mã hóa đơn" required><br>
    Khách hàng:
    <select name="idKhachHang">
        <c:forEach items="${listKH}" var="kh">
            <option value="${kh.id}">${kh.ten}</option>
        </c:forEach>
    </select><br>
    Nhân viên:
    <select name="idNhanVien">
        <c:forEach items="${listNV}" var="nv">
            <option value="${nv.id}">${nv.ten}</option>
        </c:forEach>
    </select><br>
    Phiếu giảm giá:
    <select name="idPhieuGiamGia">
        <option value="">-- Không chọn --</option>
        <c:forEach items="${listPGG}" var="pgg">
            <option value="${pgg.id}">${pgg.tenPhieu}</option>
        </c:forEach>
    </select><br>
    <input type="number" step="0.01" name="tongTien" placeholder="Tổng tiền" required><br>
    Ngày tạo: <input type="date" name="ngayTao" required><br>
    <input type="number" name="trangThai" placeholder="Trạng thái" value="1"><br>
    <button type="submit">Thêm</button>
</form>

<c:if test="${not empty hdEdit}">
    <h3>Sửa hóa đơn</h3>
    <form action="${pageContext.request.contextPath}/admin/hoa-don/update" method="post">
        <input type="hidden" name="id" value="${hdEdit.id}">
        <input type="text" name="maHoaDon" value="${hdEdit.maHoaDon}" required><br>
        Khách hàng:
        <select name="idKhachHang">
            <c:forEach items="${listKH}" var="kh">
                <option value="${kh.id}" ${kh.id == hdEdit.khachHang.id ? 'selected' : ''}>${kh.ten}</option>
            </c:forEach>
        </select><br>
        Nhân viên:
        <select name="idNhanVien">
            <c:forEach items="${listNV}" var="nv">
                <option value="${nv.id}" ${nv.id == hdEdit.nhanVien.id ? 'selected' : ''}>${nv.ten}</option>
            </c:forEach>
        </select><br>
        Phiếu giảm giá:
        <select name="idPhieuGiamGia">
            <option value="">-- Không chọn --</option>
            <c:forEach items="${listPGG}" var="pgg">
                <option value="${pgg.id}" ${hdEdit.phieuGiamGia != null && pgg.id == hdEdit.phieuGiamGia.id ? 'selected' : ''}>${pgg.tenPhieu}</option>
            </c:forEach>
        </select><br>
        <input type="number" step="0.01" name="tongTien" value="${hdEdit.tongTien}" required><br>
        <fmt:formatDate value="${hdEdit.ngayTao}" pattern="yyyy-MM-dd" var="ngayT"/>
        Ngày tạo: <input type="date" name="ngayTao" value="${ngayT}" required><br>
        <input type="number" name="trangThai" value="${hdEdit.trangThai}"><br>
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/hoa-don">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã HĐ</th>
        <th>Khách hàng</th>
        <th>Nhân viên</th>
        <th>Tổng tiền</th>
        <th>Ngày tạo</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="hd">
        <tr>
            <td>${hd.id}</td>
            <td>${hd.maHoaDon}</td>
            <td>${hd.khachHang.ten}</td>
            <td>${hd.nhanVien.ten}</td>
            <td>${hd.tongTien}</td>
            <td><fmt:formatDate value="${hd.ngayTao}" pattern="yyyy-MM-dd"/></td>
            <td>${hd.trangThai}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/hoa-don/detail?id=${hd.id}">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/hoa-don/edit?id=${hd.id}">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/hoa-don/delete?id=${hd.id}"
                   onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty detailHd}">
    <h3>Chi tiết hóa đơn</h3>
    <p>ID: ${detailHd.id}</p>
    <p>Mã HĐ: ${detailHd.maHoaDon}</p>
    <p>Khách hàng: ${detailHd.khachHang.ten}</p>
    <p>Nhân viên: ${detailHd.nhanVien.ten}</p>
    <p>Tổng tiền: ${detailHd.tongTien}</p>
    <p>Ngày tạo: <fmt:formatDate value="${detailHd.ngayTao}" pattern="yyyy-MM-dd"/></p>
    <p>Trạng thái: ${detailHd.trangThai}</p>
    <a href="${pageContext.request.contextPath}/admin/hoa-don">Đóng chi tiết</a>
</c:if>
</body>
</html>