<%-- 
    Document   : Delete Meal
    Created on : Nov 14, 2023, 11:58:29 PM
    Author     : Althea Garcia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Meal</title>
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
                filter: blur(3px);
                
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

            form select#meal_id {
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
        <h1>Remove Meal</h1>
        <form action="delete_meal_processing.jsp">
            <jsp:useBean id="M" class="diningmanagement.meals" scope="session"/>
            Meal :<select id="meal_id" name="meal_id">
                <%
                    M.view_meals();
                    for(int i = 0; i < M.meal_idlist.size(); i++) { %>
                        <option value="<%=M.meal_idlist.get(i)%>"><%=M.meal_namelist.get(i)%></option>
                <% } %>
                </select><br>
            <input type="submit" value="Submit Meal">
        </form>
    </body>
</html>
