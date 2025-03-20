/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.util.Comparator;
import product.Product;

/**
 *
 * @author WIN11
 */
public class SortByPrice {

    public static class PriceComparatorAsc implements Comparator<Product> {
        public int compare(Product p1, Product p2) {
            return (int) (p1.getNewPrice()-p2.getNewPrice());
        }
    }
    public static class PriceComparatorDesc implements Comparator<Product> {
        public int compare(Product p1, Product p2) {
            return (int) (p2.getNewPrice()-p1.getNewPrice());
        }
    }
    
}
