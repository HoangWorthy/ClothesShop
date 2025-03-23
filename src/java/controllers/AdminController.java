/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import account.Account;
import account.AccountDAO;
import category.Category;
import category.CategoryDAO;
import java.io.File;
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
import javax.servlet.http.Part;
import order.Order;
import order.OrderDAO;
import order.OrderDetail;
import product.Product;
import product.ProductDAO;

/**
 *
 * @author PC
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final AccountDAO accountDAO = new AccountDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final String UPLOAD_DIR = "pics/products";

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
                case "dashboard":
                    showDashboard(request, response);
                    break;
                case "productList":
                    showProductList(request, response);
                    break;
                case "orderList":
                    showOrderList(request, response);
                    break;
                case "orderDetail":
                    showOrderDetails(request, response);
                    break;
                case "revenue":
                    getRevenue(request, response);
                    break;
                case "changeOrderStatus":
                    changeStatus(request, response);
                    break;
                case "deleteProduct":
                    deleteProduct(request, response);
                    break;
                case "updateProduct":
                    updateProduct(request, response);
                    break;
                case "activeProduct":
                    activeProduct(request, response);
                    break;
                case "addProductPicture":
                    addPicture(request, response);
                    break;
                case "addProduct":
                    addProduct(request, response);
                    break;
                case "userList":
                    getUser(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int totalProducts = productDAO.count();
        int totalAccounts = accountDAO.count();

        List<Product> topProducts = productDAO.selectTop(4);
        List<Account> topAccounts = accountDAO.selectTop(4);
        List<Order> topOrders = orderDAO.selectTop(4);

        request.setAttribute("topProducts", topProducts);
        request.setAttribute("topAccounts", topAccounts);
        request.setAttribute("topOrders", topOrders);
        request.setAttribute("totalAccounts", totalAccounts);
        request.setAttribute("totalProducts", totalProducts);

        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }

    protected void showProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Product> products = productDAO.select();
        List<Category> categories = categoryDAO.selectAll();
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }

    protected void showOrderList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Order> orders = orderDAO.selectAll();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }

    private void showOrderDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int orderHeaderId = Integer.parseInt(request.getParameter("orderHeaderId"));
        List<OrderDetail> list = orderDAO.selectOrderDetailByOrderId(orderHeaderId);
        request.setAttribute("list", list);
        try {
            request.getRequestDispatcher("/admin/orderList.do").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        if (revenueLast7Days == null) {
            revenueLast7Days = new ArrayList<>(Collections.nCopies(7, 0.0)); // Ensure 7 zero values
        }
        request.setAttribute("revenueIntervalDay", revenueIntervalDay);
        request.setAttribute("revenueADay", revenueADay);
        request.setAttribute("revenueAMonth", revenueAMonth);
        request.setAttribute("revenueAYear", revenueAYear);
        request.setAttribute("revenueLast7Days", revenueLast7Days);
        request.setAttribute("selectedDate", date);

        request.getRequestDispatcher("/admin/dashboard.do").forward(request, response);
    }

    private void changeStatus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            String status = request.getParameter("status");
            int orderHeaderId = Integer.parseInt(request.getParameter("id"));

            // Call the DAO method to update the status
            orderDAO.changeStatus(orderHeaderId, status);

            // Redirect to the order admin list after updating
            response.sendRedirect(request.getContextPath()+"/admin/orderList.do");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write("Invalid order ID");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error while updating order status");
        }
    }

    protected void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        int id = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        Product newProduct = new Product();
        newProduct.setId(id);
        newProduct.setDescription(description);
        newProduct.setPrice(price);
        newProduct.setDiscount(discount);
        newProduct.setCategoryId(categoryId);
        newProduct.setStatus(status);
        productDAO.update(newProduct);
        session.setAttribute("product", newProduct);
        request.setAttribute("message", "Update Success");
        request.setAttribute("showUpdateProductModal", true);
        request.getRequestDispatcher("/admin/productList.do").forward(request, response);
    }
    protected void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.changeStatus(id, false);
        request.setAttribute("message", "Product deleted successfully!");
        response.sendRedirect(request.getContextPath()+"/admin/productList.do");
    }
    
    protected void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();

        String description = request.getParameter("description");
        Double price = Double.parseDouble(request.getParameter("price"));
        Double discount = Double.parseDouble(request.getParameter("discount"));
        int categoryId = Integer.parseInt(request.getParameter("category"));

        Product newProduct = new Product();
        newProduct.setDescription(description);
        newProduct.setPrice(price);
        newProduct.setDiscount(discount);
        newProduct.setCategoryId(categoryId);

        int id = productDAO.insert(newProduct);
        newProduct.setId(id);
        session.setAttribute("product", newProduct);
        request.setAttribute("message", "Product Added Successfully!");
        request.setAttribute("showAddProductPictureModal", true);
        request.getRequestDispatcher("/admin/productList.do").forward(request, response);
    }
        
    private void addPicture(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Product product = (Product) session.getAttribute("product");
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // Create directory if it doesn’t exist
        }
        // Get the file part
        Part filePart = request.getPart("picture"); // Matches name="picture" in form
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = String.format("%d.jpg", product.getId());
            String filePath = uploadPath + File.separator + fileName;

            // Save the file
            filePart.write(filePath);
        }
        response.sendRedirect(request.getContextPath()+"/admin/productList.do");
    }
    
    protected void activeProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.changeStatus(id, true);
        response.sendRedirect(request.getContextPath() + "/admin/productList.do"); // Redirect to product list
    }
    
    protected void getUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Account> accounts = accountDAO.select();
        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
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
