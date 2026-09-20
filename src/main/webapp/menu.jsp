<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.Food.Model.Menu" %>
<%@ page import="com.Food.Model.Restaurant" %>
<%@ page import="com.Food.Model.Cart" %>
<%@ page import="com.Food.Model.CartItem" %>
<%@ page import="com.Food.daoimp.CartDAOImpl" %>
<%@ page import="com.Food.daoimp.CartItemDAOImpl" %>

<%

String contextPath = request.getContextPath();
    Restaurant restaurant =
        (Restaurant) request.getAttribute("restaurant");

    List<Menu> allMenuByRestaurant =
        (List<Menu>) request.getAttribute("allMenuByRestaurant");

    if (allMenuByRestaurant == null) {
        allMenuByRestaurant = new ArrayList<Menu>();
    }

    String restaurantId = request.getParameter("restaurantId");

    if (restaurantId == null && !allMenuByRestaurant.isEmpty()) {
        restaurantId =
            String.valueOf(
                allMenuByRestaurant.get(0).getRestaurantId()
            );
    }

    /*
     * =========================================================
     * CART DATA FROM DATABASE
     * =========================================================
     */

    Integer loggedUserId =
        (Integer) session.getAttribute("userId");

    Cart userCart = null;
    List<CartItem> cartItems =
        new ArrayList<CartItem>();

    int cartCount = 0;
    double cartTotal = 0;

    if (loggedUserId != null) {

        CartDAOImpl cartDAO =
            new CartDAOImpl();

        userCart =
            cartDAO.getCartByUserId(loggedUserId);

        if (userCart != null) {

            CartItemDAOImpl cartItemDAO =
                new CartItemDAOImpl();

            cartItems =
                cartItemDAO.getCartItems(
                    userCart.getCartId()
                );

            for (CartItem ci : cartItems) {

                cartCount += ci.getQuantity();

                cartTotal +=
                    ci.getPrice() * ci.getQuantity();
            }
        }
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Zestora - Menu</title>

<style>

/* =========================================================
   RESET
========================================================= */

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #ffffff;
    color: #211810;
}

button {
    font-family: inherit;
}


/* =========================================================
   HEADER
========================================================= */

.header {
    position: sticky;
    top: 0;
    z-index: 100;
    background: #ffffff;
    border-bottom: 1px solid #eee5dc;
}

.header-row {
    max-width: 1200px;
    margin: auto;
    padding: 13px 24px;

    display: flex;
    align-items: center;
    gap: 12px;
}

.logo {
    font-family: Georgia, serif;
    font-size: 30px;
    font-weight: 800;
}

.logo-black {
    color: #111111;
}

.logo-red {
    color: #E53935;
}

.back-btn,
.cart-btn,
.menu-btn {
    height: 45px;

    background: #ffffff;

    border: 1px solid #e2d9d0;

    border-radius: 13px;

    cursor: pointer;
}

.back-btn {
    padding: 0 15px;
    font-weight: 600;
}

.cart-btn {
    margin-left: auto;
    padding: 0 16px;

    position: relative;

    font-weight: 700;
}

.menu-btn {
    width: 46px;

    font-size: 23px;

    padding: 0;
}

.cart-badge {
    position: absolute;

    top: -7px;
    right: -7px;

    min-width: 20px;
    height: 20px;

    padding: 0 5px;

    border-radius: 50%;

    background: #d62b25;
    color: #ffffff;

    font-size: 11px;

    display: flex;
    align-items: center;
    justify-content: center;
}


/* =========================================================
   SEARCH
========================================================= */

.search-wrapper {
    max-width: 1200px;
    margin: auto;

    padding: 8px 24px 14px;
}

.search-box {
    height: 48px;

    border: 1px solid #ddd4ca;

    border-radius: 25px;

    background: #faf8f5;

    display: flex;
    align-items: center;

    padding: 0 16px;

    gap: 9px;
}

.search-box input {
    width: 100%;

    border: none;
    outline: none;

    background: transparent;

    font-size: 15px;
}


/* =========================================================
   DRAWER
========================================================= */

.drawer-overlay {
    position: fixed;
    inset: 0;

    background: rgba(0,0,0,0.45);

    z-index: 200;

    opacity: 0;
    visibility: hidden;

    transition: 0.25s;
}

