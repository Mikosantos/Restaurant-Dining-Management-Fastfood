<%-- 
    Document   : view_order_history_processing
    Created on : Nov 16, 2023, 2:09:52 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Order History Processing</title>
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
        <form action = "index.html">
            <div class="background-container"></div>
            <h1>View Order History</h1>
            <jsp:useBean id="oh" class="diningmanagement.order_history" scope="session"/>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                    <th>Order History ID</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Price</th>
                    <th>Date</th>
                    <th>Order List</th>
                    </tr>
                    <%  oh.view_order_history();
                        for(int i = 0; i < oh.order_history_idlist.size(); i++ ) { %>
                        <tr>
                            <td><%= oh.order_history_idlist.get(i) %></td>
                            <td><%= oh.order_ratinglist.get(i) %></td>
                            <td><%= oh.order_satisfactionlist.get(i) %></td>
                            <td><%= oh.totalPricelist.get(i) %></td>
                            <td><%= oh.date_orderedlist.get(i) %></td>
                            <td><%= oh.orderlistList.get(i) %></td>
                        </tr>
                    <% } %> 
                </table>
            </div>
            <br><input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
