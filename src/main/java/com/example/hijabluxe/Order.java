package com.example.hijabluxe;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Order {
    private int id;
    private String customerName;
    private double amount;
    private String status; // "processing" or "completed"
    private String orderDate;

    private static int nextId = 1001;

    public Order(String customerName, double amount) {
        this.id = nextId++;
        this.customerName = customerName;
        this.amount = amount;
        this.status = "processing"; // Default status
        this.orderDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    // Getters and Setters
    public int getId() { return id; }
    public String getCustomerName() { return customerName; }
    public double getAmount() { return amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getOrderDate() { return orderDate; }
}
