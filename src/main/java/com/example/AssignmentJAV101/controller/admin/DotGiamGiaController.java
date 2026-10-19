package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.DotGiamGia;
import com.example.AssignmentJAV101.service.DotGiamGiaService;
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
import java.util.Date;

@WebServlet(urlPatterns = {
        "/admin/dot-giam-gia",
        "/admin/dot-giam-gia/add",
        "/admin/dot-giam-gia/update",
        "/admin/dot-giam-gia/edit",
        "/admin/dot-giam-gia/delete",
        "/admin/dot-giam-gia/detail"
})
public class DotGiamGiaController extends HttpServlet {
    private final DotGiamGiaService dotGiamGiaService = new DotGiamGiaService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/dot-giam-gia/delete")) {
            this.deleteDotGiamGia(request, response);
        } else if (uri.contains("/admin/dot-giam-gia/edit")) {
            this.editDotGiamGia(request, response);
        } else if (uri.contains("/admin/dot-giam-gia/detail")) {
            this.detailDotGiamGia(request, response);
        } else if (uri.contains("/admin/dot-giam-gia")) {
            this.showDotGiamGia(request, response);
        }
    }

    private void detailDotGiamGia(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        DotGiamGia dgg = dotGiamGiaService.getOne(id);
        if (dgg == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đợt giảm giá");
            return;
        }
        request.setAttribute("detailDgg", dgg);
        request.setAttribute("list", dotGiamGiaService.getAll());
        request.getRequestDispatcher("/dotgiamgia.jsp").forward(request, response);
    }

    private void editDotGiamGia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        DotGiamGia dgg = dotGiamGiaService.getOne(id);
        request.setAttribute("dggEdit", dgg);
        request.setAttribute("list", dotGiamGiaService.getAll());
        request.getRequestDispatcher("/dotgiamgia.jsp").forward(request, response);
    }

    private void showDotGiamGia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("list", dotGiamGiaService.getAll());
        request.getRequestDispatcher("/dotgiamgia.jsp").forward(request, response);
    }

    private void deleteDotGiamGia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        dotGiamGiaService.delete(id);
        response.sendRedirect("/admin/dot-giam-gia");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DateConverter converter = new DateConverter(null);
        converter.setPattern("yyyy-MM-dd");
        ConvertUtils.register(converter, Date.class);

        String uri = req.getRequestURI();
        if (uri.contains("/admin/dot-giam-gia/add")) {
            this.addDotGiamGia(req, resp);
        } else if (uri.contains("/admin/dot-giam-gia/update")) {
            this.updateDotGiamGia(req, resp);
        }
    }

    private void updateDotGiamGia(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        DotGiamGia dgg = new DotGiamGia();
        BeanUtils.populate(dgg, req.getParameterMap());
        dotGiamGiaService.update(dgg);
        resp.sendRedirect("/admin/dot-giam-gia");
    }

    private void addDotGiamGia(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        DotGiamGia dgg = new DotGiamGia();
        BeanUtils.populate(dgg, req.getParameterMap());
        dotGiamGiaService.add(dgg);
        resp.sendRedirect("/admin/dot-giam-gia");
    }
}