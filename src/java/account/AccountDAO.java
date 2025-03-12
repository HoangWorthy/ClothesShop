package account;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import product.Product;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author PC
 */
public class AccountDAO {

    public Account searchOne(String username, String password) throws SQLException {
        Account account = null;
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("SELECT * FROM Account WHERE username=? AND password=?");

        pst.setString(1, username);  // Set username into the first "?".
        pst.setString(2, password);  // Set password into the second "?".

        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            account = new Account();
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRoleId(rs.getString("roleId"));
            account.setName(rs.getString("name"));
            account.setAddress(rs.getString("address"));
            account.setEmail(rs.getString("email"));
            account.setPhone(rs.getString("phone"));
        }
        rs.close();
        conn.close();
        return account;
    }

    public void create(Account account) throws SQLException {
        Connection conn = DBContext.getConnection();
        PreparedStatement pst = conn.prepareStatement("insert into Account VALUES(?,?,?,?,?,?,?)");
        pst.setString(1, account.getUsername());
        pst.setString(2, account.getPassword());
        pst.setString(3, "US");
        pst.setString(4, account.getName());
        pst.setString(5, account.getAddress());
        pst.setString(6, account.getEmail());
        pst.setString(7, account.getPhone());
        int count = pst.executeUpdate();
        conn.close();
    }

    public void update(String username, Account newAccount) throws SQLException {
    Connection conn = null;
    PreparedStatement pst = null;
    
    try {
        conn = DBContext.getConnection();
        pst = conn.prepareStatement("UPDATE Account SET password=?, name=?, address=?, email=?, phone=? WHERE username=?");
        
        pst.setString(1, newAccount.getPassword());
        pst.setString(2, newAccount.getName());
        pst.setString(3, newAccount.getAddress());
        pst.setString(4, newAccount.getEmail());
        pst.setString(5, newAccount.getPhone());
        pst.setString(6, username);

        pst.executeUpdate();
    } finally {
        if (pst != null) {
            pst.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
}


    public int count() throws SQLException {
        int row_count = 0;
        //Tạo kết nối db
        Connection con = DBContext.getConnection();
        //Tạo đối tượng Statement
        Statement stm = con.createStatement();
        //Thực thi lệnh select
        ResultSet rs = stm.executeQuery("select count(*) row_count from Account");
        if (rs.next()) {
            row_count = rs.getInt("row_count");
        }
        //Đóng kết nối db
        con.close();
        return row_count;
    }

    public List<Account> select() throws SQLException {
        List<Account> list = new ArrayList<>();
        String query = "SELECT * FROM Account";

        try (Connection con = DBContext.getConnection();
                Statement stm = con.createStatement();
                ResultSet rs = stm.executeQuery(query)) {

            while (rs.next()) {
                Account account = new Account();
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setRoleId(rs.getString("roleId"));
                account.setName(rs.getString("name"));
                account.setAddress(rs.getString("address"));
                account.setEmail(rs.getString("email"));
                account.setPhone(rs.getString("phone"));
                list.add(account);
            }
        }
        return list;
    }
    
public List<Account> selectTop(int limit) throws SQLException {
    List<Account> list = new ArrayList<>();
    String query = "SELECT TOP " + limit + " * FROM Account ORDER BY username";

    try (Connection con = DBContext.getConnection();
         Statement stm = con.createStatement();
         ResultSet rs = stm.executeQuery(query)) {

        while (rs.next()) {
            Account account = new Account();
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRoleId(rs.getString("roleId"));
            account.setName(rs.getString("name"));
            account.setAddress(rs.getString("address"));
            account.setEmail(rs.getString("email"));
            account.setPhone(rs.getString("phone"));
            list.add(account);
        }
    }
    return list;
}


}