.drawer-overlay.open {
    opacity: 1;
    visibility: visible;
}

.drawer {
    position: fixed;

    right: -360px;
    top: 0;

    width: 340px;
    max-width: 88vw;

    height: 100vh;

    background: #ffffff;

    z-index: 201;

    padding: 28px 24px;

    box-shadow:
        -8px 0 30px rgba(0,0,0,0.15);

    transition: right 0.3s ease;
}

.drawer.open {
    right: 0;
}

.drawer h2 {
    margin: 0 0 25px;

    font-family: Georgia, serif;

    font-size: 28px;
}

.drawer-close {
    position: absolute;

    right: 18px;
    top: 15px;

    border: none;

    background: transparent;

    font-size: 28px;

    cursor: pointer;
}

.drawer-item {
    width: 100%;

    text-align: left;

    border: none;

    border-bottom:
        1px solid #eee5dc;

    background: #ffffff;

    padding: 17px 5px;

    font-size: 15px;

    font-weight: 600;

    cursor: pointer;
}

.drawer-item:hover {
    background: #faf6f1;
}


/* =========================================================
   RESTAURANT DETAILS
========================================================= */

.restaurant-header {
    max-width: 1200px;
    margin: auto;

    padding: 22px 24px 12px;
}

.restaurant-name {
    margin: 0 0 7px;

    font-family: Georgia, serif;

    font-size: 34px;

    font-weight: 700;
}

.restaurant-location {
    color: #75695e;

    font-size: 14px;
}

.restaurant-meta {
    margin-top: 12px;

    display: flex;

    gap: 9px;

    flex-wrap: wrap;
}

.restaurant-meta span {
    padding: 7px 11px;

    background: #f7f3ee;

    border-radius: 8px;

    font-size: 12px;

    font-weight: 600;
}


/* =========================================================
   CATEGORY NAVIGATION
========================================================= */

.category-nav {
    max-width: 1200px;

    margin: auto;

    padding: 3px 24px 15px;

    display: flex;

    gap: 25px;

    overflow-x: auto;

    border-bottom:
        1px solid #eee5dc;
}

.category-link {
    flex-shrink: 0;

    border: none;

    background: transparent;

    padding: 9px 2px;

    font-size: 14px;

    font-weight: 700;

    color: #62584f;

    cursor: pointer;

    border-bottom:
        3px solid transparent;
}

.category-link:hover,
.category-link.active {
    color: #211810;

    border-bottom-color:
        #d62b25;
}


/* =========================================================
   FILTER
========================================================= */

.filter-row {
    max-width: 1200px;

    margin: auto;

    padding: 15px 24px;

    display: flex;

    justify-content: flex-end;

    position: relative;
}

.filter-button {
    border:
        1px solid #d9d0c6;

    background: #ffffff;

    border-radius: 9px;

    padding: 10px 17px;

    font-weight: 700;

    cursor: pointer;
}

.filter-button:hover {
    background: #faf6f1;
}

.filter-panel {
    position: absolute;

    right: 24px;
    top: 62px;

    width: 285px;

    background: #ffffff;

    border:
        1px solid #e2d9d0;

    border-radius: 13px;

    box-shadow:
        0 10px 35px rgba(0,0,0,0.17);

    padding: 18px;

    z-index: 90;

    display: none;
}

.filter-panel.open {
    display: block;
}

.filter-title {
    margin: 0 0 15px;

    font-family: Georgia, serif;

    font-size: 20px;
}

.filter-heading {
    margin: 16px 0 8px;

    font-size: 13px;

    font-weight: 800;

    color: #75695e;
}

.filter-option {
    width: 100%;

    display: flex;

    align-items: center;

    gap: 9px;

    border: none;

    background: #ffffff;

    padding: 9px 5px;

    text-align: left;

    cursor: pointer;

    font-size: 14px;
}

.filter-option:hover {
    background: #faf6f1;
}

.filter-option input {
    accent-color: #d62b25;
}


/* =========================================================
   MENU
========================================================= */

.main {
    max-width: 1200px;

    margin: auto;

    padding: 5px 24px 110px;
}

.menu-section {
    margin-bottom: 32px;
}

.section-header {
    margin: 18px 0 13px;

    display: flex;

    align-items: center;

    justify-content: space-between;
}

