public class Product {
    private String name;
    private String category;
    private double price;
    private int stock;
    private String image;

    public Product() {}

    public Product(String name, String category, double price, int stock, String image) {
        this.name = name;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.image = image;
    }

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    // Helper method to convert product to JSON manually
    public String toJson() {
        return String.format("{\"name\":\"%s\",\"category\":\"%s\",\"price\":%s,\"stock\":%s,\"image\":\"%s\"}",
                name, category, price, stock, image);
    }
}

