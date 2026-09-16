package com.Food.Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Food.Model.Cart;
import com.Food.Model.CartItem;
import com.Food.Model.Menu;
import com.Food.Model.Restaurant;
import com.Food.daoimp.CartDAOImpl;
import com.Food.daoimp.CartItemDAOImpl;
import com.Food.daoimp.MenuDAOImpl;
import com.Food.daoimp.RestaurantDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // =========================================================
    // OPEN CART
    // =========================================================

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        // =====================================================
        // LOGIN CHECK
        // =====================================================

        if (userId == null) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/login.jsp?error=login_required"
            );

            return;
        }

        // =====================================================
        // GET USER CART
        // =====================================================

        CartDAOImpl cartDAO =
                new CartDAOImpl();

        Cart cart =
                cartDAO.getCartByUserId(userId);

        // =====================================================
        // CART DOES NOT EXIST
        // =====================================================

        if (cart == null) {

            req.setAttribute("cart", null);

            req.setAttribute(
                    "cartItems",
                    new ArrayList<CartItem>()
            );

            req.setAttribute(
                    "restaurant",
                    null
            );

            req.setAttribute(
                    "menuMap",
                    new HashMap<Integer, Menu>()
            );

            req.getRequestDispatcher("/cart.jsp")
               .forward(req, resp);

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

     // =====================================================
     // GET RESTAURANT DETAILS
     // =====================================================

     RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

     Restaurant restaurant =
             restaurantDAO.getRestaurant(
                     cart.getRestaurantId()
             );


     // =====================================================
     // GET MENU DETAILS FOR CART ITEMS
     // =====================================================

     MenuDAOImpl menuDAO = new MenuDAOImpl();

     List<Menu> menuList = new java.util.ArrayList<Menu>();

     for (CartItem item : cartItems) {

         Menu menu =
                 menuDAO.getMenu(item.getMenuId());

         if (menu != null) {
             menuList.add(menu);
         }
     }
        // =====================================================
        // SEND DATA TO CART JSP
        // =====================================================

        req.setAttribute(
                "cart",
                cart
        );

        req.setAttribute(
                "cartItems",
                cartItems
        );

        req.setAttribute(
                "restaurant",
                restaurant
        );


req.setAttribute(
        "menuList",
        menuList
        );

        // =====================================================
        // OPEN CART JSP
        // =====================================================

        req.getRequestDispatcher("/cart.jsp")
           .forward(req, resp);
    }


    // =========================================================
    // PLUS / MINUS FROM CART
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        // =====================================================
        // LOGIN CHECK
        // =====================================================

        if (userId == null) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/login.jsp?error=login_required"
            );

            return;
        }

        // =====================================================
        // READ PARAMETERS
        // =====================================================

        String cartItemIdParam =
                req.getParameter("cartItemId");

        String action =
                req.getParameter("action");

        if (cartItemIdParam == null ||
            cartItemIdParam.trim().isEmpty() ||
            action == null ||
            action.trim().isEmpty()) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Missing cart item parameters"
            );

            return;
        }

        // =====================================================
        // PARSE CART ITEM ID
        // =====================================================

        int cartItemId;

        try {

            cartItemId =
                    Integer.parseInt(
                            cartItemIdParam
                    );

        } catch (NumberFormatException e) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart item ID"
            );

            return;
        }

        // =====================================================
        // GET USER CART
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

        // =====================================================
        // FIND SELECTED CART ITEM
        // =====================================================

        CartItem selectedItem = null;

        for (CartItem item : cartItems) {

            if (item.getCartItemId() == cartItemId) {

                selectedItem = item;

                break;
            }
        }

        // =====================================================
        // CART ITEM NOT FOUND
        // =====================================================

        if (selectedItem == null) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Cart item not found"
            );

            return;
        }

        // =====================================================
        // PLUS
        // =====================================================

        if ("plus".equalsIgnoreCase(action)) {

            int newQuantity =
                    selectedItem.getQuantity() + 1;

            cartItemDAO.updateQuantity(
                    selectedItem.getCartItemId(),
                    newQuantity
            );
        }

        // =====================================================
        // MINUS
        // =====================================================

        else if ("minus".equalsIgnoreCase(action)) {

            int newQuantity =
                    selectedItem.getQuantity() - 1;

            if (newQuantity <= 0) {

                cartItemDAO.removeCartItem(
                        selectedItem.getCartItemId()
                );

            } else {

                cartItemDAO.updateQuantity(
                        selectedItem.getCartItemId(),
                        newQuantity
                );
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
        // RETURN TO CART
        // =====================================================

        resp.sendRedirect(
                req.getContextPath()
                + "/cart"
        );
    }
}