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
import java.util.List;

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

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/hoa-don-chi-tiet/delete")) {
            this.deleteHoaDonChiTiet(request, response);
        } else if (uri.contains("/admin/hoa-don-chi-tiet/edit")) {
            this.editHoaDonChiTiet(request, response);
        } else if (uri.contains("/admin/hoa-don-chi-tiet/detail")) {
            this.detailHoaDonChiTiet(request, response);
        } else if (uri.contains("/admin/hoa-don-chi-tiet")) {
            this.showHoaDonChiTiet(request, response);
        }
    }

    private void loadComboboxData(HttpServletRequest request) {
        request.setAttribute("listHD", hoaDonService.getAll());
        request.setAttribute("listCTSP", chiTietSanPhamService.getAll());
    }

    private void loadPaginationData(HttpServletRequest request) {
        String idHDStr = request.getParameter("idHoaDon");
        Integer idHoaDon = (idHDStr != null && !idHDStr.isEmpty()) ? Integer.valueOf(idHDStr) : null;

        int page = 1;
        int pageSize = 5;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }

        List<HoaDonChiTiet> list = hoaDonChiTietService.getPage(page, pageSize, idHoaDon);
        long totalItems = hoaDonChiTietService.count(idHoaDon);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        loadComboboxData(request);
    }

    private void showHoaDonChiTiet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadPaginationData(request);
        request.getRequestDispatcher("/hoadonchitiet.jsp").forward(request, response);
    }

    private void detailHoaDonChiTiet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDonChiTiet detailHdct = hoaDonChiTietService.getOne(id);
        request.setAttribute("detailHdct", detailHdct);
        loadPaginationData(request);
        request.getRequestDispatcher("/hoadonchitiet.jsp").forward(request, response);
    }

    private void editHoaDonChiTiet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDonChiTiet hdctEdit = hoaDonChiTietService.getOne(id);
        request.setAttribute("hdctEdit", hdctEdit);
        loadPaginationData(request);
        request.getRequestDispatcher("/hoadonchitiet.jsp").forward(request, response);
    }

    private void deleteHoaDonChiTiet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        hoaDonChiTietService.delete(id);
        response.sendRedirect("/admin/hoa-don-chi-tiet");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/hoa-don-chi-tiet/add")) {
            this.addHoaDonChiTiet(req, resp);
        } else if (uri.contains("/admin/hoa-don-chi-tiet/update")) {
            this.updateHoaDonChiTiet(req, resp);
        }
    }

    private void updateHoaDonChiTiet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        HoaDonChiTiet hdct = new HoaDonChiTiet();
        BeanUtils.populate(hdct, req.getParameterMap());
        hoaDonChiTietService.update(hdct);
        resp.sendRedirect("/admin/hoa-don-chi-tiet");
    }

    private void addHoaDonChiTiet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        HoaDonChiTiet hdct = new HoaDonChiTiet();
        BeanUtils.populate(hdct, req.getParameterMap());
        hoaDonChiTietService.add(hdct);
        resp.sendRedirect("/admin/hoa-don-chi-tiet");
    }
}