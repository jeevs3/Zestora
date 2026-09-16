<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Reset Password - Zestora</title>

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
    box-shadow: 0 8px 30px rgba(0,0,0,0.12);
}

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

.subtitle {
    text-align: center;
    color: #777;
    font-size: 14px;
    margin-bottom: 30px;
}

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

.input-label {
    display: block;
    font-size: 13px;
    font-weight: bold;
    color: #555;
    margin-bottom: 7px;
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
    box-shadow: 0 0 0 2px rgba(229,57,53,0.1);
}

.reset-btn {
    width: 100%;
    border: none;
    background: #E53935;
    color: white;
    padding: 14px;
    margin-top: 18px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

.reset-btn:hover {
    background: #C62828;
}

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

</style>
</head>

<body>

<div class="reset-container">

    <div class="logo">
        <span class="logo-black">Zest</span><span class="logo-red">ora</span>
    </div>

    <div class="subtitle">
        Delicious food, delivered to you
    </div>

    <h2>Reset Password</h2>

    <div class="description">
        Enter your registered email address or phone number
        to continue.
    </div>

    <%
        String error = request.getParameter("error");
    %>

    <% if ("not_found".equals(error)) { %>

        <div class="error-message">
            No account found with this email or phone number.
        </div>

    <% } else if ("server".equals(error)) { %>

        <div class="error-message">
            Something went wrong. Please try again.
        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="error-message">
            Please enter a valid email or phone number.
        </div>

    <% } %>


    <form action="<%=request.getContextPath()%>/forgotPassword"
          method="post">

        <label class="input-label">
            Email or Phone Number
        </label>

        <input
            type="text"
            name="login"
            class="reset-input"
            placeholder="Enter email or phone number"
            required>

        <button type="submit" class="reset-btn">
            Continue
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