.section-title {
    margin: 0;

    font-family: Georgia, serif;

    font-size: 25px;
}

.section-count {
    color: #81766d;

    font-size: 12px;
}


/* =========================================================
   MENU ITEM
========================================================= */

.menu-item {
    display: grid;

    grid-template-columns:
        1fr 220px 100px;

    align-items: center;

    gap: 28px;

    min-height: 165px;

    padding: 18px 20px;

    background: #ffffff;

    border:
        1px solid #e3ddd5;

    border-radius: 18px;

    margin-bottom: 16px;
}

.item-content {
    min-width: 0;
}

.item-name-row {
    display: flex;

    justify-content: space-between;

    gap: 10px;
}

.item-name {
    margin: 0 0 8px;

    font-size: 18px;
}

.item-description {
    margin: 0 0 9px;

    color: #75695e;

    font-size: 13px;

    line-height: 1.45;
}

.item-price {
    font-size: 15px;

    font-weight: 800;
}


/* =========================================================
   VEG / NON VEG
========================================================= */

.veg-icon {
    display: inline-flex;

    width: 15px;
    height: 15px;

    border:
        2px solid #3f8050;

    border-radius: 4px;

    align-items: center;

    justify-content: center;

    margin-right: 6px;
}

.veg-icon::after {
    content: "";

    width: 5px;
    height: 5px;

    border-radius: 50%;

    background: #3f8050;
}

.veg-icon.nonveg {
    border-color: #d62b25;
}

.veg-icon.nonveg::after {
    background: #d62b25;
}


/* =========================================================
   FOOD PHOTO
========================================================= */

.food-photo {
    width: 220px;

    height: 135px;

    object-fit: cover;

    border-radius: 12px;

    background: #eeeeee;

    display: block;
}


/* =========================================================
   FAVORITE
========================================================= */

.favorite-btn {
    border: none;

    background: transparent;

    color: #777;

    font-size: 23px;

    cursor: pointer;
}

.favorite-btn.active {
    color: #d62b25;
}


/* =========================================================
   ADD / QUANTITY
========================================================= */

.add-area {
    display: flex;

    justify-content: flex-end;

    align-items: center;
}

.add-form {
    margin: 0;
    padding: 0;
}

.add-btn {
    border:
        1px solid #4c7d57;

    background: #ffffff;

    color: #4c7d57;

    border-radius: 8px;

    padding: 9px 16px;

    font-weight: 800;

    cursor: pointer;

    min-width: 70px;
}

.add-btn:hover {
    background: #eaf3ec;
}


/* =========================================================
   QUANTITY CONTROL
========================================================= */

.quantity-box {
    display: inline-flex;

    align-items: center;

    border:
        1px solid #4c7d57;

    border-radius: 8px;

    overflow: hidden;

    background: #ffffff;
}

.quantity-btn {
    width: 32px;

    height: 34px;

    border: none;

    background: #ffffff;

    color: #4c7d57;

    font-size: 20px;

    font-weight: 700;

    cursor: pointer;
}

.quantity-btn:hover {
    background: #eaf3ec;
}

.quantity-number {
    min-width: 30px;

    text-align: center;

    font-size: 14px;

    font-weight: 800;

    color: #211810;
}


/* =========================================================
   EMPTY
========================================================= */

.empty {
    text-align: center;

    padding: 80px 20px;

    color: #75695e;
}


/* =========================================================
   CART BAR
========================================================= */

.bottom-cart {
    position: fixed;

    left: 50%;

    bottom: 17px;

    transform:
        translateX(-50%);

    width:
        min(1000px,
        calc(100% - 32px));

    background: #ffffff;

    border:
        1px solid #e2d9d0;

    box-shadow:
        0 8px 30px rgba(0,0,0,0.17);

    border-radius: 15px;

    padding: 12px 16px;

    display: flex;

    justify-content: space-between;

    align-items: center;

    z-index: 150;
}

.view-cart {
    border: none;

    background: #d62b25;

    color: #ffffff;

    border-radius: 9px;

    padding: 12px 22px;

    font-weight: 800;

    cursor: pointer;
}


/* =========================================================
   MOBILE
========================================================= */

