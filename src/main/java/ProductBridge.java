import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

            @WebServlet("/products")
            public class ProductBridge extends HttpServlet {

                private static final List<Product> products = new ArrayList<>();

                private void setCors(HttpServletResponse response) {
                    response.setHeader("Access-Control-Allow-Origin", "*");
                    response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
                    response.setHeader("Access-Control-Allow-Headers", "Content-Type");
                }

                @Override
                protected void doOptions(HttpServletRequest request, HttpServletResponse response) {
                    setCors(response);
                }

                @Override
                protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
                    setCors(response);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    PrintWriter out = response.getWriter();
                    out.print("[");
                    for (int i = 0; i < products.size(); i++) {
                        out.print(products.get(i).toJson());
                        if (i < products.size() - 1) out.print(",");
                    }
                    out.print("]");
                    out.flush();
                }

                @Override
                protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
                    setCors(response);

                    String name = request.getParameter("name");
                    String category = request.getParameter("category");
                    String priceStr = request.getParameter("price");
                    String stockStr = request.getParameter("stock");
                    String image = request.getParameter("image");

                    if (name == null || category == null || priceStr == null || stockStr == null) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing fields");
                        return;
                    }

                    double price = Double.parseDouble(priceStr);
                    int stock = Integer.parseInt(stockStr);

                    Product p = new Product(name, category, price, stock, image == null ? "" : image);
                    products.add(p);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.setStatus(HttpServletResponse.SC_CREATED);

                    PrintWriter out = response.getWriter();
                    out.print(p.toJson());
                    out.flush();
                }
            }
