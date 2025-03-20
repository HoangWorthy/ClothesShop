/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package category;

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
 * @author PC
 */
public class CategoryDAO {
    public List<Category> selectAll() throws SQLException{
        Connection conn = DBContext.getConnection();
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery("Select * from Category");
        List<Category> list = new ArrayList<>();
        while(rs.next()){
            Category category = new Category();
            category.setId(rs.getInt("id"));
            category.setName(rs.getString("name"));
            list.add(category);
        }
        return list;
    }
    
    public Category select(int id) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("select * from Category where id=?");
        pst.setInt(1,id);
        ResultSet rs = pst.executeQuery();
        Category category = null;
        if(rs.next()){
            category = new Category();
            category.setId(rs.getInt("id"));
            category.setName(rs.getString("name"));
        }
        return category;
    }
}
