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

    <title>Help & Support - Zestora</title>

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

        /* ================= MAIN ================= */

        .container {
            width: 90%;
            max-width: 900px;

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

        /* ================= SUPPORT CARD ================= */

        .support-card {
            background: white;

            border-radius: 18px;

            padding: 25px;

            margin-bottom: 25px;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.05);
        }

        .support-card h2 {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .support-card p {
            color: #777;
            line-height: 1.6;
        }

        /* ================= FAQ ================= */

        .faq-title {
            font-size: 22px;
            margin-bottom: 15px;
        }

        .faq-item {
            background: white;

            border-radius: 15px;

            margin-bottom: 12px;

            overflow: hidden;

            box-shadow:
                0 3px 12px rgba(0,0,0,0.04);
        }

        .faq-question {
            width: 100%;

            border: none;

            background: white;

            padding: 20px;

            display: flex;

            justify-content: space-between;
            align-items: center;

            text-align: left;

            font-size: 16px;
            font-weight: 600;

            cursor: pointer;
        }

        .faq-question:hover {
            background: #fafafa;
        }

        .faq-answer {
            display: none;

            padding: 0 20px 20px;

            color: #666;

            line-height: 1.6;

            font-size: 14px;
        }

        .faq-item.active .faq-answer {
            display: block;
        }

        .arrow {
            font-size: 20px;

            transition: 0.2s;
        }

        .faq-item.active .arrow {
            transform: rotate(180deg);
        }

        /* ================= CONTACT ================= */

        .contact-grid {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 15px;

            margin-top: 20px;
        }

        .contact-box {
            border: 1px solid #eee;

            border-radius: 14px;

            padding: 20px;

            text-decoration: none;

            color: inherit;

            transition: 0.2s;
        }

        .contact-box:hover {
            border-color: #e53935;

            transform: translateY(-2px);
        }

        .contact-icon {
            font-size: 25px;

            margin-bottom: 10px;
        }

        .contact-name {
            font-weight: 700;

            margin-bottom: 5px;
        }

        .contact-detail {
            color: #777;

            font-size: 14px;
        }

        /* ================= ORDER HELP ================= */

        .help-list {
            margin-top: 15px;

            padding-left: 20px;

            color: #666;

            line-height: 1.8;
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

            .contact-grid {
                grid-template-columns: 1fr;
            }

            .faq-question {
                padding: 17px;
            }

        }

    </style>

</head>


<body>


<!-- =====================================================
     HEADER
===================================================== -->

<header>

    <div class="logo">
        Zestora<span>.</span>
    </div>

    <button class="back-btn"
            onclick="history.back()">

        ← Back

    </button>

</header>


<!-- =====================================================
     MAIN
===================================================== -->

<div class="container">

    <h1 class="title">
        Help & Support
    </h1>

    <p class="subtitle">
        We're here to help you with your Zestora experience.
    </p>


    <!-- =================================================
         QUICK HELP
    ================================================== -->

    <div class="support-card">

        <h2>
            How can we help?
        </h2>

        <p>
            Find answers to common questions about orders,
            payments, delivery and your Zestora account below.
        </p>

    </div>


    <!-- =================================================
         FAQ
    ================================================== -->

    <h2 class="faq-title">
        Frequently Asked Questions
    </h2>


    <!-- ORDER -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                How can I check my order?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            Open <b>My Orders</b> from your Account section.
            You can see your order details, restaurant,
            items, payment status and order status there.

        </div>

    </div>


    <!-- ADD TO CART -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                How do I add food to my cart?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            Open a restaurant, select the food you want and
            click the <b>ADD</b> button. The item will be added
            to your cart.

        </div>

    </div>


    <!-- FAVORITES -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                How do I save my favorite food?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            Click the heart ♡ beside a food item.
            Your favorite food will be saved to
            <b>My Favorites</b>.

        </div>

    </div>


    <!-- PAYMENT -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                What payment methods are available?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            Zestora supports the payment options displayed
            during checkout, such as UPI, card, net banking
            and cash on delivery where available.

        </div>

    </div>


    <!-- PAYMENT STATUS -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                Why is my payment status showing PENDING?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            A payment can temporarily show as
            <b>PENDING</b> while the payment process is
            being completed or verified.

        </div>

    </div>


    <!-- DELIVERY -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                Can I change my delivery address?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            You can update your delivery details from the
            checkout page before placing your order.

        </div>

    </div>


    <!-- CART -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                Can I order from two restaurants at once?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            Currently, one cart contains items from one
            restaurant at a time. If you add an item from
            another restaurant, the cart will switch to that
            restaurant.

        </div>

    </div>


    <!-- ACCOUNT -->

    <div class="faq-item">

        <button class="faq-question"
                onclick="toggleFAQ(this)">

            <span>
                How can I manage my account?
            </span>

            <span class="arrow">
                ▼
            </span>

        </button>

        <div class="faq-answer">

            Go to <b>Account</b> to view your personal
            information, orders, favorites, settings and
            support options.

        </div>

    </div>


    <!-- =================================================
         CONTACT SUPPORT
    ================================================== -->

    <div class="support-card">

        <h2>
            Contact Support
        </h2>

        <p>
            Still need help? Contact the Zestora support team.
        </p>


        <div class="contact-grid">


            <!-- EMAIL -->

            <a class="contact-box"
               href="mailto:support@zestora.com">

                <div class="contact-icon">
                    ✉️
                </div>

                <div class="contact-name">
                    Email Support
                </div>

                <div class="contact-detail">
                    support@zestora.com
                </div>

            </a>


            <!-- PHONE -->

            <a class="contact-box"
               href="tel:+918000000000">

                <div class="contact-icon">
                    📞
                </div>

                <div class="contact-name">
                    Call Support
                </div>

                <div class="contact-detail">
                    +91 80000 00000
                </div>

            </a>

        </div>

    </div>


    <!-- =================================================
         ACCOUNT BUTTON
    ================================================== -->

    <div style="text-align:center; margin-top:30px;">

        <a href="<%= contextPath %>/account"
           style="
               display:inline-block;
               background:#e53935;
               color:white;
               text-decoration:none;
               padding:13px 25px;
               border-radius:12px;
               font-weight:600;
           ">

            ← Back to Account

        </a>

    </div>


</div>


<!-- =====================================================
     JAVASCRIPT
===================================================== -->

<script>

    function toggleFAQ(button) {

        const item =
            button.parentElement;

        item.classList.toggle("active");

    }

</script>


</body>

</html>