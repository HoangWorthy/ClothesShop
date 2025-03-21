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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import product.Product;

/**
 *
 * @author PC
 */
public class OrderDAO {

    public List<Order> selectAll() throws SQLException {
        List<Order> orders = new ArrayList();
        Order order;
        Connection conn = DBContext.getConnection();
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("select * from OrderHeader order by date desc");
        while (rs.next()) {
            order = new Order();
            order.setId(rs.getInt("id"));
            order.setDate(rs.getDate("date"));
            order.setAccountId(rs.getString("accountId"));
            order.setStatus(rs.getString("status"));
            order.setShipToAddress(rs.getString("shipToAddress"));
            orders.add(order);
        }
//        conn.close();
        return orders;
    }

    public List<Order> selectTop(int limit) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT TOP " + limit + " * FROM OrderHeader ORDER BY date DESC"; // Hardcoding limit

        try (Connection conn = DBContext.getConnection();
                PreparedStatement pst = conn.prepareStatement(query)) {
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setDate(rs.getDate("date"));
                order.setAccountId(rs.getString("accountId"));
                order.setStatus(rs.getString("status"));
                order.setShipToAddress(rs.getString("shipToAddress"));
                orders.add(order);
            }
        }
        return orders;
    }

    public double calcRevenueInterval7Days(String date) throws SQLException {
        double revenue = 0;
        Connection conn = DBContext.getConnection();

        String sql = "SELECT SUM((price - (price * discount)) * quantity) AS revenue "
                + "FROM OrderDetail od "
                + "JOIN OrderHeader oh ON od.orderHeaderId = oh.id "
                + "WHERE oh.date BETWEEN DATEADD(day, -6, CAST(? AS DATE)) AND CAST(? AS DATE);";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, date);
        ps.setString(2, date);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            revenue = rs.getDouble("revenue");
        }
        conn.close();
        return revenue;
    }

    public List<Double> calcRevenueLast7Days(String date) throws SQLException {
    List<Double> revenueList = new ArrayList<>(Collections.nCopies(7, 0.0)); // Initialize with 7 zeroes
    Connection conn = DBContext.getConnection();

    String sql = "SELECT SUM((price - (price * discount)) * quantity) AS revenue, CAST(oh.date AS DATE) AS order_date " +
                 "FROM OrderDetail od " +
                 "JOIN OrderHeader oh ON od.orderHeaderId = oh.id " +
                 "WHERE oh.date BETWEEN DATEADD(day, -6, CAST(? AS DATE)) AND CAST(? AS DATE) " +
                 "GROUP BY CAST(oh.date AS DATE) " +
                 "ORDER BY order_date";

    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, date);
    ps.setString(2, date);

    ResultSet rs = ps.executeQuery();
    
    // Map for quick lookup
    Map<String, Double> revenueMap = new HashMap<>();
    while (rs.next()) {
        revenueMap.put(rs.getString("order_date"), rs.getDouble("revenue"));
    }

    conn.close();

    // Ensure correct mapping for last 7 days
    LocalDate selectedDate = LocalDate.parse(date);
    for (int i = 6; i >= 0; i--) {
        String day = selectedDate.minusDays(i).toString();
        revenueList.set(6 - i, revenueMap.getOrDefault(day, 0.0));
    }

    return revenueList;
}


    public double calcRevenueADay(String date) throws SQLException {
        double revenue = 0;
        Connection conn = DBContext.getConnection();
        String sql = "SELECT SUM((price - (price * discount)) * quantity) AS revenue "
                + "FROM OrderDetail od "
                + "JOIN OrderHeader oh ON od.orderHeaderId = oh.id "
                + "WHERE CONVERT(DATE, oh.date) = CONVERT(DATE, ?);";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, date);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            revenue = rs.getDouble("revenue");
        }
        conn.close();
        return revenue;
    }

    public double calcRevenueAMonth(String date) throws SQLException {
        double revenue = 0;
        Connection conn = DBContext.getConnection();
        String sql = "SELECT SUM((price - (price * discount)) * quantity) AS revenue "
                + "FROM OrderDetail od "
                + "JOIN OrderHeader oh ON od.orderHeaderId = oh.id "
                + "WHERE YEAR(oh.date) = YEAR(?) AND MONTH(oh.date) = MONTH(?);";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, date);
        ps.setString(2, date);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            revenue = rs.getDouble("revenue");
        }
        conn.close();
        return revenue;
    }

    public double calcRevenueAYear(String date) throws SQLException {
        double revenue = 0;
        Connection conn = DBContext.getConnection();
        String sql = "SELECT SUM((price - (price * discount)) * quantity) AS revenue "
                + "FROM OrderDetail od "
                + "JOIN OrderHeader oh ON od.orderHeaderId = oh.id "
                + "WHERE YEAR(oh.date) = ?;";

        PreparedStatement ps = conn.prepareStatement(sql);
        int year = Integer.parseInt(date.substring(0, 4));
        ps.setInt(1, year);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            revenue = rs.getDouble("revenue");
        }
        conn.close();
        return revenue;
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

    public List<Order> selectOrderHeaderByAccountId(String accountId) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("select * from OrderHeader where accountId=?");
        pst.setString(1, accountId);
        ResultSet rs = pst.executeQuery();
        List<Order> orders = new ArrayList<>();
        Order order = null;
        while (rs.next()) {
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

    public List<List<OrderDetail>> selectOrderDetail(String accountId) throws SQLException {
        Connection conn = DBContext.getConnection();
        List<List<OrderDetail>> list = new ArrayList<>();
        List<Order> orders = selectOrderHeaderByAccountId(accountId);

        for (Order order : orders) {
            PreparedStatement pst = conn.prepareStatement(
                    "SELECT x.id, x.productId, x.orderHeaderId, "
                    + "y.description, x.quantity, x.price, x.discount "
                    + "FROM OrderDetail x JOIN Product y ON x.productId = y.id "
                    + "WHERE orderHeaderId = ?"
            );
            pst.setInt(1, order.getId());

            ResultSet rs = pst.executeQuery();
            List<OrderDetail> orderDetails = new ArrayList<>();

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail();
                Product product = new Product();

                product.setId(rs.getInt("productId"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscount(rs.getDouble("discount"));
                product.setCategoryId(rs.getInt("categoryId"));

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

            if (!orderDetails.isEmpty()) {
                list.add(orderDetails);
            }
        }

        conn.close();
        return list;
    }

    public List<OrderDetail> selectOrderDetailByOrderId(int orderId) throws SQLException {
        List<OrderDetail> orderDetails = new ArrayList<>();

        String query = "SELECT x.id, x.productId, x.orderHeaderId, y.description, x.quantity, x.price, x.discount "
                + "FROM OrderDetail x JOIN Product y ON x.productId = y.id "
                + "WHERE x.orderHeaderId = ?";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setInt(1, orderId);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    OrderDetail orderDetail = new OrderDetail();
                    Product product = new Product();

                    // Setting OrderDetail attributes
                    orderDetail.setId(rs.getInt("id"));
                    orderDetail.setOrderId(orderId);
                    orderDetail.setQuantity(rs.getInt("quantity"));
                    orderDetail.setPrice(rs.getDouble("price"));
                    orderDetail.setDiscount(rs.getDouble("discount"));

                    // Setting Product attributes
                    product.setId(rs.getInt("productId"));
                    product.setDescription(rs.getString("description"));

                    // Associating Product with OrderDetail
                    orderDetail.setProductId(product); // Assuming `setProduct()` exists in OrderDetail class
                    orderDetails.add(orderDetail);
                }
            }
        }

        return orderDetails;
    }

    public void changeStatus(int orderHeaderId, String status) throws SQLException {
        String query = "UPDATE OrderHeader SET status=? WHERE id=?";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setString(1, status);
            pst.setInt(2, orderHeaderId);
            pst.executeUpdate();
        }
    }

}
