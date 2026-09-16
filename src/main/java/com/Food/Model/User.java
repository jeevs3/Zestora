package com.Food.Model;

import java.sql.Timestamp;

public class User {
	int userId;
	String userName;
	String password;
	String email;
	String address;
	String role;
	Timestamp createdDate;
	Timestamp lastLoginDate;
	String phone;
	String pincode;
	String instruction;
	
	public User() {
		
	}
	
	public User(int userId, String userName, String password, String email, String address, String role,
			Timestamp createdDate, Timestamp lastLoginDate, String phone,String pincode,String instruction) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.password = password;
		this.email = email;
		this.address = address;
		this.role = role;
		this.createdDate = createdDate;
		this.lastLoginDate = lastLoginDate;
		this.phone = phone;
		this.pincode = pincode;
		this.instruction = instruction;
		}

	public User(String userName, String password, String email, String address, String role, Timestamp createdDate,
			Timestamp lastLoginDate, String phone, String pincode,String instruction) {
		super();
		this.userName = userName;
		this.password = password;
		this.email = email;
		this.address = address;
		this.role = role;
		this.createdDate = createdDate;
		this.lastLoginDate = lastLoginDate;
		this.phone = phone;
		this.pincode = pincode;
		this.instruction = instruction;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	

	public String getInstruction() {
		return instruction;
	}

	public void setInstruction(String instruction) {
		this.instruction = instruction;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password + ", email=" + email
				+ ", address=" + address + ", role=" + role + ", createdDate=" + createdDate + ", lastLoginDate="
				+ lastLoginDate + ", phone=" + phone + ", pincode=" + pincode + ", instruction=" + instruction + "]";
	}

	

	
}
