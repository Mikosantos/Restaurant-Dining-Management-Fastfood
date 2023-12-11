<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, diningmanagement.meals"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    
    <script>
        <jsp:useBean id="payment" class="diningmanagement.Payment" scope="session"/>
        <jsp:useBean id="TM" class="diningmanagement.TransactionMeal" scope="session"/>
        <jsp:useBean id="C" class="diningmanagement.Customer" scope="session"/>
        <jsp:useBean id="O" class="diningmanagement.Order" scope="session"/>
       
        O.customer_id = C.getLatestCustomer();
        TM.transactionId = O.getCustomerTransactionId();
       
        function updateChange() {
            var cashInput = document.getElementById("cash");
            var amountChangeInput = document.getElementById("amountChange");
            var hiddenAmountChangeInput = document.getElementById("hiddenAmountChange");

            var cashValue = parseFloat(cashInput.value);
            var totalDue = parseFloat("<%= retrieveTotalPrice(String.valueOf(TM.transactionId)) %>");

            if (!isNaN(cashValue)) {
                var change = cashValue - totalDue;
                amountChangeInput.value = change.toFixed(2); // Format to two decimal places
                hiddenAmountChangeInput.value = change.toFixed(2); // Set the value for the hidden input
            } else {
                amountChangeInput.value = ""; // Clear the change if cash is not a valid number
                hiddenAmountChangeInput.value = ""; // Clear the hidden input value
            }
        }

        // Attach the updateChange function to the input event of the cash field
        document.getElementById("cash").addEventListener("input", updateChange);
    </script>
</head>
<body>
    <div>
        <div class="background-container"></div>
        <h1>Operate Payment</h1>
        <form action="payment_processing.jsp" method="post" id="paymentForm">
        
        <label for="transactionId">Transaction ID: </label>
        <input type="text" id="transactionId2" name="transactionId2" value="<%= String.valueOf(TM.transactionId) %>" readonly><br>
        <input type="hidden" id="hiddenTransactionId" name="hiddenTransactionId" value="<%= String.valueOf(TM.transactionId) %>">

        <label for="totalDue">Total Due: </label>
        <input type="text" id="totalDue" name="totalDue" value=" <%= retrieveTotalPrice(String.valueOf(TM.transactionId)) %>" readonly><br>
        <input type="hidden" id="hiddenTotalDue" name="hiddenTotalDue" value="<%= retrieveTotalPrice(String.valueOf(TM.transactionId)) %>">
        
        <label for="cash">Cash: </label>
        <input type="text" id="cash" name="cash" required oninput="updateChange()"><br>
        

        <label for="amountChange">Amount Change: </label>
        <input type="text" id="amountChange" name="amountChange" readonly><br>

        <label for="authorizingEmployeeId">Authorizing Employee ID: </label>
        <input type="text" id="authorizingEmployeeId" name="authorizingEmployeeId" value=" <%= String.valueOf(retrieveAuthorizingOfficer()) %>" readonly><br>
         <input type="hidden" id="hiddenAuthorizingEmployeeId" name="hiddenAuthorizingEmployeeId" value="<%= String.valueOf(retrieveAuthorizingOfficer())%>">
       
        <button type="submit">Process Payment</button>
    </form>
    </div>
</body>
</html>
<%! 
    private String retrieveTotalPrice(String transactionIdStr) {
        String totalDue = "N/A";

        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            int transact_id = Integer.parseInt(transactionIdStr);
            totalDue = Integer.toString(transact_id);

            PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(tm.quantity * m.meal_price) AS total_price FROM order_transaction ot JOIN transaction_meal tm ON ot.transaction_id = tm.transaction_id JOIN meal m ON tm.meal_id = m.meal_id WHERE ot.transaction_id = ? GROUP BY ot.transaction_id;");
            pstmt.setInt(1, transact_id);
            ResultSet rst = pstmt.executeQuery();

            if (rst.next()) {
                totalDue = rst.getString("total_price");
            }

            rst.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalDue;
    }
%>

<%! 
    private int retrieveAuthorizingOfficer() {
        int authorizingStaffID = 0;
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            PreparedStatement pstmt = conn.prepareStatement("SELECT staff_id FROM staff WHERE position = ? ");
            pstmt.setString(1, "Cashier");
            ResultSet rst = pstmt.executeQuery();

            if (rst.next()) {
                authorizingStaffID = rst.getInt("staff_id");
            }

            rst.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return authorizingStaffID;
    }
%>