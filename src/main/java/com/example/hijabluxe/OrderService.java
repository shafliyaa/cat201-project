package com.example.hijabluxe;

import java.util.ArrayList;
import java.util.List;

public class OrderService {
    private static OrderService instance;
    private List<Order> orders = new ArrayList<>();

    private OrderService() {
        // Adding some dummy orders for the Admin to see initially
        orders.add(new Order("Siti Aminah", 89.00));
        orders.add(new Order("Syarifah Asri", 70.00));
    }

    public static OrderService getInstance() {
        if (instance == null) instance = new OrderService();
        return instance;
    }

    public List<Order> getAllOrders() { return orders; }

    public void addOrder(Order order) { orders.add(0, order); }

    public void updateOrderStatus(int id, String status) {
        for (Order o : orders) {
            if (o.getId() == id) {
                o.setStatus(status);
                break;
            }
        }
    }
}