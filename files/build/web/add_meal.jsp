<%-- 
    Document   : Add Meal
    Created on : Nov 14, 2023, 11:58:29 PM
    Author     : Althea Garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Meal</title>
        <style>
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('menu-bg.png');
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
                margin-bottom: 10px; /* Add margin to create space between input elements */
            }

            form select#meal_type {
                font-family: Comic Sans MS;
                padding: 5px 5px; /* Adjust the values as needed */
                font-size: 16px;   /* Adjust the font size as needed */
                width: 200px;
                font-style: Italic;
                margin-bottom: 10px; /* Add margin to create space between input elements */
            }

            form input[type="submit"] {
                font-family: Comic Sans MS;
                padding: 5px 5px; /* Adjust the values as needed */
                font-size: 16px;   /* Adjust the font size as needed */
                width: 200px;
                font-style: Italic;
                font-weight: bold;
                margin-top: 10px; /* Add margin to create space between input elements */
            }
            
            form {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="background-container"></div>
        <h1>Add Meal</h1>
        <form action="add_meal_processing.jsp">
            Meal Name:              <input type="text" id="meal_name" name="meal_name" required><br><!-- get the name of the meal to be added -->
            Meal Category:          <input type="text" id="meal_category" name="meal_category" required><br><!-- get the category of the meal to be added -->
            Meal Price:             <input type="text" id="meal_price" name="meal_price" required><br><!-- get the category of the meal to be added -->
            Meal Description:       <input type="text" id="meal_description" name="meal_description" required><br><!-- get the category of the meal to be added -->
            <jsp:useBean id="M" class="diningmanagement.meals" scope="session"/>
            Meal:   <select id="meal_type" name="meal_type">
                    <option value="Ala Carte">Ala Carte</option>
                    <option value="Combo">Combo</option>
                </select><br>
            <input type="submit" value="Submit Meal">
        </form>
    </body>
</html>
