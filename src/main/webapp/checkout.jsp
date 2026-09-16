<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.Food.Model.CartItem" %>
<%@ page import="com.Food.Model.Menu" %>
<%@ page import="com.Food.Model.User" %>
<%@ page import="com.Food.Model.Restaurant" %>

<%
    String contextPath = request.getContextPath();

    User user = (User) request.getAttribute("user");

    List<CartItem> cartItems =
            (List<CartItem>) request.getAttribute("cartItems");

    List<Menu> menuList =
            (List<Menu>) request.getAttribute("menuList");

    Restaurant restaurant =
            (Restaurant) request.getAttribute("restaurant");

    Double itemTotal =
            (Double) request.getAttribute("itemTotal");

    Double deliveryFee =
            (Double) request.getAttribute("deliveryFee");

    Double discount =
            (Double) request.getAttribute("discount");

    Double toPay =
            (Double) request.getAttribute("toPay");

    if (itemTotal == null) itemTotal = 0.0;
    if (deliveryFee == null) deliveryFee = 0.0;
    if (discount == null) discount = 0.0;
    if (toPay == null) toPay = 0.0;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Zestora - Checkout</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #fff;
            color: #222;
        }

        /* =========================
           CONTAINER
           ========================= */

        .container {
            width: min(1100px, 92%);
            margin: auto;
        }

        /* =========================
           HEADER
           ========================= */

        header {
            border-bottom: 1px solid #eee;
            background: #fff;
        }

        .header-inner {
            min-height: 65px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font: 700 32px Georgia, serif;
        }

   .logo-black {
    color: #111111;
}

