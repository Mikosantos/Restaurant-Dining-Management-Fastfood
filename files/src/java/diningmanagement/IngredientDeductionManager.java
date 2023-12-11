package diningmanagement;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class IngredientDeductionManager {
    
    public IngredientDeductionManager(){}
    
    public int deduction_id;
    public ArrayList<Integer>   ingredientIDList = new ArrayList<>(); 
    public ArrayList<Integer>   quantityOrderedList = new ArrayList<>(); 
    
    public void processIngredientDeduction(int orderHistoryId) {
        ingredientIDList.clear();
        quantityOrderedList.clear();
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dining_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            String query = "SELECT mi.ingredient_id, tm.quantity " +
                            "FROM meal_ingredient mi " +
                            "JOIN meal m ON mi.meal_id = m.meal_id " +
                            "JOIN transaction_meal tm ON m.meal_id = tm.meal_id " +
                            "WHERE tm.transaction_id IN (SELECT MAX(transaction_id) FROM order_transaction) ";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rst = pstmt.executeQuery();
            
            while(rst.next()) {
                ingredientIDList.add(rst.getInt("ingredient_id"));
                quantityOrderedList.add(rst.getInt("quantity"));
            }
            
            String updateQuery = "UPDATE ingredient SET quantity = quantity - ? WHERE ingredient_id = ?";
            PreparedStatement updatePstmt = conn.prepareStatement(updateQuery);
            for(int i = 0; i < ingredientIDList.size(); i++) { 
                updatePstmt.setInt(1, quantityOrderedList.get(i));
                updatePstmt.setInt(2, ingredientIDList.get(i));
                updatePstmt.executeUpdate();
            }
            

            String insertQuery = "INSERT INTO ingredient_deduction (ingredient_deduction_id, order_history_id, ingredient_id) VALUES (?, ?, ?)";
            PreparedStatement insertPstmt = conn.prepareStatement(insertQuery);
            for(int i = 0; i < ingredientIDList.size(); i++) {
                PreparedStatement getPstmt = conn.prepareStatement("SELECT MAX(ingredient_deduction_id) + 1 AS new_id FROM ingredient_deduction");
                ResultSet getRst = getPstmt.executeQuery();

                while (getRst.next()) {
                    deduction_id = getRst.getInt("new_id");
                }   
                
                insertPstmt.setInt(1, deduction_id);
                insertPstmt.setInt(2, orderHistoryId);
                insertPstmt.setInt(3, ingredientIDList.get(i));
                insertPstmt.executeUpdate();
            }

            String updateStatusQuery = "UPDATE order_transaction SET order_status = 'Complete' " +
                                       "WHERE transaction_id = (SELECT * FROM (SELECT MAX(transaction_id) FROM order_transaction) AS temp)";

            PreparedStatement updateStatusPstmt = conn.prepareStatement(updateStatusQuery);
            updateStatusPstmt.executeUpdate();
            
            
            
            rst.close();
            pstmt.close();
            updatePstmt.close();
            insertPstmt.close();
            updateStatusPstmt.close();
            conn.close();
            

        } catch (SQLException ex) {
            Logger.getLogger(IngredientDeductionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static void main(String[] args){
        IngredientDeductionManager idm = new IngredientDeductionManager();
        idm.processIngredientDeduction(10005);
    }
}
