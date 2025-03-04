/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

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
public class ProductFacade {
    
    public List<Product> select() throws SQLException{
        List<Product> list = null;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        Statement stm = con.createStatement();
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery("select * from Product");
        list = new ArrayList<>();
        while(rs.next()){
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
    
    public List<Product> selectlist(int page) throws SQLException{
        int pageSize = 15;
        List<Product> list = null;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        PreparedStatement stm = con.prepareStatement("select * from Product order by id offset ? rows fetch next ? rows only");        
        stm.setInt(1, (page-1)*pageSize);
        stm.setInt(2, pageSize);
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery();        
        list = new ArrayList<>();
        while(rs.next()){
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
public List<Product> selectTop8() throws SQLException {
    List<Product> list = new ArrayList<>();
    Connection con = DBContext.getConnection();
    PreparedStatement stm = con.prepareStatement("select top 8 * from Product order by id");
    ResultSet rs = stm.executeQuery();
    while (rs.next()) {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setDiscount(rs.getDouble("discount"));
        product.setCategoryId(rs.getInt("categoryId"));
        list.add(product);
    }
    con.close();
    return list;
}


    
    public Product read(int id) throws SQLException{
        Product product = null;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        PreparedStatement stm = con.prepareStatement("select * from Product where id=?");        
        stm.setInt(1, id);
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery();        
        while(rs.next()){
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
    
    public int count() throws SQLException{
        int row_count = 0;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        Statement stm = con.createStatement();
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery("select count(*) row_count from Product");
        if(rs.next()){
            row_count = rs.getInt("row_count");
        }
        //Đóng kết nối db
        con.close();
        return row_count;
    }
}
