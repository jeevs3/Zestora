package com.Food.Model;

public class Cart {
	
	 private int cartId;
	    private int userId;
	    private int restaurantId;
	    private double totalAmount;

	    public Cart() {
	    }

	    public Cart(int cartId, int userId, int restaurantId, double totalAmount) {
	        this.cartId = cartId;
	        this.userId = userId;
	        this.restaurantId = restaurantId;
	        this.totalAmount = totalAmount;
	    }

	    public int getCartId() {
	        return cartId;
	    }

	    public void setCartId(int cartId) {
	        this.cartId = cartId;
	    }

	    public int getUserId() {
	        return userId;
	    }

	    public void setUserId(int userId) {
	        this.userId = userId;
	    }

	    public int getRestaurantId() {
	        return restaurantId;
	    }

	    public void setRestaurantId(int restaurantId) {
	        this.restaurantId = restaurantId;
	    }

	    public double getTotalAmount() {
	        return totalAmount;
	    }

	    public void setTotalAmount(double totalAmount) {
	        this.totalAmount = totalAmount;
	    }
	}


