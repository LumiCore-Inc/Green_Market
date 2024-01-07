package com.green_market.servlets;

import com.green_market.config.Security;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println(username);
        System.out.println(password);

        Security security = new Security();

        // Validate user credentials
        if (security.isValidUser(username, password)) {
            // Generate JWT token
            String jwtToken = security.createJWT(username);

            // Send JWT token as response
            response.setContentType("application/json");
            response.getWriter().write("{ \"token\": \"" + jwtToken + "\" }");
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }

    public void destroy() {
    }
}