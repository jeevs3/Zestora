package com.Food.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.Food.DAO.UserDAO;
import com.Food.Model.User;
import com.Food.Utility.DBConnection;

public class UserDAOImpl implements UserDAO{
	private final String INSERT_QUERY =
	        "INSERT INTO user(userName, password, email, address, role, createDate, loginDate, phone, pincode, instruction) "
	        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	private final String SELECT_QUERY = "SELECT * FROM user where userId = ?";
	
	private final String UPDATE_QUERY = "UPDATE user SET userName = ?, password = ?, email = ?,"
			+ "address = ?, loginDate = ?, phone = ?,pincode = ?,instruction = ? WHERE userId = ?";
	
	private final String DELETE_QUERY = "DELETE FROM user WHERE userId = ?";
	
	private final String SELECT_ALL_QUERY = "SELECT * FROM user";

	private Connection connection;

	private User user2;

	@Override
	public boolean addUser(User user) {

	    String query = "INSERT INTO user "
	            + "(userName, password, email, address, role, createDate, loginDate, phone, pincode, instruction) "
	            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    Connection connection = DBConnection.getConnection();

	    try {
	        PreparedStatement stmt = connection.prepareStatement(query);

	        stmt.setString(1, user.getUserName());
	        stmt.setString(2, user.getPassword());
	        stmt.setString(3, user.getEmail());
	        stmt.setString(4, user.getAddress());
	        stmt.setString(5, user.getRole());
	        

	        Timestamp now = new Timestamp(System.currentTimeMillis());

	        stmt.setTimestamp(6, now);
	        stmt.setTimestamp(7, now);

	        stmt.setString(8, user.getPhone());
	        stmt.setString(9, user.getPincode());
	        stmt.setString(10, user.getInstruction());

	        int rows = stmt.executeUpdate();

	        return rows > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	@Override
	public User getUser(int userId) {
		User user = null;
		
		connection = DBConnection.getConnection();
		try {
			PreparedStatement pstmt= connection.prepareStatement(SELECT_QUERY);
			
			pstmt.setInt(1, userId);
			
			ResultSet res = pstmt.executeQuery();
			
			while(res.next()) {
				int id = res.getInt("userId");
				String userName = res.getString("userName");
				String password = res.getString("password");
				String email = res.getString("email");
				String address = res.getString("address");
				String role=res.getString("role");
				Timestamp createdDate = res.getTimestamp("createDate");
				Timestamp lastLoginDate = res.getTimestamp("LoginDate");
				String phone = res.getString("phone");
				String pincode = res.getString("pincode");
				String instruction = res.getString("instruction");
				
				user = new User(userId, userName, password, email, address, role, createdDate, lastLoginDate,phone,pincode,instruction);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		// TODO Auto-generated method stub
	return user;
	}

	@Override
	public void updateUser(User user) {
		
		
		Connection connection = DBConnection.getConnection();
		try {
		PreparedStatement pstmt= connection.prepareStatement(UPDATE_QUERY);
		
		pstmt.setString(1,  user.getUserName());
		pstmt.setString(2,  user.getPassword());
		pstmt.setString(3,  user.getEmail());
		pstmt.setString(4,  user.getAddress());
		pstmt.setTimestamp(5,  new Timestamp(System.currentTimeMillis()));
		pstmt.setString(6, user.getPhone());
		pstmt.setString(7, user.getPincode());
		pstmt.setString(8, user.getInstruction());
		pstmt.setInt(9,  user.getUserId());
	
	
		pstmt.executeUpdate();
		
		}catch(SQLException e) {
			e.printStackTrace();
		}
	
	}

	@Override
	public void deleteUser(int userId) {
		
		Connection connection = DBConnection.getConnection();
		try {
			PreparedStatement pstmt= connection.prepareStatement(DELETE_QUERY);

			pstmt.setInt(1,  userId);
			pstmt.executeUpdate();
		
	    }catch(SQLException e) {
		e.printStackTrace();
	    }
		
}
		// TODO Auto-generated method stub		
	@Override
	public List<User> getAllUsers() {
		List<User> list = new ArrayList<User>();
		Connection connection = DBConnection.getConnection();
		try {
			Statement stmt = connection.createStatement();
			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);
			
			while(res.next()) {
				int userid = res.getInt("userId");
				String userName = res.getString("userName");
				String password = res.getString("password");
				String email = res.getString("email");
				String address = res.getString("address");
				String role=res.getString("role");
				Timestamp createdDate = res.getTimestamp("createDate");
				Timestamp lastLoginDate = res.getTimestamp("LoginDate");
				String phone = res.getString("phone");
				String pincode = res.getString("pincode");
				String instruction = res.getString("instruction");
				
				User user = new User(userid,userName, password, email, address, role, createdDate, lastLoginDate, phone, pincode,instruction);
				list.add(user);
		}
			
		}
			catch(SQLException e) {
				e.printStackTrace();
			    }
		return list;
	}
	
	
	
	@Override
	public User login(String email, String password) {

	    User user = null;

	    String LOGIN_QUERY =
	            "SELECT * FROM user WHERE email = ? AND password = ?";

	    Connection connection = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt =
	                connection.prepareStatement(LOGIN_QUERY);

	        pstmt.setString(1, email);
	        pstmt.setString(2, password);

	        ResultSet res = pstmt.executeQuery();

	        if (res.next()) {

	            int userId = res.getInt("userId");
	            String userName = res.getString("userName");
	            String userPassword = res.getString("password");
	            String userEmail = res.getString("email");
	            String address = res.getString("address");
	            String role = res.getString("role");
	            Timestamp createdDate = res.getTimestamp("createDate");
	            Timestamp lastLoginDate = res.getTimestamp("loginDate");
	            String phone = res.getString("phone");
	            String pincode = res.getString("pincode");
	            String instruction = res.getString("instruction");

	            user = new User(
	            		userId,
	                    userName,
	                    userPassword,
	                    userEmail,
	                    address,
	                    role,
	                    createdDate,
	                    lastLoginDate,
	                    phone,
	                    pincode,
	                    instruction
	                    
	            );
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return user;
	}
	@Override
	public void updateLoginDate(int userId) {

	    String query =
	        "UPDATE user SET LoginDate = CURRENT_TIMESTAMP WHERE userId = ?";

	    Connection connection = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt =
	                connection.prepareStatement(query);

	        pstmt.setInt(1, userId);

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public User getUserByEmail(String email) {

	    User user = null;

	    String query = "SELECT * FROM user WHERE email = ?";

	    Connection connection = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt = connection.prepareStatement(query);

	        pstmt.setString(1, email);

	        ResultSet res = pstmt.executeQuery();

	        if (res.next()) {

	            int userId = res.getInt("userId");
	            String userName = res.getString("userName");
	            String userPassword = res.getString("password");
	            String userEmail = res.getString("email");
	            String address = res.getString("address");
	            String role = res.getString("role");
	            Timestamp createdDate = res.getTimestamp("createDate");
	            Timestamp lastLoginDate = res.getTimestamp("loginDate");
	            String phone = res.getString("phone");
	            String pincode = res.getString("pincode");
	            String instruction = res.getString("instruction");

	            user = new User(
	                    userId,
	                    userName,
	                    userPassword,
	                    userEmail,
	                    address,
	                    role,
	                    createdDate,
	                    lastLoginDate, 
	                    phone,
	                    pincode,
	                    instruction
	            );
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return user;
	}
	@Override
	public User getUserByEmailOrPhone(String email, String phone, String password) {

	    User user = null;

	    String query =
	        "SELECT * FROM user " +
	        "WHERE (email = ? OR phone = ?) " +
	        "AND password = ?";

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement pstmt = connection.prepareStatement(query)) {

	        pstmt.setString(1, email);
	        pstmt.setString(2, phone);
	        pstmt.setString(3, password);

	        ResultSet res = pstmt.executeQuery();

	        if (res.next()) {

	            user = new User();

	            user.setUserId(res.getInt("userId"));
	            user.setUserName(res.getString("userName"));
	            user.setPassword(res.getString("password"));
	            user.setEmail(res.getString("email"));
	            user.setAddress(res.getString("address"));
	            user.setRole(res.getString("role"));
	            user.setCreatedDate(res.getTimestamp("createDate"));
	            user.setLastLoginDate(res.getTimestamp("loginDate"));
	            user.setPhone(res.getString("phone"));
	            user.setPincode(res.getString("pincode"));
	            user.setInstruction(res.getString("instruction"));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return user;
	}
	@Override
	public void updateCheckoutDetails(
	        int userId,
	        String userName,
	        String phone,
	        String address,
	        String pincode,
	        String instruction) {

	    String query =
	            "UPDATE user SET userName = ?, phone = ?, address = ?, "
	            + "pincode = ?, instruction = ? WHERE userId = ?";

	    Connection connection = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt =
	                connection.prepareStatement(query);

	        pstmt.setString(1, userName);
	        pstmt.setString(2, phone);
	        pstmt.setString(3, address);
	        pstmt.setString(4, pincode);
	        pstmt.setString(5, instruction);
	        pstmt.setInt(6, userId);

	        pstmt.executeUpdate();

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }
	}

	public User getUserByPhone(String phone) {

	    User user = null;

	    String sql =
	            "SELECT * FROM User WHERE phone = ?";

	    try {

	        Connection con =
	                DBConnection.getConnection();

	        PreparedStatement ps =
	                con.prepareStatement(sql);

	        ps.setString(1, phone);

	        ResultSet rs =
	                ps.executeQuery();

	        if (rs.next()) {

	            user = new User();

	            user.setUserId(
	                    rs.getInt("userId")
	            );

	            user.setUserName(
	                    rs.getString("userName")
	            );

	            user.setPassword(
	                    rs.getString("password")
	            );

	            user.setEmail(
	                    rs.getString("email")
	            );

	            user.setAddress(
	                    rs.getString("address")
	            );

	            user.setRole(
	                    rs.getString("role")
	            );

	            user.setPhone(
	                    rs.getString("phone")
	            );

	            user.setPincode(
	                    rs.getString("pincode")
	            );

	            user.setInstruction(
	                    rs.getString("instruction")
	            );

	            user.setCreatedDate(
	                    rs.getTimestamp("createdDate")
	            );

	            user.setLastLoginDate(
	                    rs.getTimestamp("lastLoginDate")
	            );
	        }

	        rs.close();
	        ps.close();
	        con.close();

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    return user;
	}

	@Override
	public boolean updatePassword(int userId, String newPassword) {

	    String sql = "UPDATE user SET password = ? WHERE userId = ?";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, newPassword);
	        ps.setInt(2, userId);

	        int rows = ps.executeUpdate();

	        return rows > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return false;
	}

	

}
