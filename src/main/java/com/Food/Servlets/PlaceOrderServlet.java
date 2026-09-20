package com.Food.Servlets;

import java.io.IOException;
import java.util.List;

import com.Food.Model.Cart;
import com.Food.Model.CartItem;
import com.Food.Model.Menu;
import com.Food.Model.Restaurant;
import com.Food.Model.User;
import com.Food.daoimp.CartDAOImpl;
import com.Food.daoimp.CartItemDAOImpl;
import com.Food.daoimp.MenuDAOImpl;
import com.Food.daoimp.RestaurantDAOImpl;
import com.Food.daoimp.UserDAOImpl;
import com.Food.Utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // =====================================================
        // LOGIN CHECK
        // =====================================================

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/login.jsp?error=login_required"
            );

            return;
        }


        // =====================================================
        // PAYMENT METHOD
        // =====================================================

        String paymentMethod =
                req.getParameter("paymentMethod");

        if (paymentMethod == null ||
                paymentMethod.trim().isEmpty()) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/checkout?error=payment_required"
            );

            return;
        }


        // =====================================================
        // GET USER
        // =====================================================

        UserDAOImpl userDAO =
                new UserDAOImpl();

        User user =
                userDAO.getUser(userId);

        if (user == null) {

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "User not found"
            );

            return;
        }


        // =====================================================
        // ADDRESS
        // =====================================================

        String address =
                (String) session.getAttribute(
                        "selectedAddress"
                );

        String pincode =
                (String) session.getAttribute(
                        "selectedPincode"
                );


        // If Google Maps address is not selected,
        // use the saved User address.

        if (address == null ||
                address.trim().isEmpty()) {

            address = user.getAddress();
        }

        if (pincode == null ||
                pincode.trim().isEmpty()) {

            pincode = user.getPincode();
        }


        // =====================================================
        // VALIDATE ADDRESS
        // =====================================================

        if (address == null ||
                address.trim().isEmpty() ||
                pincode == null ||
                pincode.trim().isEmpty()) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/checkout?error=address_required"
            );

            return;
        }


        // =====================================================
        // GET CART
        // =====================================================

        CartDAOImpl cartDAO =
                new CartDAOImpl();

        Cart cart =
                cartDAO.getCartByUserId(userId);

        if (cart == null) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/cart"
            );

            return;
        }


        // =====================================================
        // GET CART ITEMS
        // =====================================================

        CartItemDAOImpl cartItemDAO =
                new CartItemDAOImpl();

        List<CartItem> cartItems =
                cartItemDAO.getCartItems(
                        cart.getCartId()
                );

        if (cartItems == null ||
                cartItems.isEmpty()) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/cart"
            );

            return;
        }


        // =====================================================
        // CALCULATE TOTAL
        // =====================================================

        double itemTotal = 0.0;

        for (CartItem item : cartItems) {

            itemTotal +=
                    item.getPrice()
                    * item.getQuantity();
        }


        double deliveryFee = 40.0;

        double discount = 0.0;

        double totalAmount =
                itemTotal
                + deliveryFee
                - discount;


        // =====================================================
        // GET RESTAURANT
        // =====================================================

        RestaurantDAOImpl restaurantDAO =
                new RestaurantDAOImpl();

        Restaurant restaurant =
                restaurantDAO.getRestaurant(
                        cart.getRestaurantId()
                );
     // =====================================================
     // GET MENU DETAILS FOR ORDER SUCCESS PAGE
     // =====================================================

     MenuDAOImpl menuDAO = new MenuDAOImpl();

     List<Menu> orderMenus = new java.util.ArrayList<>();

     for (CartItem item : cartItems) {

         Menu menu = menuDAO.getMenuById(
                 item.getMenuId()
         );

         if (menu != null) {
             orderMenus.add(menu);
         }
     }

        if (restaurant == null) {

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Restaurant not found"
            );

            return;
        }


        // =====================================================
        // INSERT ORDER
        // =====================================================

        String orderQuery =
                "INSERT INTO orders "
                + "(userId, restaurantId, customerName, phone, "
                + "deliveryAddress, pincode, instruction, "
                + "itemTotal, deliveryFee, discount, totalAmount, "
                + "paymentMethod, paymentStatus, orderStatus) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


        String instruction = user.getInstruction();

        if (instruction == null) {
            instruction = "";
        }


        Connection connection =
                DBConnection.getConnection();

        int orderId = 0;


        try {

            connection.setAutoCommit(false);


            // =================================================
            // CREATE ORDER
            // =================================================

            PreparedStatement orderStatement =
                    connection.prepareStatement(
                            orderQuery,
                            PreparedStatement.RETURN_GENERATED_KEYS
                    );


            orderStatement.setInt(
                    1,
                    userId
            );

            orderStatement.setInt(
                    2,
                    cart.getRestaurantId()
            );

            orderStatement.setString(
                    3,
                    user.getUserName()
            );

            orderStatement.setString(
                    4,
                    user.getPhone()
            );

            orderStatement.setString(
                    5,
                    address
            );

            orderStatement.setString(
                    6,
                    pincode
            );

            orderStatement.setString(
                    7,
                    instruction
            );

            orderStatement.setDouble(
                    8,
                    itemTotal
            );

            orderStatement.setDouble(
                    9,
                    deliveryFee
            );

            orderStatement.setDouble(
                    10,
                    discount
            );

            orderStatement.setDouble(
                    11,
                    totalAmount
            );

            orderStatement.setString(
                    12,
                    paymentMethod
            );


            // For now payment is not actually processed.
            orderStatement.setString(
                    13,
                    "PENDING"
            );

            orderStatement.setString(
                    14,
                    "PLACED"
            );


            orderStatement.executeUpdate();


            // =================================================
            // GET GENERATED ORDER ID
            // =================================================

            ResultSet generatedKeys =
                    orderStatement.getGeneratedKeys();


            if (generatedKeys.next()) {

                orderId =
                        generatedKeys.getInt(1);

            } else {

                throw new SQLException(
                        "Order ID could not be generated."
                );
            }


            // =================================================
            // INSERT ORDER ITEMS
            // =================================================

            String itemQuery =
                    "INSERT INTO orderitem "
                    + "(orderId, menuId, quantity, price) "
                    + "VALUES (?, ?, ?, ?)";


            PreparedStatement itemStatement =
                    connection.prepareStatement(
                            itemQuery
                    );


            for (CartItem item : cartItems) {

                itemStatement.setInt(
                        1,
                        orderId
                );

                itemStatement.setInt(
                        2,
                        item.getMenuId()
                );

                itemStatement.setInt(
                        3,
                        item.getQuantity()
                );

                itemStatement.setDouble(
                        4,
                        item.getPrice()
                );

                itemStatement.addBatch();
            }


            itemStatement.executeBatch();


            // =================================================
            // EVERYTHING SUCCESSFUL
            // =================================================

            connection.commit();


            // =================================================
            // CLEAR CART
            // =================================================

            cartItemDAO.clearCart(
                    cart.getCartId()
            );


            cartDAO.deleteCart(
                    cart.getCartId()
            );


            // =================================================
            // LOAD DATA FOR SUCCESS PAGE
            // =================================================

         // =====================================================
         // LOAD DATA FOR SUCCESS PAGE
         // =====================================================

         req.setAttribute(
                 "orderId",
                 String.valueOf(orderId)
         );

         req.setAttribute(
                 "restaurantName",
                 restaurant.getName()
         );

         req.setAttribute(
                 "deliveryAddress",
                 address
         );

         req.setAttribute(
                 "pincode",
                 pincode
         );

         req.setAttribute(
                 "paymentMethod",
                 paymentMethod
         );

         req.setAttribute(
                 "paymentStatus",
                 "Pending"
         );

         req.setAttribute(
                 "orderItems",
                 cartItems
         );

         req.setAttribute(
                 "orderMenus",
                 orderMenus
         );

         req.setAttribute(
                 "itemTotal",
                 itemTotal
         );

         req.setAttribute(
                 "deliveryFee",
                 deliveryFee
         );

         req.setAttribute(
                 "discount",
                 discount
         );

         req.setAttribute(
                 "toPay",
                 totalAmount
         );

       

            // =================================================
            // OPEN SUCCESS PAGE
            // =================================================

            req.getRequestDispatcher(
                    "/placeOrder.jsp"
            ).forward(req, resp);


        } catch (SQLException e) {

            try {
                connection.rollback();
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }

            e.printStackTrace();

            resp.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to place order."
            );

        } finally {

            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
