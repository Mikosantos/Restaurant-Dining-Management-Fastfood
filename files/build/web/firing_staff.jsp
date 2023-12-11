<%-- 
    Document   : firing_staff_processing
    Created on : Nov 15, 2023, 1:13:22 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, diningmanagement.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Firing Staff Processing</title>
        <style>
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('staff-bg.png');
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
                height: 65vh;
                margin: 0;
            }     

            h1 {
                font-family: Papyrus;
                color: white;
                font-size: 70px; /* Adjust the font size as needed */
                margin-bottom: 0px; /* Reduce the margin to lessen the gap */
                margin-top: 0; /* Reset default margin for these elements */
            }

            h2 {
                font-family: Comic Sans MS;
                font-size: 20px; /* Adjust the font size as needed */
                margin-bottom: 5px; /* You can adjust this margin based on your preference */
                margin-top: 0; /* Reset default margin for these elements */
                color: red;
            }
            
            form select#lastname {
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
        <h1>Remove Staff</h1>
        <h2>Select A Staff To Fire</h2>
        <form action = "fire_selected_staff_processing.jsp">
            <jsp:useBean id="fs" class="diningmanagement.staff" scope="session"/>
            Staff Last Name: <select id="lastname" name="lastname">
                <%
                fs.view_eligible_staffs_to_fire();
                for(int i=0; i< fs.staff_idList.size(); i++){
              %>
                  <option value="<%=fs.lastnameList.get(i)%>"><%=fs.lastnameList.get(i)%></option>
              <% }
              %>
            </select><br>
            <input type = "submit" value ="Fire">
        </form>
    </body>
</html>