@media(max-width:700px) {

    .header-row {
        padding: 11px 15px;
    }

    .logo {
        font-size: 24px;
    }

    .restaurant-header {
        padding-left: 16px;
        padding-right: 16px;
    }

    .restaurant-name {
        font-size: 28px;
    }

    .category-nav,
    .filter-row,
    .main {
        padding-left: 16px;
        padding-right: 16px;
    }

    .filter-panel {
        right: 16px;
    }

    .menu-item {
        grid-template-columns:
            1fr 105px;

        gap: 10px;
    }

    .food-photo {
        width: 105px;

        height: 100px;

        grid-column: 2;

        grid-row: 1 / span 2;
    }

    .item-content {
        grid-column: 1;
    }

    .add-area {
        grid-column: 1;

        justify-content: flex-start;
    }

}


/* =========================================================
   SMALL MOBILE
========================================================= */

@media(max-width:450px) {

    .cart-btn {
        padding: 0 10px;
    }

    .back-btn {
        padding: 0 10px;
    }

    .menu-btn {
        width: 42px;
    }

    .menu-item {
        padding: 14px;
    }

    .food-photo {
        width: 95px;
        height: 90px;
    }


}

</style>

</head>


<body>


<!-- =====================================================
     HEADER
===================================================== -->

<header class="header">

    <div class="header-row">

        
   <div class="logo">
    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>


        <button class="back-btn"
                onclick="history.back()">

            ← Back

        </button>


        <button class="cart-btn"
                onclick="location.href='cart'">

            🛒 Cart

            <span class="cart-badge"
                  id="cartCount">

                <%= cartCount %>

            </span>

        </button>


        <button class="menu-btn"
                onclick="toggleDrawer()">

            ☰

        </button>

    </div>


    <!-- SEARCH -->

    <div class="search-wrapper">

        <div class="search-box">

            🔍

            <input type="text"
                   id="searchInput"
                   placeholder=
                   "Search dishes in this restaurant...">

        </div>

    </div>

</header>



<!-- =====================================================
     DRAWER
===================================================== -->

<div class="drawer-overlay"
     id="drawerOverlay"
     onclick="closeDrawer()">
</div>


<aside class="drawer"
       id="drawer">

    <button class="drawer-close"
            onclick="closeDrawer()">

        ×

    </button>


    <h2>Zestora</h2>


    <button class="drawer-item" onclick="location.href='<%= contextPath %>/account'">
        👤 Account
    </button>


    <button class="drawer-item" onclick="location.href='<%= contextPath %>/orders'">
        📦 My Orders
    </button>


    <button class="drawer-item" onclick="location.href='<%= contextPath %>/favorites'">
        ❤️ Favorites
    </button>


    <button class="drawer-item" onclick="location.href='<%= contextPath %>/help.jsp'">
        ❓ Help & Support
    </button>

</aside>



<!-- =====================================================
     RESTAURANT
===================================================== -->

<section class="restaurant-header">

<%
    if (restaurant != null) {
%>

    <h1 class="restaurant-name">

        <%= restaurant.getName() %>

    </h1>


    <div class="restaurant-location">

        📍 <%= restaurant.getLocation() %>

    </div>


    <div class="restaurant-meta">

        <span>★ 4.2</span>

        <span>25–30 mins</span>

    </div>

<%
    }
%>

</section>



<!-- =====================================================
     CATEGORY NAVIGATION
===================================================== -->

<div class="category-nav">

    <button class="category-link active"
            onclick=
            "scrollToCategory('recommended', this)">

        ★ Recommended

    </button>


    <button class="category-link"
            onclick=
            "scrollToCategory('Starters', this)">

        Starters

    </button>


    <button class="category-link"
            onclick=
            "scrollToCategory('Main Course', this)">

        Main Course

    </button>


    <button class="category-link"
            onclick=
            "scrollToCategory('Desserts', this)">

        Desserts

    </button>

</div>



<!-- =====================================================
     FILTER
===================================================== -->

