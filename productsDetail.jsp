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
        <title>Product Details</title>
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
        <nav style="position: fixed" class="navbar navbar-expand-lg navbar-light bg-light container-fluid">
            <div class="container px-4 px-lg-5" >

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="/Vegetable_Shopping/ListProductsController">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="https://www.facebook.com/ThalAlone/">About</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#!">All Products</a></li>
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
                            <span class="badge bg-dark text-white ms-1 rounded-pill"> <%= cart.getCart().size() %> </span>

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

        <!-- Product section-->   
        <%Product product = (Product) request.getAttribute("product");


        %>


        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5" style="min-height: 660px">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="<%=product.getImage()%>" alt="<%=product.getProductName()%>" /></div>
                    <div class="col-md-6">
                        <div class="small mb-1">Mã sản phẩm: <%=product.getProductID()%></div>
                        <h1 class="display-5 fw-bolder"><%=product.getProductName()%></h1>
                        <div class="fs-5 mb-5">
                            <span class="fw-bolder"><%=product.getPrice()%> VND</span>
                            <br>  
                            <span style="font-size: 10pt">Tồn kho: <%=product.getQuantity()%></span>
                        </div>
                        <p class="lead"> <%=product.getProductName()%> nhà trồng, thơm ngon mời bạn mua nha, tôi đây không chờ bạn nữa giờ tôi mua liền! </p>
                        <div class="d-flex">
                            <form action="MainController">
                                <div>
                                    <input id="inputQuantity" type="number" value="1" name="quantity" style="max-width: 3rem" />
                                    <input type="hidden" name="productID" value="<%=product.getProductID()%>" />
                                    <input type="hidden" name="url" value="productsDetail.jsp" />
                                    <button name="action" value="AddToCart" type="submit">
                                        <i class="bi-cart-fill me-1"></i>
                                        Add to cart
                                    </button>

                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
<!--         Related items section
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Related products</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                             Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                             Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                     Product name
                                    <h5 class="fw-bolder">Fancy Product</h5>
                                     Product price
                                    $40.00 - $80.00
                                </div>
                            </div>
                             Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                             Sale badge
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                             Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                             Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                     Product name
                                    <h5 class="fw-bolder">Special Item</h5>
                                     Product reviews
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                     Product price
                                    <span class="text-muted text-decoration-line-through">$20.00</span>
                                    $18.00
                                </div>
                            </div>
                             Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                             Sale badge
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                             Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                             Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                     Product name
                                    <h5 class="fw-bolder">Sale Item</h5>
                                     Product price
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    $25.00
                                </div>
                            </div>
                             Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                             Product image
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                             Product details
                            <div class="card-body p-4">
                                <div class="text-center">
                                     Product name
                                    <h5 class="fw-bolder">Popular Item</h5>
                                     Product reviews
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                     Product price
                                    $40.00
                                </div>
                            </div>
                             Product actions
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>-->

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
