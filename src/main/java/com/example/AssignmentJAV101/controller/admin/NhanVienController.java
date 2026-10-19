package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.NhanVien;
import com.example.AssignmentJAV101.service.NhanVienService;
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
        "/admin/nhan-vien",
        "/admin/nhan-vien/add",
        "/admin/nhan-vien/update",
        "/admin/nhan-vien/edit",
        "/admin/nhan-vien/delete",
        "/admin/nhan-vien/detail"
})
public class NhanVienController extends HttpServlet {
    private final NhanVienService nhanVienService = new NhanVienService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/nhan-vien/delete")) {
            this.deleteNhanVien(request, response);
        } else if (uri.contains("/admin/nhan-vien/edit")) {
            this.editNhanVien(request, response);
        } else if (uri.contains("/admin/nhan-vien/detail")) {
            this.detailNhanVien(request, response);
        } else if (uri.contains("/admin/nhan-vien")) {
            this.showNhanVien(request, response);
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

        List<NhanVien> list = nhanVienService.getPage(page, pageSize, keyword, trangThai);
        long totalItems = nhanVienService.count(keyword, trangThai);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
    }

    private void showNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadPaginationData(request);
        request.getRequestDispatcher("/nhanvien.jsp").forward(request, response);
    }

    private void detailNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        NhanVien detailNv = nhanVienService.getOne(id);
        request.setAttribute("detailNv", detailNv);
        loadPaginationData(request);
        request.getRequestDispatcher("/nhanvien.jsp").forward(request, response);
    }

    private void editNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        NhanVien nvEdit = nhanVienService.getOne(id);
        request.setAttribute("nvEdit", nvEdit);
        loadPaginationData(request);
        request.getRequestDispatcher("/nhanvien.jsp").forward(request, response);
    }

    private void deleteNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        nhanVienService.delete(id);
        response.sendRedirect("/admin/nhan-vien");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/nhan-vien/add")) {
            this.addNhanVien(req, resp);
        } else if (uri.contains("/admin/nhan-vien/update")) {
            this.updateNhanVien(req, resp);
        }
    }

    private void updateNhanVien(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        NhanVien nv = new NhanVien();
        BeanUtils.populate(nv, req.getParameterMap());
        nhanVienService.update(nv);
        resp.sendRedirect("/admin/nhan-vien");
    }

    private void addNhanVien(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        NhanVien nv = new NhanVien();
        BeanUtils.populate(nv, req.getParameterMap());
        nhanVienService.add(nv);
        resp.sendRedirect("/admin/nhan-vien");
    }
}