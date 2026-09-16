<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String error = request.getParameter("error");
String success = request.getParameter("success");

String fullName = "";
String email = "";
String phone = "";

if (request.getParameter("fullName") != null) {
    fullName = request.getParameter("fullName");
}

if (request.getParameter("email") != null) {
    email = request.getParameter("email");
}

if (request.getParameter("phone") != null) {
    phone = request.getParameter("phone");
}

// Google Signup data
Boolean googleSignup =
    (Boolean) session.getAttribute("googleSignup");

if (Boolean.TRUE.equals(googleSignup)) {

    String googleFirstName =
        (String) session.getAttribute("googleFirstName");

    String googleEmail =
        (String) session.getAttribute("googleEmail");

    if (googleFirstName != null) {
        fullName = googleFirstName;
    }

    if (googleEmail != null) {
        email = googleEmail;
    }
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Sign Up - Zestora</title>


<style>

/* ================================
   RESET
================================ */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}


/* ================================
   BODY
================================ */

body {

    min-height: 100vh;

    background: #fff7f0;

    display: flex;

    justify-content: center;

    align-items: center;

    font-family: Arial, sans-serif;

    color: #222;
}


/* ================================
   SIGNUP CONTAINER
================================ */

.signup-container {

    width: 400px;

    max-width: 92%;

    background: white;

    padding: 32px 35px;

    border-radius: 16px;

    box-shadow:
        0 8px 30px rgba(0,0,0,0.12);

}


/* ================================
   LOGO
================================ */

.logo {
    text-align: center;
    font-size: 32px;
    font-weight: bold;
    color: #FC8019;
    margin-bottom: 8px;
}

/* ================================
   SUBTITLE
================================ */

.subtitle {

    text-align: center;

    color: #777;

    font-size: 14px;

    margin-bottom: 24px;
}


/* ================================
   HEADING
================================ */

h2 {
    text-align: center;
    color:  #E53935;
    margin-bottom: 22px;
    font-size: 22px;
}


/* ================================
   ERROR / SUCCESS
================================ */

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


.error-message a {

    color: #ed1c24;

    font-weight: bold;

    text-decoration: none;
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


/* ================================
   INPUT GROUP
================================ */

.input-group {

    margin-bottom: 14px;
}


.input-group label {

    display: block;

    font-size: 13px;

    font-weight: bold;

    color: #444;

    margin-bottom: 7px;
}


.input-group input {

    width: 100%;

    height: 48px;

    padding: 0 14px;

    border: 1px solid #ddd;

    border-radius: 8px;

    background: white;

    outline: none;

    font-size: 15px;

    color: #222;

    transition: 0.2s;
}


.input-group input:focus {
    border-color: #E53935;
    box-shadow: 0 0 0 2px rgba(229,57,53,0.1);
}


.input-group input::placeholder {

    color: #777;
}


/* ================================
   CREATE ACCOUNT BUTTON
================================ */
.signup-submit {
    width: 100%;
    height: 48px;
    border: none;
    border-radius: 8px;
    background: #E53935;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 5px;
    transition: 0.2s;
}

.signup-submit:hover {
    background: #C62828;
}

/* ================================
   DIVIDER
================================ */

.divider {

    display: flex;

    align-items: center;

    gap: 12px;

    margin: 24px 0;
}


.divider::before,
.divider::after {

    content: "";

    flex: 1;

    height: 1px;

    background: #ddd;
}


.divider span {

    color: #999;

    font-size: 13px;
}


/* ================================
   GOOGLE BUTTON
================================ */
  .google-btn {
        width: 100%;
        height: 48px;
        border: 1px solid #ddd;
        background: white;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        font-size: 15px;
        font-weight: 600;
        color: #333;
        cursor: pointer;
    }

    .google-btn:hover {
        background: #fafafa;
        border-color: #bbb;
    }

    .google-icon {
        width: 20px;
        height: 20px;
    }

/* ================================
   LOGIN TEXT
================================ */

.login-text {
    text-align: center;
    margin-top: 24px;
    color:black;
    font-size: 14px;
    line-height: 1.5;
    width: 100%;
}

.login-text a {
    color:  #E53935;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
}

.login-text a:hover {
    text-decoration: underline;
}


/* ================================
   BACK HOME
================================ */

.back-home {
    display: block;
    text-align: center;
    margin-top: 15px;
    color:  #E53935;
    font-size: 13px;
    text-decoration: none;
}

.back-home:hover {
    color:#C62828;
}


/* ================================
   MOBILE
================================ */

.signup-text {
        text-align: center;
        margin-top: 25px;
        color: #777;
        font-size: 14px;
    }

    .signup-text a {
        color: #fc8019;
        text-decoration: none;
        font-weight: bold;
    }

    .logo {

        font-size: 30px;
    }
    .logo-black {
    color: #111111;
}

.logo-red {
    color: #E53935;
}

}

</style>

</head>


<body>


