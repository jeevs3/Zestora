package com.Food.Servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/location")
public class LocationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/location.jsp")
           .forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();


        // ==============================
        // GET LOCATION DETAILS
        // ==============================

        String address =
                req.getParameter("address");

        String pincode =
                req.getParameter("pincode");

        String latitude =
                req.getParameter("latitude");

        String longitude =
                req.getParameter("longitude");


        // ==============================
        // STORE IN SESSION
        // ==============================

        session.setAttribute(
                "selectedAddress",
                address
        );

        session.setAttribute(
                "selectedPincode",
                pincode
        );

        session.setAttribute(
                "selectedLatitude",
                latitude
        );

        session.setAttribute(
                "selectedLongitude",
                longitude
        );


        // ==============================
        // BACK TO CHECKOUT
        // ==============================

        resp.sendRedirect(
                req.getContextPath()
                + "/checkout"
        );
    }
}