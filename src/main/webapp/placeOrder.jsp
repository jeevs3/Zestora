<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.Food.Model.CartItem" %>
<%@ page import="com.Food.Model.Menu" %>
<%@ page import="com.Food.Model.User" %>
<%@ page import="com.Food.DAO.UserDAO" %>
<%@ page import="com.Food.daoimp.UserDAOImpl" %>


<%
    String contextPath = request.getContextPath();


    /* =====================================================
       USER / PROFILE
       ===================================================== */

    User user = (User) request.getAttribute("user");

    /*
     * If PlaceOrderServlet did not send the user object,
     * get the logged-in user directly using the session ID.
     */

    if (user == null) {

        Integer loggedInUserId =
            (Integer) session.getAttribute("userId");

        if (loggedInUserId != null) {

            try {

                UserDAO userDAO = new UserDAOImpl();

                user = userDAO.getUser(loggedInUserId);

            } catch (Exception e) {

                e.printStackTrace();

            }
        }
    }


    /* =====================================================
       USER INITIAL
       ===================================================== */

    String userInitial = "U";

    if (user != null &&
        user.getUserName() != null &&
        !user.getUserName().trim().isEmpty()) {

        userInitial =
            user.getUserName()
                .trim()
                .substring(0, 1)
                .toUpperCase();
    }


    /* =====================================================
       REAL ORDER DATA
       ===================================================== */

    String orderId =
        (String) request.getAttribute("orderId");

    String restaurantName =
        (String) request.getAttribute("restaurantName");

    String deliveryAddress =
        (String) request.getAttribute("deliveryAddress");

    String pincode =
        (String) request.getAttribute("pincode");

    String paymentMethod =
        (String) request.getAttribute("paymentMethod");

    String paymentStatus =
        (String) request.getAttribute("paymentStatus");


    /* =====================================================
       TOTALS
       ===================================================== */

    Double itemTotalObj =
        (Double) request.getAttribute("itemTotal");

    Double deliveryFeeObj =
        (Double) request.getAttribute("deliveryFee");

    Double discountObj =
        (Double) request.getAttribute("discount");

    Double toPayObj =
        (Double) request.getAttribute("toPay");


    double itemTotal =
        itemTotalObj != null
            ? itemTotalObj
            : 0.0;


    double deliveryFee =
        deliveryFeeObj != null
            ? deliveryFeeObj
            : 0.0;


    double discount =
        discountObj != null
            ? discountObj
            : 0.0;


    double toPay =
        toPayObj != null
            ? toPayObj
            : itemTotal + deliveryFee - discount;


    /* =====================================================
       ORDER ITEMS
       ===================================================== */

    List<CartItem> orderItems =
        (List<CartItem>) request.getAttribute("orderItems");

    List<Menu> orderMenus =
        (List<Menu>) request.getAttribute("orderMenus");


    /* =====================================================
       SAFE DEFAULTS
       ===================================================== */

    if (orderId == null) {
        orderId = "N/A";
    }


    if (restaurantName == null) {
        restaurantName = "Restaurant";
    }


    if (deliveryAddress == null ||
        deliveryAddress.trim().isEmpty()) {

        deliveryAddress =
            "Delivery address not available";
    }


    if (pincode == null) {
        pincode = "";
    }


    if (paymentMethod == null) {
        paymentMethod = "Not selected";
    }


    if (paymentStatus == null) {
        paymentStatus = "Pending";
    }

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Order Placed Successfully - Zestora
</title>


<style>

/* =====================================================
   RESET
   ===================================================== */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}


body {

    font-family:
        Arial,
        Helvetica,
        sans-serif;

    background: #fafafa;

    color: #222222;

}


/* =====================================================
   HEADER
   ===================================================== */

.header {

    height: 76px;

    background: #ffffff;

    border-bottom: 1px solid #eeeeee;

    display: flex;

    align-items: center;

    padding: 0 34px;

    gap: 36px;

}


/* =====================================================
   LOGO
   ===================================================== */

