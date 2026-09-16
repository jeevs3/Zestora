package com.Food.Utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static Connection getConnection() {

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Railway MySQL environment variables
			String host = System.getenv("MYSQLHOST");
			String port = System.getenv("MYSQLPORT");
			String database = System.getenv("MYSQLDATABASE");
			String username = System.getenv("MYSQLUSER");
			String password = System.getenv("MYSQLPASSWORD");

			/*
			 * Local development fallback. Password is NOT stored in the source code.
			 */
			if (host == null || host.isBlank()) {
				host = "127.0.0.1";
			}

			if (port == null || port.isBlank()) {
				port = "3306";
			}

			if (database == null || database.isBlank()) {
				database = "food_delivery_application";
			}

			if (username == null || username.isBlank()) {
				username = "root";
			}

			// For local Eclipse testing, set DB_PASSWORD as an
			// environment variable in your Eclipse Run Configuration.
			if (password == null || password.isBlank()) {
				password = System.getProperty("DB_PASSWORD");
			}

			if (password == null || password.isBlank()) {
				throw new SQLException("Database password is not configured. " + "Set MYSQLPASSWORD or DB_PASSWORD.");
			}

			String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?useSSL=false"
					+ "&allowPublicKeyRetrieval=true" + "&serverTimezone=UTC";

			Connection connection = DriverManager.getConnection(url, username, password);

			System.out.println("Database connected successfully!");

			return connection;

		} catch (ClassNotFoundException e) {

			System.out.println("MySQL JDBC Driver not found!");
			e.printStackTrace();

		} catch (SQLException e) {

			System.out.println("Database connection failed!");
			e.printStackTrace();
		}

		return null;
	}
}