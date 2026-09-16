<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Settings - Zestora</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            color: #222;
            transition: 0.3s;
        }

        /* ================= HEADER ================= */

        header {
            height: 80px;
            background: white;
            border-bottom: 1px solid #eee;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 8%;
        }

        .logo {
            font-size: 30px;
            font-weight: 800;
        }

        .logo span {
            color: #e53935;
        }

        .back-btn {
            border: none;
            background: #f0f0f0;
            padding: 12px 20px;
            border-radius: 12px;

            font-size: 14px;
            font-weight: 600;

            cursor: pointer;
        }

        /* ================= CONTAINER ================= */

        .container {
            width: 90%;
            max-width: 850px;
            margin: 40px auto;
        }

        .title {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 30px;
        }

        /* ================= SETTINGS CARD ================= */

        .settings-card {
            background: white;
            border-radius: 18px;
            margin-bottom: 20px;
            overflow: hidden;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.05);
        }

        .section-title {
            padding: 20px 24px;

            font-size: 18px;
            font-weight: 700;

            border-bottom: 1px solid #eee;
        }

        /* ================= ROW ================= */

        .setting-row {
            padding: 20px 24px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            border-bottom: 1px solid #f0f0f0;
        }

        .setting-row:last-child {
            border-bottom: none;
        }

        .setting-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .icon {
            width: 42px;
            height: 42px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f5f5f5;
            border-radius: 12px;

            font-size: 20px;
        }

        .setting-name {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .setting-description {
            color: #888;
            font-size: 13px;
        }

        /* ================= SWITCH ================= */

        .switch {
            position: relative;
            width: 50px;
            height: 28px;
        }

        .switch input {
            display: none;
        }

        .slider {
            position: absolute;
            inset: 0;

            background: #ccc;

            border-radius: 30px;

            cursor: pointer;

            transition: 0.3s;
        }

        .slider:before {
            content: "";

            position: absolute;

            width: 22px;
            height: 22px;

            left: 3px;
            top: 3px;

            background: white;

            border-radius: 50%;

            transition: 0.3s;
        }

        input:checked + .slider {
            background: #e53935;
        }

        input:checked + .slider:before {
            transform: translateX(22px);
        }

        /* ================= LINK ROW ================= */

        .link-row {
            text-decoration: none;
            color: inherit;

            cursor: pointer;
        }

        .arrow {
            font-size: 20px;
            color: #999;
        }

        .link-row:hover {
            background: #fafafa;
        }

        /* ================= DARK MODE ================= */

        body.dark {
            background: #181818;
            color: #f5f5f5;
        }

        body.dark header,
        body.dark .settings-card {
            background: #242424;
            border-color: #333;
        }

        body.dark .section-title,
        body.dark .setting-row {
            border-color: #333;
        }

        body.dark .setting-description {
            color: #aaa;
        }

        body.dark .icon,
        body.dark .back-btn {
            background: #333;
            color: white;
        }

        body.dark .link-row:hover {
            background: #2c2c2c;
        }

        /* ================= MOBILE ================= */

        @media(max-width: 600px) {

            header {
                padding: 0 5%;
            }

            .logo {
                font-size: 25px;
            }

            .container {
                width: 92%;
            }

            .setting-row {
                padding: 18px;
            }

            .setting-description {
                max-width: 220px;
            }
        }

    </style>

</head>


<body>

<!-- ================= HEADER ================= -->

<header>

    <div class="logo">
        Zestora<span>.</span>
    </div>

    <button class="back-btn"
            onclick="history.back()">
        ← Back
    </button>

</header>


<!-- ================= MAIN ================= -->

<div class="container">

    <h1 class="title">
        Settings
    </h1>

    <p class="subtitle">
        Manage your Zestora preferences and account.
    </p>


    <!-- =================================================
         PREFERENCES
    ================================================== -->

    <div class="settings-card">

        <div class="section-title">
            Preferences
        </div>


        <!-- NOTIFICATIONS -->

        <div class="setting-row">

            <div class="setting-info">

                <div class="icon">
                    🔔
                </div>

                <div>

                    <div class="setting-name">
                        Notifications
                    </div>

                    <div class="setting-description">
                        Receive updates about your orders and offers.
                    </div>

                </div>

            </div>


            <label class="switch">

                <input type="checkbox"
                       id="notificationsToggle">

                <span class="slider"></span>

            </label>

        </div>


        <!-- DARK MODE -->

        <div class="setting-row">

            <div class="setting-info">

                <div class="icon">
                    🌙
                </div>

                <div>

                    <div class="setting-name">
                        Dark Mode
                    </div>

                    <div class="setting-description">
                        Use a darker appearance across this page.
                    </div>

                </div>

            </div>


            <label class="switch">

                <input type="checkbox"
                       id="darkModeToggle">

                <span class="slider"></span>

            </label>

        </div>

    </div>


    <!-- =================================================
         ACCOUNT
    ================================================== -->

    <div class="settings-card">

        <div class="section-title">
            Account
        </div>


        <a class="setting-row link-row"
           href="<%= contextPath %>/account">

            <div class="setting-info">

                <div class="icon">
                    👤
                </div>

                <div>

                    <div class="setting-name">
                        Account Information
                    </div>

                    <div class="setting-description">
                        View and manage your personal information.
                    </div>

                </div>

            </div>

            <div class="arrow">
                →
            </div>

        </a>


        <a class="setting-row link-row"
           href="<%= contextPath %>/account">

            <div class="setting-info">

                <div class="icon">
                    🔒
                </div>

                <div>

                    <div class="setting-name">
                        Password & Security
                    </div>

                    <div class="setting-description">
                        Manage your account security.
                    </div>

                </div>

            </div>

            <div class="arrow">
                →
            </div>

        </a>

    </div>


    <!-- =================================================
         PRIVACY
    ================================================== -->

    <div class="settings-card">

        <div class="section-title">
            Privacy & Security
        </div>


        <div class="setting-row">

            <div class="setting-info">

                <div class="icon">
                    🛡️
                </div>

                <div>

                    <div class="setting-name">
                        Data & Privacy
                    </div>

                    <div class="setting-description">
                        Your personal information is used to provide Zestora services.
                    </div>

                </div>

            </div>

        </div>


        <div class="setting-row">

            <div class="setting-info">

                <div class="icon">
                    🔐
                </div>

                <div>

                    <div class="setting-name">
                        Secure Login
                    </div>

                    <div class="setting-description">
                        Your account requires authentication to access your information.
                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- =================================================
         HELP
    ================================================== -->

    <div class="settings-card">

        <div class="section-title">
            Support
        </div>


        <a class="setting-row link-row"
           href="<%= contextPath %>/help.jsp">

            <div class="setting-info">

                <div class="icon">
                    ❓
                </div>

                <div>

                    <div class="setting-name">
                        Help & Support
                    </div>

                    <div class="setting-description">
                        Find answers to common questions.
                    </div>

                </div>

            </div>

            <div class="arrow">
                →
            </div>

        </a>

    </div>


</div>


<script>

    // =====================================================
    // NOTIFICATIONS
    // =====================================================

    const notificationToggle =
        document.getElementById(
            "notificationsToggle"
        );

    const savedNotifications =
        localStorage.getItem(
            "zestora_notifications"
        );

    if (savedNotifications === null) {

        notificationToggle.checked = true;

    } else {

        notificationToggle.checked =
            savedNotifications === "true";
    }


    notificationToggle.addEventListener(
        "change",
        function() {

            localStorage.setItem(
                "zestora_notifications",
                this.checked
            );

        }
    );


    // =====================================================
    // DARK MODE
    // =====================================================

    const darkModeToggle =
        document.getElementById(
            "darkModeToggle"
        );

    const savedTheme =
        localStorage.getItem(
            "zestora_theme"
        );


    if (savedTheme === "dark") {

        document.body.classList.add("dark");

        darkModeToggle.checked = true;

    }


    darkModeToggle.addEventListener(
        "change",
        function() {

            if (this.checked) {

                document.body.classList.add("dark");

                localStorage.setItem(
                    "zestora_theme",
                    "dark"
                );

            } else {

                document.body.classList.remove("dark");

                localStorage.setItem(
                    "zestora_theme",
                    "light"
                );
            }

        }
    );

</script>


</body>
</html>