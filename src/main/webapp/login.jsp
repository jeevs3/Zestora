<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Zestora</title>

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

    .login-container {
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
        margin-bottom: 22px;
        font-size: 22px;
    }

    .input-label {
        display: block;
        font-size: 13px;
        font-weight: bold;
        color: #555;
        margin-bottom: 7px;
    }

    .login-input {
        width: 100%;
        padding: 14px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 15px;
        outline: none;
        transition: 0.2s;
    }

    .login-input:focus {
    border-color: #E53935;
    box-shadow: 0 0 0 2px rgba(229, 57, 53, 0.1);
}

   .continue-btn {
    width: 100%;
    border: none;
    background: #E53935;
    color: white;
    padding: 14px;
    margin-top: 18px;
    bborder-radius: 8px;
font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s ease;
}

.continue-btn:hover {
    background: #C62828;
}

    

    .divider {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 25px 0;
        color: #999;
        font-size: 13px;
    }

    .divider::before,
    .divider::after {
        content: "";
        flex: 1;
        height: 1px;
        background: #ddd;
    }

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

    .signup-text {
        text-align: center;
        margin-top: 25px;
        color: #777;
        font-size: 14px;
    }

    .signup-text a {
        color:#E53935;
        text-decoration: none;
        font-weight: bold;
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
    .forgot-password {
    text-align: right;
    margin-top: 8px;
}

.forgot-password a {
    color: #E53935;
    font-size: 13px;
    font-weight: 600;
    text-decoration: none;
}

.forgot-password a:hover {
    color: #C62828;
    text-decoration: underline;
}
</style>
</head>

<body>

<div class="login-container">

 <div class="logo">
    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>

    <div class="subtitle">
        Delicious food, delivered to you
    </div>

    <h2>Login to continue</h2>

    <%
        String error = request.getParameter("error");
    %>

    <% if ("not_registered".equals(error)) { %>
        <div class="error-message">
            This phone number or email is not registered.
        </div>
    <% } else if ("invalid".equals(error)) { %>
        <div class="error-message">
            Invalid phone number or email. Please try again.
        </div>
    <% } else if ("server".equals(error)) { %>
        <div class="error-message">
            Something went wrong. Please try again.
        </div>
    <% } else if ("logout".equals(error)) { %>
        <div class="success-message">
            You have been logged out successfully.
        </div>
    <% } %>

    <!-- Phone / Email Login -->
    <form action="<%=request.getContextPath()%>/login"
          method="post"
          id="loginForm">

    <label class="input-label">
    Phone number or Email
</label>

<input
    type="text"
    name="login"
    class="login-input"
    placeholder="Enter phone number or email"
    autocomplete="username"
    required>
<br>

<label class="input-label password-label">
    Password
</label>

<input
    type="password"
    id="password"
    name="password"
    class="login-input"
    placeholder="Enter your password"
    autocomplete="current-password"
    required>
    
    <div class="forgot-password">
    <a href="<%=request.getContextPath()%>/forgotPassword.jsp">
        Forgot Password?
    </a>
</div>

 
        <button type="submit" class="continue-btn">
            Continue
        </button>

    </form>

    <div class="divider">
        OR
    </div>

    <!-- Google Login -->
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

    <div class="signup-text">
        Don't have an account?
        <a href="<%=request.getContextPath()%>/signup.jsp">
            Sign up
        </a>
    </div>

</div>

</body>
</html>