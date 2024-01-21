package com.green_market.servlets;

import com.green_market.entities.OrderDetail;
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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;

import static com.green_market.config.Security.isValidJWT;

@WebServlet(name = "orderDetailServlet", value = "/order-details")
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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

            String orderId = req.getParameter("orderId");

            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = null;
            try {
                connection = ds.getConnection();
                PreparedStatement pstm = connection.prepareStatement("SELECT \n" +
                        "    od.id,\n" +
                        "    p.name, \n" +
                        "    od.unit_price, \n" +
                        "    od.qty  \n" +
                        "FROM `order_details` od \n" +
                        "    LEFT JOIN products p on od.product_id = p.id \n" +
                        "where order_id=?");
                pstm.setObject(1, Integer.parseInt(orderId));
                ResultSet resultSet = pstm.executeQuery();

                ArrayList<OrderDetail> orderDetails = new ArrayList<>();

                while (resultSet.next()){
                    OrderDetail order = new OrderDetail(
                            resultSet.getInt(1),
                            resultSet.getString(2),
                            resultSet.getDouble(3),
                            resultSet.getDouble(4)
                    );
                    orderDetails.add(order);
                }

                if (Objects.equals(orderDetails.size(), 0)){
                    response.add("message", "order detail not exist");
                    response.add("code", 400);
                    resp.setStatus(400);
                    writer.print(response.build());
                    writer.close();
                }else {

                    System.out.println(orderDetails.toString());

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
}
