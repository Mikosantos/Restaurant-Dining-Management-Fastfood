<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- add_order.jsp -->
<%@ page import="diningmanagement.meals" %>
<%@ page import="diningmanagement.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Place Order</title>
    <!-- Add any necessary styling or scripts -->
    <script>
        function addMeal() {
            // Clone the last meal row and append it to the list
            var mealRow = document.getElementById('mealRow');
            var clone = mealRow.cloneNode(true);
            document.getElementById('mealList').appendChild(clone);
        }

        function removeMeal(row) {
            // Remove the specified meal row
            var container = document.getElementById('mealList');
            container.removeChild(row);
        }
    </script>
    <style>
            .background-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('addOrder-bg.png');
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
                margin-bottom: 10px; /* Add margin to create space between input elements */
            }
            
            form div#mealList div#mealRow select[name="mealId"] {
                font-family: Comic Sans MS;
                padding: 5px 5px; /* Adjust the values as needed */
                font-size: 16px;   /* Adjust the font size as needed */
                width: 200px;
                font-style: Italic;
                margin-bottom: 10px; /* Add margin to create space between input elements */
                height: 40px;
                line-height: 40px;
            }
            
            form div#mealList div#mealRow input[type="number"] {
                width: 200px;
                padding: 5px 10px;
                font-size: 18px;
                margin-bottom: 10px;
            }
            
            form div#mealList div#mealRow button {
                font-family: Comic Sans MS;
                padding: 8px 15px;
                font-size: 14px;
                background-color: #ff0000; /* Red background color, adjust as needed */
                color: #fff; /* White text color */
                border: none;
                cursor: pointer;
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

            form div#mealList div#mealRow button:hover {
                background-color: #cc0000; /* Darker red on hover, adjust as needed */
            }
            
            form input:hover {
                background-color: #cccccc;
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
    <h1>Place Order</h1>
    <form action="add_processing_order.jsp" method="post">
        <div id="mealList">
            <!-- Initial meal row -->
            <div id="mealRow">
                <label for="mealId">Select Meal: </label>
                <select name="mealId">
                    <% 
                        try {
                            Connection conn;
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT m.* FROM meal m WHERE m.meal_id NOT IN (SELECT dm.meal_id FROM delete_meal dm)");

                            while (rs.next()) {
                                String mealId = rs.getString("meal_id");
                                String mealName = rs.getString("meal_name");
                                String mealPrice = rs.getString("meal_price");
                    %>
                                <option value="<%= mealId %>" data-name="<%= mealName %>" data-price="<%= mealPrice %>"><%= mealName %></option>
                    <%
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>

                <label for="quantity">Quantity: </label>
                <input type="number" name="quantity" min="1" required>

                <button type="button" onclick="removeMeal(this.parentNode)">Remove</button>
            </div>
        </div>

        <!-- Button to add more meals -->
        <br><button type="button" onclick="addMeal()">Add More Meals</button>

        <br>
        <input type="submit" value="Place Order">
    </form>
</body>
</html>
