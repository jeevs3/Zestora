package com.Food.Servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.json.JSONObject;

import com.Food.Model.User;
import com.Food.daoimp.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/GoogleCallback")
public class GoogleCallbackServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID =
            "645024225265-r9brbqd040akvm9vastoims797k0j36l.apps.googleusercontent.com";

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // Check whether Google was opened from Login or Signup
        String googleMode = (String) session.getAttribute("googleMode");

        if (googleMode == null) {
            googleMode = "login";
        }

        String code = req.getParameter("code");
        String error = req.getParameter("error");

        // ==========================================
        // GOOGLE LOGIN CANCELLED / ERROR
        // ==========================================

        if (error != null || code == null) {

            if ("signup".equals(googleMode)) {
                resp.sendRedirect("signup.jsp?error=google_login_cancelled");
            } else {
                resp.sendRedirect("login.jsp?error=google_login_cancelled");
            }

            return;
        }

        try {

            // ==========================================
            // GOOGLE CLIENT SECRET
            // ==========================================

            String clientSecret = System.getenv("GOOGLE_CLIENT_SECRET");

            if (clientSecret == null || clientSecret.isBlank()) {
                throw new ServletException(
                    "GOOGLE_CLIENT_SECRET environment variable is not configured."
                );
            }

            // ==========================================
            // GOOGLE REDIRECT URI
            // ==========================================

            String redirectUri = System.getenv("GOOGLE_REDIRECT_URI");

            if (redirectUri == null || redirectUri.isBlank()) {

                // Local Eclipse/Tomcat fallback
                redirectUri =
                    "http://localhost:8080/Food_APP/GoogleCallback";
            }

            // ==========================================
            // STEP 1: EXCHANGE CODE FOR ACCESS TOKEN
            // ==========================================

            String params =
                    "code=" + URLEncoder.encode(code, "UTF-8")
                    + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                    + "&client_secret=" + URLEncoder.encode(
                            clientSecret, "UTF-8")
                    + "&redirect_uri=" + URLEncoder.encode(
                            redirectUri, "UTF-8")
                    + "&grant_type=authorization_code";

            HttpURLConnection tokenConn =
                    (HttpURLConnection) new URL(
                            "https://oauth2.googleapis.com/token"
                    ).openConnection();

            tokenConn.setRequestMethod("POST");
            tokenConn.setDoOutput(true);

            tokenConn.setRequestProperty(
                    "Content-Type",
                    "application/x-www-form-urlencoded"
            );

            try (OutputStream os = tokenConn.getOutputStream()) {
                os.write(params.getBytes(StandardCharsets.UTF_8));
            }

            if (tokenConn.getResponseCode() != 200) {

                if ("signup".equals(googleMode)) {
                    resp.sendRedirect(
                        "signup.jsp?error=token_exchange_failed"
                    );
                } else {
                    resp.sendRedirect(
                        "login.jsp?error=token_exchange_failed"
                    );
                }

                return;
            }

            JSONObject tokenJson = readJson(tokenConn);

            String accessToken =
                    tokenJson.getString("access_token");

            // ==========================================
            // STEP 2: GET GOOGLE USER PROFILE
            // ==========================================

            HttpURLConnection userConn =
                    (HttpURLConnection) new URL(
                            "https://openidconnect.googleapis.com/v1/userinfo"
                    ).openConnection();

            userConn.setRequestProperty(
                    "Authorization",
                    "Bearer " + accessToken
            );

            if (userConn.getResponseCode() != 200) {

                if ("signup".equals(googleMode)) {
                    resp.sendRedirect(
                        "signup.jsp?error=profile_fetch_failed"
                    );
                } else {
                    resp.sendRedirect(
                        "login.jsp?error=profile_fetch_failed"
                    );
                }

                return;
            }

            JSONObject profile = readJson(userConn);

            String email = profile.optString("email");
            String name = profile.optString("name");

            boolean emailVerified =
                    profile.optBoolean("email_verified", false);

            // Always replace previous Google email
            session.removeAttribute("googleEmail");
            session.setAttribute("googleEmail", email);

            // ==========================================
            // STEP 3: CHECK GOOGLE EMAIL
            // ==========================================

            if (email.isEmpty() || !emailVerified) {

                if ("signup".equals(googleMode)) {
                    resp.sendRedirect(
                        "signup.jsp?error=email_not_verified"
                    );
                } else {
                    resp.sendRedirect(
                        "login.jsp?error=email_not_verified"
                    );
                }

                return;
            }

            // ==========================================
            // STEP 4: GOOGLE SIGNUP
            // ==========================================

            if ("signup".equals(googleMode)) {

                UserDAOImpl userDAO = new UserDAOImpl();

                User existingUser =
                        userDAO.getUserByEmail(email);

                if (existingUser != null) {

                    resp.sendRedirect(
                        "signup.jsp?error=exists"
                    );

                    return;
                }

                // New Google user
                session.setAttribute(
                        "googleFirstName", name);

                session.setAttribute(
                        "googleEmail", email);

                session.setAttribute(
                        "googleSignup", true);

                resp.sendRedirect("signup.jsp");

                return;
            }

            // ==========================================
            // STEP 5: GOOGLE LOGIN
            // ==========================================

            UserDAOImpl userDAO = new UserDAOImpl();

            User existingUser =
                    userDAO.getUserByEmail(email);

            if (existingUser == null) {

                resp.sendRedirect(
                    "login.jsp?error=not_registered"
                );

                return;
            }

            // ==========================================
            // GOOGLE LOGIN SUCCESS
            // ==========================================

            session.setAttribute(
                    "user", existingUser);

            session.setAttribute(
                    "userId", existingUser.getUserId());

            session.setAttribute(
                    "userEmail", email);

            session.setAttribute(
                    "userName", name);

            // ==========================================
            // CHECK FOR PENDING RESTAURANT
            // ==========================================

            String pendingRestaurantId =
                    (String) session.getAttribute(
                            "pendingRestaurantId");

            if (pendingRestaurantId != null) {

                session.removeAttribute(
                        "pendingRestaurantId");

                resp.sendRedirect(
                    "menu?restaurantId="
                    + pendingRestaurantId
                );

            } else {

                resp.sendRedirect("restaurant");
            }

        } catch (Exception e) {

            e.printStackTrace();

            if ("signup".equals(googleMode)) {
                resp.sendRedirect(
                    "signup.jsp?error=server_error"
                );
            } else {
                resp.sendRedirect(
                    "login.jsp?error=server_error"
                );
            }
        }
    }

    private JSONObject readJson(HttpURLConnection conn)
            throws IOException {

        BufferedReader br =
                new BufferedReader(
                    new InputStreamReader(
                        conn.getInputStream()
                    )
                );

        StringBuilder sb = new StringBuilder();

        String line;

        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        br.close();

        return new JSONObject(sb.toString());
    }
}