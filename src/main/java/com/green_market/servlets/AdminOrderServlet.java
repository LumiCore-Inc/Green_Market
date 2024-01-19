package com.green_market.servlets;

import com.green_market.entities.Order;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import org.apache.commons.dbcp2.BasicDataSource;

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
import java.util.Objects;

import static com.green_market.config.Security.isValidJWT;

@WebServlet(name = "adminOrderServlet", value = "/admin-order")
public class AdminOrderServlet extends HttpServlet {

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
                PreparedStatement pstm = connection.prepareStatement("SELECT * FROM `order` where id=?");
                pstm.setObject(1, Integer.parseInt(orderId));
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
                PreparedStatement pstm = connection.prepareStatement("SELECT * FROM `order`");
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

                System.out.println(orders.toString());

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
