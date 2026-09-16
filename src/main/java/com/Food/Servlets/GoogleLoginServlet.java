package com.Food.Servlets;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/GoogleLogin")
public class GoogleLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID =
            "645024225265-r9brbqd040akvm9vastoims797k0j36l.apps.googleusercontent.com";

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String mode = req.getParameter("mode");

        if (mode == null || mode.isBlank()) {
            mode = "login";
        }

        HttpSession session = req.getSession();
        session.setAttribute("googleMode", mode);

        /*
         * Production:
         * Set GOOGLE_REDIRECT_URI in Railway.
         *
         * Example:
         * https://your-public-domain/GoogleCallback
         *
         * Local development:
         * Falls back to localhost.
         */
        String redirectUri = System.getenv("GOOGLE_REDIRECT_URI");

        if (redirectUri == null || redirectUri.isBlank()) {
            redirectUri =
                    "http://localhost:8080/Food_APP/GoogleCallback";
        }

        String authUrl =
                "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&redirect_uri=" + URLEncoder.encode(
                        redirectUri, "UTF-8")
                + "&response_type=code"
                + "&scope=" + URLEncoder.encode(
                        "openid email profile", "UTF-8")
                + "&access_type=online"
                + "&prompt=select_account";

        resp.sendRedirect(authUrl);
    }
}