.logo {

    font-size: 34px;

    font-weight: 800;

    color: #111111;

    white-space: nowrap;

}


.logo-black {
    color: #111111;
}

.logo-red {
    color: #E53935;
}


/* =====================================================
   NAVIGATION
   ===================================================== */

.nav {

    display: flex;

    gap: 28px;

}


.nav a {

    text-decoration: none;

    color: #222222;

    font-size: 15px;

    font-weight: 500;

}


.nav a:hover {

    color: #e93626;

}


/* =====================================================
   HEADER RIGHT
   ===================================================== */

.header-right {

    margin-left: auto;

    display: flex;

    align-items: center;

    gap: 12px;

}


/* =====================================================
   DELIVERY ADDRESS
   ===================================================== */

.location {

    max-width: 270px;

    color: #333333;

    font-size: 13px;

    line-height: 1.35;

    display: flex;

    align-items: center;

    gap: 5px;

}


.location-text {

    max-width: 230px;

    overflow: hidden;

    text-overflow: ellipsis;

    white-space: nowrap;

}


/* =====================================================
   HEADER ICON
   ===================================================== */

.header-link {

    text-decoration: none;

    color: #222222;

}


.header-icon {

    width: 42px;

    height: 42px;

    border-radius: 50%;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 22px;

    cursor: pointer;

    transition: 0.2s ease;

}


.header-icon:hover {

    background: #f5f5f5;

    transform: scale(1.05);

}


/* =====================================================
   PROFILE
   ===================================================== */

.profile {

    display: flex;

    align-items: center;

    gap: 9px;

    padding: 5px 13px 5px 6px;

    background: #f7f7f7;

    border-radius: 30px;

    cursor: pointer;

    transition: 0.2s ease;

}


.profile:hover {

    background: #eeeeee;

}


.profile-avatar {

    width: 36px;

    height: 36px;

    border-radius: 50%;

    background: #e93626;

    color: #ffffff;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 16px;

    font-weight: 700;

}


.profile-name {

    font-size: 14px;

    font-weight: 700;

}


.profile-arrow {

    font-size: 12px;

}


/* =====================================================
   MAIN CONTAINER
   ===================================================== */

.container {

    max-width: 1480px;

    margin: 30px auto;

    padding: 0 32px;

}


.layout {

    display: grid;

    grid-template-columns:
        minmax(0, 2fr)
        minmax(350px, 1fr);

    gap: 28px;

}


/* =====================================================
   SUCCESS BOX
   ===================================================== */

.success-box {

    background: #eaf9ee;

    border: 1px solid #d1efd8;

    border-radius: 14px;

    padding: 28px;

    display: flex;

    align-items: center;

    gap: 24px;

    margin-bottom: 22px;

}


.success-icon {

    width: 72px;

    height: 72px;

    min-width: 72px;

    border-radius: 50%;

    background: #16a34a;

    color: #ffffff;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 42px;

    font-weight: bold;

}


.success-content h1 {

    font-family: Georgia, serif;

    font-size: 31px;

    margin-bottom: 10px;

}


.success-content p {

    color: #555555;

    line-height: 1.5;

    margin-bottom: 7px;

}


.delivery-time {

    color: #149447 !important;

    font-weight: 700;

}


/* =====================================================
   LEFT CARDS
   ===================================================== */

.left-cards {

    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 20px;

}


.card {

    background: #ffffff;

    border: 1px solid #e5e5e5;

    border-radius: 13px;

    padding: 24px;

    min-width: 0;

}


.card h2 {

    font-family: Georgia, serif;

    font-size: 24px;

    margin-bottom: 26px;

}


/* =====================================================
   ORDER DETAILS
   ===================================================== */

.detail-row {

    display: grid;

    grid-template-columns:
        28px
        120px
        minmax(0, 1fr);

    gap: 10px;

    margin-bottom: 22px;

    align-items: start;

}


.detail-icon {

    font-size: 19px;

    line-height: 1.5;

}


.detail-label {

    color: #666666;

    font-weight: 600;

    font-size: 14px;

    line-height: 1.5;

}


