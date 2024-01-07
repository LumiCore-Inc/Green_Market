package com.green_market.config;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*") // Filter all requests
public class JWTValidationFilter implements Filter {
    private static final String SECRET_KEY = "";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("dshdf");
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        System.out.println(req);
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // Get the Authorization header from the request
        String authHeader = request.getHeader("Authorization");

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            // Extract the token from the Authorization header
            String token = authHeader.substring(7); // Remove "Bearer " prefix

            try {
                // Verify and parse the token
                Claims claims = Jwts.parser()
                        .setSigningKey(SECRET_KEY)
                        .parseClaimsJws(token)
                        .getBody();

                System.out.println(claims);

                // Extract necessary information from the token (e.g., username, roles)

                // Proceed with the request chain
                chain.doFilter(req, res);
            } catch (JwtException | IllegalArgumentException e) {
                // Token validation failed
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            }
        } else {
            // No token or invalid format
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
