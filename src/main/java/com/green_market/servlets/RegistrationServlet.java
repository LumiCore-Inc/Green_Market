package com.green_market.servlets;

import org.apache.commons.dbcp2.BasicDataSource;
import org.json.simple.JSONObject;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

//        JSONObject json = jsonPasser(req);

        String userName = req.getParameter("userName");
        String userPassword = req.getParameter("password");
        String email = req.getParameter("email");
        HttpSession session = req.getSession();
        RequestDispatcher dispatcher = null;

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("select * from users where username=?");
            pstm.setObject(1 , userName);
            ResultSet rst = pstm.executeQuery();

            while (rst.next()) {
                Integer id = rst.getInt(1);
                if (!Objects.equals(id, null)){
//                    response.add("message", "username already exist");
//                    response.add("code", 404);
//
//                    writer.print(response.build());
//                    writer.close();
                    session.setAttribute("status", "Error");
                    session.setAttribute("message", "Username already exist");
                    dispatcher = req.getRequestDispatcher("login.jsp");
                    dispatcher.forward(req, resp);

                    connection.close();
                    return;
                }
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("insert into users values(?,?,?,?,?,?,?,?)");
            pstm.setObject(1, 0);
            pstm.setObject(2, userName);
            pstm.setObject(3, "First Name");
            pstm.setObject(4, "Last Name");
            pstm.setObject(5, "Mobile");
            pstm.setObject(6, "address");
            pstm.setObject(7, userPassword);
            pstm.setObject(8, email);
            int i = pstm.executeUpdate();


            if (i > 0) {
                response.add("message", "success");
                response.add("code", 201);

                sendEmail(email, "Welcome TO Green Market","Your Account Created Success");
//                writer.print(response.build());
                session.setAttribute("status", "created");
                session.setAttribute("message", "Account created successfully");
                dispatcher = req.getRequestDispatcher("login.jsp");
                dispatcher.forward(req, resp);
            }
            connection.close();
            writer.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}