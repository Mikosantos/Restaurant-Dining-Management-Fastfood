<%-- 
    Document   : add_ingredient_processing
    Created on : 14 Nov 2023, 9:54:17 pm
    Author     : Rhazelle Joy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Meal Ingredient</title>
        <style>
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('login-bg.png');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                /* filter: blur(5px); */
                filter: blur(3px);
                
            }

            body {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                font-size: 30px;
                color: white;
                height: 70vh;
                margin: 0;
            }     

            h1 {
                font-family: Papyrus;
                color: white;
                font-size: 70px; /* Adjust the font size as needed */
                margin-bottom: 20px;
            }
            
            h2 {
                font-family: Comic Sans MS;
                font-size: 40px; /* Adjust the font size as needed */
                margin-bottom: 5px; /* You can adjust this margin based on your preference */
                margin-top: 0; /* Reset default margin for these elements */
                color: green;
            }
            
            form input[type="text"] {
                width: 200px; /* Adjust the width as needed */
                padding: 5px 10px; /* Add padding to make it visually appealing */
                font-size: 18px; /* Adjust the font size as needed */
            }
            
            form input[type="submit"] {
                font-family: Comic Sans MS;
                padding: 5px 5px; /* Adjust the values as needed */
                font-size: 16px;   /* Adjust the font size as needed */
                width: 200px;
                font-style: Italic;
            }
            
            form {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Update Meal Ingredient</h1>
        <div class="background-container"></div>
            <jsp:useBean id="MI" class="diningmanagement.meal_ingredient" scope="session"/>
            <% //get info from update_meal_ingredients.jsp
                String v_meal_id = request.getParameter("meal_id");
                String v_ingredient_id = request.getParameter("ingredient_id");
                String v_quantity_used = request.getParameter("quantityUsed");

                MI.meal_id = Integer.parseInt(v_meal_id);
                MI.ingredient_id = Integer.parseInt(v_ingredient_id);
                MI.quantity_used = Integer.parseInt(v_quantity_used);

                if(MI.add_meal_ingredient()) {
            %>
            <h2>Updating Meal Ingredient Successful</h2><br>
            <% // Invalidate the session and redirect
                session = request.getSession();
                session.invalidate(); %>
                <form action="update_meal_ingredients.jsp">
                    <input type="submit" value="Ingredients Addition">
                </form>
            
                <form action="index.html">
                    <br><input type="submit" value="Return to Menu">
                </form>
            <% } else { %>
            <h2>Updating Meal Ingredient Failed</h2><br>
                <form action="index.html">
                    <br><input type="submit" value="Return to Menu">
                </form>
            <% } 
            %>
    </body>
</html>
