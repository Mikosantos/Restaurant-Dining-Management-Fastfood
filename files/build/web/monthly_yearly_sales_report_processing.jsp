<%-- 
    Document   : monthly_yearly_sales_report_processing
    Created on : Nov 16, 2023, 1:34:47 AM
    Author     : Miko Santos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Monthly and Yearly Sales Report</title>
    </head>
        <style>
                .background-container {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    z-index: -1;
                    background-image: url('viewSales-bg.png');
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
                    height: 100vh;
                    margin: 0;
                }     

                h1 {
                    font-family: Papyrus;
                    color: white;
                    font-size: 50px; /* Adjust the font size as needed */
                    margin-bottom: 20px;
                }

                form input[type="submit"] {
                    font-family: Comic Sans MS;
                    padding: 10px 20px; /* Adjust the values as needed */
                    font-size: 20px;   /* Adjust the font size as needed */
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
                    max-height: 410px; /* Set a maximum height for the scrollable area */
                    overflow-y: auto; /* Enable vertical scrollbar if needed */
                }


        </style>
    <body>
        <form action="index.html">
            <div class="background-container"></div>
            <h1>Monthly Sales Report</h1>
            <jsp:useBean id="oh" class="diningmanagement.order_history" scope="session"/>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                        <th>Month</th>
                        <th>Sales</th>

                    </tr>
                    <%  oh.generate_monthly_sales_report();
                        for(int i = 0; i < oh.monthNamelist.size(); i++ ) { %>
                        <tr>
                            <td><%= oh.monthNamelist.get(i) %></td>
                            <td><%= oh.salesPerMonthlist.get(i) %></td>
                        </tr>
                    <% } %> 
                </table>
            </div>
            
            <h1>Monthly Most Ordered Meal/s</h1>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                        <th>Month</th>
                        <th>Most Ordered Meal/s</th>
                         <th>Order Count</th>
                    </tr>
                    <% 
                    oh.getMonthlyMostOrderedMeals();
                    for(int i = 0; i < oh.monthlistMMOM.size(); i++) {
                    %>
                    <tr>
                        <td><%= oh.monthlistMMOM.get(i) %></td>
                        <td><%= oh.meallistMMOM.get(i) %></td>
                        <td><%= oh.ordercountMMOM.get(i) %></td>
                    </tr>
                    <% } %>
                </table>    
            </div>
                
            <h1>Yearly Sales Report</h1>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                        <th>Year</th>
                        <th>Sales</th>

                    </tr>
                 <%  oh.generate_yearly_sales_report();
                        for(int i = 0; i < oh.yearlist.size(); i++ ) { %>
                        <tr>
                            <td><%= oh.yearlist.get(i) %></td>
                            <td><%= oh.salesPerYearlist.get(i) %></td>
                        </tr>
                    <% } %> 
                </table>
            </div>
            
            <h1>Yearly Most Ordered Meal/s</h1>
            <div class="scrollable-table">
                <table border="1">
                    <tr>
                        <th>Year</th>
                        <th>Most Ordered Meal/s</th>
                         <th>Order Count</th>
                    </tr>
                    <% 
                    oh.getYearlyMostOrderedMeals();
                    for(int i = 0; i < oh.yearlistYMOM.size(); i++) {
                    %>
                    <tr>
                        <td><%= oh.yearlistYMOM.get(i) %></td>
                        <td><%= oh.meallistYMOM.get(i) %></td>
                        <td><%= oh.ordercountYMOM.get(i) %></td>
                    </tr>
                    <% } %>
                </table>    
            </div>
                
            <br><input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
