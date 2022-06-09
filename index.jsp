<%-- 
    Document   : index.jsp
    Created on : Mar 11, 2022, 10:08:14 PM
    Author     : tvfep
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%String name = (String) request.getAttribute("name");%>
        <%String email = (String) request.getAttribute("email");%>
        <%String googleID = (String) request.getAttribute("id");%>
        
        <h1>Hello <%=name%></h1>
        <h1>Hello <%=googleID%></h1>
        <h1>Hello <%=email%></h1>

    </body>
</html>
