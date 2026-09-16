<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String contextPath = request.getContextPath();

    List<Map<String, Object>> orders =
        (List<Map<String, Object>>) request.getAttribute("orders");

    if (orders == null) {
        orders = new java.util.ArrayList<>();
    }

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>My Orders - Zestora</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f7f7f7;
    color: #292929;
}

.header {
    background: #ffffff;
    border-bottom: 1px solid #e5e5e5;
    position: sticky;
    top: 0;
    z-index: 10;
}

.header-row {
    max-width: 1100px;
    margin: auto;
    padding: 18px 25px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.logo {
    font-size: 28px;
    font-weight: 800;
    color: #222;
}

.logo b {
    color: #d7352d;
}

.back-btn,
.cart-btn {
    border: 0;
    padding: 11px 16px;
    border-radius: 10px;
    cursor: pointer;
    font-weight: 600;
}

.back-btn {
    background: #f1eeee;
}

.cart-btn {
    background: #d7352d;
    color: white;
}

.page {
    max-width: 1000px;
    margin: 45px auto;
    padding: 0 20px 60px;
}

.title {
    font-family: Georgia, serif;
    font-size: 40px;
    margin-bottom: 8px;
}

.subtitle {
    color: #777;
    margin-bottom: 30px;
}

.tabs {
    display: flex;
    gap: 10px;
    margin-bottom: 25px;
    flex-wrap: wrap;
}

.tab {
    border: 1px solid #ddd;
    background: white;
    padding: 10px 18px;
    border-radius: 20px;
    cursor: pointer;
}

.tab.active {
    background: #222;
    color: white;
}

.order-card {
    background: white;
    border: 1px solid #e6e1dc;
    border-radius: 18px;
    margin-bottom: 25px;
    overflow: hidden;
    box-shadow: 0 5px 18px rgba(0,0,0,0.04);
}

.order-head {
    padding: 20px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    gap: 15px;
}

.restaurant {
    font-size: 21px;
    font-weight: 700;
}

.order-id {
    color: #777;
    font-size: 13px;
    margin-top: 5px;
}

.status {
    padding: 7px 12px;
    border-radius: 20px;
    background: #e9f7ed;
    color: #16803c;
    font-size: 13px;
    font-weight: 700;
    height: fit-content;
}

.items {
    padding: 15px 20px;
}

.item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;
}

.item:last-child {
    border-bottom: 0;
}

.item-photo {
    width: 65px;
    height: 65px;
    object-fit: cover;
    border-radius: 12px;
    background: #eee;
}

.item-info {
    flex: 1;
}

.item-name {
    font-weight: 600;
    margin-bottom: 5px;
}

.item-meta {
    color: #777;
    font-size: 14px;
}

.item-price {
    font-weight: 600;
}

.details {
    padding: 20px;
    background: #faf9f7;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    margin: 9px 0;
    color: #666;
}

.total {
    border-top: 1px solid #ddd;
    padding-top: 13px;
    margin-top: 13px;
    font-size: 18px;
    color: #222;
    font-weight: 700;
}

.delivery {
    padding: 20px;
    border-top: 1px solid #eee;
}

.delivery-title {
    font-weight: 700;
    margin-bottom: 8px;
}

.delivery p {
    margin: 4px 0;
    color: #666;
}

.payment {
    padding: 0 20px 20px;
}

.payment span {
    display: inline-block;
    background: #f1eeee;
    padding: 8px 12px;
    border-radius: 8px;
    font-size: 13px;
}

.empty {
    background: white;
    border: 1px solid #e6e1dc;
    border-radius: 18px;
    padding: 70px 20px;
    text-align: center;
}

.empty-icon {
    font-size: 55px;
    margin-bottom: 15px;
}

.empty h2 {
    font-family: Georgia, serif;
}

.empty p {
    color: #777;
    margin-bottom: 25px;
}

.browse {
    border: 0;
    background: #d7352d;
    color: white;
    padding: 13px 22px;
    border-radius: 10px;
    cursor: pointer;
    font-weight: 600;
}

.error {
    background: #fff0f0;
    color: #b42318;
    border: 1px solid #f1baba;
    padding: 14px;
    border-radius: 10px;
    margin-bottom: 20px;
}

@media(max-width:650px) {

    .header-row {
        padding: 14px;
    }

    .logo {
        font-size: 25px;
    }

    .page {
        margin-top: 25px;
        padding: 0 15px 45px;
    }

    .title {
        font-size: 31px;
    }

    .order-head {
        flex-direction: column;
    }

}

</style>

</head>

<body>

<header class="header">

    <div class="header-row">

        <div class="logo">
            Zestora<b>.</b>
        </div>

        <button class="back-btn"
                onclick="history.back()">
            ← Back
        </button>

        <button class="cart-btn"
                onclick="location.href='<%= contextPath %>/cart'">
            🛒 Cart
        </button>

    </div>

</header>


