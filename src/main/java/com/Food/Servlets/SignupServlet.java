package com.Food.Servlets;

import java.io.IOException;

import com.Food.Model.User;
import com.Food.daoimp.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // 1. Empty fields
        if (fullName == null || email == null || phone == null ||
            password == null || confirmPassword == null ||
            fullName.trim().isEmpty() ||
            email.trim().isEmpty() ||
            phone.trim().isEmpty() ||
            password.isEmpty() ||
            confirmPassword.isEmpty()) {

            resp.sendRedirect("signup.jsp?error=empty");
            return;
        }

        fullName = fullName.trim();
        email = email.trim();
        phone = phone.trim();

        // 2. Email validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

            resp.sendRedirect("signup.jsp?error=email");
            return;
        }

        // 3. Phone validation
        if (!phone.matches("\\d{10}")) {

            resp.sendRedirect("signup.jsp?error=invalidphone");
            return;
        }

        // 4. Password length
        if (password.length() < 6) {

            resp.sendRedirect("signup.jsp?error=invalidpassword");
            return;
        }

        // 5. Confirm password
        if (!password.equals(confirmPassword)) {

            resp.sendRedirect("signup.jsp?error=password");
            return;
        }

        UserDAOImpl userDAO = new UserDAOImpl();

        // 6. Check whether email or phone already exists
        User existingUser =
                userDAO.getUserByEmailOrPhone(email, phone, password);

        if (existingUser != null) {

            resp.sendRedirect("signup.jsp?error=exists");
            return;
        }

        // 7. Create new User
        User user = new User();

        user.setUserName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);

        // If your User class requires address
        user.setAddress("");

        user.setRole("customer");

        boolean created = userDAO.addUser(user);

        if (created) {
            resp.sendRedirect("login.jsp?success=created");
        } else {
            resp.sendRedirect("signup.jsp?error=database");
        }
    }
}