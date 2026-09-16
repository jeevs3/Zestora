<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.Food.Model.Cart" %>
<%@ page import="com.Food.Model.CartItem" %>
<%@ page import="com.Food.Model.Menu" %>
<%@ page import="com.Food.Model.Restaurant" %>
<%@ page import="com.Food.daoimp.RestaurantDAOImpl" %>

<%
    String contextPath = request.getContextPath();

    Cart cart = (Cart) request.getAttribute("cart");

    List<CartItem> cartItems =
            (List<CartItem>) request.getAttribute("cartItems");

    Restaurant restaurant =
            (Restaurant) request.getAttribute("restaurant");

    List<Menu> menuList =
            (List<Menu>) request.getAttribute("menuList");

    if (cartItems == null) {
        cartItems = new ArrayList<CartItem>();
    }

    if (menuList == null) {
        menuList = new ArrayList<Menu>();
    }

    double subtotal = 0;
    int totalQuantity = 0;

    for (CartItem item : cartItems) {
        subtotal += item.getPrice() * item.getQuantity();
        totalQuantity += item.getQuantity();
    }

    double deliveryFee = subtotal >= 199 ? 0 : 40;
    double discount = subtotal >= 599 ? 100 : 0;
    double total = subtotal + deliveryFee - discount;

    if (total < 0) {
        total = 0;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Zestora - Cart</title>

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

/* ==============================
   CONTAINER
   ============================== */

.container {
    width: min(1100px, 92%);
    margin: auto;
}

/* ==============================
   HEADER
   ============================== */

header {
    border-bottom: 1px solid #eee;
    background: #fff;
}

.header-inner {
    min-height: 80px;

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

    border-radius: 12px;

    padding: 11px 18px;

    font-weight: 600;

    cursor: pointer;

    text-decoration: none;

    color: #222;
}

/* ==============================
   PAGE
   ============================== */

.page {
    padding: 35px 0 100px;
}

.page-title {
    font: 700 34px Georgia, serif;

    margin: 0 0 8px;
}

.subtitle {
    color: #777;

    margin-bottom: 25px;
}

/* ==============================
   LAYOUT
   ============================== */

.layout {
    display: grid;

    grid-template-columns: 1.55fr .9fr;

    gap: 25px;

    align-items: start;
}

/* ==============================
   CARD
   ============================== */

.card {
    border: 1px solid #e8e1d9;

    border-radius: 16px;

    background: #fff;

    overflow: hidden;
}

/* ==============================
   RESTAURANT HEADER
   ============================== */

.restaurant-header {
    padding: 20px;

    border-bottom: 1px solid #eee;
}

.restaurant-name {
    font-size: 20px;

    font-weight: 700;
}

.restaurant-note {
    color: #777;

    font-size: 14px;

    margin-top: 5px;
}

/* ==============================
   CART ITEM
   ============================== */

.cart-item {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 20px;
    padding: 22px 20px;
    border-bottom: 1px solid #eee;
    align-items: end;
}
.item-name {
    font-size: 17px;

    font-weight: 700;

    margin-bottom: 7px;
}

.item-id {
    color: #999;

    font-size: 12px;

    margin-bottom: 8px;
}

.item-price {
    font-weight: 700;
}

/* ==============================
   RIGHT SIDE
   ============================== */

.item-right {
    text-align: right;

    min-width: 130px;
}

/* ==============================
   PLUS MINUS
   ============================== */

.stepper {
    display: inline-flex;

    align-items: center;

    border: 1px solid #d7d7d7;

    border-radius: 9px;

    overflow: hidden;

    margin-bottom: 9px;

    background: #fff;
}

/*
   IMPORTANT:
   These buttons are inside forms.
   They submit POST requests to /cart.
*/

.stepper button {
    width: 34px;

    height: 32px;

    border: 0;

    background: #fff;

    cursor: pointer;

    font-size: 18px;

    font-weight: 700;
}

.stepper button:hover {
    background: #f5f5f5;
}

.quantity {
    width: 32px;

    text-align: center;

    font-weight: 700;
}

.item-total {
    font-weight: 700;
}

/* ==============================
   BILL
   ============================== */

.bill {
    padding: 22px;

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
}

.bill-row.total {
    border-top: 1px solid #eee;

    padding-top: 18px;

    color: #222;

    font-size: 19px;

    font-weight: 700;
}

/* ==============================
   CHECKOUT
   ============================== */

.checkout {
    width: 100%;

    border: 0;

    background: #e72d23;

    color: #fff;

    border-radius: 11px;

    padding: 15px;

    margin-top: 18px;

    font-size: 17px;

    font-weight: 700;

    cursor: pointer;
}

.checkout:hover {
    background: #c9251d;
}

/* ==============================
   EMPTY CART
   ============================== */

.empty {
    text-align: center;

    padding: 70px 20px;

    border: 1px dashed #ddd;

    border-radius: 16px;
}

.empty-icon {
    font-size: 48px;
}

.empty h2 {
    font: 700 25px Georgia, serif;
}

.empty p {
    color: #777;

    margin-bottom: 22px;
}

.browse-btn {
    display: inline-block;

    background: #e72d23;

    color: #fff;

    text-decoration: none;

    padding: 13px 22px;

    border-radius: 10px;

    font-weight: 700;
}

/* ==============================
   RESPONSIVE
   ============================== */

@media(max-width: 800px) {

    .layout {
        grid-template-columns: 1fr;
    }

    .bill {
        position: static;
    }

}
.add-more-container {
    margin-top: 12px;
}

.add-more-btn {
    display: inline-block;
    margin-top: 10px;
    padding: 11px 17px;
    border: 1px solid #198754;
    border-radius: 10px;
    text-decoration: none;
    color: #198754;
    font-weight: 700;
    background: #fff;
}

.add-more-btn:hover {
    background: #f7f7f7;
}
.quantity-row {
    display: inline-flex;
    align-items: center;
    gap: 0;
}

.quantity-row form {
    margin: 0;
}

.quantity-row button {
    width: 34px;
    height: 34px;
    border: 1px solid #d7d7d7;
    background: #fff;
    cursor: pointer;
    font-size: 18px;
    font-weight: 700;
}

.quantity-row form:first-child button {
    border-radius: 9px 0 0 9px;
}

.quantity-row form:last-child button {
    border-radius: 0 9px 9px 0;
}

.quantity {
    width: 38px;
    height: 34px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-top: 1px solid #d7d7d7;
    border-bottom: 1px solid #d7d7d7;
    font-weight: 700;
}

.item-total {
    margin-top: 9px;
    font-weight: 700;
}
</style>

</head>

<body>


<!-- =========================================================
     HEADER
     ========================================================= -->

<header>

    <div class="container header-inner">

        <div class="logo">
    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>

        <a href="<%= contextPath %>/restaurant"
           class="back-btn">

            ← Back

        </a>

    </div>

</header>

<%
    String restaurantChange =
            request.getParameter("restaurantChange");

    if ("true".equals(restaurantChange)) {

        Integer pendingRestaurantId =
                (Integer) session.getAttribute("pendingRestaurantId");

        Restaurant pendingRestaurant = null;

        if (pendingRestaurantId != null) {

            RestaurantDAOImpl pendingRestaurantDAO =
                    new RestaurantDAOImpl();

            pendingRestaurant =
                    pendingRestaurantDAO.getRestaurant(
                            pendingRestaurantId
                    );
        }
%>

<div class="restaurant-change-box">

    <h3>Switch Restaurant?</h3>

    <p>
        Your cart contains items from
        <strong>
            <%= restaurant != null
                    ? restaurant.getName()
                    : "another restaurant" %>
        </strong>.
    </p>

    <p>
        You can only order from one restaurant at a time.
        Do you want to remove the current items and add from
        <strong>
            <%= pendingRestaurant != null
                    ? pendingRestaurant.getName()
                    : "the selected restaurant" %>
        </strong>?
    </p>

    <div class="switch-buttons">

        <button
            type="button"
            onclick="closeRestaurantChange()">
            Cancel
        </button>

        <form action="<%= request.getContextPath() %>/switchRestaurant"
              method="post">

            <button type="submit">
                Switch Restaurant
            </button>

        </form>

    </div>

</div>

<%
    }
%>


<!-- =========================================================
     MAIN
     ========================================================= -->

<main class="container page">

    <h1 class="page-title">
        Your Cart
    </h1>


<%
    /*
     * ========================================================
     * EMPTY CART
     * ========================================================
     */

    if (cartItems.isEmpty()) {
%>

    <div class="empty">

        <div class="empty-icon">
            🛒
        </div>

        <h2>
            Your cart is empty
        </h2>

        <p>
            Add some delicious food from a restaurant to continue.
        </p>

        <a href="<%= contextPath %>/restaurant"
           class="browse-btn">

            Browse Restaurants

        </a>

    </div>

<%
    } else {
%>


    <!-- =====================================================
         CART + BILL
         ===================================================== -->

    <div class="layout">


        <!-- =================================================
             LEFT CART
             ================================================= -->

        <section class="card">


            <!-- RESTAURANT HEADER -->

            <div class="restaurant-header">

                <div class="restaurant-name">
<% if (restaurant != null) { %>

    <div class="restaurant-name">
        <%= restaurant.getName() %>
    </div>

<% } else { %>

    <div class="restaurant-name">
        Restaurant
    </div>

<% } %>

                </div>

                <div class="restaurant-note">

                    <%= totalQuantity %>
                    <%= totalQuantity == 1 ? "item" : "items" %>
                    in your cart

                </div>

            </div>


            <!-- =================================================
                 CART ITEMS
                 ================================================= -->


 <%
for (CartItem item : cartItems) {
%>

<div class="cart-item">

    <!-- LEFT SIDE -->
    <div>

        <div class="item-name">

            <%
                String itemName = "Menu Item";

                for (Menu menu : menuList) {

                    if (menu.getMenuId() == item.getMenuId()) {

                        itemName = menu.getItemName();

                        break;
                    }
                }
            %>

            <%= itemName %>

        </div>

        <!-- ADD MORE ITEMS -->
      <div class="add-more-container">



    <a href="<%= contextPath %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"



       class="add-more-btn">



        + Add more items



    </a>



</div>

    </div>


    <!-- RIGHT SIDE -->
    <div class="item-right">

        <!-- QUANTITY -->
        <div class="quantity-row">

            <!-- MINUS -->
            <form action="<%=contextPath%>/cart"
                  method="post">

                <input type="hidden"
                       name="cartItemId"
                       value="<%=item.getCartItemId()%>">

                <input type="hidden"
                       name="action"
                       value="minus">

                <button type="submit">−</button>

            </form>


            <!-- QUANTITY -->
            <span class="quantity">
                <%=item.getQuantity()%>
            </span>


            <!-- PLUS -->
            <form action="<%=contextPath%>/cart"
                  method="post">

                <input type="hidden"
                       name="cartItemId"
                       value="<%=item.getCartItemId()%>">

                <input type="hidden"
                       name="action"
                       value="plus">

                <button type="submit">+</button>

            </form>

        </div>


        <!-- ITEM TOTAL -->
        <div class="item-total">

            ₹<%=String.format(
                    "%.0f",
                    item.getPrice() * item.getQuantity()
            )%>

        </div>

    </div>

</div>

<%
}
%>


        </section>


        <!-- =================================================
             BILL DETAILS
             ================================================= -->

        <aside class="card bill">

            <h2>
                Bill Details
            </h2>


            <div class="bill-row">

                <span>
                    Item Total
                </span>

                <span>
                    ₹<%= String.format("%.0f", subtotal) %>
                </span>

            </div>


            <div class="bill-row">

                <span>
                    Delivery Fee
                </span>

                <span>

<%
                if (deliveryFee == 0) {
%>
                    FREE
<%
                } else {
%>
                    ₹<%= String.format("%.0f", deliveryFee) %>
<%
                }
%>

                </span>

            </div>


            <div class="bill-row">

                <span>
                    Discount
                </span>

                <span>

<%
                if (discount > 0) {
%>

                    -₹<%= String.format("%.0f", discount) %>

<%
                } else {
%>

                    ₹0

<%
                }
%>

                </span>

            </div>


            <div class="bill-row total">

                <span>
                    To Pay
                </span>

                <span>
                    ₹<%= String.format("%.0f", total) %>
                </span>

            </div>


            <button class="checkout"
                    type="button"
                    onclick="goToCheckout()">

                Proceed to Checkout

            </button>

        </aside>


    </div>


<%
    }
%>

</main>


<script>

function goToCheckout() {

    window.location.href =
        "<%= contextPath %>/checkout";

}

function closeRestaurantChange() {
    const url = new URL(window.location.href);

    url.searchParams.delete("restaurantChange");

    window.history.replaceState({}, "", url);
    
    const box =
        document.querySelector(".restaurant-change-box");

    if (box) {
        box.remove();
    }
}

</script>


</body>

</html>