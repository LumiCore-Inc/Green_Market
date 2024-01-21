package com.green_market.servlets;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.green_market.entities.Order;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import org.apache.commons.dbcp2.BasicDataSource;
import org.json.simple.JSONObject;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.Objects;

import static com.green_market.config.Security.isValidJWT;
import static com.green_market.util.JsonPasser.jsonPasser;

@WebServlet(name = "orderServlet", value = "/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");

        Connection connection = null;
        try {
            connection = ds.getConnection();
            connection.setAutoCommit(false); // Start transaction

            if (!Objects.equals(claims, null)) {
                Object user = claims.getBody().get("userID");

                if (Objects.equals(user, null)){
                    response.add("message", "Unauthorized Request");
                    response.add("code", 403);
                    resp.setStatus(403);
                    writer.print(response.build());
                    writer.close();
                }

                JSONObject json = jsonPasser(req);
                Long total = (Long) json.get("total");
//                double v = total.doubleValue();

                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode details = objectMapper.readTree(json.get("details").toString());

                PreparedStatement pstm = connection.prepareStatement("INSERT INTO `order` VALUE (?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
                pstm.setObject(1, 0);
                pstm.setObject(2, new Timestamp(new Date().getTime()));
                pstm.setObject(3, total);
                pstm.setObject(4, user);
                int i = pstm.executeUpdate();

                ResultSet generatedKeys = pstm.getGeneratedKeys();
                if (generatedKeys.next()) {

                    int generatedID = generatedKeys.getInt(1);

                    for (JsonNode product :details) {
                        JsonNode productId = product.get("productId");
                        JsonNode orderQty = product.get("qty");

                        pstm = connection.prepareStatement("SELECT qty FROM products WHERE id=?");
                        pstm.setObject(1, productId.asInt());
                        ResultSet resultSet = pstm.executeQuery();

                        while (resultSet.next()){
                            int qty = resultSet.getInt(1);

                            if (orderQty.asDouble() > qty){
                                response.add("message", "not enough qty");
                                response.add("code", 400);
                                resp.setStatus(400);
                                writer.print(response.build());
                                writer.close();
                                connection.rollback();
                                return; // Rollback transaction
                            } else {
                                pstm = connection.prepareStatement("UPDATE products set qty=? where id=?");
                                pstm.setObject(1, qty - orderQty.asDouble());
                                pstm.setObject(2, productId.asInt());
                                int i1 = pstm.executeUpdate();

                                if (i1 == 0){
                                    response.add("message", "something went wrong");
                                    response.add("code", 400);
                                    resp.setStatus(400);
                                    writer.print(response.build());
                                    writer.close();
                                    connection.rollback();
                                    return; // Rollback transaction
                                }
                            }
                        }

                        pstm = connection.prepareStatement("INSERT INTO order_details VALUE (?,?,?,?,?)");
                        pstm.setObject(1, 0);
                        pstm.setObject(2, generatedID);
                        pstm.setObject(3, productId.asInt());
                        pstm.setObject(4, product.get("unitPrice").asDouble());
                        pstm.setObject(5, orderQty.asDouble());
                        int update = pstm.executeUpdate();

                        if (update == 0){
                            response.add("message", "something went wrong");
                            response.add("code", 400);
                            resp.setStatus(400);
                            writer.print(response.build());
                            writer.close();
                            connection.rollback();
                            return; // Rollback transaction
                        }
                    }

                    connection.commit(); // Commit transaction since everything is successful

                    response.add("message", "success");
                    response.add("code", 201);
                    resp.setStatus(201);
                    writer.print(response.build());
                    writer.close();
                }
            } else {
                response.add("message", "Unauthorized Request");
                response.add("code", 403);
                resp.setStatus(403);
                writer.print(response.build());
                writer.close();
            }
        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback(); // Rollback transaction in case of an exception
                }
            } catch (SQLException ex) {
                ex.printStackTrace(); // Handle rollback exception
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true); // Reset auto-commit to true
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Handle connection closure exception
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if (action.equals("all")) {
            getAllOrders(req, resp);
        } else {
            getOrderById(req, resp);
        }

    }

    private void getOrderById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");


        if (!Objects.equals(claims, null)) {
            Object user = claims.getBody().get("userID");

            if (Objects.equals(user, null)) {
                response.add("message", "Unauthorized Request");
                response.add("code", 403);
                resp.setStatus(403);
                writer.print(response.build());
                writer.close();
            }

            String orderId = req.getParameter("action");

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = null;
            try {
                connection = ds.getConnection();
                PreparedStatement pstm = connection.prepareStatement("SELECT * FROM `order` where user_id=? and id=?");
                pstm.setObject(1, user);
                pstm.setObject(2, Integer.parseInt(orderId));
                ResultSet resultSet = pstm.executeQuery();

                Order order = null;
                while (resultSet.next()){
                    order = new Order(
                            resultSet.getInt(1),
                            resultSet.getTimestamp(2),
                            resultSet.getDouble(3)
                    );
                }

                if (Objects.equals(order, null)){
                    response.add("message", "order not exist");
                    response.add("code", 400);
                    resp.setStatus(400);
                    writer.print(response.build());
                    writer.close();
                }else {

                    System.out.println(order.toString());

                    response.add("data", "");
                    response.add("message", "success");
                    response.add("code", 200);
                    writer.print(response.build());
                    writer.close();
                }
                connection.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void getAllOrders(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");


        if (!Objects.equals(claims, null)) {
            Object user = claims.getBody().get("userID");

            if (Objects.equals(user, null)) {
                response.add("message", "Unauthorized Request");
                response.add("code", 403);
                resp.setStatus(403);
                writer.print(response.build());
                writer.close();
            }

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = null;
            try {
                connection = ds.getConnection();
                PreparedStatement pstm = connection.prepareStatement("SELECT * FROM `order` where user_id=?");
                pstm.setObject(1, user);
                ResultSet resultSet = pstm.executeQuery();

                ArrayList<Order> orders = new ArrayList<>();
                while (resultSet.next()){
                    Order order = new Order(
                            resultSet.getInt(1),
                            resultSet.getTimestamp(2),
                            resultSet.getDouble(3)
                    );
                    orders.add(order);
                }

                response.add("data", "");
                response.add("message", "success");
                response.add("code", 200);
                writer.print(response.build());
                writer.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
