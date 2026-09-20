package com.Food.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Food.DAO.RestaurantDAO;
import com.Food.Model.Restaurant;
import com.Food.Utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO{
	
	public static String INSERT_QUERY =
	        "INSERT INTO restaurant(Name, CuisineType, DeliveryTime, Address, AdminUserId, Rating, isActive, Photo, offer, veg, location) "
	        + "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
	
	public static String SELECT_QUERY = "SELECT * FROM restaurant WHERE RestaurantID = ?";
	
	public static String UPDATE_QUERY =
	        "UPDATE restaurant SET Name = ?, CuisineType = ?, DeliveryTime = ?, Address = ?, AdminUserId = ?, "
	        + "Rating = ?, isActive = ?, Photo = ?, offer = ?, veg = ?, location = ? "
	        + "WHERE RestaurantId = ?";
	
	public static String DELETE_QUERY = "DELETE  FROM restaurant WHERE RestaurantId = ?";
	
	public static String SELECT_ALL_QUERY = "SELECT * FROM restaurant";
	

	@Override
	public void addRestaurant(Restaurant restaurant) {
		
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(INSERT_QUERY);
			stmt.setString(1, restaurant.getName());
			stmt.setString(2, restaurant.getCuisineType());
			stmt.setInt(3, restaurant.getDeliveryTime());
			stmt.setString(4, restaurant.getAddress());
			stmt.setInt(5, restaurant.getAdminUserId());
			stmt.setDouble(6, restaurant.getRating());
			stmt.setBoolean(7, restaurant.isActive());
			stmt.setString(8, restaurant.getPhoto());
			stmt.setString(9, restaurant.getOffer());
			stmt.setBoolean(10, restaurant.Veg());
			stmt.setString(11, restaurant.getLocation());
			
			int i = stmt.executeUpdate();
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	@Override
	public Restaurant getRestaurant(int restaurantId) {
		
		Restaurant restaurant = null;
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(SELECT_QUERY);
			
			stmt.setInt(1, restaurantId);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				 int id = res.getInt("RestaurantId");
				 String name = res.getString("Name");
				 String cuisineType = res.getString("CuisineType");
				 int deliveryTime = res.getInt("DeliveryTime");
				 String address = res.getString("Address");
				 int adminUserId = res.getInt("AdminUserId");
				 double rating = res.getDouble("Rating");
				 boolean isActive = res.getBoolean("isActive");
				 String photo = res.getString("Photo");
				 boolean Veg = res.getBoolean("Veg");
				 String offer = res.getString("Offer");
				 String location = res.getString("location");
				 
				restaurant = new Restaurant(id ,name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, photo, Veg, offer, location);
				
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {
		
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(UPDATE_QUERY);
			
			stmt.setString(1, restaurant.getName());
			stmt.setString(2, restaurant.getCuisineType());
			stmt.setInt(3, restaurant.getDeliveryTime());
			stmt.setString(4, restaurant.getAddress());
			stmt.setInt(5, restaurant.getAdminUserId());
			stmt.setDouble(6, restaurant.getRating());
			stmt.setBoolean(7, restaurant.isActive());
			stmt.setString(8, restaurant.getPhoto());
			stmt.setString(9, restaurant.getOffer());
			stmt.setBoolean(10, restaurant.Veg());
			stmt.setString(11, restaurant.getLocation());
			stmt.setInt(12, restaurant.getRestaurantId());
			
		    stmt.executeUpdate();
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteRestaurant(int restaurantId) {
		
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(DELETE_QUERY);
			
			stmt.setInt(1, restaurantId);
			stmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Restaurant> getAllRestaurant() {
		List<Restaurant> list = new ArrayList<Restaurant>();
		
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(SELECT_ALL_QUERY);
					
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				 int id = res.getInt("RestaurantId");
				 String name = res.getString("Name");
				 String cuisineType = res.getString("CuisineType");
				 int deliveryTime = res.getInt("DeliveryTime");
				 String address = res.getString("Address");
				 int adminUserId = res.getInt("AdminUserId");
				 double rating = res.getDouble("Rating");
				 boolean isActive = res.getBoolean("isActive");
				 String photo = res.getString("Photo");
				 boolean Veg = res.getBoolean("Veg");
				 String offer = res.getString("Offer");
				 String location = res.getString("location");
				 
			    Restaurant restaurant = new Restaurant(id ,name, cuisineType, deliveryTime, address, adminUserId, rating, isActive,photo, Veg, offer, location);
				list.add(restaurant);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return list;
	}
	

}