<div class="signup-container">


    <!-- LOGO -->

   <div class="logo">
    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>


    <div class="subtitle">
        Delicious food, delivered to you
    </div>


    <h2>
        Create your account
    </h2>


    <!-- ==========================
         ERROR / SUCCESS MESSAGES
    =========================== -->

    <%
    if ("exists".equals(error)) {
    %>

        <div class="error-message">
            You already have an account.
            <a href="<%=request.getContextPath()%>/login.jsp">
                Login
            </a>
        </div>

    <%
    } else if ("email".equals(error)) {
    %>

        <div class="error-message">
            Please enter a valid email address.
        </div>

    <%
    } else if ("password".equals(error)) {
    %>

        <div class="error-message">
            Passwords do not match.
        </div>

    <%
    } else if ("empty".equals(error)) {
    %>

        <div class="error-message">
            Please fill in all the fields.
        </div>

    <%
    } else if ("invalidphone".equals(error)) {
    %>

        <div class="error-message">
            Please enter a valid phone number.
        </div>

    <%
    } else if ("invalidpassword".equals(error)) {
    %>

        <div class="error-message">
            Password must be at least 6 characters.
        </div>

    <%
    } else if ("database".equals(error)) {
    %>

        <div class="error-message">
            Something went wrong. Please try again.
        </div>

    <%
    } else if ("created".equals(success)) {
    %>

        <div class="success-message">
            Account created successfully.
            You can now login.
        </div>

    <%
    }
    %>


    <!-- ==========================
         SIGNUP FORM
    =========================== -->

    <form action="<%=request.getContextPath()%>/signup"
          method="post">


        <!-- FULL NAME -->

        <div class="input-group">

            <label for="fullName">
                Full Name
            </label>

            <input
                type="text"
                id="fullName"
                name="fullName"
                placeholder="Enter your full name"
                value="<%=fullName%>"
                autocomplete="name"
                required
            >

        </div>


        <!-- EMAIL -->

        <div class="input-group">

            <label for="email">
                Email
            </label>

            <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter your email"
                value="<%=email%>"
                autocomplete="email"

                <% if (Boolean.TRUE.equals(googleSignup)) { %>
                    readonly
                <% } %>

                required
            >

        </div>


        <!-- PHONE -->

        <div class="input-group">

            <label for="phone">
                Phone Number
            </label>

            <input
                type="tel"
                id="phone"
                name="phone"
                placeholder="Enter your phone number"
                value="<%=phone%>"
                autocomplete="tel"
                required
            >

        </div>


        <!-- PASSWORD -->

        <div class="input-group">

            <label for="password">
                Password
            </label>

            <input
                type="password"
                id="password"
                name="password"
                placeholder="Create a password"
                autocomplete="new-password"
                required
            >

        </div>


        <!-- CONFIRM PASSWORD -->

        <div class="input-group">

            <label for="confirmPassword">
                Confirm Password
            </label>

            <input
                type="password"
                id="confirmPassword"
                name="confirmPassword"
                placeholder="Confirm your password"
                autocomplete="new-password"
                required
            >

        </div>


        <!-- CREATE ACCOUNT -->

        <button
            type="submit"
            class="signup-submit">

            Create Account

        </button>

    </form>


    <!-- ==========================
         OR
    =========================== -->

    <div class="divider">

        <span>OR</span>

    </div>


    <!-- ==========================
         GOOGLE SIGNUP
    =========================== -->

   <form action="<%=request.getContextPath()%>/GoogleLogin"
          method="get">

        <button type="submit" class="google-btn">

            <svg class="google-icon"
                 viewBox="0 0 24 24"
                 xmlns="http://www.w3.org/2000/svg">

                <path fill="#4285F4"
                      d="M21.35 12.23c0-.79-.07-1.55-.2-2.28H12v4.32h5.23a4.47 4.47 0 0 1-1.94 2.93v2.43h3.14c1.84-1.69 2.92-4.18 2.92-7.4z"/>

                <path fill="#34A853"
                      d="M12 21.7c2.63 0 4.84-.87 6.45-2.36l-3.14-2.43c-.87.58-1.98.93-3.31.93-2.54 0-4.69-1.72-5.46-4.03H3.3v2.5A9.74 9.74 0 0 0 12 21.7z"/>

                <path fill="#FBBC05"
                      d="M6.54 13.81A5.85 5.85 0 0 1 6.23 12c0-.63.11-1.24.31-1.81v-2.5H3.3A9.73 9.73 0 0 0 2.27 12c0 1.57.38 3.05 1.03 4.31l3.24-2.5z"/>

                <path fill="#EA4335"
                      d="M12 6.16c1.43 0 2.71.49 3.72 1.45l2.79-2.79C16.84 3.14 14.63 2.3 12 2.3a9.74 9.74 0 0 0-8.7 5.39l3.24 2.5C7.31 7.88 9.46 6.16 12 6.16z"/>

            </svg>

            Continue with Google

        </button>

    </form>

    <!-- ==========================
         LOGIN
    =========================== -->

    <p class="login-text">

        Already have an account?

        <a href="<%=request.getContextPath()%>/login.jsp">
            Login
        </a>

    </p>


    <!-- ==========================
         BACK HOME
    =========================== -->

    <a
        href="<%=request.getContextPath()%>/index.jsp"
        class="back-home">

        ← Back to Zestora

    </a>


</div>


</body>

</html>