package com.green_market.servlets;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import org.apache.commons.dbcp2.BasicDataSource;
import org.json.simple.JSONObject;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Objects;

import static com.green_market.config.Security.isValidJWT;
import static com.green_market.util.JsonPasser.jsonPasser;

@WebServlet(name = "orderServlet", value = "/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Jws<Claims> claims = isValidJWT(req, resp);
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");
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


//            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
//            Connection connection = null;
//            try {
//                connection = ds.getConnection();
//
//                PreparedStatement pstm = connection.prepareStatement("delete from Customer  where id=?", Statement.RETURN_GENERATED_KEYS);
//                pstm.setObject(1, id);
//                int i = pstm.executeUpdate();
//            } catch (SQLException e) {
//                throw new RuntimeException(e);
//            }


            Double total = (Double) json.get("total");
            ArrayList details = (ArrayList) json.get("details");


            System.out.println(total);
            System.out.println(details);


        }else {
            response.add("message", "Unauthorized Request");
            response.add("code", 403);
            resp.setStatus(403);
            writer.print(response.build());
            writer.close();
        }

    }
}
