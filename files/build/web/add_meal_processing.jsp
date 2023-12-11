<%-- 
    Document   : add_meal_processing
    Created on : 14 Nov 2023, 6:38:58 pm
    Author     : Rhazelle Joy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Meal Processing</title>
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
        <h1>Add Meal</h1>
        <div class="background-container"></div>
        
            <jsp:useBean id="M" class="diningmanagement.meals" scope="session"/>
            <% //get info from add_meal.jsp
                String v_meal_name = request.getParameter("meal_name");
                String v_meal_category = request.getParameter("meal_category");
                String v_meal_price = request.getParameter("meal_price");
                String v_meal_description = request.getParameter("meal_description");
                String v_meal_type = request.getParameter("meal_type");

                M.meal_name = v_meal_name;
                M.meal_category = v_meal_category;
                M.meal_price = Float.parseFloat(v_meal_price);
                M.meal_description = v_meal_description;
                M.meal_type = v_meal_type;

                if(M.add_meal()) {
            %>
                <h2>Adding of Meal Successful!</h2><br>
                <form action="update_meal_ingredients.jsp">
                    <input type="submit" value="Ingredients Addition">
                </form>
                
                <form action="index.html">
                    <br><input type="submit" value="Return to Menu">
                </form>
            <% } else { %>
                <h2>Adding of Meal Failed!</h2><br>
                <form action="index.html">
                    <input type="submit" value="Return to Menu">
                </form>
            <% } 
            %>
            
    </body>
</html>
