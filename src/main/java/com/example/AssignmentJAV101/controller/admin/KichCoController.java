package com.example.AssignmentJAV101.controller.admin;

import com.example.AssignmentJAV101.model.KichCo;
import com.example.AssignmentJAV101.service.KichCoService;
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
        "/admin/kich-co",
        "/admin/kich-co/add",
        "/admin/kich-co/update",
        "/admin/kich-co/edit",
        "/admin/kich-co/delete",
        "/admin/kich-co/detail"
})
public class KichCoController extends HttpServlet {
    private final KichCoService kichCoService = new KichCoService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String uri = request.getRequestURI();
        if (uri.contains("/admin/kich-co/delete")) {
            this.deleteKichCo(request, response);
        } else if (uri.contains("/admin/kich-co/edit")) {
            this.editKichCo(request, response);
        } else if (uri.contains("/admin/kich-co/detail")) {
            this.detailKichCo(request, response);
        } else if (uri.contains("/admin/kich-co")) {
            this.showKichCo(request, response);
        }
    }

    private void detailKichCo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        KichCo kc = kichCoService.getOne(id);
        if (kc == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy kích cỡ");
            return;
        }
        request.setAttribute("detailKc", kc);
        request.setAttribute("list", kichCoService.getAll());
        request.getRequestDispatcher("/kichco.jsp").forward(request, response);
    }

    private void editKichCo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        KichCo kc = kichCoService.getOne(id);
        request.setAttribute("kcEdit", kc);
        request.setAttribute("list", kichCoService.getAll());
        request.getRequestDispatcher("/kichco.jsp").forward(request, response);
    }

    private void showKichCo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("list", kichCoService.getAll());
        request.getRequestDispatcher("/kichco.jsp").forward(request, response);
    }

    private void deleteKichCo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        kichCoService.delete(id);
        response.sendRedirect("/admin/kich-co");
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/kich-co/add")) {
            this.addKichCo(req, resp);
        } else if (uri.contains("/admin/kich-co/update")) {
            this.updateKichCo(req, resp);
        }
    }

    private void updateKichCo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        KichCo kc = new KichCo();
        BeanUtils.populate(kc, req.getParameterMap());
        kichCoService.update(kc);
        resp.sendRedirect("/admin/kich-co");
    }

    private void addKichCo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, InvocationTargetException, IllegalAccessException {
        KichCo kc = new KichCo();
        BeanUtils.populate(kc, req.getParameterMap());
        kichCoService.add(kc);
        resp.sendRedirect("/admin/kich-co");
    }
}