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
import category.Category;
import category.CategoryDAO;
import java.io.File;
import product.Product;
import product.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import utils.SortByPrice;

/**
 *
 * @author PHT
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB before writing to disk
    maxFileSize = 1024 * 1024 * 10,      // Max file size: 10MB
    maxRequestSize = 1024 * 1024 * 50    // Max request size: 50MB
)
@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final AccountDAO accountDAO = new AccountDAO();
    private final CartDAO cartDAO = new CartDAO();
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
                case "list":
                    //hiện danh sach toy
                    list(request, response);
                    break;
                case "index":
                    index(request, response);
                    break;
                case "update":
                    update(request, response);
                    break;
                case "delete":
                    delete(request, response);
                    break;
                case "add":
                    add(request, response);
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
                case "addPicture":
                    addPicture(request, response);
                    break;
                case "active":
                    active(request,response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

protected void list(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {
    List<Product> products = productDAO.select();
    List<Product> list = new ArrayList<>();
    String filter = request.getParameter("filter");
    String search = request.getParameter("search");
    if (search != null){
        List<Product> searchedProduct = new ArrayList();
        for(Product product : products){
            if(product.getDescription().toLowerCase().contains(search.toLowerCase()))
                searchedProduct.add(product);
        }
        products = searchedProduct;
    }
    if(filter != null){
        if(filter.equals("lowestPrice")) Collections.sort(products, new SortByPrice.PriceComparatorAsc());
        else if(filter.equals("highestPrice")) Collections.sort(products, new SortByPrice.PriceComparatorDesc());
        request.setAttribute("lowestPrice", (filter.equals("lowestPrice")?"Checked":""));
        request.setAttribute("highestPrice", (filter.equals("highestPrice")?"Checked":""));
    }
    int totalProducts = products.size();
    int pageSize = (int) Math.ceil((double) totalProducts / 15);
    int page = Integer.parseInt((request.getParameter("page") == null) ? "1" : request.getParameter("page"));
    int startIndex = (page - 1) * 15;
    int endIndex = Math.min(page * 15, totalProducts); 

    for (int i = startIndex; i < endIndex; i++) {
        list.add(products.get(i));
    }
    request.setAttribute("filter", filter);
    request.setAttribute("search", search);
    request.setAttribute("list", list);
    request.setAttribute("total_page", pageSize);
    request.setAttribute("page", page);
    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
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
    
    protected void active(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.changeStatus(id, true);
        response.sendRedirect(request.getContextPath() + "/product/productList.do"); // Redirect to product list
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        int id = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Product newProduct = new Product();
        newProduct.setId(id);
        newProduct.setDescription(description);
        newProduct.setPrice(price);
        newProduct.setDiscount(discount);
        newProduct.setCategoryId(categoryId);
        productDAO.update(newProduct);
        System.out.println("hello");
        session.setAttribute("product", newProduct);
        request.setAttribute("message", "Update Success");
        request.setAttribute("showUpdateProductModal", true);
        request.setAttribute("controller", "product");
        request.setAttribute("action", "productList");
        response.sendRedirect(request.getContextPath() + "/product/productList.do");
    }

    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.changeStatus(id,false);
        request.setAttribute("message", "Product deleted successfully!");
        response.sendRedirect(request.getContextPath() + "/product/productList.do"); // Redirect to product list
    }

    protected void add(HttpServletRequest request, HttpServletResponse response)
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
        request.setAttribute("controller", "product");
        request.setAttribute("action", "productList");
        request.getRequestDispatcher("product/productList.do").forward(request, response);
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
        List<Category> categories = categoryDAO.selectAll();
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher(Config.ADMIN).forward(request, response);
    }
    private void addPicture(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Product product = (Product) session.getAttribute("product");
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir(); // Create directory if it doesn’t exist

        // Get the file part
        Part filePart = request.getPart("picture"); // Matches name="picture" in form
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = String.format("%d.jpg", product.getId());
            String filePath = uploadPath + File.separator + fileName;

            // Save the file
            filePart.write(filePath);
        }
        request.setAttribute("message", "Product Added Successfully!");
        response.sendRedirect(request.getContextPath() + "/product/productList.do");
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
        String action = (String) request.getAttribute("action");
        if ("addPicture".equals(action)) {
            addPicture(request, response);
        } else {
            processRequest(request, response);
        }
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
