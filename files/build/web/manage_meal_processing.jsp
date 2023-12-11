<%-- 
    Document   : manage_meal_processing
    Created on : 14 Nov 2023, 9:30:52 am
    Author     : Reina Althea
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Management</title>
        <style>
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('index4-bg.png');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                /* filter: blur(5px); */
                filter: blur(5px);
                
            }

            body {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 70vh;
                margin: 0;
            }     

            h1 {
                font-family: Papyrus;
                color: white;
                font-size: 100px; /* Adjust the font size as needed */
                margin-bottom: 20px;
            }
            
            h2 {
                font-family: Comic Sans MS;
                font-size: 40px; /* Adjust the font size as needed */
                margin-bottom: 5px; /* You can adjust this margin based on your preference */
                margin-top: 0; /* Reset default margin for these elements */
                color: #ff9999;
            }
            
            form input[type="submit"] {
                font-family: Comic Sans MS;
                padding: 10px 20px; /* Adjust the values as needed */
                font-size: 22px;   /* Adjust the font size as needed */
                width: 300px;
                font-style: Italic;
            }
            
            form {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="background-container"></div>
            <h1>Menu</h1>
        <jsp:useBean id="A" class="diningmanagement.employee_login" scope="session"/>
        <% // receive the values from manage_meal.html
        String v_staff_id = request.getParameter("staff_id");
        if (v_staff_id != null && !v_staff_id.isEmpty()) {
            A.staff_id = Integer.parseInt(v_staff_id);
            //debugging
//            out.println("Staff ID: " + A.staff_id);
//            out.println("manager ID: " + A.manager_id);
//            out.println("mesasge: " + A.message);
//            out.println("Status: " + A.check_employee());
            
            if (A.check_employee()) { 
        %>
                <form action="view_meal.jsp">
                    <br><input type="submit" value="View Meal">
                </form>
        
                <form action="add_meal.jsp">
                    <br><input type="submit" value="Add Meal">
                </form>
                
                <form action="delete_meal.jsp">
                    <br><input type="submit" value="Remove Meal">
                </form>
                
                <form action="index.html">
                    <br><input type="submit" value="Return to Menu">
                </form>
        <%  } else { 
        %>
            <h2>Not Authorized to Access</h2>
        <%  }
        } else {
    %>
        <h2>Invalid Staff ID</h2>
        <form action="index.html">
            <br><input type="submit" value="Return to Menu">
        </form>
    <% } %>   
    </body>
</html>
