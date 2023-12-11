/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package diningmanagement;
/**
 *
 * @author YES
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Payment {
    
    public int currCustomer;
    
    public int transaction_id;
    public float totalDue;
    public float cash;
    public float change;
    public int authorizing_staff_id;

    public ArrayList<Integer> transaction_idList = new ArrayList<>();
    public ArrayList<Float> totalDueList = new ArrayList<>();
    public ArrayList<Float> cashList = new ArrayList<>();
    public ArrayList<Float> changeList = new ArrayList<>();
    public ArrayList<Integer> authorizing_staff_idList = new ArrayList<>();

    public Payment() {}

    public void clearLists() {
        transaction_idList.clear();
        totalDueList.clear();
        cashList.clear();
        changeList.clear();
        authorizing_staff_idList.clear();
    }

    public boolean updatePayment(int transactionId, float newTotalDue, float newChange) {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement(
                    "UPDATE payment SET totalDue=?, change=? WHERE transaction_id=?"
            );
            pstmt.setFloat(1, newTotalDue);
            pstmt.setFloat(2, newChange);
            pstmt.setInt(3, transactionId);

            int rowsAffected = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return rowsAffected > 0;
       
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean viewPayments() {
        clearLists();
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM payment");
            ResultSet rst = pstmt.executeQuery();

            while (rst.next()) {
                transaction_idList.add(rst.getInt("transaction_id"));
                totalDueList.add(rst.getFloat("totalDue"));
                cashList.add(rst.getFloat("cash"));
                changeList.add(rst.getFloat("change"));
                authorizing_staff_idList.add(rst.getInt("authorizing_staff_id"));
            }

            pstmt.close();
            conn.close();
            return true;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            //message = e.getMessage();
            return false;
        }
    }

    public boolean insertPayment() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            if(cash >= totalDue){
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO payment (transaction_id, totalDue, cash, amount_change, authorizing_employee_id) VALUES (?, ?, ?, ?, ?)");
                pstmt.setInt(1, transaction_id);
                pstmt.setFloat(2, totalDue);
                pstmt.setFloat(3, cash);
                pstmt.setFloat(4, change);
                pstmt.setInt(5, authorizing_staff_id);
                pstmt.executeUpdate();
                
                 pstmt.close();
                 conn.close();
                 
                 return true;
            }
            return false;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            //message = e.getMessage();
            return false;
        }
    }

    public boolean deleteFailedRecords () {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM transaction_meal WHERE transaction_id = ?");
            pstmt.setInt(1, transaction_id);
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement("DELETE FROM order_transaction WHERE transaction_id = ?");
            pstmt.setInt(1, transaction_id);
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement("DELETE FROM customer WHERE customer_id = ?");
            pstmt.setInt(1, currCustomer);
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
            return true;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            //message = e.getMessage();
            return false;
        }
    }
    
    public boolean getCurrentRecords () {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("SELECT totalDue FROM payment WHERE transaction_id = ?");
            pstmt.setInt(1, transaction_id);
            ResultSet rst = pstmt.executeQuery();
            
            while(rst.next()) {
                totalDue = rst.getFloat("totalDue");
            }
            
            pstmt.close();
            conn.close();
            return true;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            //message = e.getMessage();
            return false;
        }
    }
    
    
    public static void main(String args[]) {
        Payment payment = new Payment();
        /*
        payment.transaction_id = 2001;
        payment.totalDue = 120;
        payment.cash = 150;
        payment.change = 30;
        payment.authorizing_staff_id = 3001;
        payment.insertPayment();
        */
        //payment.viewPayments();
        payment.transaction_id = 2005;
        payment.totalDue = 470;
        payment.cash = 1000;
        payment.change = 530;
        payment.authorizing_staff_id = 3001;
        payment.insertPayment();

    }
}
