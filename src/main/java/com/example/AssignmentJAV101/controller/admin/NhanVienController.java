package com.example.AssignmentJAV101.controller.admin;

import java.io.*;
import java.lang.reflect.InvocationTargetException;

import com.example.AssignmentJAV101.model.NhanVien;
import com.example.AssignmentJAV101.service.NhanVienService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import lombok.SneakyThrows;
import org.apache.commons.beanutils.BeanUtils;

@WebServlet(urlPatterns = {
        "/admin/nhan-vien",
        "/admin/nhan-vien/add",
        "/admin/nhan-vien/update",
        "/admin/nhan-vien/edit",
        "/admin/nhan-vien/delete",
        "/admin/nhan-vien/detail"
}

)
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

    private void detailNhanVien(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Lấy ID từ URL
        Integer id = Integer.valueOf(request.getParameter("id"));
        // Tìm chi tiết sản phẩm theo ID
        NhanVien nv = nhanVienService.getOne(id);
        // Kiểm tra sản phẩm có tồn tại không
        if (nv == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Không tìm thấy chi tiết sản phẩm");
            return;
        }
        // Gửi dữ liệu sang JSP
        request.setAttribute("detailNv", nv);
        request.setAttribute("list", nhanVienService.getAll());
        // Hiển thị trang chi tiếtindex
        request.getRequestDispatcher("/nhanvien.jsp").forward(request, response);
    }


    //edit
    private void editNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        NhanVien nv = nhanVienService.getOne(id);
        request.setAttribute("nvEdit", nv);
        request.setAttribute("list", nhanVienService.getAll());
        request.getRequestDispatcher("/nhanvien.jsp").forward(request, response);
    }

    //show
    private void showNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String trangThaiStr = request.getParameter("trangThai");
        Integer trangThai = (trangThaiStr != null && !trangThaiStr.isEmpty()) ? Integer.valueOf(trangThaiStr) : null;

        request.setAttribute("list", nhanVienService.search(keyword, trangThai));
        request.getRequestDispatcher("/nhanvien.jsp").forward(request, response);
    }

    //remove
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

    //edit
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