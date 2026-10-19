package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.KhachHang;
import com.example.AssignmentJAV101.service.KhachHangService;
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
        "/admin/khach-hang",
        "/admin/khach-hang/add",
        "/admin/khach-hang/update",
        "/admin/khach-hang/edit",
        "/admin/khach-hang/delete",
        "/admin/khach-hang/detail"
})
public class KhachHangController extends HttpServlet {
    private final KhachHangService khachHangService = new KhachHangService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/khach-hang/delete")) {
            this.deleteKhachHang(request, response);
        } else if (uri.contains("/admin/khach-hang/edit")) {
            this.editKhachHang(request, response);
        } else if (uri.contains("/admin/khach-hang/detail")) {
            this.detailKhachHang(request, response);
        } else if (uri.contains("/admin/khach-hang")) {
            this.showKhachHang(request, response);
        }
    }

    private void loadPaginationData(HttpServletRequest request) {
        String keyword = request.getParameter("keyword");
        String trangThaiStr = request.getParameter("trangThai");
        Integer trangThai = (trangThaiStr != null && !trangThaiStr.isEmpty()) ? Integer.valueOf(trangThaiStr) : null;

        int page = 1;
        int pageSize = 5;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }

        List<KhachHang> list = khachHangService.getPage(page, pageSize, keyword, trangThai);
        long totalItems = khachHangService.count(keyword, trangThai);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
    }

    private void showKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadPaginationData(request);
        request.getRequestDispatcher("/khachhang.jsp").forward(request, response);
    }

    private void detailKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        KhachHang detail = khachHangService.getOne(id);
        request.setAttribute("detail", detail);
        loadPaginationData(request);
        request.getRequestDispatcher("/khachhang.jsp").forward(request, response);
    }

    private void editKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        KhachHang editKhachHang = khachHangService.getOne(id);
        request.setAttribute("editKhachHang", editKhachHang);
        loadPaginationData(request);
        request.getRequestDispatcher("/khachhang.jsp").forward(request, response);
    }

    private void deleteKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        khachHangService.delete(id);
        response.sendRedirect("/admin/khach-hang");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/khach-hang/add")) {
            this.addKhachHang(req, resp);
        } else if (uri.contains("/admin/khach-hang/update")) {
            this.updateKhachHang(req, resp);
        }
    }

    private void updateKhachHang(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        KhachHang kh = new KhachHang();
        BeanUtils.populate(kh, req.getParameterMap());
        khachHangService.update(kh);
        resp.sendRedirect("/admin/khach-hang");
    }

    private void addKhachHang(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        KhachHang kh = new KhachHang();
        BeanUtils.populate(kh, req.getParameterMap());
        khachHangService.add(kh);
        resp.sendRedirect("/admin/khach-hang");
    }
}