.detail-value {

    color: #333333;

    line-height: 1.5;

    font-size: 14px;

    word-break: break-word;

}


.payment-status {

    display: inline-block;

    background: #e4f8e8;

    color: #149447;

    padding: 6px 12px;

    border-radius: 20px;

    font-weight: 700;

    font-size: 13px;

}


/* =====================================================
   ORDER STATUS
   ===================================================== */

.status {

    width: 100%;

    margin-top: 4px;

}


.status-item {

    position: relative;

    display: grid;

    grid-template-columns:
        38px
        minmax(0, 1fr);

    column-gap: 14px;

    min-height: 94px;

}


/* =====================================================
   TIMELINE LINE
   ===================================================== */

.status-item:not(:last-child)::before {

    content: "";

    position: absolute;

    left: 17px;

    top: 36px;

    width: 3px;

    height: 58px;

    background: #dddddd;

    z-index: 0;

}


.status-item.completed:not(:last-child)::before {

    background: #16a34a;

}


/* =====================================================
   STATUS CIRCLE
   ===================================================== */

.status-circle {

    position: relative;

    width: 36px;

    height: 36px;

    border-radius: 50%;

    background: #ffffff;

    border: 3px solid #cccccc;

    display: flex;

    align-items: center;

    justify-content: center;

    color: #cccccc;

    font-size: 15px;

    font-weight: 700;

    z-index: 2;

}


/* COMPLETED */

.status-item.completed .status-circle {

    background: #16a34a;

    border-color: #16a34a;

    color: #ffffff;

}


/* =====================================================
   STATUS CONTENT
   ===================================================== */

.status-content {

    min-width: 0;

    padding-top: 2px;

}


.status-title {

    font-weight: 700;

    font-size: 16px;

    line-height: 1.5;

    margin-bottom: 4px;

    color: #222222;

}


.status-text {

    color: #777777;

    font-size: 13px;

    line-height: 1.5;

    max-width: 260px;

}


/* =====================================================
   ORDER SUMMARY
   ===================================================== */

.summary {

    min-height: 600px;

}


.summary-header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 10px;

    margin-bottom: 24px;

}


.summary-header h2 {

    margin: 0;

}


.view-details {

    color: #e93626;

    font-size: 14px;

    font-weight: 700;

    white-space: nowrap;

}


/* =====================================================
   ORDER ITEM
   ===================================================== */

.order-item {

    display: flex;

    align-items: center;

    gap: 13px;

    padding-bottom: 17px;

    margin-bottom: 17px;

    border-bottom: 1px solid #eeeeee;

}


.food-image {

    width: 68px;

    height: 68px;

    min-width: 68px;

    border-radius: 10px;

    overflow: hidden;

    background: #f2f2f2;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 28px;

}


.food-image img {

    width: 100%;

    height: 100%;

    object-fit: cover;

}


.food-info {

    flex: 1;

    min-width: 0;

}


.food-name {

    font-weight: 700;

    font-size: 16px;

    margin-bottom: 6px;

}


.food-price {

    color: #777777;

    font-size: 14px;

}


.food-total {

    font-weight: 700;

    font-size: 15px;

    white-space: nowrap;

}


.no-items {

    padding: 20px;

    text-align: center;

    color: #777777;

    background: #fafafa;

    border-radius: 10px;

}


/* =====================================================
   BILL
   ===================================================== */

.bill {

    border-top: 1px solid #eeeeee;

    margin-top: 22px;

    padding-top: 20px;

}


.bill-row {

    display: flex;

    justify-content: space-between;

    margin-bottom: 15px;

    color: #666666;

    font-size: 15px;

}


.discount {

    color: #159447;

}


.total {

    border-top: 1px solid #eeeeee;

    margin-top: 18px;

    padding-top: 18px;

    color: #111111;

    font-size: 20px;

    font-weight: 700;

}


.total span:last-child {

    color: #e93626;

    font-size: 25px;

}


/* =====================================================
   ENJOY MESSAGE
   ===================================================== */

