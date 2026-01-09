package com.example.hijabluxe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdParam = request.getParameter("productId");
        if (productIdParam == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int productId = Integer.parseInt(productIdParam);

        Product product = ProductService.getInstance().getProductById(productId);
        if (product == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart(currentUser);
            session.setAttribute("cart", cart);
        }

        cart.addItem(product);

        response.sendRedirect("index.jsp");
    }
} // <- Make sure this closing brace is there
