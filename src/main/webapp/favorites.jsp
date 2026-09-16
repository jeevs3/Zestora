<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    String contextPath = request.getContextPath();

    List<Map<String, Object>> favorites =
        (List<Map<String, Object>>) request.getAttribute("favorites");

    if (favorites == null) {
        favorites = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Favorites - Zestora</title>

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
            background: white;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 8%;
            border-bottom: 1px solid #eee;
        }

        .logo {
            font-size: 30px;
            font-weight: 800;
        }

        .logo span {
            color: #e53935;
        }

        .header-buttons {
            display: flex;
            gap: 12px;
        }

        .header-btn {
            border: none;
            padding: 12px 20px;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            background: #f0f0f0;
        }

        .cart-btn {
            background: #e53935;
            color: white;
        }

        /* ================= MAIN ================= */

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        .page-title {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 30px;
        }

        /* ================= EMPTY ================= */

        .empty {
            background: white;
            border-radius: 20px;
            padding: 70px 20px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .empty h2 {
            margin-bottom: 10px;
        }

        .empty p {
            color: #777;
            margin-bottom: 25px;
        }

        .browse-btn {
            display: inline-block;
            background: #e53935;
            color: white;
            text-decoration: none;
            padding: 13px 25px;
            border-radius: 12px;
            font-weight: 600;
        }

        /* ================= GRID ================= */

        .favorites-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fill, minmax(300px, 1fr));
            gap: 22px;
        }

        /* ================= CARD ================= */

        .favorite-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
            transition: 0.2s;
        }

        .favorite-card:hover {
            transform: translateY(-3px);
        }

        .food-image {
            width: 100%;
            height: 210px;
            object-fit: cover;
        }

        .card-content {
            padding: 20px;
        }

        .restaurant {
            font-size: 14px;
            color: #777;
            margin-bottom: 7px;
        }

        .food-name {
            font-size: 21px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .description {
            color: #777;
            font-size: 14px;
            line-height: 1.5;
            min-height: 42px;
            margin-bottom: 15px;
        }

        .price {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 17px;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .actions form {
            flex: 1;
        }

        .add-btn,
        .remove-btn {
            width: 100%;
            padding: 11px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
        }

        .add-btn {
            border: none;
            background: #e53935;
            color: white;
        }

        .remove-btn {
            border: 1px solid #ddd;
            background: white;
            color: #444;
        }

        .remove-btn:hover {
            background: #f5f5f5;
        }

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

            .header-btn {
                padding: 10px 12px;
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

    <div class="header-buttons">

        <button class="header-btn"
                onclick="history.back()">
            ← Back
        </button>

        <button class="header-btn cart-btn"
                onclick="location.href='<%= contextPath %>/cart'">
            🛒 Cart
        </button>

    </div>

</header>


<!-- ================= MAIN ================= -->

<div class="container">

    <h1 class="page-title">
        My Favorites
    </h1>

    <p class="subtitle">
        Your favorite dishes, all in one place.
    </p>


<% if (favorites.isEmpty()) { %>

    <!-- ================= EMPTY ================= -->

    <div class="empty">

        <div class="empty-icon">
            ♡
        </div>

        <h2>
            No favorites yet
        </h2>

        <p>
            Save your favorite dishes and find them here.
        </p>

        <a class="browse-btn"
           href="<%= contextPath %>/restaurant">
            Browse Restaurants
        </a>

    </div>

<% } else { %>

    <!-- ================= FAVORITES ================= -->

    <div class="favorites-grid">

<%
    for (Map<String, Object> item : favorites) {

        int menuId =
            (Integer) item.get("menuId");

        int restaurantId =
            (Integer) item.get("restaurantId");

        String itemName =
            (String) item.get("itemName");

        String restaurantName =
            (String) item.get("restaurantName");

        String description =
            (String) item.get("description");

        String photo =
            (String) item.get("photo");

        double price =
            (Double) item.get("price");

        if (description == null ||
            description.trim().isEmpty()) {

            description =
                "Delicious food prepared fresh.";
        }

        if (photo == null ||
            photo.trim().isEmpty()) {

            photo = "images/default-food.jpg";
        }
%>

        <div class="favorite-card"
             id="favorite-<%= menuId %>">

            <img class="food-image"
                 src="<%= photo %>"
                 alt="<%= itemName %>"
                 onerror="this.onerror=null;
                          this.src='images/default-food.jpg';">

            <div class="card-content">

                <div class="restaurant">
                    <%= restaurantName != null
                        ? restaurantName
                        : "Restaurant" %>
                </div>

                <div class="food-name">
                    <%= itemName %>
                </div>

                <div class="description">
                    <%= description %>
                </div>

                <div class="price">
                    &#8377;<%= String.format("%.0f", price) %>
                </div>

                <div class="actions">

                    <!-- ADD TO CART -->

                    <form action="<%= contextPath %>/addToCart"
                          method="post">

                        <input type="hidden"
                               name="menuId"
                               value="<%= menuId %>">

                        <input type="hidden"
                               name="restaurantId"
                               value="<%= restaurantId %>">

                        <input type="hidden"
                               name="price"
                               value="<%= price %>">

                        <input type="hidden"
                               name="action"
                               value="add">

                        <button type="submit"
                                class="add-btn">
                            Add to Cart
                        </button>

                    </form>


                    <!-- REMOVE -->

                    <button type="button"
                            class="remove-btn"
                            onclick="removeFavorite(<%= menuId %>)">

                        Remove

                    </button>

                </div>

            </div>

        </div>

<%
    }
%>

    </div>

<% } %>

</div>


<script>

    const contextPath = "<%= contextPath %>";


    // =====================================================
    // REMOVE FAVORITE
    // =====================================================

    function removeFavorite(menuId) {

        fetch(contextPath + "/favorites", {

            method: "POST",

            headers: {
                "Content-Type":
                    "application/x-www-form-urlencoded"
            },

            body:
                "menuId=" +
                encodeURIComponent(menuId) +
                "&action=remove"

        })

        .then(response => response.json())

        .then(data => {

            if (data.favorite === false) {

                const card =
                    document.getElementById(
                        "favorite-" + menuId
                    );

                if (card) {
                    card.remove();
                }

                // If no cards remain, reload page
                if (
                    document.querySelectorAll(
                        ".favorite-card"
                    ).length === 0
                ) {
                    location.reload();
                }
            }

        })

        .catch(error => {

            console.error(
                "Favorite error:",
                error
            );

            alert(
                "Unable to remove favorite."
            );
        });
    }

</script>

</body>
</html>