.enjoy {

    background: #fff1ef;

    border-radius: 10px;

    padding: 17px;

    margin-top: 22px;

    display: flex;

    gap: 13px;

    align-items: center;

}


.heart {

    font-size: 29px;

}


.enjoy-title {

    color: #c9271b;

    font-weight: 700;

    margin-bottom: 4px;

}


.enjoy-text {

    color: #666666;

    font-size: 13px;

    line-height: 1.4;

}


/* =====================================================
   TRACK ORDER
   ===================================================== */

.track-btn {

    width: 100%;

    display: flex;

    align-items: center;

    justify-content: center;

    box-sizing: border-box;

    border: none;

    background: #e93626;

    color: #ffffff;

    padding: 14px;

    border-radius: 10px;

    font-size: 16px;

    font-weight: 700;

    margin-top: 18px;

    cursor: pointer;

    text-decoration: none;

    transition: 0.2s ease;

}


.track-btn:hover {

    background: #d92f20;

}


/* =====================================================
   CONTINUE SHOPPING
   ===================================================== */

.continue-btn {

    display: flex;

    align-items: center;

    justify-content: center;

    width: 100%;

    text-align: center;

    text-decoration: none;

    color: #222222;

    border: 1px solid #bbbbbb;

    padding: 13px;

    border-radius: 10px;

    font-weight: 700;

    margin-top: 11px;

}


.continue-btn:hover {

    background: #f7f7f7;

}


/* =====================================================
   RESPONSIVE
   ===================================================== */

@media (max-width: 1100px) {

    .header {

        padding: 0 20px;

        gap: 18px;

    }


    .nav {

        display: none;

    }


    .location {

        max-width: 220px;

    }

}


@media (max-width: 900px) {

    .layout {

        grid-template-columns: 1fr;

    }


    .left-cards {

        grid-template-columns: 1fr 1fr;

    }


    .summary {

        min-height: auto;

    }

}


@media (max-width: 650px) {

    .container {

        padding: 0 15px;

        margin-top: 18px;

    }


    .header {

        padding: 0 14px;

    }


    .header-right {

        gap: 3px;

    }


    .location {

        display: none;

    }


    .profile-name,

    .profile-arrow {

        display: none;

    }


    .profile {

        padding: 4px;

    }


    .left-cards {

        grid-template-columns: 1fr;

    }


    .success-box {

        padding: 20px;

    }


    .success-icon {

        width: 58px;

        height: 58px;

        min-width: 58px;

        font-size: 32px;

    }


    .success-content h1 {

        font-size: 24px;

    }


    .card {

        padding: 20px;

    }


    .detail-row {

        grid-template-columns:
            28px
            110px
            minmax(0, 1fr);

    }

}

</style>

</head>


<body>


<!-- =====================================================
     HEADER
     ===================================================== -->

<header class="header">


    <!-- LOGO -->

     <div class="logo">
    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>

    <!-- NAVIGATION -->

    <nav class="nav">

        <a href="<%=contextPath%>/index.jsp">
            Home
        </a>


        <a href="<%=contextPath%>/restaurant">
            Restaurants
        </a>


        <a href="<%=contextPath%>/help">
            Help
        </a>

    </nav>


    <!-- HEADER RIGHT -->

    <div class="header-right">


        <!-- SAVED DELIVERY ADDRESS -->

        <div class="location"
             title="<%=deliveryAddress%>">

            📍

            <span class="location-text">
                <%=deliveryAddress%>
            </span>

        </div>


        <!-- FAVORITES -->

        <a href="<%=contextPath%>/favorites"
           class="header-link"
           title="Favorites">

            <div class="header-icon">

                ♡

            </div>

        </a>


        <!-- CART -->

        <a href="<%=contextPath%>/cart"
           class="header-link"
           title="Cart">

            <div class="header-icon">

                🛒

            </div>

        </a>


        <!-- ACCOUNT -->

        <div class="profile"
             onclick="window.location.href='<%=contextPath%>/account'"
             title="Account">


            <div class="profile-avatar">

                <%=userInitial%>

            </div>


           

        </div>


    </div>