<div class="filter-row">

    <button class="filter-button"
            onclick="toggleFilter()">

        ☷ Filter

    </button>


    <div class="filter-panel"
         id="filterPanel">


        <h3 class="filter-title">

            Filters

        </h3>


        <!-- SORT -->

        <div class="filter-heading">

            SORT BY

        </div>


        <label class="filter-option">

            <input type="radio"
                   name="sortFilter"
                   value="reordered"
                   onchange="applyFilters()">

            Highly Reordered

        </label>



        <!-- FOOD TYPE -->

        <div class="filter-heading">

            FOOD TYPE

        </div>


        <label class="filter-option">

            <input type="radio"
                   name="foodFilter"
                   value="all"
                   checked
                   onchange="applyFilters()">

            All

        </label>


        <label class="filter-option">

            <input type="radio"
                   name="foodFilter"
                   value="veg"
                   onchange="applyFilters()">

            🟢 Veg

        </label>


        <label class="filter-option">

            <input type="radio"
                   name="foodFilter"
                   value="nonveg"
                   onchange="applyFilters()">

            🔴 Non-Veg

        </label>



        <!-- PRICE -->

        <div class="filter-heading">

            PRICE

        </div>


        <label class="filter-option">

            <input type="radio"
                   name="priceFilter"
                   value="all"
                   checked
                   onchange="applyFilters()">

            All Prices

        </label>


        <label class="filter-option">

            <input type="radio"
                   name="priceFilter"
                   value="0-100"
                   onchange="applyFilters()">

            ₹0 – ₹100

        </label>


        <label class="filter-option">

            <input type="radio"
                   name="priceFilter"
                   value="100-200"
                   onchange="applyFilters()">

            ₹100 – ₹200

        </label>


        <label class="filter-option">

            <input type="radio"
                   name="priceFilter"
                   value="200-300"
                   onchange="applyFilters()">

            ₹200 – ₹300

        </label>


        <label class="filter-option">

            <input type="radio"
                   name="priceFilter"
                   value="300plus"
                   onchange="applyFilters()">

            ₹300+

        </label>

    </div>

</div>



<!-- =====================================================
     MENU
===================================================== -->

<main class="main">

<%

if (allMenuByRestaurant.isEmpty()) {

%>

    <div class="empty">

        <h2>No dishes found</h2>

        <p>
            No menu items are available
            for this restaurant.
        </p>

    </div>

<%

} else {

    String currentCategory = null;

    for (Menu menu : allMenuByRestaurant) {

        String category =
            menu.getCategory();

        if (category == null ||
            category.trim().isEmpty()) {

            category = "Other";
        }


        if (!category.equals(currentCategory)) {

            if (currentCategory != null) {

%>

                </div>
                </section>

<%
            }

            currentCategory = category;
%>


            <section class="menu-section"
                     id="category-<%= category.replaceAll("[^a-zA-Z0-9]", "-") %>"
                     data-category="<%= category %>">


                <div class="section-header">

                    <h2 class="section-title">

                        <%= category %>

                    </h2>

                    <span class="section-count"></span>

                </div>


                <div class="category-items">

<%
        }


        /*
         * =====================================================
         * FIND QUANTITY OF THIS MENU ITEM IN DATABASE
         * =====================================================
         */

        int existingQuantity = 0;
        int existingCartItemId = 0;

        for (CartItem ci : cartItems) {

            if (ci.getMenuId() == menu.getMenuId()) {

                existingQuantity =
                    ci.getQuantity();

                existingCartItemId =
                    ci.getCartItemId();

                break;
            }
        }

%>


        <article class="menu-item"

                 data-name="<%= menu.getItemName() %>"

                 data-category="<%= category %>"

                 data-price="<%= menu.getPrice() %>"

                 data-veg="<%= menu.isVeg() %>"

                 data-menu-id="<%= menu.getMenuId() %>">


            <!-- ITEM CONTENT -->

            <div class="item-content">

                <div class="item-name-row">

                    <h3 class="item-name">

                        <span class="veg-icon
                            <%= menu.isVeg()
                                ? ""
                                : "nonveg" %>">
                        </span>

                        <%= menu.getItemName() %>

                    </h3>


                    <button class="favorite-btn"
                            type="button"
                            onclick="toggleFavorite(this)">

                        ♡

                    </button>

                </div>


                <p class="item-description">

<%
                    String description =
                        menu.getDescription();

                    if (description == null ||
                        description.trim().isEmpty()) {

                        description =
                            "Delicious food prepared fresh.";
                    }
%>

                    <%= description %>

                </p>


                <div class="item-price">

                    ₹<%= String.format(
                        "%.0f",
                        menu.getPrice()) %>

                </div>

            </div>



            <!-- PHOTO -->

            <img class="food-photo"

                 src="<%= menu.getPhoto() %>"

                 alt="<%= menu.getItemName() %>"

                 onerror=
                 "this.onerror=null;
                  this.src='images/default-food.jpg';">



            <!-- ADD / QUANTITY -->

            <div class="add-area">

<%
                if (existingQuantity <= 0) {
%>

                    <!-- ADD BUTTON -->

         <form action="<%= request.getContextPath() %>/addToCart"
      method="post"
      style="display:inline;">

    <input type="hidden"
           name="menuId"
           value="<%= menu.getMenuId() %>">

    <input type="hidden"
           name="restaurantId"
           value="<%= menu.getRestaurantId() %>">

    <input type="hidden"
           name="price"
           value="<%= menu.getPrice() %>">

    <input type="hidden"
           name="action"
           value="add">

    <button type="submit"
            class="add-btn">
        ADD
    </button>

</form>
<%
                } else {
%>

                    <!-- QUANTITY CONTROL -->

                    <div class="quantity-box">


                        <!-- MINUS -->

                       <form action="<%= request.getContextPath() %>/addToCart"
      method="post"
      style="display:inline;">

    <input type="hidden"
           name="menuId"
           value="<%= menu.getMenuId() %>">

    <input type="hidden"
           name="restaurantId"
           value="<%= menu.getRestaurantId() %>">

    <input type="hidden"
           name="price"
           value="<%= menu.getPrice() %>">

    <input type="hidden"
           name="action"
           value="minus">

    <button type="submit"
            class="quantity-btn">
        −
    </button>

</form>


                        <!-- NUMBER -->

                        <span class="quantity-number">

                            <%= existingQuantity %>

                        </span>


                        <!-- PLUS -->

                        <form action="${pageContext.request.contextPath}/updateCartItem"
                              method="post"
                              class="quantity-form">

                            <input type="hidden"
                                   name="cartItemId"
                                   value="<%= existingCartItemId %>">

                            <input type="hidden"
                                   name="quantity"
                                   value="<%= existingQuantity + 1 %>">

                            <input type="hidden"
                                   name="restaurantId"
                                   value="<%= menu.getRestaurantId() %>">

                            <button type="submit"
                                    class="quantity-btn">

                                +

                            </button>

                        </form>

                    </div>

<%
                }
%>

            </div>

        </article>


<%
    }

%>

                </div>

            </section>

<%
}



