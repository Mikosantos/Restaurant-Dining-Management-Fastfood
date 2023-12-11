/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package diningmanagement;

import java.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Reina Althea
 */
public class meals {
    
    //Change the values in line with your server.
    public String username = "root";
    public String password = "password";
    
    //variables (for single record)
    public int      meal_id;
    public String   meal_name;
    public String   meal_category;
    public float    meal_price;
    public String   meal_description;
    public String   meal_type;
    
    //list of meals (for multiple records)
    public ArrayList<Integer> meal_idlist = new ArrayList<>();
    public ArrayList<String> meal_namelist = new ArrayList<>();
    public ArrayList<String> meal_categorylist = new ArrayList<>();
    public ArrayList<Float> meal_pricelist = new ArrayList<>();
    public ArrayList<String> meal_descriptionlist = new ArrayList<>();
    public ArrayList<String> meal_typelist = new ArrayList<>();
    
    public meals () {}
    
    public void clearList(){
        meal_idlist.clear();
        meal_namelist.clear();
        meal_categorylist.clear();
        meal_pricelist.clear();
        meal_descriptionlist.clear();
        meal_typelist.clear();
    }
    
    public boolean view_meals () {
        clearList();
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT m.* FROM meal m WHERE m.meal_id NOT IN (SELECT dm.meal_id FROM delete_meal dm)"); 
            ResultSet rst = pstmt.executeQuery();
           
            while(rst.next()) {
                meal_idlist.add(rst.getInt("meal_id"));
                meal_namelist.add(rst.getString("meal_name"));
                meal_categorylist.add(rst.getString("meal_category"));
                meal_pricelist.add(rst.getFloat("meal_price"));
                meal_descriptionlist.add(rst.getString("meal_description"));
                meal_typelist.add(rst.getString("meal_type"));
            }
            
            pstmt.close();
            conn.close();
            return true;
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean add_meal () {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(meal_id) + 1 AS new_id FROM meal"); //to get a new meal_id
            ResultSet rst = pstmt.executeQuery();
           
            while(rst.next()) {
                meal_id = rst.getInt("new_id");
            }
            
            pstmt = conn.prepareStatement("INSERT INTO meal (meal_id, meal_name, meal_category, meal_price, meal_description, meal_type) VALUES (?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, meal_id);
            pstmt.setString(2, meal_name);
            pstmt.setString(3, meal_category);
            pstmt.setFloat(4, meal_price);
            pstmt.setString(5, meal_description);
            pstmt.setString(6, meal_type);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            return true;
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean delete_meal () {
        try {
           Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO delete_meal VALUES (?)");
            pstmt.setInt(1, meal_id);
            int result = pstmt.executeUpdate();
            
            if(result > 0) {
                pstmt.close();
                conn.close();
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
    
    public static void main (String args[]) {
        
        /*
         * meals M = new meals();
         *
         * M.meal_name = "Coke";
         * M.meal_category = "Beverages";
         * M.meal_price = 79;
         * M.meal_description = "Cold drink for summer!";
         * M.meal_type = "Ala carte";
         * M.add_meal();
         *
         * M.meal_id = 6001;
         * System.out.println(M.delete_meal());
         */
        meals M = new meals();
//        M.meal_id = 6001;
//        System.out.println(M.delete_meal());
    }
  
}
