package com.Food.Model;

public class Restaurant {
	
	int restaurantId;
    String name;
	String cuisineType;
	int deliveryTime;
	String address;
	int adminUserId;
	double rating;
	boolean isActive;
	String photo;
	boolean veg;
	String offer;
	String location;
	
	public Restaurant() {
		
	}

	public Restaurant(int restaurantId, String name, String cuisineType, int deliveryTime, String address,
			int adminUserId, double rating, boolean isActive, String photo, boolean veg, String offer, String location) {
		super();
		this.restaurantId = restaurantId;
		this.name = name;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.adminUserId = adminUserId;
		this.rating = rating;
		this.isActive = isActive;
		this.photo = photo;
		this.veg = veg;
		this.offer = offer;
		this.location = location;
		}
	
	

	public Restaurant(String name, String cuisineType, int deliveryTime, String address, int adminUserId, double rating,
			boolean isActive,String photo, boolean veg, String offer, String location) {
		super();
		this.name = name;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.adminUserId = adminUserId;
		this.rating = rating;
		this.isActive = isActive;
		this.photo = photo;
		this.veg = veg;
		this.offer = offer;
		this.location = location;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public  String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCuisineType() {
		return cuisineType;
	}

	public void setCuisineType(String cuisineType) {
		this.cuisineType = cuisineType;
	}

	public int getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(int deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getAdminUserId() {
		return adminUserId;
	}

	public void setAdminUserId(int adminUserId) {
		this.adminUserId = adminUserId;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public boolean Veg() {
		return veg;
	}

	public void setVeg(boolean veg) {
		this.veg = veg;
	}

	public String getOffer() {
		return offer;
	}

	public void setOffer(String offer) {
		this.offer = offer;
	}
	

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@Override
	public String toString() {
		return "Restaurant [restaurantId=" + restaurantId + ", name=" + name + ", cuisineType=" + cuisineType
				+ ", deliveryTime=" + deliveryTime + ", address=" + address + ", adminUserId=" + adminUserId
				+ ", rating=" + rating + ", isActive=" + isActive + ", photo=" + photo + ", veg=" + veg + ", offer="
				+ offer + ", location=" + location + "]";
	}

	
	
	


}
