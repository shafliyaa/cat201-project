package com.example.hijabluxe;

import java.util.ArrayList;
import java.util.List;

public class OrderService {
    private static OrderService instance;
    private List<Order> orders = new ArrayList<>();

    private OrderService() {
        // Initial mock data
        orders.add(new Order(1109, "Siti Aminah", 89.00, "processing"));
        orders.add(new Order(1108, "Syarifah Asri", 70.00, "processing"));
    }

    public static OrderService getInstance() {
        if (instance == null) instance = new OrderService();
        return instance;
    }

    public List<Order> getAllOrders() { return orders; }

    public void addOrder(String name, double total) {
        int newId = orders.isEmpty() ? 1110 : orders.get(0).getId() + 1;
        orders.add(0, new Order(newId, name, total, "processing"));
    }

    public void updateStatus(int id, String status) {
        for (Order o : orders) {
            if (o.getId() == id) {
                o.setStatus(status);
                break;
            }
        }
    }
}
