<%-- 
    Document   : payment_processing
    Created on : Nov 17, 2023, 11:49:46 PM
    Author     : polar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.Payment" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Operate Payment</title>
    <style>
        .background-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background-image: url('payment-bg.png');
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
            height: 70vh;
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
    </style>
</head>
<body>
    <div class="background-container"></div>
    <h1>Operate Payment</h1>
        <%-- Create an instance of the Payment class --%>
        <jsp:useBean id="payment" class="diningmanagement.Payment" scope="session"/>
        <jsp:useBean id="TM" class="diningmanagement.TransactionMeal" scope="session"/>
        <jsp:useBean id="C" class="diningmanagement.Customer" scope="session"/>
        <jsp:useBean id="O" class="diningmanagement.Order" scope="session"/>
        <%
            String transactionIdStr = request.getParameter("hiddenTransactionId");
            String totalDueStr = request.getParameter("hiddenTotalDue");
            String cashStr = request.getParameter("cash");
            
            float a = Float.parseFloat(totalDueStr);
            float b = Float.parseFloat(cashStr);
            
            String amountChangeStr = String.valueOf(b-a);
            String authorizingEmployeeIdStr = request.getParameter("hiddenAuthorizingEmployeeId");
            
//            out.println("Debugging: Transaction ID - " + transactionIdStr);
//            out.println("Debugging: Total Due - " + totalDueStr);
//            out.println("Debugging: Cash - " + cashStr);
//            out.println("Debugging: Amount Change - " + amountChangeStr);
//            out.println("Debugging: Authorizing Employee ID - " + authorizingEmployeeIdStr);

            if (transactionIdStr != null && totalDueStr != null && cashStr != null && amountChangeStr != null && authorizingEmployeeIdStr != null) {
                try {
                    int transactionId = Integer.parseInt(transactionIdStr);
                    float totalDue = Float.parseFloat(totalDueStr);
                    float cash = Float.parseFloat(cashStr);
                    float amountChange = Float.parseFloat(amountChangeStr);
                    int authorizingEmployeeId = Integer.parseInt(authorizingEmployeeIdStr);

                    payment.transaction_id = transactionId;
                    payment.totalDue = totalDue;
                    payment.cash = cash;
                    payment.change = amountChange;
                    payment.authorizing_staff_id = authorizingEmployeeId;

                   
                    if (payment.insertPayment()) {
                        out.println("Payment processed successfully."); %>
                            <form action="order_rating.jsp">
                                <br><input type="submit" value="Proceed to Rating">
                            </form>
                    <% } else {
                        out.println("Failed to process payment." + payment.transaction_id + " "+ payment.totalDue + " "+ payment.cash + " "+ payment.change + " "+ payment.authorizing_staff_id); 
                        O.customer_id = C.getLatestCustomer();
                        TM.transactionId = O.getCustomerTransactionId();
                    
                        if(payment.deleteFailedRecords()) { %>
                            <form action="index.html">
                                <br><input type="submit" value="Return to Menu">
                            </form>
                        <%}%>
                    <% }

                } catch (NumberFormatException e) { 
                    out.println("Invalid input. Please enter valid numbers."); %>
                        <form action="operate_payment_processing.jsp">
                           <br><input type="submit" value="Back to Payment">
                       </form>
                <% } 
            } else {
                out.println("Missing parameters. Please fill out the payment form.");
            }
        %>
</body>
</html>
