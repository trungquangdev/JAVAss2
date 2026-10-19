package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.SanPham;
import com.example.AssignmentJAV101.service.SanPhamService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

@WebServlet(urlPatterns = {
        "/admin/san-pham",
        "/admin/san-pham/add",
        "/admin/san-pham/update",
        "/admin/san-pham/edit",
        "/admin/san-pham/delete",
        "/admin/san-pham/detail"
})
public class SanPhamController extends HttpServlet {
    private final SanPhamService sanPhamService = new SanPhamService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/san-pham/delete")) {
            this.deleteSanPham(request, response);
        } else if (uri.contains("/admin/san-pham/edit")) {
            this.editSanPham(request, response);
        } else if (uri.contains("/admin/san-pham/detail")) {
            this.detailSanPham(request, response);
        } else if (uri.contains("/admin/san-pham")) {
            this.showSanPham(request, response);
        }
    }

    // Hàm dùng chung để load phân trang, tìm kiếm, lọc (tránh lặp code và mất phân trang)
    private void loadPaginationData(HttpServletRequest request) {
        String keyword = request.getParameter("keyword");
        String trangThaiStr = request.getParameter("trangThai");
        Integer trangThai = (trangThaiStr != null && !trangThaiStr.isEmpty()) ? Integer.valueOf(trangThaiStr) : null;

        int page = 1;
        int pageSize = 5; // Số bản ghi trên 1 trang
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }

        List<SanPham> list = sanPhamService.getPage(page, pageSize, keyword, trangThai);
        long totalItems = sanPhamService.count(keyword, trangThai);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
    }

    private void showSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadPaginationData(request);
        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);
    }

    private void detailSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        SanPham detail = sanPhamService.getOne(id);
        if (detail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm");
            return;
        }

        // Đẩy biến detail ra để JSP bật Popup Modal
        request.setAttribute("detail", detail);

        // Giữ lại phân trang và danh sách hiện tại
        loadPaginationData(request);

        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);
    }

    private void editSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        SanPham sp = sanPhamService.getOne(id);
        request.setAttribute("spEdit", sp);

        // Giữ lại phân trang và danh sách hiện tại khi ấn Sửa
        loadPaginationData(request);

        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);
    }

    private void deleteSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        sanPhamService.delete(id);
        response.sendRedirect("/admin/san-pham");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/san-pham/add")) {
            this.addSanPham(req, resp);
        } else if (uri.contains("/admin/san-pham/update")) {
            this.updateSanPham(req, resp);
        }
    }

    private void updateSanPham(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        SanPham sp = new SanPham();
        BeanUtils.populate(sp, req.getParameterMap());
        sanPhamService.update(sp);
        resp.sendRedirect("/admin/san-pham");
    }

    private void addSanPham(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        SanPham sp = new SanPham();
        BeanUtils.populate(sp, req.getParameterMap());
        sanPhamService.add(sp);
        resp.sendRedirect("/admin/san-pham");
    }
}