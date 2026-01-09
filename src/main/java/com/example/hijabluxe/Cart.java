package com.example.hijabluxe;

import java.util.ArrayList;

public class Cart {
    private User user;
    private ArrayList<Product> items;

    // Constructor
    public Cart(User user) {
        this.user = user;
        items = new ArrayList<>();
    }

    // Add product to cart
    public void addItem(Product product) {
        items.add(product);
        System.out.println(product + " added to " + user.getUsername() + "'s cart.");
    }

    // Remove product from cart
    public void removeItem(Product product) {
        if (items.remove(product)) {
            System.out.println(product + " removed from " + user.getUsername() + "'s cart.");
        } else {
            System.out.println(product + " not found in the cart.");
        }
    }

    // Calculate total price
    public double getTotalPrice() {
        double total = 0;
        for (Product p : items) {
            total += p.getPrice();
        }
        return total;
    }

    // Get cart items
    public ArrayList<Product> getItems() {
        return items;
    }
}
