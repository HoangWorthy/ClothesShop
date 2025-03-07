/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cart;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import product.Product;

/**
 *
 * @author PHT
 */
public class Cart {
    private int id;
    private int quantity;
    private int productId;
    private Product product;
    private int accountId;

    public Cart() {
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    public double getNewTotal() {
        return product.getNewPrice() * this.quantity;
    }
    
}
