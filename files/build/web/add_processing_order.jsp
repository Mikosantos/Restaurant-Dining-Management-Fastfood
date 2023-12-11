<%-- 
    Document   : newjsp
    Created on : Nov 17, 2023, 5:04:23 PM
    Author     : YES
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
                height: 80vh;
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
            
            p {
                margin: 0;  /* Set margin to zero */
                padding: 0; /* Set padding to zero */
            }
        </style>
    </head>
    <body>
        <div class="background-container"></div>
        <h1>Add Order Transaction</h1>
            <jsp:useBean id="O" class="diningmanagement.Order" scope="session"/>
            <jsp:useBean id="C" class="diningmanagement.Customer" scope="session"/>
            <jsp:useBean id="TM" class="diningmanagement.TransactionMeal" scope="session"/>
            
            <% //get info from add_meal.html
                C.addCustomer();
                O.customer_id = C.getLatestCustomer();
                String[] v_meal_Ids = request.getParameterValues("mealId");
                String[] v_quantities_ = request.getParameterValues("quantity");
                boolean orderTransactionAdded = true;
                
                if (O.addOrder()) {
                    out.println("<p>Order transaction added for meal ID </p>");
                } else {
                    out.println("<p>Failed to add Order transaction for meal ID </p>");
                    orderTransactionAdded = false;  // Set flag to false
                }
                boolean mealTransactionAdded = true;  // Flag to track meal transaction status
                int transaction = (O.getLatestTransactionId()); //get latest + 1
                for (int i = 0; i < v_meal_Ids.length; i++) {
                    int mealId = Integer.parseInt(v_meal_Ids[i]);
                    int quantity = Integer.parseInt(v_quantities_[i]); // Corrected from v_meal_Ids[i]s
                    TM.transactionId = transaction;
                    TM.mealId = mealId;
                    TM.quantity = quantity;

                    if (TM.addTransactionMeal()) {
                        out.println("<p>Meal transaction added for meal ID: " + mealId + "</p>");
                    } else {
                        out.println("<p>Failed to add meal transaction for meal ID: " + mealId + "</p>");
                        mealTransactionAdded = false;  // Set flag to false
                    }
                }
                if(orderTransactionAdded == true && mealTransactionAdded == true) { 
                    out.println("<h2>Your Transaction ID is: " + transaction + "</h2>");
                %>
                    <form action="viewSpecificTransactionMeal.jsp">
                        <input type="submit" value="View Orders">
                    </form>
                <% } else { %>
                    <h2>Adding of transaction Failed!</h2>
                    <form action="index.html">
                        <input type="submit" value="Return to Menu">
                    </form>
            <% } 
            %>
    </body>
</html>


