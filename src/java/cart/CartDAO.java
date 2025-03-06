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
import java.util.ArrayList;

/**
 *
 * @author PC
 */
public class CartDAO {
    public void create(int productId, int accountId) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("insert into Carts VALUES(?,?,?)");
        pst.setInt(1, 1);
        pst.setInt(2, productId);
        pst.setInt(3, accountId);
        pst.executeUpdate();
        conn.close();
    }
    public void update(int productId, int accountId, int quantity) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("update Carts set quantity=? "
                                                    + "where accountId=? and productId=?");
        pst.setInt(1, quantity+1);
        pst.setInt(2, productId);
        pst.setInt(3, accountId);
        pst.executeUpdate();
        conn.close();
    }
    public int searchOne(int productId, int accountId) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("select * from Carts "
                                                    + "where productId=? and accountId=?");
        pst.setInt(1, productId);
        pst.setInt(2, accountId);
        ResultSet rs = pst.executeQuery();
        if(rs.next()) return rs.getInt("quantity");
        conn.close();
        return 0;
    }
    
    public ArrayList<Cart> searchByAccount(int accountId) throws SQLException{
        ArrayList<Cart> carts = new ArrayList();
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("select * from Carts accountId=?");
        pst.setInt(1, accountId);
        ResultSet rs = pst.executeQuery();
        while(rs.next()){
            Cart cart = new Cart();
            cart.setAccountId(accountId);
            cart.setProductId(rs.getInt("productId"));
            cart.setQuantity(rs.getInt("quantity"));
            carts.add(cart);
        }
        conn.close();
        return carts;
    }
    
    public void emptyAll(int accountId) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("delete * from carts where accountId=?");
        pst.setInt(1, accountId);
        pst.executeUpdate();
        conn.close();
    }
    public void remove(int accountId, int productId) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("delete * from carts where accountId=? and productId=?");
        pst.setInt(1, accountId);
        pst.setInt(2, productId);
        pst.executeUpdate();
        conn.close();
    }
}
