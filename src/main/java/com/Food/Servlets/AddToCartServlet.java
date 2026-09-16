package com.Food.Servlets;

import java.io.IOException;
import java.util.List;

import com.Food.Model.Cart;
import com.Food.Model.CartItem;
import com.Food.Model.Menu;
import com.Food.daoimp.CartDAOImpl;
import com.Food.daoimp.CartItemDAOImpl;
import com.Food.daoimp.MenuDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {

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
        // READ MENU ID
        // =====================================================

        String menuIdParam =
                req.getParameter("menuId");

        String action =
                req.getParameter("action");

        if (menuIdParam == null ||
            menuIdParam.trim().isEmpty()) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Menu ID is missing"
            );

            return;
        }

        if (action == null || action.trim().isEmpty()) {
            action = "add";
        }

        int menuId;

        try {

            menuId = Integer.parseInt(menuIdParam);

        } catch (NumberFormatException e) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid menu ID"
            );

            return;
        }

        // =====================================================
        // GET MENU FROM DATABASE
        // =====================================================

        MenuDAOImpl menuDAO =
                new MenuDAOImpl();

        Menu menu =
                menuDAO.getMenuById(menuId);

        if (menu == null) {

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Menu item not found"
            );

            return;
        }

        // =====================================================
        // GET RESTAURANT ID + PRICE FROM DATABASE
        // =====================================================

        int restaurantId =
                menu.getRestaurantId();

        double price =
                menu.getPrice();

        // =====================================================
        // CART DAO
        // =====================================================

        CartDAOImpl cartDAO =
                new CartDAOImpl();

        CartItemDAOImpl cartItemDAO =
                new CartItemDAOImpl();

        // =====================================================
        // GET USER CART
        // =====================================================

        Cart cart =
                cartDAO.getCartByUserId(userId);

        // =====================================================
        // DIFFERENT RESTAURANT
        // =====================================================

        if (cart != null &&
            cart.getRestaurantId() != restaurantId) {

            /*
             * User selected an item from another restaurant.
             *
             * Remove all items from the previous restaurant.
             * Then change the cart to the new restaurant.
             */

            cartItemDAO.clearCart(
                    cart.getCartId()
            );

            cartDAO.updateRestaurantId(
                    cart.getCartId(),
                    restaurantId
            );

            // Get updated cart
            cart =
                    cartDAO.getCartByUserId(userId);
        }

        // =====================================================
        // CREATE CART IF USER HAS NO CART
        // =====================================================

        if (cart == null) {

            Cart newCart =
                    new Cart();

            newCart.setUserId(userId);

            newCart.setRestaurantId(
                    restaurantId
            );

            newCart.setTotalAmount(0);

            cartDAO.createCart(newCart);

            cart =
                    cartDAO.getCartByUserId(userId);
        }

        // =====================================================
        // GET EXISTING CART ITEM
        // =====================================================

        CartItem existingItem =
                cartItemDAO.getCartItemByCartIdAndMenuId(
                        cart.getCartId(),
                        menuId
                );

        // =====================================================
        // ADD
        // =====================================================

        if ("add".equals(action)) {

            if (existingItem == null) {

                CartItem newItem =
                        new CartItem();

                newItem.setCartId(
                        cart.getCartId()
                );

                newItem.setMenuId(
                        menuId
                );

                newItem.setQuantity(1);

                newItem.setPrice(
                        price
                );

                cartItemDAO.addCartItem(
                        newItem
                );

            } else {

                int quantity =
                        existingItem.getQuantity() + 1;

                cartItemDAO.updateQuantity(
                        existingItem.getCartItemId(),
                        quantity
                );
            }
        }

        // =====================================================
        // PLUS
        // =====================================================

        else if ("plus".equals(action)) {

            if (existingItem != null) {

                int quantity =
                        existingItem.getQuantity() + 1;

                cartItemDAO.updateQuantity(
                        existingItem.getCartItemId(),
                        quantity
                );
            }
        }

        // =====================================================
        // MINUS
        // =====================================================

        else if ("minus".equals(action)) {

            if (existingItem != null) {

                int quantity =
                        existingItem.getQuantity() - 1;

                if (quantity <= 0) {

                    cartItemDAO.removeCartItem(
                            existingItem.getCartItemId()
                    );

                } else {

                    cartItemDAO.updateQuantity(
                            existingItem.getCartItemId(),
                            quantity
                    );
                }
            }
        }

        // =====================================================
        // INVALID ACTION
        // =====================================================

        else {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart action"
            );

            return;
        }

        // =====================================================
        // RECALCULATE CART TOTAL
        // =====================================================

        List<CartItem> updatedItems =
                cartItemDAO.getCartItems(
                        cart.getCartId()
                );

        double total = 0;

        for (CartItem item : updatedItems) {

            total +=
                    item.getPrice()
                    * item.getQuantity();
        }

        cartDAO.updateTotalAmount(
                cart.getCartId(),
                total
        );

        // =====================================================
        // RETURN TO SAME RESTAURANT MENU
        // =====================================================

        resp.sendRedirect(
                req.getContextPath()
                + "/menu?restaurantId="
                + restaurantId
        );
    }
}