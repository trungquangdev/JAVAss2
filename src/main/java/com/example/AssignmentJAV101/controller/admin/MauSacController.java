package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.MauSac;
import com.example.AssignmentJAV101.service.MauSacService;
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
        "/admin/mau-sac",
        "/admin/mau-sac/add",
        "/admin/mau-sac/update",
        "/admin/mau-sac/edit",
        "/admin/mau-sac/delete",
        "/admin/mau-sac/detail"
})
public class MauSacController extends HttpServlet {
    private final MauSacService mauSacService = new MauSacService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/mau-sac/delete")) {
            this.deleteMauSac(request, response);
        } else if (uri.contains("/admin/mau-sac/edit")) {
            this.editMauSac(request, response);
        } else if (uri.contains("/admin/mau-sac/detail")) {
            this.detailMauSac(request, response);
        } else if (uri.contains("/admin/mau-sac")) {
            this.showMauSac(request, response);
        }
    }

    private void detailMauSac(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        MauSac ms = mauSacService.getOne(id);
        if (ms == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy màu sắc");
            return;
        }
        request.setAttribute("detailMs", ms);
        request.setAttribute("list", mauSacService.getAll());
        request.getRequestDispatcher("/mausac.jsp").forward(request, response);
    }

    private void editMauSac(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        MauSac ms = mauSacService.getOne(id);
        request.setAttribute("msEdit", ms);
        request.setAttribute("list", mauSacService.getAll());
        request.getRequestDispatcher("/mausac.jsp").forward(request, response);
    }

    private void showMauSac(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("list", mauSacService.getAll());
        request.getRequestDispatcher("/mausac.jsp").forward(request, response);
    }

    private void deleteMauSac(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        mauSacService.delete(id);
        response.sendRedirect("/admin/mau-sac");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/mau-sac/add")) {
            this.addMauSac(req, resp);
        } else if (uri.contains("/admin/mau-sac/update")) {
            this.updateMauSac(req, resp);
        }
    }

    private void updateMauSac(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        MauSac ms = new MauSac();
        BeanUtils.populate(ms, req.getParameterMap());
        mauSacService.update(ms);
        resp.sendRedirect("/admin/mau-sac");
    }

    private void addMauSac(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        MauSac ms = new MauSac();
        BeanUtils.populate(ms, req.getParameterMap());
        mauSacService.add(ms);
        resp.sendRedirect("/admin/mau-sac");
    }
}