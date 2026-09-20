package com.Food.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Food.DAO.CartDAO;
import com.Food.Model.Cart;
import com.Food.Utility.DBConnection;

public class CartDAOImpl implements CartDAO {

    private static final String INSERT_QUERY =
            "INSERT INTO cart (userId, restaurantId, totalAmount) VALUES (?, ?, ?)";

    private static final String SELECT_BY_USER_QUERY =
            "SELECT * FROM cart WHERE userId = ?";

    private static final String UPDATE_TOTAL_QUERY =
            "UPDATE cart SET totalAmount = ? WHERE cartId = ?";

    private static final String DELETE_QUERY =
            "DELETE FROM cart WHERE cartId = ?";


    @Override
    public int createCart(Cart cart) {

        Connection connection = DBConnection.getConnection();

        try {
            PreparedStatement stmt =
                    connection.prepareStatement(
                            INSERT_QUERY,
                            PreparedStatement.RETURN_GENERATED_KEYS
                    );

            stmt.setInt(1, cart.getUserId());
            stmt.setInt(2, cart.getRestaurantId());
            stmt.setDouble(3, cart.getTotalAmount());

            stmt.executeUpdate();

            ResultSet res = stmt.getGeneratedKeys();

            if (res.next()) {
                return res.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }


    @Override
    public Cart getCartByUserId(int userId) {

        Cart cart = null;

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(SELECT_BY_USER_QUERY);

            stmt.setInt(1, userId);

            ResultSet res = stmt.executeQuery();

            if (res.next()) {

                int cartId = res.getInt("cartId");
                int user = res.getInt("userId");
                int restaurantId = res.getInt("restaurantId");
                double totalAmount = res.getDouble("totalAmount");

                cart = new Cart(
                        cartId,
                        user,
                        restaurantId,
                        totalAmount
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }


    @Override
    public void updateTotalAmount(int cartId, double totalAmount) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(UPDATE_TOTAL_QUERY);

            stmt.setDouble(1, totalAmount);
            stmt.setInt(2, cartId);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteCart(int cartId) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(DELETE_QUERY);

            stmt.setInt(1, cartId);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void updateRestaurantId(int cartId, int restaurantId) {

        String query =
                "UPDATE cart SET restaurantId = ? WHERE cartId = ?";

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(query);

            stmt.setInt(1, restaurantId);
            stmt.setInt(2, cartId);

            stmt.executeUpdate();

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }
}
