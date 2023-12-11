<%-- 
    Document   : view_ingredients
    Created on : 15 Nov 2023, 12:59:48 pm
    Author     : Reina Althea
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Ingredients</title>
        <style>
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('view-bg.png');
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
            
            form input[type="submit"] {
                font-family: Comic Sans MS;
                padding: 10px 20px; /* Adjust the values as needed */
                font-size: 20px;   /* Adjust the font size as needed */
                width: 250px;
                font-style: Italic;
            }
            form {
                text-align: center; /* Optional: Align form content to center within the form */
            }
            
            table{
                margin: 0 auto;
                font-size: 22px;
                color: white;
            }
            
            .scrollable-table {
                max-height: 410px; /* Set a maximum height for the scrollable area */
                overflow-y: auto; /* Enable vertical scrollbar if needed */
            }
            
        </style>
    </head>
    <body>
        <form action="index.html">
            <div class="background-container"></div>
            <h1>View Meals</h1>
            <jsp:useBean id="M" class="diningmanagement.meals" scope="session"/>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Type</th>
                    </tr>
                    <%  M.view_meals();
                        for(int i = 0; i < M.meal_idlist.size(); i++ ) { %>
                        <tr>
                            <td><%= M.meal_idlist.get(i) %></td>
                            <td><%= M.meal_namelist.get(i) %></td>
                            <td><%= M.meal_categorylist.get(i) %></td>
                            <td><%= M.meal_pricelist.get(i) %></td>
                            <td><%= M.meal_descriptionlist.get(i) %></td>
                            <td><%= M.meal_typelist.get(i) %></td>
                        </tr>
                    <% } %> 
                </table>
            </div>    
            <br><input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
