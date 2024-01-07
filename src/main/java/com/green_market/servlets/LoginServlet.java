package com.green_market.servlets;

import com.green_market.config.Security;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response){
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
            try {
                response.getWriter().write("{ \"token\": \"" + jwtToken + "\" }");
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }

}
