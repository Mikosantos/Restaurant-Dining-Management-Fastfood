<%-- 
    Document   : order_rating
    Created on : 18 Nov 2023, 2:11:27 pm
    Author     : gaby arco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
     <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <div>
        <div class="background-container"></div>
        <h1>Rate your Experience!</h1>
        <form action="orderhistory_processing.jsp">
            <jsp:useBean id="oh" class="diningmanagement.order_history" scope="session"/>
            Rating:
            <select name="rating">
                <option value="5.0">5.0</option>
                <option value="4.0">4.0</option>
                <option value="3.0">3.0</option>
                <option value="2.0">2.0</option>
                <option value="1.0">1.0</option>
            </select>

            <button type="submit">Done</button>
        </form>
        </div>
    </body>
</html>
