package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.PhieuGiamGia;
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
        "/admin/phieu-giam-gia",
        "/admin/phieu-giam-gia/add",
        "/admin/phieu-giam-gia/update",
        "/admin/phieu-giam-gia/edit",
        "/admin/phieu-giam-gia/delete",
        "/admin/phieu-giam-gia/detail"
})
public class PhieuGiamGiaController extends HttpServlet {
    private final PhieuGiamGiaService phieuGiamGiaService = new PhieuGiamGiaService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/phieu-giam-gia/delete")) {
            this.deletePhieuGiamGia(request, response);
        } else if (uri.contains("/admin/phieu-giam-gia/edit")) {
            this.editPhieuGiamGia(request, response);
        } else if (uri.contains("/admin/phieu-giam-gia/detail")) {
            this.detailPhieuGiamGia(request, response);
        } else if (uri.contains("/admin/phieu-giam-gia")) {
            this.showPhieuGiamGia(request, response);
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

        List<PhieuGiamGia> list = phieuGiamGiaService.getPage(page, pageSize, keyword, trangThai);
        long totalItems = phieuGiamGiaService.count(keyword, trangThai);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if (totalPages == 0) totalPages = 1;

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
    }

    private void showPhieuGiamGia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadPaginationData(request);
        request.getRequestDispatcher("/phieugiamgia.jsp").forward(request, response);
    }

    private void detailPhieuGiamGia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        PhieuGiamGia detailPgg = phieuGiamGiaService.getOne(id);
        request.setAttribute("detailPgg", detailPgg);
        loadPaginationData(request);
        request.getRequestDispatcher("/phieugiamgia.jsp").forward(request, response);
    }

    private void editPhieuGiamGia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        PhieuGiamGia pggEdit = phieuGiamGiaService.getOne(id);
        request.setAttribute("pggEdit", pggEdit);
        loadPaginationData(request);
        request.getRequestDispatcher("/phieugiamgia.jsp").forward(request, response);
    }

    private void deletePhieuGiamGia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        phieuGiamGiaService.delete(id);
        response.sendRedirect("/admin/phieu-giam-gia");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/phieu-giam-gia/add")) {
            this.addPhieuGiamGia(req, resp);
        } else if (uri.contains("/admin/phieu-giam-gia/update")) {
            this.updatePhieuGiamGia(req, resp);
        }
    }

    private void updatePhieuGiamGia(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        PhieuGiamGia pgg = new PhieuGiamGia();
        BeanUtils.populate(pgg, req.getParameterMap());
        phieuGiamGiaService.update(pgg);
        resp.sendRedirect("/admin/phieu-giam-gia");
    }

    private void addPhieuGiamGia(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        PhieuGiamGia pgg = new PhieuGiamGia();
        BeanUtils.populate(pgg, req.getParameterMap());
        phieuGiamGiaService.add(pgg);
        resp.sendRedirect("/admin/phieu-giam-gia");
    }
}