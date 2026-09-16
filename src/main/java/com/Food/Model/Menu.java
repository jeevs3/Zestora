package com.Food.Model;

import java.sql.Timestamp;

public class Menu {
	int menuId;
	int RestaurantId;
	String itemName;
	String description;
	double price;
	boolean isAvailable;
	String category;
	Timestamp createdAt;
	Timestamp updatedAt;
	Timestamp deletedAt;
	String photo;
	boolean isVeg;
	
    public Menu() {
    }

	public Menu(int menuId, int RestaurantId, String itemName, String description, double price, boolean isAvailable,
			String category, Timestamp createdAt, Timestamp updatedAt, Timestamp deletedAt, String photo, boolean isVeg) {
		super();
		this.menuId = menuId;
		this.RestaurantId = RestaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.deletedAt = deletedAt;
		this.photo = photo;
		this.isVeg = isVeg;
	}

	public Menu(int RestaurantId, String itemName, String description, double price, boolean isAvailable,
			String category, Timestamp createdAt, Timestamp updatedAt, Timestamp deletedAt, String photo, boolean isVeg) {
		super();
		this.RestaurantId = RestaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.deletedAt = deletedAt;
		this.photo = photo;
		this.isVeg = isVeg;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getRestaurantId() {
		return RestaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.RestaurantId = restaurantId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Timestamp getDeletedAt() {
		return deletedAt;
	}

	public void setDeletedAt(Timestamp deletedAt) {
		this.deletedAt = deletedAt;
	}
	

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public boolean isVeg() {
		return isVeg;
	}

	public void setVeg(boolean isVeg) {
		this.isVeg = isVeg;
	}

	@Override
	public String toString() {
		return "Menu [menuId=" + menuId + ", RestaurantId=" + RestaurantId + ", itemName=" + itemName
				+ ", description=" + description + ", price=" + price + ", isAvailable=" + isAvailable + ", category="
				+ category + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", deletedAt=" + deletedAt
				+ ", photo=" + photo + ", isVeg=" + isVeg + "]";
	}

	
    
	

}
