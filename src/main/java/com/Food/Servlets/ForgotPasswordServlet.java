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

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

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

        response.sendRedirect(
            request.getContextPath() + "/forgotPassword.jsp"
        );
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String login = request.getParameter("login");

        if (login == null || login.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/forgotPassword.jsp?error=invalid"
            );

            return;
        }

        login = login.trim();

        try {

            User user = null;

            /*
             * First check email
             */
            if (login.contains("@")) {

                user = userDAO.getUserByEmail(login);

            } else {

                /*
                 * Otherwise check phone number
                 */
                user = userDAO.getUserByPhone(login);
            }


            /*
             * Account not found
             */
            if (user == null) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/forgotPassword.jsp?error=not_found"
                );

                return;
            }


            /*
             * Account exists.
             *
             * For now we send the user to the
             * reset-password page.
             */
            request.getSession().setAttribute(
                "resetUserId",
                user.getUserId()
            );

            request.getSession().setAttribute(
                "resetUserEmail",
                user.getEmail()
            );

            response.sendRedirect(
                request.getContextPath()
                + "/resetPassword.jsp"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/forgotPassword.jsp?error=server"
            );
        }
    }
}