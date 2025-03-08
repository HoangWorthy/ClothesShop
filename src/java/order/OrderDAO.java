/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package order;

import db.DBContext;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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
        return orders;
    }
}
