<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<form action="/admin/nhan-vien/add" method="post">

    <h2 class="mb-4 text-primary fw-bold"><i class="fas fa-box-open me-2"></i>Quản Lý Nhân Viên</h2>


        <div class="col-md-5">
            <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Tìm kiếm mã, tên, email, sđt, chức vụ...">
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
            <a href="${pageContext.request.contextPath}/admin/nhan-vien" class="btn btn-secondary">Làm mới</a>
        </div>


    <input type="text" name="ma" placeholder="Mã">
    <input type="text" name="ten" placeholder="Tên">
    <input type="email" name="email" placeholder="Email">
    <input type="text" name="sdt" placeholder="SĐT">
    <input type="password" name="matKhau" placeholder="Mật khẩu">
    <input type="text" name="chucVu" placeholder="Chức vụ">
    <input type="number" name="trangThai" placeholder="Trạng thái">

    <button type="submit" onclick="return confirm('Thêm thành công')">Thêm</button>
</form>

<c:if test="${not empty nvEdit}">
    <form action="${pageContext.request.contextPath}/admin/nhan-vien/update" method="post">
        <!-- ID dùng để Hibernate biết cần update bản ghi nào -->
        <input type="hidden" name="id" value="${nvEdit.id}">
        <input type="text" name="ma" value="${nvEdit.ma}" placeholder="Ma">
        <input type="text" name="ten" value="${nvEdit.ten}" placeholder="Ten">
        <input type="email" name="email" value="${nvEdit.email}" placeholder="Email">
        <input type="text" name="sdt" value="${nvEdit.sdt}" placeholder="SDT">
        <input type="password" name="matKhau" value="${nvEdit.matKhau}" placeholder="Mat khau">
        <input type="text" name="chucVu" value="${nvEdit.chucVu}" placeholder="Chuc vu">
        <input type="number" name="trangThai" value="${nvEdit.trangThai}" placeholder="Trang thai">
        <button type="submit">Xác nhận</button>

    </form>
</c:if>

<table border="1" cellpadding="6" cellspacing="6">
    <thead>
    <tr>
        <th>ma</th>
        <th>ten</th>
        <th>email</th>
        <th>sdt</th>
        <th>matKhau</th>
        <th>chucVu</th>
        <th>trangThai</th>
        <th>action</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach items="${list}" var="nv">
        <tr>
            <td>${nv.ma}</td>
            <td>${nv.ten}</td>
            <td>${nv.email}</td>
            <td>${nv.sdt}</td>
            <td>${nv.matKhau}</td>
            <td>${nv.chucVu}</td>
            <td>${nv.trangThai}</td>
            <td>
                <!-- Sửa -->
                <a href="/admin/nhan-vien/edit?id=${nv.id}" style="text-decoration: none">
                    Sửa
                </a>

                <!-- Xóa -->
                <a href="/admin/nhan-vien/delete?id=${nv.id}"
                   onclick="return confirm('Bạn có chắc muốn xóa?')">
                    Xóa
                </a>

                <a href="/admin/nhan-vien/detail?id=${nv.id}">Detail</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<%--// <a href="${pageContext.request.contextPath}/chi-tiet-san-pham/detail?id=${s.idCTSP}"> Detail </a>--%>
<%--//viet trong action--%>
<div style="border: 1px solid black; padding: 10px">
<c:if test="${not empty detailNv}">
    <hr>

    <h3>Chi tiết sản phẩm</h3>

    <p>ma: ${detailNv.ma}</p>
    <p>ten: ${detailNv.ten}</p>
    <p>mail: ${detailNv.email}</p>
    <p>sdt: ${detailNv.sdt}</p>
    <p>mat khau: ${detailNv.matKhau}</p>

    <p>chuc vu: ${detailNv.chucVu}</p>
    <p>trang thai: ${detailNv.trangThai}</p>

    <a href="/admin/nhan-vien">
        Đóng chi tiết
    </a>
</c:if>
</div>
</body>
</html>