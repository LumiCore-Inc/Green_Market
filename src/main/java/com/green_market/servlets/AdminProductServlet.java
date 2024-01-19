package com.green_market.servlets;

import com.green_market.entities.Product;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import org.apache.commons.dbcp2.BasicDataSource;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Objects;

import static com.green_market.config.Security.isValidJWT;
import static com.green_market.util.JsonPasser.jsonPasser;

@WebServlet(name = "adminProductServlet", value = "/admin-product")
public class AdminProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        if (!Objects.equals(claims, null)) {
            JsonObjectBuilder response = Json.createObjectBuilder();
            PrintWriter writer = resp.getWriter();
            resp.setContentType("application/json");

            JSONObject json = jsonPasser(req);

            String name = json.get("name").toString();
            String price = json.get("price").toString();
            String description = json.get("description").toString();
            String qty = json.get("qty").toString();

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = null;
            PreparedStatement pstm = null;
            ResultSet rst = null;

            try {
                connection = ds.getConnection();
                connection.setAutoCommit(false);

                // Check if product name already exists
                pstm = connection.prepareStatement("select * from products where name=?");
                pstm.setObject(1, name);
                rst = pstm.executeQuery();

                if (rst.next()) {
                    response.add("message", "product name already exists");
                    response.add("code", 400);
                    resp.setStatus(400);
                    writer.print(response.build());
                    return;
                }

                // Insert the new product
                pstm = connection.prepareStatement("insert into products values(?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
                pstm.setObject(1, 0);
                pstm.setObject(2, name);
                pstm.setObject(3, price);
                pstm.setObject(4, 0);
                pstm.setObject(5, claims.getBody().get("userID"));
                pstm.setObject(6, description);
                pstm.setObject(7, qty);

                int i = pstm.executeUpdate();

                if (i > 0) {
                    ResultSet generatedKeys = pstm.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int generatedID = generatedKeys.getInt(1);

                        // Save new images
                        JSONArray imagesArray = (JSONArray) json.get("images");
                        for (Object object : imagesArray) {
                            pstm = connection.prepareStatement("insert into product_has_images values (?,?,?)");
                            pstm.setObject(1, 0);
                            pstm.setObject(2, object);
                            pstm.setObject(3, generatedID);

                            pstm.executeUpdate();
                        }

                        // Commit the transaction
                        connection.commit();
                        response.add("message", "success");
                        response.add("code", 201);
                        writer.print(response.build());
                    } else {
                        // If update fails, rollback the transaction
                        connection.rollback();
                        response.add("message", "failed");
                        response.add("code", 400);
                        writer.print(response.build());
                    }
                }
            } catch (SQLException throwables) {
                response.add("message", "failed");
                response.add("code", 400);
                writer.print(response.build());
                throwables.printStackTrace();
            } finally {
                try {
                    if (rst != null) {
                        rst.close();
                    }
                    if (pstm != null) {
                        pstm.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                    writer.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();

            String productId = req.getParameter("productId");

            String httpMethod = String.valueOf(req.getAttribute("method"));
            if (httpMethod.equals("GET")){
                productId = null;
            }

            PreparedStatement pstm = null;
            if (Objects.equals(productId, null)) {
                pstm = connection.prepareStatement("select * from products");
            } else {
                pstm = connection.prepareStatement("select * from products where id=?");
                pstm.setObject(1, productId);
            }

            ResultSet rst = pstm.executeQuery();

            JsonArrayBuilder products = Json.createArrayBuilder();

            DecimalFormat df = new DecimalFormat("0.00");
            if (Objects.equals(productId, null)) {
                ArrayList<Product> productList = new ArrayList<>();
                while (rst.next()) {
                    JsonObjectBuilder product = Json.createObjectBuilder();
                    pstm = connection.prepareStatement("select * from product_has_images where product_id=?");
                    pstm.setObject(1, rst.getInt(1));

                    ResultSet resultSet = pstm.executeQuery();

                    JsonArrayBuilder productHasImages = Json.createArrayBuilder();
                    while (resultSet.next()) {

                        JsonObjectBuilder productHasImage = Json.createObjectBuilder();
                        productHasImage.add("id",resultSet.getInt(1));
                        productHasImage.add("url",resultSet.getString(2));

                        productHasImages.add(productHasImage);
                    }

                    product.add("id",rst.getInt(1));
                    product.add("name",rst.getString(2));
                    product.add("price",rst.getDouble(3));
                    product.add("ratings",rst.getDouble(4));
                    product.add("createdUser",rst.getInt(5));
                    product.add("description",rst.getString(6));
                    product.add("qty",rst.getInt(7));
                    product.add("productHasImages",productHasImages);


                    products.add(product);
                }
                response.add("data", products);
                response.add("message", "success");
                response.add("code", 200);
                writer.print(response.build());
            } else {
                JsonObjectBuilder product = null;
                while (rst.next()) {
                    pstm = connection.prepareStatement("select * from product_has_images where product_id=?");
                    pstm.setObject(1, rst.getInt(1));

                    ResultSet resultSet = pstm.executeQuery();
                    product = Json.createObjectBuilder();

                    JsonArrayBuilder productHasImages = Json.createArrayBuilder();
                    while (resultSet.next()) {

                        JsonObjectBuilder productHasImage = Json.createObjectBuilder();
                        productHasImage.add("id",resultSet.getInt(1));
                        productHasImage.add("url",resultSet.getString(2));

                        productHasImages.add(productHasImage);
                    }

                    product.add("id",rst.getInt(1));
                    product.add("name",rst.getString(2));
                    product.add("price",rst.getDouble(3));
                    product.add("ratings",rst.getDouble(4));
                    product.add("createdUser",rst.getInt(5));
                    product.add("description",rst.getString(6));
                    product.add("qty",rst.getInt(7));
                    product.add("productHasImages",productHasImages);
                }


                if (Objects.equals(product , null)) {
                    response.add("message", "product not exist");
                    response.add("code", 400);
                    resp.setStatus(400);
                    writer.print(response.build());
                } else {
                    response.add("data", product);
                    response.add("message", "success");
                    response.add("code", 200);
                    writer.print(response.build());
                }
            }
            writer.close();
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override// update product
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        if (!Objects.equals(claims, null)) {
            JsonObjectBuilder response = Json.createObjectBuilder();
            PrintWriter writer = resp.getWriter();
            resp.setContentType("application/json");

            JSONObject json = jsonPasser(req);

            String id = json.get("id").toString();
            String name = json.get("name").toString();
            String price = json.get("price").toString();
            String description = json.get("description").toString();
            String qty = json.get("qty").toString();

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = null;

            try {
                connection = ds.getConnection();
                connection.setAutoCommit(false); // Start transaction

                PreparedStatement pstm = connection.prepareStatement("update products set name=?, price=?, created_user=?, description=?, qty=? where id=?", Statement.RETURN_GENERATED_KEYS);
                pstm.setObject(1, name);
                pstm.setObject(2, price);
                pstm.setObject(3, claims.getBody().get("userID"));
                pstm.setObject(4, description);
                pstm.setObject(5, qty);
                pstm.setObject(6, id);
                int i = pstm.executeUpdate();

                if (i > 0) {
                    // Delete current images
                    pstm = connection.prepareStatement("DELETE FROM product_has_images WHERE product_id=?");
                    pstm.setObject(1, id);
                    pstm.executeUpdate();

                    // Save new images
                    JSONArray imagesArray = (JSONArray) json.get("images");
                    for (Object object : imagesArray) {
                        pstm = connection.prepareStatement("insert into product_has_images values (?,?,?)");
                        pstm.setObject(1, 0);
                        pstm.setObject(2, object);
                        pstm.setObject(3, id);

                        pstm.executeUpdate();
                    }

                    // Commit the transaction
                    connection.commit();

                    response.add("message", "success");
                    response.add("code", 204);
                    writer.print(response.build());
                } else {
                    // If update fails, rollback the transaction
                    connection.rollback();
                    response.add("message", "failed");
                    response.add("code", 400);
                    writer.print(response.build());
                }
            } catch (SQLException throwables) {
                if (connection != null) {
                    try {
                        // If any SQL exception occurs, rollback the transaction
                        connection.rollback();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                throwables.printStackTrace();
            } finally {
                if (connection != null) {
                    try {
                        // Restore auto-commit mode and close the connection
                        connection.setAutoCommit(true);
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                writer.close();
            }
        }
    }


    @Override// delete product
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        if (!Objects.equals(claims, null)) {
            JsonObjectBuilder response = Json.createObjectBuilder();
            PrintWriter writer = resp.getWriter();
            resp.setContentType("application/json");

            int productID = Integer.parseInt(req.getParameter("id"));
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = null;
            try {
                connection = ds.getConnection();
                connection.setAutoCommit(false); // Start transaction

                PreparedStatement pstm = connection.prepareStatement("DELETE FROM cart_has_product WHERE product_id=?");
                pstm.setObject(1, productID);
                int i1 = pstm.executeUpdate();
                if (i1 > 0 || i1 == 0){
                    pstm = connection.prepareStatement("DELETE FROM product_has_images WHERE product_id=?");
                    pstm.setObject(1, productID);
                    int i = pstm.executeUpdate();

                    if (i > 0 || i == 0) {
                        //delete current images
                        pstm = connection.prepareStatement("DELETE FROM products where id=?");
                        pstm.setObject(1, productID);
                        pstm.executeUpdate();

                        // Commit the transaction
                        connection.commit();

                        response.add("message", "success");
                        response.add("code", 203);
                        writer.print(response.build());
                    } else {
                        // If deletion fails, rollback the transaction
                        connection.rollback();
                        response.add("message", "failed");
                        response.add("code", 400);
                        writer.print(response.build());
                    }
                }
            } catch (SQLException throwables) {
                if (connection != null) {
                    try {
                        // If any SQL exception occurs, rollback the transaction
                        connection.rollback();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                throwables.printStackTrace();
                response.add("message", "you cant change anything");
                response.add("code", 400);
                resp.setStatus(400);
                writer.print(response.build());
            } finally {
                if (connection != null) {
                    try {
                        // Restore auto-commit mode and close the connection
                        connection.setAutoCommit(true);
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                writer.close();
            }
        }
    }
}
