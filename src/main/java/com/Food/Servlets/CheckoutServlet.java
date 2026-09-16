package com.Food.Servlets;

import java.io.IOException;
import java.util.ArrayList;
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

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =========================================================
    // GET - LOAD CHECKOUT PAGE
    // =========================================================
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        // =====================================================
        // SESSION
        // =====================================================
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
        // USER
        // =====================================================
        UserDAOImpl userDAO = new UserDAOImpl();

        User user = userDAO.getUser(userId);

        if (user == null) {

            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "User not found"
            );

            return;
        }

        // =====================================================
        // ADDRESS FROM GOOGLE MAP
        // =====================================================
        String selectedAddress =
                (String) session.getAttribute("selectedAddress");

        String selectedPincode =
                (String) session.getAttribute("selectedPincode");

        // =====================================================
        // DISPLAY ADDRESS
        // =====================================================
        if (selectedAddress != null
                && !selectedAddress.trim().isEmpty()) {

            req.setAttribute(
                    "displayAddress",
                    selectedAddress
            );

        } else {

            req.setAttribute(
                    "displayAddress",
                    user.getAddress()
            );
        }

        // =====================================================
        // DISPLAY PINCODE
        // =====================================================
        if (selectedPincode != null
                && !selectedPincode.trim().isEmpty()) {

            req.setAttribute(
                    "displayPincode",
                    selectedPincode
            );

        } else {

            req.setAttribute(
                    "displayPincode",
                    user.getPincode()
            );
        }
        

        // =====================================================
        // USER DETAILS
        // =====================================================
        req.setAttribute("user", user);

        // =====================================================
        // CART
        // =====================================================
        CartDAOImpl cartDAO = new CartDAOImpl();

        Cart cart = cartDAO.getCartByUserId(userId);

        if (cart == null) {

            req.setAttribute(
                    "cart",
                    null
            );

            req.setAttribute(
                    "cartItems",
                    new ArrayList<CartItem>()
            );

            req.setAttribute(
                    "menuList",
                    new ArrayList<Menu>()
            );

            req.setAttribute(
                    "restaurant",
                    null
            );

            req.setAttribute(
                    "itemTotal",
                    0.0
            );

            req.setAttribute(
                    "deliveryFee",
                    0.0
            );

            req.setAttribute(
                    "discount",
                    0.0
            );

            req.setAttribute(
                    "toPay",
                    0.0
            );

            req.getRequestDispatcher(
                    "/checkout.jsp"
            ).forward(req, resp);

            return;
        }

        // =====================================================
        // CART ITEMS
        // =====================================================
        CartItemDAOImpl cartItemDAO =
                new CartItemDAOImpl();

        List<CartItem> cartItems =
                cartItemDAO.getCartItems(
                        cart.getCartId()
                );

        // =====================================================
        // MENU ITEMS
        // =====================================================
        MenuDAOImpl menuDAO =
                new MenuDAOImpl();

        List<Menu> menuList =
                new ArrayList<>();

        for (CartItem item : cartItems) {

            Menu menu =
                    menuDAO.getMenuById(
                            item.getMenuId()
                    );

            if (menu != null) {
                menuList.add(menu);
            }
        }

        // =====================================================
        // RESTAURANT
        // =====================================================
        RestaurantDAOImpl restaurantDAO =
                new RestaurantDAOImpl();

        Restaurant restaurant =
                restaurantDAO.getRestaurant(
                        cart.getRestaurantId()
                );

        // =====================================================
        // CALCULATE ITEM TOTAL
        // =====================================================
        double itemTotal = 0.0;

        for (CartItem item : cartItems) {

            itemTotal +=
                    item.getPrice()
                    * item.getQuantity();
        }

        // =====================================================
        // DELIVERY FEE
        // =====================================================
        double deliveryFee = 40.0;

        // =====================================================
        // DISCOUNT
        // =====================================================
        double discount = 0.0;

        // =====================================================
        // FINAL AMOUNT
        // =====================================================
        double toPay =
                itemTotal
                + deliveryFee
                - discount;

        // =====================================================
        // SEND DATA TO CHECKOUT.JSP
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
                "menuList",
                menuList
        );

        req.setAttribute(
                "restaurant",
                restaurant
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
                toPay
        );

        // =====================================================
        // OPEN CHECKOUT PAGE
        // =====================================================
        req.getRequestDispatcher(
                "/checkout.jsp"
        ).forward(req, resp);
    }


    // =========================================================
    // POST - SAVE DELIVERY DETAILS
    // =========================================================
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        // =====================================================
        // SESSION
        // =====================================================
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
        // GET FORM VALUES
        // =====================================================
        String userName =
                req.getParameter("userName");

        String phone =
                req.getParameter("phone");

        String address =
                req.getParameter("address");

        String pincode =
                req.getParameter("pincode");

        String instruction =
                req.getParameter("instruction");


        // =====================================================
        // FALLBACK TO GOOGLE MAP LOCATION
        // =====================================================
        String selectedAddress =
                (String) session.getAttribute(
                        "selectedAddress"
                );

        String selectedPincode =
                (String) session.getAttribute(
                        "selectedPincode"
                );

        if ((address == null
                || address.trim().isEmpty())
                && selectedAddress != null
                && !selectedAddress.trim().isEmpty()) {

            address = selectedAddress;
        }

        if ((pincode == null
                || pincode.trim().isEmpty())
                && selectedPincode != null
                && !selectedPincode.trim().isEmpty()) {

            pincode = selectedPincode;
        }


        // =====================================================
        // FALLBACK USER NAME
        // =====================================================
        if (userName == null
                || userName.trim().isEmpty()) {

            userName = user.getUserName();
        }


        // =====================================================
        // FALLBACK PHONE
        // =====================================================
        if (phone == null
                || phone.trim().isEmpty()) {

            phone = user.getPhone();
        }


        // =====================================================
        // OPTIONAL INSTRUCTION
        // =====================================================
        if (instruction == null) {

            instruction = "";
        }


        // =====================================================
        // VALIDATE ADDRESS
        // =====================================================
        if (address == null
                || address.trim().isEmpty()) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Delivery address is required"
            );

            return;
        }


        // =====================================================
        // VALIDATE PINCODE
        // =====================================================
        if (pincode == null
                || pincode.trim().isEmpty()) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Pincode is required"
            );

            return;
        }


        // =====================================================
        // SAVE TO USER TABLE
        // =====================================================
        userDAO.updateCheckoutDetails(
                userId,
                userName,
                phone,
                address,
                pincode,
                instruction
        );


        // =====================================================
        // CLEAR TEMPORARY GOOGLE MAP LOCATION
        // =====================================================
        session.removeAttribute(
                "selectedAddress"
        );

        session.removeAttribute(
                "selectedPincode"
        );

        session.removeAttribute(
                "selectedLatitude"
        );

        session.removeAttribute(
                "selectedLongitude"
        );


        // =====================================================
        // RETURN TO CHECKOUT
        // =====================================================
        resp.sendRedirect(
                req.getContextPath()
                + "/checkout"
        );
    }
}