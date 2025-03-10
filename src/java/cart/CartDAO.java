/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cart;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import product.Product;

/**
 *
 * @author PC
 */
public class CartDAO {

    public void create(int productId, String accountId) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("insert into Carts VALUES(?,?,?)");
        pst.setInt(1, 1);
        pst.setInt(2, productId);
        pst.setString(3, accountId);
        int count = pst.executeUpdate();
        conn.close();
    }

    public void update(int productId, String accountId, int quantity) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("update Carts set quantity=? "
                + "where accountId=? and productId=?");
        pst.setInt(1, quantity);
        pst.setString(2, accountId);
        pst.setInt(3, productId);
        pst.executeUpdate();
        conn.close();
    }

    public int searchOne(int productId, String accountId) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("select * from Carts "
                + "where productId=? and accountId=?");
        pst.setInt(1, productId);
        pst.setString(2, accountId);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            return rs.getInt("quantity");
        }
        conn.close();
        return 0;
    }

    public ArrayList<Cart> searchByAccount(String accountId) throws SQLException {
        ArrayList<Cart> carts = new ArrayList<>();
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement(
                "SELECT c.accountId, c.productId, c.quantity, p.description, p.price, p.discount, p.categoryId "
                + "FROM Carts c JOIN Product p ON c.productId = p.id WHERE c.accountId = ?"
        );
        pst.setString(1, accountId);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Cart cart = new Cart();
            cart.setAccountId(rs.getString("accountId"));
            cart.setProductId(rs.getInt("productId"));
            cart.setQuantity(rs.getInt("quantity"));

            Product product = new Product();
            product.setId(rs.getInt("productId"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setDiscount(rs.getDouble("discount"));
            product.setCategoryId(rs.getInt("categoryId"));
            cart.setProduct(product);
            carts.add(cart);
        }
        conn.close();
        return carts;
    }

    public void emptyAll(String accountId) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("delete from carts where accountId=?");
        pst.setString(1, accountId);
        pst.executeUpdate();
        conn.close();
    }

    public void remove(String accountId, int productId) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("delete from carts where accountId=? and productId=?");
        pst.setString(1, accountId);
        pst.setInt(2, productId);
        pst.executeUpdate();
        conn.close();
    }

    public List<Cart> select() throws SQLException {
    List<Cart> list = new ArrayList<>();
    String query = "SELECT c.accountId, c.productId, c.quantity, " +
                   "p.description, p.price, p.discount, p.categoryId " +
                   "FROM Carts c JOIN Product p ON c.productId = p.id";

    try (Connection con = DBContext.getConnection();
         PreparedStatement stm = con.prepareStatement(query);
         ResultSet rs = stm.executeQuery()) {

        while (rs.next()) {
            Cart cart = new Cart();
            cart.setAccountId(rs.getString("accountId"));
            cart.setProductId(rs.getInt("productId"));
            cart.setQuantity(rs.getInt("quantity"));

            // Create Product object and set its attributes
            Product product = new Product();
            product.setId(rs.getInt("productId"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setDiscount(rs.getDouble("discount"));
            product.setCategoryId(rs.getInt("categoryId"));

            cart.setProduct(product); // Associate product with cart
            list.add(cart);
        }
    }
    return list;
}


    public List<Cart> selectTop(int limit) throws SQLException {
    List<Cart> carts = new ArrayList<>();
    String query = "SELECT TOP " + limit + " c.accountId, c.productId, c.quantity, " +
                   "p.description, p.price, p.discount, p.categoryId " +
                   "FROM Carts c JOIN Product p ON c.productId = p.id " +
                   "ORDER BY c.accountId";

    try (Connection con = DBContext.getConnection();
         Statement stm = con.createStatement();
         ResultSet rs = stm.executeQuery(query)) {

        while (rs.next()) {
            Cart cart = new Cart();
            cart.setAccountId(rs.getString("accountId"));
            cart.setProductId(rs.getInt("productId"));
            cart.setQuantity(rs.getInt("quantity"));

            // Create Product object and set its attributes
            Product product = new Product();
            product.setId(rs.getInt("productId"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setDiscount(rs.getDouble("discount"));
            product.setCategoryId(rs.getInt("categoryId"));

            cart.setProduct(product); // Associate product with cart
            carts.add(cart);
        }
    }
    return carts;
}


}
