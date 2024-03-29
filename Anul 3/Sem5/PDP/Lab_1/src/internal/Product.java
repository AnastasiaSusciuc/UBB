package internal;

import java.util.concurrent.locks.ReentrantLock;

public class Product {
    private String name;
    private int price;
    private int quantity;
    private final ReentrantLock mutex = new ReentrantLock();

    public Product(String name, int price, int quantity){
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public String getName() {
        return name;
    }

    public int getQuantity() {
        return quantity;
    }

    @Override
    public String toString() {
        return name + ": " + price + " " + quantity + "q";
    }

    public void setQuantity(int i) {
        this.quantity = i;
    }
}