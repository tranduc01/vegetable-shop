/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.LinkedHashMap;

/**
 *
 * @author light
 */
public class Cart {

    LinkedHashMap<String, Product> cart;

    public Cart() {
    }

    public Cart(LinkedHashMap<String, Product> cart) {
        this.cart = cart;
    }

    public LinkedHashMap<String, Product> getCart() {
        return cart;
    }

    public void setCart(LinkedHashMap<String, Product> cart) {
        this.cart = cart;
    }

    public boolean add(Product product) {
        boolean check = false;
        if (cart == null) {
            cart = new LinkedHashMap<>();
        }
        if (this.cart.containsKey(product.getProductID())) {
            int currentQuantity = this.cart.get(product.getProductID()).getQuantity();
            product.setQuantity(currentQuantity + product.getQuantity());
        }
        this.cart.put(product.getProductID(), product);
        check = true;
        return check;
    }

    public boolean delete(String productID) {
        boolean check = false;
        if (this.cart != null) {
            System.out.println(this.cart.values());
            if (this.cart.containsKey(productID)) {
                this.cart.remove(productID);
                check = true;
            }
        }
        return check;
    }

    public boolean update(String productID, Product product) {
        boolean check = false;
        if (this.cart != null) {
            if (this.cart.containsKey(productID)) {
                this.cart.replace(productID, product);
                check = true;
            }
        }
        return check;
    }

//    public boolean updateQuantity(String productID, int quantity) {
//        boolean check = false;
//        Product product = new Product();
//        if (this.cart != null) {
//            if (this.cart.containsKey(productID)) {
//                this.cart.get(product.getProductID()).setQuantity(quantity);
//                check = true;
//            }
//        }
//        return check;
//    }

}
