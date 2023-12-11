<%-- 
    Document   : add_ingredient_processing
    Created on : 14 Nov 2023, 9:54:17 pm
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
                font-size: 70px; 
                margin-bottom: 20px;
            }
            
            h2 {
                font-family: Comic Sans MS;
                font-size: 40px; 
                margin-bottom: 5px; 
                margin-top: 0; 
                color: green;
            }
            
            form input[type="text"] {
                width: 200px; 
                padding: 5px 10px; 
                font-size: 18px; 
            }
            
            form input[type="submit"] {
                font-family: Comic Sans MS;
                padding: 5px 5px; /* Adjust the values as needed */
                font-size: 16px;   /* Adjust the font size as needed */
                width: 250px;
                font-style: Italic;
            }
            
            form {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Add Ingredient</h1>
        <div class="background-container"></div>
            <jsp:useBean id="I" class="diningmanagement.ingredients" scope="session"/>
            <% //get info from add_ingredient.html
                String v_ingredient_name = request.getParameter("ingredient_name");
                String v_ingredient_description = request.getParameter("ingredient_description");
                String v_quantity = request.getParameter("quantity");
                
                I.ingredient_name = v_ingredient_name;
                I.ingredient_description = v_ingredient_description;
                I.quantity = Integer.parseInt(v_quantity);

                if(I.add_ingredients()) {
            %>
            <h2>Adding of Ingredient Successful!</h2><br>
                <form action="index.html">
                    <br><input type="submit" value="Return to Menu">
                </form>
            <% } else { %>
            <h2>Adding of Ingredient Failed!</h2><br>
                <form action="index.html">
                    <input type="submit" value="Return to Menu">
                </form>
            <% } 
            %>
    </body>
</html>
