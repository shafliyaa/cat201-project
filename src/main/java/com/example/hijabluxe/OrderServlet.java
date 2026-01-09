package com.example.hijabluxe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

//will be updated when user class completed
@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    // Get all orders for the Admin Page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        // Manual JSON conversion (Vanilla style)
        out.print("[");
        var orders = OrderService.getInstance().getAllOrders();
        for (int i = 0; i < orders.size(); i++) {
            Order o = orders.get(i);
            out.print(String.format("{\"id\":%d, \"customer\":\"%s\", \"amount\":%.2f, \"status\":\"%s\", \"date\":\"%s\"}",
                    o.getId(), o.getCustomerName(), o.getAmount(), o.getStatus(), o.getOrderDate()));
            if (i < orders.size() - 1) out.print(",");
        }
        out.print("]");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("checkout".equals(action)) {
            // Logic for when user clicks Checkout
            String name = req.getParameter("customer");
            double total = Double.parseDouble(req.getParameter("amount"));
            OrderService.getInstance().addOrder(new Order(name, total));
            resp.getWriter().print("{\"status\":\"success\"}");

        } else if ("completePayment".equals(action)) {
            // Logic for Admin to mark as Completed
            int id = Integer.parseInt(req.getParameter("orderId"));
            OrderService.getInstance().updateOrderStatus(id, "completed");
            resp.getWriter().print("{\"status\":\"updated\"}");
        }
    }
}