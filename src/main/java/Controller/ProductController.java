package Controller;

import model.Product;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {

    private static final List<Product> productList = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ProductController: doGet called");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder json = new StringBuilder("[");
        synchronized (productList) {
            for (int i = 0; i < productList.size(); i++) {
                json.append(productList.get(i).toJson());
                if (i < productList.size() - 1) json.append(",");
            }
        }
        json.append("]");

        response.getWriter().print(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String image = request.getParameter("image");

            System.out.println("Received add product request:");
            System.out.println("Name: " + name);
            System.out.println("Category: " + category);
            System.out.println("Price: " + priceStr);
            System.out.println("Stock: " + stockStr);
            System.out.println("Image: " + image);

            // Validate required parameters
            if (name == null || name.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Product name is required\"}");
                return;
            }

            if (category == null || category.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Category is required\"}");
                return;
            }

            if (priceStr == null || priceStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Price is required\"}");
                return;
            }

            if (stockStr == null || stockStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Stock quantity is required\"}");
                return;
            }

            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            // If image is empty, use a default
            if (image == null || image.trim().isEmpty()) {
                image = "image/product-image.png";
            }

            Product product = new Product(name.trim(), category.trim(), price, stock, image.trim());
            synchronized (productList) {
                productList.add(product);
            }

            System.out.println("Product added successfully. Total products: " + productList.size());
            response.getWriter().print("{\"status\":\"success\",\"message\":\"Product added successfully\"}");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"status\":\"error\",\"message\":\"Invalid number format for price or stock\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
