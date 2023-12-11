<%-- 
    Document   : viewSpecificTransactionMeal
    Created on : 19 Nov 2023, 6:15:16 pm
    Author     : Reina Althea
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Orders</title>
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
        
        h3 {
                font-family: Comic Sans MS;
                font-size: 20px; /* Adjust the font size as needed */
                margin-bottom: 5px; /* You can adjust this margin based on your preference */
                margin-top: 0; /* Reset default margin for these elements */
                color: #99ff66;
                text-align: center;
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
    <div class="background-container"></div>
    <h1>View Orders</h1>
        <jsp:useBean id="C" class="diningmanagement.Customer" scope="session"/>
        <jsp:useBean id="TM" class="diningmanagement.TransactionMeal" scope="session"/>
        <jsp:useBean id="O" class="diningmanagement.Order" scope="session"/>
        <jsp:useBean id="MI" class="diningmanagement.meal_ingredient" scope="session"/>

        <%  
            O.customer_id = C.getLatestCustomer();
            TM.transactionId = O.getCustomerTransactionId();
            TM.viewTransactionMeals();
        %>
        <div class="scrollable-table">
            <%  
                for (int i = 0; i < TM.transactionMeal_idlist.size(); i++) {
            %>
                <div>
                    <table border="1">
                        <tr>
                            <th>Transaction Meal ID</th>
                            <th>Transaction ID</th>
                            <th>Meal ID</th>
                            <th>Meal Name</th>
                            <th>Quantity Ordered</th>
                        </tr> 
                        <tr>
                            <td><%= TM.transactionMeal_idlist.get(i) %></td>
                            <td><%= TM.transaction_idlist.get(i) %></td>
                            <td><%= TM.meal_idlist.get(i) %></td>
                            <td><%= TM.meal_namelist.get(i) %></td>
                            <td><%= TM.quantitylist.get(i) %></td>
                        </tr>
                    </table>

                    <%  
                        TM.mealId = TM.meal_idlist.get(i);
                        TM.transactionMealId = TM.transactionMeal_idlist.get(i);   
                        if(TM.isStock()) { %>
                            <h3>Ingredients in Stock!</h3><br>  
                    <% } else { %>
                        <h3>Ingredients Out of Stock!</h3><br>
                            <% TM.toBeDeletedTransactionMealId.add(TM.transactionMealId); 
                        } %>
                </div>
            <% } %> 
            <%  for(int i = 0; i < TM.toBeDeletedTransactionMealId.size(); i++) {
                    TM.transactionMealId = TM.toBeDeletedTransactionMealId.get(i);
                    
                    TM.deleteTransactionMeal();
                }
                if(TM.transactionMeal_idlist.size() > 0) { %>
                    <form action="operate_payment_processing.jsp">
                        <br><input type="submit" value="Proceed to Payment">
                    </form>
            <% } else { %>
                <h3>No active orders. Head back to the main menu.</h3>
                <form action="index.html">
                    <br><input type="submit" value="Return to Menu">
                </form>
            <% } %>
        </div>
</body>
</html>

