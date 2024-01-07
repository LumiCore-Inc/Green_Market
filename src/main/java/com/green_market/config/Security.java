package com.green_market.config;

import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Security {

    public boolean isValidUser(String username, String password) {
        // Mock data - replace this with actual database interaction
        Map<String, String> users = new HashMap<>();
        users.put("john", "password123");
        users.put("alice", "qwerty");

        // Check if the provided username exists
        if (users.containsKey(username)) {
            // Get the stored password for the username
            String storedPassword = users.get(username);

            // Check if the provided password matches the stored password
            return password.equals(storedPassword);
        }
        return false; // User not found
    }


    public String createJWT(String username) {
        // Current time in milliseconds
        long currentTimeMillis = System.currentTimeMillis();

        // Set the token expiration time (e.g., 1 hour)
        long expirationTime = currentTimeMillis + (60 * 60 * 1000); // 1 hour

        // Build the JWT claims
        JwtBuilder builder = Jwts.builder()
                .setSubject(username) // Set subject (user)
                .setIssuedAt(new Date(currentTimeMillis)) // Set issued time
                .setExpiration(new Date(expirationTime)); // Set expiration time

        // Sign the token with a secret key using HS256 algorithm
        builder.signWith(SignatureAlgorithm.HS256, "yourSecretKey");

        // Generate the JWT token
        return builder.compact();
    }

}
