/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import model.Product;
import dao.ProductDAO;
import dao.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "ListProductsController", urlPatterns = {"/ListProductsController"})
public class ListProductsController extends HttpServlet {

    private static final String AD = "AD";
    private static final String ADMIN_PAGE = "admin.jsp";
    private static final String US = "US";
    private static final String USER_PAGE = "shopping.jsp";

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
        String url = "error.jsp";
        List<Product> listProducts = new ArrayList<>();
        final int PAGE_SIZE = 8;
        HttpSession session = request.getSession();
        String checkSearch = (String)request.getAttribute("checkSearch");
        try {
            //---Get all products
            ProductDAO productDao = new ProductDAO();
            //---
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String roleID = loginUser.getRoleID();
            if (AD.equals(roleID)) {
                listProducts = productDao.getAllProductsAdmin();

                request.setAttribute("listProducts", listProducts);
                url = ADMIN_PAGE;
            } else if (US.equals(roleID)) {
//                listProducts = new ProductDAO().getAllProducts();
                int page = 1;
                String pageStr = request.getParameter("page");
                if (pageStr != null) {
                    page = Integer.parseInt(pageStr);
                }

                listProducts = productDao.getAllProductsUSPagging(page, PAGE_SIZE);
                int totalProducts = productDao.getTotalProducts();
                int totalPage = (totalProducts / PAGE_SIZE);
                if(totalProducts % PAGE_SIZE != 0){
                    totalPage += 1;
                }                                
                
                List<Product> listSearch = (List<Product>)request.getAttribute("listSearch");
                
                if(checkSearch != null){
                    request.setAttribute("listProducts", listSearch);
                }else{
                    request.setAttribute("listProducts", listProducts);
                }
                
                request.setAttribute("page", page);
                request.setAttribute("totalPage", totalPage);
                
                url = USER_PAGE;
            } else {
                request.setAttribute("ERROR", "Your role is not support!");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ListProductsController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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
