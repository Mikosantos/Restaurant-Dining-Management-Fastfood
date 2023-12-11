/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package diningmanagement;

/**
 *
 * @author polar
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TransactionMeal {
    
    //Change the values in line with your server.
    public String username = "root";
    public String password = "password";
    
    public int transactionMealId;
    public int transactionId;
    public int mealId;
    public int quantity;

    public ArrayList<Integer>   transactionMeal_idlist = new ArrayList<>(); 
    public ArrayList<Integer>   transaction_idlist = new ArrayList<>();
    public ArrayList<Integer>   meal_idlist = new ArrayList<>();
    public ArrayList<String>   meal_namelist = new ArrayList<>();
    public ArrayList<Integer>   quantitylist = new ArrayList<>();
    public ArrayList<Integer>   pricelist = new ArrayList<>();
    
    public ArrayList<Integer>  toBeDeletedTransactionMealId = new ArrayList<>();
    

    public TransactionMeal() {}

    public void clearList() {
        transactionMeal_idlist = new ArrayList<>();
        transaction_idlist = new ArrayList<>();
        meal_idlist = new ArrayList<>();
        meal_namelist = new ArrayList<>();
        quantitylist = new ArrayList<>();
        pricelist = new ArrayList<>();
    }
    
    public boolean insertTransactionMeal() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO transaction_meal (transaction_meal_id, transaction_id, meal_id, quantity) VALUES (?, ?, ?, ?)");
            pstmt.setInt(1, transactionMealId);
            pstmt.setInt(2, transactionId);
            pstmt.setInt(3, mealId);
            pstmt.setInt(4, quantity);
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
            return true;

        
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public boolean addTransactionMeal() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            // Get a new transaction_meal_id
            PreparedStatement pstmtId = conn.prepareStatement("SELECT MAX(transaction_meal_id) + 1 AS new_id FROM transaction_meal");
            ResultSet rstId = pstmtId.executeQuery();
            System.out.print("Connection Successful");

            while (rstId.next()) {
                transactionMealId = rstId.getInt("new_id");
            }

            // Insert new transaction meal
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO transaction_meal (transaction_meal_id, transaction_id, meal_id, quantity) VALUES (?, ?, ?, ?)");
            pstmt.setInt(1, transactionMealId);
            pstmt.setInt(2, transactionId); // Using a method to get a new transaction_id
            pstmt.setInt(3, mealId);
            pstmt.setInt(4, quantity);
            pstmt.executeUpdate();

            pstmtId.close();
            rstId.close();
            pstmt.close();
            conn.close();
            return true;

        
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean viewTransactionMeals() {
        clearList();
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT tm.transaction_meal_id AS transaction_meal_id, "
                    + "                                             tm.transaction_id AS transaction_id,"
                    + "                                             tm.meal_id AS meal_id, "
                    + "                                             m.meal_name AS meal_name, "
                    + "                                             tm.quantity AS quantity"
                    + "                                      FROM transaction_meal tm JOIN meal m"
                    + "                                                               ON tm.meal_id = m.meal_id  "
                    + "                                      WHERE transaction_id = ?");
            pstmt.setInt(1, transactionId); //transaction_id of the current customer
            ResultSet rst = pstmt.executeQuery();
           
            while(rst.next()) {
                transactionMeal_idlist.add(rst.getInt("transaction_meal_id"));
                transaction_idlist.add(rst.getInt("transaction_id"));
                meal_idlist.add(rst.getInt("meal_id"));
                meal_namelist.add(rst.getString("meal_name"));
                quantitylist.add(rst.getInt("quantity"));
                
                System.out.println(rst.getInt("transaction_meal_id"));
                System.out.println(rst.getInt("transaction_id"));
                System.out.println(rst.getInt("meal_id"));
                System.out.println(rst.getString("meal_name"));
                System.out.println(rst.getInt("quantity"));
            }
            
            pstmt.close();
            conn.close();
            return true;
            
        
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public boolean isStock() {
        int quantityOrdered = 0;
        int quantityUsed = 0;
        int quantityInStock = 0;
        boolean flag = false;
     
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT tm.quantity AS quantityOrdered, "
                            + "                                              mi.quantityUsed AS quanityUsed,"
                            + "                                              i.quantity AS quantityInStock "
                    + "                                      FROM transaction_meal tm JOIN  meal m"
                    + "                                                               ON    tm.meal_id = m.meal_id"
                    + "                                                               JOIN  meal_ingredient mi"
                    + "                                                               ON    mi.meal_id = m.meal_id"
                    + "                                                               JOIN  ingredient i"
                    + "                                                               ON    i.ingredient_id = mi.ingredient_id"
                    + "                                      WHERE  tm.transaction_id = ? AND tm.meal_id = ?");
            pstmt.setInt(1, transactionId);
            pstmt.setInt(2, mealId);
            ResultSet rst = pstmt.executeQuery();
           
            while(rst.next()) {
                quantityOrdered = rst.getInt("quantityOrdered");
                quantityUsed = rst.getInt("quanityUsed");
                quantityInStock = rst.getInt("quantityInStock");
                
                flag = (quantityUsed * quantityOrdered) <= quantityInStock;
            }
            
            if (flag) {
                return true;
            }
            
            pstmt.close();
            conn.close();
            return false;
            
       
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public void addToBeDeleted () {
        toBeDeletedTransactionMealId.add(mealId);
    }
    
    public boolean deleteTransactionMeal() {
        boolean flag = false;
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            // Get a new transaction_meal_id
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM transaction_meal WHERE transaction_meal_id = ?");
            pstmt.setInt(1, transactionMealId);
            int rows = pstmt.executeUpdate();
            System.out.println("Connection Successful");
            
            if(rows > 0) {
                transactionMeal_idlist.remove(Integer.valueOf(transactionMealId));
                flag = true;
            }
            System.out.println(transactionMeal_idlist.size());
            pstmt.close();
            conn.close();
            return flag;

        
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public static void main(String[] args) {
        // You can use this main method for testing
        // For example, insert a transaction meal
        // or retrieve the order list for a specific transaction
        TransactionMeal tm = new TransactionMeal();
        tm.transactionId = 2029;
        tm.viewTransactionMeals();
        tm.transactionMealId = 2029;
        tm.deleteTransactionMeal();
    }
}
