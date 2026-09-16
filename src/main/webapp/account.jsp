<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.Food.Model.User"%>

<%
    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );
        return;
    }

    String contextPath = request.getContextPath();

    String userName = user.getUserName() != null
            ? user.getUserName() : "";

    String email = user.getEmail() != null
            ? user.getEmail() : "";

    String phone = user.getPhone() != null
            ? user.getPhone() : "";

    String address = user.getAddress() != null
            ? user.getAddress() : "";

    String pincode = user.getPincode() != null
            ? user.getPincode() : "";

    String instruction = user.getInstruction() != null
            ? user.getInstruction() : "";
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Account - Zestora</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            background:
                radial-gradient(
                    circle at 0% 0%,
                    rgba(233, 54, 38, 0.14),
                    transparent 35%
                ),
                radial-gradient(
                    circle at 100% 100%,
                    rgba(233, 54, 38, 0.10),
                    transparent 35%
                ),
                #f7f2ec;
            color: #252525;
        }

        /* HEADER */

        .header {
            background: rgba(255,255,255,0.95);
            border-bottom: 1px solid #eee5dc;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-inner {
            max-width: 1100px;
            margin: auto;
            padding: 18px 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-family: Georgia, serif;
            font-size: 30px;
            font-weight: 700;
            color: #252525;
        }

        .logo span {
            color: #e93626;
        }

        .back-btn {
            text-decoration: none;
            color: #333;
            font-weight: 600;
            padding: 10px 16px;
            border-radius: 10px;
            transition: 0.2s;
        }

        .back-btn:hover {
            background: #f5eee8;
        }

        /* PAGE */

        .page {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px 60px;
        }

        .page-title {
            font-family: Georgia, serif;
            font-size: 38px;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 30px;
        }

        /* PROFILE CARD */

        .profile-card {
            background: rgba(255,255,255,0.88);
            border: 1px solid #eee4da;
            border-radius: 22px;
            padding: 28px;
            margin-bottom: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
        }

        .profile-top {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .avatar {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: #e93626;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            font-weight: bold;
        }

        .profile-name {
            font-size: 24px;
            font-weight: 700;
        }

        .profile-email {
            color: #777;
            margin-top: 4px;
        }

        /* GRID */

        .details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 25px;
        }

        .detail-box {
            background: #faf7f3;
            border: 1px solid #eee4da;
            border-radius: 15px;
            padding: 18px;
        }

        .detail-label {
            font-size: 13px;
            color: #888;
            margin-bottom: 7px;
        }

        .detail-value {
            font-size: 16px;
            font-weight: 600;
            word-break: break-word;
        }

        /* ADDRESS */

        .address-card {
            background: rgba(255,255,255,0.88);
            border: 1px solid #eee4da;
            border-radius: 22px;
            padding: 28px;
            margin-bottom: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 21px;
            margin-bottom: 20px;
        }

        .address-text {
            line-height: 1.6;
            color: #444;
        }

        .pincode {
            margin-top: 10px;
            font-weight: 700;
        }

        .instruction {
            margin-top: 12px;
            color: #777;
            font-size: 14px;
        }

        /* MENU */

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
        }

        .menu-card {
            background: white;
            border: 1px solid #eee4da;
            border-radius: 18px;
            padding: 22px;
            text-decoration: none;
            color: #222;
            transition: 0.2s;
        }

        .menu-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        .menu-icon {
            font-size: 28px;
            margin-bottom: 12px;
        }

        .menu-title {
            font-weight: 700;
            margin-bottom: 5px;
        }

        .menu-description {
            color: #777;
            font-size: 14px;
        }

        /* LOGOUT */

        .logout {
            display: block;
            margin-top: 30px;
            text-align: center;
            text-decoration: none;
            background: #e93626;
            color: white;
            padding: 14px;
            border-radius: 12px;
            font-weight: 700;
            transition: 0.2s;
        }

        .logout:hover {
            background: #c92c20;
        }

        /* MOBILE */

        @media (max-width: 700px) {

            .header-inner {
                padding: 15px;
            }

            .logo {
                font-size: 26px;
            }

            .page {
                margin-top: 25px;
            }

            .page-title {
                font-size: 31px;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .menu-grid {
                grid-template-columns: 1fr;
            }

            .profile-card,
            .address-card {
                padding: 20px;
            }

        }

    </style>

</head>

<body>

<header class="header">

    <div class="header-inner">

        <div class="logo">
            Zestora<span>.</span>
        </div>

        <a href="<%= contextPath %>/restaurant"
           class="back-btn">
            ← Back
        </a>

    </div>

</header>


<main class="page">

    <h1 class="page-title">
        My Account
    </h1>

    <p class="subtitle">
        Manage your Zestora profile and delivery information.
    </p>


    <!-- PROFILE -->

    <section class="profile-card">

        <div class="profile-top">

            <div class="avatar">
                <%= userName.isEmpty()
                    ? "U"
                    : userName.substring(0, 1).toUpperCase() %>
            </div>

            <div>

                <div class="profile-name">
                    <%= userName %>
                </div>

                <div class="profile-email">
                    <%= email %>
                </div>

            </div>

        </div>


        <div class="details-grid">

            <div class="detail-box">

                <div class="detail-label">
                    FULL NAME
                </div>

                <div class="detail-value">
                    <%= userName.isEmpty()
                        ? "Not added"
                        : userName %>
                </div>

            </div>


            <div class="detail-box">

                <div class="detail-label">
                    EMAIL
                </div>

                <div class="detail-value">
                    <%= email.isEmpty()
                        ? "Not added"
                        : email %>
                </div>

            </div>




            <div class="detail-box">

                <div class="detail-label">
                    PIN CODE
                </div>

                <div class="detail-value">
                    <%= pincode.isEmpty()
                        ? "Not added"
                        : pincode %>
                </div>

            </div>

        </div>

    </section>


    <!-- ADDRESS -->

    <section class="address-card">

        <h2 class="section-title">
            📍 Delivery Address
        </h2>

        <div class="address-text">

            <%= address.isEmpty()
                ? "No delivery address added yet."
                : address %>

        </div>

        <% if (!pincode.isEmpty()) { %>

            <div class="pincode">
                PIN Code: <%= pincode %>
            </div>

        <% } %>


        <% if (!instruction.isEmpty()) { %>

            <div class="instruction">
                <strong>Delivery instruction:</strong>
                <%= instruction %>
            </div>

        <% } %>

    </section>


    <!-- ACCOUNT MENU -->

    <section class="address-card">

        <h2 class="section-title">
            Account
        </h2>

        <div class="menu-grid">


            <a href="<%= contextPath %>/orders"
               class="menu-card">

                <div class="menu-icon">
                    📦
                </div>

                <div class="menu-title">
                    My Orders
                </div>

                <div class="menu-description">
                    View your previous and active orders.
                </div>

            </a>


            <a href="<%= contextPath %>/favorites"
               class="menu-card">

                <div class="menu-icon">
                    ❤️
                </div>

                <div class="menu-title">
                    Favorites
                </div>

                <div class="menu-description">
                    View your saved restaurants and dishes.
                </div>

            </a>


            <a href="<%= contextPath %>/settings"
               class="menu-card">

                <div class="menu-icon">
                    ⚙️
                </div>

                <div class="menu-title">
                    Settings
                </div>

                <div class="menu-description">
                    Manage your account preferences.
                </div>

            </a>


          

        </div>

    </section>


    <!-- LOGOUT -->

    <a href="<%= contextPath %>/logout"
       class="logout">
        Logout
    </a>

</main>

</body>

</html>