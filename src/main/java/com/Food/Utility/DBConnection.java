package com.Food.Utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String database = System.getenv("MYSQLDATABASE");
            String username = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD");

            // TiDB Cloud defaults
            if (host == null || host.isBlank()) {
                host = "gateway01.ap-southeast-1.prod.aws.tidbcloud.com";
            }

            if (port == null || port.isBlank()) {
                port = "4000";
            }

            if (database == null || database.isBlank()) {
                database = "test";
            }

            if (username == null || username.isBlank()) {
                username = "22YmW3eG8HwpGVs.root";
            }

            // Never hardcode the database password
            if (password == null || password.isBlank()) {
                password = System.getProperty("DB_PASSWORD");
            }

            if (password == null || password.isBlank()) {
                throw new SQLException("TiDB password is not configured.");
            }

            String url = "jdbc:mysql://" + host + ":" + port
                    + "/" + database
                    + "?sslMode=REQUIRED"
                    + "&serverTimezone=UTC";

            Connection connection =
                    DriverManager.getConnection(url, username, password);

            System.out.println("TiDB database connected successfully!");

            return connection;

        } catch (Exception e) {
            System.out.println("TiDB database connection failed!");
            e.printStackTrace();
            return null;
        }
    }
}