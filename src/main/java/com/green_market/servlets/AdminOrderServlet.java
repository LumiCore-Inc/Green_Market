package com.green_market.servlets;

import com.green_market.entities.Order;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import org.apache.commons.dbcp2.BasicDataSource;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
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
        }else if (action.equals("by-user")){
            getAllOrdersByUserId(req, resp);
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

                PreparedStatement pstm = connection.prepareStatement("select od.id,\n" +
                        "       p.name ,\n" +
                        "       od.qty,\n" +
                        "       od.unit_price,\n" +
                        "       (select url from product_has_images where product_id = od.product_id limit 1)\n" +
                        "from order_details od\n" +
                        "    LEFT JOIN green_market.products p\n" +
                        "        on od.product_id = p.id where od.order_id=?");
                pstm.setObject(1, Integer.parseInt(orderId));
                ResultSet resultSet1 = pstm.executeQuery();

                JsonArrayBuilder details = Json.createArrayBuilder();
                while (resultSet1.next()){
                    JsonObjectBuilder detail = Json.createObjectBuilder();

                    detail.add("detailId",resultSet1.getInt(1));
                    detail.add("productName",resultSet1.getString(2));
                    detail.add("qty",resultSet1.getDouble(3));
                    detail.add("unitPrice",resultSet1.getDouble(4));
                    detail.add("img",resultSet1.getString(5));

                    details.add(detail);
                }

                if (Objects.equals(details, null)){
                    response.add("message", "order not exist");
                    response.add("code", 400);
                    resp.setStatus(400);
                    writer.print(response.build());
                    writer.close();
                }else {

                    System.out.println(details.toString());

                    response.add("data", details);
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
                PreparedStatement pstm = connection.prepareStatement("SELECT \n" +
                        "    o.id,\n" +
                        "    o.order_date,\n" +
                        "    o.total, \n" +
                        "    CONCAT(u.first_name ,' ', u.last_name) \n" +
                        "FROM `order` o \n" +
                        "    LEFT JOIN users u on `o`.user_id = u.id");
                ResultSet resultSet = pstm.executeQuery();

                JsonArrayBuilder orders = Json.createArrayBuilder();
                while (resultSet.next()){
                    JsonObjectBuilder order = Json.createObjectBuilder();
                    order.add("id", resultSet.getInt(1));
                    order.add("orderDate", resultSet.getTimestamp(2).toString());
                    order.add("total", resultSet.getDouble(3));
                    order.add("customer", resultSet.getString(4));

                    orders.add(order);
                }

                System.out.println(orders.toString());

                response.add("data", orders);
                response.add("message", "success");
                response.add("code", 200);
                writer.print(response.build());
                writer.close();
                connection.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void getAllOrdersByUserId(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
                PreparedStatement pstm = connection.prepareStatement("SELECT \n" +
                        "    o.id,\n" +
                        "    o.order_date,\n" +
                        "    o.total, \n" +
                        "    CONCAT(u.first_name ,' ', u.last_name) \n" +
                        "FROM `order` o \n" +
                        "    LEFT JOIN users u on `o`.user_id = u.id WHERE u.id=?");
                pstm.setObject(1, Integer.parseInt(user.toString()));
                ResultSet resultSet = pstm.executeQuery();

                JsonArrayBuilder orders = Json.createArrayBuilder();
                while (resultSet.next()){
                    JsonObjectBuilder order = Json.createObjectBuilder();
                    order.add("id", resultSet.getInt(1));
                    order.add("orderDate", resultSet.getTimestamp(2).toString());
                    order.add("total", resultSet.getDouble(3));
                    order.add("customer", resultSet.getString(4));

                    orders.add(order);
                }

                System.out.println(orders.toString());

                response.add("data", orders);
                response.add("message", "success");
                response.add("code", 200);
                writer.print(response.build());
                writer.close();
                connection.close();

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
