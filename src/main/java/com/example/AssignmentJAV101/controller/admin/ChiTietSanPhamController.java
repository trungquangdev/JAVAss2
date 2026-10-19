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

@WebServlet(urlPatterns = {
        "/admin/chi-tiet-san-pham",
        "/admin/chi-tiet-san-pham/add",
        "/admin/chi-tiet-san-pham/update",
        "/admin/chi-tiet-san-pham/edit",
        "/admin/chi-tiet-san-pham/delete",
        "/admin/chi-tiet-san-pham/detail"
})
public class ChiTietSanPhamController extends HttpServlet {
    private final ChiTietSanPhamService ctspService = new ChiTietSanPhamService();
    private final SanPhamService sanPhamService = new SanPhamService();
    private final MauSacService mauSacService = new MauSacService();
    private final KichCoService kichCoService = new KichCoService();

    private void loadComboboxData(HttpServletRequest request) {
        request.setAttribute("listSP", sanPhamService.getAll());
        request.setAttribute("listMS", mauSacService.getAll());
        request.setAttribute("listKC", kichCoService.getAll());
    }

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

    private void detailChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        ChiTietSanPham ctsp = ctspService.getOne(id);
        if (ctsp == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy chi tiết sản phẩm");
            return;
        }
        request.setAttribute("detailCtsp", ctsp);
        request.setAttribute("list", ctspService.getAll());
        loadComboboxData(request);
        request.getRequestDispatcher("/chitietsanpham.jsp").forward(request, response);
    }

    private void editChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        ChiTietSanPham ctsp = ctspService.getOne(id);
        request.setAttribute("ctspEdit", ctsp);
        request.setAttribute("list", ctspService.getAll());
        loadComboboxData(request);
        request.getRequestDispatcher("/chitietsanpham.jsp").forward(request, response);
    }

//    private void showChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setAttribute("list", ctspService.getAll());
//        loadComboboxData(request);
//        request.getRequestDispatcher("/chitietsanpham.jsp").forward(request, response);
//    }

    private void showChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idSPStr = request.getParameter("idSanPham");
        String idMSStr = request.getParameter("idMauSac");
        String idKCStr = request.getParameter("idKichCo");
        String trangThaiStr = request.getParameter("trangThai");

        Integer idSP = (idSPStr != null && !idSPStr.isEmpty()) ? Integer.valueOf(idSPStr) : null;
        Integer idMS = (idMSStr != null && !idMSStr.isEmpty()) ? Integer.valueOf(idMSStr) : null;
        Integer idKC = (idKCStr != null && !idKCStr.isEmpty()) ? Integer.valueOf(idKCStr) : null;
        Integer trangThai = (trangThaiStr != null && !trangThaiStr.isEmpty()) ? Integer.valueOf(trangThaiStr) : null;

        request.setAttribute("list", ctspService.search(idSP, idMS, idKC, trangThai));
        loadComboboxData(request);
        request.getRequestDispatcher("/chitietsanpham.jsp").forward(request, response);
    }

    private void deleteChiTietSanPham(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        ctspService.delete(id);
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
        ctsp.setSanPham(sanPhamService.getOne(Integer.valueOf(req.getParameter("idSanPham"))));
        ctsp.setMauSac(mauSacService.getOne(Integer.valueOf(req.getParameter("idMauSac"))));
        ctsp.setKichCo(kichCoService.getOne(Integer.valueOf(req.getParameter("idKichCo"))));
        ctspService.update(ctsp);
        resp.sendRedirect("/admin/chi-tiet-san-pham");
    }

    private void addChiTietSanPham(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        ChiTietSanPham ctsp = new ChiTietSanPham();
        BeanUtils.populate(ctsp, req.getParameterMap());
        ctsp.setSanPham(sanPhamService.getOne(Integer.valueOf(req.getParameter("idSanPham"))));
        ctsp.setMauSac(mauSacService.getOne(Integer.valueOf(req.getParameter("idMauSac"))));
        ctsp.setKichCo(kichCoService.getOne(Integer.valueOf(req.getParameter("idKichCo"))));
        ctspService.add(ctsp);
        resp.sendRedirect("/admin/chi-tiet-san-pham");
    }
}