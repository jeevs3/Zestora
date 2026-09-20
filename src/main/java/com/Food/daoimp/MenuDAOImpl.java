package com.Food.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.Food.DAO.MenuDAO;
import com.Food.Model.Menu;
import com.Food.Model.Restaurant;
import com.Food.Utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {
	
	public static String INSERT_QUERY = "INSERT INTO menu(RestaurantId, itemName, description, price, isAvailable, category, createdAt, updatedAt, deletedAt, photo, isVeg)" 
			+ "Values(?,?,?,?,?,?,?,?,?,?,?)";
	public static String SELECT_QUERY = "SELECT * FROM menu WHERE menuId = ?";
	
	public static String UPDATE_QUERY =
	        "UPDATE menu SET RestaurantId = ?, itemName = ?, description = ?, price = ?, " +
	        "isAvailable = ?, category = ?, createdAt = ?, updatedAt = ?, deletedAt = ?, " +
	        "photo = ?, isVeg = ? WHERE menuId = ?";
	
	public static String DELETE_QUERY = "DELETE  FROM menu WHERE menuId = ?";
	
	public static String SELECT_ALL_QUERY = "SELECT * FROM menu";
	
	public static String SELECT_BY_RESTAURANT_QUERY = "SELECT * FROM menu WHERE RestaurantId = ?";
	@Override
	public void addMenu(Menu menu) {
		

		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(INSERT_QUERY);
			stmt.setInt(1, menu.getRestaurantId());
			stmt.setString(2, menu.getItemName());
			stmt.setString(3, menu.getDescription());
			stmt.setDouble(4, menu.getPrice());
			stmt.setBoolean(5, menu.isAvailable());
			stmt.setString(6, menu.getCategory());
			stmt.setTimestamp(7,  new Timestamp(System.currentTimeMillis()));
			stmt.setTimestamp(8,  new Timestamp(System.currentTimeMillis()));
			stmt.setTimestamp(9,  null);
			stmt.setString(10, menu.getPhoto());
			stmt.setBoolean(11, menu.isVeg());
			
			int i = stmt.executeUpdate();
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	@Override
	public Menu getMenu(int menuId) {
		
		Menu menu = null;
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(SELECT_QUERY);
				
			stmt.setInt(1, menuId);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				int id = res.getInt("menuId");
				 int restaurantid = res.getInt("RestaurantId");
				 String itemname = res.getString("itemName");
				 String description = res.getString("description");
				 double price = res.getDouble("price");
				 boolean available = res.getBoolean("isAvailable");
				 String category = res.getString("category");
				 Timestamp createdAt = res.getTimestamp("createdAt");
				 Timestamp updatedAt = res.getTimestamp("updatedAt");
				 Timestamp deletedAt = res.getTimestamp("deletedAt");
				 String photo = res.getString("photo");
				 boolean Veg = res.getBoolean("isVeg");
				 
			     menu = new Menu(id, restaurantid, itemname, description, price, available, category, createdAt, updatedAt, deletedAt, photo, Veg);			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return menu;
		
	}

	@Override
	public void updateMenu(Menu menu) {
		
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(UPDATE_QUERY);
			stmt.setInt(1, menu.getRestaurantId());
			stmt.setString(2, menu.getItemName());
			stmt.setString(3, menu.getDescription());
			stmt.setDouble(4, menu.getPrice());
			stmt.setBoolean(5, menu.isAvailable());
			stmt.setString(6, menu.getCategory());
			stmt.setTimestamp(7,  new Timestamp(System.currentTimeMillis()));
			stmt.setTimestamp(8,  new Timestamp(System.currentTimeMillis()));
			stmt.setTimestamp(9,  null);
			stmt.setString(10, menu.getPhoto());
			stmt.setBoolean(11, menu.isVeg());
			stmt.setInt(12, menu.getMenuId());
			
			int i = stmt.executeUpdate();
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	@Override
	public void deleteMenu(int menuId) {
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(DELETE_QUERY);
			
			stmt.setInt(1, menuId);
			stmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Menu> addAllMenu() {
		
		List<Menu> list = new ArrayList<Menu>();
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(SELECT_ALL_QUERY);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				 int menuId = res.getInt("menuId");
				 int id = res.getInt("RestaurantId");
				 String itemname = res.getString("itemName");
				 String description = res.getString("description");
				 double price = res.getDouble("price");
				 boolean available = res.getBoolean("isAvailable");
				 String category = res.getString("category");
				 Timestamp createdAt = res.getTimestamp("createdAt");
				 Timestamp updatedAt = res.getTimestamp("updatedAt");
				 Timestamp deletedAt = res.getTimestamp("deletedAt");
				 String photo = res.getString("photo");
				 boolean Veg = res.getBoolean("isVeg");
				 
			     Menu menu = new Menu(menuId, id, itemname, description, price, available, category, createdAt, updatedAt, deletedAt, photo,Veg);	
			     list.add(menu);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override

	public List<Menu> getMenuByRestaurant(int restaurantId) {

	    List<Menu> list = new ArrayList<Menu>();

	    Connection connection = DBConnection.getConnection();

	    try {
	        PreparedStatement stmt = connection.prepareStatement(SELECT_BY_RESTAURANT_QUERY);

	        stmt.setInt(1, restaurantId);

	        ResultSet res = stmt.executeQuery();

	        while (res.next()) {

	            int menuId = res.getInt("menuId");
	            int id = res.getInt("RestaurantId");
	            String itemname = res.getString("itemName");
	            String description = res.getString("description");
	            double price = res.getDouble("price");
	            boolean available = res.getBoolean("isAvailable");
	            String category = res.getString("category");
	            Timestamp createdAt = res.getTimestamp("createdAt");
	            Timestamp updatedAt = res.getTimestamp("updatedAt");
	            Timestamp deletedAt = res.getTimestamp("deletedAt");
	       	 String photo = res.getString("photo");
			 boolean Veg = res.getBoolean("isVeg");

	            Menu menu = new Menu(
	                    menuId,
	                    id,
	                    itemname,
	                    description,
	                    price,
	                    available,
	                    category,
	                    createdAt,
	                    updatedAt,
	                    deletedAt,
	                    photo,
	                    Veg
	            );

	            list.add(menu);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	@Override
	public Menu getMenuById(int menuId) {

	    Menu menu = null;

	    String query =
	            "SELECT * FROM menu WHERE menuId = ?";

	    Connection connection =
	            DBConnection.getConnection();

	    try {

	        PreparedStatement stmt =
	                connection.prepareStatement(query);

	        stmt.setInt(1, menuId);

	        ResultSet res =
	                stmt.executeQuery();

	        if (res.next()) {

	            menu = new Menu();

	            menu.setMenuId(
	                    res.getInt("menuId")
	            );

	            menu.setRestaurantId(
	                    res.getInt("restaurantId")
	            );

	            menu.setItemName(
	                    res.getString("itemName")
	            );

	            menu.setDescription(
	                    res.getString("description")
	            );

	            menu.setPrice(
	                    res.getDouble("price")
	            );

	            menu.setAvailable(
	                    res.getBoolean("isAvailable")
	            );

	            menu.setCategory(
	                    res.getString("category")
	            );

	            menu.setCreatedAt(
	                    res.getTimestamp("createdAt")
	            );

	            menu.setUpdatedAt(
	                    res.getTimestamp("updatedAt")
	            );

	            menu.setDeletedAt(
	                    res.getTimestamp("deletedAt")
	            );

	            menu.setPhoto(
	                    res.getString("photo")
	            );

	            menu.setVeg(
	                    res.getBoolean("isVeg")
	            );
	        }

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return menu;
	}
	
	

}
