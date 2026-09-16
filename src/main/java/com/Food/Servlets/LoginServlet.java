package com.Food.Servlets;

import java.io.IOException;

import com.Food.DAO.UserDAO;
import com.Food.Model.User;
import com.Food.daoimp.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String login = req.getParameter("login");
        String password = req.getParameter("password");

        // Check empty fields
        if (login == null || login.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            resp.sendRedirect(
                req.getContextPath() + "/login.jsp?error=invalid"
            );
            return;
        }

        login = login.trim();
        password = password.trim();

        try {

            // Login using either Email OR Phone + Password
            User user = userDAO.getUserByEmailOrPhone(
                login,
                login,
                password
            );

            // Invalid email/phone/password
            if (user == null) {

                resp.sendRedirect(
                    req.getContextPath() + "/login.jsp?error=invalid"
                );
                return;
            }

            // ==============================
            // LOGIN SUCCESS
            // ==============================

            HttpSession session = req.getSession();

            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userEmail", user.getEmail());

            // Update last login date
            userDAO.updateLoginDate(user.getUserId());

            // ==============================
            // RETURN TO PENDING RESTAURANT
            // ==============================

            Integer pendingRestaurantId =
                (Integer) session.getAttribute("pendingRestaurantId");

            if (pendingRestaurantId != null) {

                session.removeAttribute("pendingRestaurantId");

                resp.sendRedirect(
                    req.getContextPath()
                    + "/menu?restaurantId="
                    + pendingRestaurantId
                );

                return;
            }

            // ==============================
            // NORMAL LOGIN
            // ==============================

            resp.sendRedirect(
                req.getContextPath() + "/restaurant"
            );

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                req.getContextPath()
                + "/login.jsp?error=server"
            );
        }
    }
}