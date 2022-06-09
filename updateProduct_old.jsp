<%-- 
    Document   : updateProduct
    Created on : Mar 5, 2022, 5:11:48 PM
    Author     : tvfep
--%>

<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Update Here</h1>
        <form action="MainController" method="POST">
            <table>
                <%
                    Product product = (Product) request.getAttribute("updateProduct");
                %>



                <tr>
                    <td>Product ID</td>
                    <td><input type="hidden" name="productID" value="<%=product.getProductID()%>" /></td>
                </tr>
                <tr>
                    <td>Product Name</td>
                    <td><input type="text" name="productName" value="<%=product.getProductName()%>" /></td>
                </tr>
                <tr>
                    <td>Image URL</td>
                    <td><input type="url" name="image" value="<%=product.getImage()%>" /></td>
                </tr>
                <tr>
                    <td>Price</td>
                    <td><input type="text" name="price" value="<%=product.getPrice()%>" /></td>
                </tr>
                <tr>
                    <td>Quantity</td>
                    <td><input type="text" name="quantity" value="<%=product.getQuantity()%>" /></td>
                </tr>
                <tr>
                    <td>Category ID</td>
                    <td>
                        <select name="categoryID">
                            <option value="r01">r01</option>
                            <option value="c01">c01</option>
                        </select>
                    </td>

                </tr>
                <tr>
                    <td>Import Date</td>
                    <td><input type="date" name="importDate" value="<%=product.getImportDate()%>" /></td>
                </tr>
                <tr>
                    <td>Using Date</td>
                    <td><input type="date" name="usingDate" value="<%=product.getUsingDate()%>" /></td>
                </tr>
                <tr>
                    <td>Status</td>
                    <td>
                        <select name="status">
                            <option value="Available">Available</option>
                            <option value="Unavailable">Unavailable</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="action" value="Update"/></td>
                </tr>
            </table>

        </form>
    </body>
</html>