.logo-red {
    color: #E53935;
}
        .back-btn {
            border: 1px solid #ddd;
            background: #fff;
            border-radius: 11px;
            padding: 10px 18px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            color: #222;
        }

        .back-btn:hover {
            background: #f7f7f7;
        }

        /* =========================
           PAGE
           ========================= */

        .page {
            padding: 28px 0 80px;
        }

        .page-title {
            font: 700 34px Georgia, serif;
            margin: 0 0 5px;
        }

        .subtitle {
            color: #777;
            margin: 0 0 22px;
        }

        /* =========================
           MAIN LAYOUT
           ========================= */

        .layout {
            display: grid;
            grid-template-columns: 1.55fr .9fr;
            gap: 20px;
            align-items: start;
        }

        /* =========================
           CARD
           ========================= */

        .card {
            border: 1px solid #e5e5e5;
            border-radius: 14px;
            background: #fff;
            overflow: hidden;
            margin-bottom: 14px;
        }

        /* =========================
           CARD TITLE
           ========================= */

        .card-title {
            font-size: 20px;
            font-weight: 700;
            margin: 0 0 18px;
        }

        /* =========================
           ORDER SUMMARY
           ========================= */

        .order-summary {
            padding: 20px;
        }

        .order-item {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .food-image {
            width: 64px;
            height: 64px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #eee;
            background: #f5f5f5;
        }

        .food-info {
            flex: 1;
        }

        .food-name {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 3px;
        }

        .restaurant-name {
            color: #777;
            font-size: 14px;
            margin-bottom: 6px;
        }

        .food-quantity {
            color: #777;
            font-size: 14px;
        }

        .food-price {
            font-size: 15px;
            font-weight: 700;
            white-space: nowrap;
        }

        /* =========================
           DELIVERY DETAILS
           ========================= */

        .delivery-card {
            padding: 20px;
        }

        .delivery-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .delivery-header h2 {
            margin: 0;
            font-size: 20px;
        }

        .edit-btn {
            border: 1px solid #ddd;
            background: #fff;
            border-radius: 10px;
            padding: 9px 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .edit-btn:hover {
            background: #f7f7f7;
        }

        .field {
            margin-bottom: 13px;
        }

        .field label {
            display: block;
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .field input,
        .field textarea {
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 9px;
            padding: 11px 13px;
            font-size: 14px;
            font-family: Arial, sans-serif;
            background: #f7f8f9;
            color: #555;
            outline: none;
        }

        .field textarea {
            min-height: 70px;
            resize: vertical;
        }

        .field input:disabled,
        .field textarea:disabled {
            cursor: default;
        }

        .save-btn {
            width: 100%;
            border: 0;
            background: #e72d23;
            color: #fff;
            border-radius: 9px;
            padding: 13px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 3px;
        }

        .save-btn:hover {
            background: #c9251d;
        }

        /* =========================
           PAYMENT METHOD
           ========================= */

        .payment-card {
            padding: 20px;
        }

        .payment-card h2 {
            margin: 0 0 16px;
            font-size: 20px;
        }

        .payment-options {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }

        .payment-option {
            position: relative;
        }

        .payment-option input {
            position: absolute;
            opacity: 0;
        }

        .payment-label {
            display: block;
            border: 1px solid #ddd;
            border-radius: 9px;
            padding: 13px 10px;
            cursor: pointer;
            min-height: 68px;
        }

        .payment-label:hover {
            border-color: #aaa;
        }

        .payment-option input:checked + .payment-label {
            border: 2px solid #e72d23;
            padding: 12px 9px;
        }

        .payment-title {
            font-weight: 700;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .payment-description {
            color: #777;
            font-size: 12px;
        }

        /* =========================
           BILL DETAILS
           ========================= */

        .bill {
            padding: 20px;
            position: sticky;
            top: 20px;
        }

        .bill h2 {
            font-size: 21px;
            margin: 0 0 20px;
        }

        .bill-row {
            display: flex;
            justify-content: space-between;
            margin: 14px 0;
            color: #555;
            font-size: 15px;
        }

        .bill-row.total {
            border-top: 1px solid #eee;
            padding-top: 18px;
            margin-top: 18px;
            color: #222;
            font-size: 19px;
            font-weight: 700;
        }

        .place-order {
            width: 100%;
            border: 0;
            background: #e72d23;
            color: #fff;
            border-radius: 10px;
            padding: 14px;
            margin-top: 18px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
        }

        .place-order:hover {
            background: #c9251d;
        }

        .secure-payment {
            text-align: center;
            color: #777;
            font-size: 13px;
            margin-top: 14px;
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media(max-width: 850px) {

            .layout {
                grid-template-columns: 1fr;
            }

            .bill {
                position: static;
            }

            .payment-options {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media(max-width: 500px) {

            .payment-options {
                grid-template-columns: 1fr;
            }

            .page-title {
                font-size: 29px;
            }

            .food-image {
                width: 55px;
                height: 55px;
            }
        }
     /* ================= DELIVERY ADDRESS ================= */

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 8px;
}

/* Address clickable box */
.location-input {
    width: 100%;
    min-height: 64px;

    border: 1px solid #dddddd;
    border-radius: 12px;

    padding: 14px 16px;

    display: flex;
    align-items: center;
    justify-content: space-between;

    background: #ffffff;
    cursor: pointer;

    font-size: 16px;
    line-height: 1.45;

    transition: border-color 0.2s ease,
                box-shadow 0.2s ease;
}

.location-input:hover {
    border-color: #ef2b23;
}

.location-input > div {
    flex: 1;
    color: #222222;
    font-size: 16px;
    font-weight: 500;
    padding-right: 20px;
}

.change-location {
    color: #ef2b23;
    font-size: 16px;
    font-weight: 700;
    white-space: nowrap;
    cursor: pointer;
}


/* ================= PIN CODE ================= */

#pincodeInput {
    width: 180px;
    height: 46px;

    padding: 10px 12px;

    border: 1px solid #dddddd;
    border-radius: 8px;

    font-size: 16px;
    color: #222222;

    outline: none;
}

#pincodeInput:focus {
    border-color: #ef2b23;
}


/* ================= DELIVERY INSTRUCTION ================= */

textarea[name="instruction"] {
    width: 100%;
    min-height: 110px;

    padding: 14px 16px;

    border: 1px solid #dddddd;
    border-radius: 12px;

    font-family: Arial, sans-serif;
    font-size: 16px;

    resize: vertical;
    outline: none;
}

textarea[name="instruction"]:focus {
    border-color: #ef2b23;
}
.delivery-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.edit-btn {
    border: none;
    background: transparent;
    color: #ef2b23;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    padding: 5px 10px;
}

.edit-btn:hover {
    text-decoration: underline;
}

    </style>

</head>

<body>

<!-- =========================
     HEADER
     ========================= -->

<header>

    <div class="container header-inner">

         <div class="logo">
    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>

        <a href="<%= contextPath %>/cart"
           class="back-btn">
            ← Back to Cart
        </a>

    </div>

</header>


<!-- =========================
     PAGE
     ========================= -->

<main class="container page">

    <h1 class="page-title">
        Checkout
    </h1>

    <p class="subtitle">
        Complete your delivery details and place your order.
    </p>


    <div class="layout">


        <!-- =====================================
             LEFT SIDE
             ===================================== -->

        <div>
<!-- =================================
     ORDER SUMMARY
     ================================= -->

<section class="card order-summary">

    <h2 class="card-title">
        Order Summary
    </h2>

    <%
        if (cartItems != null && !cartItems.isEmpty()) {

            for (CartItem item : cartItems) {

                String itemName = "Menu Item";
                String photo = "";

                for (Menu menu : menuList) {

                    if (menu.getMenuId() == item.getMenuId()) {

                        itemName = menu.getItemName();

                        // Get the same photo stored for the menu item
                        photo = menu.getPhoto();

                        break;
                    }
                }
    %>

    <div class="order-item">

        <!-- FOOD IMAGE -->

        <%
            if (photo != null && !photo.trim().isEmpty()) {
        %>

            <img src="<%= contextPath + "/" + photo %>"
                 class="food-image"
                 alt="<%= itemName %>">

        <%
            } else {
        %>

            <div class="food-image"
                 style="
                    display:flex;
                    align-items:center;
                    justify-content:center;
                    font-size:25px;
                 ">
                🍽️
            </div>

        <%
            }
        %>


        <!-- FOOD DETAILS -->

        <div class="food-info">

            <div class="food-name">
                <%= itemName %>
            </div>

            <div class="restaurant-name">

                <%
                    if (restaurant != null) {
                %>

                    <%= restaurant.getName() %>

                <%
                    } else {
                %>

                    Restaurant

                <%
                    }
                %>

            </div>

            <div class="food-quantity">

                <%= item.getQuantity() %>
                x
                ₹<%= String.format("%.0f", item.getPrice()) %>

            </div>

        </div>


        <!-- ITEM TOTAL -->

        <div class="food-price">

            ₹<%= String.format(
                    "%.0f",
                    item.getPrice() * item.getQuantity()
            ) %>

        </div>

    </div>

    <%
            }
        }
    %>

</section>



            <!-- =================================
                 DELIVERY DETAILS
                 ================================= -->

            <section class="card delivery-card">

                <div class="delivery-header">

                    <h2>
                        Delivery Details
                    </h2>

                    <button type="button"
        class="edit-btn"
        id="editBtn"
        onclick="toggleEdit()">
    ✎ Edit
</button>

                </div>


                <!-- SAVE ADDRESS FORM -->

                <form action="<%= contextPath %>/checkout"
                      method="post"
                      id="addressForm">


                    <!-- FULL NAME -->

                    <div class="field">

                        <label>
                            Full Name
                        </label>

                       <input type="text"
       id="userName"
       name="userName"
       value="<%= user != null && user.getUserName() != null
              ? user.getUserName() : "" %>"
       readonly
       required>
                    </div>


                    <!-- PHONE -->

                    <div class="field">

                        <label>
                            Phone Number
                        </label>

                        <input type="text"
                               id="phone"
                               name="phone"
                               value="<%= user != null && user.getPhone() != null
                                      ? user.getPhone() : "" %>"
                               disabled
                               required>

                    </div>


                    <!-- ADDRESS -->

                  <div class="form-group">

    <label>Delivery Address</label>

    <div class="location-input"
         onclick="window.location.href='<%=request.getContextPath()%>/location'">

        <div>
            <%= request.getAttribute("displayAddress") != null
                    && !request.getAttribute("displayAddress").toString().trim().isEmpty()
                ? request.getAttribute("displayAddress")
                : "Select delivery location" %>
        </div>

        <span class="change-location">Change</span>

    </div>

    <!-- Sends selected address when Save Address is clicked -->
    <input type="hidden"
           name="address"
           id="addressInput"
           value="<%= request.getAttribute("displayAddress") != null
                    ? request.getAttribute("displayAddress")
                    : "" %>">

</div>


                    <!-- PINCODE -->

                 <div class="form-group">

    <label>PIN Code</label>

    <input type="text"
           name="pincode"
           id="pincodeInput"
           value="<%= request.getAttribute("displayPincode") != null
                    ? request.getAttribute("displayPincode")
                    : "" %>"
           placeholder="PIN Code"
           maxlength="6">

</div>


                    <!-- INSTRUCTION -->

                    <div class="field">

                        <label>
                            Delivery Instructions
                            <span style="color:#888;font-weight:400;">
                                (Optional)
                            </span>
                        </label>

            <textarea id="instruction"
          name="instruction"
          placeholder="Example: Please call when you arrive."><%= user != null && user.getInstruction() != null
              ? user.getInstruction() : "" %></textarea>


                    <!-- SAVE BUTTON -->

                    <button type="submit"
                            class="save-btn"
                            id="saveAddressBtn">
                            

                        Save Address

                    </button>

                </form>

            </section>



            <!-- =================================
                 PAYMENT METHOD
                 ================================= -->

            <section class="card payment-card">

                <h2>
                    Payment Method
                </h2>


                <div class="payment-options">


                    <!-- UPI -->

                    <div class="payment-option">

                      <input type="radio"
       id="upi"
       name="paymentMethod"
       value="UPI"
       form="placeOrderForm"
       checked>

                        <label for="upi"
                               class="payment-label">

                            <div class="payment-title">
                                🔴 UPI
                            </div>

                            <div class="payment-description">
                                PhonePe, GPay, Paytm
                            </div>

                        </label>

                    </div>


                    <!-- CARD -->

                    <div class="payment-option">

                      <input type="radio"
       id="card"
       name="paymentMethod"
       value="CARD"
       form="placeOrderForm">

                        <label for="card"
                               class="payment-label">

                            <div class="payment-title">
                                ◯ Card
                            </div>

                            <div class="payment-description">
                                Credit / Debit Card
                            </div>

                        </label>

                    </div>


                    <!-- NET BANKING -->

                    <div class="payment-option">

                       <input type="radio"
       id="netbanking"
       name="paymentMethod"
       value="NET_BANKING"
       form="placeOrderForm">

                        <label for="netbanking"
                               class="payment-label">

                            <div class="payment-title">
                                ◯ Net Banking
                            </div>

                            <div class="payment-description">
                                All major banks
                            </div>

                        </label>

                    </div>


                    <!-- CASH -->

                    <div class="payment-option">

                       <input type="radio"
       id="cod"
       name="paymentMethod"
       value="COD"
       form="placeOrderForm">

                        <label for="cod"
                               class="payment-label">

                            <div class="payment-title">
                                ◯ Cash on Delivery
                            </div>

                            <div class="payment-description">
                                Pay at your doorstep
                            </div>

                        </label>

                    </div>


                </div>

            </section>

        </div>



        <!-- =====================================
             RIGHT SIDE - BILL
             ===================================== -->

        <aside class="card bill">

            <h2>
                Bill Details
            </h2>


            <!-- ITEM TOTAL -->

            <div class="bill-row">

                <span>
                    Item Total
                </span>

                <span>
                    ₹<%= String.format("%.0f", itemTotal) %>
                </span>

            </div>


            <!-- DELIVERY FEE -->

            <div class="bill-row">

                <span>
                    Delivery Fee
                </span>

                <span>
                    ₹<%= String.format("%.0f", deliveryFee) %>
                </span>

            </div>


            <!-- DISCOUNT -->

            <%
                if (discount > 0) {
            %>

            <div class="bill-row">

                <span>
                    Discount
                </span>

                <span>
                    -₹<%= String.format("%.0f", discount) %>
                </span>

            </div>

            <%
                }
            %>


            <!-- TOTAL -->

            <div class="bill-row total">

                <span>
                    To Pay
                </span>

                <span>
                    ₹<%= String.format("%.0f", toPay) %>
                </span>

            </div>


            <!-- PLACE ORDER -->

           <form id="placeOrderForm"
      action="<%= contextPath %>/placeOrder"
      method="post">
                <button type="submit"
                        class="place-order">

                    Place Order ·
                    ₹<%= String.format("%.0f", toPay) %>

                </button>

            </form>


            <div class="secure-payment">

                🔒 Secure and safe payment

            </div>

        </aside>

    </div>

</main>


 <!-- <script>

   function enableEditing() {

        document.getElementById("userName").disabled = false;

        document.getElementById("phone").disabled = false;

        document.getElementById("address").disabled = false;

        document.getElementById("pincode").disabled = false;

        document.getElementById("instruction").disabled = false;

        document.getElementById("saveAddressBtn").style.display = "block";

    }

</script>-->
<script>
function toggleEdit() {
    const name = document.getElementById("userName");
    const phone = document.getElementById("phone");
    const pin = document.getElementById("pincodeInput");
    const editBtn = document.getElementById("editBtn");
    const editing = name.hasAttribute("readonly");

    if (editing) {
        name.removeAttribute("readonly");
        phone.removeAttribute("readonly");
        pin.removeAttribute("readonly");
        editBtn.innerText = "Done";
        name.focus();
    } else {
        name.setAttribute("readonly", true);
        phone.setAttribute("readonly", true);
        pin.setAttribute("readonly", true);
        editBtn.innerText = "Edit";
    }
}
</script>




</body>
</html>