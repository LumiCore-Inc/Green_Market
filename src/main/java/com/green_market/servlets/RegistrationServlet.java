package com.green_market.servlets;

import org.apache.commons.dbcp2.BasicDataSource;
import org.json.simple.JSONObject;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

import static com.green_market.util.EmailSender.sendEmail;
import static com.green_market.util.JsonPasser.jsonPasser;

@WebServlet(name = "registrationServlet", value = "/register")
public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");

        JSONObject json = jsonPasser(req);

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("select * from users where username=?");
            pstm.setObject(1 , json.get("username").toString());
            ResultSet rst = pstm.executeQuery();

            while (rst.next()) {
                Integer id = rst.getInt(1);
                if (!Objects.equals(id, null)){
                    response.add("message", "username already exist");
                    response.add("code", 404);

                    writer.print(response.build());
                    writer.close();
                    connection.close();
                    return;
                }
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        String username = json.get("username").toString();
        String firstName = json.get("firstName").toString();
        String lastName = json.get("lastName").toString();
        String tp = json.get("tp").toString();
        String address = json.get("address").toString();
        String password = json.get("password").toString();
        String email = json.get("email").toString();

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("insert into users values(?,?,?,?,?,?,?,?)");
            pstm.setObject(1, 0);
            pstm.setObject(2, username);
            pstm.setObject(3, firstName);
            pstm.setObject(4, lastName);
            pstm.setObject(5, tp);
            pstm.setObject(6, address);
            pstm.setObject(7, password);
            pstm.setObject(8, email);
            int i = pstm.executeUpdate();


            if (i > 0) {
                response.add("message", "success");
                response.add("code", 201);

                sendEmail(email, "Welcome TO Green Market","Your Account Created Success");
                writer.print(response.build());
            }
            connection.close();
            writer.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}