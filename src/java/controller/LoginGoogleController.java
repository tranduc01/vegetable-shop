package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserGoogle;
import utils.GoogleUtils;

@WebServlet(name = "LoginGoogleController", urlPatterns = {"/LoginGoogleController"})
public class LoginGoogleController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LoginGoogleController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        } else {
            String accessToken = GoogleUtils.getToken(code);
            UserGoogle userGoogle = GoogleUtils.getUserInfo(accessToken);
            request.setAttribute("id", userGoogle.getId());
            request.setAttribute("name", userGoogle.getName());
            request.setAttribute("email", userGoogle.getEmail());
            request.setAttribute("LOGIN", "GG");
            request.setAttribute("userID", "user");
            request.setAttribute("password", "2");

            RequestDispatcher dis = request.getRequestDispatcher("LoginController");
            dis.forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
