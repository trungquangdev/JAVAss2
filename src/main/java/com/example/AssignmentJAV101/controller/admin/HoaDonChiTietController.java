package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.HoaDonChiTiet;
import com.example.AssignmentJAV101.service.ChiTietSanPhamService;
import com.example.AssignmentJAV101.service.HoaDonChiTietService;
import com.example.AssignmentJAV101.service.HoaDonService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

@WebServlet(urlPatterns = {
        "/admin/hoa-don-chi-tiet",
        "/admin/hoa-don-chi-tiet/add",
        "/admin/hoa-don-chi-tiet/update",
        "/admin/hoa-don-chi-tiet/edit",
        "/admin/hoa-don-chi-tiet/delete",
        "/admin/hoa-don-chi-tiet/detail"
})
public class HoaDonChiTietController extends HttpServlet {
    private final HoaDonChiTietService hoaDonChiTietService = new HoaDonChiTietService();
    private final HoaDonService hoaDonService = new HoaDonService();
    private final ChiTietSanPhamService chiTietSanPhamService = new ChiTietSanPhamService();

    private void loadComboboxData(HttpServletRequest request) {
        request.setAttribute("listHD", hoaDonService.getAll());
        request.setAttribute("listCTSP", chiTietSanPhamService.getAll());
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/hoa-don-chi-tiet/delete")) {
            this.deleteHdct(request, response);
        } else if (uri.contains("/admin/hoa-don-chi-tiet/edit")) {
            this.editHdct(request, response);
        } else if (uri.contains("/admin/hoa-don-chi-tiet/detail")) {
            this.detailHdct(request, response);
        } else if (uri.contains("/admin/hoa-don-chi-tiet")) {
            this.showHdct(request, response);
        }
    }

    private void detailHdct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDonChiTiet hdct = hoaDonChiTietService.getOne(id);
        if (hdct == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hóa đơn chi tiết");
            return;
        }
        request.setAttribute("detailHdct", hdct);
        request.setAttribute("list", hoaDonChiTietService.getAll());
        loadComboboxData(request);
        request.getRequestDispatcher("/hoadonchitiet.jsp").forward(request, response);
    }

    private void editHdct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDonChiTiet hdct = hoaDonChiTietService.getOne(id);
        request.setAttribute("hdctEdit", hdct);
        request.setAttribute("list", hoaDonChiTietService.getAll());
        loadComboboxData(request);
        request.getRequestDispatcher("/hoadonchitiet.jsp").forward(request, response);
    }

    private void showHdct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("list", hoaDonChiTietService.getAll());
        loadComboboxData(request);
        request.getRequestDispatcher("/hoadonchitiet.jsp").forward(request, response);
    }

    private void deleteHdct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        hoaDonChiTietService.delete(id);
        response.sendRedirect("/admin/hoa-don-chi-tiet");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/hoa-don-chi-tiet/add")) {
            this.addHdct(req, resp);
        } else if (uri.contains("/admin/hoa-don-chi-tiet/update")) {
            this.updateHdct(req, resp);
        }
    }

    private void updateHdct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        HoaDonChiTiet hdct = new HoaDonChiTiet();
        BeanUtils.populate(hdct, req.getParameterMap());
        hdct.setHoaDon(hoaDonService.getOne(Integer.valueOf(req.getParameter("idHoaDon"))));
        hdct.setChiTietSanPham(chiTietSanPhamService.getOne(Integer.valueOf(req.getParameter("idChiTietSanPham"))));
        hoaDonChiTietService.update(hdct);
        resp.sendRedirect("/admin/hoa-don-chi-tiet");
    }

    private void addHdct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        HoaDonChiTiet hdct = new HoaDonChiTiet();
        BeanUtils.populate(hdct, req.getParameterMap());
        hdct.setHoaDon(hoaDonService.getOne(Integer.valueOf(req.getParameter("idHoaDon"))));
        hdct.setChiTietSanPham(chiTietSanPhamService.getOne(Integer.valueOf(req.getParameter("idChiTietSanPham"))));
        hoaDonChiTietService.add(hdct);
        resp.sendRedirect("/admin/hoa-don-chi-tiet");
    }
}