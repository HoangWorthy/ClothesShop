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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
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
import product.ProductDAO;

/**
 *
 * @author PC
 */
@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();

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
                case "select":
                    select(request, response);
                    break;
                case "selectDetail":
                    selectDetail(request, response);
                    break;
                case "create":
                    create(request, response);
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

    protected void getRevenue(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {
    String date = request.getParameter("date");
    if (date == null || date.isEmpty()) {
        date = LocalDate.now().toString();
    }

    double revenueIntervalDay = orderDAO.calcRevenueInterval7Days(date);
    double revenueADay = orderDAO.calcRevenueADay(date);
    double revenueAMonth = orderDAO.calcRevenueAMonth(date);
    double revenueAYear = orderDAO.calcRevenueAYear(date);

    List<Double> revenueLast7Days = orderDAO.calcRevenueLast7Days(date);
    System.out.println("Revenue Last 7 Days: " + revenueLast7Days);
    if (revenueLast7Days == null) {
        revenueLast7Days = new ArrayList<>(Collections.nCopies(7, 0.0)); // Ensure 7 zero values
    }
System.out.println("Revenue Last 7 Days: " + revenueLast7Days);
    request.setAttribute("revenueIntervalDay", revenueIntervalDay);
    request.setAttribute("revenueADay", revenueADay);
    request.setAttribute("revenueAMonth", revenueAMonth);
    request.setAttribute("revenueAYear", revenueAYear);
    request.setAttribute("revenueLast7Days", revenueLast7Days);
    request.setAttribute("selectedDate", date);

    request.getRequestDispatcher("/product/adminList.do").forward(request, response);
}


    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        CartDAO cartDAO = new CartDAO();
        ArrayList<Cart> carts = cartDAO.searchByAccount(account.getUsername());
        ArrayList<OrderDetail> orderDetails = new ArrayList();
        for (Cart cart : carts) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductId(cart.getProduct());
            orderDetail.setQuantity(cart.getQuantity());
            orderDetail.setDiscount(cart.getProduct().getDiscount());
            orderDetail.setPrice(cart.getProduct().getPrice());
            orderDetails.add(orderDetail);
        }
        orderDAO.create(account, orderDetails);
        cartDAO.emptyAll(account.getUsername());
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
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

    private void changeStatus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            String status = request.getParameter("status");
            int orderHeaderId = Integer.parseInt(request.getParameter("id"));

            // Call the DAO method to update the status
            orderDAO.changeStatus(orderHeaderId, status);

            // Redirect to the order admin list after updating
            response.sendRedirect(request.getContextPath() + "/order/ADMINlist.do");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write("Invalid order ID");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error while updating order status");
        }
    }

    private void select(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
//        Account account = new Account();
        List<Order> orders = orderDAO.selectOrderHeaderByAccountId(account.getUsername());
//        List<List<OrderDetail>> list = orderDAO.selectOrderDetail(account.getUsername());
        request.setAttribute("orders", orders);
//        request.setAttribute("list", list);
        request.setAttribute("controller", "cart");
        request.setAttribute("action", "index");
        try {
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void selectDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        int orderHeaderId = Integer.parseInt(request.getParameter("orderHeaderId"));
        List<OrderDetail> list = orderDAO.selectOrderDetailByOrderId(orderHeaderId);
        for (OrderDetail orderDetail : list) {
            System.out.println(orderDetail.getNewTotal());
        }
        request.setAttribute("list", list);
        request.setAttribute("controller", "cart");
        request.setAttribute("action", "index");
        System.out.println("hleoo");
        try {
            request.getRequestDispatcher("/cart/index.do").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void selectDetailAdmin(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        int orderHeaderId = Integer.parseInt(request.getParameter("orderHeaderId"));
        List<OrderDetail> list = orderDAO.selectOrderDetailByOrderId(orderHeaderId);
        for (OrderDetail orderDetail : list) {
            System.out.println(orderDetail.getNewTotal());
        }
        request.setAttribute("list", list);
        try {
            request.getRequestDispatcher("/order/ADMINlist.do").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
