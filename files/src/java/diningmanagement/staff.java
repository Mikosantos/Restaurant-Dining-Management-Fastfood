/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package diningmanagement;

/**
 *
 * @author Miko Santos
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;
import java.sql.*;

public class staff {
    //Change the values in line with your server.
    public String username = "root";
    public String password = "password";
    
    public int staff_id;
    public String lastname;
    public String middlename;
    public String firstname;
    public String completeName;
    public String  mobile_no;
    public String email_add;
    public float salary;
    public String position;
    
    public ArrayList<Integer> staff_idList =  new ArrayList<>();
    public ArrayList<String> lastnameList =  new ArrayList<>();
    public ArrayList<String> middlenameList =  new ArrayList<>();
    public ArrayList<String> firstnameList =  new ArrayList<>();
    public ArrayList<String > mobile_noList =  new ArrayList<>();
    public ArrayList<String> email_addList =  new ArrayList<>();
    public ArrayList<Float> salaryList =  new ArrayList<>();
    public ArrayList<String> positionList =  new ArrayList<>();
    public ArrayList<String> completeNameList = new ArrayList<>();
    
    public staff(){}
    
    public boolean view_eligible_staffs_to_fire(){
        clearList();
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM staff WHERE NOT (position   LIKE 'Manager' OR position LIKE  'Cashier');"); 
            ResultSet rst = pstmt.executeQuery();
            
            while (rst.next()){ 
                staff_idList.add(rst.getInt("staff_id"));
                lastnameList.add(rst.getString("lastname"));
                middlenameList.add(rst.getString("middlename"));
                firstnameList.add(rst.getString("firstname"));
                mobile_noList.add(rst.getString("mobile_no"));
                email_addList.add(rst.getString("email_add"));
                salaryList.add(rst.getFloat("salary"));
                positionList.add(rst.getString("position"));
                
            }
            pstmt.close();
            conn.close();
            return true;
        }catch(SQLException e){
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean view_staffs(){
        clearList();
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successfull");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT staff_id, CONCAT(firstname, ' ',middlename, ' ',lastname) AS 'staff_name', mobile_no, email_add, salary,position FROM staff;"); 
            ResultSet rst = pstmt.executeQuery();
            
            while (rst.next()){ 
                staff_idList.add(rst.getInt("staff_id"));
                completeNameList.add(rst.getString("staff_name"));
                mobile_noList.add(rst.getString("mobile_no"));
                email_addList.add(rst.getString("email_add"));
                salaryList.add(rst.getFloat("salary"));
                positionList.add(rst.getString("position"));
            }
            pstmt.close();
            conn.close();
            return true;
        }catch(SQLException e){
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public void clearList(){
        staff_idList.clear();
        lastnameList.clear();
        middlenameList.clear();
        mobile_noList.clear();
        email_addList.clear();
        salaryList.clear();
        positionList.clear(); 
        completeNameList.clear();
    }
    
    public int register_staff() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement pstmt1 = conn.prepareStatement("SELECT MAX(staff_id)+ 1 AS newID FROM staff");
            ResultSet rst = pstmt1.executeQuery();

            clearList();

            while (rst.next()) {
                staff_id = rst.getInt("newID");
            }
            pstmt1.close();

            PreparedStatement pstmt2 = conn.prepareStatement("INSERT INTO staff(staff_id, lastname, middlename, firstname, mobile_no, email_add, salary, position) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt2.setInt(1, staff_id);
            pstmt2.setString(2, lastname);
            pstmt2.setString(3, middlename);
            pstmt2.setString(4, firstname);
            pstmt2.setString(5, mobile_no);
            pstmt2.setString(6, email_add);
            pstmt2.setFloat(7, salary);
            pstmt2.setString(8, position);

            pstmt2.executeUpdate();
            pstmt2.close();

            System.out.println("Staff registered successfully");
            conn.close();

            return 1;
        } catch (SQLException e) { 
             e.printStackTrace(); 
             System.out.println(e.getMessage());
             return 0;
        }
    }
 
    public int remove_staff(String lastname) {
        try {
            
            int rowsAffected;
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678")) {
                System.out.println("Connection Successfull");
                
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM staff WHERE lastname = ?");
                pstmt.setString(1, lastname);
                rowsAffected = pstmt.executeUpdate();
                pstmt.close();
            }

            if (rowsAffected > 0) {
                System.out.println("Staff member removed successfully.");
                return 1;
            } else {
                System.out.println("No staff member found with the given ID.");
                return 0;
            }
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public static void main(String[] args){
        staff s = new staff();
        int status = s.remove_staff("Garcia");
        if (status == 1)    
            System.out.println("Successful");
        else    
            System.out.println("Unsuccessful");
        
    }
}