<main class="page">

    <h1 class="title">
        My Orders
    </h1>

    <p class="subtitle">
        Track your orders and view your previous purchases.
    </p>


    <div class="tabs">

        <button class="tab active">
            All Orders
        </button>

        <button class="tab">
            Active
        </button>

        <button class="tab">
            Delivered
        </button>

    </div>


    <%
        String errorMessage =
            (String) request.getAttribute("errorMessage");

        if (errorMessage != null) {
    %>

        <div class="error">
            <%= errorMessage %>
        </div>

    <%
        }
    %>


    <%
        if (orders.isEmpty()) {
    %>

        <div class="empty">

            <div class="empty-icon">
                📦
            </div>

            <h2>
                No orders yet
            </h2>

            <p>
                Your Zestora orders will appear here
                after you place an order.
            </p>

            <button class="browse"
                    onclick="location.href='<%= contextPath %>/restaurant'">
                Browse Restaurants
            </button>

        </div>

    <%
        } else {

            for (Map<String, Object> order : orders) {

                int orderId =
                    (Integer) order.get("orderId");

                String restaurantName =
                    (String) order.get("restaurantName");

                if (restaurantName == null ||
                    restaurantName.trim().isEmpty()) {

                    restaurantName = "Restaurant";
                }

                String orderStatus =
                    (String) order.get("orderStatus");

                if (orderStatus == null) {
                    orderStatus = "PLACED";
                }

                java.sql.Timestamp createdAt =
                    (java.sql.Timestamp) order.get("createdAt");

                List<Map<String, Object>> items =
                    (List<Map<String, Object>>) order.get("items");
    %>


    <section class="order-card">

        <div class="order-head">

            <div>

                <div class="restaurant">
                    <%= restaurantName %>
                </div>

                <div class="order-id">
                    Order ID: #<%= orderId %>
                </div>

                <%
                    if (createdAt != null) {
                %>

                    <div class="order-id">
                        <%= dateFormat.format(createdAt) %>
                    </div>

                <%
                    }
                %>

            </div>

            <div class="status">
                <%= orderStatus %>
            </div>

        </div>


        <div class="items">

        <%
            if (items != null && !items.isEmpty()) {

                for (Map<String, Object> item : items) {

                    String itemName =
                        (String) item.get("itemName");

                    if (itemName == null) {
                        itemName = "Menu Item";
                    }

                    String photo =
                        (String) item.get("photo");

                    int quantity =
                        (Integer) item.get("quantity");

                    double price =
                        (Double) item.get("price");
        %>

            <div class="item">

                <%
                    if (photo != null &&
                        !photo.trim().isEmpty()) {
                %>

                    <img class="item-photo"
                         src="<%= photo %>"
                         alt="<%= itemName %>">

                <%
                    } else {
                %>

                    <div class="item-photo"
                         style="display:flex;align-items:center;justify-content:center;font-size:25px;">
                        🍽️
                    </div>

                <%
                    }
                %>


                <div class="item-info">

                    <div class="item-name">
                        <%= itemName %>
                    </div>

                    <div class="item-meta">
                        Quantity: <%= quantity %>
                    </div>

                </div>

                <div class="item-price">
                    ₹<%= String.format("%.2f", price * quantity) %>
                </div>

            </div>

        <%
                }

            } else {
        %>

            <p style="color:#777;">
                No item details available.
            </p>

        <%
            }
        %>

        </div>


        <div class="details">

            <div class="detail-row">
                <span>Item Total</span>
                <span>
                    ₹<%= String.format("%.2f",
                        (Double) order.get("itemTotal")) %>
                </span>
            </div>

            <div class="detail-row">
                <span>Delivery Fee</span>
                <span>
                    ₹<%= String.format("%.2f",
                        (Double) order.get("deliveryFee")) %>
                </span>
            </div>

            <div class="detail-row">
                <span>Discount</span>
                <span>
                    - ₹<%= String.format("%.2f",
                        (Double) order.get("discount")) %>
                </span>
            </div>

            <div class="detail-row total">
                <span>Total Paid</span>
                <span>
                    ₹<%= String.format("%.2f",
                        (Double) order.get("totalAmount")) %>
                </span>
            </div>

        </div>


        <div class="delivery">

            <div class="delivery-title">
                📍 Delivery Address
            </div>

            <p>
                <%= order.get("deliveryAddress") %>
            </p>

            <p>
                Pincode:
                <%= order.get("pincode") %>
            </p>

            <%
                String instruction =
                    (String) order.get("instruction");

                if (instruction != null &&
                    !instruction.trim().isEmpty()) {
            %>

                <p>
                    <b>Instruction:</b>
                    <%= instruction %>
                </p>

            <%
                }
            %>

        </div>


        <div class="payment">

            <span>
                💳
                <%= order.get("paymentMethod") %>
            </span>

            <span>
                Payment:
                <%= order.get("paymentStatus") %>
            </span>

        </div>

    </section>


    <%
            }
        }
    %>

</main>

</body>
</html>