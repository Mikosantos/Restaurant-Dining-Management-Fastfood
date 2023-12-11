<%-- 
    Document   : delete_selected_meal_processing
    Created on : Nov 18, 2023, 3:21:45 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>delete_selected_meal_processing</title>
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
        </style>
    </head>
    <body>
        <h1>Remove Meal</h1>
        <div class="background-container"></div>
        <form action = "index.html">
            <jsp:useBean id = "sml" class="diningmanagement.meals" scope="session"/>
            <%
                String v_meal_id = request.getParameter("meal_id");
                
                sml.meal_id = Integer.parseInt(v_meal_id);
                
                
                if (sml.delete_meal()){
            %>
                <h2>Deleted Meal Successful</h2><br>
                
            <%  } else{ %>      
                <h2>Deleted Meal Failed</h2><br>
            <%  }    
            %>    
            <input type = "submit" value ="Return to Menu"> 
        </form>
    </body>
</html>
