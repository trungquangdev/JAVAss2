package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.KhachHang;
import com.example.AssignmentJAV101.service.KhachHangService;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

@WebServlet(urlPatterns = {"/admin/khach-hang",
        "/admin/khach-hang/add",
        "/admin/khach-hang/edit",
        "/admin/khach-hang/update",
        "/admin/khach-hang/delete",
        "/admin/khach-hang/detail"
})
public class KhachHangController extends HttpServlet {
    private final KhachHangService khachHangService=new KhachHangService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/khach-hang/delete")) {
            this.deleteKhachHang(req, resp);
        } else if (uri.contains("/admin/khach-hang/edit")) {
            this.editKhachHang(req, resp);
        }else if(uri.contains("/admin/khach-hang/detail")){
            this.detailKhachHang(req,resp);
        } else if (uri.contains("/admin/khach-hang")) {
            this.showKhachHang(req, resp);
        }
    }

    private void detailKhachHang(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        // Lấy ID từ URL
        Integer id = Integer.valueOf(req.getParameter("id"));
        // Tìm theo ID
        KhachHang kh = khachHangService.getOne(id);
        // Kiểm tra có tồn tại không
        if (kh == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Không tìm thấy ");
            return;
        }
        // Gửi dữ liệu sang JSP
        req.setAttribute("detail", kh);
        req.setAttribute("list", khachHangService.getAll());
        // Hiển thị trang chi tiếtindex
        req.getRequestDispatcher("/khachhang.jsp").forward(req, resp);
    }

    private void editKhachHang(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id=Integer.valueOf(req.getParameter("id"));
        KhachHang khachHang=khachHangService.getOne(id);
        req.setAttribute("editKhachHang",khachHang);
        req.setAttribute("list",khachHangService.getAll());
        req.getRequestDispatcher("/khachhang.jsp").forward(req,resp);
    }

    private void showKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String trangThaiStr = request.getParameter("trangThai");
        Integer trangThai = (trangThaiStr != null && !trangThaiStr.isEmpty()) ? Integer.valueOf(trangThaiStr) : null;

        request.setAttribute("list", khachHangService.search(keyword, trangThai));
        request.getRequestDispatcher("/khachhang.jsp").forward(request, response);
    }

    private void deleteKhachHang(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer id = Integer.valueOf(req.getParameter("id"));
        khachHangService.delete(id);
        resp.sendRedirect("/admin/khach-hang");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("/admin/khach-hang/add")){
            this.addKhachHang(req,resp);
        }else if(uri.contains("/admin/khach-hang/update")){
            this.updateKhachHang(req,resp);
        }
    }

    private void updateKhachHang(HttpServletRequest req, HttpServletResponse resp) throws InvocationTargetException, IllegalAccessException, IOException {
        KhachHang khachHang = new KhachHang();
        BeanUtils.populate(khachHang,req.getParameterMap());
        khachHangService.update(khachHang);
        resp.sendRedirect("/admin/khach-hang");
    }

    private void addKhachHang(HttpServletRequest req, HttpServletResponse resp) throws InvocationTargetException, IllegalAccessException, IOException {
        KhachHang khachHang=new KhachHang();
        BeanUtils.populate(khachHang,req.getParameterMap());
        khachHangService.add(khachHang);
        resp.sendRedirect("/admin/khach-hang");
    }
}