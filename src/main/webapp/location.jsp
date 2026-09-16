<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Select Location - Zestora</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #ffffff;
            color: #222;
        }

        /* ================= HEADER ================= */

        .header {
            height: 70px;
            border-bottom: 1px solid #eeeeee;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 15%;
        }

        .logo {
            font-family: Georgia, serif;
            font-size: 32px;
            font-weight: bold;
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

        /* ================= MAIN ================= */

        .container {
            width: 900px;
            max-width: 92%;
            margin: 35px auto;
        }

        .title {
            font-family: Georgia, serif;
            font-size: 32px;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 25px;
        }

        /* ================= SEARCH ================= */

        .search-box {
            position: relative;
            margin-bottom: 15px;
        }

        .search-box input {
            width: 100%;
            height: 52px;
            padding: 0 18px;
            border: 1px solid #dddddd;
            border-radius: 10px;
            font-size: 16px;
            outline: none;
        }

        .search-box input:focus {
            border-color: #ef2b23;
        }

        /* ================= CURRENT LOCATION ================= */

        .current-location {
            width: 100%;
            border: 1px solid #eeeeee;
            background: white;
            padding: 15px;
            border-radius: 10px;
            text-align: left;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-bottom: 15px;
        }

        .current-location:hover {
            background: #fafafa;
        }

        .location-icon {
            color: #ef2b23;
            margin-right: 8px;
        }

        /* ================= MAP ================= */

        #map {
            width: 100%;
            height: 450px;
            border-radius: 14px;
            border: 1px solid #dddddd;
            margin-bottom: 18px;
        }

        /* ================= SELECTED ADDRESS ================= */

        .selected-box {
            border: 1px solid #e4e4e4;
            border-radius: 12px;
            padding: 18px;
            margin-bottom: 15px;
        }

        .selected-title {
            font-size: 14px;
            font-weight: bold;
            color: #777;
            margin-bottom: 7px;
        }

        #selectedAddress {
            font-size: 16px;
            font-weight: 600;
        }

        /* ================= CONFIRM ================= */

        .confirm-btn {
            width: 100%;
            height: 52px;
            border: none;
            border-radius: 9px;
            background: #ef2b23;
            color: white;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
        }

        .confirm-btn:hover {
            background: #dc211b;
        }

    </style>

</head>

<body>

<!-- ================= HEADER ================= -->

<div class="header">

     <div class="logo">
    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>

 <a href="${pageContext.request.contextPath}/checkout"
   class="back-btn">
    ← Back to checkout
</a>

</div>


<!-- ================= MAIN ================= -->

<div class="container">

    <div class="title">
        Select Delivery Location
    </div>

    <div class="subtitle">
        Choose where you want your order delivered.
    </div>


    <!-- SEARCH -->

    <div class="search-box">

        <input type="text"
               id="searchInput"
               placeholder="Search for area, street or landmark">

    </div>


    <!-- CURRENT LOCATION -->

    <button class="current-location"
            onclick="getCurrentLocation()">

        <span class="location-icon">📍</span>

        Use my current location

    </button>


    <!-- MAP -->

    <div id="map"></div>


    <!-- SELECTED ADDRESS -->

    <div class="selected-box">

        <div class="selected-title">
            SELECTED LOCATION
        </div>

        <div id="selectedAddress">
            Move the pin to select your delivery location.
        </div>

    </div>


    <!-- CONFIRM -->

    <form action="${pageContext.request.contextPath}/location"
          method="post">

        <input type="hidden"
               name="address"
               id="addressInput">

        <input type="hidden"
               name="pincode"
               id="pincodeInput">

        <input type="hidden"
               name="latitude"
               id="latitudeInput">

        <input type="hidden"
               name="longitude"
               id="longitudeInput">


        <button type="submit"
                class="confirm-btn">

            Confirm Location

        </button>

    </form>

</div>


<!-- ================= GOOGLE MAP ================= -->

<script>

let map;
let marker;
let geocoder;
let autocomplete;


/*
 * Initialize Google Map
 */
function initMap() {

    /*
     * Default location
     * Bengaluru
     */
    const defaultLocation = {
        lat: 12.9716,
        lng: 77.5946
    };


    map = new google.maps.Map(
        document.getElementById("map"),
        {
            center: defaultLocation,
            zoom: 15
        }
    );


    geocoder = new google.maps.Geocoder();


    /*
     * Create marker
     */
    marker = new google.maps.Marker({

        position: defaultLocation,

        map: map,

        draggable: true

    });


    /*
     * Search box
     */
    const input =
        document.getElementById("searchInput");


    autocomplete =
        new google.maps.places.Autocomplete(input);


    autocomplete.bindTo("bounds", map);


    /*
     * When user selects a search result
     */
    autocomplete.addListener(
        "place_changed",
        function () {

            const place =
                autocomplete.getPlace();


            if (!place.geometry ||
                !place.geometry.location) {

                alert("Location not found.");

                return;
            }


            map.setCenter(
                place.geometry.location
            );

            map.setZoom(17);


            marker.setPosition(
                place.geometry.location
            );


            getAddress(
                place.geometry.location
            );

        }
    );


    /*
     * When user moves the marker
     */
    marker.addListener(
        "dragend",
        function () {

            getAddress(
                marker.getPosition()
            );

        }
    );


    /*
     * Initial location
     */
    getAddress(defaultLocation);
}


/*
 * Get address from latitude/longitude
 */
function getAddress(location) {

    geocoder.geocode(
        {
            location: location
        },

        function(results, status) {

            if (status === "OK" &&
                results[0]) {

                const address =
                    results[0].formatted_address;


                let pincode = "";


                /*
                 * Find PIN code
                 */
                for (
                    let component
                    of results[0].address_components
                ) {

                    if (
                        component.types.includes(
                            "postal_code"
                        )
                    ) {

                        pincode =
                            component.long_name;

                    }

                }


                document.getElementById(
                    "selectedAddress"
                ).innerText = address;


                document.getElementById(
                    "addressInput"
                ).value = address;


                document.getElementById(
                    "pincodeInput"
                ).value = pincode;


                document.getElementById(
                    "latitudeInput"
                ).value =
                    location.lat();


                document.getElementById(
                    "longitudeInput"
                ).value =
                    location.lng();

            }

        }
    );
}


/*
 * Current location
 */
function getCurrentLocation() {

    if (!navigator.geolocation) {

        alert(
            "Your browser does not support location."
        );

        return;
    }


    navigator.geolocation.getCurrentPosition(

        function(position) {

            const location = {

                lat: position.coords.latitude,

                lng: position.coords.longitude

            };


            map.setCenter(location);

            map.setZoom(17);

            marker.setPosition(location);

            getAddress(location);

        },

        function() {

            alert(
                "Unable to get your current location."
            );

        }

    );

}

</script>


<!--
    IMPORTANT:
    Replace YOUR_GOOGLE_MAPS_API_KEY
    with your actual Google Maps API key.
-->

<script async
        defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBdBgjioaHWR9XREIYVYWbcnjU0QW1fkWs&libraries=places&callback=initMap">
</script>


</body>
</html>