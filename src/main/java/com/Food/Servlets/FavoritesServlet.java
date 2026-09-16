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

@WebServlet("/favorites")
public class FavoritesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =====================================================
    // GET → SHOW FAVORITES
    // =====================================================

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath() +
                "/login.jsp?error=login_required"
            );

            return;
        }

        Integer userId =
                (Integer) session.getAttribute("userId");

        List<Map<String, Object>> favorites =
                new ArrayList<>();

        String sql =
            "SELECT f.favoriteId, " +
            "m.menuId, " +
            "m.itemName, " +
            "m.description, " +
            "m.price, " +
            "m.photo, " +
            "m.RestaurantId, " +
            "r.Name AS restaurantName " +
            "FROM Favorites f " +
            "JOIN menu m ON f.menuId = m.menuId " +
            "LEFT JOIN Restaurant r " +
            "ON m.RestaurantId = r.RestaurantId " +
            "WHERE f.userId = ? " +
            "ORDER BY f.createdAt DESC";

        try {

            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement stmt =
                    connection.prepareStatement(sql);

            stmt.setInt(1, userId);

            ResultSet rs =
                    stmt.executeQuery();

            while (rs.next()) {

                Map<String, Object> item =
                        new HashMap<>();

                item.put("favoriteId",
                        rs.getInt("favoriteId"));

                item.put("menuId",
                        rs.getInt("menuId"));

                item.put("itemName",
                        rs.getString("itemName"));

                item.put("description",
                        rs.getString("description"));

                item.put("price",
                        rs.getDouble("price"));

                item.put("photo",
                        rs.getString("photo"));

                item.put("restaurantId",
                        rs.getInt("RestaurantId"));

                item.put("restaurantName",
                        rs.getString("restaurantName"));

                favorites.add(item);
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                "error",
                "Unable to load favorites."
            );
        }

        request.setAttribute(
            "favorites",
            favorites
        );

        request.getRequestDispatcher(
            "/favorites.jsp"
        ).forward(request, response);
    }


    // =====================================================
    // POST → ADD / REMOVE FAVORITE
    // =====================================================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.setCharacterEncoding("UTF-8");
        response.setContentType(
            "application/json; charset=UTF-8"
        );

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.setStatus(
                HttpServletResponse.SC_UNAUTHORIZED
            );

            response.getWriter().write(
                "{\"error\":\"login_required\"}"
            );

            return;
        }

        Integer userId =
                (Integer) session.getAttribute("userId");

        String menuIdParam =
                request.getParameter("menuId");

        String action =
                request.getParameter("action");

        if (menuIdParam == null ||
            action == null) {

            response.setStatus(
                HttpServletResponse.SC_BAD_REQUEST
            );

            response.getWriter().write(
                "{\"error\":\"missing_parameters\"}"
            );

            return;
        }

        int menuId =
                Integer.parseInt(menuIdParam);

        Connection connection = null;

        try {

            connection =
                    DBConnection.getConnection();

            // =================================================
            // CHECK WHETHER ALREADY FAVORITED
            // =================================================

            String checkSql =
                "SELECT favoriteId " +
                "FROM Favorites " +
                "WHERE userId = ? AND menuId = ?";

            PreparedStatement checkStmt =
                    connection.prepareStatement(checkSql);

            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, menuId);

            ResultSet rs =
                    checkStmt.executeQuery();

            boolean exists = rs.next();


            // =================================================
            // TOGGLE
            // =================================================

            if ("toggle".equals(action)) {

                if (exists) {

                    String deleteSql =
                        "DELETE FROM Favorites " +
                        "WHERE userId = ? AND menuId = ?";

                    PreparedStatement deleteStmt =
                            connection.prepareStatement(
                                deleteSql
                            );

                    deleteStmt.setInt(1, userId);
                    deleteStmt.setInt(2, menuId);

                    deleteStmt.executeUpdate();

                    response.getWriter().write(
                        "{\"favorite\":false}"
                    );

                } else {

                    String insertSql =
                        "INSERT INTO Favorites " +
                        "(userId, menuId) " +
                        "VALUES (?, ?)";

                    PreparedStatement insertStmt =
                            connection.prepareStatement(
                                insertSql
                            );

                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, menuId);

                    insertStmt.executeUpdate();

                    response.getWriter().write(
                        "{\"favorite\":true}"
                    );
                }

                return;
            }


            // =================================================
            // REMOVE
            // =================================================

            if ("remove".equals(action)) {

                String deleteSql =
                    "DELETE FROM Favorites " +
                    "WHERE userId = ? AND menuId = ?";

                PreparedStatement deleteStmt =
                        connection.prepareStatement(
                            deleteSql
                        );

                deleteStmt.setInt(1, userId);
                deleteStmt.setInt(2, menuId);

                deleteStmt.executeUpdate();

                response.getWriter().write(
                    "{\"favorite\":false}"
                );

                return;
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                "{\"error\":\"server_error\"}"
            );
        }
    }
}
