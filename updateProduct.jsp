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
        <title>Update Product</title>
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
            if (user == null || user.getRoleID().equals("US")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <!-- Navigation-->
        <nav style="position: fixed" class="container-fluid navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Update Product</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="ListProductsController">Back To Admin Page</a></li>                                                                                               
                            </ul>
                        </li>
                    </ul>
                    <!--                    Display userName-->
                    <ul class="navbar-nav mb-2 mb-lg-0 ms-lg-4">
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


        <%
            Product product = (Product) request.getAttribute("updateProduct");
        %>
        <!--Update Form-->
        <section class="py-3">
            <div class="container px-4 px-lg-5 my-5 " style="min-height: 700px">
                <h1 class="text-center fw-bolder">Update Form</h1>
                <br>
                <div class="row justify-content-center">                    
                    <div class="col-md-5" style="border: 1px solid #ccc; border-radius: 10px;padding: 30px">
                        <form action="MainController" method="POST">
                            <input type="hidden" name="productID" value="<%=product.getProductID()%>" />
                            <div class="mb-3">                                
                                <label for="inputEmail" class="form-label fw-bolder">Product Name</label>
                                <input required="" class="form-control" type="text" name="productName" value="<%=product.getProductName()%>" />                           
                            </div>

                            <div class="mb-3">
                                <label for="inputPhone" class="form-label fw-bolder">Image URL</label>
                                <input required="" class="form-control" type="url" name="image" value="<%=product.getImage()%>" />                               
                            </div>

                            <div class="mb-3">
                                <label for="inputPhone" class="form-label fw-bolder">Price</label>
                                <input required="" class="form-control" type="text" name="price" value="<%=product.getPrice()%>" />                               
                            </div>

                            <div class="mb-3">
                                <label for="inputPhone" class="form-label fw-bolder">Quantity</label>
                                <input required="" class="form-control" type="text" name="quantity" value="<%=product.getQuantity()%>" />                              
                            </div>
                            
                            <div class="mb-3">
                                <label for="inputPhone" class="form-label fw-bolder">Import Date</label>
                                <input required="" class="form-control" type="date" name="importDate" value="<%=product.getImportDate()%>" />                              
                            </div>

                            <div class="mb-3">
                                <label for="inputPhone" class="form-label fw-bolder">Using Date</label>
                                <input required="" class="form-control" type="date" name="usingDate" value="<%=product.getUsingDate()%>" />                             
                            </div>
                            
                            <div class="mb-3">
                                <td><label class="form-label fw-bolder">Category ID</label></td>
                                <td>
                                    <select name="categoryID">
                                        <option value="r01">r01</option>
                                        <option value="c01">c01</option>
                                    </select>
                                </td>                              
                            </div>
                            
                            <div class="mb-3">
                                <td><label class="form-label fw-bolder">Status</label></td>
                                <td>
                                    <select name="status">
                                        <option value="Available">Available</option>
                                        <option value="Unavailable">Unavailable</option>
                                    </select>
                                </td>                             
                            </div>

                            <div class="mb-3">
                                <input class="form-control" type="hidden" name="action" value="Update"/>
                            </div>

                            <button type="submit" class="btn btn-success w-100">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

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
