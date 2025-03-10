/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import account.Account;
import cart.Cart;
import cart.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import order.Order;
import order.OrderDAO;
import order.OrderDetail;
import product.Product;

/**
 *
 * @author PC
 */
@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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
                case "ADMINlist":
                    selectAll(request,response);
                    break;
                case "create":
                    create(request,response);
                    break;
                case "changeStatus":
                    changeStatus(request,response);
                    break;
                case "select":
                    select(request,response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    protected void selectAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Order> orders = orderDAO.selectAll();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }
    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        CartDAO cartDAO = new CartDAO();
        ArrayList<Cart> carts = cartDAO.searchByAccount(account.getUsername());
        ArrayList<OrderDetail> orderDetails = new ArrayList();
        for(Cart cart : carts){
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductId(cart.getProduct());
            orderDetail.setQuantity(cart.getQuantity());
            orderDetail.setDiscount(cart.getProduct().getDiscount());
            orderDetail.setPrice(cart.getProduct().getPrice());
            orderDetails.add(orderDetail);
        }
        orderDAO.create(account, orderDetails);
        cartDAO.emptyAll(account.getUsername());
        request.setAttribute("action", "ADMINlist");
        selectAll(request, response);
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

    private void changeStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String status = request.getParameter("status");
        int orderHeaderId = Integer.parseInt(request.getParameter("id"));
        orderDAO.changeStatus(orderHeaderId, status);
        request.setAttribute("action", "ADMINlist");
        selectAll(request, response);
    }

    private void select(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = new Account();
        List<List<OrderDetail>> list = orderDAO.selectOrderDetail(account.getUsername());
        request.setAttribute("list", list);
        request.setAttribute("controller", "cart");
        request.setAttribute("action", "index");
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }
}
