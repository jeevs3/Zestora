package com.Food.Model;

public class CartItem {
	
	  private int cartItemId;
	    private int cartId;
	    private int menuId;
	    private int quantity;
	    private double price;

	    public CartItem() {
	    }

	    public CartItem(int cartItemId, int cartId, int menuId, int quantity, double price) {
	        this.cartItemId = cartItemId;
	        this.cartId = cartId;
	        this.menuId = menuId;
	        this.quantity = quantity;
	        this.price = price;
	    }

	    public int getCartItemId() {
	        return cartItemId;
	    }

	    public void setCartItemId(int cartItemId) {
	        this.cartItemId = cartItemId;
	    }

	    public int getCartId() {
	        return cartId;
	    }

	    public void setCartId(int cartId) {
	        this.cartId = cartId;
	    }

	    public int getMenuId() {
	        return menuId;
	    }

	    public void setMenuId(int menuId) {
	        this.menuId = menuId;
	    }

	    public int getQuantity() {
	        return quantity;
	    }

	    public void setQuantity(int quantity) {
	        this.quantity = quantity;
	    }

	    public double getPrice() {
	        return price;
	    }

	    public void setPrice(double price) {
	        this.price = price;
	    }
	}


