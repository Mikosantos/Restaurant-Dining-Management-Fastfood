<%-- 
    Document   : orderhistory_processing
    Created on : 18 Nov 2023, 12:49:39 pm
    Author     : gaby arco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Rating</title>
    <style>
        .background-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background-image: url('rating-bg.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            /* filter: blur(5px); */
            filter: blur(0px);

        }

        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            color: white;
            height: 60vh;
            margin: 0;
        }     

        h1 {
            font-family: Papyrus;
            color: white;
            font-size: 70px; /* Adjust the font size as needed */
            margin-bottom: 20px;
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
        
        form button {
            font-family: Comic Sans MS;
            padding: 8px 15px;
            font-size: 14px;
            background-color: #66ff66; /* Red background color, adjust as needed */
            color: #000000; /* White text color */
            border: none;
            cursor: pointer;
        }

        form button:hover {
            background-color: #33cc00;
        }
        
        form select {
            font-size: 18px; /* Adjust the font size as needed */
            padding: 10px;   /* Adjust the padding to increase the height of each option */
            width: 100px;    /* Adjust the width of the dropdown */
        }
    </style>
    </head>
    <body>
        <div class="background-container"></div>
        <h1>Order Rating</h1>
        <form action="index.html">
        <%-- Create an instance of the Payment class --%>
        <jsp:useBean id="oh" class="diningmanagement.order_history" scope="session"/>
        <jsp:useBean id="payment" class="diningmanagement.Payment" scope="session"/>
        <jsp:useBean id="TM" class="diningmanagement.TransactionMeal" scope="session"/>
        <jsp:useBean id="C" class="diningmanagement.Customer" scope="session"/>
        <jsp:useBean id="O" class="diningmanagement.Order" scope="session"/>
        <jsp:useBean id="IDM" class="diningmanagement.IngredientDeductionManager" scope="session"/>
        <%
            String ratingStr = request.getParameter("rating");
            
            float rating = Float.parseFloat(ratingStr);
            oh.order_rating = rating;
            
            if (oh.order_rating == 5.0){
                oh.order_satisfaction = "Very Satisfied";
            } 
            if (oh.order_rating == 4.0){
                oh.order_satisfaction = "Satisfied";
            }
            if (oh.order_rating == 3.0){
                oh.order_satisfaction = "OK";
            }
            if (oh.order_rating == 2.0){
                oh.order_satisfaction = "Not Satisfied";
            }
            if (oh.order_rating == 1.0){
                oh.order_satisfaction = "Disatisfied";
            }
           
            O.customer_id = C.getLatestCustomer();
            payment.transaction_id = O.getCustomerTransactionId();
            payment.getCurrentRecords();
            oh.totalPrice = payment.totalDue;
            
            oh.order_transaction_id = O.getCustomerTransactionId();
            if(oh.add_orderhistory()) {
                IDM.processIngredientDeduction(oh.getRecentOrderHistory()); %>
                <h2>Order Completed!</h2>
            <% } else { 
                    out.println(" "+ oh.order_history_id+" "+ oh.order_rating + " " + oh.order_satisfaction + " " + oh.totalPrice + " " + oh.date_ordered + " " + oh.order_transaction_id);
            %>
                <h2>Rating Failed!</h2>
            <% } 
         %>
        <input type="submit" value="Return to Menu">
    </form>
    </body>
</html>
