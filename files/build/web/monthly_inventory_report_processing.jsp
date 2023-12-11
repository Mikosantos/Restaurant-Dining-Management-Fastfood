<%-- 
    Document   : monthly_inventory_report_processing
    Created on : Nov 16, 2023, 1:33:05 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Monthly Inventory Report</title>
    </head>
        <style>
                .background-container {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    z-index: -1;
                    background-image: url('viewSales-bg.png');
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
                    height: 80vh;
                    margin: 0;
                }     

                h1 {
                    font-family: Papyrus;
                    color: white;
                    font-size: 50px; /* Adjust the font size as needed */
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
    <body>
        <form action="index.html">
            <div class="background-container"></div>
            <h1>Monthly Inventory Report</h1>
            <jsp:useBean id="ing" class="diningmanagement.ingredients" scope="session"/>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Quantity Used</th>
                    </tr>
                    <%  ing.generate_ingredients_report();
                        for(int i = 0; i < ing.ingredient_idlist.size(); i++ ) 
                        { %>
                        <tr>
                            <td><%= ing.ingredient_idlist.get(i) %></td>
                            <td><%= ing.ingredient_namelist.get(i) %></td>
                            <td><%= ing.ingredient_descriptionlist.get(i) %></td>
                            <td><%= ing.quantitylist.get(i) %></td>
                        </tr>
                    <% } %> 
                </table>
            </div>  
            <br><input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