</header>



<!-- =====================================================
     MAIN
     ===================================================== -->

<main class="container">


<div class="layout">


    <!-- =================================================
         LEFT SIDE
         ================================================= -->

    <section>


        <!-- SUCCESS MESSAGE -->

        <div class="success-box">


            <div class="success-icon">

                ✓

            </div>


            <div class="success-content">

                <h1>

                    Order Placed Successfully!

                </h1>


                <p>

                    Thank you for choosing Zestora.
                    Your order has been placed successfully.

                </p>


                <p class="delivery-time">

                    Estimated delivery:
                    25 – 30 minutes

                </p>

            </div>


        </div>



        <!-- =================================================
             ORDER DETAILS + STATUS
             ================================================= -->

        <div class="left-cards">


            <!-- =================================================
                 ORDER DETAILS
                 ================================================= -->

            <div class="card">


                <h2>

                    Order Details

                </h2>


                <!-- ORDER ID -->

                <div class="detail-row">


                    <div class="detail-icon">

                        🧾

                    </div>


                    <div class="detail-label">

                        Order ID

                    </div>


                    <div class="detail-value">

                        #<%=orderId%>

                    </div>


                </div>


                <!-- RESTAURANT -->

                <div class="detail-row">


                    <div class="detail-icon">

                        🏪

                    </div>


                    <div class="detail-label">

                        Restaurant

                    </div>


                    <div class="detail-value">

                        <%=restaurantName%>

                    </div>


                </div>


                <!-- DELIVERY ADDRESS -->

                <div class="detail-row">


                    <div class="detail-icon">

                        📍

                    </div>


                    <div class="detail-label">

                        Delivery Address

                    </div>


                    <div class="detail-value">

                        <%=deliveryAddress%>


                        <% if (!pincode.isEmpty()) { %>

                            <br>


                            <strong>

                                Pincode:

                            </strong>

                            <%=pincode%>

                        <% } %>

                    </div>


                </div>


                <!-- PAYMENT -->

                <div class="detail-row">


                    <div class="detail-icon">

                        💳

                    </div>


                    <div class="detail-label">

                        Payment

                    </div>


                    <div class="detail-value">

                        <%=paymentMethod%>

                    </div>


                </div>


                <!-- PAYMENT STATUS -->

                <div class="detail-row">


                    <div class="detail-icon">

                        ✓

                    </div>


                    <div class="detail-label">

                        Payment Status

                    </div>


                    <div class="detail-value">


                        <span class="payment-status">

                            <%=paymentStatus%>

                        </span>


                    </div>


                </div>


            </div>



            <!-- =================================================
                 ORDER STATUS
                 ================================================= -->

            <div class="card">


                <h2>

                    Order Status

                </h2>


                <div class="status">


                    <!-- ORDER PLACED -->

                    <div class="status-item completed">


                        <div class="status-circle">

                            ✓

                        </div>


                        <div class="status-content">

                            <div class="status-title">

                                Order Placed

                            </div>


                            <div class="status-text">

                                Your order has been confirmed.

                            </div>

                        </div>


                    </div>



                    <!-- PREPARING -->

                    <div class="status-item">


                        <div class="status-circle">

                        </div>


                        <div class="status-content">

                            <div class="status-title">

                                Preparing

                            </div>


                            <div class="status-text">

                                The restaurant will prepare your order.

                            </div>

                        </div>


                    </div>



                    <!-- OUT FOR DELIVERY -->

                    <div class="status-item">


                        <div class="status-circle">

                        </div>


                        <div class="status-content">

                            <div class="status-title">

                                Out for Delivery

                            </div>


                            <div class="status-text">

                                Your order will be on the way soon.

                            </div>

                        </div>


                    </div>



                    <!-- DELIVERED -->

                    <div class="status-item">


                        <div class="status-circle">

                        </div>


                        <div class="status-content">

                            <div class="status-title">

                                Delivered

                            </div>


                            <div class="status-text">

                                Enjoy your meal!

                            </div>

                        </div>


                    </div>


                </div>


            </div>


        </div>


    </section>



    <!-- =================================================
         RIGHT SIDE — ORDER SUMMARY
         ================================================= -->

    <aside class="card summary">


        <div class="summary-header">


            <h2>

                Order Summary

            </h2>


            <span class="view-details">

                Order #<%=orderId%>

            </span>


        </div>



        <!-- =================================================
             REAL ORDER ITEMS
             ================================================= -->

        <%

            if (orderItems != null &&
                !orderItems.isEmpty() &&
                orderMenus != null) {


                for (CartItem item : orderItems) {


                    Menu orderedMenu = null;


                    for (Menu menu : orderMenus) {


                        if (menu.getMenuId() ==
                            item.getMenuId()) {


                            orderedMenu = menu;

                            break;

                        }

                    }


                    if (orderedMenu != null) {


                        double itemAmount =
                            item.getPrice() *
                            item.getQuantity();

        %>


        <div class="order-item">


            <!-- FOOD IMAGE -->

            <div class="food-image">


                <%

                    String photo =
                        orderedMenu.getPhoto();


                    if (photo != null &&
                        !photo.trim().isEmpty()) {

                %>


                    <img
                        src="<%=contextPath%>/<%=photo%>"
                        alt="<%=orderedMenu.getItemName()%>"
                    >


                <%

                    } else {

                %>


                    🍽️


                <%

                    }

                %>


            </div>



            <!-- FOOD DETAILS -->

            <div class="food-info">


                <div class="food-name">

                    <%=orderedMenu.getItemName()%>

                </div>


                <div class="food-price">

                    ₹<%=String.format(
                        "%.0f",
                        item.getPrice()
                    )%>

                    ×

                    <%=item.getQuantity()%>

                </div>


            </div>



            <!-- ITEM TOTAL -->

            <div class="food-total">

                ₹<%=String.format(
                    "%.0f",
                    itemAmount
                )%>

            </div>


        </div>


        <%

                    }

                }


            } else {

        %>


        <div class="no-items">

            No order items found.

        </div>


        <%

            }

        %>



        <!-- =================================================
             BILL
             ================================================= -->

        <div class="bill">


            <!-- ITEM TOTAL -->

            <div class="bill-row">

                <span>

                    Item Total

                </span>


                <span>

                    ₹<%=String.format(
                        "%.0f",
                        itemTotal
                    )%>

                </span>

            </div>


            <!-- DELIVERY -->

            <div class="bill-row">

                <span>

                    Delivery Fee

                </span>


                <span>

                    ₹<%=String.format(
                        "%.0f",
                        deliveryFee
                    )%>

                </span>

            </div>


            <!-- DISCOUNT -->

            <% if (discount > 0) { %>


            <div class="bill-row discount">

                <span>

                    Discount

                </span>


                <span>

                    − ₹<%=String.format(
                        "%.0f",
                        discount
                    )%>

                </span>

            </div>


            <% } %>



            <!-- TOTAL -->

            <div class="bill-row total">

                <span>

                    Total Paid

                </span>


                <span>

                    ₹<%=String.format(
                        "%.0f",
                        toPay
                    )%>

                </span>

            </div>


        </div>



        <!-- =================================================
             ENJOY MESSAGE
             ================================================= -->

        <div class="enjoy">


            <div class="heart">

                ❤️

            </div>


            <div>


                <div class="enjoy-title">

                    Enjoy your food!

                </div>


                <div class="enjoy-text">

                    We hope you have a great meal.
                    See you again soon!

                </div>


            </div>


        </div>



        <!-- =================================================
             TRACK ORDER
             ================================================= -->

        <a href="<%=contextPath%>/orders"
           class="track-btn">

            📍 Track Order

        </a>



        <!-- =================================================
             CONTINUE SHOPPING
             ================================================= -->

        <a href="<%=contextPath%>/restaurant"
           class="continue-btn">

            🏠 &nbsp; Continue Shopping

        </a>


    </aside>


</div>


</main>


</body>

</html>