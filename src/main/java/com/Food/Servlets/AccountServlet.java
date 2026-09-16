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

@WebServlet("/account")
public class AccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // User must be logged in
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {

            Integer userId =
                (Integer) session.getAttribute("userId");

            // Get latest user details from database
            User user = userDAO.getUser(userId);

            if (user == null) {
                response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=user"
                );
                return;
            }

            // Send user object to account.jsp
            request.setAttribute("user", user);

            request.getRequestDispatcher("/account.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=server"
            );
        }
    }
}