%>

</main>


<!-- =====================================================
     BOTTOM CART
===================================================== -->

<div class="bottom-cart">

    <div>

        🛒

        <b id="bottomCartCount">

            <%= cartCount %>
            <%= cartCount == 1 ? "Item" : "Items" %>

        </b>

        &nbsp; | &nbsp;

        <b id="bottomCartTotal">

            ₹<%= String.format("%.0f", cartTotal) %>

        </b>

    </div>

    <button class="view-cart"
            onclick="location.href='cart'">

        View Cart →

    </button>

</div>



<script>

/* =========================================================
   DRAWER
========================================================= */

function toggleDrawer() {

    const drawer =
        document.getElementById("drawer");

    const overlay =
        document.getElementById("drawerOverlay");

    drawer.classList.toggle("open");

    overlay.classList.toggle("open");
}


function closeDrawer() {

    document
        .getElementById("drawer")
        .classList.remove("open");

    document
        .getElementById("drawerOverlay")
        .classList.remove("open");
}


/* =========================================================
   FILTER
========================================================= */

function toggleFilter() {

    document
        .getElementById("filterPanel")
        .classList.toggle("open");
}


/* =========================================================
   SEARCH
========================================================= */

document
    .getElementById("searchInput")
    .addEventListener(
        "input",
        function() {

            const search =
                this.value
                    .toLowerCase()
                    .trim();

            document
                .querySelectorAll(
                    ".menu-section"
                )
                .forEach(
                    function(section) {

                        const items =
                            section.querySelectorAll(
                                ".menu-item"
                            );

                        let visibleItems = 0;

                        items.forEach(
                            function(item) {

                                const name =
                                    item.dataset.name
                                        .toLowerCase();

                                if (
                                    name.includes(search)
                                ) {

                                    item.style.display =
                                        "";

                                    visibleItems++;

                                } else {

                                    item.style.display =
                                        "none";
                                }
                            }
                        );


                        if (visibleItems === 0) {

                            section.style.display =
                                "none";

                        } else {

                            section.style.display =
                                "";
                        }

                    }
                );
        }
    );


