/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package diningmanagement;

/**
 *
 * @author Reina Althea
 */

import java.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class meal_ingredient {
    
    //Change the values in line with your server.
    public String username = "root";
    public String password = "password";
    
    public int      meal_ingredient_id;
    public int      ingredient_id;
    public int      meal_id;
    public int      quantity_used;
    
    public ArrayList<Integer>   meal_ingredient_idlist = new ArrayList<>();
    public ArrayList<Integer>   ingredient_idlist = new ArrayList<>();
    public ArrayList<String>    ingredient_namelist = new ArrayList<>();
    public ArrayList<Integer>   meal_idlist = new ArrayList<>();
    public ArrayList<String>    meal_namelist = new ArrayList<>();
    public ArrayList<Integer>   quantity_usedlist = new ArrayList<>();
    
    public meal_ingredient() {}
    
    public void clearList(){
        meal_ingredient_idlist.clear();
        ingredient_idlist.clear();
        ingredient_namelist.clear();
        meal_idlist.clear();
        quantity_usedlist.clear();
    }
    
    public boolean add_meal_ingredient () {
        clearList();
        int count = 0;
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM meal_ingredient WHERE meal_id = ? AND ingredient_id = ?"); //check if it exists
            pstmt.setInt(1, meal_id);
            pstmt.setInt(2, ingredient_id);
            ResultSet rst = pstmt.executeQuery();
           
            while(rst.next()) {
                count = rst.getInt("count");
                
            }
           
            if(count > 0) { //meaning it exists already
                pstmt = conn.prepareStatement("UPDATE meal_ingredient SET quantityUsed = ? WHERE meal_id = ? AND ingredient_id = ?");
                pstmt.setInt(1, quantity_used);
                pstmt.setInt(2, meal_id);
                pstmt.setInt(3, ingredient_id);
                pstmt.executeUpdate();
            } else { //meaning new meal_ingredient
                
                pstmt = conn.prepareStatement("SELECT MAX(meal_ingredient_id) + 1 AS new_id FROM meal_ingredient"); //to get a new ingredient_meal_id
                rst = pstmt.executeQuery();

                while(rst.next()) {
                    meal_ingredient_id = rst.getInt("new_id");
                }
                
                pstmt = conn.prepareStatement("INSERT INTO meal_ingredient (meal_ingredient_id, ingredient_id, meal_id, quantityUsed) VALUES (?, ?, ?, ?)");
                pstmt.setInt(1, meal_ingredient_id);
                pstmt.setInt(2, ingredient_id);
                pstmt.setInt(3, meal_id);
                pstmt.setInt(4, quantity_used);
                pstmt.executeUpdate();
            }
            
            pstmt.close();
            conn.close();
            return true;
            
        
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean view_meal_ingredients () { 
        clearList();
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            //galing ni miko
            PreparedStatement pstmt = conn.prepareStatement("SELECT mi.meal_ingredient_id, i.ingredient_id, i.ingredient_name, m.meal_id, m.meal_name, mi.quantityUsed "
                    + "                                      FROM ( "
                    + "                                             SELECT meal_id FROM meal "
                    + "                                             WHERE meal_id NOT IN (SELECT meal_id FROM delete_meal)"
                    + "                                      ) AS ndm "
                    + "                                      JOIN meal m ON ndm.meal_id = m.meal_id "
                    + "                                      JOIN meal_ingredient mi ON m.meal_id = mi.meal_id "
                    + "                                      JOIN ingredient i ON mi.ingredient_id = i.ingredient_id "
                    + "                                      ORDER BY m.meal_id, mi.quantityUsed, mi.meal_ingredient_id, i.ingredient_id;"); //select all ingredients
            ResultSet rst = pstmt.executeQuery();
           
            while(rst.next()) {
                meal_ingredient_idlist.add(rst.getInt("meal_ingredient_id"));
                ingredient_idlist.add(rst.getInt("ingredient_id"));
                ingredient_namelist.add(rst.getString("ingredient_name"));
                meal_idlist.add(rst.getInt("meal_id"));
                meal_namelist.add(rst.getString("meal_name"));
                quantity_usedlist.add(rst.getInt("quantityUsed"));
                
                /* debugging
                 * System.out.println("Meal Ingredient ID: " + rst.getInt("meal_ingredient_id"));
                 * System.out.println("Ingredient ID: " + rst.getInt("ingredient_id"));
                 * System.out.println("Ingredient Name: " + rst.getString("ingredient_name"));
                 * System.out.println("Meal ID: " + rst.getInt("meal_id"));
                 * System.out.println("Meal Name: " + rst.getString("meal_name"));
                 * System.out.println("Ingredient Quantity: " + rst.getInt("quantityUsed"));
                 */
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
    
    public boolean view_specific_meal_ingredients () {
        clearList();
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT i.ingredient_name AS ingredient_name, "
                    + "                                             mi.quantityUsed AS quantityUsed"
                    + "                                      FROM meal m JOIN meal_ingredient mi ON m.meal_id = mi.meal_id "
                    + "                                                  JOIN ingredient i ON mi.ingredient_id = i.ingredient_id"
                    + "                                      WHERE  m.meal_id = ?"
                    + "                                      ORDER BY  ingredient_name"); //select all ingredients
            pstmt.setInt(1, meal_id);
            ResultSet rst = pstmt.executeQuery();
           
            while(rst.next()) {
                ingredient_namelist.add(rst.getString("ingredient_name"));
                quantity_usedlist.add(rst.getInt("quantityUsed"));
                
                System.out.println(rst.getString("ingredient_name"));
                System.out.println(rst.getInt("quantityUsed"));
                
                /* debugging
                 * System.out.println("Meal Ingredient ID: " + rst.getInt("meal_ingredient_id"));
                 * System.out.println("Ingredient ID: " + rst.getInt("ingredient_id"));
                 * System.out.println("Ingredient Name: " + rst.getString("ingredient_name"));
                 * System.out.println("Meal ID: " + rst.getInt("meal_id"));
                 * System.out.println("Meal Name: " + rst.getString("meal_name"));
                 * System.out.println("Ingredient Quantity: " + rst.getInt("quantityUsed"));
                 */
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
    
    public static void main (String args[]) {
        
        /*
         * meal_ingredient mi = new meal_ingredient();
         *
         * i.ingredient_name = "Magic potato";
         * i.ingredient_description = "1000g";
         * i.quantity = 100;
         *
         * System.out.println(i.add_ingredients());
         *
         * mi.view_meal_ingredients();
         *
         * mi.meal_id = 6001;
         * mi.ingredient_id = 8009;
         * mi.quantity_used = 10;
         *
         *System.out.println(mi.add_meal_ingredient());
         */
        
        meal_ingredient mi = new meal_ingredient();
        mi.meal_id = 6005;
        mi.view_specific_meal_ingredients();
    }
}
