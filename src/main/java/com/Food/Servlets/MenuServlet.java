package com.Food.Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.Food.Model.Cart;
import com.Food.Model.CartItem;
import com.Food.Model.Menu;
import com.Food.Model.Restaurant;
import com.Food.daoimp.CartDAOImpl;
import com.Food.daoimp.CartItemDAOImpl;
import com.Food.daoimp.MenuDAOImpl;
import com.Food.daoimp.RestaurantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String restaurantIdParam =
                req.getParameter("restaurantId");

        if (restaurantIdParam == null ||
            restaurantIdParam.isEmpty()) {

            resp.sendRedirect("restaurant.jsp");
            return;
        }

        int restaurantId =
                Integer.parseInt(restaurantIdParam);

        // ==========================================
        // RESTAURANT
        // ==========================================

        RestaurantDAOImpl restaurantDAO =
                new RestaurantDAOImpl();

        Restaurant restaurant =
                restaurantDAO.getRestaurant(restaurantId);

        // ==========================================
        // MENU
        // ==========================================

        MenuDAOImpl menuDAO =
                new MenuDAOImpl();

        List<Menu> menuList =
                menuDAO.getMenuByRestaurant(restaurantId);
        
        System.out.println("=================================");
        System.out.println("Restaurant ID: " + restaurantId);
        System.out.println("Menu List Size: " + menuList.size());

        for (Menu menu : menuList) {
            System.out.println(
                "Menu ID: " + menu.getMenuId()
                + " | Name: " + menu.getItemName()
                + " | Restaurant ID: " + menu.getRestaurantId()
            );
        }

        System.out.println("=================================");

        // ==========================================
        // CART ITEMS
        // ==========================================

        List<CartItem> cartItems =
                new ArrayList<CartItem>();

        HttpSession session =
                req.getSession(false);

        if (session != null) {

            Integer userId =
                    (Integer) session.getAttribute("userId");

            if (userId != null) {

                CartDAOImpl cartDAO =
                        new CartDAOImpl();

                Cart cart =
                        cartDAO.getCartByUserId(userId);

                if (cart != null) {

                    CartItemDAOImpl cartItemDAO =
                            new CartItemDAOImpl();

                    cartItems =
                            cartItemDAO.getCartItems(
                                    cart.getCartId()
                            );
                }
            }
        }

        // ==========================================
        // SEND TO JSP
        // ==========================================

        req.setAttribute("restaurant", restaurant);

        req.setAttribute(
                "allMenuByRestaurant",
                menuList
        );

        req.setAttribute(
                "cartItems",
                cartItems
        );

        RequestDispatcher rd =
                req.getRequestDispatcher("/menu.jsp");

        rd.forward(req, resp);
    }
}