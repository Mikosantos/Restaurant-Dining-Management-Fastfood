/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author polar
 */
package diningmanagement;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Customer {
    private int customer_id;

    public Customer() {}

    public boolean addCustomer() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Get a new customer_id
            PreparedStatement pstmtCustomerId = conn.prepareStatement("SELECT MAX(customer_id) + 1 AS new_customer_id FROM customer");
            ResultSet rstCustomerId = pstmtCustomerId.executeQuery();

            while (rstCustomerId.next()) {
                customer_id = rstCustomerId.getInt("new_customer_id");
            }

            // Insert the new customer into the customer table
            PreparedStatement pstmtInsertCustomer = conn.prepareStatement("INSERT INTO customer (customer_id) VALUES (?)");
            pstmtInsertCustomer.setInt(1, customer_id);
            pstmtInsertCustomer.executeUpdate();

            // Close resources
            pstmtCustomerId.close();
            rstCustomerId.close();
            pstmtInsertCustomer.close();
            conn.close();

            return true;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            //message = e.getMessage();
            return false;
        }
    }
    
    public int getLatestCustomer() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Get the latest customer_id
            PreparedStatement pstmtLatestCustomer = conn.prepareStatement("SELECT MAX(customer_id) AS latest_customer_id FROM customer");
            ResultSet rstLatestCustomer = pstmtLatestCustomer.executeQuery();

            int latestCustomerId = 0;  // Local variable to store the latest customer ID

            while (rstLatestCustomer.next()) {
                latestCustomerId = rstLatestCustomer.getInt("latest_customer_id");
            }

            // Close resources
            pstmtLatestCustomer.close();
            rstLatestCustomer.close();
            conn.close();

            return latestCustomerId;

        } catch (SQLException ex) {
            Logger.getLogger(employee_login.class.getName()).log(Level.SEVERE, null, ex);
            return 0;  // Return 0 as an indication of failure
        }
    }

    public static void main(String[] args) {
        Customer customer = new Customer();

    }
}

