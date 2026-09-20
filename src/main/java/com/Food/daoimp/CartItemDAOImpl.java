package com.Food.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Food.DAO.CartItemDAO;
import com.Food.Model.CartItem;
import com.Food.Utility.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

    private static final String INSERT_QUERY =
            "INSERT INTO CartItem (cartId, menuId, quantity, price) VALUES (?, ?, ?, ?)";

    private static final String SELECT_QUERY =
            "SELECT * FROM CartItem WHERE cartId = ?";

    private static final String UPDATE_QUERY =
            "UPDATE CartItem SET quantity = ? WHERE cartItemId = ?";

    private static final String DELETE_QUERY =
            "DELETE FROM CartItem WHERE cartItemId = ?";

    private static final String CLEAR_QUERY =
            "DELETE FROM CartItem WHERE cartId = ?";


    @Override
    public void addCartItem(CartItem cartItem) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(INSERT_QUERY);

            stmt.setInt(1, cartItem.getCartId());
            stmt.setInt(2, cartItem.getMenuId());
            stmt.setInt(3, cartItem.getQuantity());
            stmt.setDouble(4, cartItem.getPrice());

            System.out.println("========== INSERT CART ITEM ==========");
            System.out.println("Cart ID     = " + cartItem.getCartId());
            System.out.println("Menu ID     = " + cartItem.getMenuId());
            System.out.println("Quantity    = " + cartItem.getQuantity());
            System.out.println("Price       = " + cartItem.getPrice());

            int rows = stmt.executeUpdate();

            System.out.println("Rows inserted = " + rows);

            if (rows > 0) {
                System.out.println("CART ITEM INSERTED SUCCESSFULLY");
            }

            System.out.println("======================================");

        } catch (SQLException e) {

            System.out.println("========== CART ITEM INSERT ERROR ==========");
            e.printStackTrace();
            System.out.println("============================================");
        }
    }

    @Override
    public List<CartItem> getCartItems(int cartId) {

        List<CartItem> list = new ArrayList<CartItem>();

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(SELECT_QUERY);

            stmt.setInt(1, cartId);

            ResultSet res = stmt.executeQuery();

            while (res.next()) {

                int cartItemId = res.getInt("cartItemId");
                int id = res.getInt("cartId");
                int menuId = res.getInt("menuId");
                int quantity = res.getInt("quantity");
                double price = res.getDouble("price");

                CartItem cartItem = new CartItem(
                        cartItemId,
                        id,
                        menuId,
                        quantity,
                        price
                );

                list.add(cartItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }


    @Override
    public void updateQuantity(int cartItemId, int quantity) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(UPDATE_QUERY);

            stmt.setInt(1, quantity);
            stmt.setInt(2, cartItemId);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void removeCartItem(int cartItemId) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(DELETE_QUERY);

            stmt.setInt(1, cartItemId);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void clearCart(int cartId) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                    connection.prepareStatement(CLEAR_QUERY);

            stmt.setInt(1, cartId);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    @Override
    public CartItem getCartItemByCartIdAndMenuId(int cartId, int menuId) {

        CartItem cartItem = null;

        String query =
            "SELECT * FROM CartItem WHERE cartId = ? AND menuId = ?";

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement stmt =
                connection.prepareStatement(query);

            stmt.setInt(1, cartId);
            stmt.setInt(2, menuId);

            ResultSet res = stmt.executeQuery();

            if (res.next()) {

                cartItem = new CartItem(
                    res.getInt("cartItemId"),
                    res.getInt("cartId"),
                    res.getInt("menuId"),
                    res.getInt("quantity"),
                    res.getDouble("price")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItem;
    }
}