/* =========================================================
   FILTER
========================================================= */

function applyFilters() {

    const foodRadio = document.querySelector(
        'input[name="foodFilter"]:checked'
    );

    const priceRadio = document.querySelector(
        'input[name="priceFilter"]:checked'
    );

    const food = foodRadio ? foodRadio.value : "all";
    const price = priceRadio ? priceRadio.value : "all";

    const sections = document.querySelectorAll(".menu-section");

    let totalVisibleItems = 0;

    sections.forEach(function(section) {

        const items = section.querySelectorAll(".menu-item");
        let visibleItems = 0;

        items.forEach(function(item) {

            const itemVeg = item.dataset.veg === "true";

            const itemPrice = parseFloat(
                item.dataset.price
            );

            let show = true;

            // FOOD FILTER
            if (food === "veg" && !itemVeg) {
                show = false;
            }

            if (food === "nonveg" && itemVeg) {
                show = false;
            }

            // PRICE FILTER
            if (price === "0-100") {

                if (itemPrice < 0 || itemPrice > 100) {
                    show = false;
                }

            } else if (price === "100-200") {

                if (itemPrice < 100 || itemPrice > 200) {
                    show = false;
                }

            } else if (price === "200-300") {

                if (itemPrice < 200 || itemPrice > 300) {
                    show = false;
                }

            } else if (price === "300plus") {

                if (itemPrice < 300) {
                    show = false;
                }
            }

            // SHOW / HIDE ITEM
            item.style.display = show ? "" : "none";

            if (show) {
                visibleItems++;
                totalVisibleItems++;
            }
        });

        // HIDE ENTIRE CATEGORY IF NO ITEMS MATCH
        if (visibleItems === 0) {
            section.style.display = "none";
        } else {
            section.style.display = "";
        }
    });

    // REMOVE OLD "NO ITEMS" MESSAGE
    const oldMessage = document.getElementById("filterEmptyMessage");

    if (oldMessage) {
        oldMessage.remove();
    }

    // SHOW MESSAGE IF NOTHING MATCHES
    if (totalVisibleItems === 0) {

        const message = document.createElement("div");

        message.id = "filterEmptyMessage";
        message.className = "empty";

        message.innerHTML = `
            <h2>No items found</h2>
            <p>
                No dishes are available for the selected filters.
                Try another price range or food type.
            </p>
        `;

        document.querySelector(".main").prepend(message);
    }
}

/* =========================================================
   CATEGORY NAVIGATION
========================================================= */

function scrollToCategory(
    category,
    button
) {

    document
        .querySelectorAll(
            ".category-link"
        )
        .forEach(
            function(btn) {

                btn.classList.remove(
                    "active"
                );

            }
        );


    button.classList.add("active");


    if (
        category === "recommended"
    ) {

        window.scrollTo({

            top: 0,

            behavior: "smooth"

        });

        return;
    }


    const id =
        "category-" +
        category.replace(
            /[^a-zA-Z0-9]/g,
            "-"
        );


    const section =
        document.getElementById(id);


    if (section) {

        const headerOffset = 170;

        const position =
            section
                .getBoundingClientRect()
                .top +
            window.pageYOffset -
            headerOffset;


        window.scrollTo({

            top: position,

            behavior: "smooth"

        });
    }
}


/* =========================================================
   FAVORITE
========================================================= */

function toggleFavorite(button) {

    button.classList.toggle(
        "active"
    );


    if (
        button.classList.contains(
            "active"
        )
    ) {

        button.innerHTML = "♥";

    } else {

        button.innerHTML = "♡";
    }
}


/* =========================================================
   CLOSE FILTER WHEN CLICKING OUTSIDE
========================================================= */

document.addEventListener(
    "click",
    function(event) {

        const panel =
            document.getElementById(
                "filterPanel"
            );

        const button =
            document.querySelector(
                ".filter-button"
            );


        if (
            panel &&
            button &&
            !panel.contains(event.target) &&
            !button.contains(event.target)
        ) {

            panel.classList.remove(
                "open"
            );
        }

    }
);

</script>

</body>

</html>