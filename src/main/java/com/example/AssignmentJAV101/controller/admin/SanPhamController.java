package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.SanPham;
import com.example.AssignmentJAV101.service.SanPhamService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import lombok.var;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

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

    private void detailSanPham(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        SanPham sp = sanPhamService.getOne(id);
        if (sp == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm");
            return;
        }
        request.setAttribute("detailSp", sp);
        request.setAttribute("list", sanPhamService.getAll());
        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);
    }

    private void editSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        SanPham sp = sanPhamService.getOne(id);
        request.setAttribute("spEdit", sp);
        request.setAttribute("list", sanPhamService.getAll());
        request.getRequestDispatcher("/sanpham.jsp").forward(request, response);
    }

    private void showSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String trangThaiStr = request.getParameter("trangThai");

        Integer trangThai = null;
        if (trangThaiStr != null && !trangThaiStr.isEmpty()) {
            trangThai = Integer.valueOf(trangThaiStr);
        }

        // Gọi hàm search thay vì getAll thông thường
        var list = sanPhamService.search(keyword, trangThai);
        request.setAttribute("list", list);
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