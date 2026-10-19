package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.HoaDon;
import com.example.AssignmentJAV101.service.HoaDonService;
import com.example.AssignmentJAV101.service.KhachHangService;
import com.example.AssignmentJAV101.service.NhanVienService;
import com.example.AssignmentJAV101.service.PhieuGiamGiaService;
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
        "/admin/hoa-don",
        "/admin/hoa-don/add",
        "/admin/hoa-don/update",
        "/admin/hoa-don/edit",
        "/admin/hoa-don/delete",
        "/admin/hoa-don/detail"
})
public class HoaDonController extends HttpServlet {
    private final HoaDonService hoaDonService = new HoaDonService();
    private final KhachHangService khachHangService = new KhachHangService();
    private final NhanVienService nhanVienService = new NhanVienService();
    private final PhieuGiamGiaService phieuGiamGiaService = new PhieuGiamGiaService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/hoa-don/delete")) {
            this.deleteHoaDon(request, response);
        } else if (uri.contains("/admin/hoa-don/edit")) {
            this.editHoaDon(request, response);
        } else if (uri.contains("/admin/hoa-don/detail")) {
            this.detailHoaDon(request, response);
        } else if (uri.contains("/admin/hoa-don")) {
            this.showHoaDon(request, response);
        }
    }

    private void loadComboboxData(HttpServletRequest request) {
        request.setAttribute("listKH", khachHangService.getAll());
        request.setAttribute("listNV", nhanVienService.getAll());
        request.setAttribute("listPGG", phieuGiamGiaService.getAll());
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

        List<HoaDon> list = hoaDonService.getPage(page, pageSize, keyword, trangThai);
        long totalItems = hoaDonService.count(keyword, trangThai);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        loadComboboxData(request);
    }

    private void showHoaDon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadPaginationData(request);
        request.getRequestDispatcher("/hoadon.jsp").forward(request, response);
    }

    private void detailHoaDon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDon detailHd = hoaDonService.getOne(id);
        request.setAttribute("detailHd", detailHd);
        loadPaginationData(request);
        request.getRequestDispatcher("/hoadon.jsp").forward(request, response);
    }

    private void editHoaDon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDon hdEdit = hoaDonService.getOne(id);
        request.setAttribute("hdEdit", hdEdit);
        loadPaginationData(request);
        request.getRequestDispatcher("/hoadon.jsp").forward(request, response);
    }

    private void deleteHoaDon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        hoaDonService.delete(id);
        response.sendRedirect("/admin/hoa-don");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/hoa-don/add")) {
            this.addHoaDon(req, resp);
        } else if (uri.contains("/admin/hoa-don/update")) {
            this.updateHoaDon(req, resp);
        }
    }

    private void updateHoaDon(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        HoaDon hd = new HoaDon();
        BeanUtils.populate(hd, req.getParameterMap());
        hoaDonService.update(hd);
        resp.sendRedirect("/admin/hoa-don");
    }

    private void addHoaDon(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        HoaDon hd = new HoaDon();
        BeanUtils.populate(hd, req.getParameterMap());
        hoaDonService.add(hd);
        resp.sendRedirect("/admin/hoa-don");
    }
}