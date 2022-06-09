/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import model.Product;
import dao.ProductDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.UserDTO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String SUCCESS = "ListProductsController";

//    private static final String AD = "AD";
//    private static final String ADMIN_PAGE = "admin.jsp";
//    private static final String US = "US";
//    private static final String USER_PAGE = "shopping.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        String gg = "GG";
        try {
            String checkGG = (String) request.getAttribute("LOGIN");
            String userID = "";
            String password = "";
            if (checkGG != null && gg.equals(checkGG)) {
                userID = (String) request.getAttribute("userID");
                password = (String) request.getAttribute("password");
            } else {
                userID = request.getParameter("userID");
                password = request.getParameter("password");
            }
            UserDAO dao = new UserDAO();
            UserDTO loginUser = dao.checkLogin(userID, password);
            if (loginUser != null) {
                HttpSession session = request.getSession();
                session.setAttribute("LOGIN_USER", loginUser);
//                String roleID = loginUser.getRoleID();
                //phan quyen
//                if(AD.equals(roleID)){
//                    url= ADMIN_PAGE;
//                }else if(US.equals(roleID)){
//                    url = USER_PAGE;
//                }else{
//                    request.setAttribute("ERROR", "Your role is not support!");
//                }
                url = SUCCESS;
            } else {
                request.setAttribute("ERROR", "Incorrect Username or Password!");
            }

        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
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
