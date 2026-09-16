package com.Food.Servlets;

import java.io.IOException;

import com.Food.daoimp.CartItemDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateCartItem")
public class UpdateCartItemServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String cartItemIdParam = req.getParameter("cartItemId");
        String quantityParam = req.getParameter("quantity");

        if (cartItemIdParam == null || quantityParam == null) {
            resp.sendRedirect("cart");
            return;
        }

        try {

            int cartItemId = Integer.parseInt(cartItemIdParam);
            int quantity = Integer.parseInt(quantityParam);

            CartItemDAOImpl cartItemDAO = new CartItemDAOImpl();

            if (quantity <= 0) {

                cartItemDAO.removeCartItem(cartItemId);

            } else {

                cartItemDAO.updateQuantity(cartItemId, quantity);

            }

            resp.sendRedirect("cart");

        } catch (NumberFormatException e) {

            e.printStackTrace();
            resp.sendRedirect("cart");

        }
    }
}
