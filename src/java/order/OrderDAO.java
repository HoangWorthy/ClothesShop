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
        ResultSet rs = stm.executeQuery("select * from OrderHeader order by date desc");
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
    public void create(Account account, List<OrderDetail> orderDetails) throws SQLException {
    Connection conn = DBContext.getConnection();
    PreparedStatement pstHeader = null;
    PreparedStatement pstDetail = null;
    ResultSet rs = null;
    int orderId = 0;
    pstHeader = conn.prepareStatement("INSERT INTO OrderHeader (date, accountId, status, shipToAddress) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
    pstHeader.setDate(1, new Date(System.currentTimeMillis()));
    pstHeader.setString(2, account.getUsername());
    pstHeader.setString(3, "OnGoing");
    pstHeader.setString(4, account.getAddress());
    pstHeader.executeUpdate();
    rs = pstHeader.getGeneratedKeys();
    if (rs.next()) {
        orderId = rs.getInt(1);
    }
    pstDetail = conn.prepareStatement("INSERT INTO OrderDetail (orderHeaderId, productId, quantity, price, discount) VALUES (?, ?, ?, ?, ?)");

    for (OrderDetail orderDetail : orderDetails) {
        pstDetail.setInt(1, orderId);
        pstDetail.setInt(2, orderDetail.getProductId().getId());
        pstDetail.setInt(3, orderDetail.getQuantity());
        pstDetail.setDouble(4, orderDetail.getPrice());
        pstDetail.setDouble(5, orderDetail.getDiscount());
        pstDetail.executeUpdate();
    }
    
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
