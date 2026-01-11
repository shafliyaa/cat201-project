package com.example.hijabluxe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// This maps the URL "/cart-action" to this file
@WebServlet(name = "CartServlet", value = "/cart-action")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        // --- ADD TO CART LOGIC ---
        if ("add".equals(action)) {
            String pId = request.getParameter("id");
            String pName = request.getParameter("name");
            String pPrice = request.getParameter("price");

            if (pId != null && pName != null && pPrice != null) {
                // 1. Get or Create Cart
                HttpSession session = request.getSession();
                Cart myCart = (Cart) session.getAttribute("cart");
                if (myCart == null) {
                    myCart = new Cart();
                    session.setAttribute("cart", myCart);
                }

                // 2. Add Item
                try {
                    double priceVal = Double.parseDouble(pPrice);
                    int idVal = Integer.parseInt(pId);
                    
                    // Create Product and Add
                    Product p = new Product(idVal, pName, priceVal);
                    myCart.addItem(p);
                    
                } catch (NumberFormatException e) {
                    System.out.println("Error parsing price or ID: " + e.getMessage());
                }
            }
        }

        // --- REMOVE FROM CART LOGIC ---
        if ("remove".equals(action)) {
            String idToRemove = request.getParameter("id");
            HttpSession session = request.getSession();
            Cart myCart = (Cart) session.getAttribute("cart");

            if (myCart != null && idToRemove != null) {
                int id = Integer.parseInt(idToRemove);
                // Remove the item safely
                myCart.getItems().removeIf(p -> p.getId() == id);
            }
        }

// --- FINAL STEP: REDIRECT BASED ON ACTION ---
    if ("add".equals(action)) {
        // If we just added an item, go back to main page and show a success signal
        response.sendRedirect("main.jsp?status=added");
    } else {
        // If we removed an item (or anything else), show the cart
        response.sendRedirect("main.jsp?view=cart");
    }

    }
}