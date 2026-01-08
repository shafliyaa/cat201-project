package com.example.hijabluxe;

public class Product {
    private int id;
    private String name;
    private String category;
    private double price;
    private int stock;
    private String image;

    // Simple counter to give each product a unique number
    private static int nextId = 1;

    public Product(String name, String category, double price, int stock, String image) {
        this.id = nextId++;
        this.name = name;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.image = image;
    }

    // Getters - Needed so the Servlet can read the data
    public int getId() { return id; }
    public String getName() { return name; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
    public int getStock() { return stock; }
    public String getImage() { return image; }
}