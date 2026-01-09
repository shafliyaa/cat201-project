package com.example.hijabluxe;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Order {
    private int id;
    private String customerName;
    private double amount;
    private String status;
    private String orderDate;

    public Order(int id, String customerName, double amount, String status) {
        this.id = id;
        this.customerName = customerName;
        this.amount = amount;
        this.status = status;
        this.orderDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    // Getters and Setters
    public int getId() { return id; }
    public String getCustomerName() { return customerName; }
    public double getAmount() { return amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
