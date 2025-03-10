/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import account.Account;
import account.AccountDAO;
import cart.Cart;
import cart.CartDAO;
import product.Product;
import product.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
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
@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private AccountDAO accountDAO = new AccountDAO();
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
                case "list":
                    //hiện danh sach toy
                    list(request, response);
                    break;
                case "index":
                    index(request, response);
                    break;
                case "adminList":
                    select(request, response);
                    break;
                case "userList":
                    selectUser(request, response);
                    break;
                case "productList":
                    selectProduct(request, response);
                    break;
                case "cartList":
                    selectCart(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void list(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int page_size = 15;

        // Lấy số trang
        String spage = request.getParameter("page");
        int page = (spage == null) ? 1 : Integer.parseInt(spage);

        // Đọc table Product (previously named "Toy" in your comment)
        int row_count = productDAO.count();

        // Tính total_pages correctly
        int total_page = (int) Math.ceil((double) row_count / page_size);

        // Ensure page is within bounds
        if (page > total_page) {
            page = total_page; // If the page is out of range, go to the last page
        }
        if (page < 1) {
            page = 1; // Ensure page does not go below 1
        }

        // Fetch paginated products
        List<Product> list = productDAO.selectlist(page);

        request.setAttribute("page", page);
        request.setAttribute("total_page", total_page);
        request.setAttribute("list", list);

        // Cho hiện view /toy.jsp
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}


    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Product> top = productDAO.selectTop(8);
            request.setAttribute("top", top);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    protected void select(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int totalProducts = productDAO.count();
        int totalAccounts = accountDAO.count();
        List<Product> topProducts = productDAO.selectTop(4);
        List<Account> topAccounts = accountDAO.selectTop(4);
        List<Cart> topCarts = cartDAO.selectTop(4);
        
        request.setAttribute("topProducts", topProducts);
        request.setAttribute("topAccounts", topAccounts);
        request.setAttribute("topCarts", topCarts);
        request.setAttribute("totalAccounts", totalAccounts);
        request.setAttribute("totalProducts", totalProducts);

        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }
    
    protected void selectUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Account> accounts = accountDAO.select();
        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }
    
    protected void selectProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Product> products = productDAO.select();
        request.setAttribute("products", products);
        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }
    
    protected void selectCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Cart> carts = cartDAO.select();
        request.setAttribute("carts", carts);
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
