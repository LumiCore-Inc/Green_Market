package com.green_market.servlets;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import org.apache.commons.dbcp2.BasicDataSource;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.json.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.Objects;

import static com.green_market.config.Security.isValidJWT;

@WebServlet(name = "cartServlet", value = "/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        if (!Objects.equals(claims, null)) {
            JsonObjectBuilder response = Json.createObjectBuilder();
            PrintWriter writer = resp.getWriter();
            resp.setContentType("application/json");

            String productId = req.getParameter("productId");

            Object user = claims.getBody().get("userID");

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            PreparedStatement pstm;
            try {
                Connection connection = ds.getConnection();

                pstm = connection.prepareStatement("select * from products where id=?");
                pstm.setObject(1, productId);
                ResultSet executeQuery = pstm.executeQuery();

                JsonObjectBuilder product = Json.createObjectBuilder();
                while (executeQuery.next()){
                    product.add("productId", executeQuery.getInt(1));
                }
                if (product.build().isEmpty()){
                    response.add("message", "product not exist");
                    response.add("code", 400);
                    resp.setStatus(400);
                    connection.close();
                    writer.print(response.build());
                    writer.close();
                }

                pstm = connection.prepareStatement("select * from cart where user_id=?");
                pstm.setObject(1, user);
                ResultSet rst = pstm.executeQuery();

                JsonObjectBuilder cart = Json.createObjectBuilder();

                while (rst.next()) {
                    cart.add("id", rst.getInt(1));
                }

                JsonObject build = cart.build();

                if (build.isEmpty()){
                    System.out.println("create new cart and add product");
                    pstm = connection.prepareStatement("INSERT INTO cart VALUE (?,?)", Statement.RETURN_GENERATED_KEYS);
                    pstm.setObject(1, 0);
                    pstm.setObject(2, user);
                    int i = pstm.executeUpdate();

                    if (i > 0) {
                        ResultSet generatedKeys = pstm.getGeneratedKeys();
                        if (generatedKeys.next()) {
                            int generatedID = generatedKeys.getInt(1);

                            pstm = connection.prepareStatement("INSERT INTO cart_has_product VALUE (?,?,?)");
                            pstm.setObject(1, 0);
                            pstm.setObject(2, generatedID);
                            pstm.setObject(3, productId);

                            int update = pstm.executeUpdate();

                            if (update > 0) {
                                response.add("message", "success");
                                response.add("code", 200);
                                connection.close();
                                writer.print(response.build());
                                writer.close();
                            }
                        }
                    }
                }else {
                    System.out.println("add product into exist cart");

                    int cartId = Integer.parseInt(String.valueOf(build.get("id")));
                    pstm = connection.prepareStatement("SELECT * FROM cart_has_product WHERE cart_id=? and product_id=?");
                    pstm.setObject(1,cartId);
                    pstm.setObject(2,productId);
                    ResultSet resultSet = pstm.executeQuery();

                    product = Json.createObjectBuilder();
                    while (resultSet.next()) {
                        product.add("productId", resultSet.getInt(3));
                    }

                    if (product.build().isEmpty()){
                        pstm = connection.prepareStatement("INSERT INTO cart_has_product VALUE (?,?,?)");
                        pstm.setObject(1, 0);
                        pstm.setObject(2, Integer.parseInt(String.valueOf(build.get("id"))));
                        pstm.setObject(3, productId);

                        int update = pstm.executeUpdate();

                        if (update > 0) {
                            response.add("message", "success");
                            response.add("code", 200);
                            connection.close();
                            writer.print(response.build());
                            writer.close();
                        }
                    }else {
                        response.add("message", "product already exist in cart");
                        response.add("code", 404);
                        resp.setStatus(404);
                        connection.close();
                        writer.print(response.build());
                        writer.close();
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        if (!Objects.equals(claims, null)) {
            JsonObjectBuilder response = Json.createObjectBuilder();
            PrintWriter writer = resp.getWriter();
            resp.setContentType("application/json");

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            PreparedStatement pstm;
            try {
                Connection connection = ds.getConnection();
                Object user = claims.getBody().get("userID");

                pstm = connection.prepareStatement("SELECT\n" +
                        "    chp.id,\n" +
                        "    p.name,\n" +
                        "    p.price,\n" +
                        "    p.description,\n" +
                        "    (SELECT url FROM product_has_images WHERE product_id = p.id LIMIT 1)\n" +
                        "FROM\n" +
                        "    products p\n" +
                        "        LEFT JOIN cart_has_product chp\n" +
                        "            ON p.id = chp.product_id\n" +
                        "        LEFT JOIN cart c\n" +
                        "            ON c.id = chp.cart_id\n" +
                        "WHERE c.user_id=? GROUP BY chp.id");
                pstm.setObject(1, user);
                ResultSet rst = pstm.executeQuery();

                DecimalFormat df = new DecimalFormat("0.00");
                JsonArrayBuilder products = Json.createArrayBuilder();
                while (rst.next()) {
                    JsonObjectBuilder cart = Json.createObjectBuilder();
                    cart.add("productCartId", rst.getInt(1));
                    cart.add("productName", rst.getString(2));
                    cart.add("price", df.format(rst.getDouble(3)));
                    cart.add("description", rst.getString(4) == null ? "" : rst.getString(4));
                    cart.add("imgUrl", rst.getString(5) == null ? "" : rst.getString(5));

                    products.add(cart.build());
                }
                connection.close();

                JsonArray cartBuild = products.build();
                if (cartBuild.isEmpty()){
                    response.add("message", "empty cart");
                    response.add("code", 200);
                }else {
                    response.add("data", cartBuild);
                    response.add("message", "success");
                    response.add("code", 200);
                }

                writer.print(response.build());
                writer.close();
            }catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        if (!Objects.equals(claims, null)) {
            JsonObjectBuilder response = Json.createObjectBuilder();
            PrintWriter writer = resp.getWriter();
            resp.setContentType("application/json");

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            PreparedStatement pstm;
            try {
                Connection connection = ds.getConnection();

                Integer id = Integer.valueOf(req.getParameter("productCartId"));

                pstm = connection.prepareStatement("DELETE FROM cart_has_product WHERE id=?");
                pstm.setObject(1, id);
                int i = pstm.executeUpdate();

                if (i > 0) {
                    response.add("message", "success");
                    response.add("code", 200);
                }

                writer.print(response.build());
                writer.close();
            }catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
