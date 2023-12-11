<%-- 
    Document   : view_staff_processing
    Created on : Nov 18, 2023, 1:22:01 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Staffs</title>
        <style>
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('viewStaff-bg.png');
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
            
            form input[type="submit"] {
                font-family: Comic Sans MS;
                padding: 5px 10px; /* Adjust the values as needed */
                font-size: 18px;   /* Adjust the font size as needed */
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
                max-height: 510px; /* Set a maximum height for the scrollable area */
                overflow-y: auto; /* Enable vertical scrollbar if needed */
            }
            
        </style>
    </head>
    <body>
        <form action="index.html">
            <<div class="background-container"></div>
            <h1>View Staff</h1>
            <jsp:useBean id="vs" class="diningmanagement.staff" scope="session"/>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                    <th>Staff ID</th>
                    <th>Name</th>
                    <th>Mobile No</th>
                    <th>Email Address</th>
                    <th>Salary</th>
                    <th>Position</th>
                    </tr>
                    <%  vs.view_staffs();
                        for(int i = 0; i < vs.staff_idList.size(); i++ ) { %>
                        <tr>
                            <td><%= vs.staff_idList.get(i) %></td>
                            <td><%= vs.completeNameList.get(i) %></td>
                            <td><%= vs.mobile_noList.get(i) %></td>
                            <td><%= vs.email_addList.get(i) %></td>
                            <td><%= vs.salaryList.get(i) %></td>
                            <td><%= vs.positionList.get(i) %></td>
                        </tr>
                    <% } %> 
                </table>
            </div>
            <br><input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
