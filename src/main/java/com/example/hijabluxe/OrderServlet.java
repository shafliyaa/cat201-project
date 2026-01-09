package com.example.hijabluxe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        var orders = OrderService.getInstance().getAllOrders();
        out.print("[");
        for (int i = 0; i < orders.size(); i++) {
            Order o = orders.get(i);
            out.print(String.format("{\"id\":%d, \"customer\":\"%s\", \"amount\":%.2f, \"status\":\"%s\"}",
                    o.getId(), o.getCustomerName(), o.getAmount(), o.getStatus()));
            if (i < orders.size() - 1) out.print(",");
        }
        out.print("]");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("updateStatus".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");
            OrderService.getInstance().updateStatus(id, status);
            resp.getWriter().print("{\"status\":\"success\"}");
        }
    }
}