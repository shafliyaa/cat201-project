package com.example.hijabluxe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {

    // 1. Handle GET request (Load the list)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = ProductService.getInstance().getAllProducts();

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Manually build JSON string (Student style)
        out.print("[");
        for (int i = 0; i < products.size(); i++) {
            Product p = products.get(i);
            out.print("{");
            out.print("\"name\":\"" + p.getName() + "\",");
            out.print("\"category\":\"" + p.getCategory() + "\",");
            out.print("\"price\":" + p.getPrice() + ",");
            out.print("\"stock\":" + p.getStock());
            out.print("}");
            if (i < products.size() - 1) out.print(",");
        }
        out.print("]");
    }

    // 2. Handle POST request (Save new product)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from the form
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String image = request.getParameter("image");

        // Create and save product
        Product newProduct = new Product(name, category, price, stock, image);
        ProductService.getInstance().addProduct(newProduct);

        // Tell the frontend it worked
        response.setContentType("application/json");
        response.getWriter().print("{\"status\":\"success\"}");
    }
}