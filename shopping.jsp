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
        <title>Web này bán rau</title>
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
            int totalPage = (Integer) request.getAttribute("totalPage");
            int currentPage = (Integer) request.getAttribute("page");
        %>
        <!-- Navigation-->
        <nav style="position: fixed; z-index: 2" class="container-fluid navbar navbar-expand-lg navbar-light bg-light ">
            <div class="container px-4 px-lg-5">

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="/Vegetable_Shopping/ListProductsController">Home</a></li>
                        <li class="nav-item"><a class="nav-link" target="blank" href="https://www.facebook.com/ThalAlone/">About</a></li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/Vegetable_Shopping/ListProductsController">Tất cả sản phẩm</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="#">Rau xanh</a></li>
                                <li><a class="dropdown-item" href="#">Củ quả</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form action="MainController" class="d-flex" method="POST">
                        <input class="form-control me-2" type="text" name="search" placeholder="Search" />                        
                        <input class="btn btn-outline-success" type="submit" name="action" value="Search"></input>
                    </form>
                    <form class="d-flex">
                        <a href="cart.jsp" class="btn btn-outline-dark ms-2">
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
                                <li><a  class="dropdown-item" href="LogoutController">Đăng Xuất</a></li>
                            </ul>
                        </li>                        
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Header-->
        <!--        <header  class="bg-dark py-5">
                    <div class="container px-4 px-lg-5 my-5">
                        <div class="text-center text-white">
                            <h1 class="display-4 fw-bolder">Shop bán bánh hàng đầu Việt Nam</h1>
                            <p class="lead fw-normal text-white-50 mb-0">Bánh gì cũng có, chất lượng trên cả tuyệt vời.</p>
                        </div>
                    </div>
                </header>-->
        <div style="padding-top: 30px">
            <img class="container-fluid " src="https://i.ibb.co/gJ33MNw/Xanh-l-T-p-trung-v-o-video-Tr-i-c-y-v-Rau-c-D-ch-v-tr-c-tuy-n-T-p-h-a-nh-b-a-Facebook-3.png" />
        </div>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row">
                    
                    <div class="col-md-12">
                        <h3 class="text-center" style="margin-bottom: 30px">List Products</h3>
                        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                            <% List<Product> listProducts = (List) request.getAttribute("listProducts");
                                for (int i = 0; i < listProducts.size(); i++) {
                            %>

                            <div class="col mb-5">
                                <div class="card h-100">
                                    <!-- Sale badge-->
                                    <!--                                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>-->
                                    <!-- Product image-->
                                    <a href="DetailController?productID=<%=listProducts.get(i).getProductID()%>">                                                                            
                                        <img class="card-img-top" src="<%=listProducts.get(i).getImage()%>" alt="Hình đẹp" />
                                    </a>
                                    <!-- Product details-->
                                    <div class="card-body p-4">
                                        <div class="text-center">
                                            <!-- Product name-->
                                            <h5 class="fw-bolder"><%=listProducts.get(i).getProductName()%></h5>
                                            <!-- Product price-->
                                            <span style="color: black"> <%=listProducts.get(i).getPrice()%> VND</span>                                            
                                        </div>
                                    </div>
                                    <!-- Product actions-->
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                        <div class="text-center">
                                            <!--                                            <input id="inputQuantity" type="number" value="1" name="quantity" style="max-width: 3rem" />-->
                                            <form action="MainController">                                               

                                                <input type="hidden" name="productID" value="<%=listProducts.get(i).getProductID()%>"/>
                                                <input type="hidden" name="quantity" value="1" />
                                                <input type="hidden" name="url" value="shoppingHome" />
                                                <input type="hidden" name="action" value="AddToCart" />

                                                <button class="btn btn-outline-dark mt-auto" type="submit" >Add to cart</button>  
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%                    }
                            %>
                        </div>


<!--                        Pagging-->
                        <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                            <ul class="pagination">

                                <!--                                bam previous-->

                                <%if (currentPage <= 1) {
                                %>
                                <li class="page-item disabled"> <a class="page-link ">Previous</a> </li>
                                    <%
                                    } else {
                                    %>
                                <li class="page-item"> <a class="page-link" href="ListProductsController?page=<%=currentPage - 1%>">Previous</a> </li>

                                <%
                                    }
                                %>

                                <!--                                chia tong trang-->

                                <%for (int i = 1; i <= totalPage; i++) {
                                %>
                                <li class="page-item <%= i == currentPage ? "active" : ""%>  "><a class="page-link" href="ListProductsController?page=<%=i%>"> <%=i%> </a></li>
                                    <%
                                        }
                                    %>

                                <!--                                bam next-->
                                <%if (currentPage >= totalPage) {
                                %>
                                <li class="page-item disabled"> <a class="page-link">Next</a> </li>

                                <%
                                } else {
                                %>
                                <li class="page-item"> <a class="page-link " href="ListProductsController?page=<%=currentPage + 1%>">Next</a> </li>

                                <%
                                    }
                                %>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Nguyen Minh Thai - SE151054</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="jsa/scripts.js"></script>

    </body>
</html>
