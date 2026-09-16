package com.Food.Servlets;

import java.io.IOException;

import com.Food.DAO.CartDAO;
import com.Food.DAO.CartItemDAO;
import com.Food.Model.Cart;
import com.Food.Model.CartItem;
import com.Food.daoimp.CartDAOImpl;
import com.Food.daoimp.CartItemDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/changeRestaurant")
public class ChangeRestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        Integer menuId =
                (Integer) session.getAttribute("pendingMenuId");

        Integer restaurantId =
                (Integer) session.getAttribute("pendingRestaurantId");

        Double price =
                (Double) session.getAttribute("pendingPrice");

        // ==========================================
        // VALIDATION
        // ==========================================

        if (userId == null ||
            menuId == null ||
            restaurantId == null ||
            price == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/menu"
            );

            return;
        }

        CartDAO cartDAO =
                new CartDAOImpl();

        CartItemDAO cartItemDAO =
                new CartItemDAOImpl();


        // ==========================================
        // GET CURRENT CART
        // ==========================================

        Cart oldCart =
                cartDAO.getCartByUserId(userId);


        if (oldCart != null) {

            // ==========================================
            // REMOVE OLD CART ITEMS
            // ==========================================

            cartItemDAO.clearCart(
                    oldCart.getCartId()
            );


            // ==========================================
            // DELETE OLD CART
            // ==========================================

            cartDAO.deleteCart(
                    oldCart.getCartId()
            );
        }


        // ==========================================
        // CREATE NEW CART FOR NEW RESTAURANT
        // ==========================================

        Cart newCart =
                new Cart();

        newCart.setUserId(userId);

        newCart.setRestaurantId(
                restaurantId
        );

        newCart.setTotalAmount(0);


        int newCartId =
                cartDAO.createCart(newCart);


        // ==========================================
        // ADD REQUESTED MENU ITEM
        // ==========================================

        CartItem cartItem =
                new CartItem();

        cartItem.setCartId(newCartId);

        cartItem.setMenuId(menuId);

        cartItem.setQuantity(1);

        cartItem.setPrice(price);


        cartItemDAO.addCartItem(cartItem);


        // ==========================================
        // REMOVE TEMPORARY SESSION DATA
        // ==========================================

        session.removeAttribute(
                "pendingMenuId"
        );

        session.removeAttribute(
                "pendingRestaurantId"
        );

        session.removeAttribute(
                "pendingPrice"
        );


        // ==========================================
        // GO TO CART
        // ==========================================

        resp.sendRedirect(
                req.getContextPath() + "/cart"
        );
    }
}