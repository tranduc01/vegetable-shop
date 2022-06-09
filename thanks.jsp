<%-- 
    Document   : shopping
    Created on : Mar 3, 2022, 3:07:25 PM
    Author     : tvfep
--%>

<%@page import="model.Cart"%>
<%@page import="dao.UserDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Thank You （づ￣3￣）づ╭❤️～</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || user.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }

            Cart cart = (Cart) session.getAttribute("CART");
        %>
        <!-- Navigation-->
        <nav style="position: fixed" class="container-fluid navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Your Cart</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/Vegetable_Shopping/ListProductsController">Back to Homepage.</a></li>
                                <li><a class="dropdown-item" href="CheckOutController">Checkout</a></li>                                                                                               

                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="https://www.facebook.com/ThalAlone/">About</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/Vegetable_Shopping/ListProductsController">All Products</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="error.jsp">Popular Items</a></li>
                                <li><a class="dropdown-item" href="error.jsp">New Arrivals</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form action="MainController" class="d-flex">
                        <input class="form-control me-2" type="text" name="search" placeholder="Search" />                        
                        <input class="btn btn-outline-success" type="submit" name="action" value="Search"></input>
                    </form>
                    <form class="d-flex">
                        <a href="cart.jsp" class="btn btn-outline-dark ms-2" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            Cart
                            <%
                                if (cart != null) {
                            %>
                            <span class="badge bg-dark text-white ms-1 rounded-pill"> <%= cart.getCart().size()%> </span>

                            <%
                            } else {

                            %>
                            <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                            <%                                }
                            %>
                        </a>
                    </form>


                    <!--                    Display userName-->
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><%=user.getFullName()%></a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">                               
                                <li><a  class="dropdown-item" href="MainController?action=Logout">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                    <!--                    <body onload="showAlert()">-->
                </div>
            </div>
        </nav>


        <!--Thanks--> 
        <div style="padding-top: 100px">
            <div  class="text-center" style="min-height: 720px; margin-top:30px; font-family: monospace">
                <h1 class="text-center">Thank you for shopping with us（づ￣3￣）づ╭❤️～!</h1>
                <a href="/Vegetable_Shopping/ListProductsController" class="btn btn-outline-success mt-2">Still wanna buy something?</a>
            </div>
        </div>


        <!-- Footer-->
        <footer class="py-5" style="background-color: black">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Nguyen Minh Thai - SE151054</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="jsa/scripts.js"></script>

    </body>
</html>
