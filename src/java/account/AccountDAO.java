package account;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author PC
 */
public class AccountDAO {
    public Account searchOne(String username, String password) throws SQLException{
        Account account = null;
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("Select * from Account "
                                                    + "where username=? and password=?");
        ResultSet rs = pst.executeQuery();
        if(rs.next()){
            account = new Account();
            account.setId(rs.getInt("id"));
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRoleId(rs.getString("roleId"));
            account.setCustomerId(rs.getInt("customerId"));
        }
        return account;
    }
    public void create(Account account) throws SQLException{
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("insert into Account VALUES(?,?,?,?,?,?,?)");
        pst.setString(1, account.getUsername());
        pst.setString(2, account.getPassword());
        pst.setString(3, "US");
        pst.setString(4, account.getName());
        pst.setString(5, account.getAddress());
        pst.setString(6, account.getEmail());
        pst.setString(7, account.getPhone());
    }
}
