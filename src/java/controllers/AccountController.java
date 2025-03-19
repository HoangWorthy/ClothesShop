/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import account.Account;
import account.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet(name = "AccountController", urlPatterns = {"/account"})
public class AccountController extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * 
     * 
     * 
     * 
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = (String) request.getAttribute("action");
        System.out.println(action);
        try {
            switch (action) {
                case "login":
                    login(request, response);
                    break;
                case "register":
                    register(request, response);
                    break;
                case "update":
                    update(request, response);
                    break;
                case "logout":
                    logout(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Account account = accountDAO.searchOne(username, password);
        if (account == null) {
            request.setAttribute("message", "Username or password is wrong!");
            request.setAttribute("showLoginModal", true);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        HttpSession session = request.getSession();
        session.setAttribute("account", account);
        if (account.getRoleId().equals("AD")) {
            request.getRequestDispatcher("/product/adminList.do").forward(request, response);
        } else {
            request.setAttribute("action", "index");
            request.setAttribute("controller", "product");
            request.getRequestDispatcher("/product").forward(request, response);
        }
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        Account newAccount = new Account();
        newAccount.setUsername(account.getUsername());
        newAccount.setRoleId(account.getRoleId());
        newAccount.setPassword(password);
        newAccount.setName(name);
        newAccount.setAddress(address);
        newAccount.setEmail(email);
        newAccount.setPhone(phone);
        accountDAO.update(account.getUsername(), newAccount);
        session.setAttribute("account", newAccount);
        request.setAttribute("message", "Update Success");
        request.setAttribute("showUpdateModal", true);
        request.setAttribute("controller", "product");
        request.setAttribute("action", "index");
        request.getRequestDispatcher("/product").forward(request, response);
    }

    protected void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        session.invalidate();
        request.setAttribute("action", "index");
        request.setAttribute("controller", "product");
        request.getRequestDispatcher("/product").forward(request, response);
    }

    protected void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String roleId = request.getParameter("roleId");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        //Need validation!!
        Account account = new Account();
        account.setUsername(username);
        account.setPassword(password);
        account.setRoleId(roleId);
        account.setName(name);
        account.setAddress(address);
        account.setEmail(email);
        account.setPhone(phone);
        accountDAO.create(account);
        HttpSession session = request.getSession();
        session.setAttribute("account", account);
//        request.setAttribute("message", "Register Success");
//        request.setAttribute("showRegisterModal", true);
        request.setAttribute("controller", "product");
        request.setAttribute("action", "index");
        request.getRequestDispatcher("/product").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
