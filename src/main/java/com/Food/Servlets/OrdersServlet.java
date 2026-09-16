package com.Food.Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Food.Utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // LOGIN CHECK
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=login_required"
            );
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        List<Map<String, Object>> orders = new ArrayList<>();

        String orderQuery =
            "SELECT o.orderId, o.restaurantId, " +
            "o.customerName, o.phone, o.deliveryAddress, " +
            "o.pincode, o.instruction, o.itemTotal, " +
            "o.deliveryFee, o.discount, o.totalAmount, " +
            "o.paymentMethod, o.paymentStatus, o.orderStatus, " +
            "o.createdAt, r.name AS restaurantName " +
            "FROM Orders o " +
            "LEFT JOIN Restaurant r " +
            "ON o.restaurantId = r.restaurantId " +
            "WHERE o.userId = ? " +
            "ORDER BY o.createdAt DESC";

        String itemQuery =
            "SELECT oi.orderItemId, oi.menuId, oi.quantity, oi.price, " +
            "m.itemName, m.photo " +
            "FROM OrderItem oi " +
            "LEFT JOIN Menu m ON oi.menuId = m.menuId " +
            "WHERE oi.orderId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement orderStatement =
                 connection.prepareStatement(orderQuery)) {

            orderStatement.setInt(1, userId);

            try (ResultSet orderResult =
                     orderStatement.executeQuery()) {

                while (orderResult.next()) {

                    Map<String, Object> order = new HashMap<>();

                    int orderId =
                        orderResult.getInt("orderId");

                    order.put("orderId", orderId);
                    order.put("restaurantId",
                              orderResult.getInt("restaurantId"));
                    order.put("restaurantName",
                              orderResult.getString("restaurantName"));

                    order.put("customerName",
                              orderResult.getString("customerName"));
                    order.put("phone",
                              orderResult.getString("phone"));
                    order.put("deliveryAddress",
                              orderResult.getString("deliveryAddress"));
                    order.put("pincode",
                              orderResult.getString("pincode"));
                    order.put("instruction",
                              orderResult.getString("instruction"));

                    order.put("itemTotal",
                              orderResult.getDouble("itemTotal"));
                    order.put("deliveryFee",
                              orderResult.getDouble("deliveryFee"));
                    order.put("discount",
                              orderResult.getDouble("discount"));
                    order.put("totalAmount",
                              orderResult.getDouble("totalAmount"));

                    order.put("paymentMethod",
                              orderResult.getString("paymentMethod"));
                    order.put("paymentStatus",
                              orderResult.getString("paymentStatus"));
                    order.put("orderStatus",
                              orderResult.getString("orderStatus"));
                    order.put("createdAt",
                              orderResult.getTimestamp("createdAt"));

                    // -----------------------------
                    // ORDER ITEMS
                    // -----------------------------

                    List<Map<String, Object>> items =
                        new ArrayList<>();

                    try (PreparedStatement itemStatement =
                             connection.prepareStatement(itemQuery)) {

                        itemStatement.setInt(1, orderId);

                        try (ResultSet itemResult =
                                 itemStatement.executeQuery()) {

                            while (itemResult.next()) {

                                Map<String, Object> item =
                                    new HashMap<>();

                                item.put(
                                    "orderItemId",
                                    itemResult.getInt("orderItemId")
                                );

                                item.put(
                                    "menuId",
                                    itemResult.getInt("menuId")
                                );

                                item.put(
                                    "quantity",
                                    itemResult.getInt("quantity")
                                );

                                item.put(
                                    "price",
                                    itemResult.getDouble("price")
                                );

                                item.put(
                                    "itemName",
                                    itemResult.getString("itemName")
                                );

                                item.put(
                                    "photo",
                                    itemResult.getString("photo")
                                );

                                items.add(item);
                            }
                        }
                    }

                    order.put("items", items);

                    orders.add(order);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                "errorMessage",
                "Unable to load your orders."
            );
        }

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/orders.jsp")
               .forward(request, response);
    }
}
