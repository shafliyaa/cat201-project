package com.example.hijabluxe;

import java.util.ArrayList;
import java.util.List;

public class ProductService {
    // This 'instance' makes sure we only have ONE list for the whole app
    private static ProductService instance;
    private List<Product> productList;

    private ProductService() {
        productList = new ArrayList<>();
        // Add one starting product so the table isn't empty
        productList.add(new Product("Bawal Printed Aura", "Square", 109.00, 45, ""));
        productList.add(new Product("Bawal Printed Pastel", "Square", 130.0, 40, ""));
        productList.add(new Product("Bawal Printed Premium Aura", "Square", 209.0, 10, ""));
        productList.add(new Product("Bawal Plain Premium Aura", "Square", 140.0, 27, ""));
        productList.add(new Product("Bawal Printed Premium Lite", "Square", 150.0, 37, ""));
        productList.add(new Product("Shawl Plain Premium Red", "Shawl", 80.0, 2, ""));
        productList.add(new Product("Shawl Plain Premium Gray", "Shawl", 80.0, 15, ""));
        productList.add(new Product("Shawl Printed Premium Aura", "Shawl", 203.0, 5, ""));
        productList.add(new Product("Shawl Printed Premium Meddin", "Shawl", 200.0, 10, ""));
        productList.add(new Product("Shawl Printed Premium K", "Shawl", 209.0, 18, ""));
        productList.add(new Product("Inner Cap Black", "Inner Cap", 15.0, 20, ""));
        productList.add(new Product("Inner Cap Peach", "Inner Cap", 35.0, 10, ""));
        productList.add(new Product("Inner Ninja Premium", "Inner Cap", 29.0, 27, ""));
        productList.add(new Product("Inner Necktie", "Inner Cap", 20.0, 16, ""));
    }

    public static ProductService getInstance() {
        if (instance == null) {
            instance = new ProductService();
        }
        return instance;
    }

    public List<Product> getAllProducts() {
        return productList;
    }

    public void addProduct(Product p) {
        productList.add(p);
    }
}