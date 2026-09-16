<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Set New Password - Zestora</title>

<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

body {
    min-height: 100vh;
    background: #fff7f0;

    display: flex;
    justify-content: center;
    align-items: center;
}

.reset-container {

    width: 400px;
    max-width: 92%;

    background: white;

    padding: 38px 35px;

    border-radius: 16px;

    box-shadow:
        0 8px 30px rgba(0,0,0,0.12);
}


/* =========================
   LOGO
========================= */

.logo {

    text-align: center;

    font-size: 32px;

    font-weight: bold;

    margin-bottom: 8px;
}

.logo-black {
    color: #111111;
}

.logo-red {
    color: #E53935;
}


/* =========================
   SUBTITLE
========================= */

.subtitle {

    text-align: center;

    color: #777;

    font-size: 14px;

    margin-bottom: 30px;
}


/* =========================
   HEADING
========================= */

h2 {

    text-align: center;

    color: #222;

    margin-bottom: 10px;

    font-size: 22px;
}

.description {

    text-align: center;

    color: #777;

    font-size: 13px;

    line-height: 1.5;

    margin-bottom: 25px;
}


/* =========================
   INPUT
========================= */

.input-label {

    display: block;

    font-size: 13px;

    font-weight: bold;

    color: #555;

    margin-bottom: 7px;
}

.password-group {

    margin-bottom: 18px;
}

.reset-input {

    width: 100%;

    padding: 14px;

    border: 1px solid #ddd;

    border-radius: 8px;

    font-size: 15px;

    outline: none;

    transition: 0.2s;
}

.reset-input:focus {

    border-color: #E53935;

    box-shadow:
        0 0 0 2px rgba(229,57,53,0.1);
}


/* =========================
   BUTTON
========================= */

.reset-btn {

    width: 100%;

    border: none;

    background: #E53935;

    color: white;

    padding: 14px;

    margin-top: 5px;

    border-radius: 8px;

    font-size: 16px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.2s;
}

.reset-btn:hover {

    background: #C62828;
}


/* =========================
   MESSAGES
========================= */

.error-message {

    background: #fff0f0;

    color: #d93025;

    border: 1px solid #f3c2c2;

    padding: 10px;

    border-radius: 7px;

    margin-bottom: 15px;

    font-size: 13px;

    text-align: center;
}

.success-message {

    background: #eefaf0;

    color: #188038;

    border: 1px solid #b7dfbd;

    padding: 10px;

    border-radius: 7px;

    margin-bottom: 15px;

    font-size: 13px;

    text-align: center;
}


/* =========================
   BACK TO LOGIN
========================= */

.back-login {

    text-align: center;

    margin-top: 22px;

    font-size: 14px;

    color: #777;
}

.back-login a {

    color: #E53935;

    text-decoration: none;

    font-weight: bold;
}

.back-login a:hover {

    color: #C62828;

    text-decoration: underline;
}

</style>

</head>


<body>

<div class="reset-container">


    <!-- ZESTORA LOGO -->

    <div class="logo">

        <span class="logo-black">Zest</span><span
        class="logo-red">ora</span>

    </div>


    <div class="subtitle">

        Delicious food, delivered to you

    </div>


    <h2>

        Set New Password

    </h2>


    <div class="description">

        Enter your new password below.

    </div>


    <%
        String error = request.getParameter("error");
    %>


    <% if ("password_mismatch".equals(error)) { %>

        <div class="error-message">

            Passwords do not match.

        </div>

    <% } else if ("password_short".equals(error)) { %>

        <div class="error-message">

            Password must be at least 6 characters.

        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="error-message">

            Invalid reset request. Please start again.

        </div>

    <% } else if ("server".equals(error)) { %>

        <div class="error-message">

            Something went wrong. Please try again.

        </div>

    <% } %>


    <!-- RESET PASSWORD FORM -->

    <form
        action="<%=request.getContextPath()%>/resetPassword"
        method="post">


        <div class="password-group">

            <label class="input-label">

                New Password

            </label>

            <input
                type="password"
                name="newPassword"
                class="reset-input"
                placeholder="Enter new password"
                minlength="6"
                required>

        </div>


        <div class="password-group">

            <label class="input-label">

                Confirm New Password

            </label>

            <input
                type="password"
                name="confirmPassword"
                class="reset-input"
                placeholder="Confirm new password"
                minlength="6"
                required>

        </div>


        <button
            type="submit"
            class="reset-btn">

            Reset Password

        </button>

    </form>


    <div class="back-login">

        Remember your password?

        <a href="<%=request.getContextPath()%>/login.jsp">

            Back to Login

        </a>

    </div>


</div>

</body>

</html>