<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý biến thể sản phẩm</title>
</head>
<body>

<h2>Quản lý biến thể sản phẩm</h2>

<%-- Form Thêm --%>
<form action="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/add" method="post">
    Sản phẩm:
    <select name="idSanPham">
        <c:forEach items="${listSP}" var="sp">
            <option value="${sp.id}">${sp.tenSanPham}</option>
        </c:forEach>
    </select>
    Màu sắc:
    <select name="idMauSac">
        <c:forEach items="${listMS}" var="ms">
            <option value="${ms.id}">${ms.tenMau}</option>
        </c:forEach>
    </select>
    Kích cỡ:
    <select name="idKichCo">
        <c:forEach items="${listKC}" var="kc">
            <option value="${kc.id}">${kc.tenSize}</option>
        </c:forEach>
    </select>
    <input type="number" step="0.01" name="giaBan" placeholder="Giá bán" required>
    <input type="number" name="soLuongTon" placeholder="Số lượng tồn" required>
    <input type="number" name="trangThai" placeholder="Trạng thái" value="1">
    <button type="submit">Thêm</button>
</form>

<%-- Form Sửa (Hiện khi ctspEdit không rỗng) --%>
<c:if test="${not empty ctspEdit}">
    <h3>Sửa biến thể sản phẩm</h3>
    <form action="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/update" method="post">
        <input type="hidden" name="id" value="${ctspEdit.id}">
        Sản phẩm:
        <select name="idSanPham">
            <c:forEach items="${listSP}" var="sp">
                <option value="${sp.id}" ${sp.id == ctspEdit.sanPham.id ? 'selected' : ''}>${sp.tenSanPham}</option>
            </c:forEach>
        </select>
        Màu sắc:
        <select name="idMauSac">
            <c:forEach items="${listMS}" var="ms">
                <option value="${ms.id}" ${ms.id == ctspEdit.mauSac.id ? 'selected' : ''}>${ms.tenMau}</option>
            </c:forEach>
        </select>
        Kích cỡ:
        <select name="idKichCo">
            <c:forEach items="${listKC}" var="kc">
                <option value="${kc.id}" ${kc.id == ctspEdit.kichCo.id ? 'selected' : ''}>${kc.tenSize}</option>
            </c:forEach>
        </select>
        <input type="number" step="0.01" name="giaBan" value="${ctspEdit.giaBan}" required>
        <input type="number" name="soLuongTon" value="${ctspEdit.soLuongTon}" required>
        <input type="number" name="trangThai" value="${ctspEdit.trangThai}">
        <button type="submit">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham">Hủy</a>
    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="6">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên sản phẩm</th>
        <th>Màu sắc</th>
        <th>Kích cỡ</th>
        <th>Giá bán</th>
        <th>Số lượng tồn</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="ctsp">
        <tr>
            <td>${ctsp.id}</td>
            <td>${ctsp.sanPham.tenSanPham}</td>
            <td>${ctsp.mauSac.tenMau}</td>
            <td>${ctsp.kichCo.tenSize}</td>
            <td>${ctsp.giaBan}</td>
            <td>${ctsp.soLuongTon}</td>
            <td>${ctsp.trangThai}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/detail?id=${ctsp.id}" style="text-decoration: none">Detail</a>
                <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/edit?id=${ctsp.id}" style="text-decoration: none">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham/delete?id=${ctsp.id}" onclick="return confirm('Bạn có chắc muốn xóa?')" style="text-decoration: none">Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:if test="${not empty detailCtsp}">
    <h3>Chi tiết biến thể sản phẩm</h3>
    <p>ID: ${detailCtsp.id}</p>
    <p>Sản phẩm: ${detailCtsp.sanPham.tenSanPham}</p>
    <p>Màu sắc: ${detailCtsp.mauSac.tenMau}</p>
    <p>Kích cỡ: ${detailCtsp.kichCo.tenSize}</p>
    <p>Giá bán: ${detailCtsp.giaBan}</p>
    <p>Số lượng tồn: ${detailCtsp.soLuongTon}</p>
    <p>Trạng thái: ${detailCtsp.trangThai}</p>
    <a href="${pageContext.request.contextPath}/admin/chi-tiet-san-pham">Đóng chi tiết</a>
</c:if>
</body>
</html>