import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


//dalam process belajar tak siap lagi
@WebServlet("/get-products") // This is the 'address' JavaScript will call
public class ProductBridge extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Set content type so the browser knows it's receiving JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 1. Create your Java Objects (OOP)
        // In a real project, these would come from a database
        Product item1 = new Product("P01", "Premium Silk Bawal", 59.90);
        Product item2 = new Product("P02", "Luxury Satin Shawl", 75.00);

        // 2. Build the JSON Output manually (Processing/Output)
        PrintWriter out = response.getWriter();
        String json = "[" + item1.toJson() + "," + item2.toJson() + "]";

        out.print(json);
        out.flush();
    }
}
