package com.green_market.servlets;

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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

import static com.green_market.config.Security.createJWT;
import static com.green_market.util.AESEncryption.decrypt;
import static com.green_market.util.EmailSender.sendEmail;
import static com.green_market.util.JsonPasser.jsonPasser;

@WebServlet(name = "userServlet", value = "/user")
public class UserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if (action.equals("login")){
            userLogin(req, resp);
        }else if (action.equals("register")){
            userRegister(req, resp);
        }
    }

    private void userRegister(HttpServletRequest req, HttpServletResponse resp)throws IOException{
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

                sendEmail(email, "Welcome To Green Market","Your Account Created Success");
                writer.print(response.build());
            }
            connection.close();
            writer.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    private void userLogin(HttpServletRequest req, HttpServletResponse resp)throws IOException {
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");

        JSONObject json = jsonPasser(req);

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("select * from users where username=?");
            pstm.setObject(1, json.get("username").toString());
            ResultSet rst = pstm.executeQuery();

            while (rst.next()) {
                Integer id = rst.getInt(1);
                if (!Objects.equals(id, null)){
                    String password = rst.getString(7);
                    try {
                        String decrypt = decrypt(password);
                        if (json.get("password").toString().equals(decrypt)){

                            String jwt = createJWT("USER", rst.getInt(1));

                            JsonObjectBuilder nestedObject = Json.createObjectBuilder();
                            nestedObject.add("jwt", jwt);
                            nestedObject.add("name", rst.getString(3) +" "+rst.getString(4));

                            response.add("data", nestedObject);
                            response.add("message", "success");
                            response.add("code", 200);

                            sendEmail(rst.getString(8), "Login Success","Green Market Login Success");
                        }else {
                            response.add("message", "invalid username or password");
                            response.add("code", 404);
                        }
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }

                    writer.print(response.build());
                    writer.close();
                    connection.close();
                    return;
                }
            }
            response.add("message", "invalid username or password");
            response.add("code", 404);
            writer.print(response.build());
            writer.close();
            connection.close();
        }catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
