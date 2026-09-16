package com.Food.Servlets;

import java.io.IOException;

import com.Food.DAO.UserDAO;
import com.Food.daoimp.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

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

        if (session == null ||
            session.getAttribute("resetUserId") == null) {

            response.sendRedirect(
                request.getContextPath()
                + "/forgotPassword.jsp?error=invalid"
            );

            return;
        }

        request.getRequestDispatcher(
            "/resetPassword.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        /*
         * Check whether the user actually came through
         * the Forgot Password flow.
         */
        if (session == null ||
            session.getAttribute("resetUserId") == null) {

            response.sendRedirect(
                request.getContextPath()
                + "/forgotPassword.jsp?error=invalid"
            );

            return;
        }

        Integer userId =
            (Integer) session.getAttribute("resetUserId");

        String newPassword =
            request.getParameter("newPassword");

        String confirmPassword =
            request.getParameter("confirmPassword");


        /*
         * Check empty values
         */
        if (newPassword == null ||
            confirmPassword == null ||
            newPassword.trim().isEmpty() ||
            confirmPassword.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/resetPassword.jsp?error=invalid"
            );

            return;
        }


        /*
         * Minimum password length
         */
        if (newPassword.length() < 6) {

            response.sendRedirect(
                request.getContextPath()
                + "/resetPassword.jsp?error=password_short"
            );

            return;
        }


        /*
         * Check passwords match
         */
        if (!newPassword.equals(confirmPassword)) {

            response.sendRedirect(
                request.getContextPath()
                + "/resetPassword.jsp?error=password_mismatch"
            );

            return;
        }


        try {

            /*
             * Update password in database
             */
            boolean updated =
                userDAO.updatePassword(
                    userId,
                    newPassword
                );


            if (updated) {

                /*
                 * Remove reset-session information
                 */
                session.removeAttribute("resetUserId");
                session.removeAttribute("resetUserEmail");

                /*
                 * Go back to login
                 */
                response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?reset=success"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/resetPassword.jsp?error=server"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/resetPassword.jsp?error=server"
            );
        }
    }
}
