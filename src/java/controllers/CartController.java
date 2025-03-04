/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import cart.Cart;
import cart.Item;
import db.Product;
import db.ProductFacade;
import java.io.IOException;
import java.io.PrintWriter;
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
        switch (action) {
            case "index":
                //thêm item vào cart
                index(request, response);
                break;
            case "add":
                //thêm item vào cart
                add(request, response);
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
    }

    protected void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            //đọc product
            ProductFacade pf = new ProductFacade();
            Product product = pf.read(id);
            //tạo item
            Item item = new Item(product, quantity);
            //lấy cart từ session
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                //nếu trong session chưa có cart thì tạo cart mới
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            //thêm item vào cart
            cart.add(item);
            //cho hiện lại trang chủ
            request.getRequestDispatcher("/").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void empty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy cart từ session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            //nếu trong session chưa có cart thì tạo cart mới
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        //xóa cart
        cart.empty();
        //cho hiện trang /cart/index.do
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
    }
    
    protected void remove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy thông tin từ client
        int id = Integer.parseInt(request.getParameter("id"));
        //lấy cart từ session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            //nếu trong session chưa có cart thì tạo cart mới
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        //xóa cart
        cart.remove(id);
        //cho hiện trang /cart/index.do
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

}
