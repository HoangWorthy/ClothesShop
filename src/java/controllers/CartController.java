/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import account.Account;
import cart.Cart;
import cart.CartDAO;
import product.Product;
import product.ProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PHT
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = (String) request.getAttribute("action");
        try {
            switch (action) {
                case "index":
                    //thêm item vào cart
                    index(request, response);
                    break;
                case "add":
                    //thêm item vào cart
                    add(request, response);
                    break;
                case "update":
                    //thêm item vào cart
                    update(request, response);
                    break;
                case "remove":
                    //xóa item khỏi cart
                    remove(request, response);
                    break;
                case "empty":
                    //xóa sạch cart
                    empty(request, response);
                    break;
            }
        } catch (Exception e) {
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String accountId = account.getUsername();
        ArrayList<Cart> carts = new ArrayList();
        try {
        carts = cartDAO.searchByAccount(accountId);
            request.setAttribute("carts", carts);
            request.setAttribute("controller", "order");
            request.setAttribute("action", "select");
            request.getRequestDispatcher("/order/select.do").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            request.setAttribute("showLoginModal", true);
        } else {
            String accountId = account.getUsername();
            if (cartDAO.searchOne(Integer.parseInt(productId), accountId) != 0) {
                int quantity = cartDAO.searchOne(Integer.parseInt(productId), accountId);
                int newQuantity = quantity + 1;
                cartDAO.update(Integer.parseInt(productId), accountId, newQuantity);
                System.out.println("update success");
            } else {
                cartDAO.create(Integer.parseInt(productId), accountId);
                System.out.println("add success");
            }
        }
        request.setAttribute("action", "index");
        index(request, response);
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String accountId = account.getUsername();
        cartDAO.update(productId, accountId, quantity);
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
    }

    protected void empty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String accountId = account.getUsername();
        cartDAO.emptyAll(accountId);
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
    }

    protected void remove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        Account account = (Account) session.getAttribute("account");
        String accountId = account.getUsername();
        System.out.println(accountId);
        System.out.println(productId);
        cartDAO.remove(accountId, Integer.parseInt(productId));
        System.out.println("delete success");
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
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
