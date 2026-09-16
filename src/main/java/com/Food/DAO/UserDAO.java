package com.Food.DAO;

import java.util.List;

import com.Food.Model.User;

public interface UserDAO {
	
	boolean addUser(User user);
	User getUser(int userId);
	void updateUser(User user);
	void deleteUser(int userId);
	List<User> getAllUsers();
	User login(String email, String password);
	void updateLoginDate(int userId);
	User getUserByEmail(String email);
	User getUserByEmailOrPhone(String email, String phone, String password);
	void updateCheckoutDetails(int userId, String userName, String phone, String address, String pincode,
			String instruction);
	User getUserByPhone(String phone);
	boolean updatePassword(int userId, String newPassword);


}
