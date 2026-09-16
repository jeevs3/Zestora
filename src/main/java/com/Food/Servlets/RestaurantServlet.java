package com.Food.Servlets;

import java.io.IOException;
import java.util.List;

import com.Food.Model.Restaurant;
import com.Food.daoimp.RestaurantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/restaurant")
public class RestaurantServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();

        List<Restaurant> allRestaurants =
                restaurantDAOImpl.getAllRestaurant();
        
        req.setAttribute("allRestaurants", allRestaurants);
       RequestDispatcher rd = req.getRequestDispatcher("restaurant.jsp");
       rd.forward(req, resp);
    }
}