/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ProductDAO;
import dao.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.ProductError;
import utils.RandomID;
import utils.SendMail;

/**
 *
 * @author tvfep
 */
@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

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
        try {
//            ProductError errorProduct = new ProductError();
            LinkedHashMap<String, String> errorProduct = new LinkedHashMap<>();
            HttpSession session = request.getSession();
            RandomID rd = new RandomID();
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            ProductDAO productDAO = new ProductDAO();
            boolean checkquantity = true;
            int quantityLeft = 0;

            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            String orderID = null;
            //Check duplicated OrderID
            while (true) {
                orderID = "ORD" + rd.getARandomID();
                if (!orderDAO.checkDuplicate(orderID)) {
                    break;
                }
            }

            String userID = user.getUserID();
            long millis = System.currentTimeMillis();
            java.sql.Date orderDate = new java.sql.Date(millis);
            String status = "Available";

            Cart cart = (Cart) session.getAttribute("CART");

            if (cart != null) {
                double total = 0;
                for (Product c : cart.getCart().values()) {
                    quantityLeft = productDAO.getProductQuantity(c.getProductID());
                    if (quantityLeft < c.getQuantity()) {
                        errorProduct.put(c.getProductID(), "There are only " + quantityLeft + " left!");
                        checkquantity = false;
                    }
                    total += c.getPrice() * c.getQuantity();
                }
                if (checkquantity) {
                    //          Create Order            
                    Order order = new Order(orderID, orderDate, total, userID, status);
                    boolean checkOrder = orderDAO.createOrder(order);

                    //          Create OrderDetails                      
                    boolean checkOrderDetail = orderDetailDAO.createOrderDetails(orderID, cart);

                    if ((checkOrder == true) && (checkOrderDetail == true)) {
                        url = "ThanksController";
                        for (Product c : cart.getCart().values()) {
                            boolean checkUpdate = productDAO.updateProductQuantity(c.getProductID(), c.getQuantity());
                            if (checkUpdate) {
                                session.removeAttribute("CART");

                                //Get user Information
                                String address = user.getAddress();
                                String phone = user.getPhone();
                                String fullName = user.getFullName();
                                String email = user.getEmail();

                                //send order to email
                                SendMail sendEmail = new SendMail();
                                sendEmail.sendOrder(fullName, phone, address, orderID, email);
                            } else {
                                url = "error.jsp";
                            }
                        }
                    }

                } else {
                    request.setAttribute("ERROR_PRODUCT", errorProduct);
                    url = "checkOut.jsp";
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(CheckOutController.class.getName()).log(Level.SEVERE, null, ex);
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
