package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.ChiTietSanPham;
import com.example.AssignmentJAV101.service.ChiTietSanPhamService;
import com.example.AssignmentJAV101.service.KichCoService;
import com.example.AssignmentJAV101.service.MauSacService;
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
        "/admin/chi-tiet-san-pham",
        "/admin/chi-tiet-san-pham/add",
        "/admin/chi-tiet-san-pham/update",
        "/admin/chi-tiet-san-pham/edit",
        "/admin/chi-tiet-san-pham/delete",
        "/admin/chi-tiet-san-pham/detail"
})
public class ChiTietSanPhamController extends HttpServlet {
    private final ChiTietSanPhamService chiTietSanPhamService = new ChiTietSanPhamService();
    private final SanPhamService sanPhamService = new SanPhamService();
    private final MauSacService mauSacService = new MauSacService();
    private final KichCoService kichCoService = new KichCoService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/chi-tiet-san-pham/delete")) {
            this.deleteChiTietSanPham(request, response);
        } else if (uri.contains("/admin/chi-tiet-san-pham/edit")) {
            this.editChiTietSanPham(request, response);
        } else if (uri.contains("/admin/chi-tiet-san-pham/detail")) {
            this.detailChiTietSanPham(request, response);
        } else if (uri.contains("/admin/chi-tiet-san-pham")) {
            this.showChiTietSanPham(request, response);
        }
    }

    private void loadComboboxData(HttpServletRequest request) {
        request.setAttribute("listSP", sanPhamService.getAll());
        request.setAttribute("listMS", mauSacService.getAll());
        request.setAttribute("listKC", kichCoService.getAll());
    }

    private void loadPaginationData(HttpServletRequest request) {
        String idSPStr = request.getParameter("idSanPham");
        String idMSStr = request.getParameter("idMauSac");
        String idKCStr = request.getParameter("idKichCo");
        String trangThaiStr = request.getParameter("trangThai");

        Integer idSP = (idSPStr != null && !idSPStr.isEmpty()) ? Integer.valueOf(idSPStr) : null;
        Integer idMS = (idMSStr != null && !idMSStr.isEmpty()) ? Integer.valueOf(idMSStr) : null;
        Integer idKC = (idKCStr != null && !idKCStr.isEmpty()) ? Integer.valueOf(idKCStr) : null;
        Integer trangThai = (trangThaiStr != null && !trangThaiStr.isEmpty()) ? Integer.valueOf(trangThaiStr) : null;

        int page = 1;
        int pageSize = 5;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }

        List<ChiTietSanPham> list = chiTietSanPhamService.getPage(page, pageSize, idSP, idMS, idKC, trangThai);
        long totalItems = chiTietSanPhamService.count(idSP, idMS, idKC, trangThai);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        loadComboboxData(request);
    }

    private void showChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadPaginationData(request);
        request.getRequestDispatcher("/chitietsanpham.jsp").forward(request, response);
    }

    private void detailChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        ChiTietSanPham detailCtsp = chiTietSanPhamService.getOne(id);
        request.setAttribute("detailCtsp", detailCtsp);
        loadPaginationData(request);
        request.getRequestDispatcher("/chitietsanpham.jsp").forward(request, response);
    }

    private void editChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        ChiTietSanPham ctspEdit = chiTietSanPhamService.getOne(id);
        request.setAttribute("ctspEdit", ctspEdit);
        loadPaginationData(request);
        request.getRequestDispatcher("/chitietsanpham.jsp").forward(request, response);
    }

    private void deleteChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        chiTietSanPhamService.delete(id);
        response.sendRedirect("/admin/chi-tiet-san-pham");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/chi-tiet-san-pham/add")) {
            this.addChiTietSanPham(req, resp);
        } else if (uri.contains("/admin/chi-tiet-san-pham/update")) {
            this.updateChiTietSanPham(req, resp);
        }
    }

    private void updateChiTietSanPham(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        ChiTietSanPham ctsp = new ChiTietSanPham();
        BeanUtils.populate(ctsp, req.getParameterMap());
        chiTietSanPhamService.update(ctsp);
        resp.sendRedirect("/admin/chi-tiet-san-pham");
    }

    private void addChiTietSanPham(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        ChiTietSanPham ctsp = new ChiTietSanPham();
        BeanUtils.populate(ctsp, req.getParameterMap());
        chiTietSanPhamService.add(ctsp);
        resp.sendRedirect("/admin/chi-tiet-san-pham");
    }
}