package com.Food.Servlets;

import java.io.IOException;

import com.Food.Model.Cart;
import com.Food.Model.CartItem;
import com.Food.daoimp.CartDAOImpl;
import com.Food.daoimp.CartItemDAOImpl;
import com.Food.daoimp.MenuDAOImpl;
import com.Food.Model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/switchRestaurant")
public class SwitchRestaurantServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // ==========================================
        // LOGIN CHECK
        // ==========================================

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/login.jsp?error=login_required"
            );

            return;
        }

        // ==========================================
        // GET PENDING MENU
        // ==========================================

        Integer pendingMenuId =
                (Integer) session.getAttribute("pendingMenuId");

        if (pendingMenuId == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/cart"
            );

            return;
        }

        // ==========================================
        // GET MENU FROM DATABASE
        // ==========================================

        MenuDAOImpl menuDAO =
                new MenuDAOImpl();

        Menu menu =
                menuDAO.getMenuById(pendingMenuId);

        if (menu == null) {

            session.removeAttribute("pendingMenuId");
            session.removeAttribute("pendingRestaurantId");
            session.removeAttribute("pendingPrice");

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Menu item not found"
            );

            return;
        }

        int restaurantId =
                menu.getRestaurantId();

        double price =
                menu.getPrice();

        // ==========================================
        // GET CURRENT CART
        // ==========================================

        CartDAOImpl cartDAO =
                new CartDAOImpl();

        Cart cart =
                cartDAO.getCartByUserId(userId);

        CartItemDAOImpl cartItemDAO =
                new CartItemDAOImpl();

        // ==========================================
        // CLEAR OLD CART ITEMS
        // ==========================================

        if (cart != null) {

            cartItemDAO.clearCart(
                    cart.getCartId()
            );

            // Change cart to new restaurant
            cart.setRestaurantId(
                    restaurantId
            );

            cart.setTotalAmount(0);

            cartDAO.updateRestaurantId(
                    cart.getCartId(),
                    restaurantId
            );

            cartDAO.updateTotalAmount(
                    cart.getCartId(),
                    0
            );
        }

        // ==========================================
        // CREATE CART IF NEEDED
        // ==========================================

        if (cart == null) {

            Cart newCart =
                    new Cart();

            newCart.setUserId(userId);
            newCart.setRestaurantId(restaurantId);
            newCart.setTotalAmount(0);

            cartDAO.createCart(newCart);

            cart =
                    cartDAO.getCartByUserId(userId);
        }

        // ==========================================
        // ADD THE PENDING ITEM
        // ==========================================

        CartItem newItem =
                new CartItem();

        newItem.setCartId(
                cart.getCartId()
        );

        newItem.setMenuId(
                pendingMenuId
        );

        newItem.setQuantity(1);

        newItem.setPrice(price);

        cartItemDAO.addCartItem(
                newItem
        );

        // ==========================================
        // UPDATE TOTAL
        // ==========================================

        cartDAO.updateTotalAmount(
                cart.getCartId(),
                price
        );

        // ==========================================
        // REMOVE PENDING DATA
        // ==========================================

        session.removeAttribute("pendingMenuId");
        session.removeAttribute("pendingRestaurantId");
        session.removeAttribute("pendingPrice");

        // ==========================================
        // GO TO NEW RESTAURANT MENU
        // ==========================================

        resp.sendRedirect(
                req.getContextPath()
                + "/menu?restaurantId="
                + restaurantId
        );
    }
}
