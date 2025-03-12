/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PHT
 */
public class ProductDAO {

    public List<Product> select() throws SQLException {
        List<Product> list = null;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        Statement stm = con.createStatement();
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery("select * from Product");
        list = new ArrayList<>();
        while (rs.next()) {
            //Đọc từng dòng trong table Brand để vào đối tượng product
            Product product = new Product();
            product.setId(rs.getInt("id"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setDiscount(rs.getDouble("discount"));
            product.setCategoryId(rs.getInt("categoryId"));
            //Thêm brand vào list
            list.add(product);
        }
        //Đóng kết nối db
        con.close();
        return list;
    }

    public List<Product> selectlist(int page) throws SQLException {
    int pageSize = 15;
    List<Product> list = new ArrayList<>();
    
    // Tạo kết nối db
    Connection con = DBContext.getConnection();
    String query = "SELECT * FROM Product ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    
    try (PreparedStatement stm = con.prepareStatement(query)) {
        stm.setInt(1, (page - 1) * pageSize);
        stm.setInt(2, pageSize);
        
        try (ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscount(rs.getDouble("discount"));
                product.setCategoryId(rs.getInt("categoryId"));
                list.add(product);
            }
        }
    } finally {
        con.close(); // Ensure connection is closed
    }
    
    return list;
}

    
public List<Product> selectTop(int limit) throws SQLException {
    List<Product> list = new ArrayList<>();
    String query = "SELECT TOP " + limit + " * FROM Product ORDER BY id"; // Dynamically insert limit

    try (Connection con = DBContext.getConnection();
         Statement stm = con.createStatement();
         ResultSet rs = stm.executeQuery(query)) {

        while (rs.next()) {
            Product product = new Product();
            product.setId(rs.getInt("id"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setDiscount(rs.getDouble("discount"));
            product.setCategoryId(rs.getInt("categoryId"));
            list.add(product);
        }
    }
    return list;
}


    public Product read(int id) throws SQLException {
        Product product = null;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        PreparedStatement stm = con.prepareStatement("select * from Product where id=?");
        stm.setInt(1, id);
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            //Đọc từng dòng trong table Brand để vào đối tượng product
            product = new Product();
            product.setId(rs.getInt("id"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setDiscount(rs.getDouble("discount"));
            product.setCategoryId(rs.getInt("categoryId"));
        }
        //Đóng kết nối db
        con.close();
        return product;
    }

    public int count() throws SQLException {
        int row_count = 0;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        Statement stm = con.createStatement();
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery("select count(*) row_count from Product");
        if (rs.next()) {
            row_count = rs.getInt("row_count");
        }
        //Đóng kết nối db
        con.close();
        return row_count;
    }

    public void update(Product product) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("update Product set description=?,price=?,discount=?,categoryId=? where id=?");
        pst.setString(1, product.getDescription());
        pst.setDouble(2, product.getPrice());
        pst.setDouble(3, product.getDiscount());
        pst.setInt(4, product.getCategoryId());
        pst.setInt(5, product.getId());
        pst.executeUpdate();
        conn.close();
    }
    
    public void delete(int productId) throws SQLException {
    Connection conn = DBContext.getConnection();
    PreparedStatement pst = conn.prepareStatement("DELETE FROM Product WHERE id=?");
    pst.setInt(1, productId);
    pst.executeUpdate();
    conn.close();
}

public int insert(Product product) throws SQLException {
    int generatedId = -1; // Default value
    String sql = "INSERT INTO Product (description, price, discount, categoryId) VALUES (?, ?, ?, ?)";
    
    try (Connection conn = DBContext.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        stmt.setString(1, product.getDescription());
        stmt.setDouble(2, product.getPrice());
        stmt.setDouble(3, product.getDiscount());
        stmt.setInt(4, product.getCategoryId());

        int affectedRows = stmt.executeUpdate();
        
        if (affectedRows > 0) {
            // Get the generated ID
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
        }
    }
    return generatedId;
}


}
