/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package order;

import account.Account;
import db.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import product.Product;

/**
 *
 * @author PC
 */
public class OrderDAO {
    public List<Order> selectAll() throws SQLException{
        List<Order> orders = new ArrayList();
        Order order;
        Connection conn = DBContext.getConnection();
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from OrderHeader");
        while(rs.next()){
            order = new Order();
            order.setId(rs.getInt("id"));
            order.setDate(rs.getDate("date"));
            order.setAccountId(rs.getString("accountId"));
            order.setStatus(rs.getString("status"));
            order.setShipToAddress(rs.getString("shipToAddress"));
            orders.add(order);
        }
        conn.close();
        return orders;
    }
    public void create(Account account, OrderDetail orderDetail) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("Insert into OrderHeader VALUES(?,?,?,?)");
        pst.setDate(1, new Date(System.currentTimeMillis()));
        pst.setString(2,account.getUsername());
        pst.setString(3, "OnGoing");
        pst.setString(4, account.getEmail());
        pst.executeUpdate();
        pst = conn.prepareStatement("select MAX(id)as MAX_ID from OrderHeader");
        ResultSet rs = pst.executeQuery();
        int orderId = 0;
        if(rs.next()){
            orderId = rs.getInt("MAX_ID");
        }
        pst = conn.prepareStatement("Insert into OrderDetail VALUES(?,?,?,?,?)");
        pst.setInt(1, orderId);
        pst.setInt(2,orderDetail.getProductId().getId());
        pst.setInt(3,orderDetail.getQuantity());
        pst.setDouble(4,orderDetail.getPrice());
        pst.setDouble(5, orderDetail.getDiscount());
        pst.executeUpdate();
        conn.close();
    }
    public List<Order> selectOrderHeaderByAccountId(String accountId) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("select * from OrderHeader where accountId=?");
        pst.setString(1, accountId);
        ResultSet rs = pst.executeQuery();
        List<Order> orders = new ArrayList<>();
        Order order = null;
        while(rs.next()){
            order = new Order();
            order.setId(rs.getInt("id"));
            order.setAccountId(rs.getString("accountId"));
            order.setDate(rs.getDate("date"));
            order.setStatus(rs.getString("status"));
            order.setShipToAddress(rs.getString("shipToAddress"));
            orders.add(order);
        }
        rs.close();
        pst.close();
        conn.close();
        return orders;
    }
    
    public List<List<OrderDetail>> selectOrderDetail(String accountId) throws SQLException{
        Connection conn = DBContext.getConnection();
        List<List<OrderDetail>> list = new ArrayList<>();
        List<Order> orders = selectOrderHeaderByAccountId(accountId);
        List<OrderDetail> orderDetails = null;
        OrderDetail orderDetail = null;
        Product product = null;
        for(Order order : orders){
            PreparedStatement pst = conn.prepareStatement("Select x.id, x.productId, x.orderHeaderId, "
                    + "y.description, x.quantity, x.price, x.discount from "
                    + "OrderDetail x join Product y on x.productId=y.id "
                    + "where orderHeaderId=?");
            pst.setInt(1, order.getId());
            ResultSet rs = pst.executeQuery();
            orderDetails = new ArrayList();
            while(rs.next()){
               orderDetail = new OrderDetail();
               product = new Product();
               product.setDescription(rs.getString("description"));
               product.setId(rs.getInt("productId"));
               orderDetail.setId(rs.getInt("id"));
               orderDetail.setOrderId(order.getId());
               orderDetail.setProductId(product);
               orderDetail.setQuantity(rs.getInt("quantity"));
               orderDetail.setPrice(rs.getDouble("price"));
               orderDetail.setDiscount(rs.getDouble("discount"));
               orderDetails.add(orderDetail);
            }
            rs.close();
            pst.close();
            list.add(orderDetails);
        }
        conn.close();
        return list;
    }
}
