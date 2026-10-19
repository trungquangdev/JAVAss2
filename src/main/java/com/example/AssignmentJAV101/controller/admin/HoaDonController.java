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
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.Date;

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

    private void loadComboboxData(HttpServletRequest request) {
        request.setAttribute("listKH", khachHangService.getAll());
        request.setAttribute("listNV", nhanVienService.getAll());
        request.setAttribute("listPGG", phieuGiamGiaService.getAll());
    }

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

    private void detailHoaDon(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDon hd = hoaDonService.getOne(id);
        if (hd == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hóa đơn");
            return;
        }
        request.setAttribute("detailHd", hd);
        request.setAttribute("list", hoaDonService.getAll());
        loadComboboxData(request);
        request.getRequestDispatcher("/hoadon.jsp").forward(request, response);
    }

    private void editHoaDon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        HoaDon hd = hoaDonService.getOne(id);
        request.setAttribute("hdEdit", hd);
        request.setAttribute("list", hoaDonService.getAll());
        loadComboboxData(request);
        request.getRequestDispatcher("/hoadon.jsp").forward(request, response);
    }

    private void showHoaDon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("list", hoaDonService.getAll());
        loadComboboxData(request);
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
        DateConverter converter = new DateConverter(null);
        converter.setPattern("yyyy-MM-dd");
        ConvertUtils.register(converter, Date.class);

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
        hd.setKhachHang(khachHangService.getOne(Integer.valueOf(req.getParameter("idKhachHang"))));
        hd.setNhanVien(nhanVienService.getOne(Integer.valueOf(req.getParameter("idNhanVien"))));
        if (req.getParameter("idPhieuGiamGia") != null && !req.getParameter("idPhieuGiamGia").isEmpty()) {
            hd.setPhieuGiamGia(phieuGiamGiaService.getOne(Integer.valueOf(req.getParameter("idPhieuGiamGia"))));
        }
        hoaDonService.update(hd);
        resp.sendRedirect("/admin/hoa-don");
    }

    private void addHoaDon(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        HoaDon hd = new HoaDon();
        BeanUtils.populate(hd, req.getParameterMap());
        hd.setKhachHang(khachHangService.getOne(Integer.valueOf(req.getParameter("idKhachHang"))));
        hd.setNhanVien(nhanVienService.getOne(Integer.valueOf(req.getParameter("idNhanVien"))));
        if (req.getParameter("idPhieuGiamGia") != null && !req.getParameter("idPhieuGiamGia").isEmpty()) {
            hd.setPhieuGiamGia(phieuGiamGiaService.getOne(Integer.valueOf(req.getParameter("idPhieuGiamGia"))));
        }
        hoaDonService.add(hd);
        resp.sendRedirect("/admin/hoa-don");
    }
}